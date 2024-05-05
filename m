Return-Path: <linux-fsdevel+bounces-18780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D1E8BC3D5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 22:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059E81F2216B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB976036;
	Sun,  5 May 2024 20:59:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F46EB52
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 20:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714942745; cv=none; b=B5mCCyrqS1TGX2dh0NtLVR6dK6acBtGajUicp64ZqjqB0nlxaBzbgp0tQck6XzW10IDyYHrOsaTmKU1Kqyi8BuiofdMP589KKU0+HognCtb64BtaHtkfdXVKAuEdnKmyde7Y/Z23sAy6owZf31rQC7TqBo7wuCybHwhq/LLiwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714942745; c=relaxed/simple;
	bh=MuUD9FFWuXSGLaTNUDVSvdvJhbVmlVaZRI2izi/lgkw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m7rSUKECiEUaKubOs4t9dMS1yA81ULf4ozto6DdIbVP3dEJtECneB7VBUk0xV6nWum/KOGAhl9wASVyzNTsAf+nbUvC4zF/C3gify0KlDuVdPBPcowRXVtRizfhag9ocWznWfHxbLcyO7N5m6WyOSC3g8ypyjpDCSu7u07gBlPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dec4e29827so159171839f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 13:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714942743; x=1715547543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XZzzFIOk0q1XGbjNkVkwmB0Rx4sKexxyAZqWMu5IjM=;
        b=todYzdvlbFx6bPgEXbhIsNOjw8uZsN2XYmL6pXlxLkao57F0tD72hdG45elfexMj6L
         QIrxCwQNCg/PM7I8m3sKIbCY9H9lCokQTH57oSuc9tx2tS1cLWGIEv2eB2+ov+vKKzfI
         wQEhHBN3OkUjYXeU+h/Hye6fkWIPh5p4dSwgCICDn7ordM4EVD63yqgX3mnyk0f6AQzb
         SpoTocAAdgk0UTvicGFWR6IlV12IZeSxbA+HxTN8xOyEJBbVkYppdnP3OLVz2MH02tOy
         CicjurJBdl/N88dwmor2uklms9NOIgFeA77dRO3OpNkBCCyhoYGhZzX0d4HMv1KlJkti
         gDag==
X-Forwarded-Encrypted: i=1; AJvYcCW7MsZb3AQUHJ7isDEiHMM+3cab0QXyWCw144evOIDfDRfguNgRI5TPoWGIKAK5gY0oQjLkh3z51e/FwgC9pltCZLhs+KJgEiTOjq468g==
X-Gm-Message-State: AOJu0YyoFl/4y0aFfeeok5L9b7VE5QirI6KZRFfT6xMRiuftXAizwNXz
	tMTfK/1vkhJ1jiqFpN9b8HR4jWJH+xf+xUpvPOxUpFLCYOV13ivIPR9dZ1wL/JNcnTi0VXYV01H
	HTWSUKIIjo6h5XG5FHKFolKB2NkCuF4HmtsS7RfGQgEOA/PE1lK/2cT0=
X-Google-Smtp-Source: AGHT+IHlVd3hJWK1UWMadrAPWJdyK/1JHLko1J5M/PynvAhDREjCeIBwi8faa/qySXdPgKHzRQ2YidiOAMaHKEotNz/OdZlTi0Ry
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8c18:b0:487:5aca:1a49 with SMTP id
 jl24-20020a0566388c1800b004875aca1a49mr344230jab.1.1714942743591; Sun, 05 May
 2024 13:59:03 -0700 (PDT)
Date: Sun, 05 May 2024 13:59:03 -0700
In-Reply-To: <000000000000897f760617b91491@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ac63c0617bb390b@google.com>
Subject: Re: [syzbot] [bcachefs?] [ext4?] WARNING: suspicious RCU usage in bch2_fs_quota_read
From: syzbot <syzbot+a3a9a61224ed3b7f0010@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16f8862f180000
start commit:   7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15f8862f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=11f8862f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=a3a9a61224ed3b7f0010
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12376338980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16047450980000

Reported-by: syzbot+a3a9a61224ed3b7f0010@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

