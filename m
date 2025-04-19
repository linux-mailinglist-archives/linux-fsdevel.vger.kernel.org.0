Return-Path: <linux-fsdevel+bounces-46716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2812AA9433E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5243D17D2BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 11:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCB71D5ADC;
	Sat, 19 Apr 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fl8/5JGV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C181ACA
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 11:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745063298; cv=none; b=WfJjz9zWj/mb6Jn/tBzsdo+/BSJ/gEyruWV60VjEeupG1FzF8V84NFcp9uvjSRlcZ53SKLBItIvhJBu1XxcY0R2Y0GAJQxz/Ee112S4KlCWk86q5kBGwNuiNIevlh8PlS0Amr+RqYmdgB6sZ+l9yIwWh6xTK1of1mQVAcBDWyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745063298; c=relaxed/simple;
	bh=PSb5PN/LaJ15HlBdHJ5Jkg+eEZt9G1KmQh7aOU8kKq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbJUHGLY4loJsFjg5b+d4BifJxgsDpKYfdgjKyr5yd97ICp5iS9+u+KT22mncHHMLfIbyovGCqzd6KZ9YhVqhif5cFR9Kep4PpIBUEN2fLEVkMPINw5jfmSbTJee/Ek45nr3/4ZXElRBLD8BZeiI+7YyjCxx8dbCkdnz1pOKsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fl8/5JGV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so476163766b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 04:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745063294; x=1745668094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nbo5nJ+Dg1Wvgmweqdc9mK4kAIaK9vSzYYsEieDE3HY=;
        b=Fl8/5JGVgXLmiqwhM9U0RwtXd1jug6fOl6wZKjNY7nJw96mKqljJKGOR1JdL8IbPIj
         STDSkCIi/qPJTf91zNU2jnbbaWPB8+puxfURoXZLcvCtQwVua3OKLNe7FTQ9ZVOke6jr
         ZAFdm1cyMC21YhyvlI7da7/9XzyBRLOBpCPcd28s3FTqf0dchmt3TMbIvFuK8A5IMlae
         824R/LWmh45TlB1f9ERMQ8jYwOzob0zPcZ2Lomre+HiMgusk/J2wqJpVCp+bNgRgBii6
         MLFkzwAoOsL8iRh/RgIt358ALtyUtp72D0Ab9UmIpwYtztQZ36dTmgVRpZxBjiI1ndKK
         EHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745063294; x=1745668094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nbo5nJ+Dg1Wvgmweqdc9mK4kAIaK9vSzYYsEieDE3HY=;
        b=kNY1+0UJ/8a6f/0pjGNwYC5rzJAQwcS5YGq1xixpTAYvYh0YmzvXhKyb726/xi97sG
         lqzR2uGOVQUUhjoPCgsgtWDfyHWw4UItGaUbM41CmCRBiOaORLetGmSFRwHYKyrc+0Tb
         HjiSxMB8+BBFDQnaWGyP2m3tdJSeOishF6U89YRau4hQ2UDHmdJGC2NkHHDR03ah4ZLz
         cL7VUX52H7jmXuXNhTpdPHjJs/PDdziesS2WUwaEUm1khZ6CQajLix9rSk6Xv1NAHkzR
         Mt94BGkiIlQfaFqjCT5m3vn+KR3IgnGzYTthLmf56M+gAQ2AgWSxIF1hmWk2Cdl271KF
         C/rA==
X-Forwarded-Encrypted: i=1; AJvYcCWC9hbPuvdh6lQZLzy2jtY0GZGMWeKRjzqAR3JHXLLnW4KcRSIXL/HowDkIi5fvzwQ1F/uGAHpRgw38nY2D@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0rojCzRoYQNikPqIsxMFPFE+H1/E3aZH4d1mWDVckDjkNcttZ
	8t5RwPCcWAVV+CRJcrhG/Lylnws1f5pVwgnUgR5KMDILSyvcnu7cQA+oJQPYSvnOm+LlQMAIRjy
	yeEjf50UF8dQ/yWSpICe4NygTzqnb4izMt0g=
X-Gm-Gg: ASbGnctbEzlcYcg6dPQhW1KFgaUtlxq2aSl9GEdoJjHFrUh9UQPBZqbg6X4WV8nPEWb
	p/BUFRsm3n9AKPrTmxv48urzjrog5OBk4pgk6kEPxNWT35R9aWvAXuYFk2+TNWcqUwK2ooaNyyY
	AK9v0UFuqRix6Vv+8yOkgHEg==
X-Google-Smtp-Source: AGHT+IGawv/oQRU2bcs8NwXPaMxH4xIS7lCpqXhdqFNe05Fh6Rpi9VyYES0fhL5dYRUXpdLrPW3juYJmj2+HXLEPVcE=
X-Received: by 2002:a17:906:c154:b0:acb:5ae1:f6c7 with SMTP id
 a640c23a62f3a-acb74adb850mr454464966b.11.1745063293477; Sat, 19 Apr 2025
 04:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419100657.2654744-1-amir73il@gmail.com>
In-Reply-To: <20250419100657.2654744-1-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 19 Apr 2025 13:48:02 +0200
X-Gm-Features: ATxdqUFovmDarwRF9XjlK8TQZqApaQuGfii3Y0Iwqp0gh5t0CjyuQiGHQ1SqniI
Message-ID: <CAOQ4uxj1-8uFp1ShzcC5YXOXfvOrEMLCcB=i1Dr4LaCax03HDQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] User namespace aware fanotify
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 12:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
>
> Jan,
>
> This v2 is following a two years leap from the RFC path [1].
> the code is based on the mntns fix patches I posted and is available
> on my github [2].
>
> Since then, Christian added support for open_by_handle_at(2)
> to admin inside userns, which makes watching FS_USERNS_MOUNT
> sb more useful.
>
> And this should also be useful for Miklos' mntns mount tree watch
> inside userns.
>
> Tested sb/mount watches inside userns manually with fsnotifywatch -S
> and -M with some changes to inotify-tools [3].
>
> Ran mount-notify test manually inside userns and saw that it works
> after this change.
>
> I was going to write a variant of mount-notify selftest that clones
> also a userns, but did not get to it.
>
> Christian, Miklos,
>
> If you guys have interest and time in this work, it would be nice if
> you can help with this test variant or give me some pointers.
>
> I can work on the test and address review comments when I get back from
> vacation around rc5 time, but wanted to get this out soon for review.
>

FWIW, this is my failed attempt to copy what statmount_test_ns does
to mount-notify_test_ns:

https://github.com/amir73il/linux/commits/fanotify_selftests/

Maybe there is a simple way to fix it?
or maybe it should use the better infrastructure that Chritian
added for overlayfs selftests?

I did not have much time to look into it.

Thanks,
Amir.

>
> changes since v1:
> - Split cleanup patch (Jan)
> - Logic simplified a bit
> - Add support for mntns marks inside userns
>
> [1] https://lore.kernel.org/linux-fsdevel/20230416060722.1912831-1-amir73=
il@gmail.com/
> [2] https://github.com/amir73il/linux/commits/fanotify_userns/
> [3] https://github.com/amir73il/inotify-tools/commits/fanotify_userns/
>
> Amir Goldstein (2):
>   fanotify: remove redundant permission checks
>   fanotify: support watching filesystems and mounts inside userns
>
>  fs/notify/fanotify/fanotify.c      |  1 +
>  fs/notify/fanotify/fanotify_user.c | 47 ++++++++++++++++++------------
>  include/linux/fanotify.h           |  5 ++--
>  include/linux/fsnotify_backend.h   |  1 +
>  4 files changed, 32 insertions(+), 22 deletions(-)
>
> --
> 2.34.1
>

