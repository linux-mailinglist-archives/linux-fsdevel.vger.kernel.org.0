Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492251280DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 17:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLTQqg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 11:46:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54284 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQqg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 11:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wBzPcwiacPh3r6JPPuX4OW3YmJm5b2HBjhLdhW1rrhw=; b=gfWcV0uibA4PFU/4rEbLjxkz5
        MG8MgU55g11y3RIPF3OV3lH6YW6USCsaChSawFavqS03tMJMxbhzQNlUQ4LgBM9czPB2o1NXRqGzJ
        xsH8yvHWtPIOTxC6G6W+Jmdt6A9gU8VEl9ZXqU2Zk7tOSIFqT2E6eZPwtwbKfL99uKVOivoX5YxWC
        uWdNcE7sHIvr6yJ50gf/nC2wpbqxAQtaE2GWRlpCZVVwm5d1HL4yjArHFf0xmMzdldrHMNNn3Qjj1
        OlTvms47JyJWNXCalo/YyzycxUlGS6VJ7DNLoSG6TsfGfZYvdXWJ/lThq4jLxjN3auQzvcE9ac5kf
        dbwLX4f3w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiLQ8-0001ik-7Q; Fri, 20 Dec 2019 16:46:32 +0000
Date:   Fri, 20 Dec 2019 08:46:32 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chris Down <chris@chrisdown.name>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "zhengbin (A)" <zhengbin13@huawei.com>
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20191220164632.GA26902@bombadil.infradead.org>
References: <20191220024936.GA380394@chrisdown.name>
 <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
 <20191220121615.GB388018@chrisdown.name>
 <CAOQ4uxgo_kAttnB4N1+om5gScYSDn3FXAr+_GUiqNy_79iiLXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgo_kAttnB4N1+om5gScYSDn3FXAr+_GUiqNy_79iiLXQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 03:41:11PM +0200, Amir Goldstein wrote:
> Suggestion:
> 1. Extend the kmem_cache API to let the ctor() know if it is
> initializing an object
>     for the first time (new page) or recycling an object.

Uh, what?  The ctor is _only_ called when new pages are allocated.
Part of the contract with the slab user is that objects are returned to
the slab in an initialised state.

> 2. Let shmem_init_inode retain the value of i_ino of recycled shmem_inode_info
>     objects
> 3. i_ino is initialized with get_next_ino() only in case it it zero
> 
> Alternatively to 1., if simpler to implement and acceptable by slab developers:
> 1.b. remove the assertion from cache_grow_begin()/new_slab_objects():
>        WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
>        and pass __GFP_ZERO in shmem_alloc_inode()

WTF would that _mean_?  I want this object to contain zeroes and whatever
the constructor sets it to.  WHich one wins?

