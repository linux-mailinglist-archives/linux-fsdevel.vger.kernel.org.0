Return-Path: <linux-fsdevel+bounces-49023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E923CAB7947
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05ACD162511
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA40224AEE;
	Wed, 14 May 2025 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3MDQ0b6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B421C16D;
	Wed, 14 May 2025 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747263836; cv=none; b=DUoP8ScyirKaZSRBtWVbK5kZFoHij3eGHL3K4jErS7eoxdrbsGKekeVYsIMwBJtyX5Y+zqqdNakE9s93fyQwBDM9/0Si+9U4gLLDHsAajZ7NLb2uL96EG97L9TCgNZz2z6d2A27ryv3whGsb7lQYRfP6pXKD9GRwbJxrhswP7p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747263836; c=relaxed/simple;
	bh=JiaSEY2q1m/VU/U18b6n/bNJAaSQsucRFWniPhL8yZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K0xBeOcPTYrEjtpFILSFs6poaVJpQHEEkenhrrzZJeCGc8OlKxY4BpCLlYCMjXzNLM6VXzUKGpzIUeYUtPyAFbC3hD+edq3ScNaK0VDSjXsogiZdaeJs3j3IxQn7QQ2xAISOAJIATGRD+SsLA3wO3vIo+BsFypIA+u56nCWzWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3MDQ0b6; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-477296dce8dso4324561cf.3;
        Wed, 14 May 2025 16:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747263833; x=1747868633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiaSEY2q1m/VU/U18b6n/bNJAaSQsucRFWniPhL8yZg=;
        b=W3MDQ0b6lU5v1D88AtcKfUuZQY3iOo8xlVP5dcc1ZpKUDe9D85qo4SAkYeKuk3d8aQ
         6BxYY1dsVQPokY/+aoa+xXtdBCbKMvacBlP+7KKffJihEj8r7ug/qTu9YbfvAIEfeS1h
         +OPzxvJ01VHEObO/Ag7wNXdXx5zASdwv2i2Xcg2cn8TsWwQ9PXz44OgA8KBry1CU7qGn
         lgTYpU9OKjcNjx/wq4PmwC1aFY5JhaHrgdiHFmovlArPoxRklaCfo8yW/aqGUn0hbH19
         FOP0UDIYn/9ZwietcQLUxR/16TOjoilHVfUL2dxgumsOWyEHCG6kWbX0EmfH2uYD6yz4
         iBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747263833; x=1747868633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiaSEY2q1m/VU/U18b6n/bNJAaSQsucRFWniPhL8yZg=;
        b=StCQe+I07DSFS6cq1Ll6EKXfZdkTgk/5DWc3FSloPpBaHb0M/DK6RfELxPeKZayLtn
         Apn9S5yiQjr3Mq3nwUcZsxsiktZniluyQ1ha/rxLhqIgsDfynrq3EEhRcwQbV2I4lwsr
         1KJLDCBe0YQkzPkBeKwmQLhaFNl15/6OM3L8IvOMBOe8KuZSREcLCLYS0thw7AHvEKWp
         OgEDQ5YJ1S32xY7j6T6yz9spfMzkN5S9S0+hrQviW4n6gvzMW4u5JgNX8x3Wu64H5Kg+
         WDhmianvD+Hr40coobp6GmVyAOf4rxhhrIkICZMqJPY4cmKpBp8XfoQv/tXAy01fjb74
         7JDw==
X-Forwarded-Encrypted: i=1; AJvYcCV3lN+fcgXyHt7qvZhTZ48DIBAW1rqDrGFLQ83KpdU13B7YKxjQBo8+tjyMmsrjPllJn1QmoFmY6WnJE1zJ@vger.kernel.org, AJvYcCV4d5uq3R1dm1fw2MJH/MSgjVBAAPsZUlXU+vAsqeON9gCs+UNO7ovKiY6/GDV+nDhuQVOh9z5VjUF036IC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/V0NDKtEJ1OORy9Dj0HJ9dsW7Zgakm516+4E+qP8GZ8T8Qv5F
	d7BhwBg8m5X6EkVPfHdbhOkuovvmu/0vwF2Qz16tZNTqDeRK3GDP38vCW3ewykSN8aeGpTzsqBN
	YxeWvqE9FONXigIog9XthTvEzfs8=
X-Gm-Gg: ASbGncvwlVGPr+nCjrvrEU0fi+To91yt/4mHcR9fslqo1WVvyG+RmNfSm7PXqdQFvDp
	GqHQMD9uNb+oAkhzYL2QOMwz8YTNluaGiMQnlamvTbaIWj+ct3NjHSIB5QSvDmzxggdZvYkunZV
	ML/IIhZnI/72Ji3r2dheLh2FHhjH7Z2OtY
X-Google-Smtp-Source: AGHT+IFmDaklKWp2i/eCGiRl5Pax/EU6O2pehN6h4S1klYEEakMzA3gk3zT2iQ+m+CT9cUXP7o0HDwPdzVRnw6/Vmh4=
X-Received: by 2002:a05:622a:5a8f:b0:476:7b0b:30fb with SMTP id
 d75a77b69052e-49495c9c44bmr75855581cf.22.1747263833408; Wed, 14 May 2025
 16:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <CAOQ4uxjDwk6NA_UKiJuXfyY=2G33rruu3jr70pthFpBBbSgp1A@mail.gmail.com>
 <CAJfpegvEYUgEbpATpQx8NqVR33Mv-VK96C+gbTag1CEUeBqvnA@mail.gmail.com>
 <CAJnrk1ZxpOBENHk3Q1dJVY78RSdE+PtFR8UpYukT0dLJv3scHw@mail.gmail.com> <CAJfpegunxRn3EG3ZoQYteyZ3B6ny_DG1U65=VX25tohQuHCpVQ@mail.gmail.com>
In-Reply-To: <CAJfpegunxRn3EG3ZoQYteyZ3B6ny_DG1U65=VX25tohQuHCpVQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 May 2025 16:03:42 -0700
X-Gm-Features: AX0GCFughAO2uS0pEY_DdVUmp9BQvn96UCXQhtdV5dbbjs_VhUtOBQPkLvvdLFY
Message-ID: <CAJnrk1ZH3hwgtgOq7a=J-vxop5fCm5K_ZEek0W3kX9N1xf4HAA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] fuse: Expose more information of fuse backing
 files to userspace
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>, chenlinxuan@uniontech.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 1:50=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 13 May 2025 at 20:52, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > For getting from conn to fuse server pid, what about adding the server
> > pid to fuse's sysfs info? This use case has come up a few times in
> > production where we've encountered a stuck server and have wanted to
> > identify its pid. I have a patch on a branch I need to clean up and
> > send out for this, but it adds a new "info" file to
> > /sys/fs/fuse/connections/*/ where libfuse can write any identifying
> > info to that file like the server pid or name. If the connection gets
> > migrated to another process then libfuse is responsible for modifying
> > that to reflect the correct info.
>
> Fine, but then why not just write something in /var/run/fuse?

Oh cool, I didn't know there's a /var/run directory. But I guess one
advantage of doing it in sysfs is that it'll work for unprivileged
servers whereas I think with /var/run/, there needs to be elevated
permissions to write to anything in that directory path.


Thanks,
Joanne

>
> Thanks,
> Miklos

