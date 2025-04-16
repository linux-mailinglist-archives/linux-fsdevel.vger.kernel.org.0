Return-Path: <linux-fsdevel+bounces-46600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2FCA90EA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 00:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E39B67AE337
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B7423DE85;
	Wed, 16 Apr 2025 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N14pDKXT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9C9478;
	Wed, 16 Apr 2025 22:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744842935; cv=none; b=XfvGR+JR80NFmwJpIk6QVxBK2211gJhr6F9rIafeodr3BKYp71buA5DcSCNNdOvbbP5lKPI9QKGXnXuGDDQImpznQMXVxMmirGogxYpFjGlzA/TkzTQ4ymNskEusaDZorubSnRQ/PmZyKt3UO+ChqO2jzvRhGM0hnUwQ4hhbx4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744842935; c=relaxed/simple;
	bh=DnS8hkh/l+LdGfRFkl4ncWXFdlpFJ1XmLKJGC/9pGoU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tA6jk/Tf/qHsSdMvWIK33opYz44KXgTP+0LWVip6mYaZB7M8ano4ZCk0QZOtyE0C4BLQvvD2fH3580q5jU0jbSjTwPpbHixAG2uhGQjGSkVwZM0dVkWNxrsHB9pm/mni/I7lgNl80DfR4E0nBfYeXghStXPBRXnpNFEj+/Hbl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N14pDKXT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5cded3e2eso289704a12.0;
        Wed, 16 Apr 2025 15:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744842931; x=1745447731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHMWX+QHo6ciYAdyO1pkCtQ+YG4avnICwwmT4XL0M3s=;
        b=N14pDKXTa3qhcR6icouKFur6yscAMfzFZv9APq3bmcVE4N1KlFfTZIa72fXOZfM8wn
         mwO3ui4U0J8QrqLnCbf4N4iDLbgaEAcpJ56LscIz9QNlcsgqzMD9qzZgEyPtAuoObxF4
         uP2GgCV1f8SlCQtsos+8txF6nBQKWMUNpS6DLtYYL5vayXyB8Po4GrNyaIoxweRSN2wO
         VqJVDxk3biKiy6/U+Wu/cvT/BW7TT77CpojdbGZN/pbp2GUuFbmT/oxSu8szcao2V8rb
         0ELoQe1Li6nx286s1jVvcLgrpsBO74lIrnowMvOkRNgRNmhDKPivfqoD/OCeR1xHM18U
         5B/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744842931; x=1745447731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHMWX+QHo6ciYAdyO1pkCtQ+YG4avnICwwmT4XL0M3s=;
        b=VcD+jbqXa5F8SeivEJVgPmpty+uLm0l9Lgec8M6gsC2Nn7C8V5NLHZH4rMiVrPXTiL
         Qzi8lksa2hJ4Krc8oWT2Xl6pvdyxUR3y9P0KScCUAjHl9SooWniaYGNDk5LQbbZKUHH8
         ONtWN6zfChch3/ZtMuBZHvZH9WCrv9WHR6hQZGKlnjkIUE+ng5L5Y6R3skEu/rRRqeCh
         dMxI5+RoO7lDcCmh2bQVy4roQ7t7BuoNYOXhzISVlZySCuTfRhbHM2/Bib7Zqch+KnKm
         CNnoYodua2ZCSXucDWQlyEpt5rLn4L3ohFF0d1qU/CwMedAnOye9bbz2kPSUOcV17nA+
         chmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbpWhcxB0HAGnq0WD6TVA9ap2fcxcVWcpAZjGisOWtsSdHVpK9gQR5e/Tt0PGGRLgyKmhcC2hbeY9tixoq@vger.kernel.org, AJvYcCWdVpjrZ2/9f+bLN4uhWyLgHiR1URDy6YFS/B3gyOFSBVrGsSUGfWUfCiRqWf8f12S+hvUj9Lkpkbcnj40u@vger.kernel.org
X-Gm-Message-State: AOJu0YxliKy2Nq2f+H7mFXPhCxlGPLIose+yASjINbJKPQhO8nNJSL0t
	PAIKLSf0eMuFWnMB3Fx9RPy6ORTWE7fOR/rjfVLIZ+WKQrSkCi9S4jaYVXji+uDGc6C36sRCgGm
	8QVWdrrbNqTi7cHS2dP0OEQq/0AI=
X-Gm-Gg: ASbGncul+phrxg+g2EMqXiisc8X/1f2Ixer1KYoNP1U7lzYPCpGjBrhy5HxZodNrE/K
	N/OBqkaeG6Y5YzQfH6LuJagQpMsqkLIrq1ppdPrZ43Xi7WkitwtmZrO+voYzyCA0MpyfLYWNxyM
	lWsNmITHiB5DkruqlkJm+x+w==
X-Google-Smtp-Source: AGHT+IE1Bfo7WyDOccmF83+xyv53AP7U9h0WMDQNDUnhrEmgrKtybRdPq1K/Jb81XbGXlEBBS3MMCWzNs5S1RpI316w=
X-Received: by 2002:a17:906:f5a3:b0:ac2:c1e:dff0 with SMTP id
 a640c23a62f3a-acb428fd690mr383501166b.19.1744842931426; Wed, 16 Apr 2025
 15:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416221626.2710239-1-mjguzik@gmail.com>
In-Reply-To: <20250416221626.2710239-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 17 Apr 2025 00:35:19 +0200
X-Gm-Features: ATxdqUHaWK7LrU-Ix-EwBvKdwuCJm2IaWGaAi6CLVWc7N55ks48dPRslDisMI4A
Message-ID: <CAGudoHE4NuTugEmbG4iMCr5Mh7Qs2zTMNpcKR+nfxdTiRQiRkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] two nits for path lookup
To: brauner@kernel.org
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 12:16=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> since path looku is being looked at, two extra nits from me:
>
> 1. some trivial jump avoidance in inode_permission()
>
> 2. but more importantly avoiding a memory access which is most likely a
> cache miss when descending into devcgroup_inode_permission()
>
> the file seems to have no maintainer fwiw
>
> anyhow I'm confident the way forward is to add IOP_FAST_MAY_EXEC (or
> similar) to elide inode_permission() in the common case to begin with.
> There are quite a few branches which straight up don't need execute.

.. the bit would be set if everyone has the x perm on the inode, there
are no acls and the thing is a directory

The perm to check being MAY_EXEC elides the MAY_WRITE check in sb_permissio=
n().
The bit only showing up on directories means this is not a device,
eliding  devcgroup_inode_permission()
The bit being set means there is no need to separately check for the
mode and acls.

I have hooks in the same spot as security_* callbacks for setattr and
setacl + a CONFIG_DEBUG_VFS-guarded runtime check that the bit is only
set if there are indeed no acls and the mode grants x for everyone. It
also handles races against setattr/getacl. I just need to clean this
up + do more testing.

> On top of that btrfs has a permission hook only to check for MAY_WRITE,
> which in case of path lookup is not set. With the above flag the call
> will be avoided.
>
> Mateusz Guzik (2):
>   fs: touch up predicts in inode_permission()
>   device_cgroup: avoid access to ->i_rdev in the common case in
>     devcgroup_inode_permission()
>
>  fs/namei.c                    | 10 +++++-----
>  include/linux/device_cgroup.h |  7 ++++---
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> --
> 2.48.1
>


--=20
Mateusz Guzik <mjguzik gmail.com>

