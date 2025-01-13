Return-Path: <linux-fsdevel+bounces-39046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74903A0BA58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9707916A0CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44C523A109;
	Mon, 13 Jan 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8IHfrBx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFCC23A0F5
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779803; cv=none; b=ZkcB+8tC5iT5gOywyVTNYfsNh18NDVcCLdpS72JmH7Wd6TNxPYu8dYmg3XLsX711lPf/49QijuQmVjbI1Opo6IJAbOr3/Si4DfIBpox42wP/KaFuRsJiX4nLBwnC+RCS8RivdFZ14N3AI3EG/r5QqlEeQGUvBVY4hMQxNTDoH5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779803; c=relaxed/simple;
	bh=EOQQsLnt1mjp3hD7mOVxBjY4/KP2fczomYItwskChpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVjvTNhmP/36lLU8N2twxiNHRURNXqw60LMYdSEWAmmc6Rj5H4Ytpan+3iAwmsOuR0mQVbDZT284io7R5ogSATYBNzUqkWDzbomO41CdnipJsqrGzRm2QYmmDvIkwQwigfMkQnG1PSfG18qKry4hGbc5KQsEu0bBUYjh2TEjZ0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8IHfrBx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848E1C4CED6;
	Mon, 13 Jan 2025 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736779802;
	bh=EOQQsLnt1mjp3hD7mOVxBjY4/KP2fczomYItwskChpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8IHfrBx2iNtt5vyDijHdG0y5tWogcrJGb6LjY32zVgLLR7q8VwCwCvJq7QQbAQDl
	 w7V+fSZhCe/RaAXJ1pKDgHus35/aNWEQfOt4z1JmoX4S+znqKEwvfuMtM7GgDIw1Ko
	 moEFNMbCf9Q57NNdHNwHdn+XMiyX1Rd5XgTrRWO6kIq/xtg/g2IIUJ8jNRPdQ4pawA
	 Nhf1CQIyKqm3/OkMmAJ/smSGDF5ejKBX2r1FOFbwfP7cGNPE3uWgtv1l6bDrrP8lQS
	 d3/wa1f8L/NVfZB+wibJXybxRkalpdzfQO3ZaGVBaZvpsIROZop1wlM1l0mWHCs46b
	 q9OR6uCzmhyKg==
Date: Mon, 13 Jan 2025 15:49:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 02/21] debugfs: move ->automount into
 debugfs_inode_info
Message-ID: <20250113-dolch-anrollen-23dfbd2e020d@brauner>
References: <20250112080545.GX1977892@ZenIV>
 <20250112080705.141166-1-viro@zeniv.linux.org.uk>
 <20250112080705.141166-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250112080705.141166-2-viro@zeniv.linux.org.uk>

On Sun, Jan 12, 2025 at 08:06:46AM +0000, Al Viro wrote:
> ... and don't bother with debugfs_fsdata for those.  Life's
> simpler that way...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

