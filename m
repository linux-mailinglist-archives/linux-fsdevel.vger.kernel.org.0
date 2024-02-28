Return-Path: <linux-fsdevel+bounces-13045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B5286A83D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 07:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361691F229EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 06:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F421A22098;
	Wed, 28 Feb 2024 06:09:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D5219E4
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709100546; cv=none; b=PjZpqdXg8bfGKhOeZI4ZctCLq3vjqmueI0h8PF+/uBO5wgBxK3VbnK8506UxG8xmyFkUvYI42yfDvnZkpgeLBmKEL9ds3BGWq53BIKx29jJRuS+Po85hdwg8qVqOV/t+werqkA10qFFnF7qeFcVjXhLUX9nXJLV60un02v48Pxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709100546; c=relaxed/simple;
	bh=abFXQnDiYBj25XYqxfq/Rfluiqv8Lo1I1Hyuf+oVNSk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N+azJsxWpI8ZG+exX0A2MtdfH/7gq5/R1sQ/e6RbkBo6tkOLsZwJuYI1EAfsB4rlYqAQBAMWEEQ+KxI4Z5g7aE+z0LUgtsgylJ41UEz/XUdp3TRMyBGZr1MgFSKFTX/rlq0pyEmT9Bk7M3Coc8CZsz1ho/62EonhFpXPeFaX8bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7a733ce70so356673739f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 22:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709100544; x=1709705344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvbhFmYG3Hl0zJaQNnUCZb9RV12RO5xJllqs34cJFVU=;
        b=cAFEVyNVKw2DtVW4+V0/o9eqfFhkzRh7pPrRLynUHPyte+vZhsKjxn7xRU4oFa08jp
         ZuLMN+JgrzWV/CCeEhWg0MwLiCfz6Ney/DC/nUrysppp6XDHpXhFZhnrEnallr2czEVn
         Bw0HOKkoOndQex7wAuZkSu+TAj9kLTnX/m/254quIBz8XRrFRv1mRCFe9XwxETwaXcjS
         qCU3+8bO3Il5w+yIItwvvluVL1WR8TX+A018NBjRqyMQeTfJvHt2F/d6WbwH90A334h8
         WHt7QCe+ytD5LD2aKTCBKWIxgloCMIVyCYYvhfsx4DB0UheFkQzONGAvztSE6T4yCoO6
         zXRA==
X-Forwarded-Encrypted: i=1; AJvYcCWsTR6jTvMtAxEJ1dyibs/RZZFJgIxpP7JybdCd+qyayhlpJBX5NtWNXjgDSlWJk8tSXCsZ1xrAI9LeVqMrY0+F8xKSXqSlGAATBuLnEQ==
X-Gm-Message-State: AOJu0Yz3i0Fn3434VCUVGCBk4pGypYCRSUpeSM0IImACNqVxPmrBJ+qz
	S7FlUb7D8UdRWALXzjqV3QWDSaQ6TrwDN1hDglxQ7DtgpkM68M3EXhZb/vGho8Dwpkf2LzhMKCJ
	q5j9UbE/aUoDAXh10Pg4qCvSnAJHNXWnHpgxMfweHLgZyjQ4aqM8C3iQ=
X-Google-Smtp-Source: AGHT+IHA2oKF9Yzw50FyKsGXiUIyRwFWO8Tky0w0Ujw64VYWlHYtYe29AY9cNSZ8GLIVv72i6dQ5C8t0KPELS5B/i1ZUsMrjq0Xq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:411e:b0:474:7c04:29bf with SMTP id
 ay30-20020a056638411e00b004747c0429bfmr547122jab.3.1709100544403; Tue, 27 Feb
 2024 22:09:04 -0800 (PST)
Date: Tue, 27 Feb 2024 22:09:04 -0800
In-Reply-To: <0000000000004e88ee0601947922@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5af3006126afaeb@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in reiserfs_rename
From: syzbot <syzbot+d843d85655e23f0f643b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164b3816180000
start commit:   bee0e7762ad2 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b45dfd882e46ec91
dashboard link: https://syzkaller.appspot.com/bug?extid=d843d85655e23f0f643b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117e7af2e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109af986e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

