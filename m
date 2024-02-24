Return-Path: <linux-fsdevel+bounces-12657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3208623F6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 10:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A0C2842A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793F31B976;
	Sat, 24 Feb 2024 09:37:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB4171CD
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708767425; cv=none; b=IrUNySgEalmOwqj6E2AFWiLFHmc2aPBHjM2xoo4Zy4WLyR8BvHFRzyJZgNYX9j/NF64WcVna/ZOuIm+zx9UYlcPCVYbzjoJJF2G7uRmBi91BIb+OZlUS7k/lJ8itUt78Kcfc210MeEaYFS8RXeVR1R8qKNJq3r9uhmdQyk+EEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708767425; c=relaxed/simple;
	bh=bQcvBHdiqv3sc7EMZ18rDY7euDY+0vzbiFh1lTvFOc0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mVTLsDYvJHcVoqjS2XIyn26SydSQ1PrY/vhBAnlIjcwo/fT4nHxfhJXknjwF52GuPdtJ9yIdsXngLDYlb+i5SIJxRDldxJ9uDgKqbg3zJjoeRQ8v+qt5D8FBcagyLiG1JBdr4pKF2iG+pLWTJtWIj2eYaCpyRyIi1VnLiRRicxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36527824ab9so13572895ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 01:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708767422; x=1709372222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bG7CeMIcBz4R8ZPtnOBeZeGddzoAFYbCqM2qbx+aFUk=;
        b=go4HVy4bDr1w6H38mAeYuvGh9I43LhTAuzVU0kUeZYiKKNEitehw+0FwEMFzUvrz4d
         FC5IKbr60N+ezJBC5ZJEjfBhbQRlyKqiFBkWAlCI//4IOnVRw09n5lk4XWgqQQi7Roy5
         2a+yEqBso8TtCSKobQwrj5gkEF+tDUfzemrVq16y6Dkf6w/6bhkQnEHdlRkSHvrcPI+U
         FuCILxcZ4x+fc/k3LlNFwaBXi7tNcjlox/d1R+GD7pWwroFE1xH4UkFhqfWEQyOKA5ZD
         pJT8a725Roy8T/cdtZmNX2uRhfWonGtZ3l7j7nwiXR+SPb+WviRuCyQx7a//G67BNzdh
         Khbg==
X-Forwarded-Encrypted: i=1; AJvYcCU9DwYKQKT+/BuNLFMYGtFD9QayPdcpPeQktcPjKhiMjr3Hz2K7qEUmzVpVVTKTUr4j33WAcutQztpVGQO7HEPsBWop449JSBGYWKqeDg==
X-Gm-Message-State: AOJu0YyRj6bROzmpBGwQ5tLSS1nEKXVs50DN9f31ULH1PXbMd4MegsHU
	Y2X8o4z48h3gSoAVeyVMXAGLVAEKqFnZZQQAIGdzjEvmO7mOAAwTQpmkiMfPsz5pJBEZUB12Ql+
	CEyPx1dWPwJw57hE8jSf4yIbzKkZvjfIwIF/Arysqm7Sote/qLCpZt38=
X-Google-Smtp-Source: AGHT+IEG4Kedn7F25zgN4YUskZq2LX2rfkeUfsalxNe/VS6JPzQ2RdSSdm5g6h0m31uE7VgpGMxYnyG3dRO63YrdzJUIq1ZriKy9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c8:b0:363:a059:670b with SMTP id
 i8-20020a056e0212c800b00363a059670bmr130398ilm.4.1708767422776; Sat, 24 Feb
 2024 01:37:02 -0800 (PST)
Date: Sat, 24 Feb 2024 01:37:02 -0800
In-Reply-To: <000000000000cf826706067d18fd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d0afb06121d6b34@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_release_global_block_rsv
From: syzbot <syzbot+10e8dae9863cb83db623@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nborisov@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a6a8f22a4af6c572d9e01ca9f7b515bf0cbb63b1
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:40 2023 +0000

    btrfs: move space cache settings into open_ctree

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=100fec54180000
start commit:   23dfa043f6d5 Merge tag 'i2c-for-6.7-rc2' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d05dd66e2eb2c872
dashboard link: https://syzkaller.appspot.com/bug?extid=10e8dae9863cb83db623
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17722e24e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11201350e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: move space cache settings into open_ctree

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

