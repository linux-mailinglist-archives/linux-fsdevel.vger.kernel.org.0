Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A326176CF16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjHBNph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjHBNpg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A422126A8
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 06:45:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3750A6199F
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 13:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA36C433C8;
        Wed,  2 Aug 2023 13:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690983933;
        bh=7BQyrIhNLZeMEk47Y2SNYbZTj0iSs/HO5S+sU/9nDvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5q6Uc9ur3y5bY7AJPnT7asxzcSfd/m7Oe30+1zAyamlLcBVA275k+APvyuQccuuD
         N268Y9/5Pt+ReqWQ3ig+w2Ml1BSrnezq3Hb2EcfUtSR2QubHD0XSy4eMk+4wPHXlPb
         MXU5ku0iCGOV2tV05TMIWy8VsJeF2Q8nr3Eat4s5v15Zi8gF8Cry8s4o/UX+qoSEZJ
         gWMNuW6PKaOYYJb4nRYfdoCv50QFDrTPiLiP+qfz5Fzdx2ode8Et6Hxp2vR9+Yq6xX
         zZQg9WaU4S+AGAoIKnQ3RYH1qx34rwr8mHHwM4WWb2XbGxMu7FFHm5y/1i6bnQaXB+
         9zc6RGBy7nGCQ==
Date:   Wed, 2 Aug 2023 08:45:32 -0500
From:   Seth Forshee <sforshee@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jenkins <sethjenkins@google.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: verify {g,u}id mount options correctly
Message-ID: <ZMpd/JfOXBGiK8CA@do-x1extreme>
References: <20230801-vfs-fs_context-uidgid-v1-1-daf46a050bbf@kernel.org>
 <ZMk3LfDaPNuLCe7h@do-x1extreme>
 <20230802-preschen-streng-9f2017794d93@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-preschen-streng-9f2017794d93@brauner>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 02:06:26PM +0200, Christian Brauner wrote:
> On Tue, Aug 01, 2023 at 11:47:41AM -0500, Seth Forshee wrote:
> > On Tue, Aug 01, 2023 at 06:17:04PM +0200, Christian Brauner wrote:
> > > A while ago we received the following report:
> > > 
> > > "The other outstanding issue I noticed comes from the fact that
> > > fsconfig syscalls may occur in a different userns than that which
> > > called fsopen. That means that resolving the uid/gid via
> > > current_user_ns() can save a kuid that isn't mapped in the associated
> > > namespace when the filesystem is finally mounted. This means that it
> > > is possible for an unprivileged user to create files owned by any
> > > group in a tmpfs mount (since we can set the SUID bit on the tmpfs
> > > directory), or a tmpfs that is owned by any user, including the root
> > > group/user."
> > > 
> > > The contract for {g,u}id mount options and {g,u}id values in general set
> > > from userspace has always been that they are translated according to the
> > > caller's idmapping. In so far, tmpfs has been doing the correct thing.
> > > But since tmpfs is mountable in unprivileged contexts it is also
> > > necessary to verify that the resulting {k,g}uid is representable in the
> > > namespace of the superblock to avoid such bugs as above.
> > > 
> > > The new mount api's cross-namespace delegation abilities are already
> > > widely used. After having talked to a bunch of userspace this is the
> > > most faithful solution with minimal regression risks. I know of one
> > > users - systemd - that makes use of the new mount api in this way and
> > > they don't set unresolable {g,u}ids. So the regression risk is minimal.
> > > 
> > > Link: https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com
> > > Fixes: f32356261d44 ("vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
> > > Reported-by: Seth Jenkins <sethjenkins@google.com>
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > ---
> > > 
> > > ---
> > >  mm/shmem.c | 28 ++++++++++++++++++++++++----
> > >  1 file changed, 24 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index 2f2e0e618072..1c0b2dafafe5 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -3636,6 +3636,8 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
> > >  	unsigned long long size;
> > >  	char *rest;
> > >  	int opt;
> > > +	kuid_t kuid;
> > > +	kgid_t kgid;
> > >  
> > >  	opt = fs_parse(fc, shmem_fs_parameters, param, &result);
> > >  	if (opt < 0)
> > > @@ -3671,14 +3673,32 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
> > >  		ctx->mode = result.uint_32 & 07777;
> > >  		break;
> > >  	case Opt_uid:
> > > -		ctx->uid = make_kuid(current_user_ns(), result.uint_32);
> > > -		if (!uid_valid(ctx->uid))
> > > +		kuid = make_kuid(current_user_ns(), result.uint_32);
> > > +		if (!uid_valid(kuid))
> > >  			goto bad_value;
> > > +
> > > +		/*
> > > +		 * The requested uid must be representable in the
> > > +		 * filesystem's idmapping.
> > > +		 */
> > > +		if (!kuid_has_mapping(fc->user_ns, kuid))
> > > +			goto bad_value;
> > > +
> > > +		ctx->uid = kuid;
> > 
> > This seems like the most sensible way to handle ids in mount options.
> > Wouldn't some other filesystems (e.g. fuse) benefit from the same sort
> > of handling though? Rather than having filesystems handle these checks
> > themselves, what about adding k{uid,gid}_t members to the
> > fs_parse_result union with fsparam_is_{uid,gid}() helpers which peform
> > these checks?
> 
> Yes, I like that proposal. Let's see if that works.

After a little poking around, this is more complicated than I'd
initially thought. The parameter helpers don't currently get passed an
fs_context, and ceph/rbd seem to be using the parameter parsing like a
library when there legitimately is not an fs_context to be passed. So it
makes sense to take this patch as an immediate fix, and we can take a
look at trying to make it more generic later.


Reviewed-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
