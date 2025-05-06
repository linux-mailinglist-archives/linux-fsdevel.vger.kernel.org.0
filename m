Return-Path: <linux-fsdevel+bounces-48155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8151FAAB869
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15EEE1C27AA1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 06:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206A227BF8A;
	Tue,  6 May 2025 01:33:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B90830B28F;
	Tue,  6 May 2025 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746490739; cv=none; b=SrtMu5NnuVMjHUZ/1fgT/SPDZREOxDjKt1BE2htJP3y+8XUyFCOLBbOGPb4uJAwD9sqctjl7IDcMHDhP9AOK7u6TY80hTEzd9nb2p2ea+slVDec3Lwv73J8ll0aScHFtQ8hgc/vwIcXlUs3X1PPuS0Pm0G2f4dVL6BId3/g1rls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746490739; c=relaxed/simple;
	bh=UWQ6ERmGL6IZkWLxGd0o3ECXAkhD3bUzYsXfgnKEYHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npChp9E6Bw+u3+Gwa5GYv5pFB8RM1PHzh90V4Ye7rgJtooDTuhrLb9rhApAGzTvSFrWgb66WZdSof5sQGNMJrvQLfFi36WV+iaNqi2zEzp9QOo7Or4r3WlAPiw7RiQMCMDb5z0OtLSp+Hl8PCCOtu9ZQgf71Z8fTMp8v17XA7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E541C4CEE4;
	Tue,  6 May 2025 00:18:58 +0000 (UTC)
Date: Mon, 5 May 2025 20:19:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] kill vfs_submount()
Message-ID: <20250505201904.59cd46d0@gandalf.local.home>
In-Reply-To: <20250505213829.GI2023217@ZenIV>
References: <20250503212925.GZ2023217@ZenIV>
	<utebik76wcdgaspk7sjzb3aedmlcwbmwj3olur45zuycbpapjc@pd5rhnudxb35>
	<20250505213829.GI2023217@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 22:38:29 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> @@ -10084,10 +10087,20 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
>  	type = get_fs_type("tracefs");
>  	if (!type)
>  		return NULL;
> -	mnt = vfs_submount(mntpt, type, "tracefs", NULL);
> +
> +	fc = fs_context_for_submount(type, mntpt);
>  	put_filesystem(type);
> -	if (IS_ERR(mnt))
> -		return NULL;
> +	if (IS_ERR(fc))
> +		return ERR_CAST(fc);
> +
> +	ret = vfs_parse_fs_string(fc, "source",
> +				  "tracefs", strlen("tracefs"));
> +	if (!ret)
> +		mnt = fc_mount(fc);
> +	else
> +		mnt = ERR_PTR(ret);
> +
> +	put_fs_context(fc);
>  	return mnt;
>  }
>  

In case others try to apply this on Linus or linux-next, this is based on top of:

  https://lore.kernel.org/all/20250424060845.GG2023217@ZenIV/

Otherwise it doesn't apply cleanly.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

