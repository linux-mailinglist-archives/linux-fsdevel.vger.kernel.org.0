Return-Path: <linux-fsdevel+bounces-11332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF2852C70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1763E283645
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75A24A1D;
	Tue, 13 Feb 2024 09:36:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AF2375F
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816968; cv=none; b=PZaC2C6IpaSuIXUcfgaEHcCBW09rFSfYJJNvIpyZlKNiKsQTtxMZuifWJ6VSdrOcX1Eu3iwOjJRY66jOc1EnVVkJjPeQVEAapwJRiX84MVxyPniN63wURYj1T5mI5i16PpcyQzyyBI7KFCBucKgPSmi0LJi118W3aUDB7czHKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816968; c=relaxed/simple;
	bh=gB9pF2IRnItjsStceZOJgtsH/zgzqRAJJ6aBRP8TlIo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iyAapKLhxMSM0nxR27NGJar2ft4W6RfNNljsUfZN19ZojbF7Ma9b8QmyiBkQhcfgvp7zfb0eFwMoYnT+lPB9nDQi3n2Fgpn+A8jhPFq+crWbAuYH9N586AAusRONn1+SPfMHXPtAC2YsStRZgVliks7+vRh2Up9DRn1EncEgWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf48e0f513so486526739f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 01:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816966; x=1708421766;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejmJHoSutOTLtAXSDyUaj9KDqD1qf6XgyfbLUi69VDI=;
        b=ULsVzV2ioTGfdQkeDk4Iu2ZM+9fVRmjJ9tPAqI3Pq2I/X666JQ1RI8n/VdwhfDweAn
         tWvPlFvlQy9jPM2m0cXv+0qCdW16I0WAm5H1NI3UKQzzqqcHFOhO8/3Dj+M0trAx+liO
         sy67f12TWgTzgKzvefc7tbG5XB6032oN6SD2Qs7wC3qQjVl5Mecx3sKj/3bzACrwzQMH
         O/jRNQPqpI/Lb5RXXtTDBfczRN53vgQFFAIDKnFk/k76WVCSxJWvjDTB4Ro9vK8iqMLu
         JaPwiUCkhyB1HTT3IH8R6lOtFVs6eOPFVzulGXFDiLyu27QIJb57qOhHNVF+xK8F59pU
         dItw==
X-Gm-Message-State: AOJu0Yx+EFmdk1AQEtwARDSsqr+6EPDE0H9RZEG+ta/7cPyzciApmaNm
	nOG5GQG89KA8awBYfIYAGFrjy3SEFgE+UKSs+y/KOiplYNON0xeQzk3IXcLAiY6J2WRCcK6UPh2
	6msHUMyMQs6AG9AFrCdlP7XbNNfWn1GtoSYi8gdh/EKLbLjkhxmy47+U=
X-Google-Smtp-Source: AGHT+IEnypRnnduK0++8Kzb3OZ3IgCZSNrsFE6lWS8ZuFX+JdVG46nZmpYa2s1v0Ens4vt7ghmy7mqj915xOsfZ0xHJrPxrbY6Bt
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6d15:b0:471:107d:6708 with SMTP id
 he21-20020a0566386d1500b00471107d6708mr126223jab.1.1707816966146; Tue, 13 Feb
 2024 01:36:06 -0800 (PST)
Date: Tue, 13 Feb 2024 01:36:06 -0800
In-Reply-To: <00000000000079c7640604eefa47@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bd5560611401f9d@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in txLock
From: syzbot <syzbot+451384fb192454e258de@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1588d6ec180000
start commit:   65d6e954e378 Merge tag 'gfs2-v6.5-rc5-fixes' of git://git...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff0db7a15ba54ead
dashboard link: https://syzkaller.appspot.com/bug?extid=451384fb192454e258de
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140b48c8680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15276fb8680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

