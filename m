Return-Path: <linux-fsdevel+bounces-76478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI5ZEo3thGni6gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:20:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B40D2F6C86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01F7F300AC28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 19:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2898D32692A;
	Thu,  5 Feb 2026 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="qQcGC1wQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1B32D8378;
	Thu,  5 Feb 2026 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319237; cv=none; b=iwKEdl3+czgHE1YaWpoOHLKOhlepZY/kadS5Jdsk7y9EY1BGcIIRnL50T1C2fFg81jVoh3XWW4sQ9rjuGIbRsnwFOq2oyDbloJq+w0KmhIRE1zotsL5rv84XOz+3NWYTJXZV8frx1zWMMmJNF4ChWTH1OSqmZgfFLetypq17Ci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319237; c=relaxed/simple;
	bh=CSQmIzuXmP+ugII4sZjdv0nVsHxEzv3tjlYk1CLL2WI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOV6TrV33QM8lm1aim6x9Av4eof7q6iq1JFXR1E7yqIyEBOuk2xvKA8xMhd5zPoGQbIk9of3/B75v0QAoRROGTTvdBOEChXNncey5Bzjjqwm8nj9+8SC6JgVG0pDODtUeBJfQu0ZsBXYHTWbOqfzjS2LZCNK09HZQBDkBWc/B7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=qQcGC1wQ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBbsw3967815;
	Thu, 5 Feb 2026 11:20:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=jhg3NEbYvwMhTmAJDLAi/Gj0Lzrj075RGDwrTvhlLVQ=; b=qQcGC1wQTCXI
	9BCodiKmCxKRN99GDxmBiuEDjmsFyEir+MnMMjp4ttR2ImXmxaji+5wWaz/tEUdX
	ckd81JcU1XOqy6f31wRcA+/3Kd+Ulg3gmWRLRWZWoJq+2jERy/YmQlSupsonDdzx
	qj6fnHc+Uk+3P9BH18RuWLiI45/8aNgdByJVXz01jQym2tBxOqkIAIjveclwpXgP
	QCGdSPOcEjK+UsLvWCGIh6IUBI3C0k4rgjYljpUOo6KCQRcZ4r90n190KN5EpyWE
	BXpZ+6/ItE+5sIlrJQRM6XD9H0G1vR6Wp0I8Yh4/QFNvIcOCsHPXCL9xADZXfxPp
	59pq01LB4w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4xr1jb4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 11:20:27 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 19:20:26 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 12/31] fuse: implement direct IO with iomap
Date: Thu, 5 Feb 2026 11:19:11 -0800
Message-ID: <20260205192011.2087250-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169810612.1424854.16053093294573829123.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810612.1424854.16053093294573829123.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 6xcc5ROY9wCxhNm-aii4DDr3SDmWNNiA
X-Proofpoint-ORIG-GUID: 6xcc5ROY9wCxhNm-aii4DDr3SDmWNNiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0NiBTYWx0ZWRfX41QWRfzTDd4C
 hw3G6tY1cxElhPxIG3AKmH++WyVoO8AGiWc8z8UQPbrCnO6bHmJAsXeNldA9c7mlCnssBKuR7Il
 c9c2Kv0GUsaVfYHTvWETHE/hH0eqMQI4aZyXWlKL/gesG9ZXa/7eI9rPmyoKiRCHkDvJMes7Pqq
 K5hG9frmQABMQUXCWKB9tesYlraSsqpTWJPAiwMm2dwewZPD/XNxGhTfGNuIjYQ3uH8kP47kIJm
 UogUJsrEqoQRl748rnURPfM1bMab0plNlppy5Uj31Rbf6EomZ6rAGn9o32toi3YCBfzC3Y5vM8y
 OImRvVYeLkEDMPFIPSp5ar7rbb98np7hCUSvoHzI+Xza8CD2DPDf5h0GxAXDpF2ddk+hKl+d7kB
 BcY0L2Keu1jAtcaRu2OsOKgYaayhadbrfCCTWaghL+Abzh0shFj2oB22o1KZ7yMQI6Pq1n68fup
 C4CrsNvvoBEja1osAeA==
X-Authority-Analysis: v=2.4 cv=B9u0EetM c=1 sm=1 tr=0 ts=6984ed7b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=aj-ehV3EQ_H54BGr8_0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76478-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B40D2F6C86
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Start implementing the fuse-iomap file I/O paths by adding direct I/O
> support and all the signalling flags that come with it.  Buffered I/O
> is much more complicated, so we leave that to a subsequent patch.
> 

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

commit fab88aeb077db04c5f4fdbaff31a58f4dd9450c8
Author: Darrick J. Wong <djwong@kernel.org>

fuse: implement direct IO with iomap

Start implementing the fuse-iomap file I/O paths by adding direct I/O
support and all the signalling flags that come with it. Buffered I/O is
much more complicated, so we leave that to a subsequent patch.

> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index bec299865d8fe..07be70d314eff 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c

[ ... ]

> @@ -408,7 +416,7 @@ void fuse_sync_release(struct fuse_inode *fi, struct fuse_file *ff,
>  {
>  	WARN_ON(refcount_read(&ff->count) > 1);
>  	fuse_prepare_release(fi, ff, flags, FUSE_RELEASE, true);
> -	fuse_file_put(ff, true);
> +	fuse_file_put(ff, &fi->inode, true);
>  }
>  EXPORT_SYMBOL_GPL(fuse_sync_release);

Can this code dereference a NULL pointer when fi is NULL?

Looking at fuse_create_open in dir.c, when fuse_iget() fails, it calls:

    fuse_sync_release(NULL, ff, flags);

The fuse_prepare_release function explicitly handles fi == NULL with
the comment "Inode is NULL on error path of fuse_create_open()".

However, the new call to fuse_file_put passes &fi->inode, which
evaluates to &NULL->inode. While the inode parameter is unused in the
current commit's implementation of fuse_file_put, the API contract is
broken.

In commit 5f4e9030b26b (fuse: enable iomap), fuse_file_put uses the
inode parameter to call fuse_inode_has_iomap(inode). Since struct inode
is the first member of struct fuse_inode (offsetof == 0), &fi->inode
evaluates to NULL, and fuse_inode_has_iomap(NULL) will dereference NULL.

> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index bc55e87751215..9796e3b994565 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c

[ ... ]

> @@ -545,6 +551,120 @@ static const struct iomap_ops fuse_iomap_ops = {
>  	.iomap_end		= fuse_iomap_end,
>  };
>
> +static inline bool
> +fuse_should_send_iomap_ioend(const struct fuse_mount *fm,
> +			     const struct fuse_iomap_ioend_in *inarg)
> +{
> +	/* Not implemented on fuse server */
> +	if (fm->fc->iomap_conn.no_ioend)
> +		return false;
> +
> +	/* Always send an ioend for errors. */
> +	if (inarg->error)
> +		return true;
> +
> +	/* Send an ioend if we performed an IO involving metadata changes. */
> +	return inarg->written > 0 &&
> +	       (inarg->flags & (FUSE_IOMAP_IOEND_SHARED |
> +				FUSE_IOMAP_IOEND_UNWRITTEN |
> +				FUSE_IOMAP_IOEND_APPEND));
> +}

[ ... ]

> +static int fuse_iomap_ioend(struct inode *inode, loff_t pos, size_t written,
> +			    int error, unsigned ioendflags,
> +			    struct block_device *bdev, sector_t new_addr)
> +{
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_mount *fm = get_fuse_mount(inode);
> +	struct fuse_iomap_ioend_in inarg = {
> +		.flags = ioendflags,
> +		.error = error,
> +		.attr_ino = fi->orig_ino,
> +		.pos = pos,
> +		.written = written,
> +		.dev = fuse_iomap_find_backing_id(fm->fc, bdev),
> +		.new_addr = new_addr,
> +	};
> +	struct fuse_iomap_ioend_out outarg = { };
> +
> +	if (fuse_ioend_is_append(fi, pos, written))
> +		inarg.flags |= FUSE_IOMAP_IOEND_APPEND;
> +
> +	if (fuse_should_send_iomap_ioend(fm, &inarg)) {
> +		FUSE_ARGS(args);
> +		int iomap_error;
> +
> +		args.opcode = FUSE_IOMAP_IOEND;
> +		args.nodeid = get_node_id(inode);
> +		args.in_numargs = 1;
> +		args.in_args[0].size = sizeof(inarg);
> +		args.in_args[0].value = &inarg;
> +		args.out_numargs = 1;
> +		args.out_args[0].size = sizeof(outarg);
> +		args.out_args[0].value = &outarg;
> +		iomap_error = fuse_simple_request(fm, &args);
> +		switch (iomap_error) {
> +		case -ENOSYS:
> +			/*
> +			 * fuse servers can return ENOSYS if ioend processing
> +			 * is never needed for this filesystem.  Don't pass
> +			 * that up to iomap.
> +			 */
> +			fm->fc->iomap_conn.no_ioend = 1;
> +			break;
> +		case 0:
> +			break;
> +		default:
> +			/*
> +			 * If the write IO failed, return the failure code to
> +			 * the caller no matter what happens with the ioend.
> +			 * If the write IO succeeded but the ioend did not,
> +			 * pass the new error up to the caller.
> +			 */
> +			if (!error)
> +				error = iomap_error;
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * Pass whatever error iomap gave us (or any new errors since then)
> +	 * back to iomap.
> +	 */
> +	if (error)
> +		return error;
> +
> +	/*
> +	 * If there weren't any ioend errors, update the incore isize, which
> +	 * confusingly takes the new i_size as "pos".
> +	 */
> +	fi->i_disk_size = outarg.newsize;
> +	fuse_write_update_attr(inode, pos + written, written);
> +	return 0;
> +}

When the fuse server returns -ENOSYS (indicating it doesn't implement
FUSE_IOMAP_IOEND), the code sets fm->fc->iomap_conn.no_ioend = 1 but
does NOT return early. It falls through to the update code where
'outarg' was zero-initialized and never filled by the server.

This corrupts i_disk_size by setting it to 0:

    fi->i_disk_size = outarg.newsize;  // outarg.newsize == 0

On subsequent writes, fuse_should_send_iomap_ioend() returns false due
to no_ioend being set, so the code skips the server call and again uses
the zero-initialized outarg.newsize.

The i_disk_size field is used by fuse_ioend_is_append() to detect
append writes, so corrupting it to 0 will cause incorrect append
detection for all subsequent writes.

Should the code return early when the request is not sent or returns
-ENOSYS, or skip the i_disk_size update in this case?

> +static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
> +				 enum fuse_ilock_type type)
> +{
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> +		switch (type) {
> +		case SHARED:
> +			return inode_trylock_shared(inode) ? 0 : -EAGAIN;
> +		case EXCL:
> +			return inode_trylock(inode) ? 0 : -EAGAIN;
> +		default:
> +			ASSERT(0);
> +			return -EIO;
> +		}
> +
> +		return 0;
> +	}

This isn't a bug, but the 'return 0;' after the switch statement inside
the IOCB_NOWAIT block is unreachable since every switch case returns.


