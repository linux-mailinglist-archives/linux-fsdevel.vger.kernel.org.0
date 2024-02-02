Return-Path: <linux-fsdevel+bounces-10063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 629FB8476DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C3E2B2D105
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6D14E2C6;
	Fri,  2 Feb 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFdxQU1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A19314A4E6;
	Fri,  2 Feb 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706896622; cv=none; b=J8AgLdqIY8c6hSwXDZ5OpmbLONgMBuJurAmeSLc1sKfBhMj1ZmZU03bzcxI7vwdHWY+l3WMWFRkepZML9INWZBDBxyLiSNrW5a2C6H+/LPbRi9BuLm3+pJy9MXwoD5stpe5Cq71KeKRgZmMtxGaOyIE5ChOwcniaETqXPzNSn+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706896622; c=relaxed/simple;
	bh=YDwuxmOU5GedLso/AjAPu0UEHBl8mlloHEaWlojo/uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtkv5FtPU1NsB7vaC0ZCJ2eT+0GVXTpS7e2nyY+LJFCZ85pkT8PJ2/gLPn9502X6XAEDT0lorT7lApXHbMzCGtGSb1QJa1l+EPoSrv2dlWDPz5FXFw1a7mpb4mTBXQ1ap4xIXqbKGSWRmH0RInpZ0vzeEcPpe4RwwI3Coj9SdYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFdxQU1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C2DC433F1;
	Fri,  2 Feb 2024 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706896622;
	bh=YDwuxmOU5GedLso/AjAPu0UEHBl8mlloHEaWlojo/uY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFdxQU1FH8KyVVWxKSgZjhHNqrIJbTWk5njPHRuI5GceUCCon4DSj1SXkTkv4W7y3
	 KRWwi4djmiEcEXT9sxULrl1uBlQqmGPU5iId3D3OQEeB9cdudA4OA/tusM5768a0U1
	 71p7QCflBksGSLi9oM9iZSLogJWUvE1MC8JOpxlHyANFVXxZbc+YdRy8Zrkfk1q55u
	 fa0xo7eAd41U+lmzcXxFEb7UvPa6Qc+RFXCm5JS9cJuy1d5+ghq+ojkofiqGHJUzIg
	 jmoDf2kMaiHHaeN5V3kovdtNwkDbpMwClNO2ard0CNDYuPi7sEPSyf5Zs174xfLosB
	 9khLB7quPkWUQ==
Date: Fri, 2 Feb 2024 09:57:01 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
	dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
	martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
Subject: Re: [PATCH 2/6] fs: Add FS_XFLAG_ATOMICWRITES flag
Message-ID: <20240202175701.GI6184@frogsfrogsfrogs>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-3-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-3-john.g.garry@oracle.com>

On Wed, Jan 24, 2024 at 02:26:41PM +0000, John Garry wrote:
> Add a flag indicating that a regular file is enabled for atomic writes.

This is a file attribute that mirrors an ondisk inode flag.  Actual
support for untorn file writes (for now) depends on both the iflag and
the underlying storage devices, which we can only really check at statx
and pwrite time.  This is the same story as FS_XFLAG_DAX, which signals
to the fs that we should try to enable the fsdax IO path on the file
(instead of the regular page cache), but applications have to query
STAT_ATTR_DAX to find out if they really got that IO path.

"try to enable atomic writes", perhaps?

(and the comment for FS_XFLAG_DAX ought to read "try to use DAX for IO")

--D 

> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  include/uapi/linux/fs.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index a0975ae81e64..b5b4e1db9576 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -140,6 +140,7 @@ struct fsxattr {
>  #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
>  #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
>  #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
> +#define FS_XFLAG_ATOMICWRITES	0x00020000	/* atomic writes enabled */
>  #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
>  
>  /* the read-only stuff doesn't really belong here, but any other place is
> -- 
> 2.31.1
> 
> 

