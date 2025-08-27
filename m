Return-Path: <linux-fsdevel+bounces-59353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 194A0B37F4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 11:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53D25E44F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F952F9992;
	Wed, 27 Aug 2025 09:54:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB781C860B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756288446; cv=none; b=oMbYKA8oAWB27YxtG+yDs81NSkb52q6i/uY8NaGfPRhzfOVQj8Bczri+NsEooD56p5Xp1Ytoy5+CdKvnK5E1W+KTpiuhBaOd8vYC0KuwPm+s5f/C96bRDtmwpw7PU8JwAdvASMQ6msda+j9ast8x8pn6XLPIvJfSE93paXdu6a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756288446; c=relaxed/simple;
	bh=Ko6gcXoLS2/amIpOn2k/AyCL4mrqcDn05q+8UBn9azA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=utt1gvDP5brjRYqX4FN+Tr331nOmo/d8FnVsGf4Ia4FjwxgaMBpBLOz6NIwmQT1MG2lVcfrqk11hEzT3zpHSMkkOhrCdWGNzC6IgS/q0TUzKJMdTHdjx1+hmc96PgxGLoL5iiKjp7zfLJiUAM1AE2N+Tr8ir4AduWZG+Mo9/kLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-88428cc6d2fso107936739f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 02:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756288444; x=1756893244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKPh2SlwChQU7ZuhqgSBc2ks3+rkl2HA2Luen55P8zY=;
        b=Qukvy1bwbFR6bFZwl1Qr52cKZRvf6urSfYinNLk7AOyR4EDP7KQwQ1AAmwRn08ZVXM
         PZwVJJZI3IWw5KeoVq4iuaeKgsS/rABALCL+iSfd6Pgqfl/n/DLj97FUVjHwALWZW1Tp
         FhQsKtgSUnKD8RF7uOnDS2tGMT8hd9wgmmkG4lVRe9rcyCA+p7yeM95NU1sDSnU+CoQg
         MWTnM4cnyvLHnfQS7QhSesf60z98SKZiNXqmAsjmhih4M5WvNKICXW/lQEe64ct0n4bx
         XoILt8nr0+Ocj9L5mXKO/aA/c1ufCaJ3fxvK+EzbNssAPww0Nwkgc2MBEVDKyWWU6C6D
         6s6A==
X-Forwarded-Encrypted: i=1; AJvYcCVvwkPZWiYESBYfE5vHGlG/XDWzbk2GsUxS3trDTfZvPp89Gu9DiQK3CQEX9Lk3rHdj28oCQKkmIs73pIlo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvbu2DqngOCtb0fPxa5BROllphVNZOcTiwYg8i9jsB2BC/6tRi
	ekFiQkMLS3G2AQBC1crHTSgMFD0365+bzkBlUHJOPe0TUhLAw2LIQq6ef0L62+X4eThrMn5VO2n
	6Q0GhSfKAG/vlXsR4yB/yMj1IXrYBFr/AaWhC2RuQhIE+EY/ZekW5yY54ijA=
X-Google-Smtp-Source: AGHT+IH1Z5+3ewdHv4H31Zk3rHJWNDr6CeSPjZ186XygBcvPL23EUJogL1/i7XZi25NZKNDtAlftkUoLFlwH9fRMk+UBKfnXWIUU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ce82:0:b0:3ef:d63b:2722 with SMTP id
 e9e14a558f8ab-3efd63b28e6mr31092225ab.8.1756288443979; Wed, 27 Aug 2025
 02:54:03 -0700 (PDT)
Date: Wed, 27 Aug 2025 02:54:03 -0700
In-Reply-To: <68811963.050a0220.248954.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68aed5bb.a70a0220.3cafd4.0019.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KASAN: out-of-bounds Read in hfs_bnode_move
From: syzbot <syzbot+41ba9c82bce8d7101765@syzkaller.appspotmail.com>
To: eadavis@qq.com, frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lizhi.xu@windriver.com, slava.dubeyko@ibm.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 736a0516a16268995f4898eded49bfef077af709
Author: Viacheslav Dubeyko <slava@dubeyko.com>
Date:   Thu Jul 10 21:36:57 2025 +0000

    hfs: fix general protection fault in hfs_find_init()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1519c634580000
start commit:   01a412d06bc5 Merge tag 'pull-ufs-fix' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=859f36d9ccbeaa3e
dashboard link: https://syzkaller.appspot.com/bug?extid=41ba9c82bce8d7101765
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15611b82580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117cff22580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: hfs: fix general protection fault in hfs_find_init()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

