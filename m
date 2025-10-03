Return-Path: <linux-fsdevel+bounces-63334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E778CBB5BC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 03:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE5D24E4457
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB132777E0;
	Fri,  3 Oct 2025 01:27:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2282327A3
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454828; cv=none; b=CX2fuDn8BZwRoDdRlN38SG7Ul89zPdGLqnzxcnm4NjUzBR58HecZarR8ZxaDl6vMWZMlPvqqyU+W+GSJ7x77pkOvt3pXKMPWaEG4DLoNNFL147zKvKfxtxZGkKyuWZEvU8iKCwBc70loZwCK5qmSMVVyZ3qKCmxr/+CLXwOyoio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454828; c=relaxed/simple;
	bh=hrTxAQcFdcHbVaYRj6QxqxRE/BKl8Vu8PQW3pqXxYfI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LOQ3dnOvgam8b1T20Fvb1fO2NJWZno9oCU2obTfv2RZLTqcUpEiiYgNI1suM7ImtmRb1xinJOeNltVyv24Gy2un4I48QC5WEOkUcUC8G7j6DFoTDHowuuQ4oR0JR0qUOFonRCucXXWqYEm+wNMtxz2C9Fy5314JFVHEM8xunoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-886e347d2afso197978339f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 18:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454822; x=1760059622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSmZV/hnldfFeMcUqOY+TsvaP/ZBZaX083DD+cWyDfA=;
        b=qZ/Qqh6ho1JUYxAoqMmKyDy/ur6v+OTAjYMLiknpoYb0pL1Cf1liCb6adiR/fFWaeb
         whaysR93bOzuMuN1UsvIu66dKI+jA39mPA1ELfFHaKGWz2sR2UDMDfQS4omXcoUVifop
         g9miVafN1QngHV+cX8k8ArMUNq7vIMf+oeKObYo8JIZdgRbq1oCLZuOBVd4cHmoLNJXH
         sWLIgiJH/xMdJMrrx8ApjuAY+w4Qtp3peQx6H7H8O28eyttULttCwEQ5AiZASmxfm02S
         Q7weBMMKXOLH5DNveLTvwfyDzytcE3ySGQ4iKU5J6XoSW3SI0ztMFqYFUuVbJiGrbGtz
         UlFw==
X-Forwarded-Encrypted: i=1; AJvYcCVRFpbhap41MdbU4NZv5XoLkqtnZV0/vHoc0bEesXYsaRjD8Vrcw/rtL3J3y/lT0GGAQS2vXmUV1FKclBzN@vger.kernel.org
X-Gm-Message-State: AOJu0YyeA8EWt2FAAJ4WPvQGuplgZCe3/AeFPCGq08mju+cz/OrraD/s
	5Hcz/xhvSRfDb/VLWgL+EAYeF0r3hZiaNj+QQDi8sFUZiISBvXVVXcN8srcUU1q5Ka4/jAyoK+E
	7EXUdW/m1MBijFle16YXh/yhIsWF/L4IvzPUi3XINC0qkWADII+74C91PZQk=
X-Google-Smtp-Source: AGHT+IHudRpISqfi3wse3S1sGdDNxOvlRpJc9pmcPMngFY/X8JmxFkMvTRl5MdyIONhw5pDjJDjATx98ShZMq7O/Au7KLeczynwS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fc9:b0:91e:c3a4:537c with SMTP id
 ca18e2360f4ac-93b96a952f9mr147480539f.14.1759454822474; Thu, 02 Oct 2025
 18:27:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 18:27:02 -0700
In-Reply-To: <aN8g1OkBMndiyKyd@Bertha>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df2666.050a0220.2c17c1.000e.GAE@google.com>
Subject: Re: [syzbot] [hfs?] kernel BUG in hfs_write_inode
From: syzbot <syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>
To: contact@gvernon.com, damien.lemoal@opensource.wdc.com, jlayton@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com

Tested on:

commit:         24d9e8b3 Merge tag 'slab-for-6.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1472aa7c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9442f6915cec8b7
dashboard link: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13c8d942580000

Note: testing is done by a robot and is best-effort only.

