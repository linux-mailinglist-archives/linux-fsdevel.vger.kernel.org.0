Return-Path: <linux-fsdevel+bounces-13420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643586F919
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 04:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8940281609
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94B56117;
	Mon,  4 Mar 2024 03:53:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345733C5
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 03:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709524385; cv=none; b=IY8NCo340p/CsM5Kcgdjy768ij/Gpo6CHlmEo5X5XlXgmViZMhHsjmOXXrIgfbu7jieeYkGhDSHoZvvp9jeB9O6L/LVeO7DOjHz/KP++gMhmAGKVKKaDEb9X/wAPzw3fMd44lk0EwBQM02eK102AzMXmji5BFXatiopS2bVPU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709524385; c=relaxed/simple;
	bh=uCao/3zQohutQJFrXJ4zAEdnX96pTBSjuB8emCOtld8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i72Px0o6B7d0f9aiLpCkj9W/aoLdS7AKdGCbr7tqus97uiLUQJms3lpFwFPZZ0qUVCuLfZJ+9kIq1L/VbH6worPWX3xFx8klO4gsWv4EQXXMostiiaGeY7vTXOHhW0L2ADWn+yO6+46Be3p1qy0cFgU01S3zRJPuf4HeDasZLIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c84ad0cc57so66458339f.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Mar 2024 19:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709524383; x=1710129183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pHuPhokO987LIWAMy07DocWUyewbBZBGwrDGi0YLBU8=;
        b=PJT502JDC7u6znktruqt+equmHA58SgUNuhXWSSFy01OKixo1w9fhbr92ZoYPdt1z+
         RzFotXuf7oGMKAtO+k0eEgCaroy+Z0QcCzFHC/0MwPDsCd3lgOqrHHCNt6uBBXzw23ar
         Q3fiWhn8xNvstIRSbE7YmrDI0cRF6rJBnkDgzpBeD3XA3Y9pQ++BmaJpbcIsP6oEnBn4
         GHLp7RIZJYyj7/RhUdjmM2PwcAui8MHstGOGVnoDW+6D+vIXlCOziE5OFl7EMzRLw+Yn
         cV7Ext/Ox9oGL2Pky5c8FfbWpTUlSfAj2cgW7Ngt6i642ACfBS9VcP4Tw6ZTk2HvFqy0
         /qBA==
X-Forwarded-Encrypted: i=1; AJvYcCV60nwhvFk2+cs0DMZrFn8BLCkaLl3TLJpn6a/v1/AD14WsEt2xb7kanOdcRugVsWEGRAbhYNzzxIPvdaQ9XClVpQBHfUrzhOM0HQHR+A==
X-Gm-Message-State: AOJu0YybvCqgrXwxLFw1FssbRvYnFRNWm4lDpT0wlh38gtRPrira2cFM
	6WqXxVMV+mudNkt6XHROYBC5RcSxIoTVF+sgiQWXqsZjIjKh84D7s0pLP5b3zZvhfV1Bnbw/Kk9
	K0QHY8o0H6cJ9P6RwUsmKRzIf/52KrsXJtpzonpjNsbM4sbZCqCQn5go=
X-Google-Smtp-Source: AGHT+IF9zvXhtrwSgWUyTLSDHia5IEtUT+1Q17mqnVWSZXWM+MCcZ0pl6JK5Cu3dBEVjYHpwmsL47a2htool8caNNzxL6reCqKqu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22c4:b0:474:bc7d:544b with SMTP id
 j4-20020a05663822c400b00474bc7d544bmr226076jat.6.1709524383299; Sun, 03 Mar
 2024 19:53:03 -0800 (PST)
Date: Sun, 03 Mar 2024 19:53:03 -0800
In-Reply-To: <000000000000c4c9f105f2107386@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099ff3f0612cda952@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in jfs_readdir
From: syzbot <syzbot+f328fbf8718edb712341@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16b9e3ca180000
start commit:   2772d7df3c93 Merge tag 'riscv-for-linus-6.5-rc2' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6d0f369ef5fb88c9
dashboard link: https://syzkaller.appspot.com/bug?extid=f328fbf8718edb712341
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10233f38a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d35c1aa80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

