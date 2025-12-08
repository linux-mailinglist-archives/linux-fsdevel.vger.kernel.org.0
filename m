Return-Path: <linux-fsdevel+bounces-70981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E363ECAE167
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 20:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BFB03003DF5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 19:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14C62E06EA;
	Mon,  8 Dec 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA1S3XMi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B32248B0;
	Mon,  8 Dec 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765222225; cv=none; b=RoFqev5jUKZAoV1LXSWxpIepEoPN7OHHm5L2uS4vvGMbbsodqVTyZjmy9N4eY8+2gp4epYcV7P2hnNISKSTpi3Suwa/I9P7gLjkdNao+H6oGHBcbMpLIOflAP/FQEjh8oQVq8Hekd5n4kjyg0sIjWxqkNte+8BSuNFHZW4YH+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765222225; c=relaxed/simple;
	bh=v6w/V39j5HzpnK8m/NyQuXZ/46Io+I4MI9JAGUXZD1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ua4c9AlqfKS9SEu/O9Vv2HRSP7AyYp1j1PbZORRfMNHaTYoXAQRw9lGOZHip0ZhWPl/0ZsLoRTjajY/URlsRZ4Csh9oc0Z8NOy941Mm/2esGgtd1dXMgNgIhs7U4Jq618eZEaVnSX2PgJhtxrOpxwfABVJUerNCDevej05FK/l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA1S3XMi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA34DC4CEF1;
	Mon,  8 Dec 2025 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765222225;
	bh=v6w/V39j5HzpnK8m/NyQuXZ/46Io+I4MI9JAGUXZD1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fA1S3XMi3inzWs3PB1mKk+qcBBezVS9oYGbt9VVBE/MybTFkaE6bVj1Ayemz1nIN4
	 h91IukhlVQ5lyk/jgL1u07yQZP2gvHsmxUSPb+kfPeSM7776bYsbuNdMIPnrixiPLG
	 Prs/v8rTQ19XwTYiL/+3PB/tXxuiruRwcZxEnrtb5HmC6qa9tqES2Mmw/GJ3DxbpOD
	 R0RbmM3TC/j5glWG8aaoqA0DSTl6Q7EkNNG+sjwTFK1OCgt6ANM/dK4l+MWD9cpxeH
	 YtMeoHVCCjaBzACHuA7RYbNFQxlc6iG42lJS+ZYwvbYAp3ArIR7fkEVQpUrl6A2iLX
	 osGRq/UXyPbkQ==
Date: Mon, 8 Dec 2025 11:30:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Deepakkumar Karn <dkarn@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v2] fs: add NULL check in drop_buffers() to prevent
 null-ptr-deref
Message-ID: <20251208193024.GA89444@frogsfrogsfrogs>
References: <20251208190306.518502-2-dkarn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208190306.518502-2-dkarn@redhat.com>

On Tue, Dec 09, 2025 at 12:33:07AM +0530, Deepakkumar Karn wrote:
> drop_buffers() dereferences the buffer_head pointer returned by
> folio_buffers() without checking for NULL. This leads to a null pointer
> dereference when called from try_to_free_buffers() on a folio with no
> buffers attached. This happens when filemap_release_folio() is called on
> a folio belonging to a mapping with AS_RELEASE_ALWAYS set but without
> release_folio address_space operation defined. In such case,

What user is that?  All the users of AS_RELEASE_ALWAYS in 6.18 appear to
supply a ->release_folio.  Is this some new thing in 6.19?

--D

> folio_needs_release() returns true because of AS_RELEASE_ALWAYS flag,
> the folio has no private buffer data, causing the try_to_free_buffers()
> with a folio that has no buffers.
> 
> Adding NULL check for the buffer_head pointer and return false early if
> no buffers are attached to the folio.
> 
> Reported-by: syzbot+e07658f51ca22ab65b4e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e07658f51ca22ab65b4e
> Fixes: 6439476311a6 ("fs: Convert drop_buffers() to use a folio")
> Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
> ---
>  fs/buffer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 838c0c571022..fa5de0cdf540 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2893,6 +2893,10 @@ drop_buffers(struct folio *folio, struct buffer_head **buffers_to_free)
>  	struct buffer_head *head = folio_buffers(folio);
>  	struct buffer_head *bh;
>  
> +	/* In cases of folio without buffer_head*/
> +	if (!head)
> +		return false;
> +
>  	bh = head;
>  	do {
>  		if (buffer_busy(bh))
> -- 
> 2.52.0
> 
> 

