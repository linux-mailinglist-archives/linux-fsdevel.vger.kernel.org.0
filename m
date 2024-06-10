Return-Path: <linux-fsdevel+bounces-21356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D71D9029B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 22:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EE62285B12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 20:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD25614F9D1;
	Mon, 10 Jun 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvzNYb5u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E8314E2FC
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050154; cv=none; b=MuqJFeR8A0lq1L8Y5L9iBjLzbt+QIjupasszSKJbSdhcZnyDTwolJQzBQl/xp+do91ItxkJhzXwTINmIJ3+dhP/ezVBp7N6F1d5bKnsU/imKl6rq9Wr7p5NA4i/McMuV8Zuc32bsjTQoy+W2JREc+Xs1II/4Np/Krr4+IcTtpQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050154; c=relaxed/simple;
	bh=tbRToXYI1dKQeNsMHmTAg10R11nvpLrhVyGq9kTnlwo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpiLxFw5oM7wCDb8nitKTsbcyRKcPB/aXa2ERzpmoFW7CNNgMN3bhL6K8MzP2sKW8lLBT2E+6n76/xQPlxFD53N/Gl4Jb+iEbQB9xtieqEjg+HKKfBlr71/4vuVLzpSS8tQfR1/XefvnWJoRT/DoLd3PI8R4rQCDTlMx0vzE2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cvzNYb5u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718050151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x0uDremmGP2R6fYTU5zqp2q9RT15Ma3YxDb0XclXTpI=;
	b=cvzNYb5u88Up/OGP1GifPneQYVOCw43MUoB7VMRWrbEgDrzsgnuGfHG7UTipawTaJZBd9a
	Rjp7Lhyqn5Jux1QhfH8kqYoUFX1+R+t8/mejBzU0aOE0jTM5+a9msCRF/ggSjzuqs/v0Cn
	S2QtAeevRSDZVRm1b2npE3eqvZYaZOM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-EqTuRIs4NLun4NVBTsscPQ-1; Mon, 10 Jun 2024 16:09:09 -0400
X-MC-Unique: EqTuRIs4NLun4NVBTsscPQ-1
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3737b6fc28fso46937275ab.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jun 2024 13:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718050149; x=1718654949;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0uDremmGP2R6fYTU5zqp2q9RT15Ma3YxDb0XclXTpI=;
        b=FpE5oTChWahpJDdvjnPKZ+v8AsSRwUvWud1go2V/oEu7BPYuKLtSYLGPL3ADRB96Vn
         qP5+RyzkhoWmfvTy3cB3PpEZyOvl6OyOTy0IdtO94ZGK+wjUJ9il0yrnPoBRxuJMvPTQ
         SRlNtKed36h9kLonneiLQqpfyd9OCkxBHzw06POjyPXWOjwvg7BLIKiMyXZjhbb4lgtP
         FOZfPhWRGZWpeElStUNzTO4bEfF9Lr3u/FwEZGtGhsTGJi5Ul4Goat8OEwj32Hrpe2w3
         RSHvpqyXkh4Zl1E4rqUawstADSx8yLinSok/ovPjB0sZKQRv20MrVDs2VFBEg46ROeW3
         Y8UQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoTnlzX8ZrVg8MO1CO8b6ltyUGH37/WkFRRge1cHlwWCP0B5BlWrCtWjQxdhm+jYqjUNIeADmpmidLmNcpMKLePcmyBOEfUiXOn9j2uw==
X-Gm-Message-State: AOJu0Yzfs2tQI9iBarsjLtMxGqzpsXf0REQhpmFB6fmiciueh9K25sAb
	eVmyudnRvC1DMGtFD6FOaRExLnVfkIZqx92u98P+rGHgDGOqTksF9L7yG5XZ4keDxuhXlUlp7lL
	pqFKp/k5cHk6o5OyhO/7Wflw2cbtqPZ+PN3NzGEBMEpv6RktRoxsIJWEMIP/+xvI=
X-Received: by 2002:a92:c747:0:b0:375:946b:5974 with SMTP id e9e14a558f8ab-375b3258671mr6154245ab.10.1718050148529;
        Mon, 10 Jun 2024 13:09:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE59XiJPEBkAEGg2K+0wSV6LwyrnkemA7wvAIeFwQDC+qmQQk37ZBox/cufTvcsxGXNK+XBBA==
X-Received: by 2002:a92:c747:0:b0:375:946b:5974 with SMTP id e9e14a558f8ab-375b3258671mr6154025ab.10.1718050148163;
        Mon, 10 Jun 2024 13:09:08 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a24cfff8sm2702137173.168.2024.06.10.13.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:09:07 -0700 (PDT)
Date: Mon, 10 Jun 2024 14:09:06 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Fei Li <fei1.li@intel.com>, kvm@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] UAF in acrn_irqfd_assign() and vfio_virqfd_enable()
Message-ID: <20240610140906.2876b6f6.alex.williamson@redhat.com>
In-Reply-To: <20240610051206.GD1629371@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
	<20240607015957.2372428-1-viro@zeniv.linux.org.uk>
	<20240607015957.2372428-11-viro@zeniv.linux.org.uk>
	<20240607-gelacht-enkel-06a7c9b31d4e@brauner>
	<20240607161043.GZ1629371@ZenIV>
	<20240607210814.GC1629371@ZenIV>
	<20240610051206.GD1629371@ZenIV>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 06:12:06 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> In acrn_irqfd_assign():
> 	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
> 	...
> 	set it up
> 	...
>         mutex_lock(&vm->irqfds_lock);
>         list_for_each_entry(tmp, &vm->irqfds, list) {
>                 if (irqfd->eventfd != tmp->eventfd)
>                         continue;
>                 ret = -EBUSY;
>                 mutex_unlock(&vm->irqfds_lock);
>                 goto fail;
>         }
>         list_add_tail(&irqfd->list, &vm->irqfds);
>         mutex_unlock(&vm->irqfds_lock);
> Now irqfd is visible in vm->irqfds.
> 
>         /* Check the pending event in this stage */
>         events = vfs_poll(f.file, &irqfd->pt);
> 
>         if (events & EPOLLIN)
>                 acrn_irqfd_inject(irqfd);
> 
> OTOH, in
> 
> static int acrn_irqfd_deassign(struct acrn_vm *vm,
>                                struct acrn_irqfd *args)
> {
>         struct hsm_irqfd *irqfd, *tmp;
>         struct eventfd_ctx *eventfd;
> 
>         eventfd = eventfd_ctx_fdget(args->fd);
>         if (IS_ERR(eventfd))
>                 return PTR_ERR(eventfd);
> 
>         mutex_lock(&vm->irqfds_lock);
>         list_for_each_entry_safe(irqfd, tmp, &vm->irqfds, list) {
>                 if (irqfd->eventfd == eventfd) {
>                         hsm_irqfd_shutdown(irqfd);
> 
> and
> 
> static void hsm_irqfd_shutdown(struct hsm_irqfd *irqfd)
> {
>         u64 cnt;
> 
>         lockdep_assert_held(&irqfd->vm->irqfds_lock);
> 
>         /* remove from wait queue */
>         list_del_init(&irqfd->list);
>         eventfd_ctx_remove_wait_queue(irqfd->eventfd, &irqfd->wait, &cnt);
>         eventfd_ctx_put(irqfd->eventfd);
>         kfree(irqfd);
> }
> 
> Both acrn_irqfd_assign() and acrn_irqfd_deassign() are callable via
> ioctl(2), with no serialization whatsoever.  Suppose deassign hits
> as soon as we'd inserted the damn thing into the list.  By the
> time we call vfs_poll() irqfd might have been freed.  The same
> can happen if hsm_irqfd_wakeup() gets called with EPOLLHUP as a key
> (incidentally, it ought to do
> 	__poll_t poll_bits = key_to_poll(key);
> instead of
>         unsigned long poll_bits = (unsigned long)key;
> and check for EPOLLIN and EPOLLHUP instead of POLLIN and POLLHUP).
> 
> AFAICS, that's a UAF...
> 
> We could move vfs_poll() under vm->irqfds_lock, but that smells
> like asking for deadlocks ;-/
> 
> vfio_virqfd_enable() has the same problem, except that there we
> definitely can't move vfs_poll() under the lock - it's a spinlock.

vfio_virqfd_enable() and vfio_virqfd_disable() are serialized by their
callers, I don't see that they have a UAF problem.  Thanks,

Alex

> Could we move vfs_poll() + inject to _before_ making the thing
> public?  We'd need to delay POLLHUP handling there, but then
> we need it until the moment with do inject anyway.  Something
> like replacing
>         if (!list_empty(&irqfd->list))
> 		hsm_irqfd_shutdown(irqfd);
> in hsm_irqfd_shutdown_work() with
>         if (!list_empty(&irqfd->list))
> 		hsm_irqfd_shutdown(irqfd);
> 	else
> 		irqfd->need_shutdown = true;
> and doing
> 	if (unlikely(irqfd->need_shutdown))
> 		hsm_irqfd_shutdown(irqfd);
> 	else
> 		list_add_tail(&irqfd->list, &vm->irqfds);
> when the sucker is made visible.
> 
> I'm *not* familiar with the area, though, so that might be unfeasible
> for any number of reasons.
> 
> Suggestions?
> 


