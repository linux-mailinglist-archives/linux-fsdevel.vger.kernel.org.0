Return-Path: <linux-fsdevel+bounces-18748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4458BBEEF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 02:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF098B20E0A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 00:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2CD15CE;
	Sun,  5 May 2024 00:35:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A077FB
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714869306; cv=none; b=fp4rlGazpPzh5HknXUYKVzNN+SJYxVYcQveYghDsci/udWzOwCTnjaJoqdAVL4YsflXdgIviSUavV6uXwPlB+syQd8VdHyR0UsfrVPYfIASDWLtVJReaEjkaqAxuZaSVYrPSZ44eoqQCxmhxQ+DHAEt8x/2Uj5P/ZhFYB6o1OeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714869306; c=relaxed/simple;
	bh=3lWAJAfUZvClkbre3n9Mn5LFR4Th6NocSJxukhF+bcc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aVEzkGPM7Rrue732ZXxCzPsm9bsozO4ui6w3C9xnKO0bAb5D9KxdfJhWNLHFoiKIr5CLCyRYU09q2IB2Id8tFAB37rFs290R6hBib2FbdK7v7ck/CVDFPdF1NWBtcY1y/omGhjn5PtEaC/YCE/7nT+Gepxa2BVLP/6UYXPpTKHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da41c44e78so94067839f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 May 2024 17:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714869304; x=1715474104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQCgYFbXCI7Q2niaNhE+aI9odULkuIJr2iIWjifovcE=;
        b=nmoz9CRi0FNfUIsG9svgLNr8TlTlivFHt6nvb+W8Ieqb1pXhlMBhMQ+JXwm9nwxD0J
         i/mGnP+uPSxS4rDFEUD9Trm0o6U5W2LPHRNMcubEyqfkCAGyWalxyZsx5xIsazF4nZR9
         pFMzwZrFB9zyMg5wbum27URM7F7knXJ4ld36UFwqv2H8NPMbNDfwecmQEXMrwEvY3jfB
         URZnVn/vMaMmJqv0SrcPB/Yfox1nKZrKJ7J2EJuFEsDu5yxlvG4a32FCp70qaPhAUoSv
         JhD/9t7q7cgH72ghTSHVYnoap5irNpWnsjzLzsBTMRDT59xuYr6UbdFkjh1UT5UfdQDj
         NFDA==
X-Forwarded-Encrypted: i=1; AJvYcCX3m+rjxs0NkOWrvG7BNXhMmc1KCiw8+FNR/PWlec1P35IjOW+KTz0QMMd1gPzcZV3K9Ssrp0Qn4bQHsgZRM2YQ07UyH6RUzCKwgLK67w==
X-Gm-Message-State: AOJu0YzOpwXamqVSaCHrqlynyV01JDzPaHXfa4Gj6RgQhGmxrKTlEbAi
	zuKIQ+0Jsn7M3YUbnUBSrmt83aV2qfr5nxxRzlXWTlSFHmYIO3+QhnBpVh+5zEzw11Wlh0WSktB
	MQQzx3fg9XKiWS2Y8sHuGpDLav9fErsxFHShQwRsyKwSDVkD7P3ZXsVQ=
X-Google-Smtp-Source: AGHT+IGh+xKJ+7qu7/Kpc0kJl8tdSzMHzURQUBwlqmWGnbvGT87sd1no6wsbnRY27qj6vprI8ShhDr4RJxAvf8ptQ+TdM8P9qgTW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:614b:b0:487:cd4:4bda with SMTP id
 ez11-20020a056638614b00b004870cd44bdamr247216jab.4.1714869304673; Sat, 04 May
 2024 17:35:04 -0700 (PDT)
Date: Sat, 04 May 2024 17:35:04 -0700
In-Reply-To: <0000000000003392c606179ddd1a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdedb60617aa1f12@google.com>
Subject: Re: [syzbot] [bcachefs] KASAN: use-after-free Read in scatterwalk_copychunks
From: syzbot <syzbot+8c4acf719c3fc41e8439@syzkaller.appspotmail.com>
To: bfoster@redhat.com, davem@davemloft.net, herbert@gondor.apana.org.au, 
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit dc6f2eb000d76ac8f93f4d59a8012ddfccca927a
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Wed Apr 17 05:26:02 2024 +0000

    bcachefs: make btree read errors silent during scan

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16629450980000
start commit:   9221b2819b8a Add linux-next specific files for 20240503
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15629450980000
console output: https://syzkaller.appspot.com/x/log.txt?x=11629450980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ab537f51a6a0d98
dashboard link: https://syzkaller.appspot.com/bug?extid=8c4acf719c3fc41e8439
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111abc97180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10059004980000

Reported-by: syzbot+8c4acf719c3fc41e8439@syzkaller.appspotmail.com
Fixes: dc6f2eb000d7 ("bcachefs: make btree read errors silent during scan")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

