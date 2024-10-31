Return-Path: <linux-fsdevel+bounces-33350-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343B9B7BD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 14:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C7E2823A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Oct 2024 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DCA19F119;
	Thu, 31 Oct 2024 13:38:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6707119D89D
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 13:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730381885; cv=none; b=psyZIy2nJV5OkCoohmdNCeJA8wdNzqoBrEeqAIWuXsLUF2CwsXoim5zF6gsirqwLLfs34gzcJrRTVsiH6tXrdm20axsluC9xljGklJrPmEo5sJ+FLJl7DonHMm06sjuYaB+aos9ByG+AuE5jCGXFBSD5CfKPliHNjbdr3GPzkFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730381885; c=relaxed/simple;
	bh=m8js9PKWrGpGx/94c0m/t/kG4l17mJ472kJ3T9476rQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HHaCC1Gly4T1CCShFaBiFPsxRM1vX6iosneAiLXRl8N6QzePe9+UsLyMrPnP13NEWlmnmgc+JDJnRoWMCCzbmNf5qLr6++pmie4MH5GMUSAh7iknnbe3lF4q7alNKXtcfSagIsXT9mxZPLNHG4Z0A166zjskYzqvyRI1xKt9ErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aa904b231so82291539f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 06:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730381882; x=1730986682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2wb21YsWwCYTNPoCuhRPi219SLTEoWZUiwx8XtsEeA=;
        b=sXBPiGSGETJn+GMnXOgwsJVqB62wh8wQZ7HozLy6AzLVUc3tYnmrjHHjqnkFV7Vpcw
         Lv/acRazwOtjjTA7yctuAfqugWV5h2p7AHTuW0KfJcHCcvFG15vVBthy45dny63rir3x
         YxsjvYdNu6Ik3+1K8BsWWM3pJuPAYY99LHDYnK+HybhDjzLtxrOZvWR6KEulPWils79V
         3Mf3EKkSmgJMc4Mo1xRsNzDtHhu+itJNVAG9gbmsFLbpj+kvCkxP1/iHPf7ySw5BVnF4
         4Gy5vo2w3Q+r3u33T8IbchLmHP9/goaA5zcSDm/G1Yu6zpJb1QOaTbhxOI73KRrC+Equ
         y7rg==
X-Forwarded-Encrypted: i=1; AJvYcCU5PoldLBlg9KKnzSycR6jfYglrwGEuRueqZKAQDyt+5CXfH3meDIwZDHizrqvcL8Uk1rUIEZlSYjt2PBwi@vger.kernel.org
X-Gm-Message-State: AOJu0YxldHiJddkPMa0xWm2ym++1BG5QfN8iat2F3vxwkjTHD0joiHyQ
	2+nYk5IpqO2bwMI0mfty7p94fPo22YUbMa87i8+UW8meWc4WmmfUkoP7lSMTelM6uCjAImKFt1/
	7dFGUsraNjufn8wtsuSXmTU55wiyvZjJw7l35YoSRRFtQowXuI3+rtdo=
X-Google-Smtp-Source: AGHT+IE5AIK7chWjS9Qwruux0+MNbD0t873UJxKTJhPolIL7YKITplTj5kAbNAFrJUQcFTBg6qRbpSHAOE1fNivkZ+r2aqTjy8NZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:3a3:f86f:2d0f with SMTP id
 e9e14a558f8ab-3a609a2add2mr39984325ab.3.1730381882619; Thu, 31 Oct 2024
 06:38:02 -0700 (PDT)
Date: Thu, 31 Oct 2024 06:38:02 -0700
In-Reply-To: <000000000000e6432a06046c96a5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6723883a.050a0220.35b515.015f.GAE@google.com>
Subject: Re: [syzbot] [fs] INFO: task hung in __fdget_pos (4)
From: syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, david@fromorbit.com, 
	djwong@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, llvm@lists.linux.dev, 
	mjguzik@gmail.com, nathan@kernel.org, ndesaulniers@google.com, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, trix@redhat.com, 
	tytso@mit.edu, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fc5540580000
start commit:   3b47bc037bd4 Merge tag 'pinctrl-v6.7-2' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2c74446ab4f0028
dashboard link: https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11026e54e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

