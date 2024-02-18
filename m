Return-Path: <linux-fsdevel+bounces-11941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 303058594A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 05:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62461F22430
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 04:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52B04C97;
	Sun, 18 Feb 2024 04:42:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BA2F4A
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 04:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708231324; cv=none; b=gdUPgsOFd+0Q+KtnH9V38kdw7TNagyn/PXTsJsnkEk2rfx2RdzKjPf/zVryLIS7UmuMLLnRYnNYrpAjtAoyOxhDk60RTAL4jk7UjkzbXmBqpGxQ5QLczEnKaIOQ3lgKv/4LjjBuEt6tXLnc3VhojXx0JxtYzh4XPYdeCknn/WFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708231324; c=relaxed/simple;
	bh=dPfk3d/IgI4et8CrB7+zM5ARrgakQRE9gXrevq701Rk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NPYaS6otM3ZLz4TjO4rchnBLVdP68cJ78Z2RSUEtp8Au8MwNcUdzKrnVQaXOuOenu9VK6iNesCK3dOHumEcYTPgjtdg2IPCiN75z5Cj0UlWTlNwKQrq5iC2ULTAEeljVxG3XiDSPOwbcIMOy3YudIQt2xPa8z5LoaLHyIrBqwm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365067c1349so20848865ab.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 20:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708231322; x=1708836122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmjy4yq7SJeeKhzBuewZUYc+eWoeO+NkF0b7ie1wfJA=;
        b=LXxh+xs/SxRUKwLeYF4TOHWc6zTG2+WeALIuL1q1KrYK55dbx2rtBqhdE3PAMocdaa
         YgbzdhWXmaNQJTH+5lNwCPvlloPQUvPnI/70JY0b+JmZXbxyxEzZQ7ponZjuJc0Ck6se
         JE73tEPzdwB5Vc70kifh511fRrXwqZ4N4RA+XZUL/Wcxl2X9ADzZ2pYuD3e9IzhwO7be
         ZDxXOByoubbyFehpBNVyR7++K3Lyhadj4amk5VCbXLZ3rKvkpcGS8a28Ee9c+gaPDEo2
         Ti6XHSr5g26pA064dPw5ceHWoF9NwpQ05RiFA/lqbPSbz7wXurzLcRfOXgCSpvXo3EHD
         /zaw==
X-Forwarded-Encrypted: i=1; AJvYcCXVaM9MxRVbcu6MKHLxDldq2Bw87lAJzdnJqp4IL4v4q/fVq2pWNfmMwR4VfZvHIGobkgRLYu8COOHsexcIpUXOOeZR10fuc4N+vjL/Gg==
X-Gm-Message-State: AOJu0YyaYM/buxKpNMZ+2GZKhJEhUxAtUWMAnLmkiJOVdfpSrdubbsLw
	PFcfxsC/OjBQIbNsTrUsDVhOwbAyvTZNnUPKttMcPuMoVoqwunb/Bo1IZAZ4JyMgk1V1bqDhstu
	eNrkxK7QiqnEAIeVj8IVKWCwDfyzvvQoHUZbzc5FTiHo7iyfURUdDJCo=
X-Google-Smtp-Source: AGHT+IH8UuBu8FbOSB1H9dYXew9V4/LxafJNnjWpw/jgXH4Ca3AQgXbRaotAwzLPnehrAoL18NmodA0UO8+dZ3Z0olx7/O0s8Su+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:363:7b86:21bd with SMTP id
 l2-20020a056e021aa200b003637b8621bdmr715271ilv.4.1708231322355; Sat, 17 Feb
 2024 20:42:02 -0800 (PST)
Date: Sat, 17 Feb 2024 20:42:02 -0800
In-Reply-To: <000000000000375f00060eb11585@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029d2820611a09994@google.com>
Subject: Re: [syzbot] [nilfs?] KASAN: use-after-free Read in nilfs_set_link
From: syzbot <syzbot+4936b06b07f365af31cc@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	konishi.ryusuke@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10639b34180000
start commit:   52b1853b080a Merge tag 'i2c-for-6.7-final' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=4936b06b07f365af31cc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d62025e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13c38055e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

