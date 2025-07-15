Return-Path: <linux-fsdevel+bounces-54936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 566C1B05781
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 12:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80BD37A555B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039CA2D5426;
	Tue, 15 Jul 2025 10:09:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A62550CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752574144; cv=none; b=fbgNz8ntHkNirozsBGoAakkIRYGXoD1akQo75m+tp1K+ZL9fNkO2kD3MgpdkQxzkC57UI3KVw35Ms/aa+WRxdeeTkdYMAk+aMxNc2Vla03QzEij/jco7+6I+JG+MHom+eBgTm6W3B2eT6N+Ja7YObtIMZ3PditFKgsJklnjMYRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752574144; c=relaxed/simple;
	bh=hxcRH5pJi24BOC1XzRXTiae1Sa0feToSC41uN8MIri0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fjRT1BAQQ+WbGdINl+13TY+WUbruxDhz22mMPQ4Z3aoQ0k0CI/MTYcfZC1FitlHx6B6Ccc7mtG8h4MBdElghDw/qFByrP8iNgpLH4cotsX5XO1M31AM3gkEztc80XFG8kWWnn5iOcxEYCF6fXa4+OJnlCpbzIltw6rvrv7k+wmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-86d1218df67so564390339f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 03:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752574142; x=1753178942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UyT05bOxl++wcvX5JT3gde/jg532HYEAkIZ5w84oF+8=;
        b=eWvUVGf8MhOXf5ikmPkdOv30Ikv5BGP+G/HSFuivtsw5ELx3kE855WeOnDcu3s5LSo
         UniJJqa1ClGM6zSAouBckj7N+rpu0n3plARlXiCtBGUb3z9FcQkf1uiXbWXUu6AsrUgD
         UgTcgUq8lt8HfoSCg5EoX0823qUaq85eYaFxtC32wpRg9Feb2y694BRhBJto9CEtK6WR
         SEhv223JO9vgO0MOAiRWc8F2scI5E7e6+wA3tHLR6Yg0pqVDL8TeOuMdL9KSlb2ocIFW
         UryE8H691XdniN2eXwXoepeUfdHwEnOsHUheXoka42Qg1D8s7x4zsntgQLJEA9F/+wrr
         OwVg==
X-Forwarded-Encrypted: i=1; AJvYcCXgnjo/UB2U2Mux/3lTiChAdiaOMgyBHp6wr/E9hJWHXp0Qc+v/gPWgddAH9HbM2uDYW3KL87ozrvLJGMcS@vger.kernel.org
X-Gm-Message-State: AOJu0Ywti8epTuWgNyeTYe0RXWC4DPVUKvxh3FDvx3T8GP5EpE0CoZmi
	OzDrblvF1ytv4Ju0moop1NU+x4JPYB5H5t/vOTL/0Ic+sSdy+j8XhOcTFC8e59PXuk1YqLrkSm8
	9zb/8HXFpNlFcCMIUuHtjdr5dL9DOeCMf//z4Ot1X4qsL3/VGS0fJ85NFzR0=
X-Google-Smtp-Source: AGHT+IH2DFYeAFFLDDO9dP62cwAlCAiY9tE8j/X4gV4X7LCMcUYU/t+bxXp9FyqJlm9EWACQcGM10N0/l4YElxSfPnhgPCVhp0sy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dcd:b0:86c:fdb3:2798 with SMTP id
 ca18e2360f4ac-87978866cf4mr1804968239f.11.1752574142353; Tue, 15 Jul 2025
 03:09:02 -0700 (PDT)
Date: Tue, 15 Jul 2025 03:09:02 -0700
In-Reply-To: <68757288.a70a0220.5f69f.0003.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687628be.a00a0220.3af5df.0002.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in query_matching_vma
From: syzbot <syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, andrii@kernel.org, david@redhat.com, 
	hdanton@sina.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lorenzo.stoakes@oracle.com, surenb@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit fb8a9ee1f05345b1fae37902d32d954d2150437b
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Fri Jul 4 06:07:26 2025 +0000

    fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171c27d4580000
start commit:   a62b7a37e6fc Add linux-next specific files for 20250711
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=149c27d4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=109c27d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb4e3ec360fcbd0f
dashboard link: https://syzkaller.appspot.com/bug?extid=d4316c39e84f412115c9
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ad50f0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1173018c580000

Reported-by: syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com
Fixes: fb8a9ee1f053 ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

