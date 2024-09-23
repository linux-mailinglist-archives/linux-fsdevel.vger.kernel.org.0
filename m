Return-Path: <linux-fsdevel+bounces-29841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E560297EAB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 13:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62B42817C7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B319883C;
	Mon, 23 Sep 2024 11:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk3hkFb9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94795944E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 11:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090815; cv=none; b=nQ+qZ1tzTps6WyHA1ARRgXWjL8v9agGiN4kgAG+3Fpu38SvQEWJ51kEoDbAKWbmSJ5yxmCxcuN9RqasbYhOzYofgTTbfPpDcPw/RDE71qxCgsDVoVkgUIBlom8ssXxFBqtHYcDRNklnx5Q7gdOCB7X3y2v/AsaEA7BH1lmFAZc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090815; c=relaxed/simple;
	bh=zvkc3m6+0BNJYDVSp8LLKAynZJrfFIXxrbm82fzt6JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=byp4TEl1WrrMgKSfuItbKsngLnrPq90Mqlf0IsfxZ9dqcL+eLWIm0MJsIMAAdrjO8m+0PMNHn7kDIHs1ZEVsZfUuymGazesk2MMmy3Acs7vkpuIZ7OHa8MVH3RkJ/uUQC4Q5TjgYmM8ae/AReq2/j9NlibNtr0Q7Q/emDYi6Fdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk3hkFb9; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6c35a23b378so29996096d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727090812; x=1727695612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvkc3m6+0BNJYDVSp8LLKAynZJrfFIXxrbm82fzt6JA=;
        b=Uk3hkFb9QRzKls3lO1Ri292UdSYbOjHwrIQ8bEZ6MwpmNp/sWvhwMy+/Ce+/Z2BYIR
         CcG6RKQd/uPMEmghgQhlnbdhoTMi/w6YdYltwGYML3Da0neg2aGq8EuQoP+qv4N4iqwU
         1dluJ7Nm4xzj9SjdkD0+eL+PHPvFwPM6PBYfPAp6sBXefja+Sf5VTdhPr/uYkdkiLNgP
         LbIgXuZurE+c7EcfRKWCVlsAReKkBDDVukVjr0uQCAOmCoqFVem3IH2QpT92khsKsIkO
         bzRpxf2rSnv4C9bN7D4hKORtDWsQxn7CLV+XJ53IcTrTxx1NOSt6EfB7MwpWx3jYNaHl
         f0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727090812; x=1727695612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zvkc3m6+0BNJYDVSp8LLKAynZJrfFIXxrbm82fzt6JA=;
        b=Tu1t2rN7iWqwE/asUXNCXHSHMKehDOpJTRCL4uwlPyQa6y8SrLR+aYntOUkpoqbfmf
         qOVGWz20O3crqeizRg0Yl2QyTcR4pmJelNWQop0On3c0W/gDRc2FsrC40aPPCZnwHCfu
         orAGW6CTwVEFpvW/RhDxXkd3JiZ+vYjul7Mh/lzxwRd2hC8eRWdg2UuF2yOIMkD0zy0Y
         LNQrHES6gJY1yybzvwoxu84p0klCTkUYG/ZvHnsQhHgYUe97IAJJI/BghYgR+CP1/Me8
         erQDPiqxnvBV0qExVojcaHyXq1hQtVCqX7Z0obBD533wMm4OZQSm9ZZrRzg8YodJtG/s
         lpHw==
X-Gm-Message-State: AOJu0Yz0qLw7P28v6Y7nSn3m0tNhBcj0X6PPo58KA97Cf/3re8ngzTAD
	if4caY1mvo2kF/n7406GNFKE+1X34HGBI//k4TJbeuIY7483/JdHU3UnNVFXS1sbJnKdZ+9DWSu
	JzH/4MtrueSWxaUAlnwemFP+Czno=
X-Google-Smtp-Source: AGHT+IGZkx85E1rp+f4UIcAI0lXkwJ/nUO4EkDrCydJQbBFpwhKPPlYivTQHPkOJqVgl39uCRdcs/y2NcwzpDFU/In4=
X-Received: by 2002:a05:6214:5548:b0:6c5:60bd:2c8b with SMTP id
 6a1803df08f44-6c7bc834aecmr149809726d6.49.1727090812278; Mon, 23 Sep 2024
 04:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 23 Sep 2024 13:26:40 +0200
Message-ID: <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
Subject: Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "jack@suse.cz" <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 21, 2024 at 1:17=E2=80=AFPM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
>
> Hi experts,
>

Hi Krishna,

> Need your help in identifying the root cause for issue.
>
> We've seen multiple reports of git repositories failing to clone / gettin=
g corrupted in p9 file system.
> The mount points under this file system are marked for FANOTIFY(flags: FA=
N_MARK_ADD | FAN_MARK_MOUNT) to intercept file system events
>

Which events? Permission events I suppose? Which ones exactly?

> When we remove the marking on these mount points, git clone succeeds.
>
> Following is the error message:
> kvitta@DESKTOP-OOHD5UG:/mnt/c/Users/Krishna Vivek$ git clone https://gith=
ub.com/zlatko-michailov/abc.git gtest
> Cloning into 'gtest'...
> fatal: unknown error occurred while reading the configuration files
>
> We have a MDE(Microsoft Defender for Endpoint) for Linux client running o=
n the this device which marks the filesystems for FANOTIFY to listen to fil=
e system events. And, the issue(git clone failure) is occurring only in mou=
nt points of p9 file systems.
>
> Following is the system information
>
> root@DESKTOP-OOHD5UG [ ~ ]# cat /etc/os-release
> NAME=3D"Common Base Linux Mariner"
> VERSION=3D"2.0.20240609"
> ID=3Dmariner
> VERSION_ID=3D"2.0"
> PRETTY_NAME=3D"CBL-Mariner/Linux"
> ANSI_COLOR=3D"1;34"
> HOME_URL=3Dhttps://aka.ms/cbl-mariner
> BUG_REPORT_URL=3Dhttps://aka.ms/cbl-mariner
> SUPPORT_URL=3Dhttps://aka.ms/cbl-mariner
>
> root@DESKTOP-OOHD5UG [ ~ ]# uname -a
> Linux DESKTOP-OOHD5UG 5.15.153.1-microsoft-standard-WSL2 #1 SMP Fri Mar 2=
9 23:14:13 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux
>

I wonder if you have an option to test with LTS kernel >=3D 5.15.154
because that contains many fanotify backports from a much more recent kerne=
l.

> On collecting the strace of the operation(git clone <repo link>), it is f=
ound that renaming file name from .git/config.lock to .git/config and subse=
quent read of that latter is failing.
>

Failing with which error? Can you provide the strace output?

> Any known issues in this regard ?
>
> Let us know if you require further information.

Which mount options for 9p? is fscache enabled?

Are you reporting a kernel regression?
IOW, did this test case ever work with 9p as far as you know?

Unless you are reporting a kernel regression this might be an issue of
MDE over 9p,
so will need debugging information about the decisions that MDE makes.

Thanks,
Amir.

