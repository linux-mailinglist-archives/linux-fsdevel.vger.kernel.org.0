Return-Path: <linux-fsdevel+bounces-73183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF80FD10900
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 05:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A61AB3045CE4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 04:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A47430C614;
	Mon, 12 Jan 2026 04:24:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B83A1DB
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 04:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191845; cv=none; b=DzQSgxTRENRM4mBPbKfpv4fJARu6WRi3MTB3oXgQL5EWoiQH9KlfMLNJ/THdwCsu2rs2cbncnVpEDT1IesVCuBwKMJrq26GefTmH6Ef0fRej6usvQdIPCdlQpUEDsWWAoEOA70vwM22kaNKoqwXX2FpjsNyUF1/PW4dRfUGspwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191845; c=relaxed/simple;
	bh=EinE8VXPB/8qmAOFx/VpltNzx9AP07UT8BMXb4BYv0E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nxeW+BKQBhO83bZmosw5XJuEAI3Z9oan5KD3KV5H6xf/h8L2s76BTq0AobV8ZmIg4XEjPXJRV41VKEoJFl7pZPuV5u8dk6zP5n+goSDDRbsKsor4JaIhFLylezKcwDvPbD6r0lY6xtlVFU8KQfizE4/e3JXgKhQXeWA2LziS2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-65f66b8be64so8415018eaf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jan 2026 20:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768191843; x=1768796643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2gl4hyoj6qGuCf2ibDRbBT7jnl2QJhFrlpft2pTxKy4=;
        b=Wyurjxh6wYFW8eAxAnj0rBOszHnbwrsN53VsFeGQfFkbPPf1p+wH9BbTbzvwC4zPXT
         3LqprWhJZWYrBByRSzO6c21pdWkJqpfU5/dxs2sPJUrc9O1URl2uOomcs6lyX0i71u6t
         k1Gwy/KaASAnovziHdqzZRZacB6v6UFUDmP4omLingObBeRfBSO6PMsQDheiZSym7gpI
         +umKQFVXawWjk4kkAakfxXCWTP/OkM0Ib37+YydygnKrxfd8g6iDNLqaChmx6ikUzibS
         ++LPY0upqIuWmITB2BGXI/dwBo6gJ41H+nxTg12GyPzsoB1LNtimbEAL1MsTjRTPBSJE
         ELLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9/VtMIxolDOUF+5EwN/Tj+IuHUaXiWUWhH8QJHbFaXYARhnswuvpIfh17ZXWbhSrLPiZJhMrVVrNTSC/c@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QjD3lNhNZKr8O8D0G0yW902RjUR2YdZoJ+GZw3pJ2Ql/lOCd
	6sQCO2AQopunaGDE3mUA0hH9PbvEmluMK95z3IDX8VEfiBE0yxpAx2GCO1pxtEbJJW3Gl1B0c6t
	M2v88KUamY3iC/eSbHv3h0sscpcmpfRYGb69+iX7SFfXrwi9FCdAnHmEbLMU=
X-Google-Smtp-Source: AGHT+IHUtJwBE1oSbGEiycxJ3xgLhYek8IyrgHwvrP+9hbIvo18Bdnj/pC/g+V+PZJN5/WGsvp0J9+Hi6eqnTelqmMh+knT5+eiw
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:bb07:0:b0:65c:fc22:3a64 with SMTP id
 006d021491bc7-65f54f746a9mr6283705eaf.46.1768191843345; Sun, 11 Jan 2026
 20:24:03 -0800 (PST)
Date: Sun, 11 Jan 2026 20:24:03 -0800
In-Reply-To: <6740d107.050a0220.3c9d61.0195.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69647763.050a0220.eaf7.0084.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_unlink
From: syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, jkoolstra@xs4all.nl, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 009a2ba40303cb1e3556c41233338e609ac509ea
Author: Jori Koolstra <jkoolstra@xs4all.nl>
Date:   Tue Nov 4 14:30:05 2025 +0000

    Fix a drop_nlink warning in minix_rename

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152d65fa580000
start commit:   c0c9379f235d Merge tag 'usb-6.16-rc1' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9ebb51ccc2ec42f
dashboard link: https://syzkaller.appspot.com/bug?extid=320c57a47bdabc1f294b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f409d4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1044ec0c580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Fix a drop_nlink warning in minix_rename

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

