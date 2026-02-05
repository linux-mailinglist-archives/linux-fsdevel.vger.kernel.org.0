Return-Path: <linux-fsdevel+bounces-76477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL+RIubshGkj6gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:17:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEDF6C4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EA13301E230
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 19:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39623242D2;
	Thu,  5 Feb 2026 19:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="a90AZRlT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D463242CA;
	Thu,  5 Feb 2026 19:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319067; cv=none; b=bNuG9gKmCE6HXLxKcdglBWWdHvTLlDXD6ORgxgmczZbxjOYoAW+P5+58niqIl/jzw+tuQyMIr+N0pbcTyZ91p/5qXr0iauRGhn4PL8I9YAUBb1hJgnm796XQXe+mtM1XLaaktpY0KQWWRIBzASZP17Q9lgZI90m7cIZ/Igy27QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319067; c=relaxed/simple;
	bh=eVXal1AmEVjGOi66gzn62L+31esaLYjua2J/+gXORPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbgdvEmnFzuVVCdyz+O7MMmeUt5OkERUpd5JaLhRKqMBN+dGpWVKOKLBVehE6s54seIaGMcnTRJN7JC/i4SSnsZpgY17Qa2RHBijNYkdl5I0eUgTVhbJ7WlJ4nP3hmWV5TcpszgdRCDc3Oqu9W/sxCs8XVFbtQBDyikg0sghgOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=a90AZRlT; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBSgi3292198;
	Thu, 5 Feb 2026 11:17:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=COindBEqIiATE57QPLGgbGPhOsHL0TGcQaez/bRgvX0=; b=a90AZRlTl8pD
	F3zadO7Tef5djrDk4qBNBqC/DfIg4D7hHwa4iuDLQ+NqSychVXNqCZlOr/sBXSK2
	ZhvSeF6JuaDbuimL9aGgGJ8YED7l0aHRcqLyoDvWgVgE5RI/MxjYyWIieE98/Unw
	Mos0VQkzTM/LOlh43FV5h0O870U89yEl62PTXeMFPA7Qyb8HSDuympaD7/3c1O9z
	b+JjyJuIw+igZfOoKCWPbNRxBwSJ1dVoXsM2ZAmDRB4jU5F5uP/bixQB3fQ9JWmM
	YvghDhhlU63aRJROs4YsyiHzBSKrt2H6dsyJkYP3/62QPWgNRPPcNkOWwxYsBEaT
	KToAOOGrzg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4x2sjwvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 11:17:38 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 19:17:36 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 13/31] fuse_trace: implement direct IO with iomap
Date: Thu, 5 Feb 2026 11:16:54 -0800
Message-ID: <20260205191717.2066475-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169810634.1424854.13084435884326863405.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810634.1424854.13084435884326863405.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VlZdsZkKZ9Ko3lpx1hwSLF_xrLxEK1Qb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0NiBTYWx0ZWRfX15xlH6cOMm+O
 KGzt5zMoDf6U2kgA28679TKjRo6t7CWrXIaN2WlvZluK7qW9oN+vM/mYakZWvJjNQad5VHrLd0/
 P+QyNFRj81NkMNWuVaOQhGWvSi2hBXIOy2PWrnzntzKodbNO9nEohL1UYuxNUftu1BDhz6QcoXL
 HDM9YCqnafH6FbfmcqYy/fTAvn8sIP5vKlXOLD7LHEtickiDgM6z8BygB+MwqGSI6j2BUklUxJC
 5VvzCzpntyLPHtJbjv0oq9np17961I6315PMYADUkAqqgal95Q8+AroT1ssuUMHzVwXSJWCiKvB
 3E2ih0Nui6LWYsE8X0n6L1MCJ5m5MDWO7RUbDJOB3IEeYeHyfY0mVBaAOrT8uSIAjxOQkNO2Bdl
 vJk2qz8lAhe9A0MKRi2/ucSoyF4rxI5HQ4BrEPTm3biAq6KWhrBrsZJjOradyHCoZhy0tydON6L
 lGNo0d2H4pvTnhb64/A==
X-Authority-Analysis: v=2.4 cv=aPz9aL9m c=1 sm=1 tr=0 ts=6984ecd2 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=ZeulQzZgwPvXdNACrg4A:9
X-Proofpoint-ORIG-GUID: VlZdsZkKZ9Ko3lpx1hwSLF_xrLxEK1Qb
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
	TAGGED_FROM(0.00)[bounces-76477-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22CEDF6C4D
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Add tracepoints for the previous patch.
> 

commit 3fad15ebe8d51187a2b6820ed6db4774a8b065b0
Author: Darrick J. Wong <djwong@kernel.org>

fuse_trace: implement direct IO with iomap

Add tracepoints for the previous patch.

> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index 730ab8bce4445..efba6ecbbf670 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h

[ ... ]

> @@ -484,6 +499,75 @@ TRACE_EVENT(fuse_iomap_end_error,
> +TRACE_EVENT(fuse_iomap_ioend,
> +	TP_PROTO(const struct inode *inode,
> +		 const struct fuse_iomap_ioend_in *inarg),
> +
> +	TP_ARGS(inode, inarg),
> +
> +	TP_STRUCT__entry(
> +		FUSE_IO_RANGE_FIELDS()
> +		__field(unsigned,		ioendflags)
> +		__field(int,			error)
> +		__field(uint32_t,		dev)
> +		__field(uint64_t,		new_addr)
> +	),
> +
> +	TP_fast_assign(
> +		FUSE_INODE_ASSIGN(inode, fi, fm);
> +		__entry->offset		=	inarg->pos;
> +		__entry->length		=	inarg->written;
> +		__entry->ioendflags	=	inarg->flags;
> +		__entry->error		=	inarg->error;
> +		__entry->dev		=	inarg->dev;
> +		__entry->new_addr	=	inarg->new_addr;
> +	),
> +
> +	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d dev %u new_addr 0x%llx",
> +		  FUSE_IO_RANGE_PRINTK_ARGS(),
> +		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
> +		  __entry->dev,
> +		  __entry->error,
> +		  __entry->new_addr)
                  ^^^^

Are the error and dev fields swapped in the argument list?

The format string expects 'error %d dev %u' but the arguments are
provided as __entry->dev, __entry->error. This would cause the trace
output to display the dev value as error and the error value as dev.

> +);
> +
> +TRACE_EVENT(fuse_iomap_ioend_error,
> +	TP_PROTO(const struct inode *inode,
> +		 const struct fuse_iomap_ioend_in *inarg,
> +		 const struct fuse_iomap_ioend_out *outarg,
> +		 int error),
> +
> +	TP_ARGS(inode, inarg, outarg, error),
> +
> +	TP_STRUCT__entry(
> +		FUSE_IO_RANGE_FIELDS()
> +		__field(unsigned,		ioendflags)
> +		__field(int,			error)
> +		__field(uint32_t,		dev)
> +		__field(uint64_t,		new_addr)
> +		__field(uint64_t,		new_size)
> +	),
> +
> +	TP_fast_assign(
> +		FUSE_INODE_ASSIGN(inode, fi, fm);
> +		__entry->offset		=	inarg->pos;
> +		__entry->length		=	inarg->written;
> +		__entry->ioendflags	=	inarg->flags;
> +		__entry->error		=	error;
> +		__entry->dev		=	inarg->dev;
> +		__entry->new_addr	=	inarg->new_addr;
> +		__entry->new_size	=	outarg->newsize;
> +	),
> +
> +	TP_printk(FUSE_IO_RANGE_FMT() " ioendflags (%s) error %d dev %u new_addr 0x%llx new_size 0x%llx",
> +		  FUSE_IO_RANGE_PRINTK_ARGS(),
> +		  __print_flags(__entry->ioendflags, "|", FUSE_IOMAP_IOEND_STRINGS),
> +		  __entry->dev,
> +		  __entry->error,
> +		  __entry->new_addr,
> +		  __entry->new_size)
                  ^^^^

Same issue here. The format string expects 'error %d dev %u' but the
arguments are provided as __entry->dev, __entry->error, swapping the
values in the trace output.

> +);
> +

[ ... ]


