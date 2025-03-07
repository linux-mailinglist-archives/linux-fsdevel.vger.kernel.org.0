Return-Path: <linux-fsdevel+bounces-43458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF39CA56D75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 17:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDDD3A3CDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E2C23AE79;
	Fri,  7 Mar 2025 16:21:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73423A9AE
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 16:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364464; cv=none; b=Tbd/nWU/5TnduF96HiMtFs8RCX59koBexKFOFsgM5MPN1um6mAIIbvqLMwnxXTB4jqwdIU+ncxu8QBR/BoDkYE3C3FX+IYlSH9u0gUdiKdOfFaH/j54BVq0i1e4PyfcAHCR7+TqGarTtlNt6EZMMxhazuhC9bGsD7EJrzldCViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364464; c=relaxed/simple;
	bh=NtertMuEVLb4GQJzbCtunKWOV/Sy4gysXnmuTeY8Afc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Huq2Gx00UlWd6L2n3ywH+aTyBn/i6ae4t9kYB9IL1EF5h6OuyElwvC6Y9VkcZShTStiRhoOmeyzvQAqCx7On6fXpjElN9oOVLCNt2UNxNbSoKz0XEs5a0hQrV+hrFRUH6g/s9JtCA7/Kw5Lu67pE9CBc+rnb/p+tvUmPElyR6rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d054d79dacso37897085ab.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Mar 2025 08:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364462; x=1741969262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hqoZmbhmrm3Wo0MivXF1llagCoU9e35MwSyCFLjrWUs=;
        b=MX19Is4JQZQ7S2xM0n+X1CURUACMjH0T/4j8qveoL8W/XDbhpvTLJd6RrGau4qUfIG
         U9MHAT/HJtvHi00rwXZ2zy0W6lWjSqse8hz0UKbntohSZXRurffgcRPsKGYNqBuZSAtK
         RFZkAgTQA6nZo3KS/Yxfi4mQE4J5WTPcl1TDxaxjhrv/ilsifYN3JD+KthL73Y7KcgZj
         r3dIHcFxrNy1UjVhjDb7g4a82UWyMGJfa9Xg5I1333Ns9ryaAc1cHb6wyKZ1sYnKwq1g
         8rsxxsro18kPdg+r0cvpN15EbIGjRodPU2FW1BsJWlw2c7et1rCypBqiGwMyXraZiwlG
         TZHA==
X-Forwarded-Encrypted: i=1; AJvYcCVsWZdEPht78zkiAPEenhu3dWmxt0+NgNUdx0Lu8SU1jaGKwADCEzEcIbT0kVF4HaaOR+0SqH9O7xKCuyXR@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/HuPriw16op3B9Xi3ndcW04LbQ0hYf0WvJtwLMEO6hNhr2G7
	F+pOP786FCQdtla4ThA223+afMvRk2KNpJ92dfJMWqaU5C1R7nilRFnr3VzspkHmR8uuqJKk0pH
	wV6bahA0xX12i6ZTU4Y8z7hPSHBXr5zpfX+UY3LXtETufqzxkYBQ/85E=
X-Google-Smtp-Source: AGHT+IE2nPYnITDZFp2SAZViHoxjw6aguupsRSsmbyNsC89hqZr0PErp4tSqaFr1UoOWuFXn55n8KZ94RFEwvPF2I/+bF0BN3faJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2168:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d44193d992mr52659425ab.7.1741364462402; Fri, 07 Mar 2025
 08:21:02 -0800 (PST)
Date: Fri, 07 Mar 2025 08:21:02 -0800
In-Reply-To: <CAOQ4uxizF1qGpC3+m47Y5C_NSMa84vbBRj6xg7_uS-BTJF0Ycw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb1cee.050a0220.15b4b9.0082.GAE@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
From: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, amir73il@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cem@kernel.org, chandan.babu@oracle.com, 
	djwong@kernel.org, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/linux/fs.h
patch: **** unexpected end of file in patch



Tested on:

commit:         ea33db4d fsnotify: avoid possible deadlock with HSM ho..
git tree:       https://github.com/amir73il/linux fsnotify-fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b7e15dc5b5e776
dashboard link: https://syzkaller.appspot.com/bug?extid=7229071b47908b19d5b7
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fe4878580000


