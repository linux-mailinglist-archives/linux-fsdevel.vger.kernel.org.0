Return-Path: <linux-fsdevel+bounces-72632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68163CFF2E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 18:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15FD0300503D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C20135BDCD;
	Wed,  7 Jan 2026 14:57:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36A35BDC5
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797824; cv=none; b=cwL53HLk8nUT9I4ufYvXpCbM7N4eYURidZr3iEltlY9nnOkvDmblnZNketMp9nbS+PRxNNGWfNCbRDc+wdHfILRwnmhfKq1baDtJYQcr6iHeehVnD1YO0/cs9rAzDII1s3j/rNEzc2H7tGIceRqm01v1wscgcAeR9HjVUBde9PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797824; c=relaxed/simple;
	bh=bPm732q0gnhK87KxkiIQ+ASftplERVhxCxMzvNkoQoY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=G1AjjYsggqu1sRODbhxs3hH71m9334cuoRh+P8Pc8WDHkL+pQGC40bX2EN8fR1mcyaEob4/aRo4+RrW+k7hIBjtvaMlmg+zgd5prZHuCA3f9mkZ4X51yP3b6AYhh8n2IQEP7aQHuf3cLm8rYL7mNdOHutKRjq+f6PzJiXkBfXGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-65b153371efso1611799eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 06:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767797822; x=1768402622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXNc8aW1tUrl2KVWvVMCKXzy2pWDkUQN3ZlLOLhLBCc=;
        b=Gm8wJgMvW+ncaoslqJJApUhPazLQVm3pttV+k1GWM9mu2I4fCtW/bcicFKDMW1FTis
         D6BOv/LdbHbsOresfs8NzGS/Duuu02hBX5w+H7jhs5PO58KOOPq/1bzTA2LJ3//bQm5v
         ux5mfvi6Sql+3wWyMReNwvoZ4ML834IIAONcUTsMfFnjnKIztb0OWfLPrs/gQsXuXpQ2
         G2E9Vd5Yb/y2KhdQD9VPzXWSwX5hmGs6Oox2F249lg7f71jmZDhpb+muAFQhaj2ySsgK
         TMPfYN4jl/+lpwPXyYaXSkQWtTCwu20xxNq09Ta5iCseA78aI3rC/tvqI7Y3Rhjt4mnb
         TJeg==
X-Forwarded-Encrypted: i=1; AJvYcCUEH9JZC7WKrJh4xwyt5kVFEKDiMYk/7QtzHZVXGCZcIJQPDQ2eEai9b9OUf/tT/14uc8nTacAMnJ0LpSyq@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1Ib8clRzBCqJwvxsqpm2Y6v2RY9Ep+B7eGQccTDAPqSuW+oI
	QjD4JaFgBjkfLxNe/sfZ7VNRMCUQCVtCE429IFsq5ZpvL4GN6YTL/t1tL8OOjX7y+bWRAFz3qip
	CnJHicsjz+uDOqddwLgGrwX9rqzTJonI2TmihGtw9RgsAVZQanbDdxU+BVJM=
X-Google-Smtp-Source: AGHT+IElJnP+xwf4y87F+g1APsfo9Vm5XUE2Vz3REcJdKkSBdJEVRIWSK9+TuDGDMpgS40AebeY0wbBGqfnJ7zPVZ46RH2I7QTk+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:b5cc:0:b0:65c:f22f:30a8 with SMTP id
 006d021491bc7-65f4826c517mr2537368eaf.20.1767797822402; Wed, 07 Jan 2026
 06:57:02 -0800 (PST)
Date: Wed, 07 Jan 2026 06:57:02 -0800
In-Reply-To: <00000000000051d14405fadad8cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e743e.050a0220.1c677c.036a.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: user-memory-access Write in __destroy_inode
From: syzbot <syzbot+dcc068159182a4c31ca3@syzkaller.appspotmail.com>
To: brauner@kernel.org, dmantipov@yandex.ru, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, mjguzik@gmail.com, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit dca3aa666fbd71118905d88bb1c353881002b647
Author: Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun Nov 9 12:19:31 2025 +0000

    fs: move inode fields used during fast path lookup closer together

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1480019a580000
start commit:   6146a0f1dfae Linux 6.18-rc4
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=dcc068159182a4c31ca3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ef4532580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179c1e14580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: move inode fields used during fast path lookup closer together

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

