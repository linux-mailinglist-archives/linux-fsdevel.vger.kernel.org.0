Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABBB81282E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 20:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTTua (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 14:50:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfLTTua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 14:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DIF8dHy1lTS5AXETb4eGjjX2UoAp1O3UhCGS1D3jxec=; b=HDd/bhKRffKrZQjxdEiO1WA2C
        h61xt0rUoBdJBYpD4d3fJmCuWgsjgDs8MOFlg4FQpwTBp7hEa7WHhpwa8L1vyWFpmB8V528lsM6/j
        LHALvTEKckosoj6TkyoNiPpji9lyVoBJlls6wQRFzKz29/bWIpwarRtVfraC8VLpUQsQlStwmt0qq
        tC8W8DksUlNzLy7rUUXVYKIvcepB48Yz2niFVwzsVMjmS1ZCKRbDISelLa1+rSirJmTh2Dj8cCoT4
        OyY3/dvvWV7+pgvs2EP+c7K3KYK6FzgHlhB8RBWXPrADcGeK2XiaEjswhtgywaOsr5qvHxUNCAPvL
        6o9i4SyKg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiOI5-0005N1-P2; Fri, 20 Dec 2019 19:50:25 +0000
Date:   Fri, 20 Dec 2019 11:50:25 -0800
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
Message-ID: <20191220195025.GA9469@bombadil.infradead.org>
References: <20191220024936.GA380394@chrisdown.name>
 <CAOQ4uxjqSWcrA1reiyit9DRt+aq2tXBxLdPE31RrYw1yr=4hjg@mail.gmail.com>
 <20191220121615.GB388018@chrisdown.name>
 <CAOQ4uxgo_kAttnB4N1+om5gScYSDn3FXAr+_GUiqNy_79iiLXQ@mail.gmail.com>
 <20191220164632.GA26902@bombadil.infradead.org>
 <CAOQ4uxhYY9Ep1ncpU+E3bWg4ZpR8pjvLJMA5vj+7frEJ2KTwsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhYY9Ep1ncpU+E3bWg4ZpR8pjvLJMA5vj+7frEJ2KTwsg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 20, 2019 at 07:35:38PM +0200, Amir Goldstein wrote:
> On Fri, Dec 20, 2019 at 6:46 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Dec 20, 2019 at 03:41:11PM +0200, Amir Goldstein wrote:
> > > Suggestion:
> > > 1. Extend the kmem_cache API to let the ctor() know if it is
> > > initializing an object
> > >     for the first time (new page) or recycling an object.
> >
> > Uh, what?  The ctor is _only_ called when new pages are allocated.
> > Part of the contract with the slab user is that objects are returned to
> > the slab in an initialised state.
> 
> Right. I mixed up the ctor() with alloc_inode().
> So is there anything stopping us from reusing an existing non-zero
> value of  i_ino in shmem_get_inode()? for recycling shmem ino
> numbers?

I think that would be an excellent solution to the problem!  At least,
I can't think of any problems with it.
