Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D4F44FDE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 05:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhKOE2p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 23:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbhKOE2o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:28:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77BBC061746;
        Sun, 14 Nov 2021 20:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wC0Ari8XMqIk4yILPJHeMCU66VcRujK6kkVC4trH5uA=; b=NliQLEmkl0leDbF8BxNEtSal8u
        M12Nez7mvlR6qnvgzyE48bgkMGSh8l6Nu6t9RCuBkTmtzwb376LN0DomfBs9zLj065Yxd+F6l+FuX
        OyuJ2Pz2w1qi/Etj92vvq7f31jFeVSKZfJYKT5wsMgIMWeRA6DeoB7q6iRzRw6zP7W91jHBkccl2m
        53hXeDzI0am1eqwPzO1lqKp09qQLT2kliyXW4U3r+ly84AesRs0i8Yh7MsaSxktYBSfk+Esspiws8
        KzR05cy39MJStkaTb+Pa7eSndpADGqQNub4ZERaeXLyMSV4qA91ljOr5e38JA6Gbgdkd7Ijsov0h7
        9xDTcuzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmTYp-005QR4-Rz; Mon, 15 Nov 2021 04:25:39 +0000
Date:   Mon, 15 Nov 2021 04:25:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pipe: fix potential use-after-free in pipe_read()
Message-ID: <YZHhQ5uUJ06BOnJh@casper.infradead.org>
References: <20211115035721.1909-1-thunder.leizhen@huawei.com>
 <20211115035721.1909-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115035721.1909-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 15, 2021 at 11:57:20AM +0800, Zhen Lei wrote:
>  			if (!buf->len) {
> +				unsigned int __maybe_unused flags = buf->flags;

Why __maybe_unused?
