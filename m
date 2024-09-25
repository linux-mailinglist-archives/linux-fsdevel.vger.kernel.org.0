Return-Path: <linux-fsdevel+bounces-30036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8582985423
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 09:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D3C1C23341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 07:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01B8176259;
	Wed, 25 Sep 2024 07:24:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BF15D5CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249044; cv=none; b=XVvboijQqy/vGZkFDX1t4zoe/XCAyISk4Qu+M26jlI74guPmNXs1r18c3i8UmS568XoPe9eL3a08TvX5vPYdqXszntTTuTRfjn50Nqy0FCscKamtmpY2OtG8CBsaYsvQrBRZ9IecpME5ISPrhDsFyoegGRjzXovuD1m2EyzYEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249044; c=relaxed/simple;
	bh=cwBW1nZexvrkSpRRMNUvQRu4cEa3POxXfYqsqy+WG5U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F/WTj6CblaiM2kMvwu7QleL2Bl48frWkk87xuSuMy1nj/repcv3uoYwSqzaMQ8eZjuErtbYPo9d9sVo4nsX0MsW4CTl9yDdE/Qay/19hX/osITRZWgMe0Dw5jb+a7KaI0zAoMgFaO/3gjLJ9A1Itme81KLIxHq4faTMGKdfOwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cd682f1d2so987796339f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 00:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727249042; x=1727853842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/A3o4UVQs5NAn318rkcVw0SNvHvy2CSk8QVGSxPhsQ=;
        b=ZaVE1WTxVhEiauV6RrxfZ2W3axmjY+1BrVun12pg4N847UJWNGdt0xVdrnMotIQhme
         cO4i/LERYlmHYwuMqxdi6MHzw4Nbck3TOEJ8lVv98gfcE1M/AAPxquwHElXj2RWAQqPA
         aItpJrZeZeFK/N9SEXMCdcpoEmMiStW/Duk5d8Ie/O9X/Yjp8pn00WCcgFr9HuE/uRuk
         VsAtB8iDHWp8CGCvyv2TSU0erWWjwBCIx+zmK2tiwO6CrJDTt2mwhrzsAeyAV396Fxbt
         Q5wcPtBwIG9J+Ts4xcSp6pfbNOKQMYvWT1axrVFXCb2/b+YK3Yu6Fc78DAfM7B3rlQAG
         zHSA==
X-Forwarded-Encrypted: i=1; AJvYcCVsi0hGmf0L5mRQyCwQroTj9f6ls6egNHiLXoTSQVsaRQYC2VSSXdEg7WyrwaSHz6ObiRciMe8tiDc1/KP3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NHQssMY8jPlPxwmuXQbuYnd3xcVEvsI3wr861ePWPVvayzR1
	3RHK/BXAj+VKJuEliU3POkDdfCWFpsIEFWSSO8pmqHZMtloP+VvOGCUUvCjpBFkrJo8qLiHjoAA
	KjOksOalED5KIHTcwyomPHUxjRMlXKW+ldyzbjBIdqQsqo1Kybc+EuIc=
X-Google-Smtp-Source: AGHT+IEPpJLOMCaCb92K68J/cy1pD5OdA22rcpbcvYEB5cQSsPAy9r/VXZbw5kMVeJw+fKgDc5Tgm4uxiRh5RTa1mGOndjSeboQb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1566:b0:3a1:a179:bb54 with SMTP id
 e9e14a558f8ab-3a26d5e8bf2mr23514285ab.0.1727249041866; Wed, 25 Sep 2024
 00:24:01 -0700 (PDT)
Date: Wed, 25 Sep 2024 00:24:01 -0700
In-Reply-To: <000000000000dbda9806203851ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f3ba91.050a0220.30ac7d.0010.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
From: syzbot <syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com>
To: brauner@kernel.org, eadavis@qq.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d97de0d017cde0d442c3d144b4f969f43064cc0f
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Tue Aug 13 01:31:25 2024 +0000

    bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147a0989980000
start commit:   2004cef11ea0 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=167a0989980000
console output: https://syzkaller.appspot.com/x/log.txt?x=127a0989980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38d475ce6711b8b4
dashboard link: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171f769f980000

Reported-by: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Fixes: d97de0d017cd ("bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

