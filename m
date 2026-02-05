Return-Path: <linux-fsdevel+bounces-76476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DreLtXrhGkj6gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:13:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3609BF6BDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 493523020856
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 19:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE2E313E31;
	Thu,  5 Feb 2026 19:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="cEQCb198"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567B279DB3;
	Thu,  5 Feb 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318798; cv=none; b=eJquhPL1aKyM8AgSp/eRwYC9QebKos3tMq6jdaNHf7B+HvpP/HrbaU84MlHUoT0mS0QTmFDCgJ4vRJQCR/q7aMuVxj0KttQcNK1gXr77NEt8YS9/jcRzMXx8HTaTM0d4P5W7HJ7tY+Vn2iRDpHCvy4yeHJsghBXrSvBN/zftJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318798; c=relaxed/simple;
	bh=f+V5Li0M/D1gDlbcW2k3TcaEKMqqocsq2e81Eo3z1hQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=naTZ2CiDZpDQNeIARB9Y+udKDMNOn8fvLXDPPfxScfUrZzC0VFqsfoPqRRMtsbsLspkCSnsTclsso+JO+HCMpDz8LP8vCMI96WISQ5U0gTIUhcvVC7GotKCSAOWY/g3baqKU5YUHo1Lj0DqOhP76aDqbcYo1XHFVnEs7yNS8cMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=cEQCb198; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBUhj2457653;
	Thu, 5 Feb 2026 11:13:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=utiDYj70ToYvf0cPo51yQw4palf3OnHrXHTMr24zlVE=; b=cEQCb198Inut
	f/Fkp/8fetFIKl9cRMl0jx2Ol9gG8WgI/Msr+k8fRFmWaF/niUMfca6YEdfyzDv4
	QCRX1teomklU7z7S7OKdsx4R+52eSnsu4enoiLUCrj3AkdiFUrBuAH6hOjrDS32H
	0NPDSc7NLiyQ5Ber9U/+BvtN4FIgBWj7Z/VZ/Gs/UWvDuY10DAwQ+khHgwRnjcwE
	f4Y2kFuXB+sd9wm3L75SEK3T3R3k3pdopjU5MsyaJae0vvdejFpKI6amg73YAeLq
	4q1P2occcfNcN5gFcnjs0Y0Uwd7oY9iqelxNdJnfgCmipWsfYBYTlyd526mLzWZn
	jglX0Fg/ZQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4tvqcu1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 11:13:08 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 19:13:07 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 14/31] fuse: implement buffered IO with iomap
Date: Thu, 5 Feb 2026 11:12:09 -0800
Message-ID: <20260205191253.2011999-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169810656.1424854.15239592653019383193.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810656.1424854.15239592653019383193.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: UZ0VvdALyWBQtw0v0SuljlY4pZKAebpL
X-Proofpoint-ORIG-GUID: UZ0VvdALyWBQtw0v0SuljlY4pZKAebpL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0NiBTYWx0ZWRfX58UvhjQpNWDW
 1hbGUJa+jG5i2PGe67Db4Lq3tEUhfFzQUMQSXoEhEhkzIMB7ogPAfMT53SPOMFyE5u4mp0RRdDa
 JTOGdNNU7HoltskurqGMblgQ6Uk9H5P+inU35fBebAp6M5LgoJewJNNL/EXHYyud0HbRU940hwb
 9HFQZ2SCjSeNP9SolOaMA0IkbycftdNw8AbNRk/y0gRm7c3gMA3Vw+mDPN9lr9Dv/0SYPQzXqnm
 ri20SfYBFwLjIu7kITUQcpMiyiWrQizdqJGp1T4zr241eL1BN5QX0cnlDEc7nN6Qto16EtDnLLN
 pkm1SGe7FH47I2lAW5JQuKUpp6/jwZMI/Xw5OJ+uEbzompUcO2ohNAovfU+j2ZAaty3Q+vuSJ+X
 edX80PFrmoMrXZ4KoZ+L6eRpe08rxq3ODpf2cdQsXu8qVxAEt21IvJ34IZhmHmz1BCZ92LA0gx8
 fXscYJehUYp34fM3AKA==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=6984ebc4 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=zlwVdIaWQsgghJQ121oA:9
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76476-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 3609BF6BDF
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Implement pagecache IO with iomap, complete with hooks into truncate and
> fallocate so that the fuse server needn't implement disk block zeroing
> of post-EOF and unaligned punch/zero regions.
> 

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

commit 05d561a4dd38273cb93745e8ddf913f490f81ad5
Author: Darrick J. Wong <djwong@kernel.org>

fuse: implement buffered IO with iomap

Implement pagecache IO with iomap, complete with hooks into truncate and
fallocate so that the fuse server needn't implement disk block zeroing
of post-EOF and unaligned punch/zero regions.

> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c

[ ... ]

> @@ -1056,6 +1144,365 @@ void fuse_iomap_open_truncate(struct inode *inode)
>  	fi->i_disk_size = 0;
>  }
>
> +struct fuse_writepage_ctx {
> +	struct iomap_writepage_ctx ctx;
> +};
> +
> +static void fuse_iomap_end_ioend(struct iomap_ioend *ioend)
> +{
> +	struct inode *inode = ioend->io_inode;
> +	unsigned int ioendflags = FUSE_IOMAP_IOEND_WRITEBACK;
> +	unsigned int nofs_flag;
> +	int error = blk_status_to_errno(ioend->io_bio.bi_status);
> +
> +	ASSERT(fuse_inode_has_iomap(inode));
> +
> +	if (fuse_is_bad(inode))
> +		return;
>                 ^^^^

Does this early return leak the ioend?  When fuse_is_bad(inode) returns
true, this function returns without calling iomap_finish_ioends().

Looking at the iomap code, iomap_finish_ioends() is responsible for:

1. Calling bio_put() to free the bio structure embedded in the ioend
2. Calling iomap_finish_folio_write() to end writeback on the folios

Without this cleanup, we get two problems:

- Memory leak: the bio structure is never freed
- Folios stuck in writeback state forever, which can cause system
  hangs as pages cannot be reclaimed or written again

The cleanup at line 1176 appears mandatory regardless of inode state.

[ ... ]


