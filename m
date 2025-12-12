Return-Path: <linux-fsdevel+bounces-71175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B22FCB7891
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 02:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CC38302C4CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 01:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B69D2153EA;
	Fri, 12 Dec 2025 01:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Oh7m599Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D9219FC;
	Fri, 12 Dec 2025 01:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765502581; cv=none; b=AdxcQHfCcPUbqVwJgBw61u0ZB3/XXpmW5jgkLDUf8HndLEfnayVFExzlKEcFk2VpTrsbaLWJyYR8ymsfAVbcycYx5d75ikU3yKLyVDIx1S6mcaopt5njIsjk7fGUDYrT3JRZvYUdnIZVextrapW4NGcDXSp0J0F/YWCZsDFJs+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765502581; c=relaxed/simple;
	bh=5cZSuGwW+f79cDZ34mYxdS/F4nyoffhNSLTKeljCIco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhZZ1i0G2z/B0sy+I+VyQtDk0ktUnsbGxnlajmXmzSHTTflsaqsJRrSKeL5mfEML6l1n/xP5UzxVeGncd0XhZimvqU+J0ofvV427O35oOQKtIh05SYHYKCFwwLmDweBGd9majtg17MklyYHucbeVaFrLfwUt2ki8362YM2/kWxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Oh7m599Y; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BBMtJso3758608;
	Thu, 11 Dec 2025 17:22:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=iTLNUTrLWjVvgSxjnQscXVaewNCe1Rk48Meri1AVnAY=; b=Oh7m599YpvdM
	gnzGe0tp0Jvi8OTQxvbTWvi6EUf7X8rNCHi91L7VafiCvEEiD6LvV70q8jynmvnX
	l27fd9CE7Ta96Km+Vcylpqhn9p00tUrLS6SlEQoUtagnOG/J/Sd6s4I5jaxg6p5j
	UrruNGdBE6YsdPiLPO8KvcUl/9QXsB7z3pWC1wxTWBhqhq+MEZwJ1TbJaQ0AKpG3
	AKOtfas2QlIdGCTXuDRAn7ANoVoyy1hl8kAP0U91Xhl/aTh+vNirvMofgtux6NVR
	dR8gGWue81sY4/2cMtfHv2yJIqLm4zzkXPDjx05Uv4MNrXhtUr6+kUlEl6otpdUK
	OZYWSEP7IQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4b03aekqft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 11 Dec 2025 17:22:52 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 12 Dec 2025 01:22:50 +0000
From: Chris Mason <clm@meta.com>
To: Mateusz Guzik <mjguzik@gmail.com>
CC: Chris Mason <clm@meta.com>, <brauner@kernel.org>,
        <viro@zeniv.linux.org.uk>, <jack@suse.cz>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5] fs: add predicts based on nd->depth
Date: Thu, 11 Dec 2025 17:22:32 -0800
Message-ID: <20251212012236.3231369-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251119142954.2909394-1-mjguzik@gmail.com>
References:
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEyMDAxMCBTYWx0ZWRfX7ZLeBwPvTVz2
 e9ViVSedC7uIykFMNhwfARBZKD7DVo/JvVcFQ/V0Y8AVpAcMLcsx1jB7mSbmhhEq/sfrPd/pu0Q
 xOeM2t3grvFdmz+PHXzmMDFimLQNNlZrio37ERFTDDuPo5/3+r4+OyZHbsSZ6cclQYqo2A2P2DM
 2RhOfhQTDRcLWO1isGklRkI0lGOhmu+mgcqpk8lRl2LL3alLP1LQKwpEz/bVIT+x2dmXfvJIVzl
 +q4XIfXf3GrQ25OAev1cNnbdzdNA3NiysVtLS3bPdutgRGcXWVVEkwpD+X00U88dTZi+CXizWb/
 uqTh7n6XVwyLlk+3iv3Tp9hvs0WtSrBWjs/ZfElbaDXLJi2byBumE3OrN3xkpfWhYw6TDlj0cpj
 lQ6Wv6Uieifx1cl7sfdPEiFo8oZxjg==
X-Proofpoint-GUID: qmOpSzEck0jJ_5ykwlLHzcO_AKT0VFiW
X-Authority-Analysis: v=2.4 cv=ZLraWH7b c=1 sm=1 tr=0 ts=693b6e6c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8
 a=WisbpVpCxSA3TflYvVEA:9
X-Proofpoint-ORIG-GUID: qmOpSzEck0jJ_5ykwlLHzcO_AKT0VFiW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-12_01,2025-12-11_01,2025-10-01_01

On Wed, 19 Nov 2025 15:29:54 +0100 Mateusz Guzik <mjguzik@gmail.com> wrote:

Hi everyone,

I ran some of the recent commits through the AI review prompts and it
flagged this one.  The comments look right to me:

[ ... ]

> diff --git a/fs/namei.c b/fs/namei.c
> index a5bffc2a29f6c..5fbb05fb96b75 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c

[ ... ]

> @@ -882,7 +883,7 @@ static bool try_to_unlazy(struct nameidata *nd)
>
>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>
> -	if (unlikely(!legitimize_links(nd)))
> +	if (unlikely(nd->depth && !legitimize_links(nd)))
>  		goto out1;

When nd->depth is 0, this short-circuits and never calls legitimize_links().
However, legitimize_links() contains a LOOKUP_CACHED check that was moved
there in commit b93a6e389bdc7 ("fix handling of nd->depth on LOOKUP_CACHED
failures in try_to_unlazy*"):

    static bool legitimize_links(struct nameidata *nd)
    {
        if (unlikely(nd->flags & LOOKUP_CACHED)) {
            drop_links(nd);
            nd->depth = 0;
            return false;
        }
        ...
    }

Before that commit, the LOOKUP_CACHED check was done directly in
try_to_unlazy() before calling legitimize_links(). It was moved into
legitimize_links() for consolidation, not because it's semantically
related to having links.

With LOOKUP_CACHED set (used by io_uring for non-blocking opens) and
nd->depth == 0, try_to_unlazy() now proceeds to legitimize_path() and may
succeed, when previously it would have failed. This can cause
lookup_fast()->try_to_unlazy() to succeed, leading the caller to call
lookup_slow() which takes inode_lock_shared() and blocks - violating
LOOKUP_CACHED semantics.

Should the LOOKUP_CACHED check be moved back to try_to_unlazy() before
the depth check, like:

    if (unlikely(nd->flags & LOOKUP_CACHED))
        goto out1;
    if (unlikely(nd->depth && !legitimize_links(nd)))
        goto out1;

>  	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
>  		goto out;

[ ... ]

> @@ -917,7 +918,7 @@ static bool try_to_unlazy_next(struct nameidata *nd, struct dentry *dentry)
>  	int res;
>  	BUG_ON(!(nd->flags & LOOKUP_RCU));
>
> -	if (unlikely(!legitimize_links(nd)))
> +	if (unlikely(nd->depth && !legitimize_links(nd)))
>  		goto out2;

The same issue applies here in try_to_unlazy_next().

[ ... ]


-chris

