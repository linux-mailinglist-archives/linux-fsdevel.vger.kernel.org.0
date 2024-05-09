Return-Path: <linux-fsdevel+bounces-19154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC4E8C0AEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 07:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93806284F09
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 05:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03C1494B0;
	Thu,  9 May 2024 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFkonWA7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADA110E5;
	Thu,  9 May 2024 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232219; cv=none; b=EuUheM5qmdtvxZkD4gHGdvXXhCAhyfGD7L4dQH/S8AUplDNxeWCpq/V9Xi9pc+xjgJWormrTJUPZO14RJ5JC1maRpKxKAV8y9X22BCmQTtg+rdaKT2dpp1TnvYHvhlHswMZwkqegzd1+Qf+hU8t32qIT2qOsMdNvMcG5erzixlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232219; c=relaxed/simple;
	bh=A/nS3HEOugLNgKjph8tOEMwkUz1x3qdu92wcdow/m90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXmVXBcIkpaGR6FxlH+6u0yTvLafdvUGZiHPFOstk6kvLo+eTvaMo3Tmzo1bNIrLw0l1luDnksPDdJg01JOV8qHW+N1/Z6miC3wBgwacWdDXDkxB7goi8L3XnE1xweyNTCEMHGaIQdj+VJDnajF8UjhH4dm0a0Sd1QLW8GFA+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFkonWA7; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b6d36b71cso3128166d6.3;
        Wed, 08 May 2024 22:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715232217; x=1715837017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/nS3HEOugLNgKjph8tOEMwkUz1x3qdu92wcdow/m90=;
        b=nFkonWA7VYy2ryh3JzZmyMg5bXH8pWCJxpUDx9KZLfzRenDFndL+SsicUXNZK1KJP9
         dDGmunnPn+RRE7ulFAhWN46ugCPbBemqmjKYpGCi2ThBcIFf7i5Fye2zvxKFLWY8tI4K
         AEkBAz1qFGP1iOWDcAOdptfljEDTNS50F5jJ6OvQmnG7YbCMveWQ1vyULlUmqm356ssn
         GmeIAUqq1vS7TmVXVniFjYXyd1DmsK50xgm4TgEAIwfnUfRiVgVn6i4DzvEVV7ovzUZG
         W381DJk4D3Bi+/lUwD0P5s6Erd/JRnYj1vZg0wgNyY96KNnRsxEp43m0fkgShh7SAx41
         8v9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232217; x=1715837017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/nS3HEOugLNgKjph8tOEMwkUz1x3qdu92wcdow/m90=;
        b=fwZSuhakX+RE5/RFoMZtqY5V2zObntt0rj+EO03EnJwgINp6B96Xdj8ydBtBcXA1kU
         9/fPM7llLZGz332yej3BsfptzKyX7K5e/rigE/59uuWvWB3nJLr7flEwcLxrNi8DiQE5
         xd4qk7zQNlEpydnmfE+audFCqotRMXqx2p604gzRB+PHN2ZBpZNdhtNT/VMgdnz+anyH
         hnKXFb7UXW7hV4Q8HarQoUF9dH2euCKwY+7Yj87976F1Tjma//PVJbKRO0bjW0jGiHcE
         TuV4OhM4hxdlivc6PtdTyzU8I2yZwA5avzLM+XTY+lLzyBPXxlFvbrplVBv4lK8Co7QX
         IM/w==
X-Forwarded-Encrypted: i=1; AJvYcCVn7yV8JFAwwRvO7qVL4zPulbAXVXOyGlpNRhKnhSVwaY9rIVd+LOaQCPJJMg/6Ul+LOnBtnBDSNS23MBH038XRWbMII40aN/lCkCPylDXCbMwE/WgEhraF++Q9YuFx+rduO8zudaR2Cg==
X-Gm-Message-State: AOJu0YznxU7ZlthlD5gQJaE2kntwbMjPL/rOZOJ4ShuGwCBtB72oO6bZ
	pwca2azUbnOxntbo41BIfN2bBWeEY60Q1srqbTVhiWqGEwRoWdyh+/W1Sfx/6hH4wHhS4h+hD86
	CQZy3LB5pk2rmtsmhefZsbuu5NxA=
X-Google-Smtp-Source: AGHT+IFHax6DPjC4uHCr77vr4oXeNl+kGo4KMIQopk17XCY3WMP9xzHXwDiZSy64nODDp2byf7wFN5LD6FnKjp7gkak=
X-Received: by 2002:ad4:5dcc:0:b0:6a0:d465:6088 with SMTP id
 6a1803df08f44-6a15156da86mr60562636d6.34.1715232216975; Wed, 08 May 2024
 22:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
 <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com> <ZjxZttSUzFTd_UWc@infradead.org>
In-Reply-To: <ZjxZttSUzFTd_UWc@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 May 2024 08:23:25 +0300
Message-ID: <CAOQ4uxhpZ-+Fgrx_LDAO-K5wHaUghPfvGePLVpNaZZza1Wpvrg@mail.gmail.com>
Subject: Re: [Lsf-pc] XFS BoF at LSFMM
To: Christoph Hellwig <hch@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Chandan Babu R <chandan.babu@oracle.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:06=E2=80=AFAM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Thu, May 09, 2024 at 08:01:39AM +0300, Amir Goldstein wrote:
> >
> > FYI, I counted more than 10 attendees that are active contributors or
> > have contributed to xfs in one way or another.
> > That's roughly a third of the FS track.
>
> FYI, I'm flying out at 4:15pm on Wednesday, and while I try to keep my
> time at the airport short I'd still be gone by 3:30.

I've penciled XFS BoF at 2:30

>
> But that will only matter if you make the BOF and actual BOF and not the
> usual televised crap that happens at LSFMM.
>

What happens in XFS BoF is entirely up to the session lead and attendees
to decide.

There is video in the room, if that is what you meant so that remote attend=
ees
that could not make it in person can be included.

We did not hand out free virtual invites to anyone who asked to attend.
Those were sent very selectively.

Any session lead can request to opt-out from publishing the video of the
session publicly or to audit the video before it is published.
This was the same last year and this year this was explicitly mentioned
in the invitation:

"Please note: As with previous years there will be an A/V team on-
site in order to facilitate conferencing and help with virtual
participants. In order to leave room for off-the-record discussions
the storage track completely opts out of recordings. For all other
tracks, please coordinate with your track leads (mentioned below)
whether a session should explicitly opt-out. This can also be
coordinated on-site during or after the workshop. The track leads
then take care that the given session recording will not be
published."

I will take a note to keep XFS BoF off the record if that is what you
want and if the other xfs developers do not object.

Thanks,
Amir.

