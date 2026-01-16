Return-Path: <linux-fsdevel+bounces-74121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE70D32170
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 14:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049B0309F717
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DF8202F65;
	Fri, 16 Jan 2026 13:44:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6E1230274
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571046; cv=none; b=KMBs3HTqoKQpubg/h8bC8XNQVLtrVZJ1rDmMfPA5igqSy+Fj5j4xZ5ygFMYqskcRn/0EVnAecQjnY2rzt0BQwjof4E0d5LO3r7PywHc+GF8iEGy5fdWbzcwGkhmtJ3uA7x0XaE1pABx22RPosQ8KQx/dsESO3goRXdT/LEPRGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571046; c=relaxed/simple;
	bh=JaYEZM6yWgI6Sg0RHWXWYEM58EDO1cvBO7S/WQm4FrQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ii3H8r1DcjEtNRsHVML+4Bruij8/Js4zVEo6tvTocOFEwf65jV5ALqXX4z6VWQB4SFa9WVs6/mVOMBW/PfmItAXKgRYRdTk8jTkhkZK8H94nNyPjeJmqxpOUbFsBv0ogMOvTXhnueLwCk+lOsvJpAHAO24ZJjHZoNRz+yEIi49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-45a684d8f6aso7454757b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 05:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768571043; x=1769175843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObNAliYPyAfNrDscf+JIUAia546ZXauaiid+xM8oNYE=;
        b=jlzQUNt7JFowgwnEpdocFZgrdAC5DvJqN5OA1JiRPgberW7gOSf0sU8rP499peQZuj
         Mgu8YN40+JSSZoO0n3+Un+4J0DKgFV7mCKLsF6qrhQRo+A7u9b606lBlvDiAtlkvuMab
         Cwhb7jmNmcfLaBYgbQozEEhxaDqp+djFYmrowOzG4y7kGPKHEf19EGbUS9t/fYADOo2O
         Oo0RDga+DS4+laZ239FF8QLHnVQn/yYSuvQXALOsT3m4WohLi4sIThY+Ofnbx1hhnvbZ
         WwvnBCLDhpbNYFDzSxgpUNP1O/Xl8YrXfFSZRIP/3Fy/+6EOGsHxhocsIn1dlBb0Ku4t
         hs0g==
X-Forwarded-Encrypted: i=1; AJvYcCVE7+m8VAiEcOcQTTycE42k82/ECpgk3aIvOh3TyQmMEc+bjWvt/CsezNBkvZ4To0fPbIaijVzpB4RMWWvJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwtZwDD96HAvRWuK8xQw6b0cF6EgV2qiFWg0249kmg2PdZlpYJU
	BwDbEEez89YvHt9uRGG+fCUy50DcOUP5piRbOWCgwHuXoA93kyTF3choQJCwkVUWKrCmvQcmMR+
	Hz5NeEj/rACPPbojp3Kuj/YrHbSBTvYby+kMV2XHKvtk+iiO5nz3dTW0lEes=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:50aa:b0:44f:ef44:9cc4 with SMTP id
 5614622812f47-45c8817ac81mr3519113b6e.32.1768571043001; Fri, 16 Jan 2026
 05:44:03 -0800 (PST)
Date: Fri, 16 Jan 2026 05:44:02 -0800
In-Reply-To: <20260116-kostbar-blass-171a72be1845@brauner>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696a40a2.050a0220.58bed.004d.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in put_mnt_ns
From: syzbot <syzbot+55fd613012e606d75d45@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+55fd613012e606d75d45@syzkaller.appspotmail.com
Tested-by: syzbot+55fd613012e606d75d45@syzkaller.appspotmail.com

Tested on:

commit:         e64f65a7 FOLDME
git tree:       https://github.com/brauner/linux.git vfs-7.0.namespace
console output: https://syzkaller.appspot.com/x/log.txt?x=15fac39a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dac5329a4190a189
dashboard link: https://syzkaller.appspot.com/bug?extid=55fd613012e606d75d45
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

