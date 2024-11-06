Return-Path: <linux-fsdevel+bounces-33829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC59BF8A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 22:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39D11284258
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Nov 2024 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90701D9323;
	Wed,  6 Nov 2024 21:48:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4F1684AC
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Nov 2024 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730929685; cv=none; b=IPKEYbYjDTr1a2h6DqFTg7wILpIUd2StAAZ1Gw/ZLa4G6wL5GPjDno0Ep8Dg0AXgV60nB2TBdzBFeFQAI0zTKqoQB3Ai/i35deHgsKjEbh2OympgBpG65qtHuke6ASlMo6W16nqf9g+tcAtmTb+jtm2412eMzrvwC8TIRF82rn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730929685; c=relaxed/simple;
	bh=L/ARnIm1u6eeiUQOB1LLwKgoAkaJUeevTjZ+cEGCd6I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T1aSnfdxZnYHX/Z1s/1a0aB+AhnJBTHCdlGrQJrA3D9Ysk9zNRhEI8dk8lYjlJiYfmvDSoL+IfpzN4MFktztIM4W6fla85XMK0tjE0TQUS2VGNFjyXyDY6kkEqwFTBQk3GYk0Q+qUMt/FaGlVdNsKQgjttiTGGxMNgKNPIn+oiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83aba93c01bso31077339f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Nov 2024 13:48:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730929683; x=1731534483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojInmPhleN/dUs2oSXWegTTSzM2m0iwKECEkAv/rcoA=;
        b=JnZfZOWvNX4pvbyHinBRyGEAsJIT0QxUf0jDvYHeZxdydiPJFznb/aEI6hLZvnVZib
         f30mIxuGrLkXT0iKCsXR4OxXhWgk5vR4dRuz5yk/or7W9Sel9VWl1nTCUijvNXLd+02k
         JJ6/tDtoqcOCczdGuOrZRN9Vc9TGwbG1pAFd6npAIDe+4PMJiv4IN5MK3n6z6ykz9j/0
         Ltpt7F5MH5aSwSv3cNpeQ+fy640hMKQKgSAG5XtgH2u19SZpH24moNBAZz7hzDUgblx+
         sXpO05S8keUrT9U3Kp6InpHGnEvly52c3sM3YmR89mEzVAHqCwlvD9e6/uYUeHnetNpm
         8pMw==
X-Forwarded-Encrypted: i=1; AJvYcCW+y7Lm4vab1ca3g5/LSQWMYLeDY7ZIFmvQHHS+oAA0NTWI/6V/SiCXRmnEHGQ5gdm0WRgypTMBOJB9VJUH@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0n00NYLQEr11W7gr3oHpYxoSms4bcnT6BNYuyNEz9x9/Ayi3
	e5wKczxSVuDFfpGkgJ9VAG9Opjak4vdip6HmFptkKzR40ABVGEhYYrStII/nbz+AC1HZu/scLGt
	09WZVQlAX7+aiNl0p5NIQIQjMry/Wx5yuKJkDdxh/zQMmmwDVuc+WdL0=
X-Google-Smtp-Source: AGHT+IFUC8aysLTjjcCNL4i9V6ZU/jbGdtX76K3kMmQ2rKrHUD010gXtdTQpAH6zxwkfTX5N79+kqbthNaKFSQiJbbhQG4mxk7Gn
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3a5:e5cf:c5b6 with SMTP id
 e9e14a558f8ab-3a5e5cfc68bmr299261055ab.10.1730929683168; Wed, 06 Nov 2024
 13:48:03 -0800 (PST)
Date: Wed, 06 Nov 2024 13:48:03 -0800
In-Reply-To: <tencent_E298974436464AA47527762F67923C3D3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672be413.050a0220.49393.016d.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_cat_bin_cmp_key
From: syzbot <syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com
Tested-by: syzbot+968ecf5dc01b3e0148ec@syzkaller.appspotmail.com

Tested on:

commit:         f43b1569 Merge tag 'keys-next-6.12-rc7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158176a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fdf74cce377223b
dashboard link: https://syzkaller.appspot.com/bug?extid=968ecf5dc01b3e0148ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1744ce30580000

Note: testing is done by a robot and is best-effort only.

