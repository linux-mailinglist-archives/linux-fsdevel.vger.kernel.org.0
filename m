Return-Path: <linux-fsdevel+bounces-12909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2620C86858B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 02:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48CB51C22753
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 01:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07BE4A31;
	Tue, 27 Feb 2024 01:09:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF623B1
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996144; cv=none; b=OY+f2l6s3qfr3XESnjbEcD1k4+EK3eqeu26ybk5p5o5HQ9eMhed09intxzqFrnpdcBRWWFBgTt59eyWasrOgrnbxg4DBNd6xJgjBDL491L44fDg/xn38N8XIymZyIfFY8Buvmpk1y/jbJPxT6k4kVe98GwHGCrqX9oG4t0QDiUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996144; c=relaxed/simple;
	bh=kzoRrXh08bElKHfj1aPeK5wEZBKK/c9vqPFeUCMIWnA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oafhKke5pJp6TLJlcoYU+tK0pU6TaZ9oux9uDCVppAOkgaAawzfr5b87i/K3ek5JGwqlFHziD3ufvy/IIawM5DkFKw4eeDEwMENSVq5Go9Y0sA2An+6378r0Tn6uhvnKv8eTMORlBsLqKLwJCaFE1chyDUJBhUF+PzjNUEcPLEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363b161279aso33896635ab.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 17:09:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708996142; x=1709600942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aktuv2KRKCqLRwq94WSyQgX3rAr6mzRgiYzRkrGsztc=;
        b=wCdMVaoc7m/rQehldJNAk13u/eTTzwoEfJysK/Fhm4xFnl2a6OobVyBh/DGRKcMA0W
         5pafK1E1PVV9Aho/uQ8BiJKnZEgeFPJFdModmBkNZV+DcLruZZ754MmxM2lBAHokZoZ2
         LWoQbcg+FPyr0niXFAslwIFIRbD1XbUP53xLHUWaJJ966A1ui6R1pzZlEwkWBTEBWWRI
         +79z07tnkM/Mw402imkwctV4SKBFkzgor6CKqVKf8ZCP564ZKd7X1iEkC6nq8rnYmapk
         lE3Lp5GDxjS3ZUU+LZvwpem0JGY5O5kzpXRT5LaX1g2rW9NLIwZOz5BcUaKpvRFmrJQh
         Og7w==
X-Forwarded-Encrypted: i=1; AJvYcCWIRTGpi+VW/7830eh+vXGfhQ+O7PXBUGPblECnu/V8IcPjhW8fqh5u/4B5bTbwtJfPgnXLSVzoZ+smDBb7qOm8FsI0sQbsVBPaLAgWhA==
X-Gm-Message-State: AOJu0Ywg2zk1i8nlTR4iRwqdkLCbTCiPMTOJBMOZuRFpc8cUGaEYp8mT
	+Pn4N0A48z6QzCEgXC9YpAH+ssx0eSAc1M9jxr6TSv3oG9iNFVRu8tj7N+JENka+hBpwa0jr3iA
	NoyWLrknCeAmRAMShoTdEOWebmb8JP9Lw1rIzMvY5xV1JD1k9QPaN+3s=
X-Google-Smtp-Source: AGHT+IE1wkVsYou1Utkg829CH1m2uRacrTIEQTXsrl5dubL6Fav7LdHQpDU/SJebyUC6BahX5BA+F53OQcjQF6i4WPT/D5AWRTlZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:358a:b0:474:96f7:a3a1 with SMTP id
 v10-20020a056638358a00b0047496f7a3a1mr45049jal.0.1708996142473; Mon, 26 Feb
 2024 17:09:02 -0800 (PST)
Date: Mon, 26 Feb 2024 17:09:02 -0800
In-Reply-To: <000000000000cc261105f10682eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fea5b1061252ab7d@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: use-after-free Read in ntfs_lookup_inode_by_name
From: syzbot <syzbot+3625b78845a725e80f61@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16ae7a30180000
start commit:   cc3c44c9fda2 Merge tag 'drm-fixes-2023-05-12' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=38526bf24c8d961b
dashboard link: https://syzkaller.appspot.com/bug?extid=3625b78845a725e80f61
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16eae776280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d273ea280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

