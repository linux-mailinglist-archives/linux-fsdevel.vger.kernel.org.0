Return-Path: <linux-fsdevel+bounces-47400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DAFA9CF4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 19:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FB64C1008
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AC21E1A3D;
	Fri, 25 Apr 2025 17:14:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0F2CCC1;
	Fri, 25 Apr 2025 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601247; cv=none; b=n7adftFCt5zT2iCdpxCrcAtePTi2XmyqDpusARVIYh0kwEqcpVXxON/bGccAHDDlp9wCN63XfHhNCOuURDxQP5Kdo8n94eSgtkL1OtXuz35bMmhLvDM92jUMQrTp8tee3XiTpOfZ0RoQ9TOAHqC6WgjXnTkTIC2hDrU5T1tMoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601247; c=relaxed/simple;
	bh=X9TjP51L1gcCH8zQYlWIeUnFmHKTLoICB255JpYXPNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5fVhB0JHgxC63RzTZR0q3xLzmdt+9mMIMmPMNsmyO4GF+rFjWxeJd06j16Fbb4GW/VxaSHwQySzQuajdYzjhxnywoMzGMgZOrRgt31MiwmZxwA2fUw+O7gMNyS+iO00Q0bqTsU9WA9T50yM4lP7hF/FCftmm6KoeiY/tYzCBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA45C4CEE4;
	Fri, 25 Apr 2025 17:14:06 +0000 (UTC)
Date: Fri, 25 Apr 2025 13:16:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 David Howells <dhowells@redhat.com>, linux-nfs@vger.kernel.org, Miklos
 Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [RFC][PATCH] saner calling conventions for ->d_automount()
Message-ID: <20250425131604.777d4dc1@gandalf.local.home>
In-Reply-To: <20250424060845.GG2023217@ZenIV>
References: <20250424060845.GG2023217@ZenIV>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 07:08:45 +0100
Al Viro <viro@zeniv.linux.org.uk> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8ddf6b17215c..fa488721019f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10085,8 +10085,6 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
>  	put_filesystem(type);
>  	if (IS_ERR(mnt))
>  		return NULL;
> -	mntget(mnt);
> -
>  	return mnt;
>  }

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

