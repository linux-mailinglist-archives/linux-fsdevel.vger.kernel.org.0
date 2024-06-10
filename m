Return-Path: <linux-fsdevel+bounces-21311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDA7901A35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 07:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4711C20C34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 05:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43598101E2;
	Mon, 10 Jun 2024 05:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ik0ekPw0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A41852;
	Mon, 10 Jun 2024 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717997726; cv=none; b=kUNrlE9VG2jkWjmT90I3jDsBGRefsuFjhFpdXuYEM8OPd0sSLmUblJrb1WBnTPJUUrdGdlLHziuLhVEy2XSb2gmO7MTjL3HuYOFK7z2Qkm9CMiXgNlneUzoFX2LTzgFFfdy6/nP+9NxoFiVIM7xtOktoAcPNx+G05BbgpZxZfpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717997726; c=relaxed/simple;
	bh=j5JDaMwuzJvc73EGL77K10m92BLzD8OND8bZM7llTHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UErLXw1Ye3M+azkMHVH5zU6fEoJfN5eN8lv7kmHK82Z1HWuc9cVbM+jE1u1aEXUz98UJd1l0ZqloJ5AbH5KbOA7fY5q48bDDtWELuC1UcRfH70FnaaeCopyOEXd+m2P75y07CJ0+9kmqR1Ctl0v79sJV+2kmQsvtuIv+OPsmgQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ik0ekPw0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eB0NMMEEXOM2b2CYR7Yv3NlVBKULaZ5fvEsvZRl6UCM=; b=ik0ekPw0EQjtiH+5BdPz5Qlw0V
	A3zpcoqkjm5sVEpkhsXBjpZmMuDQZcyg53ghnS07iwAryrgCNLW1zLyZN76Hjy20YLyjGBIEuFOm3
	9q6JDb3ljqbkNabzfM6WV63r/a8j7CILx72udH4IznkNlgxrt6ORWj9kn/GnIxOmMdd8KBeAxYYN/
	BPEwYDrM4u2Brqj7tFV2XfljfIa97FE45o0iZBVpnbSYJpuj36GDelA/ISCemX8NZ/U282I6SFJPP
	zGyTt4o1oJboeFg2ykrsQMjlvmh3V1U+a+8DoVQ7bmLdQqPzmZvg/1kuyTW4xEINYrgNBzvXxmtCd
	VvZNhxNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sGXKA-006dpp-0V;
	Mon, 10 Jun 2024 05:12:06 +0000
Date: Mon, 10 Jun 2024 06:12:06 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Fei Li <fei1.li@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC] UAF in acrn_irqfd_assign() and vfio_virqfd_enable()
Message-ID: <20240610051206.GD1629371@ZenIV>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-11-viro@zeniv.linux.org.uk>
 <20240607-gelacht-enkel-06a7c9b31d4e@brauner>
 <20240607161043.GZ1629371@ZenIV>
 <20240607210814.GC1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607210814.GC1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

In acrn_irqfd_assign():
	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
	...
	set it up
	...
        mutex_lock(&vm->irqfds_lock);
        list_for_each_entry(tmp, &vm->irqfds, list) {
                if (irqfd->eventfd != tmp->eventfd)
                        continue;
                ret = -EBUSY;
                mutex_unlock(&vm->irqfds_lock);
                goto fail;
        }
        list_add_tail(&irqfd->list, &vm->irqfds);
        mutex_unlock(&vm->irqfds_lock);
Now irqfd is visible in vm->irqfds.

        /* Check the pending event in this stage */
        events = vfs_poll(f.file, &irqfd->pt);

        if (events & EPOLLIN)
                acrn_irqfd_inject(irqfd);

OTOH, in

static int acrn_irqfd_deassign(struct acrn_vm *vm,
                               struct acrn_irqfd *args)
{
        struct hsm_irqfd *irqfd, *tmp;
        struct eventfd_ctx *eventfd;

        eventfd = eventfd_ctx_fdget(args->fd);
        if (IS_ERR(eventfd))
                return PTR_ERR(eventfd);

        mutex_lock(&vm->irqfds_lock);
        list_for_each_entry_safe(irqfd, tmp, &vm->irqfds, list) {
                if (irqfd->eventfd == eventfd) {
                        hsm_irqfd_shutdown(irqfd);

and

static void hsm_irqfd_shutdown(struct hsm_irqfd *irqfd)
{
        u64 cnt;

        lockdep_assert_held(&irqfd->vm->irqfds_lock);

        /* remove from wait queue */
        list_del_init(&irqfd->list);
        eventfd_ctx_remove_wait_queue(irqfd->eventfd, &irqfd->wait, &cnt);
        eventfd_ctx_put(irqfd->eventfd);
        kfree(irqfd);
}

Both acrn_irqfd_assign() and acrn_irqfd_deassign() are callable via
ioctl(2), with no serialization whatsoever.  Suppose deassign hits
as soon as we'd inserted the damn thing into the list.  By the
time we call vfs_poll() irqfd might have been freed.  The same
can happen if hsm_irqfd_wakeup() gets called with EPOLLHUP as a key
(incidentally, it ought to do
	__poll_t poll_bits = key_to_poll(key);
instead of
        unsigned long poll_bits = (unsigned long)key;
and check for EPOLLIN and EPOLLHUP instead of POLLIN and POLLHUP).

AFAICS, that's a UAF...

We could move vfs_poll() under vm->irqfds_lock, but that smells
like asking for deadlocks ;-/

vfio_virqfd_enable() has the same problem, except that there we
definitely can't move vfs_poll() under the lock - it's a spinlock.

Could we move vfs_poll() + inject to _before_ making the thing
public?  We'd need to delay POLLHUP handling there, but then
we need it until the moment with do inject anyway.  Something
like replacing
        if (!list_empty(&irqfd->list))
		hsm_irqfd_shutdown(irqfd);
in hsm_irqfd_shutdown_work() with
        if (!list_empty(&irqfd->list))
		hsm_irqfd_shutdown(irqfd);
	else
		irqfd->need_shutdown = true;
and doing
	if (unlikely(irqfd->need_shutdown))
		hsm_irqfd_shutdown(irqfd);
	else
		list_add_tail(&irqfd->list, &vm->irqfds);
when the sucker is made visible.

I'm *not* familiar with the area, though, so that might be unfeasible
for any number of reasons.

Suggestions?

