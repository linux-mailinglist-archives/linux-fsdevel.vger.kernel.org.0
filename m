Return-Path: <linux-fsdevel+bounces-52743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4A6AE62A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFDA2188F874
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7819128466F;
	Tue, 24 Jun 2025 10:39:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34F31F7580
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750761545; cv=none; b=aRsRIQ6R7fGcN48zxgkIwr3xfwJawVgfBVBCTH3NTXYxAPrLvwocYBTI1Yh56K9YsCfuJlWj8l/Ur60GxmWLixZhXQ5cCWkQd8Ivdwh3m+/ibBSMs/Gut/i7TvMDfEIs2X8+nb/f8ycgYioTvcFv1apDirUl6zerwZ9NLGlQKIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750761545; c=relaxed/simple;
	bh=rphr/gilBmabSnM/0Q4jGkDtLiIwETrDvS3TjqvQIHY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HP5DNN7nWfdn0VL2Ke7xYV6H6EKGNOZWdoIIPEaa/z9GJ0nT+/wUyu4XfAK84v2lEPocSRvAsOuNPaHlOKVysnCQOfSyNBF/F83TY4Hg7kTvuio4fRTNy7zN2Ht5PIGOKRd4ENr9R5+QZVN/WR8wB6G1NA3cnGWN8kFy2SRpRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddcfea00afso71162315ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 03:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750761543; x=1751366343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZjChxfo2lLHHAf18M6IBygpThdOnehCGj0MYdl6w0bw=;
        b=bKuqGv0tKx7Kvgj8+ukFoQo2car6r4Ds0GAZovKiHGVZMwvWfta4zZWXtsrrBnx+uC
         ZC6Vq3Of1rB7gScp0pk9W9Rb892ESKsvSDDGeLOizxcNyhV8c98KQ4SoNdxOaR+n9Q54
         r0NDiCFec2xbNIQ9OGKwZci3TO82MnicbQOmJSVCZVRDw819vlZr/mlu9JcxPCTd8ikI
         zFllOVYn+B9uSRY8IqikvklcG52JbCLa6lvLX1CcyWsNVHkBym0Iy4wWegTEDOMD538j
         rKk4wLl44BQ68qG789PEDzmQw/NNjDeUlDktltyoRWceKkGNit3/Y2silhsBvyieNvvY
         OY5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWZvdqkZ8GYWQovwUfgljhOZ3of6tPekHe7Ss0M9RZxBYukyTGtWqj2XxtAoiCTZUu7t62lzBXaF7yCo2O@vger.kernel.org
X-Gm-Message-State: AOJu0YyTWTmzhrUHfwaZPCZ9Mqjo9C6TSKNYfYWXeTLZxhwsUT5iUBQr
	5/2FDJBlX1tSTRbeHCikxAILU82P9UOjrV/nmfh61iCA+BEa+o3x9i980rbWz5U5vV4kTyJf479
	3wEW8dxbdRoxTtz9SUvbZW8m9wBbEU51Fd0eHSjzFSlLn/7WMZBo7ZkYnRhs=
X-Google-Smtp-Source: AGHT+IF1eR/bCiL7c/5fmlVP0t+h/SiOMoFpxFMZgFZNbDEKfJ/tzbqYYQXTjR9fnUkdsVKbb8YfnAA9F8qDtQMSM/rK0Q1DUhcI
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:3dd:d348:715a with SMTP id
 e9e14a558f8ab-3de38c31ab0mr184528235ab.8.1750761542883; Tue, 24 Jun 2025
 03:39:02 -0700 (PDT)
Date: Tue, 24 Jun 2025 03:39:02 -0700
In-Reply-To: <20250624-volldampf-brotscheiben-70bed5ac4dba@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685a8046.a00a0220.2e5631.006b.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in pidfs_free_pid
From: syzbot <syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com
Tested-by: syzbot+25317a459958aec47bfa@syzkaller.appspotmail.com

Tested on:

commit:         f077638b pidfs: fix pidfs_free_pid()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.17.pidfs
console output: https://syzkaller.appspot.com/x/log.txt?x=13dce70c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a936e3316f9e2dc
dashboard link: https://syzkaller.appspot.com/bug?extid=25317a459958aec47bfa
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

