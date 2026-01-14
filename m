Return-Path: <linux-fsdevel+bounces-73647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D37B6D1D6CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 10:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 170FB3063E68
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 09:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817AD38736B;
	Wed, 14 Jan 2026 09:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrp0W5Mi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B333378D86
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 09:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381916; cv=none; b=OTZrzIkNqx+fH7IhAabMmDSlrjk2zNTTK5tAwyM+7ZWaIeRGNCYT9IanDl1p0aEQ4XAy0xBKO874usLtx+SqKQ4Z9Fe1hBw0zIH6VsITXpfruhi63X13sKYiU8HKIGWhAh/ipRV0yJVCMw692CSH4X0Io6Hcz1mUyFiRSHL9fZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381916; c=relaxed/simple;
	bh=82+bG8c9NT2v5lvFUlTPce4HUGNH29G5+7a0UjgWE7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQHNE4pjjUgxBeiVcJPFETOT/GYbNFS9mhBgj2dl1Pjq1X2bMSTLlkEP80/Ai7LXn13m5Qb+drbC4b3vyUX5ne2zy+CSu0+V/zynVfunlhfqnwC+6tvofhKg4WukA8f+rVUeTC41RG/yCSCb8GXy67ACOs7nlkN5/5gZBiZu2do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrp0W5Mi; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64b5ed53d0aso12490793a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 01:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768381913; x=1768986713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ss8hxxmHbCJow5+qT+SG2ycgD4rdwI0VgjVuMPCS33M=;
        b=hrp0W5Mi+xWM566DbM6WDb+H9l4pJOiMqZAQWtY/CHg4uxf3TkOIiOxi+rkoMuAsgf
         ec/hT/dSRpYErc9UxFuLPOi4o5g2N+E//4SRqHYgvpFIYs4D6bedQf/r/lkDNqQ//P52
         +DO1pqP32vRSGfcUeIDn/OGRqKANm+agPYNwdeFct+L7R1+XMHh2ISeDvAHoN23WuHAg
         g25eFC8j4+vfq6LO8jQXQbv+w1oAE3fqNBaoiGMdYtc0Svz/65Fsuci2oYr0qjA0TOzJ
         4VAd6DtZj8rpZdDJjdB3VQ45iTJTDpn9OPjrFqydD00OYyrnSaDzk0QfUsmclRQGp1p1
         ZOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768381913; x=1768986713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ss8hxxmHbCJow5+qT+SG2ycgD4rdwI0VgjVuMPCS33M=;
        b=n4JDS0jA5Jqy+4Jbgyjl5uHxySNQBEDOtOOrldPbMJu8QUBevR61lNFV3wmFKT5Wpl
         w4NHcmc+EpLV9aLRB5QmC+EqwnG85daJyYIf+rLl3fXDQv01X0FxPiUwtmxRN++UWjMK
         qcR3Mxib3q4xgQ02mBYBDzLLTdpraODj/ov8+4M1v5DlK3V7oPY9l1hmtO7OdEiF7ZC+
         tbJFNfYkdNYvesIR+NBdsldViSS0d83O4bWpKz9wd/qaLZRs8jMkwDAx8Zk3sEq4R8mW
         rWifRwWSG+Z2ZewtXKTuzj5CBUL+1iVt2w7fAXRxPZfbpVFgAc5g/hTx72lXw2/7o9DU
         tJig==
X-Forwarded-Encrypted: i=1; AJvYcCXdfnKYGxXB7wdtvZY9+XDJKHHohRv+GDMdivUe0+FeBOqrRbwuLW05zhWokQGeGtWulHlbFV7glfub3Xry@vger.kernel.org
X-Gm-Message-State: AOJu0YxJgQJ9xVNTxWtLhgDZsNp5W9QedY+3OkKfrqSnJkSVrNhkrTxr
	W0V6Apaalaeukepb/nGx5qJoSSIDyPKzDcAFM1Q+4MwjusIoySy0rAMB4KF9eSQBvcYEyVdPs8z
	Xul6JWulYGIju3Lpohm8eDIl4nHzJDxQmkQ==
X-Gm-Gg: AY/fxX41cTkOkBqDQuNsBww3HaFuOyseD2SORpLnGYsDtGm7XH37a7jj5eY0To3qQ3+
	3bq/4lGpNCNOscJIq44//qZWvvFEm2yENhCWPQqgWuHgMN43Piip3zFCqrD6L2ej1XJPMFZSf2l
	ilEOLw3Sto17UxYKC3X81pM/E4JQ9zoVc4BbIa8gHG1LA6pVFVBVU0TOUoI6Tlv6Wg1viQ8Begj
	6Ty9VY/K3VsF5R/JbEJ9PCJhXW4ljWhGL0BfGfwo0ujyKubA1EtUupugno0fzdGCIjY9H51hJ2r
	mxD+1a/QYiC8UCaTC++zQr9BfQ==
X-Received: by 2002:a05:6402:22f6:b0:653:b83b:a68c with SMTP id
 4fb4d7f45d1cf-653ec10fc47mr1100386a12.12.1768381912635; Wed, 14 Jan 2026
 01:11:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111083843.651167-1-mjguzik@gmail.com> <aWb+7/g7Nz1zfFSp@ly-workstation>
In-Reply-To: <aWb+7/g7Nz1zfFSp@ly-workstation>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 14 Jan 2026 10:11:40 +0100
X-Gm-Features: AZwV_Qh-jI-bo2PSE0uYhowSlLohfPRnG_fjsuzC7Pl6T7leUQ1plTfWgIoDlNI
Message-ID: <CAGudoHHYTP7vwOMG5R1L_TDMrHkD01QjJxK5JitEMigccbOXJw@mail.gmail.com>
Subject: Re: [PATCH] fs: make insert_inode_locked() wait for inode destruction
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 3:27=E2=80=AFAM Lai, Yi <yi1.lai@linux.intel.com> w=
rote:
> I used Syzkaller and found that there is WARNING: bad unlock balance in _=
_wait_on_freeing_inode in linux-next next-20260113.
>
> [   57.741960] -------------------------------------
> [   57.742317] repro/663 is trying to release lock (rcu_read_lock) at:
> [   57.742831] [<ffffffff821343ea>] __wait_on_freeing_inode+0x13a/0x3b0
> [   57.743361] but there are no more locks to release!

uh. I made sure the hash lock dance + retry is fine, I missed the
obvious rcu problem

Figuring out a way to fix it is a matter of taste, so I'm going to
chew on it a little bit.


thanks for the report!

