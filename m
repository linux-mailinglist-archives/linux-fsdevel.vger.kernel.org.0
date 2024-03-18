Return-Path: <linux-fsdevel+bounces-14758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F249187EF35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 18:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A1F2869A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 17:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F355C3F;
	Mon, 18 Mar 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y65fXzNj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364355C16
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784322; cv=none; b=oaNkkLFfENjgZdhP9ZV5a6zp1JfrIvGB0fPbUs5NnPrnf1ziqJ95VuY4W0OAVQ1wmjqvF1uMqWFyti8UL9JNtl5WE0EQhBxnAGht0O/RGQfODTs6KsWm4s/cPQCDATaYDRmFXrfqXsaV/aFBW4uCgFFdnJC88i5Vf5Adj9ZJCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784322; c=relaxed/simple;
	bh=fqTElAEqBOCrS+SEJ/QGcyaZBur12synCMYU0rQu1bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHoVYhh8hgE4TozTwkyTtOHczBm7Woi8DGicaVFzDF0OZhchKCRdvGMZqul+xBbgggZP5rF+urZhfMt+CeKZUjGINbky6wYhAb+9Ho482F1gdyjtb2rxdrtX9HKQOig0dyjSoSNSJD6n5O7KkN5xNndOBwKQ5Muy3fabGXSpaLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y65fXzNj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710784320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ICN/PTNvFGb1DjAB0N+/RyGurYAnxvURBuljr7cKqW8=;
	b=Y65fXzNjPC6KacPDw82JTPdBs61E+IirFGav82s3jNxCa37YnGFaYQmN7dZPgIY+89LUyC
	w1kFP2nYtJZYDAxbON+WdiSKj6Py8FtXmL3xvwSfvRXxH+oS2kXddtrxyI2uFewiMdtpP0
	8tobza3pNXHJqbMgyvpy1pqg0Wegdrs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-gx1gVLBDMbChQPSyTRlDvA-1; Mon, 18 Mar 2024 13:51:58 -0400
X-MC-Unique: gx1gVLBDMbChQPSyTRlDvA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33ed234bcb1so1325312f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Mar 2024 10:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710784317; x=1711389117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICN/PTNvFGb1DjAB0N+/RyGurYAnxvURBuljr7cKqW8=;
        b=hTQwNYezFgKKJOrjEm7ojzXfWRtVQmQcSx+/C5Mu0yTCc7RyZz+Yke2IZbvNPCxf6I
         hny1+46ppaZ6GL2aZ6TWyt8lcsU0JHXddjD6g6xIABp7bhXFEGbPtc2Bcvl38iBuoAek
         0vtqtlD8L7q1DNKQHZ9bhE2QGjGZloQVkBKA+r9GZbCLEDtor1C9KZuT7kzLcvQLSsXV
         +1nTh7ymOw4BWnBTYUJ56K7j7lG/gEF8CqA2+KzdgG/ZJFzJTqQPfn4XQb9Qf4LKsCdk
         XGIgCbeWqq0Imj1CLjs4JOsvXasrWm9+LTP2qnIbxjCwnwcshZtASULxec0vLM+1COn8
         n49Q==
X-Forwarded-Encrypted: i=1; AJvYcCVs8TcCpc1iAnxbFa5fctG2dSSCEdzGpxol9YiNuvO8l7covi3TywNnOJTkmSoy91s2aVoG8TFkDWyS26oKypi+fACwA/F7SESp5IqreA==
X-Gm-Message-State: AOJu0Yxrjjiigly4p3RCRr8td20rUR+YDkzL60w3NVZLLnMPoJeHybF0
	qxLdadhQvHbbUSFCdTSD/JmBg5XzdGOe/dpNzk39L4WQoV9/UHNcrplcUz463hbaxxtW3gC0daZ
	EObkQdejw7IxXHgHOTqlw3tfNH7AsNnYp+odFRyCRFCx0R9XEvc6hN/oTFa+6pA==
X-Received: by 2002:a5d:6a48:0:b0:33d:eb13:9e27 with SMTP id t8-20020a5d6a48000000b0033deb139e27mr290439wrw.23.1710784316746;
        Mon, 18 Mar 2024 10:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYSUHL198Rb526cW9SI0mG6UqLPgcAal2tyuFEAHmiIsVF9MBLJF60tkez08WEu6iLpM8qRQ==
X-Received: by 2002:a5d:6a48:0:b0:33d:eb13:9e27 with SMTP id t8-20020a5d6a48000000b0033deb139e27mr290426wrw.23.1710784316183;
        Mon, 18 Mar 2024 10:51:56 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id bu27-20020a056000079b00b0033ecbfc6941sm10048239wrb.110.2024.03.18.10.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:51:55 -0700 (PDT)
Date: Mon, 18 Mar 2024 18:51:55 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 31/40] xfs: better reporting and error handling in
 xfs_drop_merkle_tree
Message-ID: <kszur5shvmrodxfc3hefebu2cennigrbfowucsxydpvizssatx@mpe6lvoaqain>
References: <171069245829.2684506.10682056181611490828.stgit@frogsfrogsfrogs>
 <171069246408.2684506.9245902616854244173.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171069246408.2684506.9245902616854244173.stgit@frogsfrogsfrogs>

On 2024-03-17 09:31:28, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> xfs_drop_merkle_tree is responsible for removing the fsverity metadata
> after a failed attempt to enable fsverity for a file.  However, if the
> enablement process fails before the verity descriptor is written to the
> file, the cleanup function will trip the WARN_ON.  The error code in
> that case is ENOATTR, which isn't worth logging about.
> 
> Fix that return code handling, fix the tree block removal loop not to
> return early with ENOATTR, and improve the logging so that we actually
> capture what kind of error occurred.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Looks good to me:
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

> ---
>  fs/xfs/xfs_verity.c |   25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> 
> diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
> index db43e017f10e..32891ae42c47 100644
> --- a/fs/xfs/xfs_verity.c
> +++ b/fs/xfs/xfs_verity.c
> @@ -472,15 +472,14 @@ xfs_verity_begin_enable(
>  			tree_blocksize);
>  }
>  
> +/* Try to remove all the fsverity metadata after a failed enablement. */
>  static int
> -xfs_drop_merkle_tree(
> +xfs_verity_drop_incomplete_tree(
>  	struct xfs_inode		*ip,
>  	u64				merkle_tree_size,
>  	unsigned int			tree_blocksize)
>  {
>  	struct xfs_verity_merkle_key	name;
> -	int				error = 0;
> -	u64				offset = 0;
>  	struct xfs_da_args		args = {
>  		.dp			= ip,
>  		.whichfork		= XFS_ATTR_FORK,
> @@ -491,6 +490,8 @@ xfs_drop_merkle_tree(
>  		/* NULL value make xfs_attr_set remove the attr */
>  		.value			= NULL,
>  	};
> +	u64				offset;
> +	int				error;
>  
>  	if (!merkle_tree_size)
>  		return 0;
> @@ -498,6 +499,8 @@ xfs_drop_merkle_tree(
>  	for (offset = 0; offset < merkle_tree_size; offset += tree_blocksize) {
>  		xfs_verity_merkle_key_to_disk(&name, offset);
>  		error = xfs_attr_set(&args);
> +		if (error == -ENOATTR)
> +			error = 0;
>  		if (error)
>  			return error;
>  	}
> @@ -505,7 +508,8 @@ xfs_drop_merkle_tree(
>  	args.name = (const uint8_t *)XFS_VERITY_DESCRIPTOR_NAME;
>  	args.namelen = XFS_VERITY_DESCRIPTOR_NAME_LEN;
>  	error = xfs_attr_set(&args);
> -
> +	if (error == -ENOATTR)
> +		return 0;
>  	return error;
>  }
>  
> @@ -564,9 +568,16 @@ xfs_verity_end_enable(
>  		inode->i_flags |= S_VERITY;
>  
>  out:
> -	if (error)
> -		WARN_ON_ONCE(xfs_drop_merkle_tree(ip, merkle_tree_size,
> -						  tree_blocksize));
> +	if (error) {
> +		int	error2;
> +
> +		error2 = xfs_verity_drop_incomplete_tree(ip, merkle_tree_size,
> +				tree_blocksize);
> +		if (error2)
> +			xfs_alert(ip->i_mount,
> + "ino 0x%llx failed to clean up new fsverity metadata, err %d",
> +					ip->i_ino, error2);
> +	}
>  
>  	xfs_iflags_clear(ip, XFS_VERITY_CONSTRUCTION);
>  	return error;
> 

-- 
- Andrey


