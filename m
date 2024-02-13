Return-Path: <linux-fsdevel+bounces-11269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D658524F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 02:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBBCB22892
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 01:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF64212BF13;
	Tue, 13 Feb 2024 00:24:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C777112BEAD
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 00:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783846; cv=none; b=gJ1IhdMdISnegCU+d1A8vTkPKAo5vB97QRdqVcvqWGHW0drhA77RR8Cl9oX8MKzvyPWESX6BPPllsXF8xZMi4CenshfRc8wYWibdZ2CBMaJkT4k/eJScSiuyFhEowOgNmKRH8YtgZLeT67M0h2QryzoB5hk5XzpNKjxJdjxJBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783846; c=relaxed/simple;
	bh=dqTQI63+ZqDNKjpAbbZCxeV49nIfSpoeFvQR60x/Qw4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IEISpU858jztWHTvMVqNMHqNHMvoFlPk5EP/PqYRTaEO5n63DlegzK05h5POR0B/Jt+XNoMtt6Zg7NsXYMtwzLiY9Gd/DwjPF4gxtTDR958AbjzWEn6gzh9g6wKFzW0GWwjQpyGmdFMreA9vjmOF/vhuCo5x9zBifSgHu2sd01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf863c324dso304828639f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 16:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707783844; x=1708388644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiXaK9TFzZAPYPnTyw0VSmUtJHPDIyF9ZuwGBaLUHN4=;
        b=Csax0hGyH+DUPTSb7xIEi7nPQB3Nzn2RXeK0VUbWcJK+Sd+4qcLLoBPWs5EHUWSaXD
         2aB2Xy+8P2oKhOPSyuoUSKJkyyZDxoYVYYqv+1m/xRWWZYP0nSHk6/88tdj9uQJzUN7w
         E2ZtxSMmT0yekovUP5Ja8PXPHgtoB9wFKq7CawM7ijf6pV/jgWGib/CT0c8JmNrf6n/T
         g4ugBmmRcwc/I+2Na0Lwy8hwJGvymUv6fMp8lXhFuVEJXyB22lMZCHv3k7m1WBRbRjKZ
         FvP0jDGsOFVL7u/jQ9C57WzvPI8m+RQRZDvqmE4puV6iuhsxJZaDpRD1mvAUDynN4G97
         dWaA==
X-Forwarded-Encrypted: i=1; AJvYcCXUusGOZWS2zrigbE5c1XxVMl8NYzEZ5lLWoIg4dD1cZk96Xe5VSMZWiQ/ySFyqKxeT5+TI9QjlpoCQ+00x+2em54RGP08i9pmf5R2edQ==
X-Gm-Message-State: AOJu0Yy5S+a6NhH3xdjOHd5jGg+ncC9HsUCTsLMRV8XbUpp12Vka3YxE
	VhwyTOt85K8gKlb2ndvdHnMUQtPcUTUd5jd8So2myVAUrd2o8kW9SKn8l+/cADXhCmt3eH0pXiA
	jnkWrTGLCjIm66Zs2ZY0YgP6d2jitAGfZH+nDnrQ0AU+4i/EwoH3ntJM=
X-Google-Smtp-Source: AGHT+IF6MxRdyVnerz3TZh0IMvFhTsYoobPC91qocz9bxduYTKyDy5vR6SC+Hzhdc924TduO/JMxFxAP1kD/Km0bsBVcWg9yuwkk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1789:b0:363:8b04:6df7 with SMTP id
 y9-20020a056e02178900b003638b046df7mr80908ilu.0.1707783844004; Mon, 12 Feb
 2024 16:24:04 -0800 (PST)
Date: Mon, 12 Feb 2024 16:24:03 -0800
In-Reply-To: <0000000000001f0b970605c39a7e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000600b5d06113869f0@google.com>
Subject: Re: [syzbot] [ext4?] general protection fault in utf8nlookup
From: syzbot <syzbot+9cf75dc581fb4307d6dd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	ebiggers@google.com, ebiggers@kernel.org, jack@suse.cz, krisman@collabora.com, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	twuufnxlz@gmail.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17547fd4180000
start commit:   e42bebf6db29 Merge tag 'efi-fixes-for-v6.6-1' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
dashboard link: https://syzkaller.appspot.com/bug?extid=9cf75dc581fb4307d6dd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1374a174680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b12928680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

