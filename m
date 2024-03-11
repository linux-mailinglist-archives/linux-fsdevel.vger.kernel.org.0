Return-Path: <linux-fsdevel+bounces-14093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 276F38779E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 03:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D626328198A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 02:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0115A5;
	Mon, 11 Mar 2024 02:43:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB8637
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124984; cv=none; b=g7vsKwsMDNl7fa3LwpQxoItuZmO7IG2kNchasnPs71MrJutqnGWMiCLslyVxDd3PIURbcH1//Rh+Lahyo1/XKoic6tFldGD2VM6OKh/zLczjlgQIMTrJ1iTFO4zUS8ed5QXk8r9P3E+ZCgdVkWJ4AeRpFJX06QLAYp0gK4zMLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124984; c=relaxed/simple;
	bh=xCUFlySz/HJzwmMAGBTFTxjuuWHHUASmrs7xC9rWZPw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VIjX/hdhDVCpDb7EZrIuwuFxiyMS3uORBHEScqYm0d4MBXUqcetz9FFOcE9pzegni7N1LaBi28trRVSxhMzde34p7qgePwy0mM+4xuknXsmg6/UJtivKO19nF1b+PHdZcSmJjPrhzSQl3eafcOyXg35H6wRa+YQL5T7aC7CdzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso271795639f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 19:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710124982; x=1710729782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYcxoW7cD8kZbmcK9CYx64+UUR754gw2mSrSbnYLk3U=;
        b=ZC+U+VfnsCg28SNeLM7RkK6g0jLdz/tlagpfLqdG1hH8gUt5dmkH/xVv1ypnfaF5UV
         02RM0PT9EEvkwNqld0ih75dRn4YMYYFz1AmbaW1FQVLCUkyujOIaXyy3Ry/BHNBhF79k
         GOB8Khpr87wReezRYbXb/+vn64W2rkAMN2puh6rbDO/7qZRo0Gq6d3aiFPLVQvQR75lL
         rJgSgRExdT76bgWfFoPnZVVyAlt2HgJebVHHnr3axe+P4+j2C+/Mir11/K0hlVdudYAs
         GYtjQh0unkhULosgBccnila91KnBxO1ZAaelPZiiaErTFbCmOGvi+B2FwQnnAJDPgRcc
         1F3Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ir6X3VUlxgujXOownEMVHqaujKx8QIqK+0D9ZyBuMXjg38eveAHjRUiflw7A14o2dsRnK+eC0TOWlhXkx0+lgth6ElodUTGpCoWXQQ==
X-Gm-Message-State: AOJu0YyCgl9fg+nyS93x1uI06juC06U8f4EHYsRRcFpu60VZgVVLOxuh
	7HqhJNUoI2eNtP6dHemUQtK6Gi6WheAJL5khVXC+683MwwyE8RWZAUm0omEhl3KTv4NTFx24lO2
	SofEqF+nlnOll3B0kmzeshcHzKArwY4tlVk1ssQWfkINhmuZ5lHYldM8=
X-Google-Smtp-Source: AGHT+IFusFZ3cMvP6daHHhxIg1ZsGPjKlL68E2l1ow40+7e2ifpNBPt1WflepZ0E4AeJRGxuTr3IKFO2SzeuMxFXKz+Qf3Kkd3kN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2187:b0:476:d30d:8d10 with SMTP id
 s7-20020a056638218700b00476d30d8d10mr369190jaj.6.1710124981946; Sun, 10 Mar
 2024 19:43:01 -0700 (PDT)
Date: Sun, 10 Mar 2024 19:43:01 -0700
In-Reply-To: <0000000000001bd66b05fcec6d92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000121d4f0613598092@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in vfs_setxattr (2)
From: syzbot <syzbot+c98692bac73aedb459c3@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124c2811180000
start commit:   f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=c98692bac73aedb459c3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167dba7ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160cfe19e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

