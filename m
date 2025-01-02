Return-Path: <linux-fsdevel+bounces-38347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B79FFFF0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 21:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E6E7A1D80
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 20:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6024E1B6D09;
	Thu,  2 Jan 2025 20:19:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCD31B425A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849179; cv=none; b=ObH/nl+M1X4N4jaZUPZBaA/B88/tVP6dsuaKIn87xaWaODlbcZOaVzMmDftTpc5yW34L0Cnv8f6ijN4O2glOsr2rRIs5R5xPm8rYBo5PBFRNE+AJOEPCeDsJLU7SKIHnjIyolIlK0JSugg2ClW4zB9EOE6anz/7QrnFbZcGo7Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849179; c=relaxed/simple;
	bh=0et2PUuVun1y3JgjI0sUvxWxeyC+XVDExzyexD6fPhw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=gVjpTD7bZha3xwVF61WPum+1cempJrZt6PmR+UsqSaSMnVC/5VGaz4IJB+peT+UbcwX06ShCijGbqP1Acp7AerxOKevwH/29RkXqtsbc4HPn4k01V3bony1geSYUTsf51fiAZueFLbb9ZrktTNeJo8ZxhtA5IQD7isrQzwc1xWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a81570ea43so112527795ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 12:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849177; x=1736453977;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0et2PUuVun1y3JgjI0sUvxWxeyC+XVDExzyexD6fPhw=;
        b=j0LEMZKpv4gDdPvvOFBJkvwSSeZ9FOBNWo6w2wWamt3WEo/N4c1YbqpkQqRFGwUqZ3
         qoghX+ViHB35pnqoqsJyqVnEN2wSwsVExvqesFHvldBjqFeT1uqIfYZ5eRzaEHTdblxH
         4fk84ixnDgZHamZKDFkzcNxIT0sMptJp3wTkRGHHp7yXBZ99r+8rY9rj9DatuJHhXbfz
         VPGkzMtcZt0c2Ao3PAJQSsd4i//GCWNxnzi4Nyd/TLzqQSiVNDUfwq71+ZO1CPGdlkj7
         VeKZ556qVLRZTH7WxMhoot3a2W7e02vDpSxwjtYd+D4kQomQmAelOfo21eLo2gVgEIkw
         VD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWvg3FTeLjHxIDaccQQnb42Gm51Lgav9zxgzXATVJ2bV7N7FSEYBmux6mqmZ8yqTIsQY8Bkxw96qynjBxm6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy784tFL2RPlO902dYD4TI0mK9J5ym3KE7Gkpkaa0fJ+EXEofIt
	p/Gz80HuSEb6ECtnL1x6qJpykO6K246v2WqFqr3FMnVQesGGIZOMoFzN124YuTeRAtRR6xZNmI8
	oB2+0ffP+bZGaVJaLcwya718uGr9UiMyabq7Zg/wQXiSSKSu+QA1o8MU=
X-Google-Smtp-Source: AGHT+IE5j+MoGtKa9tT7cMlBVy+6yXZQjxDjqR2NWIsMJqlaoPeHVrLXBkCjZm2EcaRErmfHGVh6gIdu7uf+B8k4nkiexmNFhz2h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1645:b0:3ab:8db6:12ac with SMTP id
 e9e14a558f8ab-3c2d1b9c925mr340133665ab.4.1735849177379; Thu, 02 Jan 2025
 12:19:37 -0800 (PST)
Date: Thu, 02 Jan 2025 12:19:37 -0800
In-Reply-To: <CAJfpeguPw9CsK56RHGTfpYhfh4V5Kj8+JHJJo=hJDy39=RB+3w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6776f4d9.050a0220.3a8527.0050.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: miklos@szeredi.hu
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git

want either no args or 2 args (repo, branch), got 1

> 7a4f5418

