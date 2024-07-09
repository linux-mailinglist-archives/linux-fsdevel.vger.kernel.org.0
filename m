Return-Path: <linux-fsdevel+bounces-23357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE57592B0F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 09:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8989D281C70
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 07:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5C513BC30;
	Tue,  9 Jul 2024 07:20:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE312C80F
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 07:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509607; cv=none; b=g12n8Sew2SBPCP6/5IhYQoU4mIy0nZsouu+A2q8FC2e76/KkGtdRalk2ehydOxgAvVKqfjfP1KTfTlBzEIHYXPILhSyMa0I3wXyJCqWwdqPfIRHyYTTFjbhIuUXg1UvFW926ySrn5DPm2kQsobCQlKggQJdIGAQXkySE94lnBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509607; c=relaxed/simple;
	bh=DnvLGnicbmiYfIqz61udK8HB+zsRCUfv0QDXsIay5O4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D9LA5SNOxINP6LBAlXrtwK6esue1P44ldma2GF9kMf3tsE7rmi/VM4eZfNizXp3IXN9+YzYjzswYYqKTCYYGIjsq6GGcGy/uRGrcHcpmYxy3QhQV4suaMWiOTAe5Z8iFn4bMt395FboxZNyxeUL54aEzGBAOtzQVp7ecqvGNnsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f95699cabcso292080139f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jul 2024 00:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720509605; x=1721114405;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mzvn5wJSg31aYIZFNCGyZmbYBaCQNY0Jc7WmVYNaI74=;
        b=AXYgolJLlmBYbt07GjkbmU4rqqsnKXSc1sHztumX/qg8eTA5HEXhLu1dCkKH/FWzgt
         Pg/i8W4G+bPtWU5/wOsytT34IUB2jXMG0gXYBrt8XP1lpav8fZspToNicKCPQ8+W0KI5
         K5cCllbPN5C5ZOwXsAE6oiBjN0J/mhUH801x6vxHnJ4BscNKizBUg/K1UCxlKvmYRh2C
         WnClcx9Udoti7+2jkl8mU5+NRIfbjeQoL46mhlLh5VyPXldsMuzIAlUz1SOQYmgVidV0
         io0LuNfavWmbSwaQ3E8Zi30V899nGfvesLDRJFyL4VmxEci0dVmbhW05ZKxGUuL2qzyx
         g4MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUb97FE0AVB8m4zF1RgtdhIN9QGMp4NgNz6q8QvLixGP/CsvLoteOb6OfTlHd5/rn5Qd2XvszROF8bfEgir+dKw8nwlQBn47GsIZ4kFCg==
X-Gm-Message-State: AOJu0YwvOyxV8rBaiAgHInh9zzMC/U2R1jR7YPiq8EKEkfxB79NmLQfg
	onaHwMlYpEIVA76QAQkoKxzs1pmlaM7u30DHgxX0iwONcFIBrr71xDGcP8qaQQ3Jr395VtypEQi
	Fp+xYp7TDTCh8KOSxcp93cPcdXReBWhc3BNrBPPhqT4mYr+StCqDvIkM=
X-Google-Smtp-Source: AGHT+IEwrGLocv2v7P1tQnDnDxza0l2WMX69HWMBD3DDTBkNGTZFpIoimehItrBvSBMKGNSJXM1ZxsbkPh0IW+avtuByeBAwJ449
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160f:b0:7f6:85d1:f825 with SMTP id
 ca18e2360f4ac-7fff9979c70mr9105839f.0.1720509605223; Tue, 09 Jul 2024
 00:20:05 -0700 (PDT)
Date: Tue, 09 Jul 2024 00:20:05 -0700
In-Reply-To: <IA0PR11MB7185EF69D19092412AC55B66F8DB2@IA0PR11MB7185.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da3147061ccb5b55@google.com>
Subject: Re: [syzbot] [fs?] [mm?] INFO: task hung in remove_inode_hugepages
From: syzbot <syzbot+f1d7fb4f94764243d23e@syzkaller.appspotmail.com>
To: airlied@redhat.com, akpm@linux-foundation.org, kraxel@redhat.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f1d7fb4f94764243d23e@syzkaller.appspotmail.com

Tested on:

commit:         581a87b1 fixup! mm/gup: introduce memfd_pin_folios() f..
git tree:       https://gitlab.freedesktop.org/Vivek/drm-tip.git syzbot_fix_remove_inode
console output: https://syzkaller.appspot.com/x/log.txt?x=145a8535980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=409b5fcdf33b7555
dashboard link: https://syzkaller.appspot.com/bug?extid=f1d7fb4f94764243d23e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

