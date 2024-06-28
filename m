Return-Path: <linux-fsdevel+bounces-22724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D879E91B591
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 05:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 077B61C20BE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 03:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A10321342;
	Fri, 28 Jun 2024 03:48:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2B31CAA2
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719546493; cv=none; b=uhrK36Gu10+3Jv2feHexyTgD2vTlKaLxjqNOPc1DToU296IJFpL4zkmDbjKGWkNNEbNVh+P2XqabO0/rKv/PWthwV6QjM35v/ENFf/jhR2/xoxrex3d1eCP9Z3BQGn5yj+hARu010Fe69mA3nPd7//rhrr61rggPi1/fXys1U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719546493; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l9Mx+T2AP6txNPfOfH2ixvj5ElgQHLL0WtlWDiDRZjpcEFtbFa4qf5yt3Vc1dTXe1UwVuSy6VfZTmb+aYlapM6HRLBwefcaJVB2+LabaullmOOXy+vtpzQIGSWTN6W4oRnXLA2QKUw0cRNFr6+gc15ZX5UbIns0+FxXOSVBfLTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7f3c8b1fee1so18820039f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 20:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719546491; x=1720151291;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=rKs07Q222hqzPaTZHprVM9mOFb49Ak4ijcSrL4h3sIQv4NwNspgVT3zQim2ZIpst3V
         uS4K+gKGgZ/WQV9zHDvG4m5YNgBJ8pmQxOjv0lAReWFURZRQJK7AVgmZPvBMjL0OSOfY
         jzNfvvJhaEG4TL/+DvU4sL7mbknWIb2qHjUlk9YGu/EJ2gGPRkQUxjPu4ubdBc9uB4XH
         57uRh8+LfY1ULe+avuGsJ04HKjDjAayZ0VLvVH34eC54ZiyDiYo510dGTiQDiEcJYvVq
         WJ+rtmPQB14LJj+K+FSVxvhJyUIULCezG+E3A+zr5vWy17/ioRXPwGL9CFIloNDAols2
         S8NA==
X-Forwarded-Encrypted: i=1; AJvYcCWlJMU5qNCILGF6JTc9meCYo/HNISGgS4clcSK5O6TwON6jwpf07rFO/PoNbDBg9q8PlDVTvNbaa89YEiQR8htoe7ms0A0XcL+bUAk0ug==
X-Gm-Message-State: AOJu0YzUpz+xTzZSExGvo3MH5MVUKQCQ0DrUED8QBQEODWYaKCmO7fE0
	/1433pq+8vrvmNE/kfFtvrXX6v66Q0mBswJH8pD9Y98phYTzusVR0Ha3UeGOhnOSRq2Mjf58fX1
	5Vz7hE+yHonTSPO/GsaUeUU2t5HZBakN2dE1B8i6ZKl4QJlD2RqihMlo=
X-Google-Smtp-Source: AGHT+IEBBqgISQtup2Pw/1uKpqjKjFEX4D7SLDczK0UdOyHzAXI7q0Lb5rMjDMzvhSNoR5lytn2LnreFrukLoL+dlECHsYSSKav0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9611:b0:4b9:bdfd:f15b with SMTP id
 8926c6da1cb9f-4b9ece1ba70mr1423229173.4.1719546491126; Thu, 27 Jun 2024
 20:48:11 -0700 (PDT)
Date: Thu, 27 Jun 2024 20:48:11 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7587c061beb1db5@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

