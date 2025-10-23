Return-Path: <linux-fsdevel+bounces-65337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5008BC02263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 17:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C5C3AC09F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0230334C36;
	Thu, 23 Oct 2025 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTw+GIcZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C5432E754
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233425; cv=none; b=dHGagY4PddLzjecepnM1IT8htdgpxaN0dLEyshNVq1GgKbhnn1ZISDrY9ccHXB1zo9ZxtcH57zNLLAotDNMlbMXQ1/rx6Jv7EVXhN1EozOi+8xwp6Cwb6/e4BwAkOosn5GPZIszASTpk2SNdNIhqzQMJiAVAb/3laFw9l4MVulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233425; c=relaxed/simple;
	bh=R1DLxxQVstkHMMSgFPTDNmcwPzVc+mL9pMgA1atSRTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2dZwxcpYqqkawIl6F5C5dX9ECltKfvI+BRUURMu34BhMAZg0TfszD4jmcjd6CiaIkaAiJx/WtswbAEPzOZtGI9ZTQBHUkFu0+3c12iKFDwOLnufUj5/v9OKycHiygM6voUnbF3gqIfkTHD2MRLtGREwsZ0b7akGyzRUojZqZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTw+GIcZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c0c9a408aso1606838a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761233421; x=1761838221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R1DLxxQVstkHMMSgFPTDNmcwPzVc+mL9pMgA1atSRTY=;
        b=kTw+GIcZhEL2diW5z0Li/nBofxVJzu+wDe/HyQv38Prs0czRRQbP31hXyXmFpx0fVx
         wYsQr6DLDrsfaq46Jic6fuIHOS3PxVkKVrjCUazBCfMoGgyOWZcfWA5GyTGv4YixfCGj
         Oroecz/61rX5CoF5FrLSUm3BEhGkzK0cUyCqjG5sspmSxZmZt/qRdchRiPPfJaoMJ14I
         QIaLYcbeZPbTN9GLRvrTTH0aSxvzukKcSl5YFQaoUhjlGSJGDt4b6dEH0NoWfpUz4/FQ
         IywhPT/WzTk6TPELckQ2ijgK/yOIbrzbio4JmEXQeFa6Pd09CXaUq8Z3qL4iq8vlUbCR
         i54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761233422; x=1761838222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1DLxxQVstkHMMSgFPTDNmcwPzVc+mL9pMgA1atSRTY=;
        b=EJ7XOaKJaaS7wPTozUURvSgHQhesvsKAqBBad0qLIKZNCrfGvL+ZnZKb4pqplvzHW/
         ZLOHlddNQdTFLsl5/68YNP600TOXJri2LszgxidT+t7/9PZ+aWfbj30IIkJFmwSH0/+B
         TFOCsw9iilZ9MrQqz5yP5yOUa7tGY/L4MHA16E9sIVbA/Oo408PyewOayX1x0LRiNpgK
         VmJukwJa9f1m0CU09huyljYYpSBKxOzLfl8UfR5gUv8vSKel7zvQDrSt7h0bE9AFER/7
         nGHMX2FGVT2Ua3YIv++iZIorat4fpC7wDYC3imBiW4lDahxeaTeLcC4vBoSzVkQgqlI9
         i96Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0L7a0Kjr8oNu/oILV/Cz2UWEVPp8SU0ibueJdr8bp3PzVr/TGGWa/ZChDt9mhXSSDHiFNOT3RXstB4W6r@vger.kernel.org
X-Gm-Message-State: AOJu0YxsnqGRu3pmyKvzEcXrOyD2+2H7PA1GdZFcn41SAaSjzasr4j1e
	2EN22LDdEW5mjwnqfFrLvmramTjRXNUijJux5hM2wiXmFlq2emVfA1T3J7NFUfFPTKe9NGcVV9e
	tVVvfm19n0v2LAn5fQE3edhdGXwnrW3s=
X-Gm-Gg: ASbGncsOxSSda7OUpsI8++LrHloMhIObKOd+9I88cngbfrFqEANiMGl5eWxSLrXG8u9
	TWzbaK8o9siYOmZwSM4Iz+iwef67hkhuVB9tfkT4/OatHZZEEoQ/UY9BrgKfVrQVbgtTtk49I1v
	IbH1C86p9r9KFRSuExeOSqz4JoEqAPIl70GKlGULQwdtcXqMTadFny871sm6R6DkHsQmjYaLpcu
	mYZxC3K33ty2SGmJeKsO0MxNWZ34Kzh+d2d3d2djYMng3KdSlG/ocj18cMX4MnTCso/seamIIIg
	5o2Y5WqPKWG+VaZ9uWM=
X-Google-Smtp-Source: AGHT+IGeg4VShtIIbMZDn43Tom+FCrQ/WOrg0eWdTj7Vv7kLxp9SIc+Im9ri1X7/944ylkzI7ZpCmF9a14W06dA2vLw=
X-Received: by 2002:a05:6402:5cb:b0:639:fca4:c471 with SMTP id
 4fb4d7f45d1cf-63c1f6e04eemr24527060a12.28.1761233421236; Thu, 23 Oct 2025
 08:30:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916133437.713064-1-ekffu200098@gmail.com>
 <20250916133437.713064-3-ekffu200098@gmail.com> <CABFDxMFtZKSr5KbqcGQzJWYwT5URUYeuEHJ1a_jDUQPO-OKVGg@mail.gmail.com>
 <CAOQ4uxgEL=gOpSaSAV_+U=a3W5U5_Uq2Sk4agQhUpL4jHMMQ9w@mail.gmail.com>
 <CABFDxMG8uLaedhFuWHLAqW75a=TFfVEHkm08uwy76B7w9xbr=w@mail.gmail.com>
 <CAOQ4uxj9BAz6ibV3i57wgZ5ZNY9mvow=6-iJJ7b4pZn4mpgF7A@mail.gmail.com> <CABFDxMFRhKNENWyqh3Yraq_vDh0P=KxuXA9RcuVPX4FUnhKqGw@mail.gmail.com>
In-Reply-To: <CABFDxMFRhKNENWyqh3Yraq_vDh0P=KxuXA9RcuVPX4FUnhKqGw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 23 Oct 2025 17:30:10 +0200
X-Gm-Features: AS18NWD7qJ545TV4uDRrLbxUlzGi9tt1Qfmxci_lB1sZ8ABllrsSvhU5Z_9KIB8
Message-ID: <CAOQ4uxjxG7KCwsHYv3Oi+t1pwjLS8jUoiAroXtzTatu3+11CWg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] smb: client: add directory change tracking via
 SMB2 Change Notify
To: Sang-Heon Jeon <ekffu200098@gmail.com>, Jan Kara <jack@suse.cz>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	linux-cifs@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Stef Bon <stefbon@gmail.com>, Ioannis Angelakopoulos <iangelak@redhat.com>
Content-Type: text/plain; charset="UTF-8"

...
> > > Hello, Amir
> > >
> > > > First feedback (value):
> > > > -----------------------------
> > > > This looks very useful. this feature has been requested and
> > > > attempted several times in the past (see links below), so if you are
> > > > willing to incorporate feedback, I hope you will reach further than those
> > > > past attempts and I will certainly do my best to help you with that.
> > >
> > > Thanks for your kind comment. I'm really glad to hear that.
> > >
> > > > Second feedback (reviewers):
> > > > ----------------------------------------
> > > > I was very surprised that your patch doesn't touch any vfs code
> > > > (more on that on design feedback), but this is not an SMB-contained
> > > > change at all.
> > >
> > > I agree with your last comment. I think it might not be easy;
> > > honestly, I may know less than
> > > Ioannis or Vivek; but I'm fully committed to giving it a try, no
> > > matter the challenge.
> > >
> > > > Your patch touches the guts of the fsnotify subsystem (in a wrong way).
> > > > For the next posting please consult the MAINTAINERS entry
> > > > of the fsnotify subsystem for reviewers and list to CC (now added).
> > >
> > > I see. I'll keep it in my mind.
> > >
> > > > Third feedback (design):
> > > > --------------------------------
> > > > The design choice of polling i_fsnotify_mask on readdir()
> > > > is quite odd and it is not clear to me why it makes sense.
> > > > Previous discussions suggested to have a filesystem method
> > > > to update when applications setup a watch on a directory [1].
> > > > Another prior feedback was that the API should allow a clear
> > > > distinction between the REMOTE notifications and the LOCAL
> > > > notifications [2][3].
> > >
> > > Current design choice is a workaround for setting an appropriate add
> > > watch point (as well as remove). I don't want to stick to the RFC
> > > design. Also, The point that I considered important is similar to
> > > Ioannis' one: compatible with existing applications.
> > >
> > > > IMO it would be better to finalize the design before working on the
> > > > code, but that's up to you.
> > >
> > > I agree, although it's quite hard to create a perfect blueprint, but
> > > it might be better to draw to some extent.
> > >
> > > Based on my current understanding, I think we need to do the following things.
> > > - design more compatible and general fsnotify API for all network fs;
> > > should process LOCAL and REMOTE both smoothly.
> > > - expand inotify (if needed, fanotify both) flow with new fsnotify API
> > > - replace SMB2 change_notify start/end point to new API
> > >
> >
> > Yap, that's about it.
> > All the rest is the details...
> >
> > > Let me know if I missed or misunderstood something. And also please
> > > give me some time to read attached threads more deeply and clean up my
> > > thoughts and questions.
> > >
> >
> > Take your time.
> > It's good to understand the concerns of previous attempts to
> > avoid hitting the same roadblocks.
>
> Good to see you again!
>
> I read and try to understand previous discussions that you attached. I
> would like to ask for your opinion about my current step.
> I considered different places for new fsnotify API. I came to the same
> conclusion that you already suggested to Inoannis [1]
> After adding new API to `struct super_operations`, I tried to find the
> right place for API calls that would not break existing systems and
> have compatibility with inotify and fanotify.
>
> From my current perspective, I think the outside of fsnotify (like
> inotify_user.c/fanotify_user.c) is a better place to call new API.
> Also, it might lead some duplicate code with inotify and fanotify, but
> it seems difficult to create one unified logic that covers both
> inotify and fanotify.


Personally, I don't mind duplicating this call in the inotify and
fanotify backends.
Not sure if this feature is relevant to other backends like nfsd and audit.

I do care about making this feature opt-in, which goes a bit against your
requirement that existing applications will get the REMOTE notifications
without opting in for them and without the notifications being clearly marked
as REMOTE notifications.

If you do not make this feature opt-in (e.g. by fanotify flag FAN_MARK_REMOTE)
then it's a change of behavior that could be desired to some and surprising to
others.

Also when performing an operation on the local smb client (e.g. unlink)
you would get two notifications, one the LOCAL and one the REMOTE,
not being able to distinguish between them or request just one of them
is going to be confusing.

> With this approach, we could start inotify first
> and then fanotify second that Inoannis and Vivek already attempted.
> Even if unified logic is possible, I don't think it is not difficult
> to merge and move them into inside of fsnotify (like mark.c)
>

For all the reasons above I would prefer to support fanotify first
(with opt-in flag) and not support inotify at all, but if you want to
support inotify, better have some method to opt-in at least.
Could be a global inotify kob for all I care, as long as the default
does not take anyone by surprise.

> Also, I have concerns when to call the new API. I think after updating
> the mark is a good moment to call API if we decide to ignore errors
> from new API; now, to me, it is affordable in terms of minimizing side
> effect and lower risk with user spaces. However, eventually, I believe
> the user should be able to decide whether to ignore the error or not
> of new API, maybe by config or flag else. In that case, we need to
> rollback update of fsnotify when new API fails. but it is not
> supported yet. Could you share your thoughts on this, too?
>

If you update remote mask with explicit FAN_MARK_REMOTE
and update local mask without FAN_MARK_REMOTE, then
there is no problem is there?

Either FAN_MARK_REMOTE succeeded or not.
If it did, remote fs could be expected to generate remote events.

> If my inspection is wrong or you might have better idea, please let me
> know about it. TBH, understanding new things is hard, but it's also a
> happy moment to me.
>

I am relying on what I think you mean, but I may misunderstand you
because you did not sketch any code samples, so I don't believe
I fully understand all your concerns and ideas.

Even an untested patch could help me understand if we are on the same page.

Thanks,
Amir.

