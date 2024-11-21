Return-Path: <linux-fsdevel+bounces-35433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E86209D4C03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FC39B287D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2E51D12E0;
	Thu, 21 Nov 2024 11:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM4GeqoG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64584288CC;
	Thu, 21 Nov 2024 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188769; cv=none; b=kLJEj8dx4iDkxxvKzyeIl887no8pYAe4tJ1+BaVvIZglVHZD4jo4tasMHLHxFNK9REpTQJuQB8mXC0W3gNxEYJo3AOVUp632eSneHS9brPjedjQPrZ5c3JjtYIexETVhS9bF6QhziZBOuM3oM34VgHEvKIIFYO98NuzV4xeoWHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188769; c=relaxed/simple;
	bh=+C2u1RJ8J8jIncpy4qBwn5GHjbzbd2il+pTYsEae3tM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UgCeFnZDIl84qeVGVGPCE1ld/QueJnehUwjgKoTO4/zjjDL8kswznr1JDvi9VaCXacC+VI9r6VzltRZ5swDpmKPyMmb9cmhMEf9xL3SAC/5BAMOeIRhBtQkmSS3npvq56QQFDwea3t/GKD4qbn+Aeii8KOf1fN/cgbnkEiE51Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM4GeqoG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e71401844so117014066b.3;
        Thu, 21 Nov 2024 03:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732188766; x=1732793566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTXAZJZ+nKlKLWkxVmOU3X8its5cDxlRDr4MYuX5+rY=;
        b=cM4GeqoGVGCTQPnZ22qyK2Jtfw9fmcV7SsyYmR1lx3vtW9xWcDHn+IKt7wiMEARCVn
         OKP0uyb6hqsHu+mh7OC2NAZvsJ6MtK60KJwT0LzGp4cCAy6kfnDuP38dnlyDAUoZj4hY
         2RsLPod+E9Go0HdPoAUELtB4dV0hpmO4+pXH2d43Tf11lRGsSzOscmFbLlVGscf7592U
         MnyfMl1cp7Y28a9a0O19aSCiWQ71aT6jtOz2+55bkLbzgonvG3vhxrdSFxswo6PLnjJz
         mh5d09YPVv3u7C2tS2pWh/cfU8CJs2cVhVLKDKpUhKXJFaKpd1mvYt3j41QJybDtVzWX
         KpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732188766; x=1732793566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTXAZJZ+nKlKLWkxVmOU3X8its5cDxlRDr4MYuX5+rY=;
        b=WAYtq8HnEoLZNc9AYwCd6GZU9ctUX3Y8/OGuHuPx7gF9SR3NJ/CazByGWHZEWuVLBw
         RDDdm8hM5KoEnq6FIUjnsE5HO9Hihi2paMBTiCa1DVxGG7D+D7H/gaGLXEN7GT1rKg6a
         tZuoJ9OOFKhMlwIQutyockyjPuAr67OYxTllMgCXSQbS2YdiWu6BVPWCIOJiBMavZTux
         vjAD+j8DjorYAl+eH/3aBZF9btK9jS0VQ+Yo1/Q3Rio+lWwmFUpZfxfTtVvSK171Q3wm
         NS/WkZoFRmqaLu3KVl1p3lqGb1IlLfanvYuI8DNWWl94be7OCdETTUGcS5BEPXxn5dcn
         Kpsw==
X-Forwarded-Encrypted: i=1; AJvYcCU020r66U3HsmHGp8gUDvRkI5K3KsjOlSTxPh8kmSRPU2PN+MwqWENbNtOze1OFGgjRMLVST8ci/ii9sg==@vger.kernel.org, AJvYcCUqbo6XFhlYoJsxAdq93hLh56cnwNw1SCLrXw4kk2Vc2jSwVTqhJB7afxJuXytPyLIy9ybQjXyuHf3DQQ==@vger.kernel.org, AJvYcCV/oZLvinbl72l95RGRmQssm/RLbOS95TZg/ec9jL08s031vLCn1QztGU+6bj4IzDI+OFPmNrW1HAIiJMSJ1g==@vger.kernel.org, AJvYcCWjMQ7rk2gsNibb6tGAxs/fbM8c4Qm6TCM4QoAGXjywCmXzv6+5FLoKiG6F+ej075R7xBrZO6I17cHw@vger.kernel.org
X-Gm-Message-State: AOJu0YxHKx4IAs61cqZS4DWHEyT3zHLXuQfp/aIr5d5QzYQ6KQsyPUnA
	+aj1iLt7P4FC+vicDihyZIR51ckbA3PxLZaCNaS3/929ND4FLxpYsUOLXtuEZe+Pxw0BetvSEWY
	o84jZ0mZprG5yr+4ab+KRr4tjqFs=
X-Google-Smtp-Source: AGHT+IFDC6Wn8S1wprqutUxY59wWGpsYYGBTQOa63eYhgEaktT9KgVt0nhPBJozxBehGGEWQNwXmv1tOeif+Aiv4XyA=
X-Received: by 2002:a17:907:86ac:b0:a99:fba0:e135 with SMTP id
 a640c23a62f3a-aa4dd723f41mr529153866b.46.1732188765299; Thu, 21 Nov 2024
 03:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731684329.git.josef@toxicpanda.com> <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
 <20241120155309.lecjqqhohgcgyrkf@quack3> <CAOQ4uxgjOZN_=BM3DuLLZ8Vzdh-q7NYKhMnF0p_NveYd=e7vdA@mail.gmail.com>
 <20241121093918.d2ml5lrfcqwknffb@quack3> <20241121-satirisch-siehst-5cdabde2ff67@brauner>
 <CAOQ4uxgL1p2P1e2AkHLHiicKXa9cwrFNkHy-oXsdGKA9EkDb6g@mail.gmail.com> <20241121111644.y63uejriiti4vce5@quack3>
In-Reply-To: <20241121111644.y63uejriiti4vce5@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 Nov 2024 12:32:34 +0100
Message-ID: <CAOQ4uxh-LTvBg93GLtdVp7ixwJLCy+Q1GgSijAs0iZ4k++AuCQ@mail.gmail.com>
Subject: Re: [PATCH v8 02/19] fsnotify: opt-in for permission events at file
 open time
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 12:16=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 21-11-24 12:04:23, Amir Goldstein wrote:
> > On Thu, Nov 21, 2024 at 11:09=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > >
> > > > It is not that I object to "two bit constants". FMODE_FSNOTIFY_MASK=
 is a
> > > > two-bit constant and a good one. But the name clearly suggests it i=
s not a
> > > > single bit constant. When you have all FMODE_FOO and FMODE_BAR thin=
gs
> > > > single bit except for FMODE_BAZ which is multi-bit, then this is IM=
HO a
> > > > recipe for problems and I rather prefer explicitely spelling the
> > > > combination out as FMODE_NONOTIFY | FMODE_NONOTIFY_PERM in the few =
places
> > > > that need this instead of hiding it behind some other name.
> > >
> > > Very much agreed!
> >
> > Yes, I agree as well.
> > What I meant is that the code that does
> >     return FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> >
> > is going to be unclear to the future code reviewer unless there is
> > a comment above explaining that this is a special flag combination
> > to specify "suppress only pre-content events".
>
> So this combination is used in file_set_fsnotify_mode() only (three
> occurences) and there I have:
>
>         /*
>          * If there are permission event watchers but no pre-content even=
t
>          * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate=
 that.
>          */
>
> at the first occurence. So hopefully that's enough of an explanation.
>

Yes, that's the comment that I did not see, but assumed it was there ;)
which I wrongly expressed as "I wonder how you annotated".

Thanks,
Amir.

