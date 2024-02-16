Return-Path: <linux-fsdevel+bounces-11849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CC3857D9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7898B250D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B43129A9B;
	Fri, 16 Feb 2024 13:23:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C64177F0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708089802; cv=none; b=M4TCOrWAsdmg/gn+UYXo5IV3bBjd1mcAYG+kPosV07pwmqlMk1cUPTI5BtMNPI5ykOMa/NeLUg/wQb5w9HBJ7GFxD8M5WhAau3MMMcwak8Q/sBdVGHf+wt8SMgdoIXHeYokxgUbZmojzhn4holRv28Jl14nKQNKZ0jiD7VGaSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708089802; c=relaxed/simple;
	bh=FqSWe7JHiE+uJcy2YTdzs/EetirgcQbQTZpnVkzmo8Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=U7z69AChDVJD37wowEKDrGqQ5cHoQrhdmUX2kJ7fwRoGscd1u1HFj2M8mW0EKMVSmrqH+1VEVlTQObuh5nnYbg8RC1HEGZb+EbTyscJpKkQfJeCiNAWD9STbFb7FfwW/ePkheP+C2L++7HnmuF1cxJ1Zu9J4ESL94QrNlrElO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36512fcf643so1581875ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 05:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708089800; x=1708694600;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pui2IuVeVwTnvL6WtkW/nNwS2Ezf2FXXIiCC2gR7PNI=;
        b=U0BG2wA68fjTY8JZwyH8RFdgkXuHojF277z+xAHF8oAhT0hMh10ejrev4M4atTL5Zp
         icqOAw8X/OCIShxmsRfeDMRXwqtTo+fUPQpYJMX9YLHZq1oDxiv5zTPgUmf45EMTWyXC
         I4E4Z0CCcZs8YosPkDoiibIhNS1cJzAv4QEHvtI71vU8B/5bFUGBcv3hbJo0ElY0qESp
         gcGa//M7tpMUaihG6/HpLtLx1r80dGI2jxiA0fZBQWxHSuIvm7iL2yGXu8QUBGh/QixI
         U811zIjXcW13oW9398wn9+9z7Fif/5w0bX8+4uIsjzoLtCUTPVQANOUaRXUJpKZdsWUv
         pcgA==
X-Forwarded-Encrypted: i=1; AJvYcCWFrfqwUlRMdOTM6i6eSoE/zvl6i1vm//OPwZFIXi7ppI+QVeiX8Fk9CypX2GAS6WT+LUYAbgThFXJ0kC82J5pE9piUquCxmQnIyLjOcw==
X-Gm-Message-State: AOJu0YzLk5TewkW6CdtoAVzRc5zvKdOD7y2IAjote75KQ+UWCtbrAsAQ
	wG6s5vnF8vqs3UtYsGhaRcB2FERCdoNg1E+inZ+eLDin6bCXi2rVsCLrsrakN3jcqMUppbB9ARr
	LGjzbjKs68J8/o56nDgTdW75bDPQlsCnfk05P1149P2ujyInDOx2VC0E=
X-Google-Smtp-Source: AGHT+IHP3zirBrdpmR87Ieqf/kCU11sHaFTXhByBqF1DIC5U6wixLWGetyvp0XpBzZg6W+D+cSFdv2yl1SN+mh8JUPbcqnKzWsq0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:9d58:8052 with SMTP id
 j15-20020a056e02154f00b003639d588052mr368389ilu.2.1708089800292; Fri, 16 Feb
 2024 05:23:20 -0800 (PST)
Date: Fri, 16 Feb 2024 05:23:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca829f06117fa50c@google.com>
Subject: [syzbot] Monthly v9fs report (Feb 2024)
From: syzbot <syzbot+listc76971b2e26402bae4ab@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 26 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1611    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 265     Yes   BUG: corrupted list in p9_fd_cancelled (2)
                  https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6
<3> 9       Yes   KASAN: slab-use-after-free Read in v9fs_stat2inode_dotl
                  https://syzkaller.appspot.com/bug?extid=7a3d75905ea1a830dbe5

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

