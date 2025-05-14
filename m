Return-Path: <linux-fsdevel+bounces-48996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC29AB741E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C01BA105E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603E27F756;
	Wed, 14 May 2025 18:13:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A0196C7C
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747246390; cv=none; b=p35/qZyqsHd4ZmcL2M78ZiaR2HGNR0suJM4buQroHHZmZZi5I1bCG8CbrDmUOFlIhMMUdxBEdQTu2nYsWq7vGDzx8+5t5PUhNuIxIVWTMBbs/pbZph64qIvHMgAh+lYsLdy+2s3RewXP64e3YRPMB58LKd89CZzjdElNOrBh3Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747246390; c=relaxed/simple;
	bh=dgcGY0n7AGbPNs8raw5es+rISDV20LNw9fg4lNhJ+u0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g6ZGrwb1x2TTbbHazxBkgv8EtIkDYUJ5e+VHhW0BWsbaLNhOrHK9EjE39sO8vuzvfAEp2i136grtpMzvbUR6Hw1PLQx37ZaCcWf1BeWt0SFoJJizRABYYoU5FyIAVcHwNxT441IKyUJG6+IxONi28ZXz3SIC9x/BRzd2t2NeofY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85e4f920dacso2344539f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 11:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747246388; x=1747851188;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpqvsPH3r8Qt61VZkW9wvmDGOmauoC7zd8i7QeBr8aA=;
        b=xMj3/0u6j9UF6uAFFhvn1PJmLBfo+gasXhjXmUl8yor4B/mdQvgpfeD1AnUSKz9wml
         7vDB+jX/XJBBNHDEXxATT1DcXL6COonKHPhXEfJWd5zvOCo7/MMiV44bsCNY7pywBM/p
         gVlLiyLAsJrQ2NFgGeuMzvgNm2a/rxEqPDGJ6pXwDsvm4DMNXCppEfzEuQPeERPT1h3V
         MyD1FwncSuF5UivgxR1o4pMmiKSdGK4JEq+eh3v3nQ5BKiLdXWpOKsd9h6g1OPX1Oxlo
         Z1PNaa8Y9kwqFrZxYf0uuK8+qMBRuXTcrBE4GVaNuknSgujePX0GOIStF481GJYPfK9X
         3YrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7i/XyXFfP3pZIFElP7GUVbPVxuIyd/FhknaQKZgeZKcIfs1Tao8d8VXtroMNHHWC6IDj1CzhNFVREYOW/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3HstWmnXC7F05tmaZJYB0+4Z3IQC22uNd276XdNbiaLm6nZBU
	nB1mF6h0z5D84K8ZGNWbJ947i0AoEeEhghqYBe/jwHkl8VpeDHHJZAWAjHUBIbmC/qxT83YCRXF
	oJQ+q8OvyQHWxm8G6seTkqDtUbisCR3J+8iLON/1jIGYgKekviWt/3vQ=
X-Google-Smtp-Source: AGHT+IF8WqWJm382Apupy6220IhksEs5T0AYLujAMicasvj3LnuzCjw08FBNmwXuEMOYK/+uAVYNTjQ72t3jPgzTArcbEef2UDHq
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d97:b0:3da:7176:81bf with SMTP id
 e9e14a558f8ab-3db6f802380mr54368075ab.21.1747246388573; Wed, 14 May 2025
 11:13:08 -0700 (PDT)
Date: Wed, 14 May 2025 11:13:08 -0700
In-Reply-To: <20250514180521.GN2023217@ZenIV>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6824dd34.a00a0220.104b28.0013.GAE@google.com>
Subject: Re: [syzbot] [xfs?] general protection fault in do_move_mount (3)
From: syzbot <syzbot+799d4cf78a7476483ba2@syzkaller.appspotmail.com>
To: brauner@kernel.org, cem@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo git://git.kernel.org//pub/scm/linux/kernel/git/viro/vfs.git/fixes: failed to run ["git" "fetch" "--force" "8a6d8037a5deb2a9d5184f299f9adb60b0c0ae04" "fixes"]: exit status 128
fatal: remote error: access denied or repository not exported: //pub/scm/linux/kernel/git/viro/vfs.git



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org//pub/scm/linux/kernel/git/viro/vfs.git fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9683d529ec1b880
dashboard link: https://syzkaller.appspot.com/bug?extid=799d4cf78a7476483ba2
compiler:       

Note: no patches were applied.

