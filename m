Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4123339D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 15:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgG3N5U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 09:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3N5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:57:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD8FC061574;
        Thu, 30 Jul 2020 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BVQM2Vt73FbBfNFVutAzFvp59bkr4TTzTQ9kL/uqdWc=; b=F2j5z2wEA9fJ8hpxfszJXZ+x8N
        +pSD7Tv6zzCfq0SRbAlDTKbJLK16YlxQDIKKcuruKPYJ5fqWFSS1LxkaJMu5VkDAu/rSdzFo+90K1
        28YmbJI4Gflfera43TO3ClFGEJNk9wH00CheEEJWWFZ7Ar+dksV8jmS2Vr1JllwnyTr6OAs3cdwoi
        fSCzxy8h4nlAt3E6atigytaUFt/txRQuss4+s2KRMv4imZ1NW8bwLqfaQKMEJ63ugVmgaweGlEXjy
        YbNU3FgbvJ9d5tMmkKP5I1pE44nh1av0KnnhV/PpB26tumRBfX8ZhmdEGBYftv51iOvxSN1Oq/prE
        O3S2Ziqw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1932-00013u-QS; Thu, 30 Jul 2020 13:56:40 +0000
Date:   Thu, 30 Jul 2020 14:56:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/23] ns: Introduce ns_idr to be able to iterate all
 allocated namespaces in the system
Message-ID: <20200730135640.GE23808@casper.infradead.org>
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611040870.535980.13460189038999722608.stgit@localhost.localdomain>
 <20200730122319.GC23808@casper.infradead.org>
 <485c01e6-a4ee-5076-878e-6303e6d8d5f3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485c01e6-a4ee-5076-878e-6303e6d8d5f3@virtuozzo.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:32:22PM +0300, Kirill Tkhai wrote:
> On 30.07.2020 15:23, Matthew Wilcox wrote:
> > xa_erase_irqsave();
> 
> static inline void *xa_erase_irqsave(struct xarray *xa, unsigned long index)
> {
> 	unsigned long flags;
>         void *entry;
> 
>         xa_lock_irqsave(xa, flags);
>         entry = __xa_erase(xa, index);
>         xa_unlock_irqrestore(xa, flags);
> 
>         return entry;
> }

was there a question here?

> >> +struct ns_common *ns_get_next(unsigned int *id)
> >> +{
> >> +	struct ns_common *ns;
> >> +
> >> +	if (*id < PROC_NS_MIN_INO - 1)
> >> +		*id = PROC_NS_MIN_INO - 1;
> >> +
> >> +	*id += 1;
> >> +	*id -= PROC_NS_MIN_INO;
> >> +
> >> +	rcu_read_lock();
> >> +	do {
> >> +		ns = idr_get_next(&ns_idr, id);
> >> +		if (!ns)
> >> +			break;
> > 
> > xa_find_after();
> > 
> > You'll want a temporary unsigned long to work with ...
> > 
> >> +		if (!refcount_inc_not_zero(&ns->count)) {
> >> +			ns = NULL;
> >> +			*id += 1;
> > 
> > you won't need this increment.
> 
> Why? I don't see a way xarray allows to avoid this.

It's embedded in xa_find_after().
