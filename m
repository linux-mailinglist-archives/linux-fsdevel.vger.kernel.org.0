Return-Path: <linux-fsdevel+bounces-62203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B13F2B8820C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 09:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798151C861DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 07:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF37287262;
	Fri, 19 Sep 2025 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKqjoAGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0341A9F93
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758266191; cv=none; b=kNiqlycA0AGzLOXBa4b01o4YeD4NYblysuxi3h/2RzkpLCxfqVQD7agFX1ewFODLWdHZrSAFes8EyDErZOcCzwQ6/9h4U02WFHF1ybMUD4yNFCQ1cZ55x7Qjdt1mpPd6RnLwkz1pmHv6F3iL2PlQuQGCNWhB1KDOffZT2coNF7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758266191; c=relaxed/simple;
	bh=abGph3h2Vv+iWytEEvTIhckiE64woXSmUp537gS9Rfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HBPiFjOUD8b1DY/Fiy09logOv7vFem6AxBBoZd1ob0ZnIihWKwHGLq0b5Ei8bDMzNvunkD0bcAYgIeWHt1OU1+wx/i5zIK2g60iU9BmA6G0VG9jHelCzv0cFmiZZsifLVtiv0n2uADnksTz0gnfalAch6q1SyUuS11wp4QcNE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKqjoAGz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758266189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=84Etj288ZL1mWyMg4qOb4gbjSyPee4cfVRuJExbnQkA=;
	b=DKqjoAGzVX++XFzCR1m0tYgwzTcPy19mAiWBqwJ+ECrolr4aemyF1Wkh2ILiP6w+JpFv/F
	Ualf6l764UvhKH6eMOQf7VzNjOB9zXf2qew9BBVqyGsiOAzUXCEJegAL23c6ZmLV0udoU/
	DoaptbdZsIvtP3LWcHJ1EZ3h1e3OwCo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-oerQSmVxMgawAOdC8RF6Kw-1; Fri,
 19 Sep 2025 03:16:25 -0400
X-MC-Unique: oerQSmVxMgawAOdC8RF6Kw-1
X-Mimecast-MFC-AGG-ID: oerQSmVxMgawAOdC8RF6Kw_1758266183
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B97C180057B;
	Fri, 19 Sep 2025 07:16:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 03AF819560BB;
	Fri, 19 Sep 2025 07:16:18 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 19 Sep 2025 09:14:59 +0200 (CEST)
Date: Fri, 19 Sep 2025 09:14:54 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: syzbot <syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, dhowells@redhat.com, jack@suse.cz,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev,
	pc@manguebit.org, syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [netfs?] INFO: task hung in vfs_utimes (3)
Message-ID: <20250919071454.GA20615@redhat.com>
References: <68cb3c24.050a0220.50883.0028.GAE@google.com>
 <68cca807.050a0220.28a605.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68cca807.050a0220.28a605.0013.GAE@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/18, syzbot wrote:
>
> syzbot has bisected this issue to:
>
> commit aaec5a95d59615523db03dd53c2052f0a87beea7
> Author: Oleg Nesterov <oleg@redhat.com>
> Date:   Thu Jan 2 14:07:15 2025 +0000
>
>     pipe_read: don't wake up the writer if the pipe is still full
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=175fa534580000
> start commit:   46a51f4f5eda Merge tag 'for-v6.17-rc' of git://git.kernel...
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14dfa534580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10dfa534580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
> dashboard link: https://syzkaller.appspot.com/bug?extid=3815dce0acab6c55984e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17692f62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1361f47c580000
>
> Reported-by: syzbot+3815dce0acab6c55984e@syzkaller.appspotmail.com
> Fixes: aaec5a95d596 ("pipe_read: don't wake up the writer if the pipe is still full")

#syz dup: [syzbot] [fs?] [mm?] INFO: task hung in v9fs_file_fsync

https://lore.kernel.org/all/68a2de8f.050a0220.e29e5.0097.GAE@google.com/


