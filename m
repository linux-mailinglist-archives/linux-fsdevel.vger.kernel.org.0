Return-Path: <linux-fsdevel+bounces-37092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 695CB9ED738
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 21:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECC0188A1D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FC720B810;
	Wed, 11 Dec 2024 20:28:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5C1FF1DC
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 20:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733948884; cv=none; b=kbLbdzB+yAjKI7x59NCAP//JTBPLxYbc1/w7WZJkBMKTwNYnolho0YXi5OYD6vIEGCf0efFX4Nz9w+WSRD+gccmTXEDFXFkSS+5iyrctVKugT7wZ5uaZ6rcDmF0CcdqOyjibwasPDOn5Ol2eHOLVJEoKokzPn4Los7kCyYgNDMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733948884; c=relaxed/simple;
	bh=BxTkdHAwDUKkT0yu7rQNK7RCeSpDgxVH7CyMEcU05oE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rRtF0U1nLyvkpQVmB4GMtlAbNbVL1HqvhiPfPVObgzY/wN9gQ3VqqzyRko24QoP6ZQMU0oYZWxx0/3yyw1jt9X2QqN7yzsBW0dSluT++mKcOkq/4mFIXyn4spK415YMWtTQNeT0RWsk7IJVRA2Csspyl5v12mb1L4ryh6v71adQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a814c7d58eso57330095ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 12:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733948883; x=1734553683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TWvuUMY0G+wmikjDT3RK+2qc8QdMPprFL6z15qVZK/A=;
        b=CLRAhrljbNohEgI6U3nbkzRD3J4sQCazDuR8D99F0hS3ZvJeuhYyHB/+MIUAfsU9em
         unlKkoJjqtWDNZqshDnh2D0QMpg4GHZfEudf6/6LuxrAM98XEXqxzhc4dM49KtXnhVNj
         Tv9hqZAHGRLeq5b+FUvrIdBBaNoa6T3JLPwBoyg5KuAOSLuR7v6L6b7dY+sqik2dQaOf
         oLa5giOuEly1kpC7SCtjU9H69c7poPxAHGt4vcxipp2UJXYU37UVGJUhdSXfHRACBLL6
         w6dyZWVfjsR0lSCMcX+H2O+/DF6kAXrUGrL7yUkuSuNZIr9FOgwCPHZoS8fkYi1tG0pl
         2u/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJPvzNw8ZQ4q+61jFfJBa1/UYSXEUeKh+O/65gR83QcMA0DUwZnGuYLfS8JfDMB4DLWhY+bbEXLOrKcL16@vger.kernel.org
X-Gm-Message-State: AOJu0YxzBFYLDX+9eEEagExOTqFxNFmKfkbN3FAbnjr6qiL+7Te0UaPQ
	OLOJ1nmMjR0mY8c93AFkWmymmnV4cSI++j0zx6wdwSmyVMduAi4ZznrydqhUHiQO+wrlSewN+wV
	mlnnT1fO+BLVSDu4bd3WyJyfTRg8HDpWEX1DG5kdL+2ThE4US0T2EKrA=
X-Google-Smtp-Source: AGHT+IFU4/JJhgeFmeUgOTOiFlptRuRRWPCJkZ0E7Hx/P2REuhArQvWWkxw4t8dMVmrVYchAgd8/ib9uHjlZQsLpg9MXrqKFdQ0W
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1609:b0:3a7:c3aa:a82b with SMTP id
 e9e14a558f8ab-3ac49fdfa0emr11002455ab.1.1733948882793; Wed, 11 Dec 2024
 12:28:02 -0800 (PST)
Date: Wed, 11 Dec 2024 12:28:02 -0800
In-Reply-To: <20241211200240.103853-1-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759f5d2.050a0220.17f54a.0045.GAE@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in __alloc_frozen_pages_noprof
From: syzbot <syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@gmail.com, ericvh@kernel.org, 
	leocstone@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	v9fs-developer@lists.sourceforge.net, v9fs@lists.linux.dev, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/gpu/drm/i915/gt/intel_rc6.c:139:19: error: static assertion expression is not an integral constant expression
drivers/gpu/drm/i915/gt/intel_rc6.c:140:12: error: static assertion expression is not an integral constant expression
fs/bcachefs/str_hash.c:164:2: error: expected expression
fs/bcachefs/str_hash.c:165:30: error: use of undeclared identifier 'inode'
fs/bcachefs/str_hash.c:169:55: error: use of undeclared identifier 'inode'
fs/bcachefs/str_hash.c:171:40: error: use of undeclared identifier 'inode'


Tested on:

commit:         91e71d60 Add linux-next specific files for 20241211
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=76f158395f6f15fd
dashboard link: https://syzkaller.appspot.com/bug?extid=03fb58296859d8dbab4d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12987544580000


