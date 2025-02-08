Return-Path: <linux-fsdevel+bounces-41293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1255A2D7FB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 19:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19971887665
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C947E18FDCE;
	Sat,  8 Feb 2025 18:13:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47CC186E2D
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Feb 2025 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739038389; cv=none; b=k/LN6+clxT9iOhqwp7uZPlAdGwJfLhDV1/+WYpl9LVk0qjoDSklifkcg9LuFu2lwKMPSpQ0HwcIybRVf5eOuh1ViNOONoiFCB/bDv08NneHEJzrJfIxKoG1GEtgAEbjg9qFCrOV0GQuMLl6ZPit/vi1GZcT0YyfL+nwDdlntJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739038389; c=relaxed/simple;
	bh=jCe5Ko+BEiMMqUX4MLdnqnpGJApSfygeryF1Wff+3MY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C2YYa8fHD6kLiRRmTUAsy+z+ub08KvN1UMCMgTFZtQObSWkNxGSW/VKBm9UjhBXDxTtmfuXi9brPKIuDz/MmMHioV1K6HeZxlhcFNwf14/+iadwBSibv1CFuV8MXYkXPsuTl4z9fzNDxBR+oGBTfbCMb0+ADMYWUwpq/4Vwxcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d04dde4aa8so57073135ab.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 10:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739038387; x=1739643187;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L68seCHq06A0QlTsoJnIo63XmqePBu8IWHQHQYEeSNY=;
        b=XLi0d+e7JyiNadKt3BOn0YN81yJG452tt83dF3iTdkaTiD08z6wOHJ/rt6hr/mbJnp
         tEUMGk85f1k4rXNOMdHy6aOGXyFKX/+Ge8odbxiN2dYk2zl6g1EQX6xU0TYAwN1NHAeL
         pCf7dqlvioUHbWc3SUfl+WaDal5+lvyZcDzzqBITyK+JAQ+E9ckP5Z7lD0IiiXREjocU
         5IBgm8c4h1foNkH24tfaM8uTS8EvoNAE6//TwBHDgArnNadJwTvI4fSmZ0UcYIYkR690
         EsHeSoyWwEm5UZ1YMe1szEXt6WwxWnCJoAlkRHGLDqfYGzod2145hy8v6+dUPOa6sp7K
         MlXw==
X-Forwarded-Encrypted: i=1; AJvYcCXTWAdr21000iiORLrHZOJ8c6lxPImi4G+ovJVv2FIAkdllcFtnCIbuY+FkhhQP7TCBm4d4yLIzfKKcZ9Ob@vger.kernel.org
X-Gm-Message-State: AOJu0YwNYseToo8LrA0DoK4FMXkHKZtyy/30w2nhdrUCHr/gnpu0Ye7+
	xk4GvmWgDBFRu+4+ozDoKpthmUdahOZBZMBitFPNF3UA7OAE7pXf8K1vQvxumARJq2YcEMtEpz2
	2DUoflGqwXITmN4KdkwyCaW/cN7cdy0x0SJkA3yKR8ABvmMV7ukCeO9Y=
X-Google-Smtp-Source: AGHT+IETwaFD92Sx+P5rd0Aiu+L8tKh8GHvF1IBMYWIs66lr6Xv785MVVxiiiHfBDzg8qLYAfHoRYvd8OWkdK2oWeDLD3BKcI1IL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8d:b0:3d0:4e0c:2c96 with SMTP id
 e9e14a558f8ab-3d13de77ae3mr64920575ab.2.1739038387122; Sat, 08 Feb 2025
 10:13:07 -0800 (PST)
Date: Sat, 08 Feb 2025 10:13:07 -0800
In-Reply-To: <67a4eae3.050a0220.65602.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a79eb3.050a0220.3d72c.002b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in inode_set_cached_link
From: syzbot <syzbot+2cca5ef7e5ed862c0799@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, brauner@kernel.org, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjguzik@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 6408a56623761f969537b421d99f045a4cc955b9
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue Feb 4 21:32:07 2025 +0000

    vfs: sanity check the length passed to inode_set_cached_link()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152ffca4580000
start commit:   808eb958781e Add linux-next specific files for 20250206
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=172ffca4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=132ffca4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=88b25e5d30d576e4
dashboard link: https://syzkaller.appspot.com/bug?extid=2cca5ef7e5ed862c0799
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161241b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ee80e4580000

Reported-by: syzbot+2cca5ef7e5ed862c0799@syzkaller.appspotmail.com
Fixes: 6408a5662376 ("vfs: sanity check the length passed to inode_set_cached_link()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

