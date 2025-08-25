Return-Path: <linux-fsdevel+bounces-59075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AEDB340F7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88D647B2D0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3622405E3;
	Mon, 25 Aug 2025 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlIX9uPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E620271A9D
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129225; cv=none; b=lZSfIi4FPYQOLj4mndBg4PXLJ9hzfUYZ9IuMcFGHH+uunzTcmI+SVO/M/AV3mtvSaqvY+5w1CGGaF5DDZgqAYHSr3DuhpENkMp7ykHi1dl4OeoUAwZpnd2CeRFrF4GFyGELeu01j82LtEi5lXkszu01ZXMo0YsVoyLwXcR0VehI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129225; c=relaxed/simple;
	bh=9+QZP4XXHG7HYpwbFCOcDpopHawR+6HrnwAB6QGyRzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5TWCy411r3X4tipOAkWuc+Zt/UPmESqrzUv/4ue0CmA8HPc7aRTKcOGjhXY8ZJA7EF53VuafHJ8HgkJqLNMrpsR+h/gPZKP/BxT6QHaiH7tFb0uXojelrYPJB2tvEwd+vNZqwOKRgk6ARInk035EhDxR2yBjlPU90fz7o/I/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlIX9uPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15937C4CEED;
	Mon, 25 Aug 2025 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756129225;
	bh=9+QZP4XXHG7HYpwbFCOcDpopHawR+6HrnwAB6QGyRzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlIX9uPCxLeG5JEg+LSiGfem5iU22MbYgyUtamSl9NsovnQ7d7fLk0dsEL1eZZzq6
	 2DU0rEn5fnEBTFbYNfgM8eeKS+BTrWiB4ieL1wSQrs0vETX/59TX/9p7y8TohXe1wJ
	 tmoBy+FYfTyIQbrq/xhSXdPArbe34qtou7GEYJfLvcEvKP6jpbDLypyLcbrjCYK1mC
	 6DEXb71OXzAB6owKfpJPwCs/kQ6ICYwjeq59DKl0TKpnDkidgwI1na04hW6zODDd3S
	 mzb200x29LfdzvvUax9kIkodsSaVCuEWHeTPHszXgWAJLQPWv4hb+TvLVDPkR7ICe5
	 T9QWwuB6PHBYg==
Date: Mon, 25 Aug 2025 15:40:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 46/52] path_umount(): constify struct path argument
Message-ID: <20250825-aufsicht-hausfassade-e6cdd153d296@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-46-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-46-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:49AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

