Return-Path: <linux-fsdevel+bounces-25609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCB194E3BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 00:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D13A2821DB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Aug 2024 22:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95F416132B;
	Sun, 11 Aug 2024 22:43:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C92C1A5
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2024 22:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416184; cv=none; b=hTN4XJdZaH+0OvIVrmm9swMR9Pva137d+vvkZ3SX2WPWe3FKzLAyXyydcrYYPQ01CL7qgZhyk+lLfNZA+2arqVcrAJUzI11BEs7Jem0k69lFtkvhP65S4uNio8h4XtV8tznYgZrC4VIXRsZNgXDh/wYY+kP8vIJdTMs7B+ZkAz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416184; c=relaxed/simple;
	bh=L4Lv+V3TAvpIqLu3MSz4+YFRq/dbvUKkqeQBE+ixKpw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uRQe39dxrJIBpEBACkFU8Gm4BjTejfsP4IWcggor0riQ4DaK6koWQtJ/UkEq5WMwdEPuJR8IQqpjcKhaFpv8ULz9CrHvahjkKLu+wnx5aYYLkpn/aa9JdCKLJbt+66XXIar0YOwCJxKxuONSXnHvjrQPW8wbyGFzT3gBaYKzVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3cd1813aso48427615ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Aug 2024 15:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416182; x=1724020982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVqFzBryEujNvLyT47tPqWQBFIh9FtkAq+KHfk8fPj4=;
        b=M43dFnJlHWkOTv7l7Ow8HRQQSDyYoPf3FQpdfyemhD/56sW/gxgix6KtmjR7LM+67x
         RG6+qXTT5kW0HpDxGx0l9x5P4mCKaEEdYOCK78Fekcx39ZVp9RW4Y9LkrvPJxFfd582n
         g626xKVFb2iRm22n2pzbxOJSaJLbVvS1kvjH0ANZeSoDnyTAujpD75lVQkEcwYLuMCnO
         08ksAdlSb0W5a3xKEsPG3bSemMWBoB2/cY8TJ+kA5x65jrd1r8pbVu6nmcoX2vncWsYv
         NJxQRX4V7N2tbGXHCEmm3K1kaIwcf7hgnxBzaok+RHgLhWZ2hYAj9WcyLB43lTWjZgtL
         v+tA==
X-Forwarded-Encrypted: i=1; AJvYcCWS/Qnt93TscLvlptBiyTUZguZIEY7KCCslzrPRB5T2QAhgD75Ibt0JF+KJTGDsrDea+Li41DWeHG6rwM2vGdzjy4q6OzNqyYm6CL6QAg==
X-Gm-Message-State: AOJu0YyoDIXpGDe/cX8R7BSw1vIteEwbMfg99z7zm836W0+g+dDzsBhJ
	CJmdvB4CX2EWDUHSRkSSXElb7PDkBo92iSX7XNMwV4FqxYwqpou8zaHKxFu0w3yJvMKs37wJlSq
	l/9c0BTMMVYrRceylid6wL0FvoMd6nGqlJFF6Q4UTrioyCMWrvOmo3zc=
X-Google-Smtp-Source: AGHT+IF7jkF4oBqJtIkn6QuGeZP/SaW+o6WVuB+UpJ1Q7K+E62/xT80ADTCE4nj7LwY0M348sXjLlvffGGJyVNNQbX8hhCmM1l+c
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:376:1fae:4604 with SMTP id
 e9e14a558f8ab-39b8709bc57mr6384475ab.4.1723416182349; Sun, 11 Aug 2024
 15:43:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 15:43:02 -0700
In-Reply-To: <0000000000002fd2de0618de2e65@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005971a8061f70191d@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	eadavis@qq.com, ericvh@kernel.org, jack@suse.cz, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lizhi.xu@windriver.com, 
	lucho@ionkov.net, marc.dionne@auristor.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2df86547b23dabcd02ab000a24ed7813606c269f
Author: David Howells <dhowells@redhat.com>
Date:   Fri Mar 8 12:36:05 2024 +0000

    netfs: Cut over to using new writeback code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148b014b980000
start commit:   5189dafa4cf9 Merge tag 'nfsd-6.11-1' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168b014b980000
console output: https://syzkaller.appspot.com/x/log.txt?x=128b014b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16828c5d980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103c7805980000

Reported-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com
Fixes: 2df86547b23d ("netfs: Cut over to using new writeback code")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

