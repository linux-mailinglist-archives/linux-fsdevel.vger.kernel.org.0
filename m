Return-Path: <linux-fsdevel+bounces-61340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B738CB579D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6477316D3D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1936D302CB8;
	Mon, 15 Sep 2025 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBvrQoMx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7768A2E6122
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937864; cv=none; b=WH1m6ydUFv6SNdZxqY7G5BPKiRe5WwrosvsKdXIENtmgRxxBkLGMZ335SOjHBkH8dTu5BaUNSBxt+Ae9opU5GkhXZirC4U1oVG7N99jct7Cpzq4xPV8mIOl6thJ1gabmUlMBePfipKthdgfUrDFvHXXnDTkzJsmc6DTg6QpSwQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937864; c=relaxed/simple;
	bh=JolqqLslWOpv65d9mAgcpp3MLn1TTYj87oJmpojwd/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0+tntsRf0zh8pgsHHSo0NmBEbrhyVghVsCzNPUBSHnXt7V+qgpfFNJUvyGoC0y8URyhePZQVHRapYVgUkwBYaAvGID1ZV8pm6Irm/e+/rvljbQ2yHlbtpPSNO8MZGlbH5aatqVJmLAY1p5gVyxDxrKDZelGLk+dYVQIfiYnLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBvrQoMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190FEC4CEF7;
	Mon, 15 Sep 2025 12:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937863;
	bh=JolqqLslWOpv65d9mAgcpp3MLn1TTYj87oJmpojwd/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBvrQoMxQ+tEKyGzb2r2arFbBi/+FvWs5U80h9tl5tF96DplLcpoldLoUOcZMPeM9
	 TaXafgJfMqFXwojKCyd/MgXpSbhmP2/02igig/nWgayEHcADzncaBdC9ek/lVMEw3Y
	 f/SamEjRKXAvQc3RmSI8KBKDoTXLHFg29hQWPe9T0qVvMonX2BHxS22g6afFzViPDH
	 7XhTjd6kjyRhm6W656sCVFI+aPTGm5aay8p0JyhHzYVZQIlgVCJ8P59/GkCbA1xIP5
	 1zQOpoEhdHjHvSDmiVvIm+vxTkFuoy1bTj5gmZS9wTVkI2qnKTlP5B35zzr40J+CUA
	 E1LMDPmwiclLw==
Date: Mon, 15 Sep 2025 14:04:18 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 12/21] ksmbd_vfs_inherit_posix_acl(): constify path
 argument
Message-ID: <20250915-mitgift-knirps-66e2be649e04@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-12-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-12-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:28AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

