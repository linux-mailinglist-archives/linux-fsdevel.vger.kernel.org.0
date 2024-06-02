Return-Path: <linux-fsdevel+bounces-20747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 402698D76BE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 17:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF75A1F219FF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E34AEE9;
	Sun,  2 Jun 2024 15:30:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9DC41C73
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342205; cv=none; b=QPbpS5Srs0UQ4MrUmbTfu3Cc4I++Z17vOUlACwdOQCldrONQRoy2EYaW+uHj2z1TrBjnss2eASQ2+oLBu8ffwC9gJtIcs+C2czorB26Cht4xipdoRpjSvcqCYB9ETH0/2Z7QHoQy/HVVJ1Q4+Dws0deYwi4sSPGlJHZ0UJurYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342205; c=relaxed/simple;
	bh=bOm9gWls7u3Ju5r4S+P0rlGua90hTb86K2Nx7PDj0PI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q+qs0v1hQtI7CnMPEern/jYIoHu9b6Gvqj+bj1cwatyrlj6uf1Ym1LFlPwgzitmkS5Sd1p/oRRpWu5jH73tXSdPTcbnRqMMg1gm2WrV18QhmrlBDkTFfLkVOoD3akXlbRRyxE2ZKk4tqwGWOZzmmbeyn+E2DobiiDysuo2xG8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-374933240bbso10223905ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Jun 2024 08:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717342203; x=1717947003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOcPbj2g/KS87dFDOfGs2GB8jKiVY1KgyNHsqEeYjUo=;
        b=kDqUEijxy8XTndUlVpdBTCZ7Tf7xJ5gD1LuXkvLozj4wFEMeoz5gokoPu3CgYsSyC5
         Va/hhwY7B+5xaxQTXYiPfcmSO2KTwbgCE3Rb+jYUNOZGIWojxLuDoSUajTzSSORKPbMn
         IMyzT335VRFoCOTb2vdqjvOr0s0B8m37AhO5WvOU4u6HOUflTsqEa7R1v9TBammb9qrz
         Hh9HoDj4sDZnIwWyPvRvhADtAninSzsvSjzWuB+AJMDzGiXO7iHDVYzswrXez2DUV6Gq
         1tENtmp7mm0SuB4obF0uVRgoGQvGEL8koRtYApeeRbAm5lfeGI7E2SHnD7X19v40c36F
         CsBA==
X-Forwarded-Encrypted: i=1; AJvYcCXa9BbTzLkguR6Z68Q1Ycw0sP6aNokxhNoaVKDwswmCtSN61cW7j/iiN/7m63LvI0o2Zihqg7NRrZjMskLgJKoT+BGTKLcjM1HchIe23A==
X-Gm-Message-State: AOJu0YyKxgaUnGqZYxb3yg91P/ty53IBnNEeKJMepX7QkqK3I2TZLl4Q
	ym4UzqGy9uBahzYskPGjim+44BzohrUA2ngjRk9ctV3phCGWpVxpFwgfEWQMWDkaazU3AUw3p98
	KqXybWWyLQzbrGIodRBmbsyydWu8cXl+mqCNanx6G8L+fkEduvCovcNM=
X-Google-Smtp-Source: AGHT+IGNFH7WpmuoUYSt/vcWg8NsJsKafOrSf7a1UACgOj50zR9yRqd2W1/qedHtJ+vKZZZEe4RSkLMEFw7wLpooTeo7dpAzNEBM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:374:9c67:1dea with SMTP id
 e9e14a558f8ab-3749c6721a2mr1304405ab.5.1717342203107; Sun, 02 Jun 2024
 08:30:03 -0700 (PDT)
Date: Sun, 02 Jun 2024 08:30:03 -0700
In-Reply-To: <e2e23c33-b318-472b-a9af-3ed787149b2d@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f971fe0619e9e3f3@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_inline_data
From: syzbot <syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com

Tested on:

commit:         9c84cdc8 f2fs: fix return value of f2fs_convert_inline..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=15e10032980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48a63c58ee55467e
dashboard link: https://syzkaller.appspot.com/bug?extid=848062ba19c8782ca5c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

