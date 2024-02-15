Return-Path: <linux-fsdevel+bounces-11640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F513855A0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 06:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E6C1C22470
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 05:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C048FB667;
	Thu, 15 Feb 2024 05:14:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2079F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707974047; cv=none; b=gIX/9XuHGasHcr8thPQ3HQPomtGCaJIYQ9IRukwpa8K9KLETFecisdxvmu1WdLa+rr7dL16tMbDZjfhSQPDnG/vvj2sFHYkQRPn/QJjQQh2ED/vb0P9MC1Mzwe1jsm8hqiJ871FCm8mUYgx8IIYX+to1Utx4FQs8cpkkcZ6gg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707974047; c=relaxed/simple;
	bh=u2zTvaigkuJAkh2Bm7RwzFPDKiy8E7ZaQMlfwujq1to=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OGIbVeUNCuLG5AIEK8gRCA6V5J7CuR20tprZppXQ2lTa+sTflvLDOEcrgkK5Vg3qvk+Q8qt1ul2n3ki9n859FFSH1ajtxqkotbsaLN5AU5c3mehxC2tvr0DcPxBbQgXG4ch+weWF2D/ycmBHPlBTnTuKwqA7l6mkImxY9+w3gIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363cef35a5eso3505955ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 21:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707974045; x=1708578845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=833iic8uS6oQb0u2s6ULb+vs6qVpUUqEMT9wxJUBre0=;
        b=NEse2YVddkC0mUO59jBR3PZ+xP0p9fJhvWMaeAk/cMbotc0EYHPWvGtqYzjK89hpX0
         vmJb8NySM+mUUNRW2HyXQNFxmL0ju46boyTPlMKTTkvLC2VeBZ9nvqqxar1LeJGCMGTz
         FJaEaFr764orpEbkrgMZaxFDdTOWAtzF9tKlgLDdUHBlNmtvD4l7INTEKlUSha3SKK7D
         e5Odu93Zli/t0NeaFFxk4Ml8KKZ9p+/6cdPupRMxbI/PVRpFI+z5OBFthDgE4RkpJxdj
         IlQ5IsyT4KbcgQRV8RagCHIBNtQT81AYnuv0cDWeCceAT0EDGqWVcrYVDd1zphmvIQCS
         gybQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjNdH8u9J3sW1NTuVpSLaiiZtkeV1z6g14NrJ8pV9OzQt4zSlnOGQoJPR/6bkQNZaQpim+V/eTmI5gyLzWJYQ1ULrB4wbvU3+wMFuqZA==
X-Gm-Message-State: AOJu0YxMhVZeGaTkTzMWYhddDEWlLiOrh4N8inZ1hepyXDzA+J+Dsw7D
	4y7ItTE/XN/dS7w4NhmQFGv8FwiwU0H68wOcCUXouSWoODtYrwKVj99e48r3Zfd9xVx3YBZCWmY
	i76Ila5BkSwFC9oZpQK11mhLsUpDicV0naxdzyWRUedtnOaoax16KaeI=
X-Google-Smtp-Source: AGHT+IGwo2Km0QbPqs+xCV/X1YBQCNiq02WGU+O3hroB+S6cLCUqdysdrb1ky+UxiUyUXtIsyMc0dCia1ge+gPgv8pa+molAyFdf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220b:b0:363:bc70:f1b1 with SMTP id
 j11-20020a056e02220b00b00363bc70f1b1mr55404ilf.2.1707974045245; Wed, 14 Feb
 2024 21:14:05 -0800 (PST)
Date: Wed, 14 Feb 2024 21:14:05 -0800
In-Reply-To: <000000000000caa956060ddf5db1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040a8cd061164b23a@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in __fget_files (2)
From: syzbot <syzbot+63cebbb27f598a7f901b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chouhan.shreyansh630@gmail.com, 
	eadavis@qq.com, jack@suse.cz, jeffm@suse.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, 
	rkovhaev@gmail.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fbb3dc180000
start commit:   f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83
dashboard link: https://syzkaller.appspot.com/bug?extid=63cebbb27f598a7f901b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1230c7e9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133d189ae80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

