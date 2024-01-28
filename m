Return-Path: <linux-fsdevel+bounces-9228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A3383F2CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 02:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECE41C21539
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 01:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F1133CE;
	Sun, 28 Jan 2024 01:57:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA3F186F
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 01:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706407025; cv=none; b=NEOv20aHJAYdBkIwQGJtwCmkvQbZ1qXC4qRuvp56JjDYuutl5wv+QMJ9j5JKiVVNBfaZ6gbjbi0BW6NJVHO2WvermxFy/Wmr1MWgQJu4l4tas+CPvoPZom2SoDpY67/GCdJ2eC4YiUsfVhkP3+T+eIwwckWVeHtURr3Dzh+3bd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706407025; c=relaxed/simple;
	bh=V+GAjd8Lml5y1XoTxNEuHT5WQVdZ9Rzj6DZ8JzsEmr0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ekCC5qkCKtEVaSbKHKIIecI5XbgYKf62YXl52Z75inVa3bvgrZ2JaYIDYCPHKvADvbaCb6Kc2GhVixUCPolI215AScHSk5kQlAGxYRbyJwKacgFgEYTlM6wjttOYSeQykNqe3BH3jZWt3Nrcwbw64khroo8ndF1EgTFActB4Uok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bbb3de4dcbso159840839f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 17:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706407023; x=1707011823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwxdzYEPbsFuO+TSL8DKdjJZvhazGlttvbnyxJ7rcOk=;
        b=O8Ls3boF1yR6Pmy80LL1Y7g4ybLUduvvfEKaDOy8Gt6m3Fxvj+HdhBL8l6eSsPDfY9
         crC/B5oT49+34iu+LaHxpA9+ROGuYq8QtXov9LMxMD5wQabYJj6DM6d3viM135P5J25q
         X/sF7ZI5Zsxmh6v04obLfKAu0YhSlNBpem+wXRXFYSVKMe0P048ibQD8Qt5JswKrVznc
         nEKvqffq8Gi6Z4CzIeFG0jobhEZsZXfcVGJ/0/f66Mv2qgxXcWEYp83S/uNtQHz/zo/J
         MF/fgYoedWtoq83t7JeWpqu9+ONwIlHZU5gLYTGHTRicKdZ1rpAJ/VwC9uWZ369G4U84
         gqQA==
X-Gm-Message-State: AOJu0Yz9PSM+bu1CPId+9P0mKRKts1RkQvu50hGijEX0waHx8GnMLqd0
	DtJZ6Tl8u/KxFozQ7kNai5EvaqxE5dT7cnEazuXJofvYR6qgE1PPLctFqnJfsxCFA1mPACJ+nmx
	quxsOzJGlIcYaV3CkzhSZGJLKXMFkRcVwUIrtTDi2ViEL/DZ9pe4wXRw=
X-Google-Smtp-Source: AGHT+IGIsY+fMOJ0iyEu9vfmYTToKr3Wef5yEAsQXVlhDr+6lu2vJj0cPpbE+RJLYb7ZvpWo457ot7GIknMwxDxUZO/evxFsZ7EA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3207:b0:35f:a338:44ae with SMTP id
 cd7-20020a056e02320700b0035fa33844aemr285298ilb.3.1706407023592; Sat, 27 Jan
 2024 17:57:03 -0800 (PST)
Date: Sat, 27 Jan 2024 17:57:03 -0800
In-Reply-To: <000000000000e9e9ee05f716c445@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007bd31e060ff7d8f0@google.com>
Subject: Re: [syzbot] [udf?] WARNING in udf_new_block
From: syzbot <syzbot+cc717c6c5fee9ed6e41d@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fe39a7e80000
start commit:   10a6e5feccb8 Merge tag 'drm-fixes-2023-10-13' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=cc717c6c5fee9ed6e41d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16700ae5680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f897f1680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

