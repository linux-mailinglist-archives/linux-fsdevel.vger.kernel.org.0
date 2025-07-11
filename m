Return-Path: <linux-fsdevel+bounces-54732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB222B026FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 00:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247924A1A38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 22:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C25221727;
	Fri, 11 Jul 2025 22:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ay/vhh9B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EECF1FAC34
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752273447; cv=none; b=fWLXwVrNx9j9TVXk7npgdixlASvdJekF6AFNnO+inJAIFi4OBvva4nYXOYy97atyxdPKPExJyrrUXMx8ZXIVjlL2jlOLjrFHfK9TwI+Rgl4TUi3kuaGQYc5j4V0TfVC46+r9Nm0M2lYlBfsWaI2fWyJmXvkUZ2NG9+Jew94DduE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752273447; c=relaxed/simple;
	bh=Xy/Amhs/OKSdS4n5t6dosvNLorPu6VmxyoxPVu555Eo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZqtxOzQG4crOir2gLnr0ED7DYSTqo45UQ++q56Xv+Xa1dK7PZ7zjWo/sW4/7C70CyYO0xLnyVBq/5l6oHZA94uO2HBCGiRobWraRnRMnLE7j3J4vPMJ6yFHkl4K2oEUoz9/GPXAG7oU0FHUBsweFng6NhTHdzhA1toQ7I72IPNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ay/vhh9B; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJiTVu001932
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 15:37:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tV5ug3vrr4YcNDsFZNiCLNI37C9HGaZj9SqdhJyhi4s=; b=ay/vhh9BFEAz
	19XvVQ033rIiqmJwa4YHP8/wXRR/VoLSz84zxnr97LKuAMzqoq4Gj9bk2n9c5Pmd
	KYAuSZoVt52MTc9ubXkKAcHE+zA3yaGDKaPSrqsdL4xRhtZx6Rxt4A84KlT1CjAl
	s2q1YOYS1cRR9lsbyrgteCx8k+r4VOGYIcidckGyfro3/xwguksrAPod8ZvXpLNq
	etupva3I9fhKYWBQInb6ykZ330fLzU/X33k/i9m4FfEgJxGCoPkwLmihqseJI0Qm
	evLT8MMnQRFWbMMi+2zQ9J0W6iYDqkBTD3MEz8ZDwka/ExJJ5KjAyahLMxlgJ1JU
	BHUyxe4Amw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47u8jb98hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 15:37:24 -0700 (PDT)
Received: from twshared11388.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 11 Jul 2025 22:37:23 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 4AADD3213E1D9; Fri, 11 Jul 2025 15:37:11 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: Re: [PATCH] fanotify: support custom default close response
Date: Fri, 11 Jul 2025 15:30:38 -0700
Message-ID: <20250711223041.1249535-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
References: <CAOQ4uxjd1tPFoV6CrsktJK8yr+ZMBptTMK-qH_+ADjiK7voYOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: Z03Xj-fF5FdsL_8oCoOcyamEWaxqyFwb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE3MSBTYWx0ZWRfX8KDqgN0nppej FczZ0juyeDnVg9qeU/Ttj4ZAedGZWaCk29VO0aVXLoX1q/VgkQ+BcNZDkUosbb1aZk/NVAM4rkV FodK+pmBwDzncnrP6H+R1akjcxMdKDTmqBGrgH4js6QoqUlFIdZW8l9PwjD2xD3m0Y2ao7DrZ90
 rtoK9EVoMV1Rm+2vGB1Er3wo0OFkyEluRVx5TLmvZSmRNlfcQqF2X0Ht6bzkmjuWdDREE5X5EEO CgRAibIl0i65b3rFgFOD33qWqNbYuxxH+eFM9vaj7GIwkim1dP2zLXdUZ5GZqlV+LAfpi8QiMlZ rOwpjnxH6rEIs2RL+QVHwlGxwMTMzGaa00IqHHpwKs8fJ3Vssmw06j6EOqIAaJpjfvOaZ4qFwGC
 rnopBiNIPub1IPcYjyaUjhfWpRFotMLUYu2w18RhZaamJiTJnHBXoZY4Pg9MmjDx7MwLboJB
X-Authority-Analysis: v=2.4 cv=JZC8rVKV c=1 sm=1 tr=0 ts=68719224 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=qf4gfuq51q0A:10 a=Wb1JkmetP80A:10 a=VabnemYjAAAA:8 a=4yWixSawVukRfqs7A0gA:9 a=k40Crp0UdiQA:10
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: Z03Xj-fF5FdsL_8oCoOcyamEWaxqyFwb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01

> On Thu, Jul 3, 2025 at 4:43=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 03-07-25 10:27:17, Amir Goldstein wrote:
> > > On Thu, Jul 3, 2025 at 9:10=E2=80=AFAM Ibrahim Jirdeh <ibrahimjirde=
h@meta.com> wrote:
> > > >
> > > > > On Wed, Jul 2, 2025 at 6:15=E2=80=AFPM Jan Kara <jack@suse.cz> =
wrote:
> > > > > > Eventually the new service starts and we are in the situation=
 I describe 3
> > > > > > paragraphs above about handling pending events.
> > > > > >
> > > > > > So if we'd implement resending of pending events after group =
closure, I
> > > > > > don't see how default response (at least in its current form)=
 would be
> > > > > > useful for anything.
> > > > > >
> > > > > > Why I like the proposal of resending pending events:
> > > > > > a) No spurious FAN_DENY errors in case of service crash
> > > > > > b) No need for new concept (and API) for default response, ju=
st a feature
> > > > > >    flag.
> > > > > > c) With additional ioctl to trigger resending pending events =
without group
> > > > > >    closure, the newly started service can simply reuse the
> > > > > >    same notification group (even in case of old service crash=
) thus
> > > > > >    inheriting all placed marks (which is something Ibrahim wo=
uld like to
> > > > > >    have).
> > > > >
> > > >
> > > > I'm also a fan of the approach of support for resending pending e=
vents. As
> > > > mentioned exposing this behavior as an ioctl and thereby removing=
 the need to
> > > > recreate fanotify group makes the usage a fair bit simpler for ou=
r case.
> > > >
> > > > One basic question I have (mainly for understanding), is if the F=
AN_RETRY flag is
> > > > set in the proposed patch, in the case where there is one existin=
g group being
> > > > closed (ie no handover setup), what would be the behavior for pen=
ding events?
> > > > Is it the same as now, events are allowed, just that they get res=
ent once?
> > >
> > > Yes, same as now.
> > > Instead of replying FAN_ALLOW, syscall is being restarted
> > > to check if a new watcher was added since this watcher took the eve=
nt.
> >
> > Yes, just it isn't the whole syscall that's restarted but only the
> > fsnotify() call.

I was trying out the resend patch Jan posted in this thread along with a
simple ioctl to trigger the resend flow - it worked well, any remaining
concerns with exposing this functionality? If not I could go ahead and
pull in Jan's change and post it with additional ioctl.

