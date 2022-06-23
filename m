Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07721558A75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 23:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiFWVDR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWVDN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:03:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C990418363
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 14:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3888461DE3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 21:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E183DC341C0;
        Thu, 23 Jun 2022 21:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656018189;
        bh=mJFP8Bsy/PYjkSbT6mapyD4vef8IJyKuymHOEavf6Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sj5Z3YenQhV9SW/S2gAv/JCdEo4O6kKKRRdm8rLdNPb7pu2mcHJX43k0pebQ8EBjg
         IMafjqguOh6YV+BH5rcUOTlY4quJC21nyHlICUP8gxVWykfY/t+cAsj2pK8TEed6Jg
         f7uESiJtq0YLG7h7eDZeIH03VIL9hmqh0pDcRKSAJALogIa9z0N6zGm2QeaKpsAUL4
         A0zrZ8ja8VQd2u3GpFfu9lThm8ZHk1ce0CxFIoUibaNPMJ+dtrn3TZJm7QBD1bQPf+
         JiTEeT4vfjMTSHOTqWim+RdcF9QblLyPnAvbPwS0xGsUnUXJKUZg2cblzhMR9wchcg
         HjLTrymyh2ZBA==
Date:   Thu, 23 Jun 2022 23:03:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 8/8] attr: port attribute changes to new types
Message-ID: <20220623210307.lyantczhg6dgccho@wittgenstein>
References: <20220621141454.2914719-1-brauner@kernel.org>
 <20220621141454.2914719-9-brauner@kernel.org>
 <YrTRpsZuOnjFUObl@do-x1extreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrTRpsZuOnjFUObl@do-x1extreme>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 23, 2022 at 03:48:38PM -0500, Seth Forshee wrote:
> On Tue, Jun 21, 2022 at 04:14:54PM +0200, Christian Brauner wrote:
> > diff --git a/fs/attr.c b/fs/attr.c
> > index 88e2ca30d42e..22e310dd483f 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -31,15 +31,15 @@
> >   * performed on the raw inode simply passs init_user_ns.
> >   */
> >  static bool chown_ok(struct user_namespace *mnt_userns,
> > -		     const struct inode *inode,
> > -		     kuid_t uid)
> > +		     const struct inode *inode, vfsuid_t ia_vfsuid)
> >  {
> > -	kuid_t kuid = i_uid_into_mnt(mnt_userns, inode);
> > -	if (uid_eq(current_fsuid(), kuid) && uid_eq(uid, inode->i_uid))
> > +	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
> > +	if (kuid_eq_vfsuid(current_fsuid(), vfsuid) &&
> > +	    vfsuid_eq(ia_vfsuid, vfsuid))
> >  		return true;
> >  	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
> >  		return true;
> > -	if (uid_eq(kuid, INVALID_UID) &&
> > +	if (vfsuid_eq(vfsuid, INVALID_VFSUID) &&
> 
> If you use my suggestion that comparison to invalid ids should always be
> false, this check will need to change to !vfsuid_valid(vfsuid). I'd
> argue that this makes the code clearer regardless.
> 
> >  	    ns_capable(inode->i_sb->s_user_ns, CAP_CHOWN))
> >  		return true;
> >  	return false;
> > @@ -58,21 +58,19 @@ static bool chown_ok(struct user_namespace *mnt_userns,
> >   * performed on the raw inode simply passs init_user_ns.
> >   */
> >  static bool chgrp_ok(struct user_namespace *mnt_userns,
> > -		     const struct inode *inode, kgid_t gid)
> > +		     const struct inode *inode, vfsgid_t ia_vfsgid)
> >  {
> > -	kgid_t kgid = i_gid_into_mnt(mnt_userns, inode);
> > -	if (uid_eq(current_fsuid(), i_uid_into_mnt(mnt_userns, inode))) {
> > -		kgid_t mapped_gid;
> > -
> > -		if (gid_eq(gid, inode->i_gid))
> > +	vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
> > +	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_userns, inode);
> > +	if (kuid_eq_vfsuid(current_fsuid(), vfsuid)) {
> > +		if (vfsgid_eq(ia_vfsgid, vfsgid))
> >  			return true;
> > -		mapped_gid = mapped_kgid_fs(mnt_userns, i_user_ns(inode), gid);
> > -		if (in_group_p(mapped_gid))
> > +		if (vfsgid_in_group_p(ia_vfsgid))
> >  			return true;
> >  	}
> >  	if (capable_wrt_inode_uidgid(mnt_userns, inode, CAP_CHOWN))
> >  		return true;
> > -	if (gid_eq(kgid, INVALID_GID) &&
> > +	if (vfsgid_eq(ia_vfsgid, INVALID_VFSGID) &&
> 
> Likewise here.

Agreed.
