Return-Path: <linux-fsdevel+bounces-14028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37391876C5F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 22:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C8AB210D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 21:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532C5FB90;
	Fri,  8 Mar 2024 21:27:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA95E08D
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933226; cv=none; b=SsELzaRMvPBpxJB7YNm/iVUryvXH0vbznueA823G7nW3HehPltSR0lAbjO+44bHoOQM4bTJAxfOt7DiXBWtBLegThE1kRn3eW6lU6oTxlSFiYZ92xyw/WOqp/ocXODJDyZRatNm5eQxosTrN882B+vrVyT22q+ylQGzJKhHvKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933226; c=relaxed/simple;
	bh=u7l/U1k0b8WLPkq/O7XnXWPK2N8wgWRoVz/cbJw/lxo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWXFfWwHazlpCl7Wix+hyaV7oNvolhVTlX70eXIc+97qRnn8GjXRk9SItmWdnTKojm9f9mODK8FIoJoOeC0S3fgkc8kOgzZxZtg2K1rWGB7KMhWN7doE+sAu/7dRMm4IpP3J2DGFTzBvb/VsuGfLD6VwfQ1cvcQuA23ib/nkj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c83a903014so268307339f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 13:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709933224; x=1710538024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7u6kH6QRLYYasOKH6vti3N8lwLjnLDCzgOQh2S+Wgc=;
        b=wclnZ9DZxvpl1q8XvlbCpGp4CR3o+9hB/882QeYi3m8m6q8x17CkWpkDmThBQN6EMg
         8KYWBs1vqSR5nx839P6lqu3P+n/kFqn4C3nhTgxiQXnB/mCTykS+jCd+NHYl8lOAolBI
         RdhhWe54PXB2dLquJJuzC0aYpn6ukXK/cbu6zZDnA/DKz2u0Sw/bpu6Bq5IBR5241lAl
         7LWhI+geVr/pfKb970g141+oq3gvEOH2ANe7qAQMGWo6ZzeuReGpsDgePXPSAh4dCOgw
         prwkJKtN86XA014Ya4HiK55UurYpjjDRNqvBIH7FjqDK4Xxv31nCWahIthfc9g81JZHM
         o2tg==
X-Forwarded-Encrypted: i=1; AJvYcCXgZ2uVwXieNChT3/IzhbwJl6Erbq/AURs/b+jy9vTCOtnjKtnu7rXN0+isObSQ4bxHhayWIBH41W7pAnE4/0FClXb38XsXA516XUoGWQ==
X-Gm-Message-State: AOJu0Yxtb8BITKho23NNcYBX9To8wh+HxpXppe9D7t+x5Qur/RsAAYFU
	7Lnjva5kYEGLUDglwGR1np/N2ovXyE5XPbnKhMKHr1teqGIf1ZdOVj3ZfVTctyHPa1wKhe3QQmC
	dFG0uJ1w+nNL1bX5eRmJikXtqQcPf8rzUNNHKaqPucQITFIvywsI2vEI=
X-Google-Smtp-Source: AGHT+IGnhB6ok+UT6dhlPPsdCYDSnoJazzwrIi3u8UzfwuMhJBQqJy+kvc9v9EefH+8uxg2q+1ZBvU6SUVqi6RBl+GmY/FXaZX7d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b09:b0:474:bc7d:544b with SMTP id
 fm9-20020a0566382b0900b00474bc7d544bmr4094jab.6.1709933223590; Fri, 08 Mar
 2024 13:27:03 -0800 (PST)
Date: Fri, 08 Mar 2024 13:27:03 -0800
In-Reply-To: <0000000000006c2bbc05e714ec79@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061cc2d06132cda4f@google.com>
Subject: Re: [syzbot] [reiserfs?] WARNING in reiserfs_lookup
From: syzbot <syzbot+392ac209604cc18792e5@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1748692e180000
start commit:   9b4509495418 Merge tag 'for-6.0-rc4-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79df237bd9a0448
dashboard link: https://syzkaller.appspot.com/bug?extid=392ac209604cc18792e5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142a4277080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146950ed080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

