Return-Path: <linux-fsdevel+bounces-36311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A78F9E12C7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 06:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF002827EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 05:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0523217E016;
	Tue,  3 Dec 2024 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITzgb2Hu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003BB1714A0
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 05:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733202730; cv=none; b=Q8oEUrIFUp4va+GXki/mtaD+7NFWqb6f9WCU++pEp0uDs1P2+bFR4pNRt8kVd7w0GRoSM1FaPDdBMUWugxKXCQg563IQw9QdWrgHiKi7AVHOdiT1jYkFNeF+ZFkQtskjgFdVnoEPYVKLZGNXymzbOKEK+j0UJgz029xT8KdDS7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733202730; c=relaxed/simple;
	bh=HofXY6nzU4orAxp0SgD9KWygslXqnQwJgbOWVJyMhyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pha9KD1tELjjhW3AyXTxYoUEJbHE1DG9zjIc+PiYFe3P/dyFv9PYPvhKYOqrYK0HE/sLTwb4gYLhfMcDRglY73SP1kp/wIgGsmaTrozUxZPRDoGE0sT1zCdseWNnoZZYhL9OeM3rLZtdBEsMvm+Bsfh9OJQB7CJIJg3OZInixM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITzgb2Hu; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-46695dd02e8so53134451cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Dec 2024 21:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733202728; x=1733807528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4S9kLpywXAGZ5QqWcOX2bwLwi4oXo+v3bl1okPs2rs=;
        b=ITzgb2Hu9qr1RDv/aUA71Wyb3c0jSnxcnXau+6fVPsr7L/zD7s1M1B8R3elXnzeToi
         qnOv4r0Pwnscf1oETqNu7zM065aj2tZlejvHIrZKAoZoI0K9AF/TJpuWwnNwPbJOkSpD
         zW8xORlUvbZDxPDGP+Buhh8n3+TIma++aOY1jMB9Bl/4UruSIUpJ9qLdkuOSj397vUSc
         zaNhEYIwK5+c995MhUP29DvT/pRoTaq5s9lMBdQTCoY+JCLK8cJUC3h+sztRojlDOkJB
         mnXYr9EgDPRG3KA+EwyLsSJS7swl2zX/F+RSMjiacT4pUDGN4fLFBGWxTuqu36ziJsSH
         dXgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733202728; x=1733807528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D4S9kLpywXAGZ5QqWcOX2bwLwi4oXo+v3bl1okPs2rs=;
        b=QhakAgUCto2ctB+xcuQ4+F+RWegpz3aBsoit1fx/sjZLSQuPj/sIS5oS2ejzYqs6vr
         CdYjKgNpvGM2DzQ8sC51x7fzfVbZh7+BKBLfJNiPx//fGB1CcMyoSFU5ZM7cxa5BQCrR
         k9hEB84sVL3eZ+Y0XIl0AS2yXcGE8LAHRgxQpxt8YHsePrkWBv4SdVrY3FgbrSCslR/Z
         eebZKSc1CSsvSjDUm+bmSNP6klpvsRFbX2d05lXiPb1B4VmfuNGzvN0nxzwd4eMoow83
         dNzy8uKe/RAlW/j9ZxhO6eZDn3/xs1avA7P6E64aMVBebnZ1JwR2dU1Gfxq8Spe1ryya
         iGsw==
X-Forwarded-Encrypted: i=1; AJvYcCUm1JN8SSEXzbD7hiAQqTbGYh2LaG7AOD9EiEtEw86O2+gDrz2GSftl8aa5d3F1CMF2Z3bbPh+4kNQdxn4r@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdvvwble6C16c/UQh6gs7+1ROHA1CjhUHyPBzL1OgrlrcGmcuq
	wzdU41O4BnyY47m26wpnIeywzR0IQDTAliS3Rhj1+Z34yo9q8UeBw+D8RyOW7zMunla9TB1hx6c
	cJ8+o4g9XN5x0N83aWcbxWN/SN5I=
X-Gm-Gg: ASbGnctPugSrePy6nzNGW1puWMohev7ANDSeRfTmfMqNLclkdrjdUtTVeTgl2SXlDNV
	BguNC93FTvKkZyp2uJnlfIX5kVIcFOWibBfl7QlMzXqvgFQo=
X-Google-Smtp-Source: AGHT+IHkjUcVF8+CTGJTR0R+SX9nFR4Gtkvz07UW7hRiRf4EkoFzhWaJjMLWHvaueQ2mHI/sKztOAGda4ddS5g3M1Zk=
X-Received: by 2002:a05:622a:114:b0:466:ae07:599f with SMTP id
 d75a77b69052e-4670c08a02emr25196161cf.17.1733202727889; Mon, 02 Dec 2024
 21:12:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-3-joannelkoong@gmail.com> <20241128104437.GB10431@google.com>
 <25e0e716-a4e8-4f72-ad52-29c5d15e1d61@fastmail.fm> <20241128110942.GD10431@google.com>
 <8c5d292f-b343-435f-862e-a98910b6a150@ddn.com> <20241128115455.GG10431@google.com>
 <CAAFQd5BW+nqZ2-_U_dj+=jLeOK9_FYN7sf_4U9PTTcbw8WJYWQ@mail.gmail.com>
 <ab0c3519-2664-4a23-adfa-d179164e038d@fastmail.fm> <CAJnrk1b3n7z3wfbZzUB_zVi3PTfjbZFbiUTfFMfAu61-t-W7Ug@mail.gmail.com>
 <20241203043118.GC886051@google.com>
In-Reply-To: <20241203043118.GC886051@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 2 Dec 2024 21:11:57 -0800
Message-ID: <CAJnrk1bHuopY72UTDxi6DYKE0jbSPnT0==XqHXoa5J6so107uQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 2/3] fuse: add optional kernel-enforced timeout
 for requests
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Tomasz Figa <tfiga@chromium.org>, 
	Bernd Schubert <bschubert@ddn.com>, "miklos@szeredi.hu" <miklos@szeredi.hu>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"josef@toxicpanda.com" <josef@toxicpanda.com>, 
	"jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>, "laoar.shao@gmail.com" <laoar.shao@gmail.com>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 8:31=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/12/02 11:29), Joanne Koong wrote:
> > > >> In those cases 1 minute fuse timeout will overshot HUNG_TASK_TIMEO=
UT
> > > >> and then the question is whether HUNG_TASK_PANIC is set.
> > > >>
> > > >> On the other hand, setups that set much lower timeout than
> > > >> DEFAULT_HUNG_TASK_TIMEOUT=3D120 will have extra CPU activities reg=
ardless,
> > > >> just because watchdogs will run more often.
> > > >>
> > > >> Tomasz, any opinions?
> > > >
> > > > First of all, thanks everyone for looking into this.
> >
> > Hi Sergey and Tomasz,
> >
> > Sorry for the late reply - I was out the last couple of days. Thanks
> > Bernd for weighing in and answering the questions!
> >
> > > >
> > > > How about keeping a list of requests in the FIFO order (in other
> > > > words: first entry is the first to timeout) and whenever the first
> > > > entry is being removed from the list (aka the request actually
> > > > completes), re-arming the timer to the timeout of the next request =
in
> > > > the list? This way we don't really have any timer firing unless the=
re
> > > > is really a request that timed out.
> >
> > I think the issue with this is that we likely would end up wasting
> > more cpu cycles. For a busy FUSE server, there could be hundreds
> > (thousands?) of requests that happen within the span of
> > FUSE_TIMEOUT_TIMER_FREQ seconds.
>
> So, a silly question - can we not do that maybe?
>
> What I'm thinking about is what if instead of implementing fuse-watchdog
> and tracking jiffies per request we'd switch to timeout aware operations
> and use what's already in the kernel?  E.g. instead of wait_event() we'd
> use wait_event_timeout() and would configure timeout per connection
> (also bringing in current hung-task-watchdog timeout value into the
> equation), using MAX_SCHEDULE_TIMEOUT as a default (similarly to what
> core kernel does).  The first req that timeouts kills its siblings and
> the connection.

Using timeout aware operations like wait_event_timeout() associates a
timer per request (see schedule_timeout()) and this approach was tried
in v6 [1] but the overhead of having a timer per request showed about
a 1.5% drop in throughput [1], which is why we ended up pivoting to a
periodic watchdog timer that triggers at set intervals.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1bdyDq+4jo29ZbyjdcbFiU2qyCG=
GbYbqQc_G23+B_Xe_Q@mail.gmail.com/

