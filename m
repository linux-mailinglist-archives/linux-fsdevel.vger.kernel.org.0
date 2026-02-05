Return-Path: <linux-fsdevel+bounces-76470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAkHLr7lhGlf6QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:47:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 661E5F68E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 19:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D91CA302E91F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFB32D592F;
	Thu,  5 Feb 2026 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="I+2zhRZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E5C1F181F;
	Thu,  5 Feb 2026 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317211; cv=none; b=oQgCMUnGeeGYVHPwrCyqWOeWnFV+vyY6XtE3hkvC0S3Pt87vpbpqf0QdKglTKvf31btFoVAD0DWCNVeCXIlCl0hkGGHyOly6DF6cizvWaKf02+NxmWjZLyPL2ehqB2bLDWodwfLncfr8v0fqjBKsdReogT8H46cRpbAYOU8+fjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317211; c=relaxed/simple;
	bh=wvfSRTBK3iQXv7MDOvAOmS9es3ETJyz0uF5YS8ywwD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5NPSJUA6y2DLXI/uVOXZrl39qnZpROyCSP3kEkJaiqziz/swHglll5Z15zLMP9jInJStpWwixgz3WsNp23MFB2O2Ka+wJzepLueHFqJ9JkST9MZAyH7X3G8BtKzoKYPRjsd9mWRcY0+No7aXlzD3KoVReVm8pqIAO0FKAlgFbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=I+2zhRZB; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615IgrgR1929127;
	Thu, 5 Feb 2026 10:46:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=8a5peUbdo9YGpjkhqEfJI6CYMg7LED6/xptnM/3jFb8=; b=I+2zhRZBdw2D
	likhw07IRSwxz4ovb7VYLDZQpZYTF5HUkgsYaZBk8kz/g92cT8gEKmTJtx3Qhlwe
	S26zGPQ8xU5kQAdbTcRYtmR8HJzxJdXSlExVzuaJIPRcf/YrxbUGypO6+NVtBBA9
	R/NQspQscdBVEE4HL6YBss2Q2zyNrbGqsohfthXhThBJTNsaUm92qsRt9ceKvPMA
	fqS+AJ1vfRN37zoqNAqgfFP9zvxyNGDwhCG9olFGz7cuRQAV/x0PCZqJ2t8h4/M4
	h0c3acR0L0POKz7xXD+Jiqk/eo44MraDMjf3s91Y+/vF8RXc3fRvjSxvbhMkdx/i
	Tq7MykSuiA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c50qtg1f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 10:46:35 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 18:46:34 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/10] fuse: invalidate iomap cache after file updates
Date: Thu, 5 Feb 2026 10:44:40 -0800
Message-ID: <20260205184620.1682986-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169812184.1426649.3326330857378130332.stgit@frogsfrogsfrogs>
References: <176169812012.1426649.16037866918992398523.stgit@frogsfrogsfrogs> <176169812184.1426649.3326330857378130332.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=FMsWBuos c=1 sm=1 tr=0 ts=6984e58b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=u-1MZTOJFxEy0LvVYYQA:9
X-Proofpoint-GUID: nwnlCYJsNW_3J1eJw5F965gmR7mA7Uw1
X-Proofpoint-ORIG-GUID: nwnlCYJsNW_3J1eJw5F965gmR7mA7Uw1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0MyBTYWx0ZWRfX4pG+wL+y8dXI
 xRZHKvLdolmpj7krP4rr0ZdK/GLGSe35gdwcFiHEf52nHE4JNzNMFA4dEjqTTWGVeidaFCuHm17
 +RU3SwDlXf35hs+eFQ2m2sBVlLVlsi4TKxprbd4clzffC6m6NR93UPLn0hQX9/6D8Jc1lOwrZ5t
 mtUGBq+giu18POicyeIWHUB3GKdrIg6X8LMVdgWDPTvA3JpoFshxUdA1qZ7NBHmpY60ntd6pz0A
 dPgoE5sgs92DcSvE4xAnrsVFntnd/UBA6ZQLdcXYgRfz33UAa3CRBWMTWg2s9egVOjz9Szv7QHV
 Oupyn/L3B/00ywc4ZO82i0MAtK+UnQu1NDqyfaauAu/uzKTxd/cOwifjPNMHDHds0zeN+AlyfGu
 +5SZc350OvQ4+g2FTbI0v4SFnGbPCFj7QLbeJWh2QmwlWHzYv5XuNylYd2gxOOcZUgxj7wL/y5P
 k7yIs+LMkDnjfjjWm/A==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76470-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 661E5F68E1
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> The kernel doesn't know what the fuse server might have done in response
> to truncate, fallocate, or ioend events.  Therefore, it must invalidate
> the mapping cache after those operations to ensure cache coherency.
> 

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

commit 8cd55ddf79a7cd6b1c8afbe08b72d8896da67306
Author: Darrick J. Wong <djwong@kernel.org>

fuse: invalidate iomap cache after file updates

This commit fixes a cache coherency bug by adding cache invalidation
calls after file-modifying operations to prevent stale cached iomap
entries from being used.

> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c

[ ... ]

> @@ -3202,7 +3205,9 @@ struct fuse_copy_file_range_in inarg = {
>  		goto out;
>  	}
>
> -	if (!is_iomap)
> +	if (is_iomap)
> +		fuse_iomap_copied_file_range(inode_out, pos_out, outarg.size);

In __fuse_copy_file_range(), does this code pass the correct value to
fuse_iomap_copied_file_range()?

When using the FUSE_COPY_FILE_RANGE_64 API (fc->no_copy_file_range_64
is false), the response goes into 'outarg_64', not 'outarg'. The
'outarg' struct remains uninitialized in this path.

Looking at the code earlier in the function:

    if (fc->no_copy_file_range_64) {
        args.out_args[0].size = sizeof(outarg);
        args.out_args[0].value = &outarg;
    } else {
        args.out_args[0].size = sizeof(outarg_64);
        args.out_args[0].value = &outarg_64;
    }

    /* ... */

    if (args.out_args[0].value == &outarg_64)
        bytes_copied = outarg_64.size;
    else
        bytes_copied = outarg.size;

The 'bytes_copied' variable correctly handles both API versions. The
else branch (non-iomap path) already uses 'bytes_copied' for
truncate_inode_pages_range().

When the 64-bit API succeeds, could the cache invalidation use
garbage/zero data for the range instead of the actual bytes copied,
potentially leaving stale mappings in the cache?

> +	else
>  		truncate_inode_pages_range(inode_out->i_mapping,
>  				   ALIGN_DOWN(pos_out, PAGE_SIZE),
>  				   ALIGN(pos_out + bytes_copied, PAGE_SIZE) - 1);


