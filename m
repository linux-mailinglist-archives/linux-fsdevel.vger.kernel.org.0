Return-Path: <linux-fsdevel+bounces-76475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD/YM/TqhGkj6gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:09:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB29F6BA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89636303388C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 19:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992E313E2B;
	Thu,  5 Feb 2026 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PWO5nK4g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B57279DB3;
	Thu,  5 Feb 2026 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318550; cv=none; b=m2s+C7DMRkG3djTE9m2Pc00ExcvCM10hb1ZbxInnbDOR+drc9VyEry5K5Kd9ikjxGPlsO09x+4WKmFNGzHqGbnqiUEJe/jxF/5rlYi4pmB3M1v2/t84g/yz78BK23OV88uwy7ujfnMt2EFhaCwqZvVZwPQVjXwvp0y2Bp7oZ104=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318550; c=relaxed/simple;
	bh=JGjzBjtHPKO9+VhUCwhp0IPl7iyz/jfbz0Mi3AgsQX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0xUJLwkvJOgedRmxgzkn+aLVUutrNifMhaCYCrLEHDiITW2zrcN9Nryv0SduTGuNpeAWzNH09hQ7+WNv+kPAz6c5PK4c4gbzeCNXSiCMgrjIE5jbDoWm4u+7mQxOKXC7UliPsh0zP0WuVSvXbT05g1g4mA4M2HeIbZ9NXiXXZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PWO5nK4g; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615H6uxM1744529;
	Thu, 5 Feb 2026 11:08:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Tw1jhsxrGuVJEwZxv1sbXrOjX9ezjoDcxWy8EzxVvNw=; b=PWO5nK4gA9Jp
	lC3gBn2FCld8Ss+SjHopLkqSZJuHy9jMgTZQanFfcHDUA/RHIySMmwx8m2jyt6aq
	bj4N5VTNP7tBBE+rSrU2fvG+/f9COYqy03r5VEocpN40ItIee+yhItZaAwGeHEg4
	XED9sRw4lKHuJ3j8UhYazVsH3oqlhBNNrLdxfyR4fACfHTT9QeBYM87S29AYja2Z
	H7ajdYgO37tlb0KvtevnVwG40WlSexlnP9HCnL8+7pZlrE2Y+1EizkwphrFuYfcr
	iKApZRUMgTuW6se1iXU7ry7TRBxnTnNJOSA2ArEWCyZrawtZgyPkMZudAJ7cYbRT
	Uvx6tpw66Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4yauhpeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 11:08:58 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 19:08:56 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 19/31] fuse: query filesystem geometry when using iomap
Date: Thu, 5 Feb 2026 11:07:55 -0800
Message-ID: <20260205190840.1958463-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169810765.1424854.10969346031644824992.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810765.1424854.10969346031644824992.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0NSBTYWx0ZWRfX6uHfG+ZhrpxL
 jRv9VvZ1HaTrJ6UDUg42YAX6rYdKebQ0fA7WQ6r+hxYW60Vucz0cJ1CQVhmV3dOXTgGIbHUFA1Z
 QdB2kw9TsSpNCYnfyqlNyYwbDTmUsB1cHu2wEQcagvEfn8/t7w/OUxkm+RjWgW4cwQN47xydH9D
 4LBaLEVQrCZ2j1UKUkOwOMmjD9S/YukVNUBX9h/4le2yy/0ywel2U9se9VOBKn8dg2rS6DPQVPT
 pIRBBncoDcXO/d1i6s4Xv+lxYlcG523FVFogJDq3hpvWgcCHZMoWUYUkKuNPjUmYgKIk2zgg67n
 DiPsob14DisFbc1PE+DvwidKrQRg3EI2tG3YxV54JXSj+xfT+k3J6oshFmJoIdoex3ndB2rEE0S
 +OZTRG0u2IJWlO4XVf4dyldr8ivanmku6gbvuCigMRprggYvkX7NLXKRCjBFwviQl4oXwVWyhvx
 HRXiTQK7i2WnwPpYXuw==
X-Proofpoint-ORIG-GUID: H9ZdG3XSZ6VufKMgueyf2ppg__TAvANu
X-Authority-Analysis: v=2.4 cv=HcQZjyE8 c=1 sm=1 tr=0 ts=6984eaca cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=HGcO7sBs-gaaMB_HWnMA:9
X-Proofpoint-GUID: H9ZdG3XSZ6VufKMgueyf2ppg__TAvANu
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
	TAGGED_FROM(0.00)[bounces-76475-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 4AB29F6BA8
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add a new upcall to the fuse server so that the kernel can request
> filesystem geometry bits when iomap mode is in use.
> 

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

commit d529d13100b2e00c33a507c371b6c1b19f2206ae
Author: Darrick J. Wong <djwong@kernel.org>

fuse_trace: query filesystem geometry when using iomap

This commit adds tracepoints for the FUSE_IOMAP_CONFIG operation,
enabling tracing of filesystem geometry queries when using iomap with
FUSE. The tracepoint captures configuration flags, block size, link
limits, time granularity and ranges, maximum file size, and UUID length.

> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> --- a/fs/fuse/fuse_iomap.c
> +++ b/fs/fuse/fuse_iomap.c
> @@ -743,6 +743,8 @@ static int fuse_iomap_process_config(struct fuse_mount *fm, int error,
>  		return error;
>  	}
>
> +	trace_fuse_iomap_config(fm, outarg);
> +
>  	if (outarg->flags & ~FUSE_IOMAP_CONFIG_ALL)
>  		return -EINVAL;
>

[ ... ]

> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h

[ ... ]

> @@ -1005,6 +1014,45 @@
>  		  __entry->mode,
>  		  __entry->newsize)
>  );
> +
> +TRACE_EVENT(fuse_iomap_config,
> +	TP_PROTO(const struct fuse_mount *fm,
> +		 const struct fuse_iomap_config_out *outarg),
> +	TP_ARGS(fm, outarg),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,			connection)
> +
> +		__field(uint32_t,		flags)
> +		__field(uint32_t,		blocksize)
> +		__field(uint32_t,		max_links)
> +		__field(uint32_t,		time_gran)
> +
> +		__field(int64_t,		time_min)
> +		__field(int64_t,		time_max)
> +		__field(int64_t,		maxbytes)
> +		__field(uint8_t,		uuid_len)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->connection	=	fm->fc->dev;
> +		__entry->flags		=	outarg->flags;
                                                           ^^^^

Does this truncate the upper 32 bits of the flags field? The flags field
in struct fuse_iomap_config_out (include/uapi/linux/fuse.h:1471) is
defined as uint64_t:

struct fuse_iomap_config_out {
	uint64_t flags;		/* FUSE_IOMAP_CONFIG_* */
	...
}

But the trace event declares it as uint32_t in TP_STRUCT__entry. While
current flag definitions (FUSE_IOMAP_CONFIG_SID through
FUSE_IOMAP_CONFIG_MAXBYTES) only use bits 0-5, using uint32_t will lose
the upper 32 bits if future flags use them.

Should the trace event field be declared as uint64_t to match the
structure definition?



