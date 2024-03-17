Return-Path: <linux-fsdevel+bounces-14567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC5887DD52
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 14:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB85428143B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 13:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F2F1BF37;
	Sun, 17 Mar 2024 13:58:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B731BC5C
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710683885; cv=none; b=f9fa5AB6HT8YdZfwoxnIXPtLd2716aewOzVPkktBqrJyT8XHMa2G/PMJ+hrzo54nfBkE+ObK9dE83DjHsSrBVp4evo+oRdap76s60iP/z4WkHPRhYuEAp743Dj+sG8tMmNFr2Fi3CWkWirm4lZZ69HuGSe5zvt+fsJ0R2+dM8CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710683885; c=relaxed/simple;
	bh=L9G4HDohrXQuIakqxZZFzidXl1q6Qm9FtmslfgpyzRk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cTRmul5NQJBxuggewO1+blTLTd3IB4+pwmv3X3Jga+1WySgdVFZgGtcfpDQkeIpIoV73Y87yYx8mBuVRwAMNrDKTvsZ0riOkVugNCq5+SAia4h87O+upGruOssQfKDeLNSyRZLe+Hzu5SbktFvRI7KV0IHsS8ZNNawenSe+PH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf38c4411so207373339f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Mar 2024 06:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710683883; x=1711288683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eD5+B9KN5f6+6XpRxSKGiUG39g7Rk1aFKdCD3iKDsCk=;
        b=wtR3VIKjW6jgiNic2SLqI5r6gc01thfjrj3xOsJAfFeP9d+URN3bx+b+jhvU44NCKO
         u5DLmz87d4bVPXp4Yjw1PjfChJ45HkAZY0A/mdzOoFJKK8SieJvTJyL5iM1jWea9VBAb
         KEcFooaMcWkT2Ab20nbypSgcSKlN1GNRuAwiGN+BJxqUIR2rkQhu5SJIZS32dmJLVWM2
         vRxj24dNMHQGiqukPMwOdkT93Gf8o+TCYrgc/Z0meLpMB08Ppp5Wl1kWb5kxvvd7Omzf
         ZYhWHd1mjdsqx8C7tXxwtiFcuaHuKEN6XAnhlyvbHMqgkGi4485++a5wZopBw8NJx2ZQ
         5Y2g==
X-Forwarded-Encrypted: i=1; AJvYcCVgGPXdC44JkUQ8sX01qBK1INRrFV4qbEwEenz6LpnEUJ/Bha4biiX3Xb2UEEFMZU11XxG76ZvFO+RnG4Fe2A+WJ1g5O042IseWZAoTqQ==
X-Gm-Message-State: AOJu0YyEcTjmmDuvkDS0MGAdld5SOOHi+ETmb9mtq5Rs+6PPva1irw/7
	hhOPNvFosHqTf58LzP9sUdg+xjL3FMhP3vp1tY8nZXXXJuMmyjurAlyIWI9XN3D+/vWTbxAaHqK
	ukIs1zYQEbK4bl33nz2pOO9WPBfG9dx4qMNUBmQUZuPxNobKxVB0APUM=
X-Google-Smtp-Source: AGHT+IHPul9WGgkKqm7B8jSCs3hOp4iNttQYvYYPfYn6tt6kgff+bf7Kr/d5QUuiKI5Un4eH0JnQ1vAaB29H+fcRR2HAvVFMlWKf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5ab:b0:366:b26a:ecb0 with SMTP id
 k11-20020a056e0205ab00b00366b26aecb0mr38488ils.6.1710683883125; Sun, 17 Mar
 2024 06:58:03 -0700 (PDT)
Date: Sun, 17 Mar 2024 06:58:03 -0700
In-Reply-To: <CAOQ4uxjdGyN84GV7rA3FTWYzvSTTY6+bza2PvHn2mNpHTPfxFA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d50840613dba1c2@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_copy_up_file
From: syzbot <syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com>
To: amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com

Tested on:

commit:         a8d73a85 ovl: relax WARN_ON in ovl_verify_area()
git tree:       https://github.com/amir73il/linux ovl-fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=14d627b6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2271d60b0617d474
dashboard link: https://syzkaller.appspot.com/bug?extid=3abd99031b42acf367ef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

