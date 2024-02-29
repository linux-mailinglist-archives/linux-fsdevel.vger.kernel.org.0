Return-Path: <linux-fsdevel+bounces-13184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEC586C6E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80FC21F230AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2893964CFC;
	Thu, 29 Feb 2024 10:29:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65164CC9
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202545; cv=none; b=KepVvBPpfkcyyanhf7ave6OsD03JOqFxw76PUUAAdZSRZnUXLKGyii4qvVoBR5YhzWjuocKmksEf0gVJiv5mqGm38I30A+foLOCB7zcUyx3ni5EQtUM/1d/6B1JLDpaickoi0Q+ECbr4jNABq5iztGOPS79MO1Ai/QBphLswdww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202545; c=relaxed/simple;
	bh=G/v8tih04oAC4s//9EOGB31fFEFCAiSTHed4T5BB2i4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hYImIQO5wYtogmlSkhvct2cg07m7WCaMCY/EWjuAaHbkBFjDAJi9p59ce5NjRgZUvxBp5CXTMp9Iw1MrZyAnw1GPWes0U9fkCvu84UEi6dsXv23XF9TEjd5vHFp2uzyp8w+XdqiLIMjyEUj1N4PmW64p9g9pAAjrVDZNYHyDXmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c76a65a4aaso53565539f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 02:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709202543; x=1709807343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=due3BSO2Q9QQy1tfU+DhYvgI9lxf7h7yLmfxg2bj9yE=;
        b=nRQ44oYgmVADnsT7D3ZNGmJ8Sfv8TATsbfgiOOUavcb6O0glnys3HMBDcSTlV3kgh4
         Zcwhaj2NATPTYF5PssVBfsXlfZggGE06XlwyskeM5OtOLihq0ij4aJkXuaRsw97byQBW
         2MTqGjcbMhHtbVqmBGd/rAfNcnaSpsh9mhIbnBWebpc23ZQWlor4aMmRr4yEjPEA5fWH
         c3XswmD3Ri1B9Xjp/JGlVOf0o9CfBPd2eJKgFiNToYA47Kx8K+h6HFhI2s+qYBINZ1jI
         RzsSQSVugDP7z2AB9EpDsoof/TVt4Y6vv7ffMe95kLLesZXUU8CmZ9vbZyWOrynikyvE
         xI+w==
X-Forwarded-Encrypted: i=1; AJvYcCWnPN9xaMeHdrtbaCEs7XIO7/pXTM2K1LlElTMdoaU16VVJ0N5dAKfhynerYjXYj+XhG3wRkncrFkU/bwPo6Tc9Ug5vIytZJCr762Seqw==
X-Gm-Message-State: AOJu0Yx7ItXUHaH1I/ifcth0/tLRJOoy02hNGIDXa/in0o6dMNo1YTgk
	Emd0SmwftLikgzr6BxI3LVlrcuNdOwI00oJM/+75m24odcjYQxCrw9O3i+swv91O7NXP+5CqkfP
	XIR90YrAl7dbUR0Owy6YoSylQCbfOMIQryzX82zL5GpDQU0HkP7Iqpiw=
X-Google-Smtp-Source: AGHT+IG2pzGB/bSL5lyIW4of4SnG2AETh2eVcWNY2PjmAky9W70Ne3ilD1c0bgJEXD2NQSMBqAVmrCjpUxXXw1IVIbbE8VsD2goT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3c45:b0:474:ba84:8ded with SMTP id
 bg5-20020a0566383c4500b00474ba848dedmr69269jab.0.1709202543676; Thu, 29 Feb
 2024 02:29:03 -0800 (PST)
Date: Thu, 29 Feb 2024 02:29:03 -0800
In-Reply-To: <000000000000602c0e05f55d793c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007717e5061282baa0@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel BUG in ntfs_iget
From: syzbot <syzbot+d62e6bd2a2d05103d105@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105d5a6a180000
start commit:   2639772a11c8 get_maintainer: remove stray punctuation when..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=d62e6bd2a2d05103d105
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1358d65ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dbbe45e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

