Return-Path: <linux-fsdevel+bounces-35038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB089D03E5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 13:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1669EB238C5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 12:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8DB190470;
	Sun, 17 Nov 2024 12:53:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805912FB0A
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2024 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731847985; cv=none; b=p5oncmQj9nG5MDtCzoh9c+Vdq0ZmfC7chFdz8HQ5aszoTJfT9go59IuKpr1IUGQ1LABZHMeWAMH71jpzbQwnqJNLa4BM1bZZiYadxY3CYXT7jNsJLeQCMI7d5dWQe/Xh2hFIucBLNryEFUC2e6wlq8ayKO6NHJX8suWkoBELsZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731847985; c=relaxed/simple;
	bh=XrRdWMJXBrdN4f/8l6l7kAcSLbQ0kZAZKwgyHlkcuwI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oEwnJrWRzBdB7E0CkfzeDrvii+Gkt0pUIw4seKZIyyq3MHxm8Y4Gbin8/MmfvWQNkzZCy69hB348JE0pJeekG1v0kun2MUDFq90lKvn/2VQeSd25mVMpzaJJ1NYyg5alBElzpXFoK2n3sBkYM+dqB8uLx7/9ioZgQvvdPZGohQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83e5dc9f6a4so313664439f.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Nov 2024 04:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731847983; x=1732452783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQFhShpCFFfqPZwz2aZH0sjh2uJyuJz+k8kyZhQ1m2E=;
        b=fakmDrb9lreZspxdubf6I8d58cogLrw6xFh8lyWTYFbktC4vz5lrKz28oZGBU/7oPx
         V1l2IJaRjUDt4DP7clsh43rUq2ULA/pA5XxyvtQL+P73vwlFVxy1ne9FEgRPmaaz+HJJ
         DTXlRdxmBpn/QjLoNWwLp5U2DEMJcXagG0XUM7I0x+JyBNtP9lS18AbBtwwBAcSpFodB
         WyS8A5lOUjnARXdrQnfGAOTDnVBXerDj+BApwbF1UN6EJfmi6L3S5wdh4Y3tM6H8pgvn
         Ba89Rr+QMGuYLZ3J4d2ga5GyZ0TkAu/JCb98BEnEY4kBATk9X5hzh9iZXAPPEkDcse2O
         /tKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaJPvTBTz4yUuhlAYXOxIA4mLkId52LrRnF2GQTBH+jELNqFhjz2YVysQO3HIxVvER3UsjfiJc/JW785DF@vger.kernel.org
X-Gm-Message-State: AOJu0YxSVv/NfpbxfRy3Qf9qCVhO7fkiNwbXHzvE4WlIuYFJPLgd1ZCh
	qHosXp75cNgemMJxBizzWu+q33I7iVPuI33LCeYxkkAmRHgB4+rY8n9A7cynuKfcSAth0KI6sMC
	vzIxrLmphu+JQz7wrFLgsjKfIlcpZ5Vfhg8OeSRrKzj4A6ncVAO4jsMk=
X-Google-Smtp-Source: AGHT+IHH42tRIhFkR/AgZmPHwUk0sE72aX9yFGbSTU9HuCw52hfPuXvwon0zb3cTuC/NEMyQeriJMsyFdp7bupcvK2YJp/vVZLtN
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:dcc6:0:b0:3a7:47ff:546a with SMTP id
 e9e14a558f8ab-3a747ff559bmr70003765ab.0.1731847983117; Sun, 17 Nov 2024
 04:53:03 -0800 (PST)
Date: Sun, 17 Nov 2024 04:53:03 -0800
In-Reply-To: <79b938a8-ecb9-4d3a-b1a3-76f1a9c9f351@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6739e72f.050a0220.e1c64.0014.GAE@google.com>
Subject: Re: [syzbot] [iomap?] [erofs?] WARNING in iomap_iter (4)
From: syzbot <syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, djwong@kernel.org, hch@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com
Tested-by: syzbot+6c0b301317aa0156f9eb@syzkaller.appspotmail.com

Tested on:

commit:         2795294b erofs: handle NONHEAD !delta[1] lclusters gra..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=1058db5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=921b01cbfd887a9b
dashboard link: https://syzkaller.appspot.com/bug?extid=6c0b301317aa0156f9eb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

