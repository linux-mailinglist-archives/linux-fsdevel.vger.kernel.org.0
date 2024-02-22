Return-Path: <linux-fsdevel+bounces-12442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC13585F63C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1FE1F26686
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA9C46557;
	Thu, 22 Feb 2024 10:55:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441FF45BE1
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 10:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599304; cv=none; b=rSaibZbBFFGzyF0Ch+/oC+WE0tqkuB4V6QfNp63tvQgyjKP39jGUqe+Ye93NkXxwGLW5nwNqJm16nnq42zEqdiCV1fX7Q1nWpk9sppsxhghJalQCobmQd3H5CItKtHdWsR2R3b7RLo9AHf/pzet3irLItda6RrEtOqzwEGexI7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599304; c=relaxed/simple;
	bh=ha1O4iLT6AxSqj0DgzjOIHcjSM59rIa3crgUCBSCn8s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iuHAiVknQigamqO5l11G6sUQGk4IZnqwd786kjN2dUDK7rW0cWWQMAsyHJT8EtRrlB8Qp6FGs+QmVeysvnYjNbJFmkIW21hpTE+ndsShsAsZP0+ybIUJ6+gnx47CQE0i6hLAsDo2BOM8KRNSLQvJ4KsFXdWm2NDoArURlpiZFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365067c1349so60954345ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 02:55:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599302; x=1709204102;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBV1Xfaxmpo/itADc9WYkcmWfCaWC4fUkR16tOejUkw=;
        b=QoS8Q0YChC4TOUidIWt6cceg1y3boN/V+RZGoMqXpO60BjSym5qk5ediViEqVvGgn9
         0XmH+er/XEIdjtQIQKM432536NZAb9dTvLJtPYp3Vx2G213/3NPJ9CPTVUojvEEOE5Cu
         NBbiwwDCu89F62Fya0ZcIn3RX/SdJ8Tdg3VewQNJuOGLwshPAOUYeK6O4AI8LSekWzfX
         +BAn/qHXYw8nE5sSf/+ncuE1HLAE9HYu6PeLW8kfxPlweftxNIcsvfnl3esn2Ba9pLuT
         eHCo2BzMufaf+XI4SBZk1D4F2v1xwTHAkn+p2Fn5VneBydGzzYvsN2aDulWuqKZCcaOF
         tcMA==
X-Forwarded-Encrypted: i=1; AJvYcCWTMKFS5EMwjYkwq8hg48C5sP2DJt2JagtkD95GKDRAhEzkx00A2/XAtVW/WqJ/11/59e1op/JsBnbkWXJwMa6GBWHJmQX0TewXm0nVtg==
X-Gm-Message-State: AOJu0YzDYgZuHILWhHVnETIb0FQhqYT7YQsn5yoG1G+xbwkm8hqx3hHh
	dH5Dq6GbErKX6cQbhwYxbTl79cabSMCJWtwNRqDwJNJRvnhK/+z5WXSiIYopGVlObEQ5B/5HHlq
	J7S3JeNTdcD/GGBjZVFkNAisVMdMMCjpga4QWov7j1crcq/pFl+fNxlk=
X-Google-Smtp-Source: AGHT+IEF/xyqLKklQw0sVER+TM5iYp/KdEmM9KqeMBTj0TPm8rLS7OaKIU7QbZcgAMu73ys+aigHWAjlhsnpk9/4AoID+Kmj+kTX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9d58:8052 with SMTP id
 j15-20020a056e02154f00b003639d588052mr1623135ilu.2.1708599302546; Thu, 22 Feb
 2024 02:55:02 -0800 (PST)
Date: Thu, 22 Feb 2024 02:55:02 -0800
In-Reply-To: <000000000000779efd05ed36086d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007def780611f64694@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in reiserfs_ioctl
From: syzbot <syzbot+79c303ad05f4041e0dad@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14c4cf52180000
start commit:   1f874787ed9a Merge tag 'net-6.7-rc9' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=247b5a935d307ee5
dashboard link: https://syzkaller.appspot.com/bug?extid=79c303ad05f4041e0dad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125c3ca9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1558b19de80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

