Return-Path: <linux-fsdevel+bounces-13970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFD6875CD6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 04:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9161C20BD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 03:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E0A2C69F;
	Fri,  8 Mar 2024 03:42:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8219A28DD8
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709869339; cv=none; b=X1CyVp9FCVOXD0njsITXKUFMXHQtvoyBFAqIpErVLLDs68YGUq+nu6qVbPS19Z8lcxnA58d/eKOptVpR15ISKOn+CECW3ZqrQA72cQElOeqYhM4XGXgt5MW0+SulpBWyubLXoC34cFQUQOp9UkpbBbo41gPpnoYQP0T8LcqDCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709869339; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MGxjMm1AOrhYM/scmnm4W5ECPlTQTtFvUQj1oRzaAjYqxHqEoZZDvmi8dsfKGIgEJxOvfO8lnPTaVJwaldMUkEIcwLwLAYovPOw30hnFeAJ4InAetjqVCya8IfJS3ex13c6zNNSBxN0znwizsV1mY3Y0p7f8kItRdjIQArjlv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8414a39b7so120386539f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Mar 2024 19:42:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709869337; x=1710474137;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=EEVySIT28ncwEjU3M+ySNE7hkMLe+WpCo6mBsC9qRj6x8qaHgMHsYsMGewBRO7G143
         6M2Oo9PWxYctE0AGzPMt26SfKRDJSfNKAFrKRq2npWin6uIVYdOY33yCo2LqVTUH5qCV
         p4S4hAopJxZejBJvci+/I7MqnAAkZ4bH+gVox3q+trDsB1MLaWNb4SM+faLhT4CXO9h/
         Y09kV7OM1a4HaeLx94tKJxmW3BwCE30zxH1QUqQlGY9mvZQD6aR5nzEs3ERAwPm37TwE
         L67fy7LDRHrsLXkLHksVslQkOgSOsdVEAF3kA3x0A0HgFqaP5WTuYfSaUEUPIwyU+XQD
         BLiA==
X-Forwarded-Encrypted: i=1; AJvYcCV5d9wMAe2A4FuIUjSZHXD/5rkfFk9yab+SssYzSp2Lp3bz7nxOxux09pUv2Vsq0MIe63zprJXCKEpHusyJhi4gLQXXbDNGGTQKXqwo+g==
X-Gm-Message-State: AOJu0YzuSKwmw9WtsvikJoknfyT/ZHKu2q+1R7n/mb/L/KNrkjWXUpRI
	3bd/tn2wMb5cAiZ8Z99X6uJLqvunIdEMPQtj9wr7FLze3tHlKhhOTt9IIDCnXFcXY3uB/t89MbT
	getIOJKiRcKiuvQ+cympn/sSm+6BbC2AXUV3Iwl4J+WGmFkU5D27JvZU=
X-Google-Smtp-Source: AGHT+IEfm4T3ox+Arg1FX0HDoKBf8GotmyyS9mYWuGNzH8O8IDART7Br5RhAcWTaqRvmJbP+PX/UzLeeC2tHO2MZ9l1ucsbwX/bl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b18:b0:476:b3e5:4392 with SMTP id
 fm24-20020a0566382b1800b00476b3e54392mr150721jab.2.1709869337792; Thu, 07 Mar
 2024 19:42:17 -0800 (PST)
Date: Thu, 07 Mar 2024 19:42:17 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007de36306131dfa42@google.com>
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

