Return-Path: <linux-fsdevel+bounces-35707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7999D75A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7C4FB379E1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6B12500CA;
	Sun, 24 Nov 2024 15:42:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051932500A0
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732462924; cv=none; b=eLsYPvUOT6yA5/kAwLPCZnGZJUi3+nwVWXhXmaLWEfIjmhLcCWOxTHB4RHhsdrC4b7kNVLt5YYeLdjo4zhABlTEvIKgigbKOs0Knyyl2k41m7Ky4Uuu0/5BujoPoIY4jlg7CONctynG7U2qXhuUZ+PHIG5Khfo8l9qe7ATP1RtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732462924; c=relaxed/simple;
	bh=Z/KQKu+c5WEklNo+Yt688x1xWLnf+a3nL7woaIVkYp8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cPhzDTV5gGG1FOw4YuoJDZg504GZ8V8aUhTXU1m+xo4xHKeFq5t0SQorzGW+z+PK/5+F2oQuP40bMfgrF5z3wXnockObnvGUyGN5SlKKS2vEvKVhxRuakfjAGp/VCDbTBr3JuipsFncGEzEPUrKGJEqhZa1nBg7+bjwDByOFVsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a75c23283cso30977415ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 07:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732462922; x=1733067722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=coRcVNZpynG+ZxE9nHIs5dACc/byHyLl4kWizERwmks=;
        b=MSFZz7WaWeuFqZNY5m+Bx2DUNnXfdJOSh1bm802kEmCfZzYQE/1Kg9sr0HuDHwmCQh
         jZCOdFMYYVRNEpM3geATt4e1EkwzqIosiOWCGWNnfG0r/0jYPchcPN3cw6kjjeuzKIXm
         fUJeAO2DhjcRPrvy3+jtghLXDfgjBT6GJsiyj+hiumH8X9B92I+qYtHsQu9IHclda+pW
         yOKe2hgcjCv7rq3kslLd3ZbxSgFq/QbFM78ksH0uoq7xJtKyLNGVIB7rfmYmpJv8EwE8
         GYtoJB2isQSczOQCL0+MpJRX7bCFg9ziRJHLUYUMteR+7gGh6i6S9v5Jtk2Ug6YEPYHg
         xIEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXVwdva6KOVDUPSavO4NDwjEqe1kPmDjtHJXlAj1VnTtCNDyy2Pu1RHEiz9VZ5GQMQYODFcrnEycAe0+Hj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe5ozniBucXcQ2FmU5vFtZSJSAAZHXyZ5RGHyR6qmpN35gsnQh
	qwMBYBoSlHQDOX2Nm7iyP63REgkoZ+CpQWlrB5XgsCLix0INTj0SSC4n08FJgr5yDaUiF6bYDKn
	VqrHFdhWhWub5cSaM0clrGVycMeerKTXP37EjffO0QIAe1bnFvI+svBI=
X-Google-Smtp-Source: AGHT+IHVizeF5m7kAeRVtJocK86791i3Jl+BSPmPJQC/yyO7LSgAuZfVEZxbxgS3AmzKG/QoMRGMAfCa1aWO1ZoTb6LsAKrTEJK5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:3a7:a58b:557e with SMTP id
 e9e14a558f8ab-3a7a58b693bmr48683065ab.12.1732462922271; Sun, 24 Nov 2024
 07:42:02 -0800 (PST)
Date: Sun, 24 Nov 2024 07:42:02 -0800
In-Reply-To: <tencent_C2474B031BD225AABA42BB7D33FC9E861B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6743494a.050a0220.1cc393.0043.GAE@google.com>
Subject: Re: [syzbot] [hfs?] WARNING in hfsplus_unlink
From: syzbot <syzbot+028180f480a74961919c@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+028180f480a74961919c@syzkaller.appspotmail.com
Tested-by: syzbot+028180f480a74961919c@syzkaller.appspotmail.com

Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=162c375f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=028180f480a74961919c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177319c0580000

Note: testing is done by a robot and is best-effort only.

