Return-Path: <linux-fsdevel+bounces-68010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C67AC507A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 05:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B42194E5C64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB622C3257;
	Wed, 12 Nov 2025 04:07:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB21F09B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Nov 2025 04:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762920424; cv=none; b=Li+3GqyLg4e3BmUqKpbjsvfIBnl9eOTVnEGtaeM+5ETnEM4M1I6rfBiFiwLogoLtPUACLpqB2lPrZcmbSwTZ2neAO47h/ldFeGruLWJTZfvXG9OZLvEowYaY2jMFkj2r3mcE9ngEuwI9yDm/anM8SBFUIEWnX+tj+vNmasod80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762920424; c=relaxed/simple;
	bh=gWujzDmq797eIGweX0kiDqqhrTMmMFfgbWstpK3QQew=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=o+tM4sK8mLwIP6uP9AeJf410xB0yb27E3rYpCZhZwZLpyBlqU5D9s02VC5LWwYTgcbUYl88mXgOvDEdmQiuqbGsILrBTq5PCUhJSyvyoqO8EIM2oC8Pn4npH7qzwTsni9hkqpmBN+x/YCbfKLw9P8hOSnWaGAYZl/b2k8Ilb+4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-433783ff82aso14067325ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 20:07:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762920422; x=1763525222;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZGC6srK0UBsNZVToxudO1JhINuHL7PrwcDUZk54PkY=;
        b=xBkCvhsEpdl3u2oSbpqKO4TsDCorMCpnHwkBpLK7kFbuGDPZ2QjHKmze6iYpTBLRHB
         VD7dAZ0BogPwtfFCYA9UnPrdJWzGJeRTkynBOuZhhhy6DCuyGZ53wdgDtpsGG4mFjG5x
         JWod6TWa5tpy8q4ctYxrec1DkvQ250ZNxxc5WgjsSM2rWi6upjRTwL+JOFsS4qRjbx9F
         3d0IKSQrm3uBlXbSUtiaA+l0hf2qXBu3M5QOBs98mRp6p2bWKmoCrgQEH+g+KLMuUUCd
         Kc4/KQG+AGgHk128x0ZROkj+JUN9A41h2kvrwjbAILsgFLofh8rFMmQVJT2CF96mXel5
         nxoA==
X-Forwarded-Encrypted: i=1; AJvYcCVgMD8gUgnSjDTIF0+yTiNyRnvQ7z2irQsfOTRsrNOU+3vE6YiwttyrTGT8bRL3OLdkKCdHr7KILbHIK5t1@vger.kernel.org
X-Gm-Message-State: AOJu0YyzqRZhb242+Nt8f7BOxZxjqE8sUMnJ2psU8fRKGhxqPjrt1ZUe
	Eq5hy/BB3lkqpRiJXSkf63ISyHR9tk8Tfsk4Ke3XV+HmORg9KlHCnJR5jPRjIy+9RVpBtr265M6
	ugcSzytKo41/sBEZPV0eGquaoeMHuzjzFG6Ws33Y+VKRoSxCghWfkLbZxb4E=
X-Google-Smtp-Source: AGHT+IE//vwcBRSspew8ysSz1OrPytRuuCdUEkH2X3LmiXWwmf9pdLMY8BcXHD6hDRSHrbZTj8rYNzK12Q8f5xJ/+AUzZrrKj5YQ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:433:2aac:c540 with SMTP id
 e9e14a558f8ab-43473d3c496mr23907955ab.14.1762920422464; Tue, 11 Nov 2025
 20:07:02 -0800 (PST)
Date: Tue, 11 Nov 2025 20:07:02 -0800
In-Reply-To: <CAKYAXd86eFyX5sVi_5exaFJ-wGn2U16n_L1c9ouDBnFGPuH_qg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <691407e6.050a0220.417c2.0003.GAE@google.com>
Subject: Re: [syzbot] [exfat?] WARNING in __rt_mutex_slowlock_locked (2)
From: syzbot <syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com
Tested-by: syzbot+5216036fc59c43d1ee02@syzkaller.appspotmail.com

Tested on:

commit:         24172e0d Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15c48212580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=5216036fc59c43d1ee02
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a8d60a580000

Note: testing is done by a robot and is best-effort only.

