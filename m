Return-Path: <linux-fsdevel+bounces-36108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665D59DBC51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 19:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB82B1647DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 18:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30241C1F16;
	Thu, 28 Nov 2024 18:56:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41FC17BA5
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732820165; cv=none; b=U0yyv4hzRI6ea5W9NZW4ca3CVJmN7ka6ayjVG/8bMijkhzkWZjjU1iOjMIYkiHEslwH8NGyhai381bWLWdVxQLZVuwkl1ApCqAq14PEUG/pIf77S7Fah/NK3ri+moJhrtjunNWElIR1oUklOn+DyInuo9vCBpTZ8pzCzrls05Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732820165; c=relaxed/simple;
	bh=Z+PpZtkz/FpeuJ9ipJoPBWSHvemXysnT3IG2YHEnkjM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VIet1K8+ozUc0V4vcWWy6QADiHhxbra6MEuRNCRsOr634IzUJygQNsuTcAHLAajcjrvoz8pWZPPR1/Hd83joC/nckCrPTC94mbwyT8kYzlmdZiEtbSEb8R8IBoaL84X2Ie/t0Z5RSr1S+TwckTs3b6x+Nw3DAnenZ0hnm6gXbvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a787d32003so10490745ab.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 10:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732820163; x=1733424963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rFnkMusVUvztaavp+Wcshy/0sAVSnlDNlHNqkEC4OWw=;
        b=cKbPGjV3TwXrat2kcxLAL3JG7e1MjXokRPeruuoYXD4Qxeusfuafz+gT/4uCuiqeFy
         nPUDH8AHGq40V3KJ2v2KFWclMX6Au75CowY3m7wvuzkrxBo8HUlu0/VDg2vygxclDEfR
         85ovuX1NJgW0ZICcYCs9B9akTwC82iHg4RQo/NTgg8QIjJ8UX7GnnRZT/ltrA93sUIUL
         MSpO28w2fxzg4FXPnBo+DW57v/V0fyRzL6gx05IsiZ2+oJXJTpp1sRRFIWtUV+wWTM7b
         o6LvN2K9gOy8jWGWPSkve/yqG7OYD9FlpFG1HBOHzykBVs4OwrtyKDIwkHkUmGGm5DHN
         PtnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKAsOfI5HtKeMlY6FH773rXqfaueqtQPiUGYZxHitpzESFMhs8Iayt2MEbndD7XubG/n4CCG/gAuXS3as6@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUq+CDFUsdq+enbxPqloRdZK600tIqddWIzTpj59/PHWeDeFk
	YPXq983tzX99HdkwQL276kbcia6MrAHbs4OtG544dWAtSLELqR1+IsRjk5b2QJhlgSbxcYKG7cG
	bm8EVmUGGn/dBfceozaK4SnAjvHpwX3+wpvqDwt0yf0+8dSPEfXPu3e0=
X-Google-Smtp-Source: AGHT+IGNAXCnkSyv5wsjsl1uLr0IvOlIpNkPenO2sAYjOOEncjSd92ioAVMokDfo7yC3eNrZ0aBco1l6dWJiwOCw+6uPBkUTfWGX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:3a7:6792:60f with SMTP id
 e9e14a558f8ab-3a7c5523f52mr85784815ab.4.1732820163265; Thu, 28 Nov 2024
 10:56:03 -0800 (PST)
Date: Thu, 28 Nov 2024 10:56:03 -0800
In-Reply-To: <67432dee.050a0220.1cc393.0041.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6748bcc3.050a0220.253251.008c.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] kernel BUG in __folio_start_writeback
From: syzbot <syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nogikh@google.com, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org, wqu@suse.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c87c299776e4d75bcc5559203ae2c37dc0396d80
Author: Qu Wenruo <wqu@suse.com>
Date:   Thu Oct 10 04:46:12 2024 +0000

    btrfs: make buffered write to copy one page a time

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=165dd3c0580000
start commit:   228a1157fb9f Merge tag '6.13-rc-part1-SMB3-client-fixes' o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=155dd3c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=115dd3c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=402159daa216c89d
dashboard link: https://syzkaller.appspot.com/bug?extid=aac7bff85be224de5156
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13840778580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17840778580000

Reported-by: syzbot+aac7bff85be224de5156@syzkaller.appspotmail.com
Fixes: c87c299776e4 ("btrfs: make buffered write to copy one page a time")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

