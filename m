Return-Path: <linux-fsdevel+bounces-13386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E8E86F3FE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 09:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30EAD2826AA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Mar 2024 08:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A954B642;
	Sun,  3 Mar 2024 08:30:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E716FF4C
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 Mar 2024 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709454608; cv=none; b=erI6TPu2d7pP1ST4+OrHbKBaGmqPPApb+CFdMSWhU8U144lEirY698Bi+QW69X7YwihG0Ft5P/FKMThU5JftDGtDsERYv3z+w1APDQO1IvU9mfACL3e/Yyy9GNPszA6iQxOLuOJLXaZ7Lma527fuw9Vt1f0UI+1iSNpA+1N7nFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709454608; c=relaxed/simple;
	bh=ZN6/uX4Tx0/Y6hxHxujw+cQxS8rTAmYY0DHz938FZb0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=k9ukpQCCOtpNCjeAcsOAfoKye71pC/BlG5Hh0vpIgSByfRLvriltR9XXm6KHQrwpmK/+WL/21wnEMr68YXfEm874wQf3lYWDjjtjZkHPFI+9ozehMhn3P/d+wjse9WFM7pOeNnHrOkuRBV2GGB1wfW+lz8y7hy9eNv6Lz+Tr0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-365219a851aso38725905ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Mar 2024 00:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709454605; x=1710059405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw6wOjMgK4MwRpjPkZeZa5isVmvzXm/3D1T3RvcQvyU=;
        b=sR+rUeeWFQy3+nOhxCkx2l9DZjTryrBbvexLOcm86WO1i7BECsIxugLqHVlZeI+Jxq
         GzTUCa55M5jcKVKchOJV3Euqq4XFAVxSzecbDSYMcX9VJcWMjbB6E+/j4aBPPz9auFQ/
         +ITIkA5+edrZu7ax5LqoI9BK7kLuxU+NpoxU9ABQm9lsut8vjQXkkC0e/2KGMgZFVoVy
         lzWOc46EC2ihAXZArb4ts4FdG7/ASZjD7VlqyhoILsaI3/8nYaAkSrRoWixhqW/ITayO
         CurM+tCTL3i4slOgHXcZ7tam1k7JDeZxrHusqNCqjgBQCGDXSmFrQ0fQftkwN/2G2+b4
         X7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpItygKvWK2vtgMfwi3Vgz2PLXM2XYCiGyAcUS4XN6m6SCxz0O9zKPh2qSpTvH3q48GXVR0NXD3w7HbDukGZd0oO6ysKEOzQuUZUhWwQ==
X-Gm-Message-State: AOJu0Yxw/xAQ4u/rEdZNN33vhbq7B8Ck9tTwF43H6WZbt/mETqpL99ei
	GKWXEjmJOwvkn0OpL0KB2rl72aRiKFHXmt77GxxoBCJXJfhv5X67z+gX+MBm9wf7wn0DuxEqyOY
	1/y4auTV33uaaDCCropj9HLH/WJNIEHrSNnN6jUPZP3mTlmmiby4L+Ds=
X-Google-Smtp-Source: AGHT+IHR9m9OWQf2a5daMm1kcCiAq5nUoCcInX4EAJ7d/KyuNCP7k69rkgu5tuf8PQMAEmm1FSHLXoo6Fad5z6jCDdAWcrsKdxpo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:365:2f9d:5f04 with SMTP id
 u8-20020a056e021a4800b003652f9d5f04mr488751ilv.5.1709454605217; Sun, 03 Mar
 2024 00:30:05 -0800 (PST)
Date: Sun, 03 Mar 2024 00:30:05 -0800
In-Reply-To: <000000000000c29dab06004a752b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080f93d0612bd6a5e@google.com>
Subject: Re: [syzbot] [fs?] UBSAN: shift-out-of-bounds in befs_check_sb
From: syzbot <syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com>
To: 20230801155823.206985-1-ghandatmanas@gmail.com, 
	88c258bd-3d0c-de79-b411-6552841eb8d0@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, ghandatmanas@gmail.com, gregkh@linuxfoundation.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	luisbg@kernel.org, salah.triki@gmail.com, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com, w@1wt.eu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14b5e754180000
start commit:   8689f4f2ea56 Merge tag 'mmc-v6.5-2' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=15873d91ff37a949
dashboard link: https://syzkaller.appspot.com/bug?extid=fc26c366038b54261e53
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14237dc2a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e34d22a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

