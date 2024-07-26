Return-Path: <linux-fsdevel+bounces-24288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C18593CD13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 05:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF50C282C8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 03:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354912B9B6;
	Fri, 26 Jul 2024 03:49:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75951442F
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721965758; cv=none; b=LBNmWh0agk7mkLn08Ubjc8Oy6102P04RmtxN5424VDN4OplFTD5WJX4ItflVptbxKFznLnvH1+kAwXzefTi9lRSNoJaWzaqAC3/gaHcp+jm948/4ovpwzTRrYNtc6gRT0ZbVisy/4ycixolaKMAJcOEBgVCtrYj0W6JaBi72SUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721965758; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W+73JmbMjEjXtuPLOuOZqBnAJ/8TryFEeiPWyVB8yNRiKwYOimdZatPNZSBomvuW5E2x0cLDQx4Yzw7rLh7IPlk5dhwfRYiEcUs5qDiQ+RqtFxMmbxUFyGB8g/hxbD31IxwWjcIGtSl6YIqbsm+AwwW36VFSv7hHPL90vUCY19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39945779edaso17852895ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2024 20:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721965756; x=1722570556;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=qK4ATYMOHWVhFlTlmS8QGChNgzfHxjJNN4DI7/Bouo2BkfLwtApVoKSnSVObe9LuwJ
         9e6H1NTJvXFA0G4elQMY3hlhdwIUoMhsPepNlRa0+7BrxWiCXTUhUWXdQXeUwD1J7M1T
         opfchYldi7/jcCEGvWa1M1GZa+9ZtY1M4xsM3JjRvREtIdYUIuUoZxh25qeUaGRHh/66
         LWEsjJ4AFQFud59DGej3LVTecktKRIRw/0RrOqXGE2gFxVGsw07qnPSpbqjnY09v1+2s
         WQA0v5vgz4ChdNrhOFmfmb5lQPBnnQfxVVcbolUWU2AT8oMGMZNLLezs9ZSc/JYcI2kG
         dNgg==
X-Forwarded-Encrypted: i=1; AJvYcCVB0BErtgWbmmCl72bQNQ9ua1bqCUG9T0sb4ORjC+VROecItsKtb2zGchD038b0ugPwjAouy7veUP0BFRfR4/6swFsTNkA9NdqeHykSSQ==
X-Gm-Message-State: AOJu0YwxtVJmfywelEbCgHmrAhj98PHud5OMEHvV+OY55X5bsEKsdVHU
	mwMm/e/aIXYlLZBwHpufJkjTJPPZ674feDFfrqA72r7Fy5FLvzqjGDkbnXdE73Ki2WY0VLimbb3
	ebxmrjUEiV49q/xtWDblIevbqn0GITJI/7Z9JFqQTxEjrMGz5wwelAwU=
X-Google-Smtp-Source: AGHT+IGVxDfTZyj3MA9baZrtud7k5xDLfonIewOkOSq9/ct8qPqAYhIrYw1oXuG3klibzz/6OMWw9vi8eO+gii7aToGwnCPs9lAx
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a86:b0:382:6a83:f4fc with SMTP id
 e9e14a558f8ab-39a2185cc84mr2796975ab.5.1721965756603; Thu, 25 Jul 2024
 20:49:16 -0700 (PDT)
Date: Thu, 25 Jul 2024 20:49:16 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cee2a061e1e65b0@google.com>
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

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

