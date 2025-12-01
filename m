Return-Path: <linux-fsdevel+bounces-70323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75590C969C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 11:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AFD94E1274
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC379302CCA;
	Mon,  1 Dec 2025 10:18:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E230170A
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764584284; cv=none; b=XGMkt1zU4uVjvwuZEK4wYz8bDXY4L/fGQ8AxsOW33Z3XjpFhvKtKivkzO5KkRWKbFECxK1bjooeZlrOpXjtQBstCWl261MEcZz4M27b3kmIfg5kuYhqjyx7TOoOZ+hvR9K6le1J6AXYaF3GftCofNp5PS0aFQlYPNADs1WGnqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764584284; c=relaxed/simple;
	bh=qYjhE5H+tepDnQR/NdXpP5gvxFSCnek9nanqQJNe0go=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ft4JGyuAz7Nxkc6dnS8rsGtSPSjoiHabugMYVG8lQKqzLEp2VNvTvYrz2yOA2oyeIocootrETsBD8EzVy1rPuq9nJq/W/wHESs9Sdw5LMdDnY7lDsb/uc5YWiCDytlUI0avwJ5mkJlDWLyLdgdNHP+ucY+ofxKPydt8SeK0yFAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-948ff1d169eso262994339f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 02:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764584282; x=1765189082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSD+sE6WJY+88YLTFb+oiMUjRjH3fxhhKy5ySSu+aFo=;
        b=vu5UCSAFSgMHRCuA9slPgHEp363vMAYVoDKCgWJ1yhBZ3FjfagoYw3L2dsKFAcWmIX
         l1ueR4M4XkV1gk5yWtDCtVQ0ovGPfYIBYHaxWJVeGNOvI2nWropyQzR7ivhzGaE+lGmK
         cxDtb7yNZ+E5i5b8B+/ZywdP/btWuwtdbytOBERL46ytI0yU/KTPIEnreVv4Nz0cOrSA
         FPkBU4zRzkOZs1ni/bzlLebWjApJhXcj8xcFEKTL78jOEzaiefdmS9J55PsB9UEfW1Tb
         82KHAGCpBxCZCn+dgwWPqO0eop/EHUYaE5olGHNh+dqlAmMBz9ywEsKgDlI7Ag5asr5P
         2skg==
X-Forwarded-Encrypted: i=1; AJvYcCXR09RMouAaDrc5HMn8elECwnE52YEre5f/pWmOlHD4HIj59hL/uGDRv0ezus1y7kqYdLGdRg56flZ6o8m2@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1uApJo9ACFTOp8co41Vlm1LskrhCBDhc7S/N+R7J1AQnJQ0/
	oPXZxWdoEPcqD6zImJc5ZpBKyr0CCxnvFtPl4ibZ8ytPtUo7EMymq7tNXsBp/IDbMIDbpmpGiUM
	CV7k/fulDFz55Pai9QD1OuWBzQYqeyKyZx7l900CmGlorHI2DebXw1p0OMZA=
X-Google-Smtp-Source: AGHT+IF7XHa4xKbbMTUcDRlaiHw8odsMwQjNRahHEl/nAczVPFt9/Ga/mhJjYvO6JImrwnjh/URNAPkJSwQuE3tsHrjmtYHV+JkU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:11d7:b0:5b7:267c:35c7 with SMTP id
 8926c6da1cb9f-5b9995d68acmr15730270173.2.1764584281993; Mon, 01 Dec 2025
 02:18:01 -0800 (PST)
Date: Mon, 01 Dec 2025 02:18:01 -0800
In-Reply-To: <CAOQ4uxhPEt76ij9zBtdKf0qYwSjeXquGGkLHeArO5t1LhdTHOg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692d6b59.a70a0220.d98e3.0182.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in fast_dput
From: syzbot <syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, neil@brown.name, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com
Tested-by: syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com

Tested on:

commit:         7d0a66e4 Linux 6.18
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b5c192580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=859bdb453c94e06c
dashboard link: https://syzkaller.appspot.com/bug?extid=b74150fd2ef40e716ca2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

