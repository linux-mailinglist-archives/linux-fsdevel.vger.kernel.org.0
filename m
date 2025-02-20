Return-Path: <linux-fsdevel+bounces-42176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC2A3DF5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 16:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EE3C17996A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 15:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E860E1F63EA;
	Thu, 20 Feb 2025 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ARxCtaZF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413F204F94
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066648; cv=none; b=Tq0taM8yby0WiLni2Mzhoz+TDH+9MNh5GcakDzcJTTmjK47226X1Otm/dFD3vZiP2stVO8c+xMILxzWLrM3badJoSUnh3uHO9+fEsk4h3KT0ztyHNy9IJFZ6fBUJPqLNJL5BP7m9lZx11ImcEHPQRhwGRE/p1Ueir46bbz36Ouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066648; c=relaxed/simple;
	bh=NOZ6hwtAfDPTUx2chY/KuMq7RkUkUAjyQesgIkb6ybw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PPDeQ4eRehDQDwBVNGLN0mDRmz7rFQEaGDdI/BEBC0kXClp1GODrNYWdqSU2OCpHa9AoFdCHKs08sIoHF7Sxi9UBiAxWCM+uuv7HoQkYXoazafof2CHrnm0KE8irovICQ2Eq0W6nzBHeurtRQJFP6TnxX1e6dLCoV3eSo74yWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ARxCtaZF; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6efe4324f96so9779057b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Feb 2025 07:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740066645; x=1740671445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOZ6hwtAfDPTUx2chY/KuMq7RkUkUAjyQesgIkb6ybw=;
        b=ARxCtaZF4VgTKB5Epe32R1Zqa0EVGoz/H6H83Jqw4LC3ierLwRMzQXnleYX2dSLKpe
         sY1BzOLumC3bsXOm4qWJ/8KxAAw4+89p9Fw9TTdRVMkA60RNXgIil9+n/b3M4eGjmzrD
         nHnqwF352fRKfQCD4Hhxhs1o4ZmkEicGxh+NN84XKV0eGprm+VWaYn5lPjm1QP+PE5bD
         R2+4CAyHtokvyETk5K1qNKyf7PqYUUv/CAM4Vw8pTYvkyu1YGIEzKK+bYl4GMZ3UT/sA
         /vkkSTOEo78a5TkxyuNLiyCRpGT3SQI3C88bXM0gFHpY8jzpdZuVH9pzjUvnL3Ty4zS/
         ik6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066645; x=1740671445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOZ6hwtAfDPTUx2chY/KuMq7RkUkUAjyQesgIkb6ybw=;
        b=q6GZ6gavVusLuHSV6p78FkpEGP1oBUxVhE+oBsqSUHE40p1NC8oq4j+HWh/EdDrSWj
         ArWUNKwxLKENrg1p2NomOm9mHGnTr1llnQrpHrsJB/5sBsiTdl7p6yH7x+X8ZVpjAmCR
         /MKi+2vDaAk1bc0oaACLMZaQhd9tIr8zJaELOtCW2pYmP4vL1qHjcWIkUvFYKa05Amvq
         xl09IvqKKcl7GZ6145WHSGNsqejyUgwXJUBFYcdtra9iyP7y3/Hu69TNqfQj8NXALFvw
         /VSKTd7F/Qr26EH6cUAL0q6ayFb04OqL9kV2Gw5bCzthbKf3H5y6m21m/24h4aLaPwKH
         gbLA==
X-Forwarded-Encrypted: i=1; AJvYcCX89538zm6fzv5g/ldgzndV82e3pMnElznM/x1GhXIGSmR5FpwZwXp0zurXkSuNDHZRQvwIfvtHJzu4llVC@vger.kernel.org
X-Gm-Message-State: AOJu0YyEf3lo+vpBzc9hsxnycgxJFzpzAInfze/Mps1tb+IxPZpzeeoV
	mi/KfzyGlNDcF0ys8tDbO5Sqge5scAKfiuyffuL6kwKCVhnLlo2YnYduWppqytJdJr0GhFzDm1U
	/YC0xFTm1H8dB2PbBCUhsUWTBe8UN6kx/27fT
X-Gm-Gg: ASbGncu/VQdx8Xu/yQy4poQeRLemsuh8jHfnIqq43yLMfpjfBfJ5Sv3KU1/WEGnuF7K
	3S+/DG+5bR9TcAqojXEtzyTqi6UCPi5Y28MFqT9FrAccJT9GbIItb5+5EQ/gAC1tk+WxKI1Y6Xn
	N2r9UzvQx7a8q1hdAxwXBL6jk+M3KGAnM=
X-Google-Smtp-Source: AGHT+IF4QHAlr0jbcej+otWDQUPRsMGqBGsy5kXYbQZNkMvCk6/6+ktBjnvNBNEXqNih9Sq6wNtxFrNOxWGqH+4vrP4=
X-Received: by 2002:a05:690c:650f:b0:6f9:a402:ff2e with SMTP id
 00721157ae682-6fbbb617953mr25513367b3.16.1740066645419; Thu, 20 Feb 2025
 07:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvVtao9OotO3sZopxxkSTkRV-cizpE1r2VtG7xZExZFOQ@mail.gmail.com>
 <20250219195400.1700787-1-samclewis@google.com> <568e942f-7ef9-4a00-a94f-441f156471b1@fastmail.fm>
 <CAJfpeguEsq2amd-UxiSEktZLSpR0s+LXFeknpLdZR6vk8fbb_A@mail.gmail.com> <76b3d8c4-65dc-4545-ae61-4def20a71374@fastmail.fm>
In-Reply-To: <76b3d8c4-65dc-4545-ae61-4def20a71374@fastmail.fm>
From: Sam Lewis <samclewis@google.com>
Date: Thu, 20 Feb 2025 10:50:08 -0500
X-Gm-Features: AWEUYZlScyW9IcaUma2P1laZspbPeDCLXncbxhRc5nFcALB-qlaDPuVoFgH9COM
Message-ID: <CAATiN+EMAQF=u8HHeTcKGHYZxuiSJ_FWkpr9VZ4McVqGa63GNA@mail.gmail.com>
Subject: Re: [fuse-devel] Symlink caching: Updating the target can result in
 corrupted symlinks - kernel issue?
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.sourceforge.net, 
	laura.promberger@cern.ch, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 5:00=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
> @Sam could you please describe your reproducer?

Absolutely. We have an internal networked filesystem that implements
the FUSE interface =E2=80=93 not CVMFS. So stat, readlink, etc end up as RP=
Cs
to another backend.

We need to avoid stale readlink calls, so we clear the kernel symlink
cache whenever we receive a new snapshot from the network, and this is
where the race condition comes in.

I reproduced the bug by interacting with the same filesystem location
on two different machines. On the first machine, we have a C for loop
that calls readlink and prints the destination whenever it changes[1].
On the second machine, I manually switched the symlink back and forth
between two destinations of different lengths using `ln -sf`.

When the kernel cache was enabled, changing the link destination from
"dest" to "longerdest" would result in the first machine printing
"long". It happened very consistently, usually immediately or with 1
or 2 tries. Here are the things that fixed the bug:
- Disabling the kernel cache
- Applying Miklos' patch to a custom kernel
- Uncommenting the 1 second sleep in [1] to make the race condition
very unlikely

I hope that helps!

[1] basically the script seen here:
https://github.com/cvmfs/cvmfs/issues/3626#issue-2390818866

Sam

