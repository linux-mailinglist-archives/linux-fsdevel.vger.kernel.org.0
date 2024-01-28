Return-Path: <linux-fsdevel+bounces-9233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0A783F49F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 09:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6021C2113E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 08:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F5FDF55;
	Sun, 28 Jan 2024 08:33:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B645DDA5
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706430788; cv=none; b=EXbvBWa81wO5pai9xsa5J1L4d9nNJzSixuMVR38zKavE/BU+BCyS9jkr4adeTU1Ppks0JSJ+lZcNYdR6kakdquusSg+ukEpDGJCSqr6qGLnFjoe7vRRfZcV832udU6/qOZhTNwcyoh/qDa/zZHSq1gKoOupWD9NG5EC4dPO/Bzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706430788; c=relaxed/simple;
	bh=hGMR4U5K86JxyB4kr5e3ZACsI7Q2evvli8q8yzSoiSw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HvD4tH4VyJlZZG3ai6IBQ22/yNx+DvJoqaH2XrzNrY89GWwRjWWGiwyvoUjGmwbwSEHKl93Y6NRGomFA6jjafgex6P+5rZvEBuTCwdoUkPQQRvg3VpZ+JXbORKRlyj/3VyYxJ9VJwaqNGaJrxh58oTXpboqrJWWkrBgsj01nYqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf4698825eso134460639f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 00:33:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706430786; x=1707035586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNN5KLkPHS0YIYwzI5Jykoe2YGdKNWga1jxyVuOp7+s=;
        b=M8o9zC1BSzfIAWnKhdeCXMgJk/2FahP97TsetKq6HyB5Gb7nDUU/JrhqpuWy2vexEL
         2u3UyFnnResi3SleudqQhO6YBfQngYKua/fsOg3ez2YY1bMaT2CRuR8I0jphzQNQqIMp
         D39h1GCQlLI3vfWyvvBvK3CQl6WEzhojYZKP7WOIO/JLODIL6axtnXUrrXfsPvX7OnL+
         f/olOEouTIa8x5Yvk3O0ryx2T90WW/l6Uvf4JyEjx/K9Tx4jNTEholT+FPhzb1mETxzh
         4viaYJHdwulcRBJ+w40Qf5O17UuDKjwppRDGkC7QOAyugmowDw8hvP6IueC2wwtQwBbu
         t2Cg==
X-Gm-Message-State: AOJu0Ywt3oi9oF+6AhMXd3vti1yNqqo+OhfnxEOYey/qTx1BTEwLoRWx
	P9rUsvrV7oCezQseVfCamPsBDBl9O3p5V6akHWSg5R6yD+lCcSYh5LoKAjATHxX7o5N/Lg9orwD
	IDYQY+vX0i+73kbzeyVR89P2NB0hniJk6nVH3+Wy+H9A037kDhLTQiZg=
X-Google-Smtp-Source: AGHT+IE5JhByvi0HswZNtB6u5bhB0ZD545GFOO2qLdKbRVHFiQgOaj511OOcYmw4/xBkKyELGhEbtSg6NtbI2umtY2tG+8LtTdM6
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:361:9a73:5a8f with SMTP id
 g15-20020a056e021a2f00b003619a735a8fmr398208ile.5.1706430784250; Sun, 28 Jan
 2024 00:33:04 -0800 (PST)
Date: Sun, 28 Jan 2024 00:33:04 -0800
In-Reply-To: <0000000000007584ba05f80047bb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baabe1060ffd60b0@google.com>
Subject: Re: [syzbot] [reiserfs?] KASAN: use-after-free Read in reiserfs_get_unused_objectid
From: syzbot <syzbot+04e8b36eaa27ecf7f840@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116501efe80000
start commit:   1e760fa3596e Merge tag 'gfs2-v6.3-rc3-fix' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=acdb62bf488a8fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=04e8b36eaa27ecf7f840
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d5c261c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155eba51c80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

