Return-Path: <linux-fsdevel+bounces-76479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFQXL+nuhGkU6wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:26:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2705EF6D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AEF93024965
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 19:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADFF326D63;
	Thu,  5 Feb 2026 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XkB0kCrX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846C4321434;
	Thu,  5 Feb 2026 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319579; cv=none; b=oKIprvfWPbT6cwZSJRn7nHjfR1KtsWlCzf8lAAukgz30vpRBLpH84YpXnCJfJocTkm0U3mesy4eaWegc73QV58xh+GUfQ0EJpc3OphZkmVwX4T/7LzEo1zaORLPpoPSjPN9PWdaTow4HrlJpsHqkeyy7RPVai3ndUlet1o7j4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319579; c=relaxed/simple;
	bh=bEHjWX/EthYtxqNyQXjFbxq385167WTlQovrzgaoClQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCtUcBDQDuTzW6W/RXN1sU4zU6CPzgn2TrzbE6tZM7ayExTi+7RJvh1uJN3hiyDC4wxXlgvVxn8eIzZdYyy+Sf9abTuiJqnYuqraqg6VoaocMC8LBYJGevhFKYk+2z5IgKYYl79jvdmPgcojNxRW8JCdAJpniS1IQ94mHT3wOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XkB0kCrX; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBUl22258936;
	Thu, 5 Feb 2026 11:26:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=f6uHP+RWrTRFq5ep3I8yPHiDAxtTFEcBs3paCPeVuqk=; b=XkB0kCrXDRkK
	N/ZpQ5EUTbal+5bIQsyJmliEpN4aMbVvLr7mt/SyPDTtHOy7xazh2rydkKcNelAC
	GfDWluXce2nZ4kmbvC6/8oW2awA8yKHPS3MB+nChXR9wPXeCkeoJIuIwGQ2VCBWO
	fayi/PLbZh23xr3BYgnsCKhOwUTJ5YoWebS9EpLe++ZOUINTYV9qg6vmFAm2en+A
	6xZaHD4LmZf3TT1crRGyuGYxkNJsceeGbwjbPwNQqL8Ze1zjKKIA4OgsYRKebotQ
	foYn3BXQ5c/Olp6Qrxnpbpw8IcXrxiSh/91eK+9V36iph/yN5J4aCijcQkAeWMpH
	hj2ay2P4SA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c5060129r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 11:26:06 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 19:26:05 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/31] fuse: implement the basic iomap mechanisms
Date: Thu, 5 Feb 2026 11:22:44 -0800
Message-ID: <20260205192550.2124130-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169810371.1424854.3010195280915622081.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs> <176169810371.1424854.3010195280915622081.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0OCBTYWx0ZWRfX3gl0cuIx8kpA
 ZR1OgYyVKTYT1Kg0PEgOnywKJ8CCjaK3MzNlCUy4GGz5U0rDupMmHqyfEzzbhuwzbjvuGT3Cys/
 27e7/RuUUjgP9X78K/jjvOvpeiT2wh+h7os/evn2iqxFL4IE/x7VegIaJHdp+lvwgGHpvLmMTyJ
 DxP8iVAlriElC5wuAjbxDCfO9f1yh0YgfRJ6bWthJATvyMnPw7LB1wqJ7592HnpzzFWauVI4Oxz
 71RQX/pynSsze5vtMEvFgVhHstgIrhge5PlmDCt3M53w0hVF802ayJrE49v/Ll4dBrYG22cmELP
 Rn23D9aSpHsL2wYynUXlLgkQSmuGaLsBpHqIFfmrILm0jr55bbWHzIYEa/hDuun9Z6OOVAyHsVH
 G0neuzbFt8arT2VoKl85n7hoFdT0yhNSL0KBXWjIMK51a2aiadMmeB0LfqghVtvGphdPQDyhbqw
 I+th4JZMvwS1eq847KQ==
X-Proofpoint-ORIG-GUID: 2erXCxnb4XTPc9r36zuTFGBSKGFKM5e3
X-Authority-Analysis: v=2.4 cv=K+Iv3iWI c=1 sm=1 tr=0 ts=6984eece cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=stIm5p4hp5KhULESKy8A:9
X-Proofpoint-GUID: 2erXCxnb4XTPc9r36zuTFGBSKGFKM5e3
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
	TAGGED_FROM(0.00)[bounces-76479-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 2705EF6D5E
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Implement functions to enable upcalling of iomap_begin and iomap_end to
> userspace fuse servers.
> 

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

(I don't fully understand why it calls out commit b3f5bd5243, looks like
it's probably just the last place that changes nearby code)

commit 99dffae5966f9647a430fa4c9198e2d2dacae172
Author: Darrick J. Wong <djwong@kernel.org>

fuse: implement the basic iomap mechanisms

Implement functions to enable upcalling of iomap_begin and iomap_end to
userspace fuse servers.

> diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> new file mode 100644
> index 0000000000000..d1c2c2e1e68b8
> --- /dev/null
> +++ b/fs/fuse/fuse_iomap.c

[ ... ]

> @@ -0,0 +1,430 @@

[ ... ]

> +/* Convert a mapping from the server into something the kernel can use */
> +static inline void fuse_iomap_from_server(struct iomap *iomap,
> +					  const struct fuse_iomap_io *fmap)
> +{
> +	iomap->addr = fmap->addr;
> +	iomap->offset = fmap->offset;
> +	iomap->length = fmap->length;
> +	iomap->type = fuse_iomap_type_from_server(fmap->type);
> +	iomap->flags = fuse_iomap_flags_from_server(fmap->flags);
> +	iomap->bdev = NULL; /* XXX */
> +}
> +
> +/* Convert a mapping from the kernel into something the server can use */
> +static inline void fuse_iomap_to_server(struct fuse_iomap_io *fmap,
> +					const struct iomap *iomap)
> +{
> +	fmap->addr = fmap->addr;
                     ^^^^

Does fmap->addr get the wrong value here? Looking at
fuse_iomap_from_server() just above, it correctly does iomap->addr =
fmap->addr. This function appears to have the reverse bug, assigning
fmap->addr to itself instead of fmap->addr = iomap->addr. The other
fields (offset, length, type, flags) all correctly copy from iomap.

This would cause fuse_iomap_end() to send uninitialized or garbage data
in the addr field when calling fuse_iomap_to_server(&inarg.map, iomap).

This bug persists unfixed through commit b3f5bd524315 later in the
series.

> +	fmap->offset = iomap->offset;
> +	fmap->length = iomap->length;
> +	fmap->type = fuse_iomap_type_to_server(iomap->type);
> +	fmap->flags = fuse_iomap_flags_to_server(iomap->flags);
> +	fmap->dev = FUSE_IOMAP_DEV_NULL; /* XXX */
> +}


