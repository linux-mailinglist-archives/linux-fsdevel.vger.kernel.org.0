Return-Path: <linux-fsdevel+bounces-10874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F2284EF74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 04:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B8D2885C6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 03:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E1A567A;
	Fri,  9 Feb 2024 03:41:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F15258
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 03:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707450080; cv=none; b=uOfrFNg9CDqRPXCMRpZF9FPxGH9H4qmXURE3S7NB3/ZP5+dsS5t7mpNwULYDw4gjBs4HCuX8zKNtxnz/N3eFv3XlhxFMzRKhdWjukJIC+25RvH+RRXStAq2LqQ14jgyc3YwekNODP+lY2wZR14vaSxivAX3r7nM1m43paASSXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707450080; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Zo8RXL7mF5eNtdQ09a6uwIckYJPEcytiaAfAFJXKKPKZmDLTZD3J8FGppIQXbrQ3hJHbj++Ef9qF+h2qEY2QtuUlfXa0fNJfYAXKjCqcchpgZDf62jgV4lhsrYDVmdSg0em7EXi945qUcVDUghU6VnOUWCAOi0QhGTSAy/Kbo4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bef67c486aso42330639f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 19:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707450078; x=1708054878;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=E+jprQsIjAywSHndVZU3dM/IFROlzdJN9m0tzvAC9MYGQwKYcYIPNvVvf0yxAgzL4t
         4Rj5NadwpAUTdNmCppyYuHl1IvXFHU3b0abxEo4ICLcG+OxoZnCpsWoxCwJgX/REClsf
         sfSgCdm9BvoiqMOxVov45k38Zwiz+Ap8S12ikwjxY4KA/avEhRalTGMxdLDnPcxV6xrp
         HVYjpGvVYbKQDEHTV9q0UHhbnIId30sCTHoVRh83Z8q7thQ7VN1sjWq8UIqp7OeGhiHf
         HzDY9IV9Z3h5Y+yAMOxC5MxfrSf8nBIuAn5RBVLLb3PKHTmPhJ6+feLIkUel79vNaD9Q
         TNtQ==
X-Gm-Message-State: AOJu0Yzi8KIOUqjOFB7enMe3MT/ds+3+AVCfRoN/pymVrHlynjYyZjCL
	q/n4qoLjTi7YEWS4FV5ZasyPrBqkEx1CMcLyQb/No8aWbf1+uY89ebSdOgwcXfT/150LDmbZMkF
	c9uZlnzgXvkU16n61CQ2+jkCH85bi7WUV1E1jqkQoeHQAfRI7B7xX2zE=
X-Google-Smtp-Source: AGHT+IEGITcXVjcVGileirP4Yke73RZOhQlFl7lZp06ObTOHCMoSuoh2VVmuIwAwVRDEWZjfhGP38xIZYgwoo9EPbVH6doLpu8aU
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:480a:b0:470:fa4e:18f with SMTP id
 cp10-20020a056638480a00b00470fa4e018fmr5640jab.3.1707450078481; Thu, 08 Feb
 2024 19:41:18 -0800 (PST)
Date: Thu, 08 Feb 2024 19:41:18 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006654780610eab315@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

