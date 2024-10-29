Return-Path: <linux-fsdevel+bounces-33103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9917A9B43EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 09:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 078B0B21531
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F76C1DF75D;
	Tue, 29 Oct 2024 08:15:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C22036EF
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730189706; cv=none; b=s+ZrzM6rq+TbUGr5XAeydKcrE6rlN9/ORZDTzgUxkvDIu6egDomDsm9bHoqelTx09Cw9CBCp/KyKn7nV0ZTwQyQ3GApp/J60F2/czZh9Cv5gIizPxBmf94GZK9kVf3dsIsIWrPgpe9vyBKjyjrn1nNpy+xLafMO8kTIlT98PZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730189706; c=relaxed/simple;
	bh=jVZI0IwpcekhbnfOrIbgBgWJzqVFKuVUtoIm9N+jkVc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=O6TtV6pRMpRAy8GVkHVYtzX1DOu4PAvrcwMvgcItFHbTcEu39Eab3442sZH8hEEaerf4IJMHYTadDLEGrOvpC4bjPP4iE7f/s2bpvD1T0DTP+Cg/BMi80ASrkPcLNivk5CKBNuY5zjvTY1yKrR0rbPbKX9DOV39F4n6VVAlVYQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83aac7e7fd7so524035239f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 01:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730189703; x=1730794503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BTRHXytTFWgdZnYL2thO68nzA3wtruqd8M7jFd6tO8=;
        b=uSCBBNZjS0Ko+CPcfz+4dxkraHJaI5Nupu3oOLxsVqLZi8QwaQoeehjT57XU2rNxpJ
         Vps6A8axPEeg+Mxah9ioMkQqsD3diTRGQizj6SewFeRF6PClH7VdDBBxZAhu/C0eZySm
         wGKbZDGEczfxEHy4fBVfgjfoviP7Njrrla6ckY7XjXykkLx3PxQNkBMzZE4SuFiafqb0
         Z4U8v7kKaPZGbjUYR3s6fXIAko2MDnysll/YDvtRoJZGIC7HnnTk/d/pOedhlqFAayhj
         wDIQQHFP7FPOrC22Ho8i8doHIV9mWUcyT2TSlBc5C0+7/6xfUM5nrkZv3Op2wfGrp4BO
         ZJ3A==
X-Forwarded-Encrypted: i=1; AJvYcCXIVgjssdCT978XDYJwCEwDNAEDgfo5NYfrgxQCe0SPSYCFf8UitaSZtZIzlvyhtdtiEvIUPzNT6zRQGeDj@vger.kernel.org
X-Gm-Message-State: AOJu0YyDgAE1gc7YI/OhzLdCp5ANI3eiFBfzHy4Ky5QUvaa06RuDjaOz
	W86iuNc61YVTRsI/CNpjkmIPOHuuIkRbfk7LN9Fyw4QxoH/fjdafa7X52/FdDynsxmQi71ffxgG
	jpewsu0farJeJ/LYSA8GdXEWUqLvWwb6b/qE5AZyqMWN/h5QpE+uSBVc=
X-Google-Smtp-Source: AGHT+IG8VvCIkrmNvSQH+kmC4iRLaOd+tCtOspcugELt4BK972V9xSrn5cpBxJ3eE49Xr5ZBxahDDGO4yGtK5fLRSCzt9o8VN2t+
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b49:b0:3a0:b631:76d4 with SMTP id
 e9e14a558f8ab-3a4ed2663ecmr114857565ab.1.1730189703613; Tue, 29 Oct 2024
 01:15:03 -0700 (PDT)
Date: Tue, 29 Oct 2024 01:15:03 -0700
In-Reply-To: <66ed861a.050a0220.2abe4d.0015.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67209987.050a0220.4735a.0258.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_advance
From: syzbot <syzbot+7c48153a9d788824044b@syzkaller.appspotmail.com>
To: aha310510@gmail.com, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netfs@lists.linux.dev, 
	oliver.sang@intel.com, rostedt@goodmis.org, stfrench@microsoft.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit df9b455633aee0bad3e5c3dc9fc1c860b13c96d2
Author: David Howells <dhowells@redhat.com>
Date:   Thu Sep 26 13:58:30 2024 +0000

    netfs: Fix write oops in generic/346 (9p) and generic/074 (cifs)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12c2eca7980000
start commit:   a430d95c5efa Merge tag 'lsm-pr-20240911' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d85e1e571a820894
dashboard link: https://syzkaller.appspot.com/bug?extid=7c48153a9d788824044b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1511a607980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c7d69f980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: netfs: Fix write oops in generic/346 (9p) and generic/074 (cifs)

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

