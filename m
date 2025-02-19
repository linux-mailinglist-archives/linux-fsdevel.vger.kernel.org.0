Return-Path: <linux-fsdevel+bounces-42059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC55DA3BCAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 12:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E73E3B817A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F31DEFE5;
	Wed, 19 Feb 2025 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MdcdGX+X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64CF1BD9DB;
	Wed, 19 Feb 2025 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964226; cv=none; b=Q7Kh74EAX8r0lyvwcsXgFbap022Nu51hnPvxHj6zw0+7Gwa0g0Khg3Vg+tgTrzejOCEy6DBbgyISdWvnqTLoQlzsM5kTRw+m2TtfV0tC0qfXDuxIeuTeJkb7rsmqKGzXCzq8fgLLZ/xtrt5DxEhLCgX7jgrVIvfNsJXUW1ovxW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964226; c=relaxed/simple;
	bh=2GfmnZLTwDvjfFV4+WSWOSZjT0JHfkcV2BbYmd+PPug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NKHwVSbRGf2wN2f09ZoCz0EqPQWQBjQk5Z3zxPkftqlB+fB4aCvQyfECOT7JT8h5zuziHJrYhgZS9ze0yqEk0vjwmCDj3vnT1D7DKnBbLMkDfCcXkbFtFxXnya082Z6CYXa8+WkiFdk8pUtqzcRDnSlOnkfXTGwdXL1p7gqxGNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MdcdGX+X; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=q/OmHWTq4XerUF1L4M0RNHTg34waSasZ17r0WBzdYBw=; b=MdcdGX+X/my7D8jWVZyqU/WM5/
	K/zNGukDGBR0dHeOkJ6Ikl4QsWb1k8jyCp08RiCjoeB7hzHgM7+kasnUP/A0Hs4IG0CjVtZ9zFIbQ
	rBmW9rvHk+K3FTfdfNIJ7BjdgY+2WHpkcZA1lBpMh/qVaRtvRTRitxN0VKTp9kmZBaaIG3kqEemJZ
	I6qcgAyxnXnPkGl+/l1qby6x+FLwRqvksnz7QTycdRjSmvRUZ1/QecwukNiGuSGFFZl1OZ7zjKM/1
	ntninm1p+BX/zStSZ1SEnYl1kdBi/4f+ZVcVI8hlSNPIZtTRKf9ZjcLUyY3Duox4arKPKiTq+YHeU
	rvhfgicw==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tkiAW-00ELjI-1c; Wed, 19 Feb 2025 12:23:13 +0100
From: Luis Henriques <luis@igalia.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Matt Harvey
 <mharvey@jumptrading.com>,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Valentin Volkl <valentin.volkl@cern.ch>,
  Laura Promberger <laura.promberger@cern.ch>
Subject: Re: [PATCH v6 2/2] fuse: add new function to invalidate cache for
 all inodes
In-Reply-To: <Z7UED8Gh7Uo-Yj6K@dread.disaster.area> (Dave Chinner's message of
	"Wed, 19 Feb 2025 09:05:03 +1100")
References: <20250217133228.24405-1-luis@igalia.com>
	<20250217133228.24405-3-luis@igalia.com>
	<Z7PaimnCjbGMi6EQ@dread.disaster.area>
	<CAJfpegszFjRFnnPbetBJrHiW_yCO1mFOpuzp30CCZUnDZWQxqg@mail.gmail.com>
	<87r03v8t72.fsf@igalia.com>
	<CAJfpegu51xNUKURj5rKSM5-SYZ6pn-+ZCH0d-g6PZ8vBQYsUSQ@mail.gmail.com>
	<87frkb8o94.fsf@igalia.com>
	<CAJfpegsThcFwhKb9XA3WWBXY_m=_0pRF+FZF+vxAxe3RbZ_c3A@mail.gmail.com>
	<87tt8r6s3e.fsf@igalia.com> <Z7UED8Gh7Uo-Yj6K@dread.disaster.area>
Date: Wed, 19 Feb 2025 11:23:06 +0000
Message-ID: <87eczu41r9.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19 2025, Dave Chinner wrote:

> On Tue, Feb 18, 2025 at 06:11:17PM +0000, Luis Henriques wrote:
>> On Tue, Feb 18 2025, Miklos Szeredi wrote:
>>=20
>> > On Tue, 18 Feb 2025 at 12:51, Luis Henriques <luis@igalia.com> wrote:
>> >>
>> >> On Tue, Feb 18 2025, Miklos Szeredi wrote:
>> >>
>> >> > On Tue, 18 Feb 2025 at 11:04, Luis Henriques <luis@igalia.com> wrot=
e:
>> >> >
>> >> >> The problem I'm trying to solve is that, if a filesystem wants to =
ask the
>> >> >> kernel to get rid of all inodes, it has to request the kernel to f=
orget
>> >> >> each one, individually.  The specific filesystem I'm looking at is=
 CVMFS,
>> >> >> which is a read-only filesystem that needs to be able to update th=
e full
>> >> >> set of filesystem objects when a new generation snapshot becomes
>> >> >> available.
>> >> >
>> >> > Yeah, we talked about this use case.  As I remember there was a
>> >> > proposal to set an epoch, marking all objects for "revalidate neede=
d",
>> >> > which I think is a better solution to the CVMFS problem, than just
>> >> > getting rid of unused objects.
>> >>
>> >> OK, so I think I'm missing some context here.  And, obviously, I also=
 miss
>> >> some more knowledge on the filesystem itself.  But, if I understand it
>> >> correctly, the concept of 'inode' in CVMFS is very loose: when a new
>> >> snapshot generation is available (you mentioned 'epoch', which is, I
>> >> guess, the same thing) the inodes are all renewed -- the inode numbers
>> >> aren't kept between generations/epochs.
>> >>
>> >> Do you have any links for such discussions, or any details on how this
>> >> proposal is being implemented?  This would probably be done mostly in
>> >> user-space I guess, but it would still need a way to get rid of the u=
nused
>> >> inodes from old snapshots, right?  (inodes from old snapshots still i=
n use
>> >> would obvious be kept aroud).
>> >
>> > I don't have links.  Adding Valentin Volkl and Laura Promberger to the
>> > Cc list, maybe they can help with clarification.
>> >
>> > As far as I understand it would work by incrementing fc->epoch on
>> > FUSE_INVALIDATE_ALL. When an object is looked up/created the current
>> > epoch is copied to e.g. dentry->d_time.  fuse_dentry_revalidate() then
>> > compares d_time with fc->epoch and forces an invalidate on mismatch.
>>=20
>> OK, so hopefully Valentin or Laura will be able to help providing some
>> more details.  But, from your description, we would still require this
>> FUSE_INVALIDATE_ALL operation to exist in order to increment the epoch.
>> And this new operation could do that *and* also already invalidate those
>> unused objects.
>
> I think you are still looking at this from the wrong direction.
>
> Invalidation is -not the operation- that is being requested. The
> CVMFS fuse server needs to update some global state in the kernel
> side fuse mount (i.e. the snapshot ID/epoch), and the need to evict
> cached inodes from previous IDs is a CVMFS implementation
> optimisation related to changing the global state.
>
>> > Only problem with this is that it seems very CVMFS specific, but I
>> > guess so is your proposal.
>> >
>> > Implementing the LRU purge is more generally useful, but I'm not sure
>> > if that helps CVMFS, since it would only get rid of unused objects.
>>=20
>> The LRU inodes purge can indeed work for me as well, because my patch is
>> also only getting rid of unused objects, right?  Any inode still being
>> referenced will be kept around.
>>=20
>> So, based on your reply, let me try to summarize a possible alternative
>> solution, that I think would be useful for CVMFS but also generic enough
>> for other filesystems:
>>=20
>> - Add a new operation FUSE_INVAL_LRU_INODES, which would get rid of, at
>>   most, 'N' unused inodes.
>>
>> - This operation would have an argument 'N' with the maximum number of
>>   inodes to invalidate.
>>
>> - In addition, it would also increment this new fuse_connection attribute
>>   'epoch', to be used in the dentry revalidation as you suggested above
>
> As per above: invalidation is an implementation optimisation for the
> CVMFS epoch update. Invalidation, OTOH, does not imply that any fuse
> mount/connector global state (e.g. the epoch) needs to change...
>
> ii.e. the operation should be FUSE_UPDATE_EPOCH, not
> FUSE_INVAL_LRU_INODES...
>
>>=20
>> - This 'N' could also be set to a pre-#define'ed value that would mean
>>   *all* (unused) inodes.
>
> Saying "only invalidate N inodes" makes no sense to me - it is
> fundamentally impossible for userspace to get right. Either the
> epoch update should evict all unreferenced inodes immediately, or it
> should leave them all behind to be purged by memory pressure or
> other periodic garbage collection mechanisms.

So, below I've a patch that is totally untested (not even compile-tested).
It's unlikely to be fully correct, but I just wanted to make sure I got
the main idea right.

What I'm trying to do there is to initialize this new 'epoch'
counter, both in the fuse connection and in every new dentry.  Then, in
the ->d_revalidate() it simply invalidate a dentry if the epochs don't
match.  Then, there's the new fuse notify operation to increment the
epoch and shrink dcache (dropped the call to {evict,invalidate}_inodes()
as Miklos suggested elsewhere).

Does this look reasonable?

(I may be missing other places where epoch should be checked or
initialized.)

Cheers,
--=20
Lu=C3=ADs

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5b5f789b37eb..f560d1bc327e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1902,6 +1902,22 @@ static int fuse_notify_resend(struct fuse_conn *fc)
 	return 0;
 }
=20
+static int fuse_notify_update_epoch(struct fuse_conn *fc)
+{
+	struct fuse_mount *fm;
+	struct inode *inode;
+
+	inode =3D fuse_ilookup(fc, FUSE_ROOT_ID, &fm);
+	if (!inode) || !fm)
+		return -ENOENT;
+=09
+	iput(inode);
+	atomic_inc(&fc->epoch);
+	shrink_dcache_sb(fm->sb);
+
+	return 0;
+}
+
 static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 		       unsigned int size, struct fuse_copy_state *cs)
 {
@@ -1930,6 +1946,9 @@ static int fuse_notify(struct fuse_conn *fc, enum fus=
e_notify_code code,
 	case FUSE_NOTIFY_RESEND:
 		return fuse_notify_resend(fc);
=20
+	case FUSE_NOTIFY_UPDATE_EPOCH:
+		return fuse_notify_update_epoch(fc);
+
 	default:
 		fuse_copy_finish(cs);
 		return -EINVAL;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 198862b086ff..d4d58b169c57 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -204,6 +204,12 @@ static int fuse_dentry_revalidate(struct inode *dir, c=
onst struct qstr *name,
 	int ret;
=20
 	inode =3D d_inode_rcu(entry);
+	if (inode) {
+		fm =3D get_fuse_mount(inode);
+		if (entry->d_time < atomic_read(&fm->fc->epoch))
+			goto invalid;
+	}
+
 	if (inode && fuse_is_bad(inode))
 		goto invalid;
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
@@ -446,6 +452,12 @@ static struct dentry *fuse_lookup(struct inode *dir, s=
truct dentry *entry,
 		goto out_err;
=20
 	entry =3D newent ? newent : entry;
+	if (inode) {
+		struct fuse_mount *fm =3D get_fuse_mount(inode);
+		entry->d_time =3D atomic_read(&fm->fc->epoch);
+	} else {
+		entry->d_time =3D 0;
+	}
 	if (outarg_valid)
 		fuse_change_entry_timeout(entry, &outarg);
 	else
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fee96fe7887b..bb6b1ebaa42d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -611,6 +611,8 @@ struct fuse_conn {
 	/** Number of fuse_dev's */
 	atomic_t dev_count;
=20
+	atomic_t epoch;
+
 	struct rcu_head rcu;
=20
 	/** The user id for this mount */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9db2cb8c150..5d2d29fad658 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -959,6 +959,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_m=
ount *fm,
 	init_rwsem(&fc->killsb);
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->dev_count, 1);
+	atomic_set(&fc->epoch, 1);
 	init_waitqueue_head(&fc->blocked_waitq);
 	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5e0eb41d967e..62cc60e61cca 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -666,6 +666,7 @@ enum fuse_notify_code {
 	FUSE_NOTIFY_RETRIEVE =3D 5,
 	FUSE_NOTIFY_DELETE =3D 6,
 	FUSE_NOTIFY_RESEND =3D 7,
+	FUSE_NOTIFY_UPDATE_EPOCH =3D 8,
 	FUSE_NOTIFY_CODE_MAX,
 };
=20

