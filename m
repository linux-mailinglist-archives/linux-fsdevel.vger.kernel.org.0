Return-Path: <linux-fsdevel+bounces-33572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0348A9BA2D9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 23:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390211C21501
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 22:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250521ABEBB;
	Sat,  2 Nov 2024 22:58:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41083170A19
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Nov 2024 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730588285; cv=none; b=H+qKHsClb96yhHd3E96PxYSNMM0F1Y7MG1dEWjenGmLkdK1Ic9cMtT7TUHI+HHZOTO4xqEMtVBrE3b/UpLfIqHAr6d1BzZJPxNv3vtOkXVAKwiKnJiEzBPuSAbo6YsXBTLfI+gzVdjvAH86OSoOWJ5QIRIv3x0JwsVJD4vwjZYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730588285; c=relaxed/simple;
	bh=lQTJmVE2dpbn2916q3lXchAWyB180O9oib1aRjyR9Zk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UwcUXDsaFdn4iWTu0scNWQAdh8u4x6LRV6yu+8f+9n+UwAgU96723VtXfTt1xtX6ak613bll8D5pZ+r7+fvXTxv2O4MEaZr7P8s6IRrrcuKlAD/yDGxEsGsHusPjirqqcpfTnCVVdYaSXgDi+2IE2Hquv2tRxKWsrGZCBxLuYq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso30347895ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Nov 2024 15:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730588283; x=1731193083;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yBzUyljWebaGC+XnQZjALDFZL0q7JsGCGKAUh0yZEw=;
        b=qlX1jxOYkq7JPk1IyRWLBhvQQdl4xmzF6JYzzxnBgmhyd2/teKA1KcpVZIjMvIb9zh
         /D+QNuRpIMc66kGYLJVIxvGjea+VKhJewRHj064uvX0yjV7fSWDlGX5Rpo+wix31dlkd
         zHjKcqVIjh63CZ0c5lwArBLbQCdR/HFdYlMPEWZ9O57fsx6tE6clJzhj05HMsAt7RljD
         Ou9ZUrZiT8NGqu3dkdkdUMHXSV2KDgV0UfugaL3V0rzuu6na46X/NvFzJlMQbNp2p3m1
         CxzGDsxz2iaJEyZnGYmpao7rhfV1POdNnwqaGYBDBIDDExB9spvpsH/TIvrYSf5U7HLP
         xdXg==
X-Forwarded-Encrypted: i=1; AJvYcCXY1nYTUeryoiOEL61ZrxfY5FcLl/7XCfKogiWvVYgx7DoGjGdBh7vl6cP9kBYjqMmYYAuNTSAk6AIygabD@vger.kernel.org
X-Gm-Message-State: AOJu0Ywll3dUyw3SblHZWem4RhUUPZP9kY8jiX2+bf0M5iJ7WRIqJaYZ
	HZQfVAcAnZrP/dm7gzPfdTk8Ix5CT/3xllbSrlCq7M3kjtYMiTN7mhHsDhEtCqBCntwcJm/uhol
	cJTtGb6UTDKUfih8HJGoDyYN2puYEVXH6lJy3G9iAWDRY0UrBQAfcTWI=
X-Google-Smtp-Source: AGHT+IHiBflm0OrHzRauDd2+Qk79yPQ2UsUXEsZO3NY2JhYxJXK8UlMJyJX29+TPwFZDLAECael9bu2Y9DD9M2ZTmExsyybtfnvw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdac:0:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3a4ed29dcdemr256947425ab.10.1730588283359; Sat, 02 Nov 2024
 15:58:03 -0700 (PDT)
Date: Sat, 02 Nov 2024 15:58:03 -0700
In-Reply-To: <000000000000163e1406152c6877@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6726ae7b.050a0220.35b515.018a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (3)
From: syzbot <syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, adilger@dilger.ca, eadavis@qq.com, 
	hdanton@sina.com, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	wojciech.gladysz@infogain.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot suspects this issue was fixed by commit:

commit d1bc560e9a9c78d0b2314692847fc8661e0aeb99
Author: Wojciech G=C5=82adysz <wojciech.gladysz@infogain.com>
Date:   Thu Aug 1 14:38:27 2024 +0000

    ext4: nested locking for xattr inode

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1245f55f9800=
00
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel.=
.
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1a07d5da4eb2158=
6
dashboard link: https://syzkaller.appspot.com/bug?extid=3Dee72b9a7aad1e5a77=
c5c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12407f4518000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D140d9db1180000

If the result looks correct, please mark the issue as fixed by replying wit=
h:

#syz fix: ext4: nested locking for xattr inode

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

