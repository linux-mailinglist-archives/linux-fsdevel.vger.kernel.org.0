Return-Path: <linux-fsdevel+bounces-53116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE06AEA8AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 23:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173B53AD70F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 21:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B825E461;
	Thu, 26 Jun 2025 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hoPpChdy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33919D06A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972796; cv=none; b=gqZO/ZEA/pqhvVb/03kPpBKNpiIJbZc4aj5kJr/ygdqxo7mEgX6M1o0xdMSqgagLyCTi9aNkKgEu7yvXrOTiFoUJvmUjHoQ2bRaDETEd8xhc4xVTLI5C0MdxXqVUHI1IUq+LfAFF9ZMIYYODqcxRJ2JdUykspwL8XhuI/u7XcUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972796; c=relaxed/simple;
	bh=V6rrzflo7oZ2UClOluyg4pAscZ8UAKNRbMC5iw591oY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKUn6QGbsgaw7UkjVUiwfZiYkZ9UgemUQmq1mp0VkihUDE4GIlz0Aq4nvuohJfgeX574h0/X5KjAiei+cFeOuovHNfbLx2qhfhOQglGIznWLbUPNJzIBl4XDTSOdVsoBn+APrz33a2u695Z8m6z03ImjLdcsoB3ZAHllPQGrrFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hoPpChdy; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QL8wHQ018481
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 14:19:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=r8vieA86eTeaLpVkpovWq3yeVlFwooh4zjZyCCXeV8I=; b=hoPpChdyfsCW
	NbUEDrzTzFaYlj5M5bE3yW1DqMB693a494cfanyR6lJjrVVulLTBy2FEBqHvIPUf
	rFPD0BOeIt7BqATDBeAi7GqPisTRzqi48n/nPfw7NO5qXg+ZNzzXinQie0UKPX17
	Gbwh/g68AOQ4UWeTwEhoHGg/W10S5B9zeqRFM+s6aHONnD2k4eD8jqL+Ujl0mowG
	TjM686wX9eLqw78RwIbX9wiH3W8eHzhs468xOxifs+SEv6NmeVpgjPZXKWMU3vI9
	RNrURDg80CHJjIL3m4yDuh13/+wk8Ym5xWV657WbSGeX7MRHY2DJIvzKoR6988aa
	LVsHBN46Rg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47gextw3v4-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 14:19:53 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Thu, 26 Jun 2025 21:19:49 +0000
Received: by devvm18334.vll0.facebook.com (Postfix, from userid 202792)
	id 4BC1530A2A8A0; Thu, 26 Jun 2025 14:19:34 -0700 (PDT)
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
To: <amir73il@gmail.com>
CC: <ibrahimjirdeh@meta.com>, <jack@suse.cz>, <josef@toxicpanda.com>,
        <lesha@meta.com>, <linux-fsdevel@vger.kernel.org>, <sargun@meta.com>
Subject: [PATCH] fanotify: support custom default close response
Date: Thu, 26 Jun 2025 14:19:32 -0700
Message-ID: <20250626211932.2468910-1-ibrahimjirdeh@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAOQ4uxguBgMuUZqs0bT_cDyEX6465YkQkUHFPFE4tndys-y2Wg@mail.gmail.com>
References: <CAOQ4uxguBgMuUZqs0bT_cDyEX6465YkQkUHFPFE4tndys-y2Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=dLammPZb c=1 sm=1 tr=0 ts=685db979 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VabnemYjAAAA:8 a=E5pSYoxeBN610M9yIE0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: NFnx52dShLrZEafw2RTTPrFuNDTDvOXH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDE4MiBTYWx0ZWRfXzxPztE5lvJoE 69wHTobNMg8HEXTfjxew+U/ByVxZfZ8FFZKCL4nJ6qdJUTetZI19qwU5kX8CxQOEFOw/yR7i971 OFg/CWmx76JgtN7RPpjaI+5gqf8hx7AHfwsXObCbFc+EP4Dx6+lOYOBgicn6A8B8d4yqdH9DNvX
 QW1n5ljCp+8sh5uMgb/kT2mrzp5G2OUrKKCYgW2npUt3FkOKcxeVE4s5MWsUO48q4lwj7AcpGh/ sMNcPxQ0fiKTVxOdx2LroGzFaK3HAYN0oEH6R/BD09ENjKRDbpp2tnn5W+A7OwB22/uqSf17wgU FDBRp6ToZiLUMqLbmmmEdYVOlgZD50zE8KM0KZ/bBy9LxeXcel6O9qLgfk4sX8byp9TdeINzVKy
 Tn+E2ErJTwvnvEez6SbQG0Szp2I94STKx8L1kdt+DSm5mwNS6wmnyPKc2Z+2U6sfl/H/U1BO
X-Proofpoint-GUID: NFnx52dShLrZEafw2RTTPrFuNDTDvOXH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_06,2025-06-26_05,2025-03-28_01

> On 6/23/25, 11:32 PM, "Amir Goldstein" <amir73il@gmail.com <mailto:amir=
73il@gmail.com>> wrote:
> > On Mon, Jun 23, 2025 at 9:26 PM Ibrahim Jirdeh <ibrahimjirdeh@meta.co=
m> wrote:
> >
> > Currently the default response for pending events is FAN\_ALLOW.
> > This makes default close response configurable. The main goal
> > of these changes would be to provide better handling for pending
> > events for lazy file loading use cases which may back fanotify
> > events by a long-lived daemon. For earlier discussion see:
> > [https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6=
bi44canfsg2aajgkialt@c3ujlrjzkppr/](https://lore.kernel.org/linux-fsdevel=
/6za2mngeqslmqjg3icoubz37hbbxi6bi44canfsg2aajgkialt@c3ujlrjzkppr/)
>
> These lore links are typically placed at the commit message tail block
> if related to a suggestion you would typically use:
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: [https://lore.kernel.org/linux-fsdevel/CAOQ4uxi6PvAcT1vL0d0e+7Yjv=
kfU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.com/](https://lore.kernel.org/linux-=
fsdevel/CAOQ4uxi6PvAcT1vL0d0e+7YjvkfU-kwFVVMAN-tc-FKXe1wtSg@mail.gmail.co=
m/)
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
>
> This way reviewers whose response is "what a terrible idea!" can
> point their arrows at me instead of you ;)
>
> Note that this is a more accurate link to the message where the default
> response API was proposed, so readers won't need to sift through
> this long thread to find the reference.
>
> >
> > This implements the first approach outlined there of providing
> > configuration for response on group close. This is supported by
> > writing a response with
> > .fd =3D FAN\_NOFD
> > .response =3D FAN\_DENY | FAN\_DEFAULT
> > which modifies the group property default\_response
> >
> > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> > ---
> >  fs/notify/fanotify/fanotify\_user.c  | 14 ++++++++++++--
> >  include/linux/fanotify.h            |  2 +-
> >  include/linux/fsnotify\_backend.h    |  1 +
> >  include/uapi/linux/fanotify.h       |  1 +
> >  tools/include/uapi/linux/fanotify.h |  1 +
> >  5 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify\_user.c b/fs/notify/fanotify=
/fanotify\_user.c
> > index b192ee068a7a..02669abff4a5 100644
> > --- a/fs/notify/fanotify/fanotify\_user.c
> > +++ b/fs/notify/fanotify/fanotify\_user.c
> > @@ -378,6 +378,13 @@ static int process\_access\_response(struct fsno=
tify\_group \*group,
> >                 return -EINVAL;
> >         }
> >
> > +       if (response & FAN\_DEFAULT) {
> > +               if (fd !=3D FAN\_NOFD)
> > +                       return -EINVAL;
> >
> I think we also need to check that no bits other than the allowed bits
> for default response
> are set, for example, if user attempts to do:
>  .response =3D FAN\_DENY | FAN\_AUDIT | FAN\_DEFAULT
>
> But that opens up the question, do we want to also allow custom
> error in default response, e.g.:
>  .response =3D FAN\_DENY\_ERRNO(EAGAIN) | FAN\_DEFAULT
>
> Anyway, we do not have to implement custom default error from the
> start. It will complicate the implementation a bit, but as long as you =
deny
> setting the default response with unsupported flags, we can extend it l=
ater.

Sure I can update this to disallow unexpected bits when updating default =
response.
It does make sense to me to also support custom error in default response=
, I can
help with exending the feature either as a later part of this series, or =
as
future follow up. Also will update the links and commit tail block as you=
've
suggested.

> >
> > +               group->default\_response =3D response & FANOTIFY\_RES=
PONSE\_ACCESS;
> > +               return 0;
> > +       }
> > +
> >         if ((response & FAN\_AUDIT) && !FAN\_GROUP\_FLAG(group, FAN\_=
ENABLE\_AUDIT))
> >                 return -EINVAL;
> >
> > @@ -1023,7 +1030,8 @@ static int fanotify\_release(struct inode \*ign=
ored, struct file \*file)
> >                 event =3D list\_first\_entry(&group->fanotify\_data.a=
ccess\_list,
> >                                 struct fanotify\_perm\_event, fae.fse=
.list);
> >                 list\_del\_init(&event->fae.fse.list);
> > -               finish\_permission\_event(group, event, FAN\_ALLOW, N=
ULL);
> > +               finish\_permission\_event(group, event,
> > +                               group->default\_response, NULL);
> >                 spin\_lock(&group->notification\_lock);
> >         }
> >
> > @@ -1040,7 +1048,7 @@ static int fanotify\_release(struct inode \*ign=
ored, struct file \*file)
> >                         fsnotify\_destroy\_event(group, fsn\_event);
> >                 } else {
> >                         finish\_permission\_event(group, FANOTIFY\_PE=
RM(event),
> > -                                               FAN\_ALLOW, NULL);
> > +                                               group->default\_respo=
nse, NULL);
> >                 }
> >                 spin\_lock(&group->notification\_lock);
> >         }
> > @@ -1640,6 +1648,8 @@ SYSCALL\_DEFINE2(fanotify\_init, unsigned int, =
flags, unsigned int, event\_f\_flags)
> >                 goto out\_destroy\_group;
> >         }
> >
> > +       group->default\_response =3D FAN\_ALLOW;
> > +
> >         BUILD\_BUG\_ON(!(FANOTIFY\_ADMIN\_INIT\_FLAGS & FAN\_UNLIMITE=
D\_QUEUE));
> >         if (flags & FAN\_UNLIMITED\_QUEUE) {
> >                 group->max\_events =3D UINT\_MAX;
> > diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> > index 879cff5eccd4..182fc574b848 100644
> > --- a/include/linux/fanotify.h
> > +++ b/include/linux/fanotify.h
> > @@ -134,7 +134,7 @@
> >
> >  /\* These masks check for invalid bits in permission responses. \*/
> >  #define FANOTIFY\_RESPONSE\_ACCESS (FAN\_ALLOW | FAN\_DENY)
> > -#define FANOTIFY\_RESPONSE\_FLAGS (FAN\_AUDIT | FAN\_INFO)
> > +#define FANOTIFY\_RESPONSE\_FLAGS (FAN\_AUDIT | FAN\_INFO | FAN\_DEF=
AULT)
> >  #define FANOTIFY\_RESPONSE\_VALID\_MASK \\
> >         (FANOTIFY\_RESPONSE\_ACCESS | FANOTIFY\_RESPONSE\_FLAGS | \\
> >          (FAN\_ERRNO\_MASK << FAN\_ERRNO\_SHIFT))
> > diff --git a/include/linux/fsnotify\_backend.h b/include/linux/fsnoti=
fy\_backend.h
> > index d4034ddaf392..9683396acda6 100644
> > --- a/include/linux/fsnotify\_backend.h
> > +++ b/include/linux/fsnotify\_backend.h
> > @@ -231,6 +231,7 @@ struct fsnotify\_group {
> >         unsigned int max\_events;                /\* maximum events a=
llowed on the list \*/
> >         enum fsnotify\_group\_prio priority;      /\* priority for se=
nding events \*/
> >         bool shutdown;          /\* group is being shut down, don't q=
ueue more events \*/
> > +       unsigned int default\_response; /\* default response sent on =
group close \*/
> >
> >  #define FSNOTIFY\_GROUP\_USER    0x01 /\* user allocated group \*/
> >  #define FSNOTIFY\_GROUP\_DUPS    0x02 /\* allow multiple marks per o=
bject \*/
> > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanot=
ify.h
> > index e710967c7c26..7badde273a66 100644
> > --- a/include/uapi/linux/fanotify.h
> > +++ b/include/uapi/linux/fanotify.h
> > @@ -254,6 +254,7 @@ struct fanotify\_response\_info\_audit\_rule {
> >
> >  #define FAN\_AUDIT      0x10    /\* Bitmask to create audit record f=
or result \*/
> >  #define FAN\_INFO       0x20    /\* Bitmask to indicate additional i=
nformation \*/
> > +#define FAN\_DEFAULT    0x30    /\* Bitmask to set default response =
on close \*/
> >
> >  /\* No fd set in event \*/
> >  #define FAN\_NOFD       -1
> > diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi=
/linux/fanotify.h
> > index e710967c7c26..7badde273a66 100644
> > --- a/tools/include/uapi/linux/fanotify.h
> > +++ b/tools/include/uapi/linux/fanotify.h
> > @@ -254,6 +254,7 @@ struct fanotify\_response\_info\_audit\_rule {
> >
> >  #define FAN\_AUDIT      0x10    /\* Bitmask to create audit record f=
or result \*/
> >  #define FAN\_INFO       0x20    /\* Bitmask to indicate additional i=
nformation \*/
> > +#define FAN\_DEFAULT    0x30    /\* Bitmask to set default response =
on close \*/
> >
> >  /\* No fd set in event \*/
> >  #define FAN\_NOFD       -1
> > --
> > 2.47.1

