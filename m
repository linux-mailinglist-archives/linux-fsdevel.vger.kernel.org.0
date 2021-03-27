Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1019D34B778
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 15:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhC0N5h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 09:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhC0N5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 09:57:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA6AC0613B1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Mar 2021 06:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZnPJEvg720MqsJlu1D8oGiNufauXiPNX/u3K2X67tWw=; b=mcXByG8FDJfjeqSYIAx3laXuS4
        golaKZklplYatYpR85nYqfLrKp0hCqhu9EjIOsqg6Da+FpmWdJifFe5b09KRugbuhtByXQEtzQPXI
        fF4+NFTTyVK2nQMsCPkjFs6NgiUX0XJn0IfNVACTWID0pJw5xZRkkZFtZ6VnMu09kFoXS/xy8kXTF
        CLuLgooznMnM7NgJQxypg4VBgTFZkZp4FBohKhTcBateFn3CPEzCvmJtrfzMzE9slLSf4H55X7xgJ
        qfxsT6DTpPKvL05gUnMuc7jcwnKIllCpbGE3qmEUUJZz8m3fVKAxtLPb9RMjyKU91LPu7R9Kq+NKn
        pDWZwxLA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lQ9Qy-00GR9P-0U; Sat, 27 Mar 2021 13:57:04 +0000
Date:   Sat, 27 Mar 2021 13:56:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Mike Marshall <hubcap@omnibond.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH v2] implement orangefs_readahead
Message-ID: <20210327135659.GH1719932@casper.infradead.org>
References: <20210327035019.GG1719932@casper.infradead.org>
 <CAOg9mSTQ-zNKXQGBK9QEnwJCvwqh=zFLbLJZy-ibGZwLve4o0w@mail.gmail.com>
 <20210201130800.GP308988@casper.infradead.org>
 <CAOg9mSSd5ccoi1keeiRfkV+esekcQLxer9_1iZ-r9bQDjZLfBg@mail.gmail.com>
 <CAOg9mSSEVE3PGs2E9ya5_B6dQkoH6n2wGAEW_wWSEvw0LurWuQ@mail.gmail.com>
 <2884397.1616584210@warthog.procyon.org.uk>
 <CAOg9mSQMDzMfg3C0TUvTWU61zQdjnthXSy01mgY=CpgaDjj=Pw@mail.gmail.com>
 <1507388.1616833898@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507388.1616833898@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 27, 2021 at 08:31:38AM +0000, David Howells wrote:
> However, in Mike's orangefs_readahead_cleanup(), he could replace:
> 
> 	rcu_read_lock();
> 	xas_for_each(&xas, page, last) {
> 		page_endio(page, false, 0);
> 		put_page(page);
> 	}
> 	rcu_read_unlock();
> 
> with:
> 
> 	while ((page = readahead_page(ractl))) {
> 		page_endio(page, false, 0);
> 		put_page(page);
> 	}
> 
> maybe?

I'd rather see that than open-coded use of the XArray.  It's mildly
slower, but given that we're talking about doing I/O, probably not enough
to care about.
