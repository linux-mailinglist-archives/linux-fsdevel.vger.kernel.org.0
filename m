Return-Path: <linux-fsdevel+bounces-72203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEFCCE7CA7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 19:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAD02300E455
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Dec 2025 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B189D29BDA5;
	Mon, 29 Dec 2025 18:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvMpVR4y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB417A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 18:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767031408; cv=none; b=HM7wYmwn5quoIshvJDJ6CRAKUh6NqANXBViYh/f9KqYHvwiPjUFgPXJ9l47BQbq3q2tTYz4Wz+YdXRAgs3UOKNPJedJyogNYboK+92oqwA9vzUhAORka3zhE4VsZw12DESP+7QPe/ftxGPJck459yJkWZ85YgfWAdLIbQw//8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767031408; c=relaxed/simple;
	bh=ZwWuLwkmSXY0STY7aPx0HBt0F3AeKNpiJEx7GgB5Y6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IoJrVv67WfMSURKyqgFEK2EpDQQyq88yblKumBMjUc5Kz0lsnZlClyXPzJefkwLjHoAI9TB5/e13m/QodhlOWl9kb7Z7lfFI7u37wmANFhOriEUko2K+vWvdgygDDQMFyMnAiq0CHO65qjpST93a2Re2zGGgwtZ77/F2kOCFD/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvMpVR4y; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4f1b147eaa9so73956651cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Dec 2025 10:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767031405; x=1767636205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JXTk7GEtpJ3tqQ216JIlp0FFRi8UcGdBGD2HLd9eCk=;
        b=XvMpVR4yLIGZ+CSAX1CfVd8gUBytw3+zCezUNxEl86SVebEjtXfJ8hDgjanfD9oiMk
         B9R08AT/HFOAAiSHfQFELK+Duvh9EqC5AU3hipmBxpKM8f/yarB/+sBlJufylO7YBWSE
         5iOqs4jIA3NGrJRITQedXg1EzQNk3yrbhgQo9Dp75TcMQKkLN/yMD9GvB+TiAAXAaDcy
         ik4MoXriIOZTKOurVJX8V/e2TtsWTlrBHY6/thK2zGxQU15eSHA08prTKJtocKZbSOAF
         ua2GrhNRChlK9nAL5TL+24V1n/yfsHW0+I/XgrUxE8XJZrkctzvRoyTc9tJ0hJbSo6Pm
         eB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767031405; x=1767636205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7JXTk7GEtpJ3tqQ216JIlp0FFRi8UcGdBGD2HLd9eCk=;
        b=crMBfflxrjlA5f2TUOJGtUbpUVyAg8aIPXoLOlv8CL/J6uiRTmIipxxnOm5QO2oqn2
         5ZFzi1O4MmSTseeMn+AkwXzOLp6OF41I1QTnHjc8ZUOo9rUcIK9o+wbud3d9iL/nyFUc
         jh7UDA/GAeBYlobGZPLAiMK5Vjfawe5gj8sv4pgXF6Mkr1+wI2CNTsh0K7X+8vjmTD9d
         AcAUW7F7bXWmHbK5wmZiw8zE2ZzBl3BO+xtITXoansEq7Efhb/s7pXn2G5hJhP1kVEg9
         B0vxBDoDxnJMDAnymK0jM9je1KQbozyi/1Vnzrj0VRxlzG7g00MFCUgAVRR0cloyADdQ
         0yWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCNOEe54sXM79lThSe+z6cdZdOtEpX5dvsxXyoqD+oYvoUKBGz/9LVHswt3YNbIk4xzTkQKCAJELFH5GkL@vger.kernel.org
X-Gm-Message-State: AOJu0YzA3dWv/BlhHhYLbinVdUnr5NrY088+CENuQt9srqATxBl6qkho
	ODV8v/JkJOvRhcgjHtmiCr5cL2rVkb3E9fmygcmuaS/iUxZl7cKoFODxod0V1+PKVNE2fmXibIf
	CgKvoi5huiw5df2hXb/9hD7KBK9Z0AeU=
X-Gm-Gg: AY/fxX6RPczyFNP0EyzpNLudzHU0F61iwHjc6wGfPi7yke5YFIU2OiJv1HmxABcSTZl
	q46ZJDEflYaXrx6uWTJavb+rD/qNAqxuiGCZ4BQKBRpwRtr0q5TAfQNDBMDXxFcjVdHeAWs58Ct
	shlqqyGHhoASaMq4PNCrGQe45sJ/8HSY2OSYejtXKqc8AsJzNUCOCFvOQJTUy1OmiQ9RGBzKj9W
	maV4dv2HByUfxdCFoKNb+mf7HomTSHQfwDs2w5LjH9fpt6GgzTwNiXgWluSU0ERVuM1Rt96lAHM
	nY2E
X-Google-Smtp-Source: AGHT+IFmn1Nc1A4qKp+F6lWdzXzQ/b6lDcGpHTbKSCCIQKYYC1vNICvW9QYI6joMivwKvI7D6KkWBMlQ5N32miNF+QE=
X-Received: by 2002:a05:622a:14d2:b0:4ee:739:142 with SMTP id
 d75a77b69052e-4f4abd9950cmr440014831cf.51.1767031405308; Mon, 29 Dec 2025
 10:03:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
In-Reply-To: <CAGmFzSc=YbHdaFbGQOrs_E4-MBXrM7QwXZ0DuKAGW1Ers2q=Rg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 29 Dec 2025 10:03:13 -0800
X-Gm-Features: AQt7F2rPtVpquiS2QlEcO0Ma_FhS3t4Ug5lROLlZezY5r26WfXkXF-Kyw246xZU
Message-ID: <CAJnrk1ZOYnXpY0qf3yU41gQUHjyHOdBhAdyRPt_kaBmhvjr_9g@mail.gmail.com>
Subject: Re: feedback: fuse/io-uring: add kernel-managed buffer rings and zero-copy
To: Gang He <dchg2000@gmail.com>
Cc: 20251223003522.3055912-1-joannelkoong@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 12:13=E2=80=AFAM Gang He <dchg2000@gmail.com> wrote=
:
>
> Hi Joanne Koong,
>
> I tested your v3 patch set about fuse/io-uring: add kernel-managed
> buffer rings and zero-copy. There are some feedbacks for your
> reference.
> 1) the fuse file system looks workable after your 25 patches are
> applied in the latest Linux kernel source.
> 2)I did not see any performance improvement with your patch set. I
> also used my fio commands to do some testing, e.g.,
>  fio -direct=3D0 --filename=3Dsingfile --rw=3Dwrite -iodepth=3D1
> --ioengine=3Dlibaio --bs=3D1M --size=3D16G --runtime=3D60 --numjobs=3D1
> -name=3Dtest_fuse1
>  fio -direct=3D0 --filename=3Dsingfile --rw=3Dread  -iodepth=3D1
> --ioengine=3Dlibaio --bs=3D1M --size=3D16G --runtime=3D60 --numjobs=3D1
> -name=3Dtest_fuse2
>
> Anyway, I am very glad to see your commits, but can you tell us how to
> show your patch set really change the fuse rw performance?

Hi Gang,

Which server are you using? passthrough_hp? If you're using
passthrough_hp, can you paste the command you're using to start up the
server?

I tried out the fio command you listed above (except using size=3D1G
instead of size=3D16G to make it fit on my VM, but that shouldn't make
any difference). I'm still seeing for reads a noticeable difference
where the baseline throughput is about 2100 MiB/s and with zero-copy
I'm seeing about 2700 MiB/s. The server I'm using is passthrough_hp.

Thanks,
Joanne
>
> Thanks
> Gang

