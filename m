Return-Path: <linux-fsdevel+bounces-48999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDDCAB7464
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A008D17687A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C25286D71;
	Wed, 14 May 2025 18:34:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4D2868AC
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747247646; cv=none; b=Y76C8PcBZzuEa5rgq3DXJ0pcLBaBiqaCud4+pNlks+lx3N+WkvnEiG2oJQ3CnE/ttjrplF7gvw9vwtKQsN/rYLKsmosM6Fu7XUpDzCbpaIAWeK3vfYzPBVX4X53056IWML8jgJcK/BiRZA1/xG4jK2OAamqmTQTNxEzc6SMPhys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747247646; c=relaxed/simple;
	bh=C/AMOybXmMNriLmRrMMUjAPPdkqLnsLVfpwHNG3y1d8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Hfd81yWtHtNn6XoIB4w5icU8GYnOUXFgYqSV0RhDDZmWlJZQyNcnaFglcT6DifbeyvVqk/C7ag9JdMceAfOTcTtLwcTxnUgEMB/MksjydkHH/NbohSTrs3XCQ2Lh54O2cqFVuysquhigPO3QITs9X3WKoRftfhqIWVLrrtcmWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3db6cf9ac11so1909775ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 11:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747247644; x=1747852444;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN8HMO0gxZcP7qvsx/HaxnOkoUT7cdCTRks8rlUkvpM=;
        b=nJTXSBh53eE23FYvmqQZlGIKG8uNecgrFGIch56MEdJZKA0Nzyx0MzKY92cLsr8Ojh
         pWtDFjTf0+Jb8u5b5Xpg7vFXpISX2KzeNnC3wXShjawYOedusaQQTO1aY6pnG5ZKrr7K
         JML/fAyktUBWUliZPigL7IpKZ0bjEbBaLeefte0oY+vq5NkzOwqQWUdTpbpKgY86CNNF
         d562J7v3r/RfM4+1+eiryc1vJhLwJ6AmSIBBxCNLk2A11A8nLKHzGTsuJoJnmuc56jJc
         GXHB9iugdeWMQwDLPbbIJ9crf8r58GiLcEMo8IEqVhj6fmZXj5amYbGOZNPA9v/jEYMe
         Tpew==
X-Forwarded-Encrypted: i=1; AJvYcCUvsHW3OQJa1T8aKDBIGL+pt8iuW4MLSMuTlHzrbwh8CSVYlXdB6NHey6ikauEJ7LXwaH+PsjmleevPamZG@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTZY52zx/NLgGBfURDbGbExpjVxIcnA4ARKwpTwkxsbIAb/tc
	2WRoPSHmfjIAsg8OTu1j1NjynoL6TT629/RM0XQvzpcld3YTkZ1jAVaeM/+DvvnIB25qnilnw5P
	SzEecrtRYXij/GUOJcOfVRh70yQ58GFiSCkNjs4uAEAAL8YDKl297z70=
X-Google-Smtp-Source: AGHT+IGJxcqIkp76cLlKNDnHJQKnIAItIIxRc0KbDG6doO25XH20nuzMroTHS6Spy1fKPEj866mmszfs+8bEXoBqcNxuVQIpawnR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9c:b0:3d9:3adb:e589 with SMTP id
 e9e14a558f8ab-3db6f794c65mr53486305ab.4.1747247643705; Wed, 14 May 2025
 11:34:03 -0700 (PDT)
Date: Wed, 14 May 2025 11:34:03 -0700
In-Reply-To: <20250514182111.GO2023217@ZenIV>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6824e21b.a00a0220.104b28.0014.GAE@google.com>
Subject: Re: [syzbot] [xfs?] general protection fault in do_move_mount (3)
From: syzbot <syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com>
To: brauner@kernel.org, cem@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/gi=
t/viro/vfs.git on commit 8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04: failed t=
o run ["git" "fetch" "--force" "--tags" "52e739496919cc3ebdc35ab042bcd12547=
ec52de" "8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04"]: exit status 128
fatal: remote error: upload-pack: not our ref 8a6d8037a5deb2a9d5184f299f9ad=
b60b0c0ae04



Tested on:

commit:         [unknown=20
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git =
8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db9683d529ec1b88=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D799d4cf78a7476483=
ba2
compiler:      =20

Note: no patches were applied.

