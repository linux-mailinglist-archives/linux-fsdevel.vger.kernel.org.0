Return-Path: <linux-fsdevel+bounces-5844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B34810FDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 12:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25AC281D38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850AA241FF;
	Wed, 13 Dec 2023 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EBnXYIZ6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF29DC
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Dec 2023 03:25:19 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SqtSX1g1tzMq7QR;
	Wed, 13 Dec 2023 11:25:16 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SqtSW2n7JzMppB1;
	Wed, 13 Dec 2023 12:25:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1702466716;
	bh=ubcRnZIYW9Vy2Y5dQZzccSBXMrxq6nvyXYbjeYRrSn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EBnXYIZ6euwXcMDdHUCHrgDWxta9ZoSiFwCvFkxWR9hPCkEf0Jf8Cm8zfo24xTP1e
	 x3hb6I3RiskIlf40TQy5TOJoedGu1R5nqfXGgxx+qDwsAaeVh6Eewt5CjEhVxUrzXQ
	 B7YIQ/Nh+eoRfra5Rht16eGda+qTbSWaSbqLJQ9M=
Date: Wed, 13 Dec 2023 12:25:15 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 9/9] landlock: Document IOCTL support
Message-ID: <20231213.java5eeb4Nee@digikod.net>
References: <20231208155121.1943775-1-gnoack@google.com>
 <20231208155121.1943775-10-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208155121.1943775-10-gnoack@google.com>
X-Infomaniak-Routing: alpha

On Fri, Dec 08, 2023 at 04:51:21PM +0100, Günther Noack wrote:
> In the paragraph above the fallback logic, use the shorter phrasing
> from the landlock(7) man page.
> 
> Signed-off-by: Günther Noack <gnoack@google.com>
> ---
>  Documentation/userspace-api/landlock.rst | 119 ++++++++++++++++++++---
>  1 file changed, 104 insertions(+), 15 deletions(-)
> 

> +Restricting IOCTL commands
> +--------------------------
> +
> +When the ``LANDLOCK_ACCESS_FS_IOCTL`` access right is handled, Landlock will

I only use "right" (instead of "access right") when LANDLOCK_ACCESS_*
precede to avoid repetition.

> +restrict the invocation of IOCTL commands.  However, to *permit* these IOCTL

This patch introduces the "permit*" wording instead of the currently
used "allowed", which is inconsistent.

> +commands again, some of these IOCTL commands are then granted through other,
> +preexisting access rights.
> +
> +For example, consider a program which handles ``LANDLOCK_ACCESS_FS_IOCTL`` and
> +``LANDLOCK_ACCESS_FS_READ_FILE``.  The program *permits*
> +``LANDLOCK_ACCESS_FS_READ_FILE`` on a file ``foo.log``.
> +
> +By virtue of granting this access on the ``foo.log`` file, it is now possible to
> +use common and harmless IOCTL commands which are useful when reading files, such
> +as ``FIONREAD``.
> +
> +On the other hand, if the program permits ``LANDLOCK_ACCESS_FS_IOCTL`` on
> +another file, ``FIONREAD`` will not work on that file when it is opened.  As
> +soon as ``LANDLOCK_ACCESS_FS_READ_FILE`` is *handled* in the ruleset, the IOCTL
> +commands affected by it can not be reenabled though ``LANDLOCK_ACCESS_FS_IOCTL``
> +any more, but are then governed by ``LANDLOCK_ACCESS_FS_READ_FILE``.
> +
> +The following table illustrates how IOCTL attempts for ``FIONREAD`` are
> +filtered, depending on how a Landlock ruleset handles and permits the
> +``LANDLOCK_ACCESS_FS_IOCTL`` and ``LANDLOCK_ACCESS_FS_READ_FILE`` access rights:
> +
> ++------------------------+-------------+-------------------+-------------------+
> +|                        | ``IOCTL``   | ``IOCTL`` handled | ``IOCTL`` handled |

I was a bit confused at first read, wondering why IOCTL was quoted, then
I realized that it was in fact LANDLOCK_ACCESS_FS_IOCTL. Maybe using the
"FS_" prefix would avoid this kind of misreading (same for READ_FILE)?

> +|                        | not handled | and permitted     | and not permitted |
> ++------------------------+-------------+-------------------+-------------------+
> +| ``READ_FILE`` not      | allow       | allow             | deny              |
> +| handled                |             |                   |                   |
> ++------------------------+             +-------------------+-------------------+
> +| ``READ_FILE`` handled  |             | allow                                 |
> +| and permitted          |             |                                       |
> ++------------------------+             +-------------------+-------------------+
> +| ``READ_FILE`` handled  |             | deny                                  |
> +| and not permitted      |             |                                       |

If it makes the raw text easier to read, it should be OK to extend this
table to 100 columns (I guess checkpatch.pl will not complain).

> ++------------------------+-------------+-------------------+-------------------+
> +
> +The full list of IOCTL commands and the access rights which affect them is
> +documented below.
>  
>  Compatibility
>  =============
> @@ -457,6 +514,28 @@ Memory usage
>  Kernel memory allocated to create rulesets is accounted and can be restricted
>  by the Documentation/admin-guide/cgroup-v1/memory.rst.
>  
> +IOCTL support
> +-------------
> +
> +The ``LANDLOCK_ACCESS_FS_IOCTL`` access right restricts the use of
> +:manpage:`ioctl(2)`, but it only applies to newly opened files.  This means
> +specifically that pre-existing file descriptors like stdin, stdout and stderr
> +are unaffected.
> +
> +Users should be aware that TTY devices have traditionally permitted to control
> +other processes on the same TTY through the ``TIOCSTI`` and ``TIOCLINUX`` IOCTL
> +commands.  It is therefore recommended to close inherited TTY file descriptors,
> +or to reopen them from ``/proc/self/fd/*`` without the
> +``LANDLOCK_ACCESS_FS_IOCTL`` right, if possible.  The :manpage:`isatty(3)`
> +function checks whether a given file descriptor is a TTY.
> +
> +Landlock's IOCTL support is coarse-grained at the moment, but may become more
> +fine-grained in the future.  Until then, users are advised to establish the
> +guarantees that they need through the file hierarchy, by only permitting the
> +``LANDLOCK_ACCESS_FS_IOCTL`` right on files where it is really harmless.  In
> +cases where you can control the mounts, the ``nodev`` mount option can help to
> +rule out that device files can be accessed.
> +

