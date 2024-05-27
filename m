Return-Path: <linux-fsdevel+bounces-20282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8E08D0F95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 23:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0B1C2235F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 21:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53929139D10;
	Mon, 27 May 2024 21:36:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99529481C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716845767; cv=none; b=tNVLK9fjB9v/G0o0aSVEw7IqZH6lo2pfV6LNSRvq0QwGbH/lir3Ddcg+/NmeI+54nHn/JSxAv92difJDozCuqUvaRNNHi9ZPXGBhskwf5Jsd/nM7kj4ctjDMy7unn+OZVrVxo1MNgqX19QnwfFzz0Dxh8Vg+ekPR7+gEopM9Hso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716845767; c=relaxed/simple;
	bh=xg5p9I+oP40kmJhXADMlxZAPjvXHHTMarEVG/hmd09E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WOsn5D5EMBhnG+rRef1gH/yrMyZqwtbvZb5iooVJAxON44jlhLhR7bkPTKV+LHPRqmv3XTJL1tbjB9aqoP0RA3vnRQzafKUdQPB4bGlgCAsg9afMCRc3k2pybBwczPYARo04X3YhhNFMmcYsTAO0V3482PQm4aLnrWq2EEE4NXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eacdc3fb57so14540739f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 14:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716845766; x=1717450566;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGnBPYhIToM5CvdNlwOkqkKSjA25/rvGdeWcOIlxVBw=;
        b=BheJvXxcdtuZ1w1isbahYk7pH5N1RISEL2p8ZU654yXRa3lNevAc39hwjq3VneCqe3
         UOi4qxlwRM8K8lzNBdzu1gAEA3CK8vZu2hqCd6Cj86SUplM3mJt3gEOM6pg8gpI1zSoe
         tKFy4lWJj5T6ZQSPhFk9sh0nNh2OpJRUnl6ddofRbmoT9gxTjlB52CzzioXNPy8VA3Ak
         Ws44ZXC+9w2B9JKk/YyxHAuuM2eAWoXcMoucCnchfDzlykWyX083HigLZORYV25k39g1
         31oxtx5qzcyssP618x5cuKQ1zAZvh55Nqj4YzOLbcfYGEQSjF1tdn+gLniuldyKwL7lg
         KoQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDGZeJ2TisiqBZchQ2TE8S0/kG4XKRTGFPEv6L5x4Cq9YpzAi8nwLW6khjCNkytrWeoPqlTZ7WamKUwJY/X9gWOL0zq3wLYaZIqfn7ew==
X-Gm-Message-State: AOJu0Yz9oiIkxsiF5N6jFkmd62RX65Pt7y82WXHfE6Ti7h1GP9kJvzu0
	eMA396bPiPeBVUjR9MuLVD0rVF8j05ndBiX8knsLdCpobIrnjAXo58NupRh6awB2n1t7kMvzvut
	IcYwLAa0nsr/U8Y1RsvIne4JgUJCXR2sM25zSRjaamPsyp7RpuVB1GnQ=
X-Google-Smtp-Source: AGHT+IGF5ftlSVDbRXoxRHrscozfUco3U5VmGiqRYnoCeclwuvAWs6L99ygLz4h+7bPaa9AKbhQaDw4qGRY1xtZYUovJp3h9Xpv1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1601:b0:7e2:b00:2239 with SMTP id
 ca18e2360f4ac-7e8c1adbc2amr32193639f.0.1716845765956; Mon, 27 May 2024
 14:36:05 -0700 (PDT)
Date: Mon, 27 May 2024 14:36:05 -0700
In-Reply-To: <CAJfpeguD5jSUd=fLaAGzuYU-01cKjSij6UbQWy72LDpqK1KQfw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003a6e50619764eb4@google.com>
Subject: Re: [syzbot] [overlayfs] possible deadlock in ovl_copy_up_flags
From: syzbot <syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	jack@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com

Tested on:

commit:         f74ee925 ovl: tmpfile copy-up fix
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
console output: https://syzkaller.appspot.com/x/log.txt?x=142c4e2c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=85e58cdf5b3136471d4b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

