Return-Path: <linux-fsdevel+bounces-15051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3EA88659B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 04:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1825F1C21CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 03:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262566FD5;
	Fri, 22 Mar 2024 03:43:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470DC4688
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711078992; cv=none; b=rNwbO4pQkXwtOE+aEFBrR6uot7SyMnsr6SG0rs9yyPxDqZBdiB1n2hJLvuJNKHe9KVpzwtGmXwVI5JWxapq84gaND3D90SOIWRqt0u9x+2w/U2K1+cJ6Ofz5CyHVVbIP4m33grQlVy5Rqj3XwnA6yuJZUlT1X9parW3Ggdyv3bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711078992; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Liyjp2DMgSWMELwchD2YyN3jyX3SPnvzMmgTG9AJ826dTuDxFIbak8TCqBLKHMo/umsLOp/VFSpxqLEp3/XU1YICDHCiKaXPuxyb5eIjKRFJeLuFlPfbzKr0RXq4ysOvD/9hy8zdDcY+Kx5rk30ZXMD2it1C39Sfmv4gpVH6W4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf179c3da4so177326639f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 20:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711078990; x=1711683790;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=V8Yt1hwRFREiHwRCP53draJElX/u77YqtXrrN/00OYo19vcfBkPvxDK5XZ5pT7dCpF
         T0a0pOrEYSNV+cIa2zh9ZnTre0VI7W1TcelR+yjpSK9t6+O4mhCcra07ofZlJ/9PXWIu
         nwQXmVsZSFLgrvZLZlrW/dDsnwaDW91gqFCojmQw2bG0GUz/Ob+9kBlx+7U1AJ+R4Mnd
         TmQRaICmqF0YMZOriyR1Bb1I+b7xxX4+XpUGRYM45pyZB+6JPe0MjNd5ONkYqYM4p7Eo
         Nv7odLXnRwWwp0afA3t3d3bkOMbpBg1+kO4ldPehn5zzsDanRJt0hJZ6XBffa47ogSJM
         4Rqg==
X-Forwarded-Encrypted: i=1; AJvYcCV80cZbjIFFt1m4HfL6JEVSCP3D8BV9Mv2bEq3ml1jgx4jV/n2eF/b+nJZO7zUUwq9pMW+imC9c9ESyEkyubycAuG0ICbpZrxZQABJ3fA==
X-Gm-Message-State: AOJu0YwWFTOPNOXrlSwOuKFAVnXzeX71TFyHzq/YN+Sc8MviyUDM/dTS
	gBPGUvkNTfe8lk4Rue24wa0ESXzkl6JDCDHhmheaIZxC/xbeuNxr44c7GvkBEIBBn2WDlv2JJUj
	unp2LvV3N3BBiEf5fzJ6ikJWQeUY4WQ470e+7B6MAMA3C21aZTb7Qngs=
X-Google-Smtp-Source: AGHT+IEHxk8xSCWHhcDoCB7Keif1EAn8Bc3Wm7anJiX6s4lQ7mGl+EfpLANtSBAw8oWfeCh6UDat/0XrKUqX/usRC3mv5voXUGuX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270b:b0:474:c3b5:a8b7 with SMTP id
 m11-20020a056638270b00b00474c3b5a8b7mr68265jav.6.1711078990482; Thu, 21 Mar
 2024 20:43:10 -0700 (PDT)
Date: Thu, 21 Mar 2024 20:43:10 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069222e0614379f1f@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

