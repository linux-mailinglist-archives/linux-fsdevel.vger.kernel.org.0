Return-Path: <linux-fsdevel+bounces-76471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIyuFkjnhGlf6QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:54:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF81F6997
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B0C630022C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 18:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231553090FF;
	Thu,  5 Feb 2026 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BMLI+Civ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF43090C6;
	Thu,  5 Feb 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317636; cv=none; b=oW+Y99UYrqE9j9zmSscqKg+heMhlTm7g/gZyiAVbXgXjYqGu2bM7J/MS9NvoocOWpdmfHwTD1qbfcPbSg8+PSKEH0+7DD2rN1VDSbxkkM/VcJVVxoP6iQ+3uiF0FuRoUc428/ojjJE5L4fEeccEZo0qJnPbaOFGcn4pqhUQrVnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317636; c=relaxed/simple;
	bh=07TbCI5INlmWPopytll6rKjff9teMw2UVZiJgkF3NY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kx/4idpn4vOmcMmJ3Ddp/1skR//3qs4hxFrvfWx7EkjPbi30Ax/QN/NUcTxtMNedi+C/wJ9sbmYO3+hRl99Xw8AbIRmYI8P0SOusg6mxCnyYsvuonivuHKmaXKzOky8CMU6Jnc4IPNIXT5YVH0QLeQt3TIeNZ3gTDIaPNiiNxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BMLI+Civ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615FfXbt2704529;
	Thu, 5 Feb 2026 10:53:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=gIdWc1sFEToCD+IrI2keWvjFpsdEtF2ee1Jr9uIu+XI=; b=BMLI+CivJVH4
	zek1bpjMoQ2A/om2pSDlKSfmiv2EnncNvXYNNj43nDYct4daZMIV0CkSWNO9h4/q
	SVE7sIJ3Bk8T4gioKUiLiaiI5tO/clr9furGr8hRm+fCEmiDa+R5QmK82RtWuNsF
	IcBNfcSpShVcgDj1k7l2eopouAXEEDk1SJ/JyQ61X+cKQIs8w/sGJHQbLhryveYu
	TWmwlgvgOUQBuJJleGVWv6NBuJ8bpLrr2Rnj3TAp8c2FJz4IUIv1HISkRSgcC6VU
	xHSjMoCwnEphUf4vC3S3JclnnguHcJSV/l91Vv68fpltRD++QV/bBYEpdS3DuQ41
	vbBW5AE9fQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4x2sjkb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 10:53:42 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 18:53:41 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/10] fuse: use the iomap cache for iomap_begin
Date: Thu, 5 Feb 2026 10:52:04 -0800
Message-ID: <20260205185327.1776495-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169812141.1426649.7329768881025739080.stgit@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs> <176169812141.1426649.7329768881025739080.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: J7tO8Q1BkhE8wThwSbXU6DaxEEOdnygK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0MyBTYWx0ZWRfXzsaJgmfszfAL
 oOLmKL7L6nDvcH0bt+ZNGDQMGaok38VpHyRus/6G/81n15g9xsfT+gxqw+gdHbHmqunGj+/U7Qe
 A1VDz61qU0cTi60u8TDtqkAxvFv4WI9aayx/7NyKvsFMi/pyGWi8J5e03W2LgAZOAVfyfsU6/AD
 /HNsYjwsWbsHzzXfA8l1Y1WbvMTSPOgVm0RjQKmvtPN9u+IJxEIWrQ9BnKFvO7C3nZG0UsJ/LLC
 iQvHXctzwN1Jav5Zwvy7606azzqW1Ux7xCUjJtNjBpaL896BFXzdu5dKuhZAg1XfibLXJQddY4n
 BuQWVJvgZEs/HpxkXIfB12ioVuOPnk9an5z3cySmkflbrPAMTs2gnjzMpu5XlxqGAO7KzX6H8pI
 n4XVzI8/ynPubpl3C2T4Yuw2Uhm4ATFD6oh5YwtfE0Hv6Cqr4i4STsf7s4LX64VfYvbu/sztCxn
 9mx444j4iFFgPOc2R4Q==
X-Authority-Analysis: v=2.4 cv=aPz9aL9m c=1 sm=1 tr=0 ts=6984e736 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=_XhwcmBIarpN5NAkK3sA:9
X-Proofpoint-ORIG-GUID: J7tO8Q1BkhE8wThwSbXU6DaxEEOdnygK
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76471-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0CF81F6997
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Look inside the iomap cache to try to satisfy iomap_begin.
> 

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

commit 705acf20a7890a2ba0ab24fe6bf523b99c1a1f32
Author: Darrick J. Wong <djwong@kernel.org>

fuse: use the iomap cache for iomap_begin

Look inside the iomap cache to try to satisfy iomap_begin.

> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> index eade8dad8a570..cf46824dc50bf 100644
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c

[ ... ]

> @@ -238,9 +239,14 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
>  	const unsigned int blocksize = i_blocksize(inode);
>  	uint64_t end;
>
> -	/* Type and flags must be known */
> +	/*
> +	 * Type and flags must be known.  Mapping type "retry cache" doesn't
> +	 * use any of the other fields.
> +	 */
>  	if (BAD_DATA(!fuse_iomap_check_type(map->type)))
>  		return false;
> +	if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE)
> +		return true;
>  	if (BAD_DATA(!fuse_iomap_check_flags(map->flags)))
>  		return false;

[ ... ]

> @@ -271,6 +277,14 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
>  		if (BAD_DATA(map->addr == FUSE_IOMAP_NULL_ADDR))
>  			return false;
>  		break;
> +	case FUSE_IOMAP_TYPE_RETRY_CACHE:
> +		/*
> +		 * We only accept cache retries if we have a cache to query.
> +		 * There must not be a device addr.
> +		 */
> +		if (BAD_DATA(!fuse_inode_caches_iomaps(inode)))
> +			return false;
> +		fallthrough;
>  	case FUSE_IOMAP_TYPE_DELALLOC:
>  	case FUSE_IOMAP_TYPE_HOLE:
>  	case FUSE_IOMAP_TYPE_INLINE:

Does the validation at lines 280-287 ever execute? Looking at
fuse_iomap_check_mapping(), the early return at line 248-249 handles
FUSE_IOMAP_TYPE_RETRY_CACHE:

    if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE)
        return true;

This means the function returns before reaching the switch statement that
contains the new RETRY_CACHE case. The validation check 'if (BAD_DATA(!
fuse_inode_caches_iomaps(inode))) return false;' at lines 284-285 appears
to be dead code because RETRY_CACHE mappings are accepted without verifying
the inode has a cache, contradicting the comment "We only accept cache
retries if we have a cache to query."

Either the fuse_inode_caches_iomaps check should move to the early return
path like this:

    if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE) {
        if (BAD_DATA(!fuse_inode_caches_iomaps(inode)))
            return false;
        return true;
    }

or the early return should be removed to let RETRY_CACHE fall through to
the switch statement validation.


