Return-Path: <linux-fsdevel+bounces-21298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21926901641
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47D2B1C209F0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jun 2024 13:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6CA44369;
	Sun,  9 Jun 2024 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y/+Fbamj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E41C6A7
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Jun 2024 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717939860; cv=none; b=qD9BCv0RIL/QyrY+G2WRmY0xgsyy5GjdyRvf8KoHmBQdArj/2HX8uCqXFRtHw5hBxHG9S2Xj7eus7lkalXE4D1kSlZMx7mdZZPKQcHAuPCGBmWWO2mBO+VefFlY3jGlH8X4f1gRN7bJGYxZZhMBkm1jqz8UCyTCHJ+5ay/IKCaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717939860; c=relaxed/simple;
	bh=PyaUoKoKEXH5JVJAE8F0EcbjshvolazHP2760/iU4Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZ1qYjjT7VposMq/k2e81MNhwsmidjZYDUI5Jpi63AMpECQ8ThIzrVgI6o4GAcJM1VHzRUGEOTcLI6v68YiMM/Jt+O8Z2kp3GTJ6iPKVvb8GIlzoQ9xhHUpeqK7zv7Yj/YhdbUf05UjbSha79qbWC7kfyaKuaxxg3gJvUy1qH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y/+Fbamj; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: syzbot+05c1843ef85da9e52042@syzkaller.appspotmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717939855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dygXqsnU+wgRnyrI1o+oaW814rLgAiGQCKt+uN/iHKM=;
	b=Y/+Fbamj+iSt+yUFE+y2NJYAf5gFxwB5zqsLq3j9Q5FmVJ0/X6BanqEQQYuIw9EmEBsL8V
	16VqwngI/gm7+rgKhtluo3u8xK6LYeklQs/6i1C3qNtNaDTj52JMaDoewD2ga7Kdfas2wZ
	6oPhyJd7U5xGsPWzN//VC3cAyi2kKbo=
X-Envelope-To: bfoster@redhat.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
Date: Sun, 9 Jun 2024 09:30:50 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: syzbot <syzbot+05c1843ef85da9e52042@syzkaller.appspotmail.com>
Cc: bfoster@redhat.com, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_fs_recovery
Message-ID: <6tvlkgpsd3ikgyez6abnv4m3dri6atxu4fkxtzclsnejw4wmur@476lz26ii4sh>
References: <0000000000008160ad06179354a2@google.com>
 <0000000000009ea02f061a741be4@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000009ea02f061a741be4@google.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Jun 09, 2024 at 05:24:02AM -0700, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 7ffec9ccdc6ad8356792f9a7823b1fe9c8a10cbf
> Author: Kent Overstreet <kent.overstreet@linux.dev>
> Date:   Fri May 3 14:55:17 2024 +0000
> 
>     bcachefs: don't free error pointers
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13191932980000
> start commit:   ddb4c3f25b7b Merge tag 'for-linus-6.9a-rc7-tag' of git://g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
> dashboard link: https://syzkaller.appspot.com/bug?extid=05c1843ef85da9e52042
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1464ea2f180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130db31f180000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
#syz fix: bcachefs: don't free error pointers

