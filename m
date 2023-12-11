Return-Path: <linux-fsdevel+bounces-5452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68780C1A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 08:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A06F4B20992
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 07:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162751F932;
	Mon, 11 Dec 2023 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lAidl2HS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fa8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFFD7
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 23:04:41 -0800 (PST)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SpXmk4s0kzMq9TL;
	Mon, 11 Dec 2023 07:04:38 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SpXmj2wh3zMpnPr;
	Mon, 11 Dec 2023 08:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1702278278;
	bh=VfO/3wUPN3SBgSAAY/K0DV4zNFRwxiPQOTaNWLy5Msg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lAidl2HSgcLC7E9vU2ut3JWLpH/Jmqw0WRuH4UOHO9Foa+/JixZ/+gAqW5UuTEiF+
	 i9ADvSxF6FUBLNCkrW2qOPveWIFC3l98XJn+CQHJBi7fvzs6IMIibHjrFwPmjPDL4D
	 QHk5xVqfmi01cZizHTwo9YiJcq22fqTVmBDHkXIA=
Date: Mon, 11 Dec 2023 08:04:33 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 9/9] landlock: Document IOCTL support
Message-ID: <20231211.ieZahkeiph1o@digikod.net>
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
> +restrict the invocation of IOCTL commands.  However, to *permit* these IOCTL
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
> ++------------------------+-------------+-------------------+-------------------+

Great! Could you please format this table with the flat-table syntax?
See https://docs.kernel.org/doc-guide/sphinx.html#tables

> +
> +The full list of IOCTL commands and the access rights which affect them is
> +documented below.

