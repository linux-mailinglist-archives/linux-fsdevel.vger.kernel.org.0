Return-Path: <linux-fsdevel+bounces-21890-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6130090D64A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 16:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B7C292CE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jun 2024 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE5514A08D;
	Tue, 18 Jun 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCxGf/k+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375CA20310;
	Tue, 18 Jun 2024 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718722374; cv=none; b=f004jIdqmxSfAdxPE9OG1wfnPayRKW34oS/VJ2SgDUZUlCpjlp1EmxhLu5J8onH49jo+9/Ck/ogFISGB7MqLw4TNGp+4uNQGQG4x7cDcq+xh3M5S1jRZA78IvmtFV45EGVxKi/9I6bydLgV6sEuA+td9BoPtxOIrI1n/CagQgJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718722374; c=relaxed/simple;
	bh=Rflk2+4WjOQgrEOm82SwHFaMZBkVKpQtOD8MLUVoVf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKNVZDwcXy6/DobboFVIs/iiEGHgEVJu1QtKNdu7hhD+rbhbx2VDxgpiJxWOibdo6F2IrsuLwYvCbCZGNCOY56Gv9lIbiOpUghEETFAL5OjSfPOjrMfMDX45Kw+WTFAsFehtyodsWO249ytzGBVd67jWBsBub1LbbczBJ6y+v94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCxGf/k+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF19DC3277B;
	Tue, 18 Jun 2024 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718722373;
	bh=Rflk2+4WjOQgrEOm82SwHFaMZBkVKpQtOD8MLUVoVf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCxGf/k+1bngfRw1QubS7zP537tVYpiDUMXTaKySJ7S1HKkVHNJt48Fsz4ct6z+kc
	 QpZ7en3i9yA/6B7b/4kNWbYxUQxc7MT8d3uns4iqp5nvhmkzRJsKd/USDfRI4boiPH
	 aldFsGS+wE7TctRkccw4hXyUs7maXFPFv5Zj/avI5zbpzisZ2h3bayOEAFwBq9ksCr
	 QP678IqGfFtN3KlODt/+SWPDXFa0rv71AGPlewp0+vLRYrFG6OciquWnq8Fljj5vVo
	 cjZXCVyL2uVGwdjLkCK8uNuZyEsdOY5O47+XRO2g/xf3ouP6N75VxeYYASFLs22MW8
	 zKkTkUvrGzN3A==
Date: Tue, 18 Jun 2024 16:52:49 +0200
From: Christian Brauner <brauner@kernel.org>
To: Junchao Sun <sunjunchao2870@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, chandan.babu@oracle.com, djwong@kernel.org
Subject: Re: [PATCH 2/2] vfs: reorder struct file structure elements to
 remove unneeded padding.
Message-ID: <20240618-zugerechnet-unvollendet-3ad100eff3d5@brauner>
References: <20240618113505.476072-1-sunjunchao2870@gmail.com>
 <20240618113505.476072-2-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618113505.476072-2-sunjunchao2870@gmail.com>

On Tue, Jun 18, 2024 at 07:35:05PM GMT, Junchao Sun wrote:
> By reordering the elements in the struct file structure, we can
> reduce the padding needed on an x86_64 system by 8 bytes.
> 
> Signed-off-by: Junchao Sun <sunjunchao2870@gmail.com>
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 0283cf366c2a..9235b7a960d3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -999,10 +999,10 @@ struct file {
>  	 */
>  	spinlock_t		f_lock;
>  	fmode_t			f_mode;
> +	unsigned int		f_flags;

Iiuc, then this will push f_pos_lock into a new cache line whereas it's
explicitly optimized so that f_lock, f_mode, and f_pos_lock are all in
the same cache line.

You could play around with moving the union to the end of struct file.

