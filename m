Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A20852DEC1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 22:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244894AbiESUvn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 16:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241839AbiESUvd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 16:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D036842ED5
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652993454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V3PquyJlTVD9Pve8kMEZF0rTovNllsX8KLcCH/4CJKI=;
        b=d1NiiYU/zzfUxVhNqORNRM9bgKBS/jUYpkWZpdj4JLGbUa3o0T2msR+MAzNTjES9vcMijC
        JiWmHqY0ntavUa+qUuV5XKwMmItuCmhffueSK6Fv6GGm57IXnOSKYliN9fH8A+pS6EzNuW
        3BYVO0pOn1u6Yv6I+hP8c6AGSlLmGXw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-cgP66FMePMOgc8pmo3BLOA-1; Thu, 19 May 2022 16:50:53 -0400
X-MC-Unique: cgP66FMePMOgc8pmo3BLOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE3668316FB;
        Thu, 19 May 2022 20:50:52 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.18.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0567400E895;
        Thu, 19 May 2022 20:50:52 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 733B42208FA; Thu, 19 May 2022 16:50:52 -0400 (EDT)
Date:   Thu, 19 May 2022 16:50:52 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dharmendra Singh <dharamhans87@gmail.com>
Subject: Re: [RFC PATCH] vfs: allow ->atomic_open() on positive
Message-ID: <YoatrAK9sWiTZ/1z@redhat.com>
References: <YoZXro9PoYAPUeh5@miu.piliscsaba.redhat.com>
 <Yoaj7jhLpp34K9+v@redhat.com>
 <016ca19d-41b8-a69f-42f1-1805a40fd611@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <016ca19d-41b8-a69f-42f1-1805a40fd611@ddn.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 10:43:54PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/19/22 22:09, Vivek Goyal wrote:
> > On Thu, May 19, 2022 at 04:43:58PM +0200, Miklos Szeredi wrote:
> > > Hi Al,
> > > 
> > > Do you see anything bad with allowing ->atomic_open() to take a positive dentry
> > > and possibly invalidate it after it does the atomic LOOKUP/CREATE+OPEN?
> > > 
> > > It looks wrong not to allow optimizing away the roundtrip associated with
> > > revalidation when we do allow optimizing away the roundtrip for the initial
> > > lookup in the same situation.
> > > 
> > > Thanks,
> > > Miklos
> > > 
> > > 
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 509657fdf4f5..d35b5cbf7f64 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -3267,7 +3267,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > >   		dput(dentry);
> > >   		dentry = NULL;
> > >   	}
> > > -	if (dentry->d_inode) {
> > > +	if (dentry->d_inode && !d_atomic_open(dentry)) {
> > >   		/* Cached positive dentry: will open in f_op->open */
> > >   		return dentry;
> > 
> > Hi Miklos,
> > 
> > I see that lookup_open() calls d_revalidate() first. So basically
> > idea is that fuse ->.d_revalidate will skip LOOKUP needed to make sure
> > dentry is still valid (Only if atomic lookup+open is implemented) and
> > return 1 claiming dentry is valid.
> > 
> > And later in ->atomic_open(), it will either open the file or
> > get an error and invalidate dentry. Hence will save one LOOKUP in
> > success case. Do I understand the intent right?
> 
> Yeah, I think Dharmendra and I had internally already debated over this. In
> order to reduce complexity for the patches we preferred to go without vfs
> modifications.

Fair enough. It is not trivial to be able to see all the paths and make
sure none of these paths is broken.

> 
> I assume the patch is a follow up to this comment
> https://lore.kernel.org/all/20220517100744.26849-1-dharamhans87@gmail.com/T/#m8bd440ddea4c135688c829f34e93371e861ba9fa
> 

Yes looks like. There are too many paths here and being able to wrap
one's head around all the paths is not trivial. Thankfully miklos
has summarized it here.

https://lore.kernel.org/all/20220517100744.26849-1-dharamhans87@gmail.com/T/#m90f64cd8c8fff70e2fba2b551ae01d0d47b3337e

Thanks
Vivek

