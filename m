Return-Path: <linux-fsdevel+bounces-10485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F7B84B854
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9AA1C237BB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F3C132C25;
	Tue,  6 Feb 2024 14:49:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EFD12FF7C
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Feb 2024 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230948; cv=none; b=kdV4JGSRRg9jmzPSeKnp/mPT/AU8HuonOylxEQgdhcjnGK064eSz7AHUNS2iVikN1osX93LEnfv0bc9yp7n+9DvRL8n++67y15MJQtx0nIqGeKRF2WMpsddaohQeH8yMdT0Dh31bPfFw8XTFS/OtaODUSN3QZzwcZgAmO3LlkYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230948; c=relaxed/simple;
	bh=ZYhM25AzuOO8uiA+4AJts7dxWvnoP0sziHlbTBDdgdU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T9tzUqnlCZiBvT1KW6mvvRNWxIyLJ+YjmwW6NldAt7ssJbZzwGeXRQZWNtMdPQHoPSi1Tsr2nb3vdHB+15HgedKNY19HzLZZdjn2JEIwdrc5TX1VvbcHb1OsKcdCeMVjU7RZd3n2q9Br/dcfUIb3QuG3hApw6hHNLWejU8QqLP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bff2d672a5so389227039f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Feb 2024 06:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230946; x=1707835746;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSrsdZ/RuKV0gEG27LOO5dIr8YmZtFDZ3FYa41rVAQo=;
        b=SJIaiAIuYLRrEqHufZUFZLFh7BR0itpK81JrrB8gad3wk8fNtYGT8BJ8Wf+fzISy3/
         XdcKkik0Q6X3vgJ5DUnIsONVcVdjqvT2VjlamoUHr1Ip5KLmRt0M2YsFGurv3dBxPzok
         EwnfGeS6Ozh7LnOtRWeHmPTjNDeTuo3grbaEAcmRdhEQtX1yF6yogb/1gk+4tRwOBaLm
         Abf86EgkfF9RFJxaf36N62AzLN+eVb8gKqFKMl/BSVQlNLtw1x7JjVi1Eq+DBDQqnBWm
         u6KfkyC7syRqt4UO6fEQx3V0gSVpITBujzQxvXU2RjSjC84mw1LvoAonz8VqQkdcsvkT
         J9Og==
X-Gm-Message-State: AOJu0YynqCnwRz3tnAOuZHL7zRYz3570/YLJhvv2I0A1dnIG+6YGPo1u
	dFkGXXLxUd6avmQpQrTuVMTqVVHwU7OP25FT7WtbfePJ4g9FcRQyfQrHRa51gBslOj2z6v928YH
	zZbUMgKkA4VBY12Dr0BFoZe+Tiy8wKVt27dbl/w1o7TGJxq2/xIGdov4=
X-Google-Smtp-Source: AGHT+IGyJ27bMyWH8/GynoFXTjuNU5g+uu1OXbn98nBQ0bYYkpj0BC/KPVZdYE7KwK+zDcXtX/Ot0QVWkk9m9WuMvI7pjKLzBruq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154d:b0:363:a059:670b with SMTP id
 j13-20020a056e02154d00b00363a059670bmr186965ilu.4.1707230945919; Tue, 06 Feb
 2024 06:49:05 -0800 (PST)
Date: Tue, 06 Feb 2024 06:49:05 -0800
In-Reply-To: <000000000000332a2505e981f474@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014c9ca0610b7aec6@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in dtSearch
From: syzbot <syzbot+9924e2a08d9ba0fd4ce2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, dan.carpenter@linaro.org, 
	dave.kleikamp@oracle.com, ghandatmanas@gmail.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
	lkp@intel.com, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	oe-kbuild@lists.linux.dev, shaggy@kernel.org, syzkaller-bugs@googlegroups.com, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13767e8fe80000
start commit:   bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=9924e2a08d9ba0fd4ce2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152bfc22e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1608f4a2e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

