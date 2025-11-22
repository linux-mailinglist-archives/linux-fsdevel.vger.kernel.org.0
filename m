Return-Path: <linux-fsdevel+bounces-69476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8722C7CE34
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 12:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 607E94E53BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 11:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048392D8387;
	Sat, 22 Nov 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FR39Xt6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898C725B31C;
	Sat, 22 Nov 2025 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763810700; cv=none; b=EwGrUIZOkUAJKbrlcQrIb3Evv3cRao/6DtXMEUFbCJAcHOXb0hoSxXxGRakeRjUfgUtoHeHglrMRZ3GZHPgPXlwAhNd8Mb/K5MqACX684C/GNuvtEhGei1pV98Mf/pD81Or3FdWc/V/MIlN2PZ0TJhBA8Q0htj2m61zrI5gR1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763810700; c=relaxed/simple;
	bh=7WZS+36j07NmjLx5Sw1JZ1mzWNvjQfBuudRR2F53mR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LLfTipnWCzVkdsL4xZhj7QWF2b9WqG9jBJNe0/FuprGgUB4e7wdGnTYBs7WTS2F47VBhbMnS43VrVVWkyivBtvwWGiY5okeBXCg3XpI1FMkq8S5kdYygYf6dffhUFSGC6tTb4tKn5yQscZwnM4HZtEzXfO+AHIxLSL1G2KVoW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FR39Xt6Z; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ldZeji9mkZnbPQ87S43+Tq/tHejGaU4CtEuJWifaIXc=; b=FR39Xt6ZziX5isnxedkmeeofgl
	hr8DDwOdxKG8HbgOSWdhHWZjxqMv2iXRJtTfNyj4WuS9hBPEvAJ1YgCe3I8ICpd7KO4j4Onco99qW
	gS7ZrPRpQ0N3I3hVgy2MgSAG+0gUcTEOD6tQ44PKXb+mMy+xE9lzV8BkpxZgk/a9IWd6RFvEw6Qha
	QpwhPgYUh4rwVzvtT/T2FRdCpkGvV3qlcA0sQN91i5za02YUJUxVrlb5o/u4jwafV7wJXupOvNnWH
	CPNWHweEBQyxb40S+BTjXpvfPJsFFFIlNqq7jKEo6dpAO2JMP37oujHFWF3/jDEEHu+fg4Ern4RmQ
	HlSZTofw==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMljS-0041Ws-41; Sat, 22 Nov 2025 12:24:45 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  "Darrick J. Wong"
 <djwong@kernel.org>,  Bernd Schubert <bschubert@ddn.com>,  Kevin Chen
 <kchen@ddn.com>,  Horst Birthelmer <hbirthelmer@ddn.com>,  linux-fsdevel
 <linux-fsdevel@vger.kernel.org>,  linux-kernel
 <linux-kernel@vger.kernel.org>,  Matt Harvey <mharvey@jumptrading.com>,
  kernel-dev@igalia.com
Subject: Re: [RFC PATCH v1 4/3] fuse: implementation of export_operations
 with FUSE_LOOKUP_HANDLE
In-Reply-To: <CAOQ4uxgzThRacOhcwQcU6DAx7MEUc-8-Z6j9fSKzJp+kuc5=-Q@mail.gmail.com>
	(Amir Goldstein's message of "Fri, 21 Nov 2025 11:53:12 +0100")
References: <CAOQ4uxgzThRacOhcwQcU6DAx7MEUc-8-Z6j9fSKzJp+kuc5=-Q@mail.gmail.com>
Date: Sat, 22 Nov 2025 11:24:40 +0000
Message-ID: <87ikf2z4w7.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21 2025, Amir Goldstein wrote:

> [changing the subject to comment on this part separately]
>
> On Thu, Nov 20, 2025 at 11:55=E2=80=AFAM Luis Henriques <luis@igalia.com>=
 wrote:
>>
>>
>> The export_operations were also modified to use this new file handle ins=
tead
>> if the lookup_handle operation is implemented for the file system.
>>
>> Signed-off-by: Luis Henriques <luis@igalia.com>
> ...
>>
>> +enum {
>> +       HANDLE_TYPE_NODEID      =3D 0,
>> +       HANDLE_TYPE_HANDLE      =3D 1,
>> +};
>> +
>>  struct fuse_inode_handle {
>> -       u64 nodeid;
>> -       u32 generation;
>> +       u32 type;
>
> I don't understand the reason for type as it is always categorically
> determined by fc->lookup_handle in this code.
>
>> +       union {
>
> Perhaps not a union, see below...
>
>> +               struct {
>> +                       u64 nodeid;
>> +                       u32 generation;
>> +               };
>> +               struct fuse_file_handle fh;
>
> Feels like this should be struct fuse_file_handle *fh;

Right, I believe this is leftovers from an earlier version I had where the
fh->handle was an array with the max size FUSE_MAX_HANDLE_SZ.  And some of
the mistakes below in the encode/decode are likely to be related :-/

>> +       };
>>  };
>>
>>  static struct dentry *fuse_get_dentry(struct super_block *sb,
>> @@ -1092,7 +1147,7 @@ static struct dentry *fuse_get_dentry(struct super=
_block *sb,
>>                         goto out_err;
>>                 }
>>
>> -               err =3D fuse_lookup_name(sb, handle->nodeid, &name, outa=
rg,
>> +               err =3D fuse_lookup_name(sb, handle->nodeid, NULL, &name=
, outarg,
>>                                        &inode);
>
> This is a special case of LOOKUP where the parent is unknown.
> Current fuse code does lookup for name "." in "parent" nodeid and servers
> should know how to treat it specially.
>
> I think that for LOOKUP_HANDLE, we can do one of two things.
> Either we always encode the nodeid in NFS exported file handles
> in addition to the server file handle,
> or we skip the ilookup5() optimization and alway send LOOKUP_HANDLE
> to the fuse server with nodeid 0 when the NFS server calls fuse_fh_to_den=
try()
> so the server knows to lookup only by file handle.
>
> The latter option sounds more robust, OTOH the ilookup5() "optimization"
> could be quite useful, so not sure it is worth giving up on.

OK, my guess is that the best option is to keep the ilookup5(), and have
to always encode the nodeid.  But you have a lot of information below for
me to digest, so I'll need to spend some more time figuring things out :-)

>>                 kfree(outarg);
>>                 if (err && err !=3D -ENOENT)
>> @@ -1121,13 +1176,42 @@ static struct dentry *fuse_get_dentry(struct sup=
er_block *sb,
>>         return ERR_PTR(err);
>>  }
>>
>> +static int fuse_encode_lookup_fh(struct inode *inode, u32 *fh, int *max=
_len,
>> +                                struct inode *parent)
>> +{
>> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
>> +       int total_len, len;
>> +
>> +       total_len =3D len =3D sizeof(struct fuse_file_handle);
>> +       if (parent)
>> +               total_len *=3D 2;
>> +
>> +       if (*max_len < total_len)
>> +               return FILEID_INVALID;
>> +
>> +       memcpy(fh, &fi->fh, len);
>> +       if (parent) {
>> +               fi =3D get_fuse_inode(parent);
>> +               memcpy((fh + len), &fi->fh, len);
>> +       }
>> +
>> +       *max_len =3D total_len;
>> +
>> +       /* XXX define new fid_type */
>> +       return parent ? FILEID_INO64_GEN_PARENT : FILEID_INO64_GEN;
>> +}
>> +
>
> This is very odd.
> I don't understand what you were trying to do here.
> As far as I can see, you are not treating fuse_inode_handle as a variable
> length struct that it is in the export operations.

As I mentioned above, I believe this is because the code wasn't updated to
the version where the handle is dynamically allocated instead of a static
array.  Sorry, I should have noticed that.

>>  static int fuse_encode_fh(struct inode *inode, u32 *fh, int *max_len,
>>                            struct inode *parent)
>>  {
>> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
>>         int len =3D parent ? 6 : 3;
>>         u64 nodeid;
>>         u32 generation;
>>
>> +       if (fc->lookup_handle)
>> +               return fuse_encode_lookup_fh(inode, fh, max_len, parent);
>> +
>>         if (*max_len < len) {
>>                 *max_len =3D len;
>>                 return  FILEID_INVALID;
>> @@ -1156,30 +1240,51 @@ static int fuse_encode_fh(struct inode *inode, u=
32 *fh, int *max_len,
>>  static struct dentry *fuse_fh_to_dentry(struct super_block *sb,
>>                 struct fid *fid, int fh_len, int fh_type)
>>  {
>> +       struct fuse_conn *fc =3D get_fuse_conn_super(sb);
>>         struct fuse_inode_handle handle;
>>
>>         if ((fh_type !=3D FILEID_INO64_GEN &&
>>              fh_type !=3D FILEID_INO64_GEN_PARENT) || fh_len < 3)
>>                 return NULL;
>>
>> -       handle.nodeid =3D (u64) fid->raw[0] << 32;
>> -       handle.nodeid |=3D (u64) fid->raw[1];
>> -       handle.generation =3D fid->raw[2];
>> +       if (fc->lookup_handle) {
>> +               if (fh_len < sizeof(struct fuse_file_handle))
>> +                       return NULL;
>> +               handle.type =3D HANDLE_TYPE_HANDLE;
>> +               memcpy(&handle.fh, &fid->raw[0],
>> +                      sizeof(struct fuse_file_handle));
>> +       } else {
>> +               handle.nodeid =3D (u64) fid->raw[0] << 32;
>> +               handle.nodeid |=3D (u64) fid->raw[1];
>> +               handle.generation =3D fid->raw[2];
>> +       }
>>         return fuse_get_dentry(sb, &handle);
>>  }
>>
>>  static struct dentry *fuse_fh_to_parent(struct super_block *sb,
>>                 struct fid *fid, int fh_len, int fh_type)
>>  {
>> -       struct fuse_inode_handle parent;
>> +       struct fuse_conn *fc =3D get_fuse_conn_super(sb);
>> +       struct fuse_inode_handle handle;
>>
>>         if (fh_type !=3D FILEID_INO64_GEN_PARENT || fh_len < 6)
>>                 return NULL;
>>
>> -       parent.nodeid =3D (u64) fid->raw[3] << 32;
>> -       parent.nodeid |=3D (u64) fid->raw[4];
>> -       parent.generation =3D fid->raw[5];
>> -       return fuse_get_dentry(sb, &parent);
>> +       if (fc->lookup_handle) {
>> +               struct fuse_file_handle *fh =3D (struct fuse_file_handle=
 *)fid->raw;
>> +
>> +               if (fh_len < sizeof(struct fuse_file_handle) * 2)
>> +                       return NULL;
>> +               handle.type =3D HANDLE_TYPE_HANDLE;
>> +               memcpy(&handle.fh, &fh[1],
>> +                      sizeof(struct fuse_file_handle));
>> +       } else {
>> +               handle.type =3D HANDLE_TYPE_NODEID;
>> +               handle.nodeid =3D (u64) fid->raw[3] << 32;
>> +               handle.nodeid |=3D (u64) fid->raw[4];
>> +               handle.generation =3D fid->raw[5];
>> +       }
>> +       return fuse_get_dentry(sb, &handle);
>>  }
>>
>
> You may want to look at ovl_encode_fh() as an example of how overlayfs
> encapsulates whatever file handle it got from the real filesystem and pac=
ks it
> as type OVL_FILEID_V1 to hand out to the NFS server.
>
> If we go that route, then the FILEID_FUSE type may include the legacy
> nodeid+gen and the server's variable length file handle following that.
>
> To support "connectable" file handles (see AT_HANDLE_CONNECTABLE
> and fstests test generic/777) would need to implement also handle type
> FILEID_FUSE_WITH_PARENT, which is a concatenation of two
> variable sized FILEID_FUSE handles.
>
> But note that the fact that the server supports LOOKUP_HANDLE does not
> mean that all NFS exported handles MUST be FILEID_FUSE handles.
>
> I think we consider allowing the server to reply to LOOKUP_HANDLE without
> a file handle argument (only nodeid+gen) for specific inodes (e.g. the
> root inode).
>
> If we allow that, then those inodes could still be encoded as FILEID_INO6=
4_GEN
> when exported to NFS and when fuse_fh_to_dentry() is requested to decide
> a file handle of type FILEID_INO64_GEN, it may call LOOKUP_HANDLE
> without nodeid and without a file handle and let the fuse server decide i=
f this
> lookup is acceptable (e.g. with FUSE_ROOT_ID) or stale.
>
> One thing that would be useful with the above is that you will not
> have to implement
> encode/decode of FILEID_FUSE for the first version of LOOKUP_HANDLE.
>
> First of all you could require FUSE_NO_EXPORT_SUPPORT for first version,
> but even without it, a fuse server that supports LOOKUP_HANDLE can fail
> LOOKUP_HANDLE requests without a file handle (or FUSE_ROOT_ID) and
> even that will behave better than NFS export of fuse today (*).
>
> Hope I was not piling too much and that I was not piling garbage.

Well, this is definitely a long list of things to consider :-)
And I *really* appreciate the time you took to write them down in an
email.  I may consider using the FUSE_NO_EXPORT_SUPPORT for now until I'm
happy with LOOKUP_HANDLE.  But I will need some time to go through all of
the comments above and eventually come back with questions.  I believe I
understand your points, and I'll start by looking at ovl_encode_fh() to
see how it handles this.

And once again, thanks a lot for you feedback, Amir!

Cheers,
--=20
Lu=C3=ADs

> Thanks,
> Amir.
>
> (*) In current fuse, fuse_fh_to_dentry() after fuse was unmounted and mou=
nted
> may return ESTALE if nodeid is not already in inode cache and it may also
> decode the wrong object if after fuse restart nodeid (with same gen)
> was assigned
> to a completely different object (yes that happens).


