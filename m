Return-Path: <linux-fsdevel+bounces-11954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69897859766
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 15:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933741C20A11
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Feb 2024 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFA96BFC7;
	Sun, 18 Feb 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Im2Zh7Z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2364CFF
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Feb 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708266545; cv=none; b=Z275xZ+Cst1MdFSaLiLmAW+APZN5vo2kDmoVjaJ3RanwQ99/STiJS1WoloH0VNkRR+gBvSsJ34SJzfv5qDzIelXShmKHIeyHxukvrKOnq29rKGTd3VkOXuegVE9kw4WmVMk/UPdfeAgd0aHmkh2nf3RiQItMSDc+cn/6qHMnu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708266545; c=relaxed/simple;
	bh=ZILS8+MSeECZcjvDP+eBCya9HDCfU+P6Hc4p6xPStYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kfk5miDbcd1LIv/LquHT2UY4B+4y+vZWtZZln5dqiLxaIbqMXU7PtQo6TO0O8DtdjQOlxzTOhMafCBIiiza+TmRq69hFLaFTjd2T5u6GY+9iC2Tz/J3or0NiEJZ3CjHRv+47oKUT/7V4OSQNJHzDVzUUJtYPSHtHfw86VUOM/7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Im2Zh7Z/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708266542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=107rewdhcNbrR6gWPvfU0GQCTmg7POPTJxhEGe5yAR4=;
	b=Im2Zh7Z/myEKby7Wh/VSYKVvQiE8WUeCvHr1cD8x4fZVvElzpEgbbYwNXcyJBKqLBJO84d
	JqPt4hetac3xBIhKGbKna3sqqLfS2DM51kaGt7lhupXRasipftwrBT9RwILVcNhkAkuiLh
	lr5yzB0dbmoozgaT3rxGe/R2hR/ViJA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-TLOvV-PCPpuXaRsY6PpGcQ-1; Sun,
 18 Feb 2024 09:28:55 -0500
X-MC-Unique: TLOvV-PCPpuXaRsY6PpGcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 220093C29A63;
	Sun, 18 Feb 2024 14:28:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.74])
	by smtp.corp.redhat.com (Postfix) with SMTP id A960C20229A3;
	Sun, 18 Feb 2024 14:28:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 18 Feb 2024 15:27:37 +0100 (CET)
Date: Sun, 18 Feb 2024 15:27:35 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240218142734.GA24311@redhat.com>
References: <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
 <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
 <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
 <20240217135916.GA21813@redhat.com>
 <CAHk-=whFXk2awwYoE7-7BO=ugFXDUJTh05gWgJk0Db1KP1VvDg@mail.gmail.com>
 <20240218-gremien-kitzeln-761dc0cdc80c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218-gremien-kitzeln-761dc0cdc80c@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 02/18, Christian Brauner wrote:
>
> On Sat, Feb 17, 2024 at 09:30:19AM -0800, Linus Torvalds wrote:
> > On Sat, 17 Feb 2024 at 06:00, Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > But I have a really stupid (I know nothing about vfs) question, why do we
> > > need pidfdfs_ino and pid->ino ? Can you explain why pidfdfs_alloc_file()
> > > can't simply use, say, iget_locked(pidfdfs_sb, (unsigned long)pid) ?
> > >
> > > IIUC, if this pid is freed and then another "struct pid" has the same address
> > > we can rely on __wait_on_freeing_inode() ?
> >
> > Heh. Maybe it would work, but we really don't want to expose core
> > kernel pointers to user space as the inode number.

We could use ptr_to_hashval(pid).

> And then also the property that the inode number is unique for the
> system lifetime is extremely useful for userspace and I would like to
> retain that property.

OK.

and perhaps task->thread_pid->ino can also be used as task_monotonic_id(task)
if we move the pid->ino initialization into init_task_pid(PIDTYPE_PID), this
allows to implement for_each_process_thread_break/continue... Nevermind, please
forget.

> > > +	if (inode->i_state & I_NEW) {
> > > +		inode->i_ino = pid->ino;
> >
> > I guess this is unnecessary, iget_locked() should initialize i_ino if I_NEW ?
>
> Yes, it does. I just like to be explicit in such cases.

Well. Of course I won't insist, this is minor. But to me this adds the
unnecessary confusion, as if we need to override ->ino for some reason.

Oleg.


