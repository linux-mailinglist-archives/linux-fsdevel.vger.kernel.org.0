Return-Path: <linux-fsdevel+bounces-39428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA24A140F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AB51881D11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 17:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E307A154BE5;
	Thu, 16 Jan 2025 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbDD5oD8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A324A7C6;
	Thu, 16 Jan 2025 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737048869; cv=none; b=nzmJQ6DoE2OmfBbxwRBuOmAtfovYkODvi1PFfaAl7fIHeRZlgMFF2FKyhQFfNTPsMhk8PUnF6Bw6OHQTK6tEzMSnJofW4xb3XxpY0O7u9VAYpsz+J8+iXbXiIe3QwOMo+n03AXdb9isrzCxZEPh/N1ruESpk64ogQ5uXupwrggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737048869; c=relaxed/simple;
	bh=QdI/Oyw8R6iGT2ROakjIbjMZIwTzOMQIg8ekYLEo0x4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCB/aIiM0WZknVFBk5HgQ3sHcxHn5KAx9cpEY+ccpNDXsCrJORa7x6jgBuQjDHc/LcCsBCtIG2Q2ZubB5qmPGLbaRvQNwBu+5i7JrpaX92OvzIO+TBkMF/sYviNnn/QIKYwQkPdyWHMHYpRoRR3oaaVJkbY6lhTEfK+7r8i12WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbDD5oD8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso1761820a91.1;
        Thu, 16 Jan 2025 09:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737048867; x=1737653667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e2H3NJynS8ASdQYVmMB/7/0U+sJgpPc8AydkCIPguM=;
        b=BbDD5oD81vK/cgIYG8f2fpbqAYzt4AGcCaXWbzLxCkEiFyPmS5GZDhrYD1kv1aOFbc
         oJAsFqgjqA40+fSqlqTXQsjqbNdd//+PajSYWvC9oqR/EGu2/l6TWLIM7I0p9vv04SL4
         HrcJ6gUsFKuQQYgBW3j1Fq/pDnfmJyeGz8jZ/O3XxPsLVwVXqvJ1y6rDIpJXGqKLsVsV
         jn0YrQqQG5MgtJZW7AWqkDlar9SFzKnu+Bq8BwBBjSsO5PBex+X08sGucdXoVs5q61Oh
         cfXwslouFUwqylwqttKFuOa7v5HT18EfRVT7FqSzT0VNUstkbkmHtTQddA9R2+esrp9g
         NIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737048867; x=1737653667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7e2H3NJynS8ASdQYVmMB/7/0U+sJgpPc8AydkCIPguM=;
        b=jO75RCFkbn9PyCl2chsW2ZQ1AKVc/kAfTwVx7vcDwhyGKwKkJUNzqeAaJSz1q0cBl2
         TQVucLb3aPY1Tls465zg+ufP885yJj8AuwCyvd2/p67zHs6d2cLABfWB2CVpGtsMYI3d
         eTK10D5+qyL5V4z82Yi1hkT8T1SLLRVvwy3WaovmPYHgmnA3nFuggeZ1+5xA7t5Vbe3y
         N/dAkOotB0KoVnE8otdRlMfgrt/mmgKECdGWFhG88pd+GqMFIEI8tnv2g1U4elBt/GSm
         OZWRNJdd1JzVoQU6zjcjW7MEYuI0r0XZ7Wp6Ek5T0+rppX9nl9qRHF5+UGM/dQjkhYU+
         YkJw==
X-Forwarded-Encrypted: i=1; AJvYcCWC4jpl8XeTV75k5LvtMB2Kz48pulY3W8LrDobmT9Efn+bP06Z32cIlyI2KmLaW/64O5oqoTQ8ZO4WcwjvO@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFvU4HyVAsTjb3hOtt1AGyJbBJ2NdkBaMx+1Q/ei4e3OgJDO5
	i2HST1SBxuBigHCrlSGSpgUETQ23Nf7jcZqs7d7vKNtzZH34AjlHVp7wUJkhoaHyxwX1PtkefVY
	4+kIy0IQBWRmESDJNmDaHFWoE6sM=
X-Gm-Gg: ASbGncvrbEzP8ELlFeT0eMs86KWwDj6WkArEiO/6nE2h8kY8jtfQEtXpyudPRe8yhOb
	QoPv1veyR5QMiWi09beacqYplpVl5djPdF+qIVQ==
X-Google-Smtp-Source: AGHT+IFxUCpsfsSC4DP1ZN+ZjvL+2FJzfrLCFzmfzhhSSbXJpqzIZi8KJxxY7lWHhsT7E2tGPd9tW7HFnkARKQfiMIM=
X-Received: by 2002:a17:90b:4d04:b0:2ee:aa95:6de9 with SMTP id
 98e67ed59e1d1-2f548f71e2bmr51924503a91.33.1737048867081; Thu, 16 Jan 2025
 09:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <06b84c0f4c7c86881d5985f391f6d0daa9ee28dd.camel@ibm.com>
 <CAOi1vP9A2MT2iaDGny0FY9cwxEN1Lvknemgxw1fL6PtYcsvqww@mail.gmail.com> <67ab883da6c54de228f133f06dbd32426573aacc.camel@ibm.com>
In-Reply-To: <67ab883da6c54de228f133f06dbd32426573aacc.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 16 Jan 2025 18:34:15 +0100
X-Gm-Features: AbW1kvbTDJ1w8_EXT8LCgq5YMq-JCOkGzw3lBZBzS3jqXm_TrbrlNcYdODGsI6k
Message-ID: <CAOi1vP_qdq_UBAXxs7UmJK_ZR7HUFTixX7wVqnTsBYSAiKx5-Q@mail.gmail.com>
Subject: Re: [RFC PATCH] ceph: switch libceph on ratelimited messages
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 2:38=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hi Ilya,
>
> On Thu, 2025-01-16 at 00:21 +0100, Ilya Dryomov wrote:
> > On Wed, Jan 15, 2025 at 9:53=E2=80=AFPM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > Hello,
> > >
> > > The libceph subsystem can generate enourmous amount of
> > > messages in the case of error. As a result, system log
> > > can be unreasonably big because of such messaging
> > > policy. This patch switches on ratelimited version of
> >
> > Hi Slava,
> >
> > Do you have an example (which is not caused by a programming error)?
> >
>
> Frankly speaking, there is no stable ground for definition
> what is the programming error. :) And if end-user can see
> some messages in the system log, then it's not always clear
> what is the reason of it (faulty hardware, wrong configuration,
> network issue, or programming error).
>
> Currently, I can see during running xfstests some sporadically
> triggered issues (and I am going to investigate this). For example,
> today I can reproduce it for generic/127 (but it passed successfully
> multiple times before). The output of this issue is the infinite
> sequence of messages in the system log:
>
> Jan 15 16:39:06 ceph-testing-0001 kernel: [ 4345.164299] libceph: mon2
> (2)127.0.0.1:40902 socket error on write
> Jan 15 16:39:06 ceph-testing-0001 kernel: [ 4345.164321] libceph: mon1
> (2)127.0.0.1:40900 socket error on write
> Jan 15 16:39:06 ceph-testing-0001 kernel: [ 4345.668314] libceph: mon1
> (2)127.0.0.1:40900 socket error on write
> Jan 15 16:39:06 ceph-testing-0001 kernel: [ 4345.668337] libceph: mon2
> (2)127.0.0.1:40902 socket error on write
> Jan 15 16:39:07 ceph-testing-0001 kernel: [ 4346.660371] libceph: mon2
> (2)127.0.0.1:40902 socket error on write
>
> <skipped>
>
> Jan 15 17:16:30 ceph-testing-0001 kernel: [ 6589.691303] libceph: mon2
> (2)127.0.0.1:40902 socket error on write
> Jan 15 17:16:31 ceph-testing-0001 kernel: [ 6590.907396] libceph: osd1
> (2)127.0.0.1:6810 socket error on write
> Jan 15 17:16:34 ceph-testing-0001 kernel: [ 6593.659370] libceph: mon2
> (2)127.0.0.1:40902 socket error on write
> Jan 15 17:16:37 ceph-testing-0001 kernel: [ 6597.051461] libceph: mon2
> (2)127.0.0.1:40902 socket error on write
>
> <continue to spam system log until the system restart>

If there is an infinite loop running in the background, one has
a problem no matter whether the messages are ratelimited or not ;)
A blanket change to impose a limit on all libceph messages isn't
going help.

>
> > > pr_notice(), pr_info(), pr_warn(), and pr_err()
> > > methods by means of introducing libceph_notice(),
> > > libceph_info(), libceph_warn(), and libceph_err()
> > > methods.
> >
> > Some of libceph messages are already ratelimited and standard
> > pr_*_ratelimited macros are used for that.  They are few apart, so
> > if there is a particular message that is too spammy, switching it to
> > a ratelimited version shouldn't be a problem, but we won't take
> > a blanket conversion like this.
> >
>
> Yes, I agree that even ratelimited version of messaging cannot
> solve the problem of spamming the system log by info, warning, or
> error messages. As far as I can see, we have infinite cycle in
> libceph core library that generates this never ending sequence of
> messages. I believe that it's not user-friendly behavior and
> we need to rework it somehow. I still don't quite follow why libceph
> core library's logic is trying to repeat the same action and
> reports the error if we already failed. Could we rework it somehow?

I tried to elaborate on the premise in another thread:

    The messenger assumes that most errors are transient, so it simply
    reestablishes the session and resends outstanding requests.  The main
    reason for this is that depending on how far in the message the error
    is raised, a corresponding request may not be known yet (consider
    a scenario where the error pops up before the messenger gets to the
    fields that identify the request, for example) or there may not be
    a external request to fail at all.

It's also how the userspace messenger works, for the same reason.

> I believe that we have some wrong logic in current implementation.

AFAIR it's supposed to be looping with an exponential backoff, so it
shouldn't busy loop.  If it gets into an actual busy loop on a vanilla
kernel, that is something to look into.  The backoff factor and upper
limit could probably be tweaked too, if needed.

Thanks,

                Ilya

