Return-Path: <linux-fsdevel+bounces-78460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGu9JoMYoGmzfgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:55:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B101A3CF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B586300789C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3EA39A803;
	Thu, 26 Feb 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YcpLFcqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820C0313285;
	Thu, 26 Feb 2026 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099712; cv=none; b=pmF2rjRD5oYCGtsvQIqc0xd92gDxQJ+bnhO+PD8jvIt/zJQmCcwEMQ61YAfYsoe/YhBKB2FG4LCdZECw1w8EN7LdUlkjjVDTjPSNk7C0I6aKNvxWUuzeBZuQHCGfF9OtvstPYgGnXpIddRVbMSwPojM0pBai9dW/Dj6NEVGQ4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099712; c=relaxed/simple;
	bh=r10BBjhA5WEfO2CXFr1FGtcb3dRjZXD9Mysz42LcL50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zt8yD0xt0xU86AThTwJE87L9Azc1tRdoGN17uRSoBcrbjwlQljFg+5rzAAzRS4sZIaHaPNQZlUHVTSVeQoD32yCsaM72PHGH3bivXIk81TGWWxynQ0Acizb6BgOnW1mxiMQ1SYUFpfnlQQxcE9XyakHBPMORIkR0yzFE1MG7lwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YcpLFcqm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9wibM06nOPCiddkWu0QHKNdY1g/uhTyKvLxC9ayseQU=; b=YcpLFcqmwbMLp44TcjlYXx87+a
	mpP41qHzgzK1sKG30qvBq1UWhmYHJOr1HDiy6QY22kAqFT3RnD0wl7U9CpbqZ/3PwjRDdUmz/ogGg
	9yFFyOipRGYxcE5mDFZZC+4viVcNHCleAjv48kdU+GgyUAHvu4a3HgpZ4xd6a8oQrWGip9bVh7vAB
	Ya7L9yZuTro4LzOMLhcghZmfs7dcK8M00fv5sQtbu9UO1m6G5Nvrh06oKnH9yWTscJ2KGG4cafbVX
	KilPSRN3yHkrWbI3bNoa+m40XmQAp8B5ao9fpuIi5DfytV/a4OWQgLfPtzEEQsjNyq4g1HN+4Yt6a
	xpqD8Gkw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vvY58-005cRR-6p; Thu, 26 Feb 2026 10:54:54 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  Bernd Schubert <bernd@bsbernd.com>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Horst Birthelmer <hbirthelmer@ddn.com>,  Joanne
 Koong <joannelkoong@gmail.com>,  Kevin Chen <kchen@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Matt
 Harvey <mharvey@jumptrading.com>,  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v3 6/8] fuse: implementation of lookup_handle+statx
 compound operation
In-Reply-To: <CAOQ4uxgvgRwfrHX3OMJ-Fvs2FXcp7d7bexrvx0acsy3t3gxv5w@mail.gmail.com>
	(Amir Goldstein's message of "Wed, 25 Feb 2026 19:06:39 +0100")
References: <20260225112439.27276-1-luis@igalia.com>
	<20260225112439.27276-7-luis@igalia.com>
	<CAOQ4uxgvgRwfrHX3OMJ-Fvs2FXcp7d7bexrvx0acsy3t3gxv5w@mail.gmail.com>
Date: Thu, 26 Feb 2026 09:54:53 +0000
Message-ID: <87zf4v7rte.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78460-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szeredi.hu,ddn.com,bsbernd.com,kernel.org,gmail.com,vger.kernel.org,jumptrading.com,igalia.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luis@igalia.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08B101A3CF9
X-Rspamd-Action: no action

Hi Amir,

On Wed, Feb 25 2026, Amir Goldstein wrote:

> On Wed, Feb 25, 2026 at 12:25=E2=80=AFPM Luis Henriques <luis@igalia.com>=
 wrote:
>>
>> The implementation of lookup_handle+statx compound operation extends the
>> lookup operation so that a file handle is be passed into the kernel.  It
>> also needs to include an extra inarg, so that the parent directory file
>> handle can be sent to user-space.  This extra inarg is added as an exten=
sion
>> header to the request.
>>
>> By having a separate statx including in a compound operation allows the
>> attr to be dropped from the lookup_handle request, simplifying the
>> traditional FUSE lookup operation.
>>
>> Signed-off-by: Luis Henriques <luis@igalia.com>
>> ---
>>  fs/fuse/dir.c             | 294 +++++++++++++++++++++++++++++++++++---
>>  fs/fuse/fuse_i.h          |  23 ++-
>>  fs/fuse/inode.c           |  48 +++++--
>>  fs/fuse/readdir.c         |   2 +-
>>  include/uapi/linux/fuse.h |  23 ++-
>>  5 files changed, 355 insertions(+), 35 deletions(-)
>>
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 5c0f1364c392..7fa8c405f1a3 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/security.h>
>>  #include <linux/types.h>
>>  #include <linux/kernel.h>
>> +#include <linux/exportfs.h>
>>
>>  static bool __read_mostly allow_sys_admin_access;
>>  module_param(allow_sys_admin_access, bool, 0644);
>> @@ -372,6 +373,47 @@ static void fuse_lookup_init(struct fuse_args *args=
, u64 nodeid,
>>         args->out_args[0].value =3D outarg;
>>  }
>>
>> +static int do_lookup_handle_statx(struct fuse_mount *fm, u64 parent_nod=
eid,
>> +                                 struct inode *parent_inode,
>> +                                 const struct qstr *name,
>> +                                 struct fuse_entry2_out *lookup_out,
>> +                                 struct fuse_statx_out *statx_out,
>> +                                 struct fuse_file_handle **fh);
>> +static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr =
*attr);
>> +static int do_reval_lookup(struct fuse_mount *fm, u64 parent_nodeid,
>> +                          const struct qstr *name, u64 *nodeid,
>> +                          u64 *generation, u64 *attr_valid,
>> +                          struct fuse_attr *attr, struct fuse_file_hand=
le **fh)
>> +{
>> +       struct fuse_entry_out entry_out;
>> +       struct fuse_entry2_out lookup_out;
>> +       struct fuse_statx_out statx_out;
>> +       FUSE_ARGS(lookup_args);
>> +       int ret =3D 0;
>> +
>> +       if (fm->fc->lookup_handle) {
>> +               ret =3D do_lookup_handle_statx(fm, parent_nodeid, NULL, =
name,
>> +                                            &lookup_out, &statx_out, fh=
);
>> +               if (!ret) {
>> +                       *nodeid =3D lookup_out.nodeid;
>> +                       *generation =3D lookup_out.generation;
>> +                       *attr_valid =3D fuse_time_to_jiffies(lookup_out.=
entry_valid,
>> +                                                          lookup_out.en=
try_valid_nsec);
>> +                       fuse_statx_to_attr(&statx_out.stat, attr);
>> +               }
>> +       } else {
>> +               fuse_lookup_init(&lookup_args, parent_nodeid, name, &ent=
ry_out);
>> +               ret =3D fuse_simple_request(fm, &lookup_args);
>> +               if (!ret) {
>> +                       *nodeid =3D entry_out.nodeid;
>> +                       *generation =3D entry_out.generation;
>> +                       *attr_valid =3D ATTR_TIMEOUT(&entry_out);
>> +                       memcpy(attr, &entry_out.attr, sizeof(*attr));
>> +               }
>> +       }
>> +
>> +       return ret;
>> +}
>>  /*
>>   * Check whether the dentry is still valid
>>   *
>> @@ -399,10 +441,11 @@ static int fuse_dentry_revalidate(struct inode *di=
r, const struct qstr *name,
>>                 goto invalid;
>>         else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()=
) ||
>>                  (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TA=
RGET))) {
>> -               struct fuse_entry_out outarg;
>> -               FUSE_ARGS(args);
>>                 struct fuse_forget_link *forget;
>> +               struct fuse_file_handle *fh =3D NULL;
>>                 u64 attr_version;
>> +               u64 nodeid, generation, attr_valid;
>> +               struct fuse_attr attr;
>>
>>                 /* For negative dentries, always do a fresh lookup */
>>                 if (!inode)
>> @@ -421,35 +464,36 @@ static int fuse_dentry_revalidate(struct inode *di=
r, const struct qstr *name,
>>
>>                 attr_version =3D fuse_get_attr_version(fm->fc);
>>
>> -               fuse_lookup_init(&args, get_node_id(dir), name, &outarg);
>> -               ret =3D fuse_simple_request(fm, &args);
>> +               ret =3D do_reval_lookup(fm, get_node_id(dir), name, &nod=
eid,
>> +                                     &generation, &attr_valid, &attr, &=
fh);
>>                 /* Zero nodeid is same as -ENOENT */
>> -               if (!ret && !outarg.nodeid)
>> +               if (!ret && !nodeid)
>>                         ret =3D -ENOENT;
>>                 if (!ret) {
>>                         fi =3D get_fuse_inode(inode);
>> -                       if (outarg.nodeid !=3D get_node_id(inode) ||
>> -                           (bool) IS_AUTOMOUNT(inode) !=3D (bool) (outa=
rg.attr.flags & FUSE_ATTR_SUBMOUNT)) {
>> -                               fuse_queue_forget(fm->fc, forget,
>> -                                                 outarg.nodeid, 1);
>> +                       if (!fuse_file_handle_is_equal(fm->fc, fi->fh, f=
h) ||
>> +                           nodeid !=3D get_node_id(inode) ||
>> +                           (bool) IS_AUTOMOUNT(inode) !=3D (bool) (attr=
.flags & FUSE_ATTR_SUBMOUNT)) {
>> +                               fuse_queue_forget(fm->fc, forget, nodeid=
, 1);
>> +                               kfree(fh);
>>                                 goto invalid;
>>                         }
>>                         spin_lock(&fi->lock);
>>                         fi->nlookup++;
>>                         spin_unlock(&fi->lock);
>>                 }
>> +               kfree(fh);
>>                 kfree(forget);
>>                 if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR)
>>                         goto out;
>> -               if (ret || fuse_invalid_attr(&outarg.attr) ||
>> -                   fuse_stale_inode(inode, outarg.generation, &outarg.a=
ttr))
>> +               if (ret || fuse_invalid_attr(&attr) ||
>> +                   fuse_stale_inode(inode, generation, &attr))
>>                         goto invalid;
>>
>>                 forget_all_cached_acls(inode);
>> -               fuse_change_attributes(inode, &outarg.attr, NULL,
>> -                                      ATTR_TIMEOUT(&outarg),
>> +               fuse_change_attributes(inode, &attr, NULL, attr_valid,
>>                                        attr_version);
>> -               fuse_change_entry_timeout(entry, &outarg);
>> +               fuse_dentry_settime(entry, attr_valid);
>>         } else if (inode) {
>>                 fi =3D get_fuse_inode(inode);
>>                 if (flags & LOOKUP_RCU) {
>> @@ -546,8 +590,215 @@ bool fuse_invalid_attr(struct fuse_attr *attr)
>>         return !fuse_valid_type(attr->mode) || !fuse_valid_size(attr->si=
ze);
>>  }
>>
>> -int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct q=
str *name,
>> -                    u64 *time, struct inode **inode)
>> +static int create_ext_handle(struct fuse_in_arg *ext, struct fuse_inode=
 *fi)
>> +{
>> +       struct fuse_ext_header *xh;
>> +       struct fuse_file_handle *fh;
>> +       u32 len;
>> +
>> +       len =3D fuse_ext_size(sizeof(*fi->fh) + fi->fh->size);
>> +       xh =3D fuse_extend_arg(ext, len);
>> +       if (!xh)
>> +               return -ENOMEM;
>> +
>> +       xh->size =3D len;
>> +       xh->type =3D FUSE_EXT_HANDLE;
>> +       fh =3D (struct fuse_file_handle *)&xh[1];
>> +       fh->size =3D fi->fh->size;
>> +       memcpy(fh->handle, fi->fh->handle, fh->size);
>> +
>> +       return 0;
>> +}
>> +
>> +static int fuse_lookup_handle_init(struct fuse_args *args, u64 nodeid,
>> +                                  struct fuse_inode *fi,
>> +                                  const struct qstr *name,
>> +                                  struct fuse_entry2_out *outarg)
>> +{
>> +       struct fuse_file_handle *fh;
>
> Considering that fuse has long used uint64_t fh as the convention
> for a file id all over the code, it would be better to pick a different
> convention for fuse file handle, perhaps ffh, or fhandle?

Good point, I'll make sure next revision will follow a different
convention.

>> +       size_t fh_size =3D sizeof(*fh) + MAX_HANDLE_SZ;
>
> I don't remember what we concluded last time, but
> shouldn't the server request max_handle_sz at init?
> This constant is quite arbitrary.

You're right, I should have pointed that out in the cover letter at least.
In the previous version that maximum size was indeed provided by the
server.  But from the discussion here [0] I understood that this
negotiation should be dropped.  Here's what Miklos suggested:

> How about allocating variable length arguments on demand?  That would
> allow getting rid of max_handle_size negotiation.
>
>        args->out_var_alloc  =3D true;
>        args->out_args[1].size =3D MAX_HANDLE_SZ;
>        args->out_args[1].value =3D NULL; /* Will be allocated to the actu=
al size of the handle */

Obviously that's not what the code is currently doing.  The plan is to
eventually set the .value to NULL and do the allocation elsewhere,
according to the actual size returned.

Because I didn't yet thought how/where the allocation could be done
instead, this code is currently simplifying things, and that's why I
picked this MAX_HANDLE_SZ.

Sorry, I should have pointed that out at in a comment as well.

[0] https://lore.kernel.org/all/CAJfpegszP+2XA=3DvADK4r09KU30BQd-r9sNu2Dog8=
8yLG8iV7WQ@mail.gmail.com

>> +       int ret =3D -ENOMEM;
>> +
>> +       fh =3D kzalloc(fh_size, GFP_KERNEL);
>> +       if (!fh)
>> +               return ret;
>> +
>> +       memset(outarg, 0, sizeof(struct fuse_entry2_out));
>> +       args->opcode =3D FUSE_LOOKUP_HANDLE;
>> +       args->nodeid =3D nodeid;
>> +       args->in_numargs =3D 3;
>> +       fuse_set_zero_arg0(args);
>> +       args->in_args[1].size =3D name->len;
>> +       args->in_args[1].value =3D name->name;
>> +       args->in_args[2].size =3D 1;
>> +       args->in_args[2].value =3D "";
>> +       if (fi && fi->fh) {
>
> Same here fi->ffh? or fi->fhandle

Ack!

>> +               args->is_ext =3D true;
>> +               args->ext_idx =3D args->in_numargs++;
>> +               args->in_args[args->ext_idx].size =3D 0;
>> +               ret =3D create_ext_handle(&args->in_args[args->ext_idx],=
 fi);
>> +               if (ret) {
>> +                       kfree(fh);
>> +                       return ret;
>> +               }
>> +       }
>> +       args->out_numargs =3D 2;
>> +       args->out_argvar =3D true;
>> +       args->out_argvar_idx =3D 1;
>> +       args->out_args[0].size =3D sizeof(struct fuse_entry2_out);
>> +       args->out_args[0].value =3D outarg;
>> +
>> +       /* XXX do allocation to the actual size of the handle */
>> +       args->out_args[1].size =3D fh_size;
>> +       args->out_args[1].value =3D fh;
>> +
>> +       return 0;
>> +}
>> +
>> +static void fuse_req_free_argvar_ext(struct fuse_args *args)
>> +{
>> +       if (args->out_argvar)
>> +               kfree(args->out_args[args->out_argvar_idx].value);
>> +       if (args->is_ext)
>> +               kfree(args->in_args[args->ext_idx].value);
>> +}
>> +
>
> Just wanted to point out that statx_out is > 256 bytes on stack
> so allocating 127+4 and the added complexity of ext arg
> seem awkward.
>
> Unless we really want to support huge file handles (we don't?)
> maybe the allocation can be restricted to fi->handle?
> Not sure.

If I understand you correctly, you're suggesting that the out_arg that
will return the handle should be handled on the stack as well and then it
would be copied to an allocated fi->handle.  Sure, that can be done.

On the other hand, as I mentioned above, the outarg allocation is just a
simplification.  So maybe the actual allocation of the handle may be done
elsewhere with the _actual_ fh size, and then simply used in fh->handle.

Please let me know if I got your comment right.
(And thanks for the comments, by the way!)

Cheers,
--=20
Lu=C3=ADs

