Return-Path: <linux-fsdevel+bounces-66292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E50C1AB57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 14:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB79C5847DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AD733B6DC;
	Wed, 29 Oct 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RHEAk1qp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7C33B6C6;
	Wed, 29 Oct 2025 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742506; cv=none; b=JHess36fMOImz8HAcW0k4hh+5NUQmcxUWpxwpRnqsWOhTS7dk54vrRHTzcQi27evND/aK1cOYpeiy9qYNzI5fRwMj584iy1dUZr8dY0kVvLrAKOockb6q4o+Ze7c7niIW30VMejUXniNPza9+KUBNt6Uv8a9aNVCHzKt7mZhb+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742506; c=relaxed/simple;
	bh=9XYrlklpk/Hc4NE8fb0wzosrDo4q6wloCH7mewEvvLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSiDwFwsI8QnTOYtLEyxRjpg/nNeVlbXiOD4EFlSVGxp3CbPXvDB2GPGFXf3Z234Ii4X2WHMKiJf6pQYSQ3HaX/DVB78fzzkfb19H/jd8cmww8s1nfbGd58ZCbQpSRHxIKfOVXteN1irWEBiJu++YB+PXHMDJ/BExxGm52Cwf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RHEAk1qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58C5C4CEF7;
	Wed, 29 Oct 2025 12:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761742503;
	bh=9XYrlklpk/Hc4NE8fb0wzosrDo4q6wloCH7mewEvvLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHEAk1qpC+8HX5MR5u6QfDqE42C9CRG3RdDExDGZ4MvXBtfCQack36vPhGsV0uWD8
	 /PO3hH+L7UCbhTUGFEZ/au20foGy/k1/DEfYmZMORmp9huDFcU1NIUj9rTvGtkWOSL
	 9YswO2xZWuEfthP37KUCBpDyTbnVn4MdE8yfJ004bbmiJXqc2iJcsVptv+Cgpq5z9Z
	 RSTlJkUaFeLaiRRdH2x47/NtNb7s2T3DeE2pGvNXBpUGyq5wsUipmzSLHPLQwNo7ai
	 pXQVSImgqj4b0sNa6pGJ8oo3oR1nTU2bioIt6lLXGd5R5qaxgRFC6QhEYtE0lvvQEO
	 rFS2UjqMrgbbQ==
Date: Wed, 29 Oct 2025 13:54:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: push list presence check into inode_io_list_del()
Message-ID: <20251029-aufweichen-pechschwarz-7eba2f4f6ffb@brauner>
References: <20251022143112.3303937-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251022143112.3303937-1-mjguzik@gmail.com>

On Wed, Oct 22, 2025 at 04:31:11PM +0200, Mateusz Guzik wrote:
> For consistency with sb routines.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---

Hm, what is this based on? It doesn't apply to vfs-6.19.inode at all.
Could you please resend?

>  fs/fs-writeback.c | 3 +++
>  fs/inode.c        | 4 +---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index f784d8b09b04..5dccbe5fb09d 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -1349,6 +1349,9 @@ void inode_io_list_del(struct inode *inode)
>  {
>  	struct bdi_writeback *wb;
>  
> +	if (list_empty(&inode->i_io_list))
> +		return;
> +
>  	wb = inode_to_wb_and_lock_list(inode);
>  	spin_lock(&inode->i_lock);
>  
> diff --git a/fs/inode.c b/fs/inode.c
> index 3153d725859c..274350095537 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -789,9 +789,7 @@ static void evict(struct inode *inode)
>  	BUG_ON(!(inode_state_read_once(inode) & I_FREEING));
>  	BUG_ON(!list_empty(&inode->i_lru));
>  
> -	if (!list_empty(&inode->i_io_list))
> -		inode_io_list_del(inode);
> -
> +	inode_io_list_del(inode);
>  	inode_sb_list_del(inode);
>  
>  	spin_lock(&inode->i_lock);
> -- 
> 2.34.1
> 

