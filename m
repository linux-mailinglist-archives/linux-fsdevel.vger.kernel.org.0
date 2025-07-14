Return-Path: <linux-fsdevel+bounces-54806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4480B03780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F18118977EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D5622F772;
	Mon, 14 Jul 2025 07:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="dst9lwGT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1B226D10
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476549; cv=none; b=ZDGqGGEzqzmLtsLY85mjMTraraR/AiIX65/gD3lWawllXcIO6R7MhXqjwEyu6tNy9Z0Skb7ceW7WbTzr1KsDZsxIkhUtbXi36uXL83MKrPMWkuykHTSRAmXJNy/7huWzuXo2AA9CfA9GKzM71ONE6xiLx/OkRAA8s31cthA2mPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476549; c=relaxed/simple;
	bh=lNtkY3NYXX1v8HrdAoHSY6DeBH3W8OxJaFIqU7hY0x8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Giv6skSaOmRg4J1kWyvXw0+RrgCHh1imgxLwMNImft9jNlHS/8HLuOC/rZfAl70ACuc5EcmY5E4sBbbq3goDrlh+lTCuXBmeebieuokiyA6VAFeaAu5G3Y6/VgN0QVOGVkZVF9N5iRlytWDJUzIDap2cDZaTe8FVttQ3FqOOihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=dst9lwGT; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56DMO1nN011347
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 00:02:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=lNtkY3NYXX1v8HrdAoHSY6DeBH3W8OxJaFIqU7hY0x8=; b=dst9lwGTOo0m
	P7EKU1k0Vn7VLk+UbiOr2nobzWcgXjJzkH8n3Gm8pCwhrNrjwr6jjLhYdKYNfoZm
	Yw2cv1Bbef2qR3bX3CR7Xty9aw6A9tkCWPyuTuP74ptVXt+703zM1C/huZk993ot
	z1nrCMml2ElXH2eRJIvjy4nh2rIVm9/aX07Sxx4pYerf8mT9KY/zECh4mZwrWZFA
	xLDh1F4q2JxYOq3Ce6MglKvxr+9a/EQjpXelLXjaSkhq8/UfYGgoLvbiHIj+K+bd
	fabcIfV8UZLAi7Px62VU9ikDYdb9caYU616WuZe1z3SsFhbf1SXkGLIdbzQdsnLP
	cBpicg1AYg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47vnj5sr4m-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 00:02:26 -0700 (PDT)
Received: from twshared11388.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 14 Jul 2025 07:02:25 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 4BF39323B0244; Mon, 14 Jul 2025 00:02:21 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: [PATCH] fanotify: support custom default close response
Date: Mon, 14 Jul 2025 00:01:13 -0700
Message-ID: <20250714070113.1690928-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
References: <CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=qL6=_2_QGi8MqTHv5ZN7Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA0MCBTYWx0ZWRfX/RyIial2+ItC o0S1i/l9BAwGgepfvADJyiWiqZwvu3/fqsZZiT27pBcrbGPeW18ok7e5TWKkrvWABjiU9WPAj41 5cwbkybGzgVfCnE7RxTcyAKP/KcjPIpcZA7RLnOCEs2eAEqplY4p70w/BJvhmHcLZIPViBuWyrg
 oVUTiSXGHF3W7cZPrfCKthze9eEVJzEOL3/y4QYhmoNZaUh/Jm6gj2cF2/Tt8vOiIej21CzfyRd u0H8jF5kxXBv6gGTfif25rYG0BdGpjrlpdQPwXttPMX0yFN8t2VAwk4KrF/oo4D34ARHLVX1lo/ GyvBi9t5LCDjaTJTSGJwCXKqf8U/RCjFlTvX7bE/Qfat3AXUpHMotqXx/XfjKDW/93kjLofle7i
 i6+yNTnb+cfkVFkpHyVgJl0QoJSdYGnbza1XL66MZURrQkq5YL2Vl5KRL+vumzogBbQVEE2+
X-Authority-Analysis: v=2.4 cv=RtnFLDmK c=1 sm=1 tr=0 ts=6874ab82 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=W3ChRxnkwNDwZ3SZYBYA:9
X-Proofpoint-GUID: gPSF-98tIehK30vUxlLS5fyZVejT1qyi
X-Proofpoint-ORIG-GUID: gPSF-98tIehK30vUxlLS5fyZVejT1qyi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01

On 7/12/25, 1:08 AM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73i=
l@gmail.com>> wrote:

> Regarding the ioctl, it occured to me that it may be a foot gun.
> Once the new group interrupts all the in-flight events,
> if due to a userland bug, this is done without full collaboration
> with old group, there could be nasty races of both old and new
> groups responding to the same event, and with recyclable
> ida response ids that could cause a real mess.

Makes sense. I had only considered an "ideal" usage where the resend
ioctl is synchronized. Sounds reasonable to provide stronger guarantees
within the surfaced api.

> If we implement the control-fd/queue-fd design, we would
> not have this problem.
> The ioctl to open an event-queue-fd would fail it a queue
> handler fd is already open.

I had a few questions around the control-fd/queue-fd api you outlined.
Most basically, in the new design, do we now only allow reading events /
writing responses through the issued queue-fd.

> The control fd API means that when a *queue* fd is released,
> events remain in pending state until a new queue fd is opened
> and can also imply the retry unanswered behavior,
> when the *control* fd is released.

It may match what you are saying, but is it safe to simply trigger the
retry unanswered flow for pending events (events that are read but not
answered) on queue fd release. And similarly the control fd release would
just match the current release flow of allowing / resending all queued
events + destroying group.

And in terms of api usage does something like the following look
reasonable for the handover:

- Control fd is still kept in fd store just like current setup
- Queue fd is not. This way on daemon restart/crash we will always resend
any pending events via the queue fd release
- On daemon startup always call ioctl to reissue a new queue fd

> Because I do not see an immediate use case for
> FAN_REPORT_RESPONSE_ID without handover,
> I would start by only allowing them together and consider relaxing
> later if such a use case is found.
>
> I will even consider taking this further and start with
> FAN_CLASS_PRE_CONTENT_FID requiring
> both the new feature flags.

The feature dependence sounds reasonable to me. We will need both
FAN_REPORT_RESPONSE_ID and retry behavior + something like proposed
control fd api to robustly handle pending events.

> Am I missing anything about meta use cases
> or the risks in the resend pending events ioctl?

I don't think theres any other complications related to pending events in
our use case. And based on my understanding of the api you proposed, it
should address our case well. I can just briefly mention why its desirabl=
e
to have some mechanism to trigger resend while still using the same
group, I might have added this in a previous discussion. Apart from
interested (mounts of) directories, we are also adding ignore marks for
all populated files. So we would need to recreate this state if just
relying on retry behavior triggering on group close. Its doable on the
use case side but probably a bit tricky versus being able to continue
to use the existing group which has proper state.

