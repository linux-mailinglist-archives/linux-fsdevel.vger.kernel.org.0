Return-Path: <linux-fsdevel+bounces-76474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QORlAlbphGkj6gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:02:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067DF6A8E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C1A2301DBBF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE830DD19;
	Thu,  5 Feb 2026 19:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZqyhKJbT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A188632A;
	Thu,  5 Feb 2026 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318151; cv=none; b=cTeJxXXW67DQLRBZqW35YAbz3dLTluR5EAbA8Kh/EOhy8d46PTmrrVWBZnVjxromjD2GWHfsT4YU4I3CXBmdKx6Z53tzGsEEnssnzPe0Tleq9+aAkpC21OORrmph9uwTpBBQCMarHNSFrxw/7nNA2gnvWuacpSyQM0xwt//vh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318151; c=relaxed/simple;
	bh=lJ8aOtwxVs1yIFhJqY82HrMsLzr83SNVhtC95QCE2Pk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQMUqC+GdYixPPcaJ7z0ODXf3bk+WuWdULSyfGBkhv9GaELgGSuq9tExYOWXDwYtBFHE0QM9FEnLiH+PDdtyZu9Y+rjJVGFYyKMrlDmLPxO8A+0VDZ7eA9E7JwMj/c+rkgmr+zqzIes8ePDcJfne09xs+XQ4kck1PJfdrX5pYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZqyhKJbT; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615I5ubh2023026;
	Thu, 5 Feb 2026 11:02:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=raVdcMrbDROdNhwJVbs5up760O5mr33IisVTfxDuaCU=; b=ZqyhKJbTz4Qg
	xhfwoVO8OKGxIarKUwi6CuRZ6xbJa4SuhUW8LFtQDmZgaaQhRr1SFq2rzOQHyBtp
	iODLaM5LzjPmShtD2xu5YgmQgif9ld70QGpQCLXRxXyyX7FUFBIfxqfHBbiSIGL0
	ug+bjI5G+d567MXyMzYKAHELe389ddmgWjPg/OAdOXcXqftgr1iGybTRSObpPmpf
	IdipvUU/QXiqm0nl9LvV6I4V+I/wTl7acvxCIZ8uwtnpLN2PGlc8LoZAlYnXYyoG
	xZh0mr13vNkrj9xSgWF2/YogD6iuI63gerRuLSHJy7qunu6PaLLwN1YGdMInECTS
	ZyBPFdguzw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c506grqj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 11:02:20 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 19:02:19 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 24/31] fuse: implement inline data file IO via iomap
Date: Thu, 5 Feb 2026 11:01:07 -0800
Message-ID: <20260205190206.1890644-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169810874.1424854.5037707950055785011.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810874.1424854.5037707950055785011.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: rrHaHPg-dOu5TsidqHyIyuYji-cELafa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0NCBTYWx0ZWRfX22PmvLrQfHbR
 Cv0REuGQ+/ZWJlnWAkgEgrhJJkJkoxQKWF36IGFj3S7VuGsNFD69wjO1uW5jQ4pwtREZ4M3AHE0
 d3H1yzxzjo/9NqtsYbNjiWriZy5J63GcubYNHsJvVZGRa4UVrvrWGJU7c+qEo4dcGVGqnqDDI2U
 4tPcTI1J3DWUldRx4vZiI8G+kyY6esaIoS8NvENfj06Ma8bOUXXuTJkWP8ftdHLGjf61kN1nzGr
 lON1/486MBWu3BahsPs6gmpZy5LNszwzS7PIAetCL97YDYzLtndp6UuFRnxh6BttYqtWSA7sdBF
 xspM6QgUgIu5Kej9YAozJ96KQarXDexqKYvrT3AjQg14jMiIWpTJATHJy9OYaK/31hr4XD3RHY7
 /lQtlRUH+wAl+dPtSVnxnGXKgnzn+e82CUEzcNDKOJpMxg4TI/QeD7nesxHZlvzqu96jEGh/Oco
 IQdVZCNPtzfz+lP9C6w==
X-Proofpoint-GUID: rrHaHPg-dOu5TsidqHyIyuYji-cELafa
X-Authority-Analysis: v=2.4 cv=EZ7FgfmC c=1 sm=1 tr=0 ts=6984e93c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=pGSTY_N_0UE5DmDzvbIA:9
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76474-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6067DF6A8E
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Implement inline data file IO by issuing FUSE_READ/FUSE_WRITE commands
> in response to an inline data mapping.

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

commit 1263eae0852acb1359182377ad94d570701e2274
Author: Darrick J. Wong <djwong@kernel.org>

fuse: implement inline data file IO via iomap

Implement inline data file IO by issuing FUSE_READ/FUSE_WRITE commands
in response to an inline data mapping.

> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -398,6 +398,150 @@ fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
>  	return ret;
>  }
>
> +/*
> + * Use the FUSE_READ command to read inline file data from the fuse server.
> + * Note that there's no file handle attached, so the fuse server must be able
> + * to reconnect to the inode via the nodeid.
> + */
> +static int fuse_iomap_inline_read(struct inode *inode, loff_t pos,
> +				  loff_t count, struct iomap *iomap)
> +{
> +	struct fuse_read_in in = {
> +		.offset = pos,
> +		.size = count,
> +	};
> +	struct fuse_inode *fi = get_fuse_inode(inode);
> +	struct fuse_mount *fm = get_fuse_mount(inode);
> +	FUSE_ARGS(args);
> +	ssize_t ret;
> +
> +	if (BAD_DATA(!iomap_inline_data_valid(iomap)))
> +		return -EFSCORRUPTED;

Does this code leak memory when the BAD_DATA check fails?  Looking at
the call chain:

fuse_iomap_set_inline()->fuse_iomap_inline_alloc() allocates
iomap->inline_data via kvzalloc.  If the iomap_inline_data_valid check
fails (i.e., iomap->length > PAGE_SIZE - offset_in_page(iomap->inline_data)),
the function returns -EFSCORRUPTED without freeing iomap->inline_data.

Other error paths in this function (around the fuse_simple_request call)
properly call fuse_iomap_inline_free(iomap) before returning errors.

The caller fuse_iomap_set_inline doesn't clean up iomap->inline_data on
error in the read path (line 538: 'if (err) return err;'), so the
allocation is leaked when a FUSE server returns an IOMAP_INLINE mapping
with length > PAGE_SIZE.

> +
> +	args.opcode = FUSE_READ;
> +	args.nodeid = fi->nodeid;
> +	args.in_numargs = 1;
> +	args.in_args[0].size = sizeof(in);
> +	args.in_args[0].value = &in;
> +	args.out_argvar = true;
> +	args.out_numargs = 1;
> +	args.out_args[0].size = count;
> +	args.out_args[0].value = iomap_inline_data(iomap, pos);
> +
> +	ret = fuse_simple_request(fm, &args);
> +	if (ret < 0) {
> +		fuse_iomap_inline_free(iomap);
> +		return ret;
> +	}
> +	/* no readahead means something bad happened */
> +	if (ret == 0) {
> +		fuse_iomap_inline_free(iomap);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -511,8 +663,28 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
>  {
>  	struct fuse_inode *fi = get_fuse_inode(inode);
>  	struct fuse_mount *fm = get_fuse_mount(inode);
> +	struct iomap_iter *iter = container_of(iomap, struct iomap_iter, iomap);
> +	struct iomap *srcmap = &iter->srcmap;

Can this container_of usage corrupt memory?  Looking at
fuse_iomap_writeback_range, it calls fuse_iomap_end with &write_iomap,
which is a stack-local struct iomap variable (not embedded in an
iomap_iter):

fuse_iomap_writeback_range()
    struct iomap write_iomap = { };
    ...
    fuse_iomap_end(inode, offset, len, 0,
                   FUSE_IOMAP_OP_WRITEBACK, &write_iomap);

The container_of macro computes an invalid pointer by subtracting the
offset of the iomap member from the address, resulting in iter pointing
to garbage memory on the stack.  Subsequently, accessing iter->srcmap
reads from invalid memory, potentially causing undefined behavior or
crashes.

The iomap core calls fuse_iomap_end via fuse_iomap_ops where iomap IS
properly embedded in iomap_iter, but the direct call from
fuse_iomap_writeback_range violates this assumption.



