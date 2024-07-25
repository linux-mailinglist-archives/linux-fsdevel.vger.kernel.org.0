Return-Path: <linux-fsdevel+bounces-24278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB0693C95C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 22:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6E2B20CD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 20:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93C712D214;
	Thu, 25 Jul 2024 20:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M+/4T/nR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868C4C7B
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938309; cv=none; b=joZedLE4+hFEzRpXK94Zr5wdlqievBz2vQN0kik01zW8u3AIIL4iqROuBXdgzEbJAK32mRpNrKekfEp+ZLzOmw4Hw0t03gU2qVnGjWpkbA0/Hcpl1jwkOazh9A0UyPV2a4GUhocrxb88JeCprhhj6a8WshV+WALqL2raQNHIJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938309; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ah0q5X74ivT80Je0iU+hG0U+pHzDfFkGSX10GZXWPc/PsRDdZEw6bJv1yvKlhCUl+49WPgKynDjafzydMQ5wrUDvlX1DZ+bncFI1dkRSa4u38242qOKm/ex4Mlsh8C8INJZREkLpu0zjLDlQoFPwP43gJhX4OaIQq9pRaXieH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M+/4T/nR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso1718386a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938305; x=1722543105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=M+/4T/nR4rllZa3+nKfbH2KYRgtt1y+0qTJE0KYe76JwTVo33VGlw0KcYkCIZf9d+j
         L8xfaZUKEnhaK9Moj3Y5GxP/QzNog+8B3FNRTTAJQwm6zDOzl/egkxpTJts83HdKmFKl
         nB2wLehvegjTh8YRD9Y0Fi2HK2nA9CIvbn5kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938305; x=1722543105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=P5RgAO2Ikblc7IqHim/83Xql1kuapPWsSp55OmXvyZh3Np/lzmiTGuX4kbC+TFbpEI
         GEZIoHb5TvUTsEb0A1+I5YB4dlOOd1ttdDnzEDJdDy/mIhlJuo80eesMSE7ru5y8GMrK
         T/jGX1CVG1boiV7n/qy8baMYc+tPyLRV7BY2BrT+T2bZD92iS2UsUZhnRjERddp4xWN3
         GfHfW97qbA6epiznCxW3zbGg1ab741RLVIEr65LL2q3NqWBsJEZ5F9zOQaNCGJpNy8Ga
         YIc+wJYvdoEASNVBxY4ejzUaASKJTpCTPQOjmXrKL4HPMv7dhFi9U4L1JjGPCxbRHSCw
         Zngw==
X-Forwarded-Encrypted: i=1; AJvYcCURqaoLVVNwgrSju9ExfNlI8wT1Y+3WY1+7rkWxTe9CVLe9Pec9dKLCahCKBcm3DMC8idRH5puLhNDIsG1Kp4pC0x3vwT34lzVggxH83g==
X-Gm-Message-State: AOJu0YygjnzY4qlPBFPV9G6jEKscrscI4f39+P7p30mGIpFSSiWGXgHf
	lLjQu5DaegY9kstCwIG9k6UZzMeOkECUnVIjR3gThaT3QTE6YFLOqvrCBFGMdMoJtWyeELyRxt7
	QQ9k=
X-Google-Smtp-Source: AGHT+IEONx3FWuLEfKh/GmR6eZGDHliWm62Up+YsbqmTW+7NT6H29VM2a6xRQX5cTXBWVLlxu1w9Jw==
X-Received: by 2002:a17:907:720d:b0:a7a:bb54:c858 with SMTP id a640c23a62f3a-a7acb3f233dmr245500566b.26.1721938305211;
        Thu, 25 Jul 2024 13:11:45 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab52c95sm104387866b.76.2024.07.25.13.11.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:11:45 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso1718362a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVq+ToZIc0izpkZ0ccIcP+enbAqHQ7nQJ99RmWkdytureNiEFiQJCzqWmIUQ8I5ND0TKcl8Cd37bc5rCIWG/JvH0/JfzwVs4PBGN4JzAA==
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus

