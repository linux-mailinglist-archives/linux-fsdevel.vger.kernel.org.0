Return-Path: <linux-fsdevel+bounces-39887-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAA0A19C20
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976923A2D5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F113595B;
	Thu, 23 Jan 2025 01:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b="Ie0swPLZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70C35950
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737594899; cv=none; b=N/9HSNxkryMym8aBvWVgZszWcj44ONHdAXlreM16BB7+17RhbBiO8H8xqYbe2pJBCgNeQRZBMr2aDedo+pVO77Bhy+UE6nFykxX/kY2Rl7g5/Uw7s8q6ktLT7YTF5679EskaSRXo2ZlK5+22PhDo681PBqkDvxFwjQGbJycTYnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737594899; c=relaxed/simple;
	bh=wNh6/E/UAQ8EPa3SwFxk9mTiGmvtA5wA7EYbhPG+PLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JJDZiXuqk4YC+i9Cb5jhPajBEz+5/f3r0tCnrU3BDaEI3T06m5rWNBqug8NlASgzoeMWzGUwXlOWsuEdONABGGJuJNTlJni/2+r5Ktc7kdDhxrYCXWyRbmpDFuPPv+fOY6lo89TYFyHkk06Tn5qlYTKtL9e1hyPePIj16UW9zuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=Ie0swPLZ; arc=none smtp.client-ip=67.231.153.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Received: from pps.filterd (m0355791.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MN9T8a004460
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 19:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=20180315; bh=w
	Nh6/E/UAQ8EPa3SwFxk9mTiGmvtA5wA7EYbhPG+PLs=; b=Ie0swPLZ9u8QcQeFe
	UM8rNdCYbPFmDVBXmWufdCvZMngx7WsdtfqQtHW2lPcb8zpFtOfY1Y60k1uX3aQl
	nVp3PcFZBn+MFow2IfmWurBHlb0G6MZx27Nr88OwuDLayWD1EpLDOL5xWGE/LqNh
	oKH3avumEXRze4IDt1ofif+veV1FimD1D154u0Q2TL0a95II9tXWXL8aMU1dW4xO
	u5b6oLqDsyPyOOPyo/PlgvLhsaVp3+YJTuMAuoJmhHcNYqTkvrOx+WwxH6/amGH5
	AYWzIsiDFcZnnkMmwajLtYr+V40el02wAkC4aultHzhH4sqqPTZBrhi9MIhk6tCi
	GBRiQ==
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 44ac45j4fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 19:51:05 -0500 (EST)
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-53faf9e6195so721444e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 16:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737593464; x=1738198264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNh6/E/UAQ8EPa3SwFxk9mTiGmvtA5wA7EYbhPG+PLs=;
        b=kuFc0EKzHeCti8xp1WODvfL+SdMxHT+aWVDL1OlG0cEF+AGHjZGbDaB9toS10od7FI
         D+SU7SayfAMz4U78HvmdbF87zrSL4fY+/ob0XCfGTjlRdrCbTpjhU+ocQcKgjnZYh+8H
         +4eKA0nvkrYE1n073JbX+rS54U9foIgjP8HE9Tv1vGzx9b+5naHhqDWBgTSl+87dwhoh
         g36aaWntQSwbFxgbX1VVBejW80ESyp3Jv1ucLml+JTwLDBoX2iXrmtDH0My3TKHjpSEt
         HFTLMFyYy6wTZlakgXCg2spNtaLyoooPhH+J3f55Y7vKmEhfyaNWENEFKsYCgEtnAJVM
         Edxw==
X-Gm-Message-State: AOJu0Yxrl/VIT2nQ0zOUD6CHz5k706vldpzGEorI5gbp1FQaZOCJqLvJ
	F6HQEWTQPOwuDkG4YV+GZi/8oGzUBMDTq+wJxx8A5BsXihHzJIlvpY88UXJLndSmOQJLMGGyWuT
	ebeGnOoacrFGqI4+YoCiTbuL/GGr8eEz2b+IDyi0zvrRuCYnTnEuRfdhRUD42oJJLulxorcuGzZ
	KBkN4M19mvc2zgoyuCMIxSNjlcZfAT1Q+BeRc=
X-Gm-Gg: ASbGncsmR9IxxjpfRy2sbGD9IxoNpywW1IsMUem3NXqdVu/oIPgj6zS25XCOhqEAelE
	bfaqaIkFynWRGyZMDuMwYWSudDLJ5WlQUkXiynD5iTCRg2DjPJHS7OYjm5eJ9ogIt0GveQP1cma
	ihOzKSQ7nk4Q==
X-Received: by 2002:a05:6512:159c:b0:541:3175:19b4 with SMTP id 2adb3069b0e04-543c222eba1mr412298e87.11.1737593464189;
        Wed, 22 Jan 2025 16:51:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn01a+ZNwaqtbvdO4h2H6LfMZe88mKtVdgMDw5AIohWUR4eArjhjSum2UW3wX1SILj+hIfFEYwveNTtbbVooE=
X-Received: by 2002:a05:6512:159c:b0:541:3175:19b4 with SMTP id
 2adb3069b0e04-543c222eba1mr412294e87.11.1737593463813; Wed, 22 Jan 2025
 16:51:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPbsSE6vngGRM6UvKT3kvWpZmj2eg7yXUMu6Ow5PykdC7s7dBQ@mail.gmail.com>
 <dnoyvsmdp7o6vgolrehhogqdki2rwj5fl3jmxh632kifbej6wc@5tzkshyj4rd5>
 <CAPbsSE5xJNVrqNugqD7Ox8FxT28kK49SBDFiRN84Dcn=DWzP9w@mail.gmail.com> <CAGudoHHWhUOcBNUu8WboxGFrb7nyBuRCruJ6=xT5DPaJ_xyd=A@mail.gmail.com>
In-Reply-To: <CAGudoHHWhUOcBNUu8WboxGFrb7nyBuRCruJ6=xT5DPaJ_xyd=A@mail.gmail.com>
From: Nick Renner <nr2185@nyu.edu>
Date: Wed, 22 Jan 2025 19:50:52 -0500
X-Gm-Features: AWEUYZnbScB4N8IgUHWH2sohP3hTbQDd_xKDnQQbaqTn1WNQsb14kPzJXvsOpZY
Message-ID: <CAPbsSE7QjCAtugQG=BH0n+nMUQUDnA7WznXCHqvkBfj304NpnQ@mail.gmail.com>
Subject: Re: Mutex free Pipes
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: NtORP6_qv--cuiGNKMeLVwYdhjj26DOW
X-Proofpoint-ORIG-GUID: NtORP6_qv--cuiGNKMeLVwYdhjj26DOW
X-Orig-IP: 209.85.167.71
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0 priorityscore=1501
 mlxscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=585 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230004

> > On Tue, Jan 21, 2025 at 3:34=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.co=
m> wrote:
> Whether things work out or not I definitely encourage you to keep digging=
.
>
> Worst case scenario you had some fun, best case you made pipes on Linux f=
aster.
Thanks for your encouragement!

>
> Now to the point: in contrast to a regular fifo, the area backing the
> total capacity of the pipe is not necessarily fully allocated -- it is
> being backed by page-sized buffers allocated and freed as needed.
>
> I think the default capacity is 64K. Only ever using what's needed
> (rounded up to a multiple of page size) saves memory for most pipes
> and I presume this property will have to stay.
>
> Sample problem this poses for the lockless approach: after finishing
> up a buffer, the reader will need to free it, but this needs to be
> synchronized against a writer which may just happen to have started
> writing there.
>

This is one of the points I was curious about. Is this on-demand
allocation and freeing of pages necessary? What are some reasons that
the full pipe capacity shouldn't be allocated for the lifetime of a
pipe?

Some of my results indicate that just this on-demand page management
contributes something like ~25% overhead when continuously writing and
reading multi-page buffers. But I'm not sure if there are some memory
management concerns that are deemed more important than the cost of
this overhead.

