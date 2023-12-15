Return-Path: <linux-fsdevel+bounces-6209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E180815081
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 21:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5C81F244A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02245973;
	Fri, 15 Dec 2023 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oFn2AKnS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405844186D;
	Fri, 15 Dec 2023 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702670438; x=1734206438;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=S8TnbWoZtp/U/6OXfiv1in0g6YJnk4EzhaYURlLIq7s=;
  b=oFn2AKnSLn08/uj9PcD9xfO+S6/0t7M6/jFnbPJsA2PvjTsBuX7qynKF
   OORvd/Cj48C1JBpvnhvvAjTLKZic4U8VuTcqCP+YHW4h5ZQECCKTVzLgh
   E2vFCeDnYvLUjl5tbfQeFdzZdG6hkZ6UujW44DDiVCDrzw7xVx60/JmCc
   NRoFrbW8zsOwEVGGobACuCXV2yDRYYMAu8hVeJin/4tKrRhBisJd+bY2B
   bgg4JrkvmZsKXCkJeVvGhuE+6dF/V3iE7KCvVvZZfaguVQuPVZq1D3T0u
   xi1tJV2338mAhrsRbRdzG9b6pVBQhhdhTwelTixUufIYxQmZUV9MsUjkd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2490402"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2490402"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 12:00:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="1022038200"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1022038200"
Received: from kpowell-mobl.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.17.106])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 12:00:25 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: hu1.chen@intel.com, miklos@szeredi.hu, malini.bhandaru@intel.com,
 tim.c.chen@intel.com, mikko.ylinen@intel.com, lizhen.you@intel.com,
 linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, David Howells
 <dhowells@redhat.com>
Subject: Re: [RFC] HACK: overlayfs: Optimize overlay/restore creds
In-Reply-To: <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
References: <CAOQ4uxg-WvdcuCrQg7zp03ocNZoT-G2bpi=Y6nVxMTodyFAUbg@mail.gmail.com>
 <20231214220222.348101-1-vinicius.gomes@intel.com>
 <CAOQ4uxhJmjeSSM5iQyDadbj5UNjPqvh1QPLpSOVEYFbNbsjDQQ@mail.gmail.com>
Date: Fri, 15 Dec 2023 12:00:24 -0800
Message-ID: <87v88zp76v.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Amir,

Amir Goldstein <amir73il@gmail.com> writes:

> +fsdevel because this may be relevant to any subsystem that
> keeps a long live cred copy (e.g. nfsd, ksmbd, cachefiles).
>
> +linus who wrote
> d7852fbd0f04 access: avoid the RCU grace period for the temporary
> subjective credentials
>
>
> On Fri, Dec 15, 2023 at 12:02=E2=80=AFAM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:
>>
>> Permission checks in overlayfs also check against the credentials
>> associated with the superblock, which are assigned at mount() time, so
>> pretty long lived. So, we can omit the reference counting for this
>> case.
>
> You forgot to mention WHY you are proposing this and to link to the
> original report with the first optimization attempt:
>
> https://lore.kernel.org/linux-unionfs/20231018074553.41333-1-hu1.chen@int=
el.com/
>

I thought that the "in-reply-to" would do that, I should have been more
explicit on the context. Sorry.

>>
>> This (very early) proof of concept does two things:
>>
>> Add a flag "immutable" (TODO: find a better name) to struct cred to
>> indicate that it is long lived, and that refcount can be omitted.
>>
>
> This reminds me of the many discussions about Rust abstractions
> that are going on right now.
> I think an abstraction like this one is called a "borrowed reference".
>

Yeah, very similar to a borrow in rust.

>> Add "guard" helpers, so we can use automatic cleanup to be sure
>> override/restore are always paired. (I didn't like that I have
>> 'ovl_cred' to be a container for the credentials, but couldn't think
>> of other solutions)
>>
>
> I like the guard but see comments below...
>
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> ---
>> Hi Amir,
>>
>> Just to know if I am more or less on right track.
>>
>> This is a different attempt, instead of the local copy idea, I am
>> using the fact that the credentials associated with the mount() will
>> be alive for a long time. I think the result is almost the same. But I
>> could be missing something.
>>
>> TODO:
>>  - Add asserts.
>>  - Replace ovl_override_creds()/revert_Creds() by
>>    ovl_creator_cred()/guard() everywhere.
>>  - Probably more.
>>
>>
>>  fs/overlayfs/inode.c     |  7 ++++---
>>  fs/overlayfs/overlayfs.h | 18 ++++++++++++++++++
>>  fs/overlayfs/params.c    |  4 +++-
>>  fs/overlayfs/super.c     | 10 +++++++---
>>  fs/overlayfs/util.c      | 10 ++++++++++
>>  include/linux/cred.h     | 12 ++++++++++--
>>  6 files changed, 52 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
>> index c63b31a460be..2c016a3bbe2d 100644
>> --- a/fs/overlayfs/inode.c
>> +++ b/fs/overlayfs/inode.c
>> @@ -290,9 +290,9 @@ int ovl_permission(struct mnt_idmap *idmap,
>>                    struct inode *inode, int mask)
>>  {
>>         struct inode *upperinode =3D ovl_inode_upper(inode);
>> +       struct ovl_cred ovl_cred;
>>         struct inode *realinode;
>>         struct path realpath;
>> -       const struct cred *old_cred;
>
> Nit: please don't reorder the variable definitions.
>

Sorry about that. "bad" habits from the networking side :-)

>>         int err;
>>
>>         /* Careful in RCU walk mode */
>> @@ -310,7 +310,9 @@ int ovl_permission(struct mnt_idmap *idmap,
>>         if (err)
>>                 return err;
>>
>> -       old_cred =3D ovl_override_creds(inode->i_sb);
>> +       ovl_cred =3D ovl_creator_cred(inode->i_sb);
>> +       guard(ovl_creds)(&ovl_cred);
>> +
>>         if (!upperinode &&
>>             !special_file(realinode->i_mode) && mask & MAY_WRITE) {
>>                 mask &=3D ~(MAY_WRITE | MAY_APPEND);
>> @@ -318,7 +320,6 @@ int ovl_permission(struct mnt_idmap *idmap,
>>                 mask |=3D MAY_READ;
>>         }
>>         err =3D inode_permission(mnt_idmap(realpath.mnt), realinode, mas=
k);
>> -       revert_creds(old_cred);
>>
>>         return err;
>>  }
>> diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
>> index 05c3dd597fa8..22ea3066376e 100644
>> --- a/fs/overlayfs/overlayfs.h
>> +++ b/fs/overlayfs/overlayfs.h
>> @@ -416,6 +416,24 @@ static inline int ovl_do_getattr(const struct path =
*path, struct kstat *stat,
>>         return vfs_getattr(path, stat, request_mask, flags);
>>  }
>>
>> +struct ovl_cred {
>> +       const struct cred *cred;
>> +};
>> +
>> +static inline struct ovl_cred ovl_creator_cred(struct super_block *sb)
>> +{
>> +       struct ovl_fs *ofs =3D OVL_FS(sb);
>> +
>> +       return (struct ovl_cred) { .cred =3D ofs->creator_cred };
>> +}
>> +
>> +void ovl_override_creds_new(struct ovl_cred *creator_cred);
>> +void ovl_revert_creds_new(struct ovl_cred *creator_cred);
>> +
>> +DEFINE_GUARD(ovl_creds, struct ovl_cred *,
>> +            ovl_override_creds_new(_T),
>> +            ovl_revert_creds_new(_T));
>> +
>
> This pattern is not unique to overlayfs.
> It is probably better to define a common container type struct override_c=
red
> in cred.h/cred.c that other code could also use.
>

Good idea.

>>  /* util.c */
>>  int ovl_get_write_access(struct dentry *dentry);
>>  void ovl_put_write_access(struct dentry *dentry);
>> diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
>> index 3fe2dde1598f..008377b9241a 100644
>> --- a/fs/overlayfs/params.c
>> +++ b/fs/overlayfs/params.c
>> @@ -770,8 +770,10 @@ void ovl_free_fs(struct ovl_fs *ofs)
>>         kfree(ofs->config.lowerdirs);
>>         kfree(ofs->config.upperdir);
>>         kfree(ofs->config.workdir);
>> -       if (ofs->creator_cred)
>> +       if (ofs->creator_cred) {
>> +               cred_set_immutable(ofs->creator_cred, false);
>>                 put_cred(ofs->creator_cred);
>
> Not happy about this API.
>
> Two solutions I can think of:
> 1. (my preference) keep two copies of creator_cred, one refcounted copy
>     and one non-refcounted that is used for override_creds()
> 2. put_cred_ref() which explicitly opts-in to dropping refcount on
>     a borrowed reference, same as you do above but hidden behind
>     a properly documented helper
>

Probably because I already have option (2) more or less understood, but
I think that having a single creator_cred marked as
"non-refcounted/long-lived" is simpler than having two copies, even the
the extra copy only exists for the duration of the override.

But it could be that I still can't imagine what you have in mind about
(1).

>> +       }
>>         kfree(ofs);
>>  }
>>
>> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
>> index a0967bb25003..1ffb4f0f8186 100644
>> --- a/fs/overlayfs/super.c
>> +++ b/fs/overlayfs/super.c
>> @@ -1304,6 +1304,13 @@ int ovl_fill_super(struct super_block *sb, struct=
 fs_context *fc)
>>         if (!cred)
>>                 goto out_err;
>>
>> +       /* Never override disk quota limits or use reserved space */
>> +       cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
>> +       /* The cred that is going to be associated with the super
>> +        * block will not change.
>> +        */
>> +       cred_set_immutable(cred, true);
>> +
>
> Likewise, either:
> 1. Create a non-refcounted copy of creator_cred

Ah! I think now I see what you meant. Not sure I like, I think it's a
bit too error prone, it's hard to enforce that the copies would be kept
in sync in general. (even if in practice the only thing that would need
to be kept in sync is the destruction of both, at least for now).

> or
> 2. Use a documented helper prepare_creds_ref() to hide
>     this implementation detail

This I like more, having the properties documented in the constructor.
And much better than my _set_immutable().

>
>>         err =3D ovl_fs_params_verify(ctx, &ofs->config);
>>         if (err)
>>                 goto out_err;
>> @@ -1438,9 +1445,6 @@ int ovl_fill_super(struct super_block *sb, struct =
fs_context *fc)
>>         else if (!ofs->nofh)
>>                 sb->s_export_op =3D &ovl_export_fid_operations;
>>
>> -       /* Never override disk quota limits or use reserved space */
>> -       cap_lower(cred->cap_effective, CAP_SYS_RESOURCE);
>> -
>>         sb->s_magic =3D OVERLAYFS_SUPER_MAGIC;
>>         sb->s_xattr =3D ovl_xattr_handlers(ofs);
>>         sb->s_fs_info =3D ofs;
>> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
>> index c3f020ca13a8..9ae9a35a6a7a 100644
>> --- a/fs/overlayfs/util.c
>> +++ b/fs/overlayfs/util.c
>> @@ -68,6 +68,16 @@ const struct cred *ovl_override_creds(struct super_bl=
ock *sb)
>>         return override_creds(ofs->creator_cred);
>>  }
>>
>> +void ovl_override_creds_new(struct ovl_cred *creator_cred)
>> +{
>> +       creator_cred->cred =3D override_creds(creator_cred->cred);
>> +}
>> +
>> +void ovl_revert_creds_new(struct ovl_cred *creator_cred)
>> +{
>> +       revert_creds(creator_cred->cred);
>> +}
>
> Would look nicer in this generic form, no?
>
> void override_cred_save(struct override_cred *override)
> {
>        override->cred =3D override_creds(override->cred);
> }
>
> void override_cred_restore(struct override_cred *old)
> {
>        revert_creds(old->cred);
> }
>

Much nicer :-)

> Which reminds me that memalloc_*_{save,restore} are good
> candidates for defining a guard.
>
>> +
>>  /*
>>   * Check if underlying fs supports file handles and try to determine en=
coding
>>   * type, in order to deduce maximum inode number used by fs.
>> diff --git a/include/linux/cred.h b/include/linux/cred.h
>> index af8d353a4b86..06eaedfe48ea 100644
>> --- a/include/linux/cred.h
>> +++ b/include/linux/cred.h
>> @@ -151,6 +151,7 @@ struct cred {
>>                 int non_rcu;                    /* Can we skip RCU delet=
ion? */
>>                 struct rcu_head rcu;            /* RCU deletion hook */
>>         };
>> +       bool    immutable;
>>  } __randomize_layout;
>>
>
> If we choose the design that the immutable/non-refcount property
> is a const property and we need to create a copy of struct cred
> whenever we want to use a non-refcounted copy, then we could
> store this in the union because RCU deletion is also not needed for
> non-refcounted copy:
>
>         struct {
>             int non_refcount:1;              /* A borrowed reference? */
>             int non_rcu:1;                      /* Can we skip RCU deleti=
on? */
>         };
>         struct rcu_head rcu;            /* RCU deletion hook */
>     };
>

Ah! Now it makes sense. Thank you.

If you, or any others of course, don't have objections against option
(2), I think I am going to play with it a bit and see how it goes.


Cheers,
--=20
Vinicius

