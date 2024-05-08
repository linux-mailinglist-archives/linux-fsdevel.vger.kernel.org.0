Return-Path: <linux-fsdevel+bounces-19101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1688C00BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7DA28248E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DFA127B40;
	Wed,  8 May 2024 15:13:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571686652
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 15:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181185; cv=none; b=sHzrw2eGeu8KZ4RjsO1nPouXk4I2Qy6yyebpMYMYBnwj1bXUctBEnYM09I1EQF+q35o0upU8/V2/4hibapjNy42c3MJ/bUM3tbQML94UapK7ILPN4zXHD9B34L814Gppo+ot1HpZJV2g+4q1587+e43tunZdHvawAvFste0vyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181185; c=relaxed/simple;
	bh=VTooLKM1UWVTk8gSGQDqgDwStVWBUyMdaRzHq8tOcbs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L5oqXMtLDCz/mROLTfwZkJGUJ4KC4uULoPRkw7b5sSOo0pGH/nQqLd1OtSsMhFhy6tTTqzLNb61es/pkGXuU5cTU/ascxwoS43arIpif1vTKtBbpL5IrMOhVT8bcGwETcj8bIDcioTH798s5aK8ljAWqiMDu5zFgKA4lV08KIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dece1fa472so450507939f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 08:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715181183; x=1715785983;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEBdO5/t3gWQndQoUbCFMwd1dlzvgeFuNRoAmahB4YQ=;
        b=sUafB2fAcTc2NDTqDaP30qz5yETxDTpes/uNmwXn6LqxlO0X+NgBy10ZfWRfJAJD8z
         zzLgBoMdVkSmp2UI0EiVMU2qxDOwfvW5mZqQoxpYFhKlihgpUmdNMXHEHc3PfZb7p1qB
         r3FZMpEHkvcz2Z4tZ1uPh7l/PFNxDpypq3NVVb+AuabgtOf6vQN5UzIvDdV/WukGAC1h
         EdYO117BZXgXjYNsJmNy/dvgLeM6UiK1tILUQ2e/28ICG3eA1f0+xNrMRWbD7Hv+rZZS
         y5dRRfK22ddU+cFctXLHV3Jbjh+3rkiDeHYyEC9iV/WFUSv71GssapNahQVJaDVe3OpX
         7riA==
X-Forwarded-Encrypted: i=1; AJvYcCUzf5rYmPCbfTg5dxae7hgkI2+5hrVW6UdaLXL/4ZJJip+5OmVFg8vaSpIAFBktXMOqNymQmat2NnMl2hYjX0KY7q5sh8asKkEhgo30eA==
X-Gm-Message-State: AOJu0Yw7GmQlCtE5TE9ch+fd+CipOVOEQGVHH1UG/nTT56qUQ6Dhv0fF
	38Fq1NoN9V4Vb+A1bOtGtQy1Ckq7x5uk550hAmBPuvR0p4Kuz6GfN0C1beB+3VaozLoEEFp9oFJ
	/HUo3ds+6e/kNcYGOtIMp+qhM+2zG9FTQWK+Ck7oH7+gcgI2jgw72DA0=
X-Google-Smtp-Source: AGHT+IEgJOu5ZVCCFED8YRbF5GZ6UCcgUorZLjp//7D8s5IUYcamXViyuOmXvu9So1WH93R5xeRN4nyaq37WLksFXyCFnIm9g7Cb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8325:b0:488:ac5a:7fe9 with SMTP id
 8926c6da1cb9f-488fdd777e4mr155178173.4.1715181183643; Wed, 08 May 2024
 08:13:03 -0700 (PDT)
Date: Wed, 08 May 2024 08:13:03 -0700
In-Reply-To: <0000000000006399c80617120daa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d41840617f2bd39@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
From: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>
To: axboe@kernel.dk, gregkh@linuxfoundation.org, hch@lst.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, rafael@kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 1e8c813b083c4122dfeaa5c3b11028331026e85d
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed May 31 12:55:32 2023 +0000

    PM: hibernate: don't use early_lookup_bdev in resume_store

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1380072f180000
start commit:   dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1040072f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1780072f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134f3c0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1367a504980000

Reported-by: syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com
Fixes: 1e8c813b083c ("PM: hibernate: don't use early_lookup_bdev in resume_store")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

