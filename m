Return-Path: <linux-fsdevel+bounces-45671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B57E9A7A90C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1574C1892337
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3581E2528F9;
	Thu,  3 Apr 2025 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="gDKIWXrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520E1FDE02
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 18:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703465; cv=none; b=tOUvzQAJQaWseBjSItEpNl7z5qWZpubQN8kQgYEAj2BQp12lN4rE5Ah2GA8drArU4Nq5EewRFOdDwF6ArOHadNei+ZC7EldeYTZgFk5ZcLgBJf/ucGpW4CpLMSm3LEEv6ijP0au1UnLrxkHTFhGyyAj/KhtqUhvSAGepmGW7L3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703465; c=relaxed/simple;
	bh=QNCO8xdV+My6UuvNhkvL144CuLnTwMj7LVMN93eC4+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHC9Yzrh5CFdnH/D9LOhlAPADZp+KpNJ7BUTWXgV0CPEmxfYut0DTzW/U9ln+39M42ig6M5VElbv7JSSbnDGGkkSvKDRcNkYGNM00mXul3EWc4Kh9z5WrsNUvNQCUy/qcsn3n5QVT+hs7vmhkhO5SHmc02FsGWeuEq+Hybw9qFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=gDKIWXrh; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 533HeH73008526
	for <linux-fsdevel@vger.kernel.org>; Thu, 3 Apr 2025 11:04:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=QNCO8xdV+My6UuvNhkvL144CuLnTwMj7LVMN93eC4+A=; b=gDKIWXrhzq9v
	5sWnA6M2gvC1aPDMfyWoQ5FdsVGLWsz1/bdgYiWCzaiGN4ItK26gTbOG/SkPmOXa
	rBFjpcsZKcy3wmwTEQYj2Edk9nnpUV3RlXrMPjRy7msfC0IOuDa8SLSXz2+U5gLy
	xVMDH0cQaMxxsjIaq8T48DRGAeLf0fUlOPqk5pAFaS8+cKJ6fdcbkyjAynpSpK4A
	xTvQN5muTEeQUqrJ9/jRuIkjCv5RgJU8EHlsIa1zIZAvbilbdJH/TDwUoqMIdGUC
	F22ugurptqNov3htkFp5z58n9KH8lFloBFd9+LeuAii+vFWA1cDXmJ/IR236BZ3K
	WAntET/Uug==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 45svekhhmr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 11:04:22 -0700 (PDT)
Received: from twshared29376.33.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 3 Apr 2025 18:04:20 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id DDC7624E755C1; Thu,  3 Apr 2025 11:04:14 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: Reseting pending fanotify events
Date: Thu, 3 Apr 2025 11:04:05 -0700
Message-ID: <20250403180405.1326087-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxi6PvAcT1vL0d0e+7YjvkfU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.com>
References: <CAOQ4uxi6PvAcT1vL0d0e+7YjvkfU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fZQDq_E2E0hrQiA7kXszt46RSqQYdxkp
X-Proofpoint-ORIG-GUID: fZQDq_E2E0hrQiA7kXszt46RSqQYdxkp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_08,2025-04-03_03,2024-11-22_01

> Let me list a few approaches to this problem that were floated in the p=
ast.
> You may choose bits and parts that you find useful to your use case.

Thanks for sharing these approaches for smoothly recovering pending event=
s.

> 3. Change the default response to pending events on group fd close
> Support writing a response with
> .fd =3D FAN_NOFD
> .response =3D FAN_DENY | FAN_DEFAULT
> to set a group parameter fanotify_data.default_response.

> Instead of setting pending events response to FAN_ALLOW,
> could set it to FAN_DENY, or to descriptive error like
> FAN_DENY(ECONNRESET).


I think that the approach of customizing group close behavior would likel=
y
address the problem of pending events in case of daemon restart / crash
encountered by our use case. It gives us the same guarantee of clearing
out pending event queue that we wanted while preventing any access of=20
unpopulated content. The one ask related to this approach would be around
the handover from old to new group fd. Would it be possible to provide an=
 easy
way to initialize one group from another (ie an fanotify_mark option).=20
In our case we have an interested mount as well as a set of ignore marks
for populated files to avoid regenerating events for.

The moderated mount functionality discussed in this thread would also be =
helpful
for better handling when the daemon is down.


