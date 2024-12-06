Return-Path: <linux-fsdevel+bounces-36671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7459E78BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 20:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAC116C28A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 19:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837C614B08C;
	Fri,  6 Dec 2024 19:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiB43b6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776851B87C7
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512777; cv=none; b=gkHeEplQquILxoutWo00bdaC1dJNAa1t5rgCRMg26jfeJK3RA8oCLQA3yr6F0kmz/Ug2ev6pZrosZ8nARZpd125VIyY0R+xZpA9PzzOjTwXyp4fTpZpNuF6vJhefOtUdiJHLB6J0ra/o5s/XPO99cc8q780qYgA5egUDgjJucY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512777; c=relaxed/simple;
	bh=Gl6PRZG1UmDqWFkhG7tDL5cIYcs8yGpOIbYv2K7MY0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+hZGvwaBqbgrLrVQDPwM+/HLm0Z2yH9FJBoT7KaVdzzQcR49lEcyTWR9iGmhoDh9FAa2jPkhQkwmPv5n32JweqKGy81p/ct2qUPs0kAPFGBMGh6KkAXGQRAE68BUe2gPtD8uABkpl5CSe7NsNeVtqGsGvHL/KznNDzmsGoNTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiB43b6o; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4668f208f10so23017101cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733512774; x=1734117574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcaWpFkbosM3uvQRFlNMzkshocQnDyMTq5xQ78c2TDY=;
        b=MiB43b6oftZjorhR94IpB+eJg1Y80xhur0VkOXdxHHuaX2asJ5oIKtX/f2Z78y+aWC
         lJyizUk0sRhehdZyk4aSaD2oa94yPfVx1lcuIhg7M5a3WCHYu1UTniBXeQ98EhFR8T9P
         HTBmoOsLxTy01eonGm0GXYCtbI9U3Y+vLnZcPP/+cEqSI9Yaq4rkshCxPt6fqKBNabre
         bKgcdKl4xD+HjFFIixcIspU8MoOpsPuwqORemehPZGoLbs2HjXKv3X65RozNbLJd604A
         kxlpFGuoa7xzdU07K2rRKQ6lT/I5O3yU1AeeuG4RVVbKKJwUAQ4pKNGiZ5RmIDG3XULb
         /czA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512774; x=1734117574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcaWpFkbosM3uvQRFlNMzkshocQnDyMTq5xQ78c2TDY=;
        b=ckgqW//ChAT1cBPLZqwwEABMdegUFm9tx16RvJUmlhcpxyKCUY0X1IGwmkJn4B7bAB
         iAz3SavUISH24OA5XNxleQREusCj8T44c1rIZxmWRx8/idaQ+H1/UOKcnnjiPvHqcJ8L
         y+TmZ0aNSm2fU4cTDDpgg63jVKxKGEmvowORNo++TF6j9tmMn+tdjPa2mKEyXtBoVkO3
         IGSA7hRyOtuOvwczF5V6bVxwC6cmyDnORYoApMBH3MYwXLrh1r5CLyUjDvpkI7DiRQZu
         UcIU6zJCTlQ/TFg1nADcs3zjj0JoB28CYfSjuD2evatqmz6sI9PEybdyIf/MI9nW+lEO
         o/ig==
X-Forwarded-Encrypted: i=1; AJvYcCVTOyJxsz4rAauAUi/7f3xcJQAkTJxQJCZLpmqYgEDPG7N1Mn6oR3Gd+HuZ810VmDRo+oAjL739eWjBqfns@vger.kernel.org
X-Gm-Message-State: AOJu0YxVQKt0gdUhPV51d9zpo4GmxFkP6Xfe9gdJEj/VUnsIe0wU22Xd
	LB8IK94LtWj+kVjLlOEA7hjYP25PstEDWfYRPHg3CqUXstEAYyvvMoQFb8MaXB9rCYu1GkO/ise
	gct5tA3dS1nHkg0J4h5mi6l1VnQc=
X-Gm-Gg: ASbGncs2znxZlBJMPpwcH9+cnEBVDcwb7q1PU3d5F64v3PVR9A1/HCqhp7LOKd3/lW9
	rP+kSn3pR/LO9Utp/TH3rTuBF9HwTnFnDqcBRSWsQTf+CWJE=
X-Google-Smtp-Source: AGHT+IEjB58bQvhfn6xi5dBgMGejbH/djUCvByzF5Jsj8Lvn7Zj0zW0hSlsA4pVbve4p8pdn61YaE68l46NRz+uKDMs=
X-Received: by 2002:a05:622a:18a1:b0:466:a584:69f8 with SMTP id
 d75a77b69052e-46734dbc98amr76254291cf.43.1733512774327; Fri, 06 Dec 2024
 11:19:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com> <9741573f2fe44f9aae6de25842db288ddc7d38c3.camel@kernel.org>
In-Reply-To: <9741573f2fe44f9aae6de25842db288ddc7d38c3.camel@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Dec 2024 11:19:22 -0800
Message-ID: <CAJnrk1ZOQOVwcV+ee+MhBrXx-ORQtpm7-++yqMS=SmOx6VOjNw@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Jeff Layton <jlayton@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
	jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:37=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Thu, 2024-11-14 at 11:13 -0800, Joanne Koong wrote:
> > There are situations where fuse servers can become unresponsive or
> > stuck, for example if the server is deadlocked. Currently, there's no
> > good way to detect if a server is stuck and needs to be killed manually=
.
> >
> > This commit adds an option for enforcing a timeout (in minutes) for
> > requests where if the timeout elapses without the server responding to
> > the request, the connection will be automatically aborted.
> >
>
> I haven't been keeping up with the earlier series, but I think I agree
> with Sergey that this timeout would be better expressed in seconds.
>
> Most filesystems that deal with timeouts (NFS, CIFS, etc.) specify them
> as a number of seconds, and expressing this in minutes goes against
> that convention. It also seems rather coarse-grained. I could easily
> see a situation where 5 minutes is too short, but 6 minutes is too
> long.

Sounds good, I'll change the timeout to seconds. The reason it was set
in minutes is because the timeouts have an upper margin of error
(right now, up to 1 minute) and I didn't want to give a misleading
illusion of precision.

It sounds like it'd be useful if the timer is run more frequently (eg
instead of every 1 minute, maybe running this every 15 or 30 secs) as
well. I'll make this change in the next version.

>
> With that too, you probably wouldn't need patch #1. You could treat it
> as a 32-bit integer and just clamp the value as necessary.
>
> > Please note that these timeouts are not 100% precise. The request may
> > take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the requested max
> > timeout due to how it's internally implemented.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> > ---
> >  fs/fuse/dev.c    | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h | 21 +++++++++++++
> >  fs/fuse/inode.c  | 21 +++++++++++++
> >  3 files changed, 122 insertions(+)
> >
...
>
> --
> Jeff Layton <jlayton@kernel.org>

