Return-Path: <linux-fsdevel+bounces-56322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE8B15AC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 10:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A628C3AE999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jul 2025 08:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E0262FC5;
	Wed, 30 Jul 2025 08:37:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05712F507
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864627; cv=none; b=j/wHseT/Q2BztZDGzBKNB/ZxJxQmsPfCfx4r8qTHjWznj8MdR6cZbkB9Thla4kW7DYOY7bMmdqFlEqq/CU4cAtRLkNvs7DBNKGkHlo1TINCUjAAQvwHR4uK9xGaUWCG2ykKwDR6KYbngbuHTMklCe35cJcNW0SuADHE8fKZ7es4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864627; c=relaxed/simple;
	bh=NkUOiRCCJLlWb7eUsmBdTQ2b3kyACzJhRlK8S3lG4C0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o5CPMwUjKTmWq/TEDgkn4R7vmpY2V/MJk/OyxgIDrMvLWqEiLIc78S2jdcpzYhx2Du5BlBGLON7pYQdl+1jbWQ5im45rALUIvefBSP3TubLS9+DT+Qr+GRGpBiRjOZd0J2oC1aFcaFY9OMXFX/qekdgIxr7fRSmDSiw9EcJ0NRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c752fb0f7so150461339f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jul 2025 01:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864625; x=1754469425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHawJtQ1MGRltb+5jXCTWQSQ/lIKowNfTpts49mnvYE=;
        b=uA0z6E12Losh2pmxXotHdFnY52QvXfLJNMb5BcvFN2kW9yFtvk5C7fuZuzz6C5NOVy
         91oOC5+SkG7kHQ8w94W58WLrGvaoaF0wUjOuJxfwNc0dVtZICK1jgrifurf12RmJxc5D
         zkFB3dE591vdYSkAD3MC5W8uwE6XBRjrs93NjHIkDzGic4uMovNJOgFBroiMlZkZex7Y
         U9Ou1BCXIkrGiUfEyVxzKuT23PpCCgg6T04AmhjPd9OjZ2eE8429FIXabIuVgYFKDqPo
         KaSBz7352DcEOBdGRqZlkjapl1SdEdc8aRP/7S4hmkdmw4dMWmr0NjN5HGrmJ0RNEUEz
         UxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3kQiIbOAtR/qr3FS1oCE6P2BblYHkquaXT+sFrEZiq9L92/1kHVz6l2aey0ZFiyERE18TQIem3B4Pkns3@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ/MbNckuGUxO/jBlLe57UsNrtASk5CfcFe5SM+7aTSrTW2SEx
	lfy7vv8mMOYrwn23Bd3HNpcXR434AjrfzXQEq5tVe2eCYdp6r8+v/D7Tdhk5ZtrKQRNfkUqy/PU
	GD5dTPUX4rUOr/pzecuZ/Qse+z+CQ91Qx75FR8kRZLfFcEqQEUjdghcR9sdI=
X-Google-Smtp-Source: AGHT+IHn7jUIMw81pbjrArBZNOmKvZBfVtYJhOLqBNdCKPEBye74nPONjr+15DWwZ1JzBUIdk74qVZbF88BPYUSRJd3glY27vmrR
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:7409:b0:873:47c7:6ff3 with SMTP id
 ca18e2360f4ac-8813771b53dmr493966739f.7.1753864625258; Wed, 30 Jul 2025
 01:37:05 -0700 (PDT)
Date: Wed, 30 Jul 2025 01:37:05 -0700
In-Reply-To: <20250730055126.114185-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6889d9b1.050a0220.5d226.0005.GAE@google.com>
Subject: Re: [syzbot] [fuse?] [block?] KASAN: slab-use-after-free Read in disk_add_events
From: syzbot <syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com>
To: contact@arnaud-lcm.com, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com
Tested-by: syzbot+fa3a12519f0d3fd4ec16@syzkaller.appspotmail.com

Tested on:

commit:         4b290aae Merge tag 'sysctl-6.17-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10908834580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=295b41325f4e1bab
dashboard link: https://syzkaller.appspot.com/bug?extid=fa3a12519f0d3fd4ec16
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15ac34a2580000

Note: testing is done by a robot and is best-effort only.

