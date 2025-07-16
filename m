Return-Path: <linux-fsdevel+bounces-55044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81FB06A52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B63D7A39A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16804A06;
	Wed, 16 Jul 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dlnIusNm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF0634;
	Wed, 16 Jul 2025 00:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624534; cv=none; b=OqC+/r/LOmK+IkAlrMei8squJNROW3O8nVHmiGtCCYlUGzOCAa+gjgzG3JysH1kTjoQlk4pANDYKeSDMTx0Tra2qoVvpLJh+RcWpfcq2M1axAt+wAXAkKK7miw0QZJ1hweeOQIeCtTYNqgH7fm2oJTA0XOFv6mxX7lcI4irXkoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624534; c=relaxed/simple;
	bh=XdTozw9SeWnYJKO34jlRMm1atgrylh7X/YNvThna1SI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LXpJQlDcxo9GvV+LuVweHMl+GstI4QZITLtldJdc7m9UosjIIkqKh8Gre5+ZY1I22+R0ng3FCCqqJXjbSpwC/xYoQLRVOAo/KeS/s1ea5wWjDCoTiWGOKFLJ6Bwzt6np8cZOSp3r2CpShwOsp3Y52k9H06eSyr7t/1YbAFLuK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dlnIusNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6A7C4CEE3;
	Wed, 16 Jul 2025 00:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752624533;
	bh=XdTozw9SeWnYJKO34jlRMm1atgrylh7X/YNvThna1SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dlnIusNm7JiiK5MYJ5R+EFfeHMi9x8k5Xosd+TG1LASG2W8Y0rHcTMqs+0Vui+e9p
	 QsRGbIcpBj5U09553O3+GQ8dXv10Ofu35Kkayy4Fd65sNT+NySe1NFqSELuw5fuW3N
	 8YeTjUVReHhLf68gl3HvCrFCoTwB3ViL2ui0hUBA=
Date: Tue, 15 Jul 2025 17:08:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, david@redhat.com, hdanton@sina.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com, surenb@google.com,
 syzkaller-bugs@googlegroups.com, linux-mm@kvack.org
Subject: Re: [syzbot] [fs?] WARNING: bad unlock balance in
 query_matching_vma
Message-Id: <20250715170852.e616b82a53a88e757ee342af@linux-foundation.org>
In-Reply-To: <687628be.a00a0220.3af5df.0002.GAE@google.com>
References: <68757288.a70a0220.5f69f.0003.GAE@google.com>
	<687628be.a00a0220.3af5df.0002.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Jul 2025 03:09:02 -0700 syzbot <syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com> wrote:

> syzbot has bisected this issue to:
> 
> commit fb8a9ee1f05345b1fae37902d32d954d2150437b
> Author: Suren Baghdasaryan <surenb@google.com>
> Date:   Fri Jul 4 06:07:26 2025 +0000
> 
>     fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=171c27d4580000
> start commit:   a62b7a37e6fc Add linux-next specific files for 20250711
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=149c27d4580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=109c27d4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bb4e3ec360fcbd0f
> dashboard link: https://syzkaller.appspot.com/bug?extid=d4316c39e84f412115c9
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ad50f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1173018c580000
> 
> Reported-by: syzbot+d4316c39e84f412115c9@syzkaller.appspotmail.com

Thanks.

This email (and the original bug report) lacked a cc:linux-mm@kvack.org.

> Fixes: fb8a9ee1f053 ("fs/proc/task_mmu: execute PROCMAP_QUERY ioctl under per-vma locks")

Could I suggest that your scripts be altered to parse the fb8a9ee1f053
changelog for its Link:, fetch the submitter's original email and from
that, figure out which mailing list(s) were cc'ed?

> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Suren, I'll drop the v6 series from mm-new.  Links which I have
accumulated are:

https://lkml.kernel.org/r/6871f94b.a00a0220.26a83e.0070.GAE@google.com
https://lkml.kernel.org/r/f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local
https://lkml.kernel.org/r/687628be.a00a0220.3af5df.0002.GAE@google.com
https://lkml.kernel.org/r/687628be.a00a0220.3af5df.0002.GAE@google.com

