Return-Path: <linux-fsdevel+bounces-12001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FD785A299
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 12:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C1C52828AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Feb 2024 11:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594E52C85D;
	Mon, 19 Feb 2024 11:58:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934C52D604
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343888; cv=none; b=Di2M+XCZ/hS2Q3Y16q4eD+bzjXhOrVSsdPdIez/BfCSF9w1X9St3kvBXhypoWV4GnikAXLu7n7e576qVN0VOH9PazTohGu1kQdVR/gOFBoh8/0ZHAwMz+j4sHFqWSnUGrYOksxv6XV5etc7vPnTIsL608qAZw6jHUqKCgkLQvBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343888; c=relaxed/simple;
	bh=TQmW0k0mrrJtpAYMPKSa7ihRnBCkF+V4hHMWThy4tNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YYpoD5iO3CQRPbQHsaa9Q2Dx9GcIiSRFjG7wiZgIZ52TaXsv48Gf5UzK/sU4PdHiwavh/MV3ilryCFE7cUzA3tbB5fSIK0y6kjA1EbEjIRBqPRZ9+MNPw3mjQBVCW5KgHCFIQmVkNbdEJ+oNgNA5gkP1jWmmsrtuRQmxP6321XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36516bed7c3so9809575ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Feb 2024 03:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343885; x=1708948685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOT/FQ95TWde9g78HBgFYpuNfXwzNoXRLXzlXD9GSII=;
        b=oiKzegeeLvwRHp3giOBja4QDfL0EF3hxhjEAVIBbSUlmVjP1UW0uHeJMyT+q61uL1M
         mRH2PdoWsXtUnDoWbO+H3tNVLYvXH6DGOSnZSt0nCExUWdwT4V17vZkE39YM+uMtfLWE
         RarVnrgZ60WIxdQ4v8jBnZs7WH7Dhr3dFreo27TlQuNZoetCvtVBvbK+saDikzhzTtxR
         WY1XuUoObqhtVU3gwB71I5ty1AP9YD8m/IknRoQuve4DTH8SDpY//blfdxn3sH9fEDkZ
         drSCOj9vWoRZbzbdrJ1kHUyHacJ0Povrv5AIgtQCpSRdEYEHtUsd0AbHMFrvE4hkFJce
         MQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk3EZuvkgXeXWEe5NujJ1Q423Fjdoa6oSqNtqPCJggYPbDqM/NKOxbPKvGY8ngyIVnjSo+vLoJtaA3HjxD0E36LtptDxrPSzZcshpaqg==
X-Gm-Message-State: AOJu0YwiUI4dKUPsfCcW1sIKKlRwrr4NIUBs1HYj5rRuiTXEEde+9Umr
	DddKF7uBsNiUqX/e96mAuZfcOYX6TYTLU4Xp7Ov3D9WO4NLhjLSMsUdy9mN+QftL09t/68tQDOy
	h+vmZpHZjCDG+x9YvT09E4TDXwke2r3roH2y+cQSvGtNFEAVXFZY4ZqY=
X-Google-Smtp-Source: AGHT+IHzjLRsBmpEd4oZ2sh+MbTV5Oxsu6nOCTZ6wBZQxqKeFpAy7GVq3CUuF1jwCIbUmS1x3hblykLa5NZxVHGCoIjqeitDcdaJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:363:df76:4a1f with SMTP id
 t13-20020a056e02160d00b00363df764a1fmr964199ilu.2.1708343885808; Mon, 19 Feb
 2024 03:58:05 -0800 (PST)
Date: Mon, 19 Feb 2024 03:58:05 -0800
In-Reply-To: <00000000000050a49105f63ed997@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077ce280611bace5b@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_dump_glock (2)
From: syzbot <syzbot+427fed3295e9a7e887f2@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, elver@google.com, gfs2@lists.linux.dev, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, peterz@infradead.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com, valentin.schneider@arm.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14238a3c180000
start commit:   58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=427fed3295e9a7e887f2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172bead8280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d01d08280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

