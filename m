Return-Path: <linux-fsdevel+bounces-46355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC59A87D6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 12:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC58F3AB4F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 10:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65170265CC5;
	Mon, 14 Apr 2025 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4cqcuge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF16F7483;
	Mon, 14 Apr 2025 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626093; cv=none; b=hVlDOjqYLxL/El1CeZG+p/7yJRexREJ16jXUFWH88uJ+aLkciukzcZe724s5rLRVyiivFfr4aqyUdrmhjTelj3E9cXmHOQrcDbLhf7FUCe9lL80SdlzEz3iZOxTiiu6vB+tqUNyGrEb9amCnnX5HxDNaizu26wesHORbTL6ay1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626093; c=relaxed/simple;
	bh=gDtoiQ4YmKw5TbLSgIYdRdUHgd1ZOp3Djt6LT8KREdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPLuCtaoxjTbu3HOymVhg1qykQafJtyTqAPuODl7WBtzxlxwvThLqsVql+vIu9iREU0oFFkilM4HLJH4KCwWpMh5EMiYJaocx1Ak4sIOHHlnaGXgQcsFLcoWCIzkohXbzlSn/57SEiyuju/krpdTeeNTAESPkFfAHhuimcWxjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4cqcuge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C34AC4CEE2;
	Mon, 14 Apr 2025 10:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744626093;
	bh=gDtoiQ4YmKw5TbLSgIYdRdUHgd1ZOp3Djt6LT8KREdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D4cqcugeP36P1G9DxMdOicsUIS6zOFT/QWuzAG994ryT1y1+xhPaLA24Pm2htPjJl
	 ZRettR0D34pQibbNqCGrfmpkF//yXwe3E+2XQX7MbRpJnyUBE0UW190zMhThWrDUjd
	 t6qeeLdwzeYRBPd26fhXPVO4Ip6x17xsn1cNUZDIJLVmsnVENKQ6LYnnz3zWh/HaOl
	 NZCpQkDCaklXgjBuEjV+Le81wExupsYPGBBRg8aQQadyVERHmV6jLiQ5AkXtIl7FaS
	 5hOBOKaHdmOK/88z0ORngEoITGK4kII4LTMaUHZshpQpyNzJzrTYi3+P82dyeSVCES
	 7lO7HNUs6yB+A==
Date: Mon, 14 Apr 2025 12:21:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: generic_permission() optimization
Message-ID: <20250414-anomalie-abpfiff-9f293dce366b@brauner>
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner>
 <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <CAHk-=wh+pk72FM+a7PoW2s46aU9OQZrY-oApMZSUH0Urg9bsMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh+pk72FM+a7PoW2s46aU9OQZrY-oApMZSUH0Urg9bsMA@mail.gmail.com>

On Sat, Apr 12, 2025 at 01:22:38PM -0700, Linus Torvalds wrote:
> On Sat, 12 Apr 2025 at 09:26, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > I plopped your snippet towards the end of __ext4_iget:
> 
> That's literally where I did the same thing, except I put it right after the
> 
>           brelse(iloc.bh);
> 
> line, rather than before as you did.
> 
> And it made no difference for me, but I didn't try to figure out why.
> Maybe some environment differences? Or maybe I just screwed up my
> testing...
> 
> As mentioned earlier in the thread, I had this bi-modal distribution
> of results, because if I had a load where the *non*-owner of the inode
> looked up the pathnames, then the ACL information would get filled in
> when the VFS layer would do the lookup, and then once the ACLs were
> cached, everything worked beautifully.
> 
> But if the only lookups of a path were done by the owner of the inodes
> (which is typical for at least my normal kernel build tree - nothing
> but my build will look at the files, and they are obviously always
> owned by me) then the ACL caches will never be filled because there
> will never be any real ACL lookups.
> 
> And then rather than doing the nice efficient "no ACLs anywhere, no
> need to even look", it ends up having to actually do the vfsuid
> comparison for the UID equality check.
> 
> Which then does the extra accesses to look up the idmap etc, and is
> visible in the profiles due to that whole dance:
> 
>         /* Are we the owner? If so, ACL's don't matter */
>         vfsuid = i_uid_into_vfsuid(idmap, inode);
>         if (likely(vfsuid_eq_kuid(vfsuid, current_fsuid()))) {
> 
> even when idmap is 'nop_mnt_idmap' and it is reasonably cheap. Just
> because it ends up calling out to different functions and does extra
> D$ accesses to the inode and the suberblock (ie i_user_ns() is this
> 
>         return inode->i_sb->s_user_ns;

I think we can improve this. Right now multiple mounts from different
superblocks can share the same struct mnt_idmap. But I can change the
code so that struct mnt_idmap can only be shared between mounts from the
same superblock. With that we could do:

diff --git a/fs/mnt_idmapping.c b/fs/mnt_idmapping.c
index a37991fdb194..a5ec15c8c754 100644
--- a/fs/mnt_idmapping.c
+++ b/fs/mnt_idmapping.c
@@ -20,6 +20,7 @@
 struct mnt_idmap {
        struct uid_gid_map uid_map;
        struct uid_gid_map gid_map;
+       struct user_namespace *s_user_ns;
        refcount_t count;
 };

And then stuff like:

static inline vfsuid_t i_uid_into_vfsuid(struct mnt_idmap *idmap,
                                         const struct inode *inode)
{
        return make_vfsuid(idmap, i_user_ns(inode), inode->i_uid);
}

just becomes:

static inline vfsuid_t i_uid_into_vfsuid(struct mnt_idmap *idmap,
                                         const struct inode *inode)
{
        return make_vfsuid(idmap, inode->i_uid);
}

which means:

vfsuid_t make_vfsuid(struct mnt_idmap *idmap,
                     kuid_t kuid)
{
        uid_t uid;

        if (idmap == &nop_mnt_idmap)
                return VFSUIDT_INIT(kuid);

<snip>
}

will only have to verify nop_mnt_idmap and we never have to access the
inode->i_sb->s_user_ns at all.

I'll wip up a patch for this.

> 
> so just to *see* that it's nop_mnt_idmap takes effort.
> 
> One improvement might be to cache that 'nop_mnt_idmap' thing in the
> inode as a flag.
> 
> But it would be even better if the filesystem just initializes the
> inode at inode read time to say "I have no ACL's for this inode" and
> none of this code will even trigger.

Yes, let's please do this.

