Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 354352A18BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Oct 2020 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgJaQ3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Oct 2020 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgJaQ2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Oct 2020 12:28:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792BDC0617A6
        for <linux-fsdevel@vger.kernel.org>; Sat, 31 Oct 2020 09:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wd2kP/lRPNbQUQ7UYe1shx1WBoUnLjGTXchbmVExCmA=; b=Cnn0KSYXyQKoeUziSms7k26mae
        Q/QG+Pt+3pyr70440sNSeTvKjnkM0v8tMkcTrzJrku/lJ/WaWAaiME7pe3S40aEFSUSC2EZGKQywl
        UJlkrl8b1x0vATPa138VI/ZY9/uMxW1UjhSn+hJASwcpyfblNbDaja4rT0NsLlp8YgwkhJ6xJ5h9M
        kI9KhPiaeiBBOs6avuMspbHYGcLD0Zgp2aTdWbdE2MFnL9cI+d39OwGkP5BfwLp29MfEztY7Wt5l7
        dbbV6BDHgpKwIvLbCPRpoceKc4oSEEH/t41u9W5lB7Xdbq/6NXefGHqK3fKh1qQ21Q7S2yZ1urxou
        zBjBOr3Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYtjh-0006Uk-I9; Sat, 31 Oct 2020 16:28:13 +0000
Date:   Sat, 31 Oct 2020 16:28:13 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] mm: simplify
 generic_file_buffered_read_no_cached_page
Message-ID: <20201031162813.GS27442@casper.infradead.org>
References: <20201031090004.452516-1-hch@lst.de>
 <20201031090004.452516-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031090004.452516-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 31, 2020 at 09:59:56AM +0100, Christoph Hellwig wrote:
> +static int filemap_new_page(struct kiocb *iocb, struct iov_iter *iter,
> +		struct page **page)

I don't like this calling convention.  It's too easy to get it wrong,
as you demonstrated.  I preferred the way Kent had it with returning
an ERR_PTR.

