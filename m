Return-Path: <linux-fsdevel+bounces-69113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60391C6FA1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F43F3A837F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBCC364024;
	Wed, 19 Nov 2025 15:08:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1228C5B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564885; cv=none; b=d2G6998XM/I5wFJ7Ol96HAGneqiSJxW7rjSCEn7PpeO+8JtvyMo7dBK+TMoqMIrftWMojgASZjguirWPKTf10TbYQEUPRyIwdnRYNt76yPxq+Gyy2BtetzlHn2JNOQ4B9GX30ObwRrkE4ab2TOX3sLqKP/SGHCntFLV51pEBWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564885; c=relaxed/simple;
	bh=xTqldB4mmKmJbTFgJmxEpvwOi1mt4/BkRsOsyBBU/eg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s2Wndw4YemflEpJaUyPiyVz+KClByCPSpWJWNG+OYAu3w45J8NbWJcPCHq316tvsztzHkC2PrI8eFgsjBkFn3gUVGv3rpfS6l38/eZFpUhrNgKH2OHaNaSMBG7b9HbcUe324ZUSowrhK89xpAITPSD17577h5TDKirqqA33061U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-43300f41682so61210325ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 07:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763564882; x=1764169682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Jptms8kGLz5EIArcmtsAZ3zanhhxpmq5xngttK6wY=;
        b=fvPMiZV2us82f7ahqccZ/XQ+HXnN7IlXCEGy+ivxKeMvBjtmCv1dXnQaeWCTDVFck4
         SVZVFIOEYofPIWdJpA40LDtJHb3b5YQtxQdj86nXJNGG5I7Yxo56NdZpb9ljrks7sZO0
         SgSp9fuev4G33oDz+E9aBc9kpE9Fmnnjc3sXQRisCKHHTdYGUud/RvlqRx97Cu02rR4z
         N5V++KTupqFYBQLltagf2rrBW2fmIF3pgnCYAKR5CYM9MBv7cqK56wmuoJQ5iG6cE+66
         vWLobxIknDkVALvac3Ap7ndnLp+1XqLk4BAFNmjTcKEe8Fsdi2N9IC/CoV2hPX46drAp
         X7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCX8ln6Mf/7QTipImB1sysxYYN33oHuweV8CHu/tUh1P50qFAUmD7gIWeZi0stn64oAbt9T4yQH3O6Kmv/34@vger.kernel.org
X-Gm-Message-State: AOJu0YxqoEjjS9unjnfoEN1blG9ks+/WOo64q+FIoEg0GCXBTSlf/E+4
	ROm9P0xsCqca2Ft8iOmIbVomeHa2Zo3kud3cEthjVy5t+L2amnHZP0ikOTUTrUpvRvPWB2OMDmr
	R8P/l5PkKdqPmrN2NgAjqsN/tzgJYRS3YVkIALJUlpq7/4Bfu8aomU1o1leQ=
X-Google-Smtp-Source: AGHT+IEkXu5gKPOa2B2r0ZzZRgMi35MwkUoqyk6IJ2/oPl9cfb4WKbZhw281qEQOYI+dsdg5cS+6pGKto2EJKQfNeIzfkc98YLEW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ce0d:0:b0:434:96ea:ff86 with SMTP id
 e9e14a558f8ab-43496eb0348mr161361635ab.38.1763564882582; Wed, 19 Nov 2025
 07:08:02 -0800 (PST)
Date: Wed, 19 Nov 2025 07:08:02 -0800
In-Reply-To: <20251119-klebrig-mutwillig-3bd6043f1270@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691ddd52.a70a0220.2ea503.001c.GAE@google.com>
Subject: Re: [syzbot] [hfs?] memory leak in hfs_init_fs_context
From: syzbot <syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com>
To: brauner@kernel.org, frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mehdi.benhadjkhelifa@gmail.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com

Tested on:

commit:         058747ce hfs: ensure sb->s_fs_info is always cleaned up
git tree:       https://github.com/brauner/linux.git work.hfs.fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=122ab914580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f30cc590c4f6da44
dashboard link: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

