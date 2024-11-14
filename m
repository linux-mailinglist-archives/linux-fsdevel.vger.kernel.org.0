Return-Path: <linux-fsdevel+bounces-34796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E242A9C8D33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1979282A8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547154720;
	Thu, 14 Nov 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYOWq4g+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C1641746;
	Thu, 14 Nov 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595685; cv=none; b=OllP19w5cxc75C3z+rJuL6nLudZp9Avgt1z16OGxEqH07Q1iRibrgjAvorpkf/VjvA20fDwP7ii75WHwp6frfFBbJjkvLJxzUoZVeCnL4HdeHl5k+pv7as42H1qwrRddleNfCuHrszgp63Z0BkAvSF0yr6RWfIiNJ64X9uMgX5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595685; c=relaxed/simple;
	bh=2ih8X+aYRj/xhF4WSA+AhhU0sQmxjNm+hB6WBW3e0Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8SZIhm2zPabfv3LbAwvKgjTcUAkVsqVa5IqfQgOQ1ZMBQovbYzqDBh0pqHFsOqCHTuK4hH//Ss+UN3PmrIu/se6uDV9XlAGMzIQX5nsgQAlOTgoX0QEixFa9xg+w2RFuqnlPLwz/bdAlFiPvjyl2Bumw9CtOYZDoFmNyfaLGSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYOWq4g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526E4C4CECD;
	Thu, 14 Nov 2024 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731595685;
	bh=2ih8X+aYRj/xhF4WSA+AhhU0sQmxjNm+hB6WBW3e0Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HYOWq4g+P1pq0Hgkj50nRy3WO1kLYKccCSKVBCWVrr2fLo4BAoxoiM848SyTVj40j
	 hiZUVwaGwbhJy9tCpd/fMt5T2xI3aAakti/EN1QC++Kia95A+I5xvBR45GBQl69sJr
	 ja9Nd1RLGxpB1Xyauqt/2CDjp0P2pCSRCiyJM/NkI/qbQgIBHdZu+1AmhBTcw7otVi
	 xk2Sz+0LnyzSW1fFG3glG15D0DcwGXtzEzyOP/CJomNmK1N2F2ZtHJvL3V3Ze5ehFD
	 rrcR5l2ScoKYbUvaBzDjisCx8OR0d7NDrvRaGIS2nrdQMuC6Nb1EjcajOrdVVd36jf
	 OlZAvZSs3NuLA==
Date: Thu, 14 Nov 2024 15:48:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and
 sb_source
Message-ID: <20241114-oberteil-villen-419f96aad840@brauner>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner>
 <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
 <20241114-umzog-garage-b1c1bb8b80f2@brauner>
 <3e6454f8a6b9176e9e1f98523be35f8eb6457eba.camel@kernel.org>
 <CAJfpegtZ6hiars5+JHCr6TEj=TgFFpFbk_TVM_b=YNpbLG0=ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtZ6hiars5+JHCr6TEj=TgFFpFbk_TVM_b=YNpbLG0=ig@mail.gmail.com>

On Thu, Nov 14, 2024 at 02:16:05PM +0100, Miklos Szeredi wrote:
> On Thu, 14 Nov 2024 at 13:29, Jeff Layton <jlayton@kernel.org> wrote:
> 
> > Ordinarily, I might agree, but we're now growing a new mount option
> > field that has them separated by NULs. Will we need two extra fields
> > for this? One comma-separated, and one NUL separated?
> >
> > /proc/#/mountinfo and mounts prepend these to the output of
> > ->show_options, so the simple solution would be to just prepend those
> > there instead of adding a new field. FWIW, only SELinux has any extra
> > mount options to show here.
> 
> Compromise: tack them onto the end of the comma separated list, but
> add a new field for the nul separated security options.
> 
> I think this would be logical, since the comma separated list is more
> useful for having a /proc/$$/mountinfo compatible string than for
> actually interpreting what's in there.

Fair. Here's an incremental for the array of security options.

diff --git a/fs/namespace.c b/fs/namespace.c
index 4f39c4aba85d..a9065a9ab971 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5072,13 +5072,30 @@ static int statmount_mnt_opts(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static inline int statmount_opt_unescape(struct seq_file *seq, char *buf_start)
+{
+	char *buf_end, *opt_start, *opt_end;
+	int count = 0;
+
+	buf_end = seq->buf + seq->count;
+	*buf_end = '\0';
+	for (opt_start = buf_start + 1; opt_start < buf_end; opt_start = opt_end + 1) {
+		opt_end = strchrnul(opt_start, ',');
+		*opt_end = '\0';
+		buf_start += string_unescape(opt_start, buf_start, 0, UNESCAPE_OCTAL) + 1;
+		if (WARN_ON_ONCE(++count == INT_MAX))
+			return -EOVERFLOW;
+	}
+	seq->count = buf_start - 1 - seq->buf;
+	return count;
+}
+
 static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
 	struct super_block *sb = mnt->mnt_sb;
 	size_t start = seq->count;
-	char *buf_start, *buf_end, *opt_start, *opt_end;
-	u32 count = 0;
+	char *buf_start;
 	int err;
 
 	if (!sb->s_op->show_options)
@@ -5095,17 +5112,39 @@ static int statmount_opt_array(struct kstatmount *s, struct seq_file *seq)
 	if (seq->count == start)
 		return 0;
 
-	buf_end = seq->buf + seq->count;
-	*buf_end = '\0';
-	for (opt_start = buf_start + 1; opt_start < buf_end; opt_start = opt_end + 1) {
-		opt_end = strchrnul(opt_start, ',');
-		*opt_end = '\0';
-		buf_start += string_unescape(opt_start, buf_start, 0, UNESCAPE_OCTAL) + 1;
-		if (WARN_ON_ONCE(++count == 0))
-			return -EOVERFLOW;
-	}
-	seq->count = buf_start - 1 - seq->buf;
-	s->sm.opt_num = count;
+	err = statmount_opt_unescape(seq, buf_start);
+	if (err < 0)
+		return err;
+
+	s->sm.opt_num = err;
+	return 0;
+}
+
+static int statmount_opt_sec_array(struct kstatmount *s, struct seq_file *seq)
+{
+	struct vfsmount *mnt = s->mnt;
+	struct super_block *sb = mnt->mnt_sb;
+	size_t start = seq->count;
+	char *buf_start;
+	int err;
+
+	buf_start = seq->buf + start;
+
+	err = security_sb_show_options(seq, sb);
+	if (!err)
+		return err;
+
+	if (unlikely(seq_has_overflowed(seq)))
+		return -EAGAIN;
+
+	if (seq->count == start)
+		return 0;
+
+	err = statmount_opt_unescape(seq, buf_start);
+	if (err < 0)
+		return err;
+
+	s->sm.opt_sec_num = err;
 	return 0;
 }
 
@@ -5138,6 +5177,10 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		sm->opt_array = start;
 		ret = statmount_opt_array(s, seq);
 		break;
+	case STATMOUNT_OPT_SEC_ARRAY:
+		sm->opt_sec_array = start;
+		ret = statmount_opt_sec_array(s, seq);
+		break;
 	case STATMOUNT_FS_SUBTYPE:
 		sm->fs_subtype = start;
 		statmount_fs_subtype(s, seq);
@@ -5294,6 +5337,9 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!err && s->mask & STATMOUNT_OPT_ARRAY)
 		err = statmount_string(s, STATMOUNT_OPT_ARRAY);
 
+	if (!err && s->mask & STATMOUNT_OPT_SEC_ARRAY)
+		err = statmount_string(s, STATMOUNT_OPT_SEC_ARRAY);
+
 	if (!err && s->mask & STATMOUNT_FS_SUBTYPE)
 		err = statmount_string(s, STATMOUNT_FS_SUBTYPE);
 
@@ -5323,7 +5369,7 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 #define STATMOUNT_STRING_REQ (STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT | \
 			      STATMOUNT_FS_TYPE | STATMOUNT_MNT_OPTS | \
 			      STATMOUNT_FS_SUBTYPE | STATMOUNT_SB_SOURCE | \
-			      STATMOUNT_OPT_ARRAY)
+			      STATMOUNT_OPT_ARRAY | STATMOUNT_OPT_SEC_ARRAY)
 
 static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
diff --git a/include/uapi/linux/mount.h b/include/uapi/linux/mount.h
index c0fda4604187..569d938a5757 100644
--- a/include/uapi/linux/mount.h
+++ b/include/uapi/linux/mount.h
@@ -177,7 +177,9 @@ struct statmount {
 	__u32 sb_source;	/* [str] Source string of the mount */
 	__u32 opt_num;		/* Number of fs options */
 	__u32 opt_array;	/* [str] Array of nul terminated fs options */
-	__u64 __spare2[47];
+	__u32 opt_sec_num;	/* Number of security options */
+	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
+	__u64 __spare2[45];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -214,6 +216,7 @@ struct mnt_id_req {
 #define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
 #define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
 #define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
+#define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
 
 /*
  * Special @mnt_id values that can be passed to listmount

