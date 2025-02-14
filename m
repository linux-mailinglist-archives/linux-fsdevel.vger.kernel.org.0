Return-Path: <linux-fsdevel+bounces-41760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEBFA3677B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 22:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A699418939EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 21:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FE51D89F0;
	Fri, 14 Feb 2025 21:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfdU0MoP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D86158870
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739568408; cv=none; b=g75bxjp5Pxrk83oALJVWNbWIat1m3oU/6Ir8/hHGuaR0r6gnOe9NX/5rdd3E6XhBLGYQcLL8zOH2b24WMBPpqL+riQ3Z55CS2uzHhbFiTbdAc788E70BNJwrThKHZ6rm+x0Vkf25X19++WoyphHxYLK4hxlienLKeBOQ1uxUuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739568408; c=relaxed/simple;
	bh=uja1g3fb9vHRXTxGeXkOXya28I87SQipkdhAv0Fe0Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=usmmh65w0MeE97MXZISqXKGKQuhGOTobVV998Jr2DA/dmMARTfJF4WDIvw3TZWKbdKSjgt5F7dZ0YFaJsaa0weUur0Wn3GUBBBkjvAR4k3D/Rpk7cWr79tEJUqsL8/aPCHxVdb1dUVS/34fJoHU0ANDBBVTtrneAhMrX4V39pNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfdU0MoP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471be82b59aso29426901cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 13:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739568405; x=1740173205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bdk1X9kFqy/OwJmutVmC6KH0fnBfKSPpHj+q0uri/Q=;
        b=IfdU0MoPRKjLpvL/BJaO4XAp31FiUNS2L+xF7bTV/0eb2XCq6LPhnWVCAP5TmTO5Ow
         d7E9l93xFZqU78oQr2wafH0z47brdCjlsuEKsNlP8hTrxnPzCLnX4btRQi2m+AfDxEcl
         U2OZg4mqfHom0QSEpYEDHpudtPzwaT2XCUZ8Rlm4qOUop44OcAflp5CNpNKjxFcEHfah
         Kfx0Kr8dl5K7SGt3Q49riBVbOseAb9/61AWrXj/gxOoggAlUnH+3A99GSPI9niblxXr/
         JrixoDmEdyirGZntY7SsZI8N4FtZarlaoyzuSJU0dMqXLReZt4TILzyy2+/JvVD3aJeO
         dsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739568405; x=1740173205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bdk1X9kFqy/OwJmutVmC6KH0fnBfKSPpHj+q0uri/Q=;
        b=Kpe0rXfPQDi1vzZ66ZKBeimAVMdpjsmLC+cqiAqQdFDPwFfFMxhyr0GNyIYg6vsAV1
         jAj9M31QOZR7+QDbKnfuGn3wnh+Dm3+AE7Ztid05Sf0HvompZDqXCo3geszQqFGHFrIL
         f4bJjucHSkx/3IgJdpqfYuTtqNY5WAqMrbKPVXl6EE5JuGjLSzjJYWGIaexyn26JXUMY
         FXUZrFdYjDgFPQDvqSZHaWm7lSTvG3P2mKwbNq+0+h4siHkier+NlF8c87RB7Oj346Tj
         3339j/AUICiuar+/SBGZsVEk4dGQPmC9hp8r8Zd7RnQOy5AOwlfKDE9JW9XogDJQpmoM
         OVRg==
X-Forwarded-Encrypted: i=1; AJvYcCXStGcXLu7LZdshec+oEQRHSbpG3LlhsP7usYUUOzR80FwJjUBUIZHrxGMTN1+HuIGWCNfgpclt0CydAR0I@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OhFxkHKEpxghVZBQ8p/DtbBgku8M0J998XdQlEGuJl8huly8
	5yTetPrbsbgHRG8/Hwm4joAeqex94mUeMkAYOM4UWIL/gclbeWuGR+6C5szWYLrdsD8Dqc7PJ2q
	UyVhPtXshktLJz88SX7YWUJ0GKRk=
X-Gm-Gg: ASbGncupT7i6HChlFRZpZzoOmgNUyA2JqsUjHpw4T8vJduf8wYctN58amgVE5soUmb0
	iG7Cpsb09tdCVStOdSU+q8jm0UFGoYBfA6z8r8RwauTtIA1AIkICORLmzmAwoq1jRto6fB6o9Fw
	==
X-Google-Smtp-Source: AGHT+IGDKc+qm4H1tAO2JTbCEwPQiWizXPg4F578Hym4JKK1I4dhQW0eIdGVhlfzPAscTfdPRdAyn0xLsZkmX2pm6Wo=
X-Received: by 2002:a05:622a:191c:b0:471:9740:89cb with SMTP id
 d75a77b69052e-471dbd6d4b2mr11609601cf.26.1739568405195; Fri, 14 Feb 2025
 13:26:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820211735.2098951-1-bschubert@ddn.com> <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
 <38c1583f-aa19-4c8a-afb7-a0528d1035b0@fastmail.fm> <CAJfpegsFdWun1xZ-uHXnWBeRz3Bmyf0FSYWiX1pGYU8LEz12WA@mail.gmail.com>
 <CAJnrk1YaE3O91hTjicR6UMcLYiXHSntyqMkRWngxWW58Uu0-4g@mail.gmail.com> <0d766a98-9da7-4448-825a-3f938b1c09d9@fastmail.fm>
In-Reply-To: <0d766a98-9da7-4448-825a-3f938b1c09d9@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 14 Feb 2025 13:26:34 -0800
X-Gm-Features: AWEUYZkOVvcY_f7L3pOHC0_CE0v9VIsN1J0SZF7g3uYfYpW6hMgm7qM8-Mw15Ic
Message-ID: <CAJnrk1b0z7+hrs3q9dGqhtnC3e2wQEEoHEyKQgvgTwg9THd_Xw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 12:27=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> Hi Joanne,
>
> On 2/14/25 21:01, Joanne Koong wrote:
> > On Wed, Aug 21, 2024 at 8:04=E2=80=AFAM Miklos Szeredi <miklos@szeredi.=
hu> wrote:
> >>
> >> On Wed, 21 Aug 2024 at 16:44, Bernd Schubert <bernd.schubert@fastmail.=
fm> wrote:
> >>
> >>> struct atomic_open
> >>> {
> >>>         uint64_t atomic_open_flags;
> >>>         struct fuse_open_out open_out;
> >>>         uint8_t future_padding1[16];
> >>>         struct fuse_entry_out entry_out;
> >>>         uint8_t future_padding2[16];
> >>> }
> >>>
> >>>
> >>> What do you think?
> >>
> >> I'm wondering if something like the "compound procedure" in NFSv4
> >> would work for fuse as well?
> >
> > Are compound requests still something that's planned to be added to
> > fuse given that fuse now has support for sending requests over uring,
> > which diminishes the overhead of kernel/userspace context switches for
> > sending multiple requests vs 1 big compound request?
> >
> > The reason I ask is because the mitigation for the stale attributes
> > data corruption for servers backed by network filesystems we saw in
> > [1]  is dependent on this patch / compound requests. If compound
> > requests are no longer useful / planned, then what are your thoughts
> > on [1] as an acceptable solution?
>

Hi Bernd,

> sorry, I have it in our ticket system, but I'm totally occupied with
> others issues for weeks *sigh*
>

No worries!

> Does io-uring really help if there is just on application doing IO to
> the current core/ring-queue?
>
> open - blocking fg request
> getattr - blocking fg request
>

My understanding (and please correct me here if i'm wrong) is that the
main benefit of compound requests is that it bundles multiple requests
into 1 request to minimize kernel/userspace context switches. For fuse
io-uring [2], "motivation ... is... to increase fuse performance by:
Reducing kernel/userspace context switches. Part of that is given by
the ring ring - handling multiple requests on either side of
kernel/userspace without the need to switch per request".

Am I missing something in my understanding of io-uring reducing
context switches?


> If we could dispatch both as bg request and wait for the response it
> might work out, but in the current form not ideal.
>
> I can only try to find the time over the weekend to work on the
> compound reuqest, although need to send out the other patch and
> especially to test it (the one about possible list corruption).

If you need an extra pair of hands, i'm happy to help out with this.
Internally, we'd like to get the proper fix in for the issue in [1],
but we have a hacky workaround for it right now (returning -ESTALE to
redo the lookup and update the file size), so we're not in a huge
rush.

Thanks,
Joanne

[2] https://lore.kernel.org/linux-fsdevel/20250120-fuse-uring-for-6-10-rfc4=
-v10-0-ca7c5d1007c0@ddn.com/

>
>
> Thanks
> Bernd
>
>
>
>
>

