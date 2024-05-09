Return-Path: <linux-fsdevel+bounces-19207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A58C140C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 19:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D839C1C21DF9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B732F1774E;
	Thu,  9 May 2024 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl/GcbBj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1445BE66;
	Thu,  9 May 2024 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275774; cv=none; b=bLUfWH1tggaeVQvGl8tiRJHjc/wGVSXTIX5P01Ju1Ppa16T6VTF//AJH8lOE1Mcg+j5MS9kpxDA4dYa4JAGM8wf954uYh6E+8NM3Vszb4SEAm10ytyUS4m6J66o5ALDzkRZH1BHBP9WRl259c0ZTewB65glqVi5UlZsvSZ3cl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275774; c=relaxed/simple;
	bh=hAaWJiU2uFsfBCBcLgxDjrROB7NVdqXJI2Wq+yRsGZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LBo7uiXU72AzQ4wiavfpXvdeSmxDyW29/5GofNSKIsXHVeD3xXNQocDXZpC3bRMBNYm1btX14+pzTOBOvBn7ta6ciDh2kWluAXPgsxrsmkkXmW/Y0F71GsOMEZWDUVE8nqnO2hxTQg4Vjsslfix/SuJawM09VYOJpD2yoz2oEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gl/GcbBj; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b59c10720so6430246d6.3;
        Thu, 09 May 2024 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715275770; x=1715880570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnS9KNaen1f6wfJRSUp/rs5uiMPYGIJWlULd+BGssks=;
        b=Gl/GcbBjKyrSIHfBC1dDOWT1hbgrtFnTmuVBnABu0Uz+MMAJX8dJuHXpXmIK6lSEKl
         oWtelyGYZMaWHHeNA69I4B3aHhd5xGhrrW2Y0J6qd/3cRf+3dzl3aU7Q9NVGcIn8iQTt
         xJX43N1B7i5EJYGThiVKtEhAjYWYKM3V+v7N5OmWlgpImZy5cJkt9AT8Qbzqz8GF9SQ6
         kSY/kYBR5+cKy/6btTJbjm93ATc9uJKYRwda7I//GG6wBM019Lm6d2I5n9tIfs5wdWv7
         F+LXaB74vazIsOAJmEz+VxF4ELxvOGOvYoqfMKGLAyz3PZPt6zDxXtsvjrt6liqgG6+U
         MTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715275770; x=1715880570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnS9KNaen1f6wfJRSUp/rs5uiMPYGIJWlULd+BGssks=;
        b=rU2E0/CmUDYNlgCekeFihv5Rxk1IyPzTqAWPq5gZe4kr+jcmF2Pb3Fu6z0zAUj/KtQ
         6EwfrEXSF851q6zCTUoJMDMQDU5gcpO4MPOYWFMEOr4q/CW5J6g/M6JOb81YkQ5NIF9U
         yU1QWr81871cpan8EtSIyCXs1L+ltIk698+OKGRepFo1h9T2M+q7PtBm/9g5jKhR3iFX
         kZKX9+rnDDcVbKThOZF7iuZi8asEWfT/odzPGGmSLFtaw2HMjcmWCIy5eYjKBj2YbjMZ
         mHo/BZOseE3CHzoa/PijW3cTiH7Gve9jU5hyMbTvI8ncE21PwY5uweayA6WIgcSfPrqs
         3Lxg==
X-Forwarded-Encrypted: i=1; AJvYcCX2V4Ze62aMP4IXxzJu1+Tgzzn/qOby5sJtEraZjV1ea7xFR3u3ge5/8Giw0eeNt2Rtn973/tTPcrGzpvaKAndxLFbFO+EiPlobAf0VLaiKUIpIJJuONaBEGxLWIZslpmfPl1inFu6LGw==
X-Gm-Message-State: AOJu0YxTnJnkVxk4WYYaxOqg4C8m9I+SJDM33Jxq9IkuyWSOwwq+LAGD
	JcrnwhHe2flfEnJiArfqMwcRaPi85lbDdlz1M8bTbxarvjQocXIDazdT2EBwvXIe0lQmQIrOL/D
	Z4r40Cd4PbcPKdMz3C81qXbV28pA=
X-Google-Smtp-Source: AGHT+IEkrWnQ/cF3wxbgmZJ1pLYGxHLM6aG6kIl1YbtTTCXkr8mhVTnvGPdi380ApXRssqXh2da8FNzhmVOdJEqi+/A=
X-Received: by 2002:a05:6214:554a:b0:6a0:b352:f3b0 with SMTP id
 6a1803df08f44-6a1681e002dmr296216d6.39.1715275770489; Thu, 09 May 2024
 10:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
 <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
 <ZjxZttSUzFTd_UWc@infradead.org> <CAOQ4uxhpZ-+Fgrx_LDAO-K5wHaUghPfvGePLVpNaZZza1Wpvrg@mail.gmail.com>
 <20240509155528.GN360919@frogsfrogsfrogs>
In-Reply-To: <20240509155528.GN360919@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 9 May 2024 20:29:19 +0300
Message-ID: <CAOQ4uxiX=O8NhonBv2Yt6nu4ZiqTLBUZg+M5r0T-ZO5LC=a2dQ@mail.gmail.com>
Subject: Re: [Lsf-pc] XFS BoF at LSFMM
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Chandan Babu R <chandan.babu@oracle.com>, Jan Kara <jack@suse.cz>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 6:55=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> [adds ritesh to cc]
>
> On Thu, May 09, 2024 at 08:23:25AM +0300, Amir Goldstein wrote:
> > On Thu, May 9, 2024 at 8:06=E2=80=AFAM Christoph Hellwig <hch@infradead=
.org> wrote:
> > >
> > > On Thu, May 09, 2024 at 08:01:39AM +0300, Amir Goldstein wrote:
> > > >
> > > > FYI, I counted more than 10 attendees that are active contributors =
or
> > > > have contributed to xfs in one way or another.
> > > > That's roughly a third of the FS track.
> > >
> > > FYI, I'm flying out at 4:15pm on Wednesday, and while I try to keep m=
y
> > > time at the airport short I'd still be gone by 3:30.
> >
> > I've penciled XFS BoF at 2:30
>
> Ritesh and Ted and Jan and I were chatting during the ext4 concall just
> now.  Could we have a 30 minute iomap bof at 2:30pm followed by the XFS
> bof after that?  That would give us some time to chat with hch about
> iomap (and xfs) direction before he has to leave.
>
> Alternately, we could announce a lunchtime discussion group on Monday
> following Ritesh's presentation about iomap.  That could fit everyone's
> schedule better?  Also everyone's braincaches will likely be warmer.
>

Seems to me that there will be a wider interest in iomap BoF
Not sure what you mean by lunchtime discussion.
We can move Willy's GFP_NOFS talk to 15:30 and have the iomap BoF
after Ritesh's session.

> > >
> > > But that will only matter if you make the BOF and actual BOF and not =
the
> > > usual televised crap that happens at LSFMM.
> > >
> >
> > What happens in XFS BoF is entirely up to the session lead and attendee=
s
> > to decide.
> >
> > There is video in the room, if that is what you meant so that remote at=
tendees
> > that could not make it in person can be included.
> >
> > We did not hand out free virtual invites to anyone who asked to attend.
> > Those were sent very selectively.
> >
> > Any session lead can request to opt-out from publishing the video of th=
e
> > session publicly or to audit the video before it is published.
> > This was the same last year and this year this was explicitly mentioned
> > in the invitation:
> >
> > "Please note: As with previous years there will be an A/V team on-
> > site in order to facilitate conferencing and help with virtual
> > participants. In order to leave room for off-the-record discussions
> > the storage track completely opts out of recordings. For all other
> > tracks, please coordinate with your track leads (mentioned below)
> > whether a session should explicitly opt-out. This can also be
> > coordinated on-site during or after the workshop. The track leads
> > then take care that the given session recording will not be
> > published."
> >
> > I will take a note to keep XFS BoF off the record if that is what you
> > want and if the other xfs developers do not object.
>
> Survey: How many people want to attend the xfs bof virtually?
>
> I'd be ok with an OTR discussion with no video, though I reserve the
> right to change my mind if the score becomes chair: 2 djwong: 0. :P

The middle ground is to allow video for the selective virtual attendees
(and trust them not to record and publish) and not publish the video
on LSMFF site.

Thanks,
Amir.

