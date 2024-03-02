Return-Path: <linux-fsdevel+bounces-13371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE1B86F0D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 16:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1865828424F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54761B5B7;
	Sat,  2 Mar 2024 15:19:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF421B263
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709392746; cv=none; b=rKqTgTT07wDcWANn+SO1iWxMERSis3XNbVCnAkjcunyuvLwQDcWoWZ4GvX//+8HiosoGRM2Z77EwlACI1BLNN5MacBtmSd8hLQcBE+nF8bG6Ku/QEMVdn32QPqMaL8SL482wpaHJRWzD1JfNwO9qAbKXqypLcka5Ikqx00zlVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709392746; c=relaxed/simple;
	bh=0ERln8J3TJYrJZ9bLSbjDBFctTDxyDIuAzme6cUygX0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VgPzhWF7XceRI/I68XwZacQPdyN1W7Oa16t22lbhYaVijGOwi3QDINZcCKqTM/3OBZjW8vBVuWrv8PuNxaDTWuAeZ1khvSHV4tfHeD8CzdqrNPxFNKY/58zn2AUXQ3Yu9v8BMs1uC75whp9p3+LvYeYVSMGaXtUPip3c7Sh+Ii8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c49d118546so288656039f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 07:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709392744; x=1709997544;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKys6Rb7JLVGIs6D1784jC1UbdMEAMKrSUMf7HacXzg=;
        b=n95EV5WXa1Ti/sVkYJRASCGeVeX+p3jVBttlA92ZhFN45QFXd87Ti52ukDWX4hRtrv
         IIJkYQzkTTGp2Ew0s73E6EznTREAfuBHVgUiaeXonq8MlpDjhOutlUXUJBFuAqj6BW7Q
         Sb/9dUMgnKTWSozku2mJ8fXT4x1EcDZJ7CBuQXCHfMO8PCtOEBMkv06ffvuxr4/gxd6f
         O1YNrQUNnhp95trdj86kx6+OS3i+zkiTE9PxnZ9S93NkMyIoVEk7HZrFhsT2YNl56ZRz
         zVtAtX4xOtEgpdf5MvF6GzUYpiGMXBUiZzf0/qzR/PU0iP335WT7xTl+JHkyHvjp8QVT
         BJHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZGNAnQQ43iFY7OuWCElQdJKSjr2wRSNXrWDc7FmlYHSHDtMgwePotuS3w3+quldnH+8t0ks0s8euvh0QRFTtmDgLyHYFlBtndRHYptA==
X-Gm-Message-State: AOJu0YwldeEMqmakHtH4oL1QByMYyPfIRypo/SiKN1/rHV/wDNg/4xfD
	1CULpmf+6MYq4mm4FUepaHC7e4qNyIKApAgjPM7ukJWsE5covQZXL00AhLzXdZ1nvtugJzvTOl0
	j/JP+Oohvi0JaDdW6s6ghbWa9A1n9qp2uJMMxPfbe/JwqgXLd3v10PP8=
X-Google-Smtp-Source: AGHT+IGkTiSt3QEIVLdLEE0FTfFUnV004RjlY3UrQMrn4cwFr1M4RyvOfudcJaPb7n0/yyMr8Ln2CdB5T2a49hZjH0muAVKtY/ri
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:809:b0:7c7:96d6:aeb5 with SMTP id
 z9-20020a056602080900b007c796d6aeb5mr31628iow.2.1709392744411; Sat, 02 Mar
 2024 07:19:04 -0800 (PST)
Date: Sat, 02 Mar 2024 07:19:04 -0800
In-Reply-To: <000000000000d40c3c05fdc05cd1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ff6580612af035e@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-use-after-free Read in udf_free_blocks
From: syzbot <syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	eadavis@qq.com, hch@lst.de, jack@suse.com, jack@suse.cz, linkinjeon@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11030516180000
start commit:   f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bcb6b5280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fbcfd1280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

