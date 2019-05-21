Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7897324EAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 14:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEUMJu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 08:09:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53008 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfEUMJt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 08:09:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CAE443179162;
        Tue, 21 May 2019 12:09:38 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-219.str.redhat.com [10.33.192.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8854750A63;
        Tue, 21 May 2019 12:09:30 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, tkjos@android.com, ldv@altlinux.org,
        miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/2] open: add close_range()
References: <20190521113448.20654-1-christian@brauner.io>
Date:   Tue, 21 May 2019 14:09:29 +0200
In-Reply-To: <20190521113448.20654-1-christian@brauner.io> (Christian
        Brauner's message of "Tue, 21 May 2019 13:34:47 +0200")
Message-ID: <87tvdoau12.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 21 May 2019 12:09:49 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Christian Brauner:

> +/**
> + * __close_range() - Close all file descriptors in a given range.
> + *
> + * @fd:     starting file descriptor to close
> + * @max_fd: last file descriptor to close
> + *
> + * This closes a range of file descriptors. All file descriptors
> + * from @fd up to and including @max_fd are closed.
> + */
> +int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
> +{
> +	unsigned int cur_max;
> +
> +	if (fd > max_fd)
> +		return -EINVAL;
> +
> +	rcu_read_lock();
> +	cur_max = files_fdtable(files)->max_fds;
> +	rcu_read_unlock();
> +
> +	/* cap to last valid index into fdtable */
> +	if (max_fd >= cur_max)
> +		max_fd = cur_max - 1;
> +
> +	while (fd <= max_fd)
> +		__close_fd(files, fd++);
> +
> +	return 0;
> +}

This seems rather drastic.  How long does this block in kernel mode?
Maybe it's okay as long as the maximum possible value for cur_max stays
around 4 million or so.

Solaris has an fdwalk function:

  <https://docs.oracle.com/cd/E88353_01/html/E37843/closefrom-3c.html>

So a different way to implement this would expose a nextfd system call
to userspace, so that we can use that to implement both fdwalk and
closefrom.  But maybe fdwalk is just too obscure, given the existence of
/proc.

I'll happily implement closefrom on top of close_range in glibc (plus
fallback for older kernels based on /proc—with an abort in case that
doesn't work because the RLIMIT_NOFILE hack is unreliable
unfortunately).

Thanks,
Florian
