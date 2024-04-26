Return-Path: <linux-fsdevel+bounces-17899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2D28B388D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF5D1F237A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDBB148301;
	Fri, 26 Apr 2024 13:35:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21A1474A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138505; cv=none; b=jPZgtWv/eOT7N2l5rz1UqeNcLGuxpBMXjWl98wtaoSfj3wUm8nvtQWhNoznJg4LFqv2BA0hXYecU9l7RljBpsOVRgvgU6j3Xma6nOGsu6qBfxJK+/2EV5yzsbZNSvH9RMUw8JFu0ZRyjWn9GHUayDpgHT74MlKJKReNz1z4GdrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138505; c=relaxed/simple;
	bh=m+kS218jt0du5H+U4ww/ufMUqNVw+bWZWMftVxqX6uU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UG8N8eBeXxz/2ZUCSIq+LXqqd42cLHeYdC6cuycWcyTX/yNfqDEBrck0uWtCE/hnxWPsoRUs5RRQ4+zGUG01Y//GsqKIv/KgPqieQZPgX/VmJicTAM5SS5xK0U74383jsVOBetutl4MvYVVCAV9knudtStkVAYt199ARjlRJnEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c2ff79144so15655945ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 06:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138502; x=1714743302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuDLgNPEPbdMqePbD8KgIT6xOlVG4D1tdaDE2YInWA8=;
        b=v4vq0rHj6RjlPhZHuYOMUnS7eF/R3kv0oTi3yc2a8s0glvqUUw/t5IFqsvtSBEg2xF
         jGTS85OBGM+s1hNmisz4A72eRySNItIJwGoU2GMZMT6Wk/CM0A3vKdE8d/xLiFArcSa1
         x0W5tX1+jYQq/XGsPCnf5x/1NF8FtT34AiKCPydAvVeHdW08TVCl5uzIRK3kJ3ToouBC
         dYSTU8Dh5wyONcFFDyltampQkIIr3OnkcwqdoNwZ0Tl+3k+aRqDeKCVM6Ec/TgWmd8xA
         0VF0zj8QOjG/QtwK6VB32jpB73dbdoHMg5ix3zeb00Qg9g/SxvjTVHQYsciRGdfVBaNf
         PFLg==
X-Forwarded-Encrypted: i=1; AJvYcCX3o3n4SG+G6xpjOsPUSaYiSaN/LE9selGW963D8MMnr6ke8fObbi0traJgCiYVt2XwIJYLsHtycrq3zj/zLtTf38VvwMvFkh2S848WBA==
X-Gm-Message-State: AOJu0YxXo0j/U+XUVOUpwEmcQSSYRoaRefm+sl/vuQmSnx1p+lvrKBZ0
	I1Z9tzDhTbbD/j9D1+DgeARNgnvjoXZG99Snar0wMrpHi9HaWzaZhHL1qYwQWZDJyHY+iVhDdSF
	GzVutzSRw3icWjhQZ/OrlzT2mx9YiIDd60MqIa3Ej/1S2p/TzR/iXbfE=
X-Google-Smtp-Source: AGHT+IEmE/D5eUWM3aazPdASVp2ndWN2Klx3oxJWUkQ8hKxgnVlM7qt0MSyaTsonzow98DrxSD3ec2fL1yp+5/rIGkUCMCzs2HRR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:368:c9e2:b372 with SMTP id
 h26-20020a056e021d9a00b00368c9e2b372mr59976ila.0.1714138502468; Fri, 26 Apr
 2024 06:35:02 -0700 (PDT)
Date: Fri, 26 Apr 2024 06:35:02 -0700
In-Reply-To: <c0a1b8d8-4b54-4881-b924-406e0e2cbca5@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000892ccb0616fff80b@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-out-of-bounds Read in f2fs_get_node_info
From: syzbot <syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com

Tested on:

commit:         77d6a556 f2fs: fix to do sanity check on i_xattr_nid i..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot
console output: https://syzkaller.appspot.com/x/log.txt?x=1535f237180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=3694e283cf5c40df6d14
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

