Return-Path: <linux-fsdevel+bounces-72919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA30D05436
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 18:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04A3A300E410
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213D2E8B6B;
	Thu,  8 Jan 2026 17:58:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BCF2E8897
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895084; cv=none; b=B+wGvCC3hGirdWy1/tTRefeiY8wr3iPqEhHiVsxXq/yjiojzBYBp/fxvxOOYhhACDQ3FMy9ssUepMesIRI8Ic6ftmD90oL4p22h3s8QBcdfMMPK4dtdOONBCo4Cp+Tqw6uoIEi6HPiSvHmCxya1+wvMFSqU5ZNO14Ykt59nLSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895084; c=relaxed/simple;
	bh=AtAyN8z5MiOe5mY9mignREfScilYh6pRyrOw/5zkAAk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eILsT8F9tN59Vir+II6mU2mpZQuFGc+sBJ5LbXCavpA2yuodNiSi7CJ/i7N7Gf3sxa8WtaTSopcE2xasV2XfwRmGpbYRooJj2Va+HwiEdE3Bl9cbK1IIeR/RDBuMgeTFNAhXhtl2N0nYdF6BUDT03nErKNFzfH6locOEEIIXGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c76977192eso15236595a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jan 2026 09:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767895082; x=1768499882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsK1d1b3OnJto0j3Hr6e1Vwdl4/xT91WzPc9I85VXsc=;
        b=I++rwFaArqFOUdxbC+OJZb5Ev7dcHlhu7CrEo9WfWZbM4S5Vitk1ZnTh4HGVmcxEDz
         m7fnANi1kCygvAlW7R8LNycruwU68pVX0SH71XdngyhzdKZL2TCBU7kHjmsEATko8eTg
         xytiYHP5VhMhuX5ztqonVTa+e32orvrXYOq0s8VN7S1ZcJ4uTVZqL0IgM3ZZbM0Dlpcf
         jj52Qx2a//6YQKmF6ZeY2Q2LIs3kW8r6A6tVextdLfjxYJ+RDUO0q4BjmfNidXsTS9QM
         QFXRPL2ulsZYY4juox9RtleAoLpYH5DJqqmD4zKqLy+J/X51jEp7YYd4OyKCkD+b8nVE
         wSRw==
X-Forwarded-Encrypted: i=1; AJvYcCXJC8hEHH3UN0L/JLLmBuRGFlVZCt6HrF2rLTRwRlzySmA/iAj47xNeu2f+NSemIwd1bpO0b3495a1xCRW4@vger.kernel.org
X-Gm-Message-State: AOJu0YzaRwWcn6c97M0aO6w+WdBev10xQ4/pSWqZg/RAtcr3H12BiEwM
	onAAu/7JLzOiiW91//xKs6uWb8q3iVMe7pCKjyBLW5Qd5twt2bVWsHjtZucf4L5MAFw4uJXXjro
	4VKbrD57qFRuFfIumXw70tlyfLUeKHyKRvNi628XfGjHGcTUPR/SbskBFyPA=
X-Google-Smtp-Source: AGHT+IE7WIW1xazUt4rVJympDUE1yZdiUzcNBRMKdZ+uDTpKAXQw58VGPbdA+zFVeXdjFd5ZMom/3N2pOZS3cb6q03LM2Ac1yqsL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:d8d3:0:b0:65b:3249:dfc7 with SMTP id
 006d021491bc7-65f550ca5e1mr2256890eaf.83.1767895082294; Thu, 08 Jan 2026
 09:58:02 -0800 (PST)
Date: Thu, 08 Jan 2026 09:58:02 -0800
In-Reply-To: <20260108173211.248566-1-activprithvi@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695ff02a.050a0220.1c677c.03a4.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in __configfs_open_file
From: syzbot <syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com>
To: activprithvi@gmail.com, hch@lst.de, jlbec@evilplan.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com
Tested-by: syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com

Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=101c119a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e854293d7f44b5a5
dashboard link: https://syzkaller.appspot.com/bug?extid=f6e8174215573a84b797
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11859f92580000

Note: testing is done by a robot and is best-effort only.

