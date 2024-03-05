Return-Path: <linux-fsdevel+bounces-13589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4508719E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 10:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDCCB22F12
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 09:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F08537E9;
	Tue,  5 Mar 2024 09:48:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B45339E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632086; cv=none; b=rTvbCoOk8Yt5rONlWFkF5oBbvWuSoT4AfHV1smr2jZ1FOw57XQmz614rmMFb1gMAp1zLW316vfmw6woMycrO6h7XI2FuLFSfHtqQJCavtWtiRVuI16+Hbc7XC8HocWwnaXNlSAbQUuEYG29ddfL2YAMgcH4HVmTVN6ARBxRH2xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632086; c=relaxed/simple;
	bh=FUV2UfMDI7InnPdcCSNJGtUvjpOsTPaChu2eym3FVR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZaZlbP6Bb1Gg8HdfscsJgVnGi8iVsde6vS38/etLNJdsjG85bThA8zHySxGtRinCfGGirLhtVlhnKC7kxY/mDcCjhRbHFKW/Zw9hbujt0Cu6waZNpUSEmfzZQIrUSAPK5+mFMU55+VoKoirZEdQwzWa+om8Ol/huJknozJcQVMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso486664339f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 01:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632083; x=1710236883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/PW67TWH8skqmU8vKJwkoq7t3qUI1ZITrOnwecy99Q=;
        b=oQJtuKg/T+59+S20ymF2myDEmxKsil3hnWa2Kl/z9NF7sTOeqOXt6Vct4KShFhKMip
         doq1GkwGANbG0kplB0bHzclAb/shpXeDwpRhqmgNtDtGSNyHm8WGvfhD6rethWPGHJ5i
         M/6yOOwUdZAUukfVXKa490MZEwL6do361RYY6dN4YXcMrro9L0mLTDI1d4yo0j5KW0yP
         QS0iPdmbHBxbIpD8HeEJknk4JzVi4kUklkKXpll77vhTFg2otuNCWxikzda28h3guCuE
         ILVEtn+9HWXEo8uDXvTKhDzd4JXGM1MNKr6rVMMbCqsAKG/A/uBhnId3Z+0YdGDFizmy
         TZgA==
X-Forwarded-Encrypted: i=1; AJvYcCU2gBjWn29H6A66fCepK40xFb1HIeFjzboFQu1Wjn0Aw1kQLrPGpTmf1Dw4uoRhAVrZJ5ibzv/uK0BwguIQUkFJSGdfpmfx7FZAHcRDoQ==
X-Gm-Message-State: AOJu0YyPMlHdXFy53O5pOwnxNMEBggUHnEXUZSNpdrKiFVnG9ZRwvYx2
	Nr/JM5rpb27zESZtBad18D/rIYhkHFfAE8qoG6MzHL4NaOfhubpHWRK2wP+cYqfG/y0iQKYoWCZ
	ldjbo9Siv2oKa7/hMh5tIaUvG8MZyGiHzZN4oApQvxWBTP8X1pB423GU=
X-Google-Smtp-Source: AGHT+IG6l3HNMZupoKsS/1gWkPsOulXpjgLde5BhCiJPeE6FXHMXeTqCfcGSOQh3Xyp9sknk0aj3dTMHR9Y5+rBXctugU6xVy/Vs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1611:b0:474:edd2:24d5 with SMTP id
 x17-20020a056638161100b00474edd224d5mr360168jas.4.1709632083746; Tue, 05 Mar
 2024 01:48:03 -0800 (PST)
Date: Tue, 05 Mar 2024 01:48:03 -0800
In-Reply-To: <000000000000c925dc0604f9e2ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c6e0a0612e6bd58@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_withdraw
From: syzbot <syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119f927a180000
start commit:   6465e260f487 Linux 6.6-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=577d06779fa95206ba66
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dbcdc1680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a367b6680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

