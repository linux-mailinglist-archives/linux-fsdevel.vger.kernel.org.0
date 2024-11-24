Return-Path: <linux-fsdevel+bounces-35710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D999D77A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 20:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02F53B2DB0A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5F45027;
	Sun, 24 Nov 2024 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jqa3uYGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D05817;
	Sun, 24 Nov 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467621; cv=none; b=UE1BZkQxeH+TahtYNGIFo6ec2EWXAzXlykm6Hu8HlZHuBtcIGvIzdPiGAKSzPHURKdE5/Als5xwbYhQL6d8CSdODTyU8XNet+hiqN63hMD37ql/A0uU3riOiMrtN0Q6I/C475h9yqElar9DnsnXMiURztGpD0oPV8IsD4k/cahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467621; c=relaxed/simple;
	bh=/dPK4ynzgFtqr2qpQqwWyiqEkCdCMGKEAgNLD+QRTJs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XR9otarp0g2APsrVLKmV5JGXFJ9JhMs6OGt9m3w/oC4qIE0apqPaTPs6XiYQ8+qxfv4faauksQyTQ7T0vjRHTF73HB4Jq4L8lWgowfdtMSHJC+A4onKijCnkapeHPxfYYRFEYuWbbOWUMWUppMmkUwOJdm+fAVaAoMi2eCg1QWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jqa3uYGs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cedf5fe237so4399856a12.3;
        Sun, 24 Nov 2024 09:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732467618; x=1733072418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnBOeKn3QqtUgUhyApq6CMxnsh9yVP3Ww8aT4BQoRkQ=;
        b=Jqa3uYGsJMKWgoi6YU35JsDvq9XZFNYLm9Vzk1REOY/MpEYvdMT46xhxbElfaWyolp
         dZmompuqDCBYC22zI2RzEEYq4udLnUxHapyY8e3nhFbD4BFYnEEATJZN/2FGshlNzwDp
         +f7+vEqdIh5lG0EwqzjCdYu1csRV4BSYYWDRenB7OxBNWcrGDKCJe/Pnjcr8RS9Uuf3C
         q9dOQNgzF8ETTS57Yxg7SBBDsNFQkVwQRWD4VqBukAbyiY3+Wo29XvfqzrdkvKXVQMGo
         9OSM95ZJCeUcFjH2HMoHMX0epVz8QyTZkg5fQGQxZasKYzxB3UWdSSt4qVT8se4kDBcN
         5hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732467618; x=1733072418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnBOeKn3QqtUgUhyApq6CMxnsh9yVP3Ww8aT4BQoRkQ=;
        b=Lg6HS6OLbxc+LlOS/bLXZz+T3j2GS7msln5eCyBxFai045k0sm1YeclFlX/84QDAAe
         /YbusO4EEFnVlI66mXe9YPOuqnLXfS4v+dBsxBSQO+xerZHo1QOy5rseD52YVk9kbyM/
         JY8TIjCSHxBITpTIPiBP2CcXmfFCbacJzzVlREkgz0ietEqwSFmFAjkaaBhKxWZw9Zwo
         nE9U4dycnYYYXFeYmqHOVhEMaBCHvVgvmDLJ/PX5THzGFCA0MXa7Wvyqzx4SCmTYLJbX
         nLKrcL77jDpM8k4kbFFm/foGqQJYBbNhu9DSd2LjS7CRVlycq1owAgWeZCKYByAxcedG
         cdgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTFt4SruARTVH9cIYZdWqnVbHrSwd38jeg1jSvLALCLgiEcNa6doZ2J2rLl+29z3dwzYNmDyoSCJehVTSA@vger.kernel.org, AJvYcCV1VqaZ0BrNYqzjA6vvSv2oOv7IstekE0fEC+MJBDzrKavFqqI937+68yBW9Mza2cf5fxFFJEuJsUzenrUa@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXikHBnXIvs9TJGZtoBRWUhpQEgVRsUxxE2cwCvuIzFuvxQ0E
	5P5ZnXAWdNmhEiciQJGOYBEF/O4Adg9nFkAXw2XvyYUsy5tVWozOirfcUkaEOAeHB+fj0CN78Vg
	+aW56sRBs76yZix4JL/Eik1AGujXeLFbE
X-Gm-Gg: ASbGnculiN5L1OkI2MqUd1Zl5qkIZVMJPvw6mekL/KtKCEmsfoRmUA0XqneZU8L/ixS
	RR2NKPuBQxsFYor1T0DA8twO3GSGx64M=
X-Google-Smtp-Source: AGHT+IFUjmq8M6ekp5andxQ+Z87JV3aXleH6sakQSHrltlHeZfHvUX0OUbv6OH2LdPer/68ob/MgbYZeGL5PGi+4W7U=
X-Received: by 2002:a17:906:3110:b0:aa5:46e7:4baa with SMTP id
 a640c23a62f3a-aa546e755f4mr272194766b.7.1732467618001; Sun, 24 Nov 2024
 09:00:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whoEWma-c-ZTj=fpXtD+1EyYimW4TwqDV9FeUVVfzwang@mail.gmail.com>
 <20241124-work-cred-v1-0-f352241c3970@kernel.org>
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 24 Nov 2024 18:00:07 +0100
Message-ID: <CAOQ4uxhdnv0H4w=V_FXxpDPsVB5Y9noS=ksqy1=CATJUXLKVfA@mail.gmail.com>
Subject: Re: [PATCH 00/26] cred: rework {override,revert}_creds()
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 24, 2024 at 2:44=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> For the v6.13 cycle we switched overlayfs to a variant of
> override_creds() that doesn't take an extra reference. To this end I
> suggested introducing {override,revert}_creds_light() which overlayfs
> could use.
>
> This seems to work rather well. As Linus correctly points out that we
> should look into unifying both and simply make {override,revert}_creds()
> do what {override,revert}_creds_light() currently does. Caller's that
> really need the extra reference count can take it manually.
>
> This series does all that. Afaict, most callers can be directly
> converted over and can avoid the extra reference count completely.
>
> Lightly tested.

FWIW, your work.cred branch passes the overlayfs tests.

Thanks,
Amir.

>
> ---
> Christian Brauner (26):
>       tree-wide: s/override_creds()/override_creds_light(get_new_cred())/=
g
>       cred: return old creds from revert_creds_light()
>       tree-wide: s/revert_creds()/put_cred(revert_creds_light())/g
>       cred: remove old {override,revert}_creds() helpers
>       tree-wide: s/override_creds_light()/override_creds()/g
>       tree-wide: s/revert_creds_light()/revert_creds()/g
>       firmware: avoid pointless reference count bump
>       sev-dev: avoid pointless cred reference count bump
>       target_core_configfs: avoid pointless cred reference count bump
>       aio: avoid pointless cred reference count bump
>       binfmt_misc: avoid pointless cred reference count bump
>       coredump: avoid pointless cred reference count bump
>       nfs/localio: avoid pointless cred reference count bumps
>       nfs/nfs4idmap: avoid pointless reference count bump
>       nfs/nfs4recover: avoid pointless cred reference count bump
>       nfsfh: avoid pointless cred reference count bump
>       open: avoid pointless cred reference count bump
>       ovl: avoid pointless cred reference count bump
>       cifs: avoid pointless cred reference count bump
>       cifs: avoid pointless cred reference count bump
>       smb: avoid pointless cred reference count bump
>       io_uring: avoid pointless cred reference count bump
>       acct: avoid pointless reference count bump
>       cgroup: avoid pointless cred reference count bump
>       trace: avoid pointless cred reference count bump
>       dns_resolver: avoid pointless cred reference count bump
>
>  drivers/base/firmware_loader/main.c   |  3 +--
>  drivers/crypto/ccp/sev-dev.c          |  2 +-
>  drivers/target/target_core_configfs.c |  3 +--
>  fs/aio.c                              |  3 +--
>  fs/backing-file.c                     | 20 +++++++-------
>  fs/cachefiles/internal.h              |  4 +--
>  fs/nfsd/auth.c                        |  4 +--
>  fs/nfsd/filecache.c                   |  2 +-
>  fs/nfsd/nfs4recover.c                 |  3 +--
>  fs/nfsd/nfsfh.c                       |  1 -
>  fs/open.c                             | 10 ++-----
>  fs/overlayfs/copy_up.c                |  6 ++---
>  fs/overlayfs/dir.c                    |  4 +--
>  fs/overlayfs/util.c                   |  4 +--
>  fs/smb/server/smb_common.c            |  4 +--
>  include/linux/cred.h                  | 14 ++++------
>  kernel/cred.c                         | 50 -----------------------------=
------
>  kernel/trace/trace_events_user.c      |  3 +--
>  18 files changed, 35 insertions(+), 105 deletions(-)
> ---
> base-commit: 228a1157fb9fec47eb135b51c0202b574e079ebf
> change-id: 20241124-work-cred-349b65450082
>

