Return-Path: <linux-fsdevel+bounces-38310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9269FF2B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 03:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D62C7A1399
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jan 2025 02:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0995D529;
	Wed,  1 Jan 2025 02:03:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C388BEA
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jan 2025 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735696985; cv=none; b=dDJe0Alb6o11DS2Vv2/V0OCrIBHxhnHUD/iRB7/hxvggb7weU68LIqOafqi1gh3TN2rxfq4JaJhNqVZeVSqhIMFzsxdH1lO+7VLzN+Dzir5owHDOALxkX0MrwYP1Vxv69mqs5BB4FkyhU29QU3fDcVBDZoWyXdufbRRqsBPDyP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735696985; c=relaxed/simple;
	bh=UxGw8+52t6n8QmAilrASrO3x9+TKWY+uu7qXqu85YI0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kXSX28EyeENd8ry35L3oYiYPRF68T3OTmtLQEtymD8OEIjZrQb4boAzeOb3r90VqEq9Umk0h56e9fQ3QeSprnqCqGsFFAlgG3KDaFR9qe02sdne7ZsA9xbnY/3VgIAq1qp6vcy+GeHhZybD/BxgIg2mjwI6pa0rSp2VqFx7l3VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a817be161bso99106415ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 18:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735696983; x=1736301783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKujP05oyByZO5lrQJ3APtLlsMmB4kwqKxUblKQ1CRo=;
        b=cQ0A3PwPfwxPygw9vs0Vsol3+MSLfHFzbgpsHHXrzwOr246qaTztFOb07J7e1qG9SC
         qQjDYDw4eubpxghNFA1zndDfWbCRGUZxO878I7WWLdtscq8ss86yHER4L3RD3kG0AnfG
         F4B1wkVf2O0M9Q456cROTqyzclBu0+8JqJNBorVbiVO2hJ80bGkoLiJpKWMbTq6VZKSN
         Xy3u27xAHa9MafE9BTAWlehE64RpD3pvHfURWR5OC88vdhQTPdmowy7lfbsxBe2cGDXp
         qd7yGRjWPQRdtdtFvfRwNjpqqCR6hsLN/co4UADtEQtHpU22gRK4wdevP+oLHEr8HOMu
         aRnA==
X-Forwarded-Encrypted: i=1; AJvYcCXCdPqU9dfWYSy8OfnQ3SDT0xjOtl91rD/9w8RJnQTguv56gWX/NNx6/qfHrTcCtbBe63da1+P1vx/fwlcQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxytZxJaUCd5ZXE9DbFKlGh+cKoQH6ImB5vLvnZ5T3dZS61P9Cy
	WE1EGSZmH9qpp0EWb6Uc/U3zT1VzyZgfOA9QI5ohY6CkzEnpQpu3zr3MVYSe5d8iPyQ+BRAE1td
	lCN1qUhkG4N25T5/VhsJbn38UueYrbcd3iWyjl0vsnbgxIGcLKVsZ2nk=
X-Google-Smtp-Source: AGHT+IFAwWP4wIvEoOfzBZBAFwz8NnBIm5FK3R9U+4LuGUde77aSKHoW/CubaRcqszfXeOXPQXRZKWqxV5LIOtxiokEAN5S6YexZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1649:b0:3a9:d0e6:abf2 with SMTP id
 e9e14a558f8ab-3c03093eb22mr375710465ab.10.1735696983276; Tue, 31 Dec 2024
 18:03:03 -0800 (PST)
Date: Tue, 31 Dec 2024 18:03:03 -0800
In-Reply-To: <20250101013503.1189-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6774a257.050a0220.25abdd.097a.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-out-of-bounds Write in __put_unused_fd
From: syzbot <syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com>
To: eric.dumazet@gmail.com, hdanton@sina.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com
Tested-by: syzbot+6a3aa63412255587b21b@syzkaller.appspotmail.com

Tested on:

commit:         8155b4ef Add linux-next specific files for 20241220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a85af8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=6a3aa63412255587b21b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11717ac4580000

Note: testing is done by a robot and is best-effort only.

