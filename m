Return-Path: <linux-fsdevel+bounces-57342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A78B209C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 15:12:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F09E7B2B96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 13:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92FE2DCF67;
	Mon, 11 Aug 2025 13:11:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150162DCF45
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754917866; cv=none; b=WcDLqJvWcizGGMYDZdAyj5jNHWS0IAWsNvmgM6gKVX6g/jYjrk96b4ivEY3MHlVXI3KuF6DPpNRMuVBD0XKTpGwjnQqkRlUOdunX36tTqekgZDJ6eB7jwCi68B3/CReTFzN1dLB0rXpsONZgCcQeGyPtlLC13IOgatsBHGFHSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754917866; c=relaxed/simple;
	bh=xD0rhCCQDxyiCTCiqij42tudVaP/CESMLu3wSMvzdTM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZQIbzUthmdeGZs6vRJrRLcErghSUhqWIFa8x+rBcQJZ+iDF3FtuBAaW2bTHwegp2aEv0T4gkVW6bsbzH9N/qy7XIcsHPc0c6icFY+wmrXsWmbV4OmZf2khQcQ/+m8nRvNMnX0xB1DVY6ErGfbpnCr+JyEAYKGu+9FCF3pbAJ8bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-881878af906so869441839f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 06:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754917864; x=1755522664;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9dk/KXnfmnIr4tFpnYGM6Fy+h6Hay7E0LqrHRkUZ/Y=;
        b=aKP73IEFY5PYcJ2fz9/lL0cThKe+lR7prkDvrZRtmRZHem17+eOs6wLzvXkIeYfZXs
         FEdBk/wb68sOa6dGdGhZB+tMJZO5GiyxmoSffOXpEkd6T8JDaMdoVzuK3rNwp4bkoyCI
         Fi0/i9a2A7uv0Ure04Tbvombe/EVxoeH08G9mJkBk3YJTBYzTAkrppJwSx/ztrJqXGc6
         xeRT48mMUOQISKEjnRe4uY4p3UdkG6HjL/RlBDgjrQu2wenLVyF9mXLtFJZ+7vvw3WLz
         Maig+klvCsrUz266UXjisvzYME+XrZDoqqTrYcGP4aRQ7V2/CR527vi/KNnDoZV9D+WS
         ppDA==
X-Forwarded-Encrypted: i=1; AJvYcCVjqXxSB2nfImge3XEkMDxf0epopTp+Uch4T5Zx2lkakW6fulaxEGRIrNqBjferSnKKqeZtA34SQ9Kmiozn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/OpDOkkGpTx3M2kmSYcQTh7Ya3J2pSGZil2VoS+RKFiGC0WzG
	r5Yo+t+mAXFLSlQYh+TmYSL8rE1x6iLyknW9p/n4rXAIOHk5U8nbWpW6Lk7wQDGW4mx7CdcRryS
	UtGj3bt27DF6UOgMiv1Wc5v8I6fhMcj76ZHVs8a00xqcjV7v9x9EQiHqx+Ro=
X-Google-Smtp-Source: AGHT+IHp9kHMc1UpwKQ0Vk7zM8V/ayxaruCybpjEPHUNxmSMW53BtQydoWKdfjWT0CkXKjyVjb9CYlFLTTfcQDbsDeNWS2uKGzn4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1585:b0:882:a22d:c543 with SMTP id
 ca18e2360f4ac-883f1268d15mr2517820939f.12.1754917864223; Mon, 11 Aug 2025
 06:11:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 06:11:04 -0700
In-Reply-To: <684c05ba.050a0220.be214.029e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6899ebe8.a70a0220.7865.003f.GAE@google.com>
Subject: Re: [syzbot] [hfs?] INFO: task hung in hfs_mdb_commit (3)
From: syzbot <syzbot+6bdbdd12cf8cdbc66466@syzkaller.appspotmail.com>
To: anders.roxell@linaro.org, arnd@arndb.de, brauner@kernel.org, 
	frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 42b0ef01e6b5e9c77b383d32c25a0ec2a735d08a
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Jul 11 08:46:51 2025 +0000

    block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=133fa9a2580000
start commit:   19272b37aa4f Linux 6.16-rc1
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c07f08ee4bcfb276
dashboard link: https://syzkaller.appspot.com/bug?extid=6bdbdd12cf8cdbc66466
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e6ca0c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d429d4580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

