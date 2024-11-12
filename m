Return-Path: <linux-fsdevel+bounces-34375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC669C4D3F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 04:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1046028239F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 03:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55166207A1B;
	Tue, 12 Nov 2024 03:23:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86684206042
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 03:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731381789; cv=none; b=pvizz/7tlm387QVxn9g3k802fhqH3yqsLfNY955IbNITNGAZPTRPdyp9Sa/IKvLx+pT2tr6f36Uv2bWDAgEszR82zKlTpNOfE4QMJzEUXP4LgnCe1q7FQcYuqFk1pz317fHCn1S+3yoVq+1/TCg4JP9rJUttDYpHw9g5DvBcQy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731381789; c=relaxed/simple;
	bh=c59rq/7n3PHZV+Suo9gZ6Sof0WvUW1q/ji67zSE35eg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gZk6dSM4nKc0AqjJ3eJqMR+40nGnAByFdqk0RI8cwEwedYRBNBs7lpLgPaKUrZRqkpxKTRVvBaenDcUfJfQ37ARuSFL8xUJ7bUjCX+XEuuT7KvXOJpGLeI3lRIytH6sriYqqwhFw0UcfipQqEAGe3tpGEgZTRSiByHKs6bU7xK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so70500375ab.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 19:23:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731381787; x=1731986587;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GmAGIQngpXa/1+2VC6uEAt5s/OZNY5/G7HFFw9+3pkI=;
        b=cSW22RJjdGQ2ARi7/izbWJ3yMBmSsuppelSp1Gbdnph90AD6n35l+cA3/2Ktz6x7uN
         clkcGFds61lP1P/N/o7IjpEloLCCFtEm4dHe6V9/xRrq5cCLFmf/u8WwbpiAoJR0/ZAo
         ee7MSgMvRuA0+tCT9XvvM1zXyRqnwq24WJX1j2Xi3nTz54OuMhFbWx0sOhPxU2doxO6T
         597eGjuriXf72NZX2QXcBciDwZPKrctm6OD3eyxMVUxJXfaleIDK6+D0ttAiiWMBBCqi
         atTKBnIkOc2EKfsJzKS8xXrafFp1JYHyYh7eugRmIsCgmiKPUsM/hCklXjoG3UTFAp2l
         0jyg==
X-Forwarded-Encrypted: i=1; AJvYcCXq2sPgKo48v1jG/NIycXGjqVciRwKDcuwzzcsSV8V4j2KHfcoXoMfq/u7wjaNXOFPa7zqkGKE5A9uADQtx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl+uEBz46GVZjGXzyD9t8aEHIjS8gG8QWmbzVtwMEf5EwTHy7C
	hyrQKaGjkk6w7oatm02kTB1WVMbrFSo08AGiU1lveCtAKXfPbnf6ZwT9PmJAtwzTKIqdCjMwyJ/
	+zGdLZIG0WPkgHtT1Djeh0bGbp4j786oTa5Loqr69qBKI4oHLilb0UdA=
X-Google-Smtp-Source: AGHT+IFnZynlEK9QhImG9NWvPseVWbTnlWM+8+8PwejoxDtnQc2IgH3PqxrpxZ8IU6RvIxJs5G11NXwh3DX79PwcdetZgOD4vPjM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:348c:b0:3a5:e5cf:c5b6 with SMTP id
 e9e14a558f8ab-3a6f19e2641mr168214415ab.10.1731381786682; Mon, 11 Nov 2024
 19:23:06 -0800 (PST)
Date: Mon, 11 Nov 2024 19:23:06 -0800
In-Reply-To: <000000000000307a8e0615918f2b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732ca1a.050a0220.1fb99c.0162.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in attr_data_get_block (4)
From: syzbot <syzbot+8e034d7422d389827720@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mail@seo-local.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 1fd21919de6de245b63066b8ee3cfba92e36f0e9
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu Aug 22 11:43:32 2024 +0000

    fs/ntfs3: Stale inode instead of bad

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17d5b8c0580000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=8e034d7422d389827720
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171bf3a9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1084f189180000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/ntfs3: Stale inode instead of bad

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

