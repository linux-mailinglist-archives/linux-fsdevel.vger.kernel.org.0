Return-Path: <linux-fsdevel+bounces-40509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF01A241F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 18:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDFB3A31BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FBD1EEA44;
	Fri, 31 Jan 2025 17:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="sd3WfeB7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A71F1313
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738344959; cv=none; b=eKkYO9pAtjBx+fxxaRCsN77MiTritoNP2TrBddKMy/J3oFdXj+UoLefi7fetNfGaQLKvEvVmDIW1It/lRVlZXSDNLjMozTyRwtFdcdIrLTc4OJFdmHM0ndydmpCgXirOXptFhd8riLw7+c4gOXHsvE79FGOkaU0xWd5oFKfS+gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738344959; c=relaxed/simple;
	bh=7tFMd94XrNV2Cv0ba9mt04yYUrLg9TaClHoJK93oO2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EExSHuVlCgaBeaSyYa+kAx36O6k27hUIS7//p9CQi2/MNMcBoRFgPKrNHiw60uBxca97nMrX3QoS+7k47Zu8RpaKH7va8IuFWNiVPaRKBw/zfPzAYN5Mqa0yDot6cAJO7FkrX1zG4znbYlAC4+XX3gWGVIAuNd4aDg75ZhT6Pcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=sd3WfeB7; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yl32d2k5Qzrj4;
	Fri, 31 Jan 2025 18:35:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738344953;
	bh=JQNxKR9dbJjG5bam5n/mwVoP3e4BSTQ5f1tiApN5rcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sd3WfeB7FkxYwSUsLyqF80fmYo23XXoWRTEyKyWwSnRlODArcXk9VwRI1pWstO7x2
	 TvtAzY2cFSZ5e9VgTAypRbTdjJtfQZF01kGaYawHIP9fh18ipHGrrVMEJcapjqMMSk
	 C45FtTyK0elHkFt6vtxhUSbMfAa04ZYzjXHVW+/A=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yl32b73zqzHLJ;
	Fri, 31 Jan 2025 18:35:51 +0100 (CET)
Date: Fri, 31 Jan 2025 18:35:49 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Cc: Charles Zaffery <czaffery@roblox.com>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, 
	Kees Cook <kees@kernel.org>, Luca Boccassi <luca.boccassi@gmail.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Praveen K Paladugu <prapal@linux.microsoft.com>, 
	Robert Salvet <robert.salvet@roblox.com>, Shervin Oloumi <enlightened@google.com>, 
	Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, containers@lists.linux.dev
Subject: Re: [RFC PATCH v1 0/3] Expose Landlock domain IDs via pidfd
Message-ID: <20250131.baePeenoo2ik@digikod.net>
References: <20250131163447.1140564-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250131163447.1140564-1-mic@digikod.net>
X-Infomaniak-Routing: alpha

On Fri, Jan 31, 2025 at 05:34:44PM +0100, Mickaël Salaün wrote:
> Hi,
> 
> Landlock enables users to create unprivileged nested security sandboxes
> (i.e. domains).  Each of these domains get a unique ID, which is used to
> identify and compare different domains.  With the audit support, these
> IDs will be used in logs, but users also need a way to map these IDs to
> processes and directly read domain IDs of arbitrary tasks.
> 
> pidfd is a reference to a task that enables users to interact with it
> and read some of its properties with the PIDFD_GET_INFO IOCTL.  This
> patch series extend this interface with two new properties:
> PIDFD_INFO_LANDLOCK_LAST_DOMAIN and PIDFD_INFO_LANDLOCK_FIRST_DOMAIN.
> 
> Being able to read tasks' domain IDs is useful for telemetry, debugging, and
> tests.  It enables users:
> - to know if a task is well sandboxed;
> - to know which tasks are part of the same sandbox;
> - to map Landlock audit logs to running processes.
> 
> Furthermore, thanks to recvmsg(2)'s SCM_PIDFD, it is also possible to reliably
> identify a peer's sandbox.
> 
> This patch series is based on the audit support patch series v5:
> https://lore.kernel.org/all/20250108154338.1129069-1-mic@digikod.net/

That was the v4, here is the v5:
https://lore.kernel.org/all/20250131163059.1139617-1-mic@digikod.net/

> 
> I'll talk about this feature at FOSDEM:
> https://fosdem.org/2025/schedule/event/fosdem-2025-6071-sandbox-ids-with-landlock/
> 
> Regards,
> 
> Mickaël Salaün (3):
>   landlock: Add landlock_read_domain_id()
>   pidfd: Extend PIDFD_GET_INFO with PIDFD_INFO_LANDLOCK_*_DOMAIN
>   samples/landlock: Print domain ID
> 
>  fs/pidfs.c                   | 24 +++++++++++-
>  include/linux/landlock.h     | 26 +++++++++++++
>  include/uapi/linux/pidfd.h   |  4 ++
>  samples/landlock/sandboxer.c | 29 +++++++++++++-
>  security/landlock/Makefile   | 12 ++++--
>  security/landlock/domain.c   |  2 -
>  security/landlock/domain.h   |  8 ++--
>  security/landlock/ruleset.c  |  2 +
>  security/landlock/syscalls.c | 75 ++++++++++++++++++++++++++++++++++++
>  9 files changed, 169 insertions(+), 13 deletions(-)
>  create mode 100644 include/linux/landlock.h
> 
> 
> base-commit: a4b76d5e6800121372b88c85628a7867a5fdc707
> -- 
> 2.48.1
> 
> 

