Return-Path: <linux-fsdevel+bounces-34559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524859C644F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 23:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096641F22705
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B00421A6EE;
	Tue, 12 Nov 2024 22:33:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AA1FEFD9;
	Tue, 12 Nov 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731450795; cv=none; b=O+64ZC7hdo8D8wnPRigw4lk3XobhC2nKYx8GvDi14rpXnnyCKeXpRd1vdn1XJDX6jZ1WRXrQE4FhL0bkwM8Zn3qJwrzhkIg/C0eLt9fH5yIzgmzNqnzgvS5exwedw59PUz7HK28VdGXtrQqXzr8Rp4G5kEhN/a1gNaN5WpvB/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731450795; c=relaxed/simple;
	bh=63RdlxJYEkmrjo66jbLlNsxb4Km11jUZ5M00MeIMh+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A54TgGfr2RBMhPz+z8hhmaT0zY78HiQ4SAXh7KzqmRc7A1hX0KBpFrubsju5YDaz2+mygwHf/3+HwY/fHZQD1hPuHJS6J7cPJEj84+Rm/ufNc5qzzZJAGZUrUu2kprOeBftDtu3G574r7Rtsk1MrYk0Hk3N8V+Xcxmw1wtoa++U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE8DC4CECD;
	Tue, 12 Nov 2024 22:33:14 +0000 (UTC)
Date: Tue, 12 Nov 2024 17:33:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: <mcgrof@kernel.org>, <kees@kernel.org>, <joel.granados@kernel.org>,
 <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kernel: add pid_max to pid_namespace
Message-ID: <20241112173331.407a5be0@gandalf.local.home>
In-Reply-To: <20241105031024.3866383-1-yun.zhou@windriver.com>
References: <20241105031024.3866383-1-yun.zhou@windriver.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 5 Nov 2024 11:10:24 +0800
Yun Zhou <yun.zhou@windriver.com> wrote:

> It is necessary to have a different pid_max in different containers.
> For example, multiple containers are running on a host, one of which
> is Android, and its 32 bit bionic libc only accepts pid <= 65535. So
> it requires the global pid_max <= 65535. This will cause configuration
> conflicts with other containers and also limit the maximum number of
> tasks for the entire system.
> 
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  - Remove sentinels from ctl_table arrays.
> v1 - https://lore.kernel.org/all/20241030052933.1041408-1-yun.zhou@windriver.com/
> ---
>  include/linux/pid_namespace.h     |  1 +
>  kernel/pid.c                      | 12 +++++------
>  kernel/pid_namespace.c            | 34 ++++++++++++++++++++++++++-----
>  kernel/sysctl.c                   |  9 --------
>  kernel/trace/pid_list.c           |  2 +-
>  kernel/trace/trace.h              |  2 --
>  kernel/trace/trace_sched_switch.c |  2 +-
>  7 files changed, 38 insertions(+), 24 deletions(-)

