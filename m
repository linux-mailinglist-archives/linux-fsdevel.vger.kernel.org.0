Return-Path: <linux-fsdevel+bounces-53425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 607DBAEEFB2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 09:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DB11BC5562
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 07:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECCB258CD0;
	Tue,  1 Jul 2025 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OsGIA/8K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4043A1E7660
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 07:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751354590; cv=none; b=jm62GkJGxJvRJPt6lVjAyaNneAtJm+Jve0bFZzw+jVmX/A+DCfI0Dg7VM3bXk9Y1alhmkHyrc0YSVKfBkpqubbodhIfkqw2nYmQZ/7fPzT38q4SMOl5dZtFBsPCUAmYzAOknSFYtTPOogOQ8V5D4V3XdQOiqoNphvOOdO0g3Uio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751354590; c=relaxed/simple;
	bh=iq16FlMvtSEJCOXZdoHCmJ5unxl2Fu9NEJi8jMGWn5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxZbWLUXHS0tQxFNeRJEp3EgACT/v6J1S+LvGaDcCcM4XBsesqyIef5NsnNqiyhrz2ZMqsYGsAdCkijOnGCPbOzV+sudRZnFGUBLopSneF7sXhIiONy1sBXBVv6bjDUGwUYHuQWMuUWWPx/wJ8Tgc+JbQKB++S1y6xcI1Y9SQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OsGIA/8K; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5615cSsP003785
	for <linux-fsdevel@vger.kernel.org>; Tue, 1 Jul 2025 00:23:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=iq16FlMvtSEJCOXZdoHCmJ5unxl2Fu9NEJi8jMGWn5U=; b=OsGIA/8KY1Su
	s13dcZkOXOVt8wDObge14vqPr8byOhEf+YsrFM9HVI2xXMEe0w3tdESWqC+7BcKj
	TKdvSQbwWXp58xHfIjq0r8yvC2J2Nwhiwg3ENBn2m2EPc02u3FJuJcOZ1YzFW/G6
	Ojr/iaY4pxpn/sfnGRPjLp9hypMKeqT8AsU7nA1SgupjXVn8C9WDIJQKFGTPctnT
	Hz6msD1T7cJKNvn19zxhL9X5424iBnYed6YEwc+swVej5AHMZ08d1X4dxaC9vWC1
	VwoyjSeO14T2+o05ug/QxIk3UOt7ZLuoVINwieRcjuGbFh14Tql/lqqCytAeexAo
	woc6iIv08Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47m8e88rf0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jul 2025 00:23:08 -0700 (PDT)
Received: from twshared32712.16.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Tue, 1 Jul 2025 07:23:07 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id D766831139190; Tue,  1 Jul 2025 00:22:58 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: [PATCH] fanotify: introduce unique event identifier
Date: Tue, 1 Jul 2025 00:22:02 -0700
Message-ID: <20250701072209.1549495-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxi8xjfhKLc7T0WGjOmtO4wRQT6b5MLUdaST2KE01BsKBg@mail.gmail.com>
References: <CAOQ4uxi8xjfhKLc7T0WGjOmtO4wRQT6b5MLUdaST2KE01BsKBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Authority-Analysis: v=2.4 cv=B5S50PtM c=1 sm=1 tr=0 ts=68638cdc cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=qf4gfuq51q0A:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=1lCT7ja5Qxs9gSApSOQA:9 a=k40Crp0UdiQA:10
X-Proofpoint-GUID: hfDmAYz5G5hCR5ZZh46HVmSs3wRuuSCa
X-Proofpoint-ORIG-GUID: hfDmAYz5G5hCR5ZZh46HVmSs3wRuuSCa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0MSBTYWx0ZWRfX2m6hfq6NOml9 5k9rbYc5lh8okOhcNq6sqqgF3zNzsJcfcJ/G1xZmeYVlwLp6q4iHiMO3gI9JmSPugZiG6Bac6OQ CQJKOLkYPaUmXrjUTX4GSJBMVXlJeBeC25qLyPIZ+8ekpO81voyK3V73t448p+/GiWteGsLXJ6o
 FAI6muVnU1EGPdKk43xVBiPCokOfZ/AgmDCCUctIyQGdBX+mJIdoVovwEpWURB0InzS6vEug8b+ WA3YrSgcIFwViiIVy0x4iLIC9q0RbpWqjPR0JNSxlJQSao0k+SqoMgK/mnrp30kuvQ4erIgWESt UGclpJYDfW/wUr7f8vAp1wSy0u9Acn2mFeIwR8Fnqmej9TMAAeybANt1baNdlFe9zTsr4MygDZw
 KGcUxPTTRjUh9kroStRT4JY5t69NmSHw5HvgXwPz40ggqRdU8EcE0/oDGT7RYhA9HnDQMgc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01

On 6/30/25, 9:06 AM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir73i=
l@gmail.com>> wrote:
> On Mon, Jun 30, 2025 at 4:50=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > Hi!
> >
> > I agree expanding fanotify_event_metadata painful. After all that's t=
he
> > reason why we've invented the additional info records in the first pl=
ace :).
> > So I agree with putting the id either in a separate info record or ov=
erload
> > something in fanotify_event_metadata.
> >
> > On Sun 29-06-25 08:50:05, Amir Goldstein wrote:
> > > I may have mentioned this before, but I'll bring it up again.
> > > If we want to overload event->fd with response id I would consider
> > > allocating response_id with idr_alloc_cyclic() that starts at 256
> > > and then set event->fd =3D -response_id.
> > > We want to skip the range -1..-255 because it is used to report
> > > fd open errors with FAN_REPORT_FD_ERROR.
> >
> > I kind of like this. It looks elegant. The only reason I'm hesitating=
 is
> > that as you mentioned with persistent notifications we'll likely need
> > 64-bit type for identifying event. But OTOH requirements there are un=
clear
> > and I can imagine even userspace assigning the ID. In the worst case =
we
> > could add info record for this persistent event id.
>
> Yes, those persistent id's are inherently different from the response k=
ey,
> so I am not really worried about duplicity.
>
> > So ok, let's do it as you suggest.
>
> Cool.
>
> I don't think that we even need an explicit FAN_REPORT_EVENT_ID,
> because it is enough to say that (fid_mode !=3D 0) always means that
> event->fd cannot be >=3D 0 (like it does today), but with pre-content e=
vents
> event->fd can be a key < -255?
>
> Ibrahim,
>
> Feel free to post the patches from my branch, if you want
> post the event->fd =3D -response_id implementation.
>
> I also plan to post them myself when I complete the pre-dir-content pat=
ches.

Sounds good. I will pull in the FAN_CLASS_PRE_CONTENT | FAN_REPORT_FID br=
anch
and resubmit this patch now that we have consensus on the approach here.

