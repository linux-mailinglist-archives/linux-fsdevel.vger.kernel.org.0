Return-Path: <linux-fsdevel+bounces-14062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F1877403
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 22:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AE5282E3F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 21:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF81A50A93;
	Sat,  9 Mar 2024 21:19:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280BC433C7
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710019146; cv=none; b=NIvqXjHhFsCsR+i4flQ2IObaOv9fFsR2wyHw3rhHTpVPXQFsx0YGNYSVLbFmES4UWWiVQ/OAgB5EA3+yYsH7jnE6k6XEgAa4VrqmMgLz9x9dG+kPFrymU9/1epuLYI9fgAvqOkuNQldOZX/JOO2+DuslJNWUjcYuUh6JBTsudMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710019146; c=relaxed/simple;
	bh=Pa7sx8/xOTjjXflylsOjtScryyrbysvuk/h52s9G43g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mdqpclhgu2lDm9WYAfUZE7Swwh2K83viYybm6l39b9JVQ34OWYJRtkUxY6RJASrs+aGY850Hj8cZfpr6XJ7Ht8ncu/zW5gRAETeX43YxzjTPIUMybuLFphYHP9tN2LIq6Zf4xXampkFTcV+O3NH4sU0qU4mbX7+tBBlcMQj/7R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7e21711d0so271606639f.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Mar 2024 13:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710019144; x=1710623944;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRFBXIh18wCLBO2+SM4FmreOxz5t2k1uDB7yZ8xEagg=;
        b=XSTXWPawNrf6sd3xuNCUGP7G9QVAJ7GRx7qHwxh+YgVBvZey/PFS2tQkXai/zV9/am
         yVEQEqna/dsQb5r/SRUNUqDvoAmSK3caSRd0yhz66IDyjUWPCF7oasVMkyLEQR/W6w/Z
         vAmzTMkLfzYM7vJDreJ8Ys5uwVCAoc4pd85/AiOJgDM+fx+uK+h8sa86Xfh0FedlK/bS
         Mi44ml7ybTDuim84hblUdZeAxh0PqB9xtZA5V/cbi67vrDEA/iTSpWzUB2LJ0I55oQDt
         Yfmc/Sn2LMnOMQlmZfVTk0+ml9O6/GZ+29+yLsv+GrwEatRQCYg2wSOa1MXzPiNZrXQr
         wKwA==
X-Forwarded-Encrypted: i=1; AJvYcCXMGERNbjH/xJ1LBacHCFMmMkMGbaG+EFSHP/4haGbwoaAQudHRpvcphMzS9axxHCTiy2l/xTMjuotxP1sHWUFC1RlFuCI+LGIsYR8HWw==
X-Gm-Message-State: AOJu0YzHUxrWSZOQiBG+VgaN6BAxkRaAqTqYOo7SASrUCgzzNDSMdP8z
	tlmtgWjhFJK//wZXA5dyT0S18PV8svyY5KCo6mzPguYhlcsuiqxCYNvdM4F0Aim6v5kCcJ9ZVAs
	x6qFzY9sxIl4WsX8n+TyIJBb2QuNsf9lwXhQ3yY+0Owut6m5LXw79h/8=
X-Google-Smtp-Source: AGHT+IFQgC/Y/uWGVhcWmNcl2ho4MafDLtAn5gwYRiBKdk1E4x8S2kf/9BZ6o500V0XRqam5OriFuXksXHwaP1QMt52X96IwDuf6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1653:b0:7c8:4198:c430 with SMTP id
 y19-20020a056602165300b007c84198c430mr36002iow.2.1710019144429; Sat, 09 Mar
 2024 13:19:04 -0800 (PST)
Date: Sat, 09 Mar 2024 13:19:04 -0800
In-Reply-To: <0000000000000149eb05dd3de8cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9c150061340dbc9@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in ntfs_iget5
From: syzbot <syzbot+b4084c18420f9fad0b4f@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, jack@suse.cz, kari.argillander@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1649668e180000
start commit:   3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ccc59c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10928774880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

