Return-Path: <linux-fsdevel+bounces-54686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A92B022A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74BD1CC1AAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDCB2EF667;
	Fri, 11 Jul 2025 17:30:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2389E2F0E28
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255004; cv=none; b=pBHASzl2mJaSW+8aeN4Lk7Yk18C4IrLTalQ2VwOnaZwAqyqKrKXnkUM7f1rQUqfEu4cQB+GA5KmAosZohwCf57Z2ieTabN60qquCIfV9j75mZbmYTiOsiaGXtygALnjQ4teHZ856C63kk0yGLwzKOA8XBKwTFszbu82t7e6hw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255004; c=relaxed/simple;
	bh=5wIUFH3p3hc8B6Ka7CMxGym9Tziz+cragojfTnvgQOc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ftcZ28dYu/+F3Unkt8vDGFcWhK5/R76OHzMQgwec9OY6MJHJH7NfWjL5XpT8tqA1Dfaht7czywkqK+zPz3Vi5BhGNAH/fUfuFhmCJlG1gkuqvq570FTmFFxIv18jCsF8dVHvQguyeAWqiUT0YyoNLoabyEuma7NjHMN8OozoqH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-869e9667f58so502680539f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 10:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752255002; x=1752859802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtYj5NrUJYfCiYvUPXTxIhWupGeSnswC1vMADMD4/6E=;
        b=qxzbnQKzD3+1Ec1+WFKMbb420nDP33tQzE6uTJ7vUacMzPOGK2xiCFHxC/GN5yCrsO
         tNWS2TV97oMj84iEpAwl4VsnNlfKBih77EToVfMsfc8YXMs1ZTJg5/M29HEOCcLxYhLG
         FzLOz/JPTeEHzht4ifv3D3EEZ1iLB8cQmMfGSNTwmcE9IXZZqocu0quWIvAgyYjCB1u+
         9FqZM8bjtMgcubHT9PsrTQMbUQKQ1o+GS5pJkCYY55AQQr+l8f2NniCheCb8pXmFGpcB
         zwmWk3qG0PLzDg7RbYpUos3sy6hAiDrsO3tAzz7RGUkV0jkmdcTG49lPa3TcybNZJ+/g
         4oRg==
X-Forwarded-Encrypted: i=1; AJvYcCV0DjfBz+Q2cUFGQFVoHpyn6qLQR35PhFd+2f4vmFqgLBftd6pryhpn+R4eCvlNSB22R73bRA+xiCrARbvw@vger.kernel.org
X-Gm-Message-State: AOJu0YzEZXUxXA0H3uL6JhtKLzl2iEDZGDVDvl4E6Fg3nLfOWWMJjTHy
	fchTDcXXAPpyN+bdCTPLBvxb3X1dl3vwAwJoSwUvViwVPfPi3Ve71qxJ2m27/LFKVwqUPxaTlqR
	w/RxlbZ99zBaXS/cioxKyQC/VtP8Ww+FW9F9xpbGkJ1mh60uhxHZpTJdZTZs=
X-Google-Smtp-Source: AGHT+IHzRB2BUsrViLN0NCJNyjkK8/XfSLHMn0mIEK6+ILPjJzMMqz5TTV41Eh8cSECo1M/2sndo3Feu2SABg0xx1Qq2f1RrQxs5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2163:b0:3e0:51bb:6e42 with SMTP id
 e9e14a558f8ab-3e254313c42mr45683925ab.6.1752255002208; Fri, 11 Jul 2025
 10:30:02 -0700 (PDT)
Date: Fri, 11 Jul 2025 10:30:02 -0700
In-Reply-To: <okx6a3ngonajh7jrzc65ybd4i6bcnkc7gm4mggyo3jlm6s2ojx@yy5jcipsnd3l>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68714a1a.a00a0220.26a83e.005a.GAE@google.com>
Subject: Re: [syzbot] [ext4?] WARNING in bdev_getblk
From: syzbot <syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, anna.luese@v-bien.de, brauner@kernel.org, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, libaokun1@huawei.com, 
	linkinjeon@kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.raghav@samsung.com, shaggy@kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
Tested-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com

Tested on:

commit:         a62b7a37 Add linux-next specific files for 20250711
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b87a8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb4e3ec360fcbd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=01ef7a8da81a975e1ccd
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c6c68c580000

Note: testing is done by a robot and is best-effort only.

