Return-Path: <linux-fsdevel+bounces-9907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516B845E74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 18:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231C31C25432
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2265E3D3;
	Thu,  1 Feb 2024 17:23:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71E163098;
	Thu,  1 Feb 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808210; cv=none; b=n99XhkCQ4qsnKpaFw0NSzjqOljK9uQmLOqfALzM1G479jC0vuv4+piBZlHcNI75w6HFF/Z4EOZ9fibapOEhz5Nak3/XiNUpVZg+0RzVZtLZMe3mjMjXyPciY5cEV2oj6IN5tUuqh3naJdOJgbi22i3uepM2VteX2bKcK19GW8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808210; c=relaxed/simple;
	bh=zkUxE2VLKDuDVJKXNGtq3jYCLzkVPr+Uc5RIJr7bjx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWbLAHgy5/gER5ee9kov8LVwAe/WtFOnxG7HLpXtPgeUJObiSyVj44TRtx8Gzr8CVTPtZi9Rb7dGbja2RaP0Oc8nmq7aLUargTysb54SOeB9tIFoemwjpbF2hmqiKSdLTWRqNZdOKM+9+nwHSGG1kLzIAw3lBvqdYMJ2UOfqGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D17C433F1;
	Thu,  1 Feb 2024 17:23:29 +0000 (UTC)
Date: Thu, 1 Feb 2024 12:23:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner
 <brauner@kernel.org>, Al Viro <viro@ZenIV.linux.org.uk>, Ajay Kaher
 <ajay.kaher@broadcom.com>
Subject: Re: [PATCH 5/6] eventfs: Add WARN_ON_ONCE() to checks in
 eventfs_root_lookup()
Message-ID: <20240201122345.1d42bb44@gandalf.local.home>
In-Reply-To: <20240201161617.499712009@goodmis.org>
References: <20240201153446.138990674@goodmis.org>
	<20240201161617.499712009@goodmis.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 01 Feb 2024 10:34:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -483,7 +483,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  	struct dentry *result = NULL;
>  
>  	ti = get_tracefs(dir);
> -	if (!(ti->flags & TRACEFS_EVENT_INODE))
> +	if (WARN_ON_ONCE!(ti->flags & TRACEFS_EVENT_INODE)))

I added this patch at the end but never tested it :-p

I then did a rebase to move it ahead of patch 6, which was tested.

Will resend this patch.

-- Steve


>  		return ERR_PTR(-EIO);
>  
>  	mutex_lock(&eventfs_mutex);

