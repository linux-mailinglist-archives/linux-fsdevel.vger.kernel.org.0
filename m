Return-Path: <linux-fsdevel+bounces-6756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4E81BC0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 17:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9933282C9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 16:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81E658219;
	Thu, 21 Dec 2023 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Ctx8RQ+V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EEA627ED;
	Thu, 21 Dec 2023 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1703176209;
	bh=K+LpPvn02gq1HXF+qJ9yzaZtW0DmaX6MxFdw18QqWF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ctx8RQ+VqKoswdOmkHc+J2fw5/TemRyuqQ4ApuLwo6UvqT70kUwZ+TK6Y/XNMFKPQ
	 3KugK+PxvF3JtogiNZbatXOLxwDAhFPq9M/ntncywoETLThiAzQCSoN0CBmJqQA39C
	 Qk5yrxTQbfcLxY7Y8zvwf1LaUcbCsz4TCxw4rMxGOSbxLCUwEztApSJZu3gHVqLM74
	 DoXxaV9NZcOwXExIu70ZGreL0l2p26TmwrF9Wqb8UvWKLG+Wv3uB3u8XbMZG84XEIM
	 GijsJdQjUaLavungK7O4bvAANoV7z8V/KIRE/N6UDTNK4lubRPordgNUXfkaElLi5x
	 TXk+f+3SYL9iA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 12A1A13D4E;
	Thu, 21 Dec 2023 17:30:09 +0100 (CET)
Date: Thu, 21 Dec 2023 17:30:08 +0100
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] splice: copy_splice_read: do the I/O with
 IOCB_NOWAIT
Message-ID: <f4xypeqoi3ubyaixn6iku6n4lqxtej4sryoy67ckqjazat6q6j@tarta.nabijaczleweli.xyz>
References: <cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <d87ac02081f2d698dde10da7da51336afc59b480.1703126594.git.nabijaczleweli@nabijaczleweli.xyz>
 <ZYP24DCMYiwc6V/4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f3tsp5pzw5hazicq"
Content-Disposition: inline
In-Reply-To: <ZYP24DCMYiwc6V/4@infradead.org>
User-Agent: NeoMutt/20231103-116-3b855e-dirty


--f3tsp5pzw5hazicq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 12:27:12AM -0800, Christoph Hellwig wrote:
> On Thu, Dec 21, 2023 at 04:08:45AM +0100, Ahelenia Ziemia=C5=84ska wrote:
> > Otherwise we risk sleeping with the pipe locked for indeterminate
> You can't just assume that any ->read_iter support IOCB_NOWAIT.
Let's see.

zero_fops	drivers/char/mem.c:     .splice_read    =3D copy_splice_read,
full_fops	drivers/char/mem.c:     .splice_read    =3D copy_splice_read,

random_fops	drivers/char/random.c:  .splice_read =3D copy_splice_read,
random_read_iter checks
urandom_fops	drivers/char/random.c:  .splice_read =3D copy_splice_read,
urandom_read_iter returns instantly

if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
fs/splice.c:            return copy_splice_read(in, ppos, pipe, len, flags);
FMODE_CAN_ODIRECT is set by filesystems and blockdevs, so trusted

fs/9p/vfs_file.c:               return copy_splice_read(in, ppos, pipe, len=
, flags);
fs/ceph/file.c:         return copy_splice_read(in, ppos, pipe, len, flags);
fs/ceph/file.c:         return copy_splice_read(in, ppos, pipe, len, flags);
fs/gfs2/file.c: .splice_read    =3D copy_splice_read,
fs/gfs2/file.c: .splice_read    =3D copy_splice_read,
fs/kernfs/file.c:       .splice_read    =3D copy_splice_read,
fs/smb/client/cifsfs.c: .splice_read =3D copy_splice_read,
fs/smb/client/cifsfs.c: .splice_read =3D copy_splice_read,
fs/proc/inode.c:        .splice_read    =3D copy_splice_read,
fs/proc/inode.c:        .splice_read    =3D copy_splice_read,
fs/proc/proc_sysctl.c:  .splice_read    =3D copy_splice_read,
fs/proc_namespace.c:    .splice_read    =3D copy_splice_read,
fs/proc_namespace.c:    .splice_read    =3D copy_splice_read,
fs/proc_namespace.c:    .splice_read    =3D copy_splice_read,
filesystems =3D> trusted

tracing_fops
kernel/trace/trace.c:   .splice_read    =3D copy_splice_read,
used in /sys/kernel/debug/tracing/per_cpu/cpu*/trace
    and /sys/kernel/debug/tracing/trace
which are seq_read_iter and even if they did block,
it's in tracefs so same logic as tracing_buffers_splice_read applies.

net/socket.c:           return copy_splice_read(file, ppos, pipe, len, flag=
s);
this is the default implementation for protocols without explicit
splice_reads, and sock_read_iter translates IOCB_NOWAIT into
MSG_DONTAIT.


So I think I can, because the ~three implementations that we want
to constrain do support it. If anything, this hints to me that to
yield a more consistent API that doesn't arbitrarily distinguish
between O_DIRECT files with and without IOCB_NOWAIT support, something
to the effect of the following diff may be used.

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 11cd8d23f6f2..dc42837ee0af 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -392,7 +392,7 @@ static ssize_t v9fs_file_splice_read(struct file *in, l=
off_t *ppos,
 		 fid->fid, len, *ppos);
=20
 	if (fid->mode & P9L_DIRECT)
-		return copy_splice_read(in, ppos, pipe, len, flags);
+		return copy_splice_read_sleepok(in, ppos, pipe, len, flags);
 	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
=20
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3b5aae29e944..9a4679013135 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2209,7 +2209,7 @@ static ssize_t ceph_splice_read(struct file *in, loff=
_t *ppos,
=20
 	if (ceph_has_inline_data(ci) ||
 	    (fi->flags & CEPH_F_SYNC))
-		return copy_splice_read(in, ppos, pipe, len, flags);
+		return copy_splice_read_sleepok(in, ppos, pipe, len, flags);
=20
 	ceph_start_io_read(inode);
=20
@@ -2228,7 +2228,7 @@ static ssize_t ceph_splice_read(struct file *in, loff=
_t *ppos,
=20
 		ceph_put_cap_refs(ci, got);
 		ceph_end_io_read(inode);
-		return copy_splice_read(in, ppos, pipe, len, flags);
+		return copy_splice_read_sleepok(in, ppos, pipe, len, flags);
 	}
=20
 	dout("splice_read %p %llx.%llx %llu~%zu got cap refs on %s\n",
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 4b66efc1a82a..5b0cbb6b95c4 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1581,7 +1581,7 @@ const struct file_operations gfs2_file_fops =3D {
 	.fsync		=3D gfs2_fsync,
 	.lock		=3D gfs2_lock,
 	.flock		=3D gfs2_flock,
-	.splice_read	=3D copy_splice_read,
+	.splice_read	=3D copy_splice_read_sleepok,
 	.splice_write	=3D gfs2_file_splice_write,
 	.setlease	=3D simple_nosetlease,
 	.fallocate	=3D gfs2_fallocate,
@@ -1612,7 +1612,7 @@ const struct file_operations gfs2_file_fops_nolock =
=3D {
 	.open		=3D gfs2_open,
 	.release	=3D gfs2_release,
 	.fsync		=3D gfs2_fsync,
-	.splice_read	=3D copy_splice_read,
+	.splice_read	=3D copy_splice_read_sleepok,
 	.splice_write	=3D gfs2_file_splice_write,
 	.setlease	=3D generic_setlease,
 	.fallocate	=3D gfs2_fallocate,
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index f0cb729e9a97..f0b6e85b2c5b 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -989,7 +989,7 @@ const struct file_operations kernfs_file_fops =3D {
 	.release	=3D kernfs_fop_release,
 	.poll		=3D kernfs_fop_poll,
 	.fsync		=3D noop_fsync,
-	.splice_read	=3D copy_splice_read,
+	.splice_read	=3D copy_splice_read_sleepok,
 	.splice_write	=3D iter_file_splice_write,
 };
=20
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index b33e490e3fd9..7ec2f4653299 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -588,7 +588,7 @@ static const struct file_operations proc_iter_file_ops =
=3D {
 	.llseek		=3D proc_reg_llseek,
 	.read_iter	=3D proc_reg_read_iter,
 	.write		=3D proc_reg_write,
-	.splice_read	=3D copy_splice_read,
+	.splice_read	=3D copy_splice_read_sleepok,
 	.poll		=3D proc_reg_poll,
 	.unlocked_ioctl	=3D proc_reg_unlocked_ioctl,
 	.mmap		=3D proc_reg_mmap,
@@ -614,7 +614,7 @@ static const struct file_operations proc_reg_file_ops_c=
ompat =3D {
 static const struct file_operations proc_iter_file_ops_compat =3D {
 	.llseek		=3D proc_reg_llseek,
 	.read_iter	=3D proc_reg_read_iter,
-	.splice_read	=3D copy_splice_read,
+	.splice_read	=3D copy_splice_read_sleepok,
 	.write		=3D proc_reg_write,
 	.poll		=3D proc_reg_poll,
 	.unlocked_ioctl	=3D proc_reg_unlocked_ioctl,
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8064ea76f80b..11d26fd14e7d 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -864,7 +864,7 @@ static const struct file_operations proc_sys_file_opera=
tions =3D {
 	.poll		=3D proc_sys_poll,
 	.read_iter	=3D proc_sys_read,
 	.write_iter	=3D proc_sys_write,
-	.splice_read	=3D copy_splice_read,
+	.splice_read	=3D copy_splice_read_sleepok,
 	.splice_write	=3D iter_file_splice_write,
 	.llseek		=3D default_llseek,
 };
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 250eb5bf7b52..e9d19a856dd7 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -324,7 +324,7 @@ static int mountstats_open(struct inode *inode, struct =
file *file)
 const struct file_operations proc_mounts_operations =3D {
 	.open		=3D mounts_open,
 	.read_iter	=3D seq_read_iter,
-	.splice_read	=3D copy_splice_read,
+	.splice_read	=3D copy_splice_read_sleepok,
 	.llseek		=3D seq_lseek,
 	.release	=3D mounts_release,
 	.poll		=3D mounts_poll,
@@ -333,7 +333,7 @@ const struct file_operations proc_mounts_operations =3D=
 {
 const struct file_operations proc_mountinfo_operations =3D {
 	.open		=3D mountinfo_open,
 	.read_iter	=3D seq_read_iter,
-	.splice_read	=3D copy_splice_read,
+	.splice_read	=3D copy_splice_read_sleepok,
 	.llseek		=3D seq_lseek,
 	.release	=3D mounts_release,
 	.poll		=3D mounts_poll,
@@ -342,7 +342,7 @@ const struct file_operations proc_mountinfo_operations =
=3D {
 const struct file_operations proc_mountstats_operations =3D {
 	.open		=3D mountstats_open,
 	.read_iter	=3D seq_read_iter,
-	.splice_read	=3D copy_splice_read,
+	.splice_read	=3D copy_splice_read_sleepok,
 	.llseek		=3D seq_lseek,
 	.release	=3D mounts_release,
 };
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2131638f26d0..5f9fb3ce3bcb 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1561,7 +1561,7 @@ const struct file_operations cifs_file_direct_ops =3D=
 {
 	.fsync =3D cifs_fsync,
 	.flush =3D cifs_flush,
 	.mmap =3D cifs_file_mmap,
-	.splice_read =3D copy_splice_read,
+	.splice_read =3D copy_splice_read_sleepok,
 	.splice_write =3D iter_file_splice_write,
 	.unlocked_ioctl  =3D cifs_ioctl,
 	.copy_file_range =3D cifs_copy_file_range,
@@ -1615,7 +1615,7 @@ const struct file_operations cifs_file_direct_nobrl_o=
ps =3D {
 	.fsync =3D cifs_fsync,
 	.flush =3D cifs_flush,
 	.mmap =3D cifs_file_mmap,
-	.splice_read =3D copy_splice_read,
+	.splice_read =3D copy_splice_read_sleepok,
 	.splice_write =3D iter_file_splice_write,
 	.unlocked_ioctl  =3D cifs_ioctl,
 	.copy_file_range =3D cifs_copy_file_range,
diff --git a/fs/splice.c b/fs/splice.c
index 2871c6f9366f..90ebcf236c05 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -298,12 +298,14 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
 }
=20
 /**
- * copy_splice_read -  Copy data from a file and splice the copy into a pi=
pe
+ * __copy_splice_read -  Copy data from a file and splice the copy into a =
pipe
  * @in: The file to read from
  * @ppos: Pointer to the file position to read from
  * @pipe: The pipe to splice into
  * @len: The amount to splice
  * @flags: The SPLICE_F_* flags
+ * @sleepok: Set if splicing from a trusted filesystem,
+ *           don't set if splicing from an IPC mechanism
  *
  * This function allocates a bunch of pages sufficient to hold the request=
ed
  * amount of data (but limited by the remaining pipe capacity), passes it =
to
@@ -317,10 +319,11 @@ void splice_shrink_spd(struct splice_pipe_desc *spd)
  * if the pipe has insufficient space, we reach the end of the data or we =
hit a
  * hole.
  */
-ssize_t copy_splice_read(struct file *in, loff_t *ppos,
-			 struct pipe_inode_info *pipe,
-			 size_t len, unsigned int flags)
+static ssize_t __copy_splice_read(struct file *in, loff_t *ppos,
+				  struct pipe_inode_info *pipe,
+				  size_t len, unsigned int flags, bool sleepok)
 {
+	printk("__copy_splice_read(%d)\n", sleepok);
 	struct iov_iter to;
 	struct bio_vec *bv;
 	struct kiocb kiocb;
@@ -361,7 +364,8 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos =3D *ppos;
-	kiocb.ki_flags |=3D IOCB_NOWAIT;
+	if (!sleepok)
+		kiocb.ki_flags |=3D IOCB_NOWAIT;
 	ret =3D call_read_iter(in, &kiocb, &to);
=20
 	if (ret > 0) {
@@ -399,8 +403,21 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	kfree(bv);
 	return ret;
 }
+
+ssize_t copy_splice_read(struct file *in, loff_t *ppos,
+			 struct pipe_inode_info *pipe,
+			 size_t len, unsigned int flags) {
+	return __copy_splice_read(in, ppos, pipe, len, flags, false);
+}
 EXPORT_SYMBOL(copy_splice_read);
=20
+ssize_t copy_splice_read_sleepok(struct file *in, loff_t *ppos,
+				 struct pipe_inode_info *pipe,
+				 size_t len, unsigned int flags) {
+	return __copy_splice_read(in, ppos, pipe, len, flags, true);
+}
+EXPORT_SYMBOL(copy_splice_read_sleepok);
+
 const struct pipe_buf_operations default_pipe_buf_ops =3D {
 	.release	=3D generic_pipe_buf_release,
 	.try_steal	=3D generic_pipe_buf_try_steal,
@@ -988,7 +1005,7 @@ long vfs_splice_read(struct file *in, loff_t *ppos,
 	 * buffer, copy into it and splice that into the pipe.
 	 */
 	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
-		return copy_splice_read(in, ppos, pipe, len, flags);
+		return copy_splice_read_sleepok(in, ppos, pipe, len, flags);
 	return in->f_op->splice_read(in, ppos, pipe, len, flags);
 }
 EXPORT_SYMBOL_GPL(vfs_splice_read);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..0980bf6ba8fd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2989,6 +2989,9 @@ ssize_t filemap_splice_read(struct file *in, loff_t *=
ppos,
 ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 			 struct pipe_inode_info *pipe,
 			 size_t len, unsigned int flags);
+ssize_t copy_splice_read_sleepok(struct file *in, loff_t *ppos,
+			 struct pipe_inode_info *pipe,
+			 size_t len, unsigned int flags);
 extern ssize_t iter_file_splice_write(struct pipe_inode_info *,
 		struct file *, loff_t *, size_t, unsigned int);
 extern long do_splice_direct(struct file *in, loff_t *ppos, struct file *o=
ut,

--f3tsp5pzw5hazicq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWEaAoACgkQvP0LAY0m
WPEprhAAt5RZ1GyTnlomGJf9hRAHHlEplTOPN+f1cTwaNJfEQsk9gRgbjWwntXhd
hqmxdlaf4rcybsnViBbauApNCanMGhvNngjFqrkr0JDCDKwGYHdVpLnrN49V8mCp
Wi7cm12MEW0tbX7wplUhmPcy7NFI+ksVX60k6/UiOzxrCcYAiMSvdxFpoOxSMNn4
rp4QNZQExkJmEiNX6KEio6ai/dTz++vC5G3oI8FFx4BmMBWhBz0yb43YaMDA93ce
uRfxe2ZsWtZdYI7O/5Djkcelb9aV8Bh1OUUGmqclqv1XYRCY7hhHsrkHEGERkcBo
WX7Mx80NGzGVVHi+OPpki3LSfLjzGT7GMb2Wbzh11eWN4H+yEhBMWLGi8d+X5GBE
Dx04Llgb7wGM3l/kip8IFg9+GKrHjZTfBN/M6TbY+YU5xrZimp3pkyLom5ExMvSn
hGQ2arsoeZswcF9VO1Ac6SlLyf403hwRozNRJLfVdC7SGePjYdhx5k9ez5MqKIuW
yfG8uQI8t8cCgCL766N2+XFBEuYYLXNx+SqgnCCPYbbZTd4EeVNLK5eZtJfK5SLj
c790YtPX4zy8nFjxgsuh+rzZMEYTfdLzDlHUdJa+LOofNw1FJpAE41PFX+BFBXRL
LflRX9nrJ1a45KH4mLGIxMmavEmdcfTnsiqafzHoKtxtoqWSje8=
=Ak49
-----END PGP SIGNATURE-----

--f3tsp5pzw5hazicq--

