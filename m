Return-Path: <linux-fsdevel+bounces-36169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCE59DEDC6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 01:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB1BE163C9E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 00:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305FC17BD9;
	Sat, 30 Nov 2024 00:21:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710558821
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 Nov 2024 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732926064; cv=none; b=k5m52ZYad8oQxuanShFtueDKZvqGFTXWQaqj/ztF4U4TlGeTpcP6t4Jf/hn42deJXjUDsJK8e9qcLAJT1nrjpZx3BSTaS8I3ZunmFmPnmRpaDCS5yrxst+1Jx2BkWhugvvB9yXLNwd93yK/XYTT69fqsTwpQS3o56JAbSvcV0PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732926064; c=relaxed/simple;
	bh=0EV1a/PEqgBijVEwNPL6KCylvy2Zu2KPS5sJdNJ8kBQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=C2FVUByXlAZ2tvLN47+KDBNjCSvfqxkhLnvvweg2GkAJ/hzP0u7TO2knwaF/LSw1xOoReNWp9dk8WR5WWDStY857t1n+iwO7L/BLiyCpLFkS+gW3riMyQ61qqHucv1Y6EGE+Bg1UhJqYYzlxnjRC/Fj48bvbrjzJQ3mB+/y8VTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so22194935ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 16:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732926062; x=1733530862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVfJflQw+zqDYWm6LdH2mWrvKmzl57FI/2or0aBkVqE=;
        b=iD+NbL+Ru923jAmle6K61O3nzLPFvICazLNnXxYaxu008zHy3x9DNg2o+uQxXA4aaA
         vZ5rVLywwMJ7vkpuijaEuo856oOMqAQJeSPrdfM2Ba3nr+WbMdNEMp+Tyv0DY8k+GGSJ
         GDN/Jy0pV/G7AluVvEHjf+Fv+vYEBG0p3U2EIvPJvKea/rXKdveu4NR5qMrDAfjM7JV0
         700aiNLx7dFRIOuMi6IFxft8SRMZzSiA0rWAVCu233Rm31Ird70fBRnd8rZB7pFdbfrA
         3+oOcUuWOHUiNhUiXiAA5r1Qoqx3sr7K5uIKejqbscRyukgSq1kPxNaDFsNSP6b15OvE
         JS+g==
X-Forwarded-Encrypted: i=1; AJvYcCUkmAMS0xLKi0rV5jXr/PTPlj2vWEWVJU4U5L+Cy/H2WgMPqsf/DvGCghl1lF84nTfLhceMsfpOlyNztKe1@vger.kernel.org
X-Gm-Message-State: AOJu0YwQYmsfeCr3sEkSrQcXXvgXRTTRVrQ5GLBf+GtB3mvc4lF56JLl
	K6kkl80k377E+4yab8wHzCZxARMuHAaPHaO20IfaNbQD3ix0PHlM9GAlvxh+8pmChKuP9uIZ+o8
	SxFB/hY5CvQWZFPWY0YQHcMLMF82OESxudQANRPEJ4eBNiwVyLJZfov4=
X-Google-Smtp-Source: AGHT+IFVKCt77VV9eIgoBFjrQ5FGd4u7RB7QruWUYFiSaKsKMQCsCEdI8hJAH/havveNDzJ2pYVF2QA5tIzx5GFl6ti8PZAgyMCD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaf:b0:3a7:2b14:add8 with SMTP id
 e9e14a558f8ab-3a7c55da135mr159559955ab.18.1732926062688; Fri, 29 Nov 2024
 16:21:02 -0800 (PST)
Date: Fri, 29 Nov 2024 16:21:02 -0800
In-Reply-To: <66ed861b.050a0220.2abe4d.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674a5a6e.050a0220.253251.00d3.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
From: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	netfs@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 3b97c3652d9128ab7f8c9b8adec6108611fdb153
Author: Joanne Koong <joannelkoong@gmail.com>
Date:   Thu Oct 24 17:18:08 2024 +0000

    fuse: convert direct io to use folios

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1033bf5f980000
start commit:   b86545e02e8c Merge tag 'acpi-6.13-rc1-2' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1233bf5f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1433bf5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f0b9d4913852126
dashboard link: https://syzkaller.appspot.com/bug?extid=2625ce08c2659fb9961a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14534f78580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c3d3c0580000

Reported-by: syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com
Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

