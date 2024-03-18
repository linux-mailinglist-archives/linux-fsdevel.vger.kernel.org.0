Return-Path: <linux-fsdevel+bounces-14774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47D87F252
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 22:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78051C211CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 21:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9275917C;
	Mon, 18 Mar 2024 21:38:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C465A792
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797884; cv=none; b=L+kUvdgojlGVI0eHiPlyFny/Qmn5bsSeD97p7x9gxz1MPNfs/euFAy/DuMxkikLgk4b7v7nTcvdNvIZ9xAu/K6HwdUQDUgLwyojWukUp6wxfD7m3fZu2/gjD8TL0KGSqB50gQcIjCdVte1/OBx7aVK3I9gujhdE7+3IvPYMxgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797884; c=relaxed/simple;
	bh=O4umbVjFHYUDfEMizAn5kUkkWDtKLtGnkvI7A/r4rMg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RMBxrN34flvvXrb/iQXz8uO3Y1Fg53YxWdnWQ+xul2T6Z9fnpPAMj90MXrW0+0bEndMxCDbF7tggf5shz+filLWaj2s8QhQzQPlkkRJ6sswYc8ZR7p4GgTX2kriBt2wWRSyH8b8Me0wjtYpP2Ww0hE1lWLWQA1kYKKijGEETlmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc0a422d43so248790039f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 14:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710797882; x=1711402682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GJmAzOZTchuP4uA1qhK5Bek7hETqC3bRqV9ZUNXqqkg=;
        b=YlVAiSs2JYRjGBgxXuGlbgEUubodRtYj+iE1OWzjXis1l+/fmB9AJ5UJmEg+QtKvvS
         oqbe2DAlDfc+0fcOQh2sTvrA23c6IHMeQ5Wz6msTllhCFeseCRNFNOoU0SdrvMn88CPJ
         TYqWoR7Yhtmp9rl1Ssq3Nnl5xEK1ej38CEwh1Q580gPrTTfsJyb3k71CeKh2tR6RV5QH
         4o3zA6Pebm0pmm4JWV+Gs/uEh23uQlkoFXUvlZO7MFDecVtozYbhdI5vr8bKnMV5GxUw
         kTTqH+bKBnoYgG70uz2g8/wVtAhmD5ztGZHwvpR88x2nF75vxKZD967ewsnHMfINjnoX
         ekUw==
X-Forwarded-Encrypted: i=1; AJvYcCV5UEMmMvm8u4uGi0vN0b7f7lnoGbLFHf9REuXKkfobQqE6fNMWudc2tAZ9Fd36baFWBfA8IxDTY2QIuEvtSZzd4B5QA8gu6twQNZkEYQ==
X-Gm-Message-State: AOJu0YzhOH5MWhZ5W7IwXliOKRb3DpwT/yJA0YqGXUdUmVS29lNgTXe7
	DSkUr/d0POl52H75/ZOeRYa6mlXmnSpjBcYU966jpG1f/6L+RSd+m1egJ20uO2nDsWcshZoGiP0
	aqkoiV46wml//PN7neKHsSGxZFibFHT87Kp7TNGyd9zkAWp9qhHjbvlY=
X-Google-Smtp-Source: AGHT+IEE0bl1tT2EzGs5vApz2wZu53dx4QAXfi7kjhMEVBTjBAHVikJmo68tYp6WxIDBl91ZI6pdnd0yhhgF/4otTEnc3TJgJEZQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1656:b0:7cc:76d0:cc1f with SMTP id
 y22-20020a056602165600b007cc76d0cc1fmr25629iow.4.1710797882097; Mon, 18 Mar
 2024 14:38:02 -0700 (PDT)
Date: Mon, 18 Mar 2024 14:38:02 -0700
In-Reply-To: <B6E22992-FF45-44E3-8FBE-D157BED7B922@posteo.net>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b942f0613f62cdf@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in v9fs_evict_inode
From: syzbot <syzbot+eb83fe1cce5833cd66a0@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, charmitro@posteo.net, ericvh@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux_oss@crudebyte.com, lucho@ionkov.net, syzkaller-bugs@googlegroups.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/9p/vfs_inode.c
patch: **** unexpected end of file in patch



Tested on:

commit:         bf3a69c6 Merge tag 'for-linus-6.9-ofs1' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=48bb382b96e7eda7
dashboard link: https://syzkaller.appspot.com/bug?extid=eb83fe1cce5833cd66a0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160cdef1180000


