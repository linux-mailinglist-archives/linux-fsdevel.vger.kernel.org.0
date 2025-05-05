Return-Path: <linux-fsdevel+bounces-48089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EBCAA953E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 16:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775D9189BDA2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F388A18DB26;
	Mon,  5 May 2025 14:15:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9787935970;
	Mon,  5 May 2025 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454544; cv=none; b=E2NyS51hN0AVh7McYqHmqVON7/5gPj9rAX7d8LgU2Jh3KISn8Oc3HIaVNK1IJ5ren1xub7KEgUuafFvBq6ZLPT5ihzQ+lqzDam0gEAX+FvjUtNnUESpoCGvoahNyk0iM+VWwjQLLmAyQ5jKf/Pjviu2/LenABjEoYUjTkrax68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454544; c=relaxed/simple;
	bh=Gk6XIQ6d2Ckysy7Eh2aKcIun+x06BrcqURKjuDrf/gY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TejDpl+QlTSlVGB8UdGcm9m+teMZqOJELt2YxwYeoyIU0PFOlItUVm5lLb6N+DfC8BSj9ITBssVzTsvTe2vf3vPW9GKF+yJb+TtqVQmBZ+usFq11vddxzcp7LI4blnVlBDYNhMIluGmRDONOVLHM4Zt5O/b83Nue+sPgpdJ8HIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEFAC4CEE4;
	Mon,  5 May 2025 14:15:43 +0000 (UTC)
Date: Mon, 5 May 2025 10:15:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH][RFC][CFT] kill vfs_submount(), already
Message-ID: <20250505101548.5c8a3995@gandalf.local.home>
In-Reply-To: <20250503212925.GZ2023217@ZenIV>
References: <20250503212925.GZ2023217@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 May 2025 22:29:25 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> @@ -10081,10 +10084,20 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
>  	type = get_fs_type("tracefs");
>  	if (!type)
>  		return NULL;
> -	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
> +
> +	fc = fs_context_for_submount(type, mntpt);
> +	if (IS_ERR(fc))
> +		return ERR_CAST(fc);

As Jan mentioned, the put_filesystem(type) is need in the error path.

> +
> +	ret = vfs_parse_fs_string(fc, "source",
> +				  "tracefs", strlen("tracefs"));
> +	if (!ret)
> +		mnt = fc_mount(fc);
> +	else
> +		mnt = ERR_PTR(ret);
> +
> +	put_fs_context(fc);
>  	put_filesystem(type);
> -	if (IS_ERR(mnt))
> -		return NULL;

This didn't apply cleanly to Linus's tree, nor linux-next, due to missing:

	mntget(mnt);

Was that supposed to be deleted too?

Anyway, I applied this (still keeping the mntget()) and it appears to work.

-- Steve


>  	return mnt;
>  }

