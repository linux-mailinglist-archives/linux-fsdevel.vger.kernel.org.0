Return-Path: <linux-fsdevel+bounces-11628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AFF85591B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 04:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437721F298F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 03:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C12D4A06;
	Thu, 15 Feb 2024 03:07:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9151864
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966427; cv=none; b=CPKybzveXAIFDhGfKTTvat5qxz3ZkX/URfrQzFIOYuuikVkRWtuWhFNNviOxFk8bBLUYcbfSyE8OkXXq6EOjZBIGxL5Bk3k35a3fodP0QdLcSD6k1JOsPPL4DyA/il+ycHWrWBbn8brE9lbonic0sdmaZRq2Xq0ES54rac/fTTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966427; c=relaxed/simple;
	bh=+WH7uPzfjj81wqBb60oGRmq5wR6eVikk7Rh/pPaG/zM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jt3I7fmYfP5J7n/1rIFGDiSdGfEmu31bIm4VVwVk/RdyiXlabKnDQk8y26oMuRJzf/k3ZnuH9HBQB2kVXdzik063l+8gPNKnvmQbsTjCrxWAvM+r29FpCq+spsynSfbsWWkXnAzCvFT7IPzQ9KO0Fg73cNFTKP+d6M+ZMtcbuIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363d169c770so5257485ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 19:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707966425; x=1708571225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hu3WnfFcFlDDxQZ/5rA1nzDSVs6Azrnu1Ol+niXifK4=;
        b=It6Y6JQy3QljZCOfhaaEB9EPlIjbfsW1EdRE5RY5KNYXuVvU1wcWceqapThOW0hgFl
         3s0FVmnEykw0LdHEKoPi1tchcCpxkrf4rtNDMcPQH+TBeOdBB1askgOWtZZT5Ho+DSck
         P2PK9eYEdmZcCrPF168f8tw5E/Hr/9D8j5xXRy0eEbh7QgLC3VY/HLHW/7M6DUBKKpUC
         tSvzhMEKesRRMlPCoz+eMNIcqctkJHknOllkuYlXOVNMu6/x2IcCbpkQikPyYyQUa0p7
         iEuDEySQ0m2Df5HQgEJ7t2uJcYJxpQmcx58oD2/PXCExqJq3YbhkxX/KZwh0WuXDpteN
         9cnw==
X-Forwarded-Encrypted: i=1; AJvYcCXBEtZPHzSkC3XFL1aefAbup1I7VFNSXKF7pDpqsTcIN7taRStETUBF+gE7jBBfIx6juO42Fbl2hj8ousdVO587p+J3AF9GowJJAfwiNA==
X-Gm-Message-State: AOJu0Yw/mexSKUqgYZ3TbsL9lG1B4KbJgeMqO31V31+4+wcVUZSl8moo
	3tAvw4vLNrEDbkv/l4/iYt0hm2HU717rlDMR6rt2jsyJhPiq/t/xc9sF+HDnd4Mn/edMlVCVlIv
	6N88xEba4Q2D8qexI9BcvuszFQ5g3q6N+AVhrO6FqhI5YCxRgX0KYSWQ=
X-Google-Smtp-Source: AGHT+IH0mUXBoVo6kd1a3ZPvV61p0PAgEUateH+/Hk/zY01riz1kIj9fB3Dkx22kScLVWX8T2JXv6d2RzarTpAUDpK8IWZiQczjE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154f:b0:363:de50:f7bb with SMTP id
 j15-20020a056e02154f00b00363de50f7bbmr27964ilu.2.1707966424876; Wed, 14 Feb
 2024 19:07:04 -0800 (PST)
Date: Wed, 14 Feb 2024 19:07:04 -0800
In-Reply-To: <0000000000005c72b5060abf946a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b0fcc061162ec09@google.com>
Subject: Re: [syzbot] [reiserfs?] kernel BUG in entry_points_to_object
From: syzbot <syzbot+927b0cd57b86eedb4193@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, reiserfs-devel@vger.kernel.org, roberto.sassu@huawei.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e6241c180000
start commit:   98b1cc82c4af Linux 6.7-rc2
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=52c9552def2a0fdd
dashboard link: https://syzkaller.appspot.com/bug?extid=927b0cd57b86eedb4193
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101b9214e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fb7214e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

