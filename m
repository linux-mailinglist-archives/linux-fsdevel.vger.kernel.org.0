Return-Path: <linux-fsdevel+bounces-11913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABAC858FE0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 15:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C111F2200C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 14:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CCE7AE6B;
	Sat, 17 Feb 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3SdzMKy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22942A96
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708178442; cv=none; b=GSW9IwME5qi1zA0tGxcGK9aQG0obIWX9xnjZxWaGg0y5LLPuqony55lg/E2YU/xyKqPpzOvHCU/UeblTwMQyASouvzxMAfOrojnjyam7TLDfeUlsBuMagv7ogFD8D9Zw6KWOXkjmehs6YfqXtEvwm47od8cW5CRDl5bfy/95hO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708178442; c=relaxed/simple;
	bh=hOtNnDWKysX+78J5S0qf1n5yUp9rsNswcd6qtm0eaDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=syYpNx41ljny7tAXTl8FZQvn+3NJpE0SIRvIkn/gmrhuYSwWeo0x6tlN7524Z/DwzJ3o3ZrWAfkNXPMFDcieJfeAjC/GPQm8xgZHYM7QRmtp37JMUkYkVxJV4UaEeYv0BuJ3Gk4NV3B3TVY44OG/A/vUsomDB8QfDSacn6GJrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K3SdzMKy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708178440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XyMzDIR8J9H+stxJHv4qSgc1X1lzUltOn9HOx337RJE=;
	b=K3SdzMKygBt5iQ1PIth5m9xeEUpBYBnuV1TSPG3qQn3vBVHTjCf9tUzN0dq0f/c9GioUlH
	CWIBf55EyN/2v8Hz69756aVhC/nPpGIHbY4KCxzDxyO2sRfe1KNqAfEVy2rLqwgH5sfO40
	hVqLd0fsUgPMQzfy4QfVA3wdRglGmws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-7i3jfpKbOca3yGv000klnA-1; Sat, 17 Feb 2024 09:00:37 -0500
X-MC-Unique: 7i3jfpKbOca3yGv000klnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BCB983B7E5;
	Sat, 17 Feb 2024 14:00:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.33])
	by smtp.corp.redhat.com (Postfix) with SMTP id 43B708CED;
	Sat, 17 Feb 2024 14:00:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 17 Feb 2024 14:59:19 +0100 (CET)
Date: Sat, 17 Feb 2024 14:59:16 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240217135916.GA21813@redhat.com>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <CAHk-=wjr+K+x8bu2=gSK8SehNWnY3MGxdfO9L25tKJHTUK0x0w@mail.gmail.com>
 <20240214-kredenzen-teamarbeit-aafb528b1c86@brauner>
 <20240214-kanal-laufleistung-d884f8a1f5f2@brauner>
 <CAHk-=whkaJFHu0C-sBOya9cdEYq57Uxqm5eeJJ9un8NKk2Nz6A@mail.gmail.com>
 <20240215-einzuarbeiten-entfuhr-0b9330d76cb0@brauner>
 <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216-gewirbelt-traten-44ff9408b5c5@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On 02/16, Christian Brauner wrote:
>
> +struct file *pidfdfs_alloc_file(struct pid *pid, unsigned int flags)
> +{
> +
> +	struct inode *inode;
> +	struct file *pidfd_file;
> +
> +	inode = iget_locked(pidfdfs_sb, pid->ino);
> +	if (!inode)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (inode->i_state & I_NEW) {
> +		inode->i_ino = pid->ino;

I guess this is unnecessary, iget_locked() should initialize i_ino if I_NEW ?

But I have a really stupid (I know nothing about vfs) question, why do we
need pidfdfs_ino and pid->ino ? Can you explain why pidfdfs_alloc_file()
can't simply use, say, iget_locked(pidfdfs_sb, (unsigned long)pid) ?

IIUC, if this pid is freed and then another "struct pid" has the same address
we can rely on __wait_on_freeing_inode() ?

Oleg.


