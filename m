Return-Path: <linux-fsdevel+bounces-11737-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD0856B03
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF62F1F26748
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2D01369A6;
	Thu, 15 Feb 2024 17:30:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C8136995
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018204; cv=none; b=lgNu1G3OezoW+CUXmzT1hYkMJAJfRpYOnmsX5xwjJN6gYfFOQOBRe7igl2yvb4EuCHSAL5f47dBqCnsniF+DH/XfxRGJ/8YFAe/GdqS+XAXAcuoXpgb2hwCnO/p0rtnDz35hdpq7eivAB38BfDUXRQzFlYNDWtQYlBbOnqRCKAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018204; c=relaxed/simple;
	bh=VthmcxhVEuqz9eJ5clxXTesoB8WduMoco1RaCTXD9Qk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ILYUnX95BZtE+gYLrFRzuO0db0DVDaRzSppQ7qXWczy00hU5Zx8Y2jHg1w0iyru8OxLiUk8Rw2mtnCrHocJXfCNu4grOLvjAHKe6qxL5Wk8iPv6iSLoXekPZtJpP1TstJFIYvSVHJpOdmb1onVKscbzmxHVkzRdSrU3sKxjSCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bc2b7bef65so95066639f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 09:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018202; x=1708623002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mas1+oMkdzW0fSqjxmSiwbESID1pMxANi5qAJUaYfqg=;
        b=lWC8fhcZj+Vh7c0n38Cb7EXnA4TBj/LJQAAp512eAonBN+XvRVH7jHukrF0PNdP2d0
         jWBTMI0LlqrenSuiGufCu7frgvYVHphdHdO8KcO9FhxzfPh4E+EU7Iec0kSjWkizDjRW
         ZoDaaAmt+wrV5CaOnQex+F6Ujv+nr8dB3T5pf2utsycKdGoAdCANqBhU+P9rpdkkLqve
         G5A/Hf6BtEt2kAR8Nws4HJmuAp7pFBKx7XmtAGnjIddAF5XTIJkZHIO8B3Gy3FkPib7n
         WDDonGNxRYw0VlMMLCAmBzL9+7kRaq8IWFR7TSnhrbKgds1yHP9gRGhuQVUAgRblyHcy
         Sm/g==
X-Forwarded-Encrypted: i=1; AJvYcCVmI1jyAmEqWBpeEU8QqO8Udl/+Tezihm077ZS1ef4LbMMZ9BaYRI6iQrTqYvLrv80j++hsJLXxA0OEmumSPa7Uw8ZUFD+a7WCZP1lFdw==
X-Gm-Message-State: AOJu0YwNZo8gKn8SHp89jnDTuATD4lEXJrAQTEDHUdBSZPb00xMZrIh1
	CxvVIbwRswnyjtcohDd9RWWtbcYRz+I/9We7YqFy0yLJQwHXwbUF+cR1a9hbpeC1Qo/XiymmAHE
	Hvqq67ruhimkPBArMszEAcNo8WPTSnXOSUXlNcALINaJO0a2qcYuQnDI=
X-Google-Smtp-Source: AGHT+IE7NYplBG53Q/FVg4oPpnY6PC138cqIKFc7dpg4p9ejsuwS+Ss4O9qFDe+Y8yNN7yBtZmj1I0gXd2bDryxkvj/RPXstuNOI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4907:b0:473:f904:f04 with SMTP id
 cx7-20020a056638490700b00473f9040f04mr17206jab.3.1708018202302; Thu, 15 Feb
 2024 09:30:02 -0800 (PST)
Date: Thu, 15 Feb 2024 09:30:02 -0800
In-Reply-To: <0000000000000fdc630601cd9825@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037dfd406116efacd@google.com>
Subject: Re: [syzbot] [udf?] UBSAN: array-index-out-of-bounds in udf_process_sequence
From: syzbot <syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	osmtendev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ef13dc180000
start commit:   9e6c269de404 Merge tag 'i2c-for-6.5-rc7' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
dashboard link: https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175ed6bba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146c8923a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

