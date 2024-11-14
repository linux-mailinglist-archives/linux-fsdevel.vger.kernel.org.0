Return-Path: <linux-fsdevel+bounces-34731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 042209C82C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 06:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B046F1F23E16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF51E9074;
	Thu, 14 Nov 2024 05:52:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8217C20F
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563526; cv=none; b=iEw/dgoxd/EvmcDouhXKdSkJxlXxv7uRYjnZNu1fE4YXMJewYmP3p5u65Wgsks20GwDfH80uXdZZPtS3/oIch68Rqv94s2uLH1YIUKQDJnV7O8n7rRElTFCMkY+6lbBpoyUkCAL1AUMOhZnL7I05/8+cgmnUiTh4Zd6Y818G+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563526; c=relaxed/simple;
	bh=7O9gfR0es3iI5P6jHi/Xi408OtxYV5gkwr3x6K1hDhQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EgQjf9OTiPPo5o2XHlXBRajjm0J6dbO0Ud80Ax9McG7SBs05jiBYXnK5MEGQm8lBfsqLDAif/59FDZb095+PF4xd5S6L/AA5nvgi/jgVwTF9MLGZkCUo+P46IkiyHMHWp7teHM1jLaOwNheRHjY8itQ+TZmMynOvzKRJN2AtP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a6bce8a678so3058465ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 21:52:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731563524; x=1732168324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1IpFZEQgGIj9TjFRbdLUfNjQq3j1EQcFpxBuYCYzFUE=;
        b=tDllwQ17kpWlu4AHnrIVUk0sRb3xOc10ecVgADc8L5suduGH/z5KJmku5FnKV2khIs
         EF2m0pzFat+yhZ54BtJD7Z0Xzcuw0qKq2uF73dXY/upAyDBs5UJ0RnjcZTZb4sgDIAkJ
         ySst5QvNVHoYJP4ExMSIejzJGZmfJcbusFKxaCgaljXvA66JvAJ+jzGTVCtD737Hyga5
         w4RWX46bsgAxuKbI/7mmrUwYu/BfJnA/7XH1Xu4pJjavJzgg3L7WDsG4EWAoK4QZQkz+
         cK+iLF3S3nIPaTPyu8LVCTLhdpsEUzS5snJbKcyyQ0LirO4W9G2pA9yods8KRMSXZVEg
         BErQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtoLQUCQI+zMDx2tokwiU6RE7PsTtLkrgjwmVYS7QhAcIdNnxWbKY+N3fLreTasezrlWGVBryEdwu2NP88@vger.kernel.org
X-Gm-Message-State: AOJu0YwETdicedp6t/rcXcMAP3Rr2kzEzb1kOLc2ocgBmA0BvIucqont
	41S2IAAVfdrw13bUbrycbnUQvsQSMV8r2aa8kUNWPrW++8F1faxuBBZ4SnpS1IIla15QwK9NKGM
	xjw7RyKG5DogEJLPFE9vSLpCSh1Qxa4sha3LwfdlztrYJVChC0NLDsFA=
X-Google-Smtp-Source: AGHT+IEGC6y1/QUxLcKR4nU9hQrJNc0vXYAJaMCUbS301MOJxa+AGUS1nxL2+ypoL/jmba0RuTagI9xdLG5nigEMdFtsK2PT8Cmf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:388d:b0:3a6:aee2:1696 with SMTP id
 e9e14a558f8ab-3a71578db17mr60186115ab.21.1731563524569; Wed, 13 Nov 2024
 21:52:04 -0800 (PST)
Date: Wed, 13 Nov 2024 21:52:04 -0800
In-Reply-To: <e22f5b69-0462-41c6-b7a9-b3ae10fa6992@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67359004.050a0220.2a2fcc.005f.GAE@google.com>
Subject: Re: [syzbot] [fuse?] general protection fault in fuse_do_readpage
From: syzbot <syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com>
To: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com
Tested-by: syzbot+0b1279812c46e48bb0c1@syzkaller.appspotmail.com

Tested on:

commit:         779014de erofs: fix file-backed mounts over FUSE
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=155294c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2effb62852f5a821
dashboard link: https://syzkaller.appspot.com/bug?extid=0b1279812c46e48bb0c1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

