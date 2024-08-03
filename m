Return-Path: <linux-fsdevel+bounces-24927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C42946B0F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 21:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D877B21141
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115DA219EB;
	Sat,  3 Aug 2024 19:28:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2701865A
	for <linux-fsdevel@vger.kernel.org>; Sat,  3 Aug 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722713285; cv=none; b=RVifH2z3ya8GwewA8X/38B+UX7HgCLEKXgf1g5ieR3D78IjXa5YuiA9Jo8KTK1+sc18kySUs5k3WfIxBlM+3ihzwzHyN1dnLDqDSUgMpqN9iY0k7jUoFT1MaPwf37EKUbTYmozeTp/JYVfzY/4AFjnFczqtGiKLYfluINv6kEdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722713285; c=relaxed/simple;
	bh=bFbUGsGxfr8+8dMfTHuGur2dy8u7hQM5oXnFeY0Iwro=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OOIDvg3Ticb0CYVw5XOhynLVSV2a3RP4Yu9BSfVXxOjLfg4KU2fXXTlOgRDfDi9JBH6oOAjXOHjo5wKaIdoXHa0TK7uz8MvpqBlWCj52qY5ByGaqj0LVWA0yMX9QvmdMg+uokZFy9l5x5uHkyFZWNWK8OWXFSGlg0mdVRmcnOjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f93601444so1322675639f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Aug 2024 12:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722713283; x=1723318083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+sAO584wltBhDlbpJdMDg1TUH0z7fhGbHYvAm/SN+I=;
        b=sRAsXeiF01nUqzXtAxIZUqRNGaVLDaSjI2rnfiCRZeQpMn0NodpXbfUiI0IR3l4/gn
         HBa30zSHBJ9kVfQrMjY/3ZRW6E/G1CEcUzvr+JumLWRcGYeHx5vxBNge8pNbSpnzrolc
         AE6+joFsQ5FBTZ4M3ORnNhYokInwe2Y8tLJ/U7GEpyP0IjKuzxkLEAzwoesLCAZEt6XQ
         neE72fTOF4TSyQr0Pomnp01PuPcQ4A4xZtT45DQm0noQpx3uKcwVXyyynTIcFi/SCVEe
         XA3E8q7U/gCWDJNsgAA+Ldv3XsLoxAeoQtGDq1fUL7hMXQrdzlz80Bjm9oDhHvrjSYk3
         An2A==
X-Forwarded-Encrypted: i=1; AJvYcCW9ZvILUoBbI4RK7nwAJBX0fqDoQ4BUXD3fjZJT0SQRHTGioRSMGAWB8pQmO4AJfM1JqzvuMfFzAX7FI7tLPcZnqPdlwkYJjUoLm+k6zg==
X-Gm-Message-State: AOJu0YzfJlRowo0E4MR8AP/3GXFiXnrYUsFebf/mBGuPzlmHZ73SrF58
	XPQKtN8eLgQF0ksMDus2G9yGTU2s8+58B/nkNqESI41wYo+agmblNrN4i2QsRtxqRU47qeu7yUG
	DPqCKT8jEu8fSjEv/zWQBWJHwKwZoFSo7qYjtqwQtwmyRA7J25maPhQU=
X-Google-Smtp-Source: AGHT+IGGy8zGTOF8yOHJyotlAgw8mXOQb6CSan6vq3o0LcTlSZskIQelzk75hM50gZLIOEytTwivlK3uyYM3oPhT6CiTyfnesXl/
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8717:b0:4c0:838e:9fd1 with SMTP id
 8926c6da1cb9f-4c8d56b0085mr303432173.5.1722713283387; Sat, 03 Aug 2024
 12:28:03 -0700 (PDT)
Date: Sat, 03 Aug 2024 12:28:03 -0700
In-Reply-To: <000000000000d74cac05f1450646@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e70d5061ecc718a@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: use-after-free Read in release_metapage
From: syzbot <syzbot+f1521383cec5f7baaa94@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, damien.lemoal@opensource.wdc.com, 
	jack@suse.cz, jfs-discussion@lists.sourceforge.net, jlayton@kernel.org, 
	kch@nvidia.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d6414b980000
start commit:   4d6d4c7f541d Merge tag 'linux-kselftest-fixes-6.4-rc3' of ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=94af80bb8ddd23c4
dashboard link: https://syzkaller.appspot.com/bug?extid=f1521383cec5f7baaa94
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13385bd6280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c11186280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

