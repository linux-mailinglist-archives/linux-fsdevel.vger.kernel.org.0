Return-Path: <linux-fsdevel+bounces-12943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A062868F6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 12:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2421C22BDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFE613A250;
	Tue, 27 Feb 2024 11:50:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528313959D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034606; cv=none; b=oeAqh+fDTfFzNQYT35WJHyMA1B0k5wX4b5H/9JjmFLA27FDdL0ih5LFfYvNDjLts+NocKmhUtFOBvhPfunWKqow5Y0H+i0R2LpcoPHMK39EemSlw0CVL3qbjLJlmXLUcmXBzYm9jrUpkl3zFUuywBUmgBdvgdCq4fWyy5AtEl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034606; c=relaxed/simple;
	bh=d31DUdbEAP3glDQzF+uAueVXLU8enodsFh7WNYdtTsg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NAOLLcjxBAg0RlNgHjUnxMU7FK6Ha2sbrBpCLR19QHFpxfPhe6A/UaQ3h9DDqK3I2TkSmgV5UzOb/RcEglMYxvQcCv+kQjX1VrrTZkPvJan50NG0+t1wLn3S+4IODvG7h1ag7VhcfPDI2Ooqg6FFxwAqJzMDgDCRL1YDXVPMr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3653311922eso33647395ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 03:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709034604; x=1709639404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tH203RrzLyAOiwyFP5B31fo86XWdWzsP+OL8gKwsz6A=;
        b=kYSU9G5PTI1XtdJCZJskDzdFg1w0jeVPACoGIWEYyg5tdpV2tjKVI54jetrn35XpLX
         h8TLsc79o7E2zEDvKggzHv2agksgLoU8tTNjFN7eHm4kF3WHT0oTxxmucim2LoSf855K
         KWA9txXRduBGF+9EQSmDEfQ0SToFQOKoh2SiW0B++IU0szs7znsoNLgnobwYhikxlG3W
         ubYaSWA0DHCPjJ2vpUoSurfv7OaA1P87j11nQ7n2xTtguG/q3zZbvOTEOmR/ACz/lOkl
         +uzFvmK6oJBrbqnqwurHFLyyWvk+PGt+8lFLB1bkuU8PKe8UCAPBvAqz5l6paHcAi1R1
         lgyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHFzzTAUFlsuT/oqsUTYXz91df+y3Aq5627euIlayDahxOwVp3lISCluU0AgRRGJtu4jnHX4g/oxcBQEcz05uH3hADpDst9FmyWQVxiw==
X-Gm-Message-State: AOJu0Yw9nfV56sqBuqcy1m8D6PmFLtwS7A25tURyI6K4hJ+cVv9txrd1
	W8jfRcCYLN2DnuFMtAdFI2XABBM9+HU65PuAT6yqxiEduu1FfxHjU2qcT4/SsNndgBQdjFJpzr0
	FAZVWGxezgOB59bJjaObYa3ggDW/u9h5fMAR4lsJ1yWdeMPwTUZurLLc=
X-Google-Smtp-Source: AGHT+IErUXetTcqvT7hKSEl4qfD4Oi1EaI+bTCZF6SZx92+OOHC9FGESt/LzHWLlFekaHASkBANwL4udJotYzCs33lO7v8FCTsQL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:365:21f4:7030 with SMTP id
 a8-20020a056e02180800b0036521f47030mr743713ilv.4.1709034604595; Tue, 27 Feb
 2024 03:50:04 -0800 (PST)
Date: Tue, 27 Feb 2024 03:50:04 -0800
In-Reply-To: <0000000000009146bb05f71b03a0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008414ba06125ba07f@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in ntfs_read_folio
From: syzbot <syzbot+d3cd38158cd7c8d1432c@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a70f4a180000
start commit:   ac865f00af29 Merge tag 'pci-v6.7-fixes-2' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=655f8abe9fe69b3b
dashboard link: https://syzkaller.appspot.com/bug?extid=d3cd38158cd7c8d1432c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12769ba5e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c2b97ee80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

