Return-Path: <linux-fsdevel+bounces-8801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE183B230
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 20:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ED291C2116B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 19:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EB7132C28;
	Wed, 24 Jan 2024 19:21:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5E131E27
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124067; cv=none; b=C0JGZ2qL28gZbnzKvfjaj8u7i6evMfy60ROrxYkM7omuNpZwunslf4GjzmF+qEy1ypYQARv0OnSDnIvdVth2wbO/WmLDu2G/WTKWWS4p3Osh8BL4t7S7qea/sanlkdxLrumBppj821H4W4juzoxI1Vaw77i2JVFXNbLoFwUbWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124067; c=relaxed/simple;
	bh=c6WFIf+JHlsGEfzQEZQLoJIP7VaM+Bmu6MrXa+u4PA4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XV4TBsmlYQ4ylAf/Zq+x4AB0ia7ydFdR3dxKeLin/KXBhWz2VCtstb5CW0FDaf1BQ4q3naUZHVsnC5t/1PrKBjv67AkKbZHzrU4mgDMuAbPfyk7lJ9XBjLa4/pyvoeohVWptLXrVc5M7u36JJtlclhJvxsetNCDbKnGgLZkynoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf356bdc2fso617850839f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jan 2024 11:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706124065; x=1706728865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7uAoJlJc/r/AdH+EKRBB9ocEe4x/wXE6PggxylocZs=;
        b=k8X+MHUP3h7Gqm63isMC3WbUW7aLByhHAf4sNtOp2W4dKsEbkFGz2ALt1ZVycr5ggC
         uU2icMewkUKbpt9U9K5Z2fORvzE4to/yr+/XJ9tb9HBY009LxoO3tubYlXf55n+YJY2T
         kV8psv7jnXBkybZopYp+wo+f4xTl8omO6P5bOlguhPYzCOms0MskhvG+BSyGaIj9Ny5E
         pgT6wLXRTNHcfCNpbg2qvtKOqzsI0qbB2teblOOFk2s/zNDDytjBkxW/AcOYvUTVeWJz
         7zErceliyka9ZgCxmVV5aS8nZt/XwXQY8Rz46/nyrUNj+8VjEr3DsrLtfY6RxReI5oAi
         X1hA==
X-Gm-Message-State: AOJu0YwkQ+lAn9ptWTPU5UtmKVJs4r0sILT0XASxJbnaCMKym0IeOI0j
	/MfocdTZEgp/qn6+4gOTpxqbEgrz0GcSvxS+fHLddEK+7H9aI878BvG8vbmZYg0r0hd4kon8iID
	3yy+unzm9HMTom0BB9gb/iM3Ia4Sh3mO/juQ2SQ48B5aTiRuno8LKKu0=
X-Google-Smtp-Source: AGHT+IE0i10pqpyY8PAMZM/n2o6EisAhLNFNU3MnVtH68x+1q+ebTb1VrFJvegV2R7EiIEC4oR8hRVnJ+M70p6wabP5Bx+g/3ZW9
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bcf:b0:35f:9ada:73a8 with SMTP id
 x15-20020a056e021bcf00b0035f9ada73a8mr269347ilv.2.1706124065104; Wed, 24 Jan
 2024 11:21:05 -0800 (PST)
Date: Wed, 24 Jan 2024 11:21:05 -0800
In-Reply-To: <00000000000099887f05fdfc6e10@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7ed43060fb5f676@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_split_extent_at (2)
From: syzbot <syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	yebin10@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102ded8be80000
start commit:   25041a4c02c7 Merge tag 'net-6.4-rc6' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=0f4d9f68fb6632330c6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b3bc8d280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

