Return-Path: <linux-fsdevel+bounces-66447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C94C1F723
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 11:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B02423CAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4817A354AC2;
	Thu, 30 Oct 2025 10:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbVoCkV5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C25A3546FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 10:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818767; cv=none; b=YHZPTeY2loabGw2zCVovXnhebeRq04G7Sv95pzcCLRLjAHCpfvoEO9ZSB0XaGXWPQqjBc/JJ2Gq0PBbDg8mkOSlB+94/U6Hmglk+GrZM0dVVzK0gzQ3bxeE7lyGTc22rtoP1do44Omv2vguHXXHzf0O/Un6C+e4cPNLFI/vGaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818767; c=relaxed/simple;
	bh=ck8LSBHKPeutEEduvO4hk2YZpUlglnNVZAj0p3d+tZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNqQ8WWVyIONfNw6OnxPSLlRrqEdcOBS4MsK8E/ASczY0wI6Y78IWQFX2NYXbmRTgRnd6iQaXwz7qnVD/APa6uha7UrQzaUzvU71krA6uN5P1y2WJtVKHf8QrozC0FBH+nM9eQOvGCOGxHy4GWZOx/oQz+oeq1YTsb92kXEfpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbVoCkV5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63c4b41b38cso1634563a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761818763; x=1762423563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpRra+YYaNP2bxzICIK5uG5yzLGIWfb13z8p6QQVNS8=;
        b=KbVoCkV5XQDK6FQ5lr83bsRgtJIt+5Vc70zwmnwMH7yJUtE98px28O+LOgbwCl8AJN
         dsY2GPkE6gPDifn9bH6kNb5ckFO3pPd9Fe8smgdgvSA+mTKFKOfFA7uZf4QJFE3VauHu
         7uxRB6M727v511czL2O4jAnZ9qn4m2VElL/RAeQiPy9t5/bVFE7DOGD6QpwW4wgKO/rE
         8YeV9+9Un/rfK9dnGpBKhIX4BoDpiINpJMPAxTewj0k2KgDGZsrfcvU7qLjtd23Fstve
         bkh1iqmiqSDfCZszJYYBp1nv8eKXHJ/M3Fx0TwcL+x4PKzD2Tw7xBzvc9UcnrZCkmm6e
         zHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761818763; x=1762423563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpRra+YYaNP2bxzICIK5uG5yzLGIWfb13z8p6QQVNS8=;
        b=b/Pv3R1Y/CmYAl0nx0OHHU84/fI4h+O+QX1yMATMKLS69Pvo/INOEObtKi1/P4xRc2
         84XmYXHqwKPqMhBIFr2inh4Aq8d5gB5z5oxQucvDQ1yu/ZEkRiM0K5MK8zyWwTR9dD+k
         8gP7b4BMOVH2slsOqoqIM7Yd04Y4zYfPx4j5I2gHKcgpidu5t34u89cb4M7syqsOzAk3
         FzG4rULLXL+BcRU6a//EOD4r3U3Z1PR4LtiJ9KOtywt6bCAEyKcpFHMb9L5QM3NSMmPk
         soGFkCFS3yQugCwMCiwPUKQRrNBmSalAGBzmd9CmkBml8LiD+RndJUFe8O7P51WXv4aR
         ctaw==
X-Forwarded-Encrypted: i=1; AJvYcCU3ZwjHtvRFUhMsphtoYT8LLtQWwqaqMMY1lpaYCyA84r5h95Bj0ZtOhA/XoZs4ObOCz4R1zQrvlMjPSOh0@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4RclpIwepeb42wU2zLWrUCW8opxhPPTNqYq3vQAWF+oxl6uF
	wZ1jZ5P5u3QieKIAAoHK030OJX75k6Hfxmisx4IFliVSuUMd36LqwXbbWh9Ux9WL38uoJtpq08i
	LQFXW6v2CUpcONRrGg8V4Gh6Bw9WJjFg=
X-Gm-Gg: ASbGncvdxLstZJpnJwJlRqAcYNDwhSiIB553jBKsn+dHlmEu5ltZGVNw8veL4LTSZka
	GH5MDG+sfg1uHkayKqf1kGBGBNWIG4pxJbfbJvYGxyUi7qKU77Vmq9ChyFrPEMMiU9TX52BYXvZ
	1uDZImyh21vVg/poTobOD44Qi4rRJ9EQHsCToEcRxU9W17tiNMjmGJhjMccetwF5x85eLF+DrDh
	YgO1yjL1YT5cJNOr8nTI1p5u6l60NdjNsUcbkAI8HJZEfi/aYT5rWQkTnsOs7bkbJLTf6LdrpdH
	a/L4YBoLnnO5gkVYdOU=
X-Google-Smtp-Source: AGHT+IEayt9kMjjupQxpl5WLpsB234iE8hKztdLOW4j/gh/ByTR/f9GKoYV6XqFI1badI7TIU5oxgv5EjeZJQhrKVsc=
X-Received: by 2002:a05:6402:5106:b0:63c:18e:1dee with SMTP id
 4fb4d7f45d1cf-64044252109mr5197576a12.24.1761818763254; Thu, 30 Oct 2025
 03:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169819804.1433624.11241650941850700038.stgit@frogsfrogsfrogs> <176169820480.1433624.3763033606730126640.stgit@frogsfrogsfrogs>
In-Reply-To: <176169820480.1433624.3763033606730126640.stgit@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Oct 2025 11:05:52 +0100
X-Gm-Features: AWmQ_bml8OwCVaqNQBU5P31b-DWNxcYedjaNrUhbws2VGFTKx58LLfTNxkNO3Ds
Message-ID: <CAOQ4uxgoZ_wrExQLsO2CfF8AFQ+n2T1WBHenwuteMUdnoO+Piw@mail.gmail.com>
Subject: Re: [PATCH 27/33] generic/050: skip test because fuse2fs doesn't have
 stable output
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: zlang@redhat.com, neal@gompa.dev, fstests@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	joannelkoong@gmail.com, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:30=E2=80=AFAM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> fuse2fs doesn't have a stable output, so skip this test for now.
>
> --- a/tests/generic/050.out      2025-07-15 14:45:14.951719283 -0700
> +++ b/tests/generic/050.out.bad        2025-07-16 14:06:28.283170486 -070=
0
> @@ -1,7 +1,7 @@
>  QA output created by 050
> +FUSE2FS (sdd): Warning: Mounting unchecked fs, running e2fsck is recomme=
nded.

oopsy here

>  setting device read-only
>  mounting read-only block device:
> -mount: device write-protected, mounting read-only
>  touching file on read-only filesystem (should fail)
>  touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system
>  unmounting read-only filesystem
> @@ -12,10 +12,10 @@
>  unmounting shutdown filesystem:
>  setting device read-only
>  mounting filesystem that needs recovery on a read-only device:
> -mount: device write-protected, mounting read-only
>  unmounting read-only filesystem
>  mounting filesystem with -o norecovery on a read-only device:
> -mount: device write-protected, mounting read-only
> +FUSE2FS (sdd): read-only device, trying to mount norecovery
> +FUSE2FS (sdd): Warning: Mounting unchecked fs, running e2fsck is recomme=
nded

and here

>  unmounting read-only filesystem
>  setting device read-write
>  mounting filesystem that needs recovery with -o ro:
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  tests/generic/050 |    4 ++++
>  1 file changed, 4 insertions(+)
>
>
> diff --git a/tests/generic/050 b/tests/generic/050
> index 3bc371756fd221..13fbdbbfeed2b6 100755
> --- a/tests/generic/050
> +++ b/tests/generic/050
> @@ -47,6 +47,10 @@ elif [ "$FSTYP" =3D "btrfs" ]; then
>         # it can be treated as "nojournal".
>         features=3D"nojournal"
>  fi
> +if [[ "$FSTYP" =3D~ fuse.ext[234] ]]; then
> +       # fuse2fs doesn't have stable output, skip this test...
> +       _notrun "fuse doesn't have stable output"
> +fi

Is this statement correct in general for fuse or specifically for fuse2fs?

If general, than I would rather foresee fuse.xfs and make it:

if [[ ! "$FSTYP" =3D~ fuse.* ]];

Thanks,
Amir.

