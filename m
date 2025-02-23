Return-Path: <linux-fsdevel+bounces-42364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C2A40F9C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 16:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F195F18968EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 15:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A7F6F099;
	Sun, 23 Feb 2025 15:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWEi1yhG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F4347CC;
	Sun, 23 Feb 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325978; cv=none; b=kXCQYCzgOD4e9TUgNz6KMmdH4MQWZzT8XvevVU1uIb6TzjG/OKsY4I7rmOP7kAnhnOW13lSI3vKWmRtRpO0sV07CvND+qaGlPeZmbms8vsBGZlZYlxcumiTf6ix7Ml1eOqRp4LPSkbOZKKcwPkPw8FeyME3J6gjPI/2Pit+R+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325978; c=relaxed/simple;
	bh=7dpqHMcMeTsL2q7Rl+cTZimMbcWp6Y6BwW0768EVC9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+K5CgKVE1DaS82+Lb4CvCQf5MmhhqI2fwm4YAw1YzKzmKoaytivkV7eGuFHuK5D4uAepCscVYNFcWfFN9Dv8QoWK79I1XlSJrdf8q+m24JHD/+Dtq5EXNg6EUuduJeA3qmMTfFdHyOfucUfYl69ImByFSsqZDGjrJ+bnJX2xcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWEi1yhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E190C4CEDD;
	Sun, 23 Feb 2025 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740325977;
	bh=7dpqHMcMeTsL2q7Rl+cTZimMbcWp6Y6BwW0768EVC9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AWEi1yhG9vhfVbIY5s769Qwx7+gWVkXovI6BDFPQxUVsGau0oRRXtkeluCpk8EKcu
	 dCW4jUf79fjk61wBlR9GPPSLhz/7ShfnhkM2JB1Sc0tOPAaTzpwcnyRLqNtLNoEMC2
	 i2VmOD4rWmo21oEpaM9ItnjoxeGkebdDnPH4Ru/1CaLxtSB/YEXj8U2+TOeVLch/Uv
	 lMt370kyte5jgedm51R087aPi8lhxCpwW4X/dvwDhLnqf26jph+ZTYZn/vhAPH3atg
	 +AquUzv/YHs8w8GdZicJ9OriG/aC9pQqDHGrLZJxEtOmulF4s5dCvSWMLiHgMpPPgT
	 M/0CumGVwZMkw==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3072f8dc069so38542311fa.3;
        Sun, 23 Feb 2025 07:52:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWA3qPwAmzK9pMBPK0FGB/jfEDU/fUksp0xVzZDrf38+1azDWl5mLl00fa3v1iyM7iSC2R7d7zs36uREFp@vger.kernel.org, AJvYcCWrJRIKbfFapPF51700Aa/Z0Mqve8AnfRCeGCzQu3K1jaAoC1ZH1SiXBrv4TtVTYoT/uch0fd1lOSY=@vger.kernel.org, AJvYcCXzMHfRqCCbJjTI90WGlC22z9IepNRzLNN3y/W7wR/IV1Zchz26CmnlzoqKw/RjoMOjax7BMowPnVsK7kSncA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2V7s1h89LBwGDSG86x4kBYFLB1QCtcWnNtVSUMLpJIRcp3IbW
	sNrYn9IXvbSHjHcQEf5jfMmsDiBnURbJwoBx92skWd8LuQ3U0x9crUV0ax9KsNXPUpWaO8bslS6
	O2kvKTY8vcArfTms0HjpZRl/eiDU=
X-Google-Smtp-Source: AGHT+IEztx4T44NxOSzK0I6ch4xU+d8tI+kffMKnDy0SEaxkKrWVD5dRqWYbG9m9TcAokK0yGvqYffGSXg4pGgGQmA8=
X-Received: by 2002:a05:6512:1282:b0:546:2ea4:8e71 with SMTP id
 2adb3069b0e04-54838f7ad50mr4017153e87.52.1740325975810; Sun, 23 Feb 2025
 07:52:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67bafe23.050a0220.bbfd1.0017.GAE@google.com>
In-Reply-To: <67bafe23.050a0220.bbfd1.0017.GAE@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 23 Feb 2025 16:52:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE1WgFkP5RG-VhC_P-gMDtyipW7nvE+i+JBSWXW1bqbhg@mail.gmail.com>
X-Gm-Features: AWEUYZn-X-lGRyLRTZRSnIwkrekSUGCsYVnDrqKDr5iJhvy-O6osSycIE9XKv00
Message-ID: <CAMj1kXE1WgFkP5RG-VhC_P-gMDtyipW7nvE+i+JBSWXW1bqbhg@mail.gmail.com>
Subject: Re: [syzbot] [efi?] [fs?] BUG: unable to handle kernel paging request
 in efivarfs_pm_notify
To: syzbot <syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com>
Cc: jk@ozlabs.org, linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git urgent

