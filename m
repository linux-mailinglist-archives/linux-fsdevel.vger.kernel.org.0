Return-Path: <linux-fsdevel+bounces-61342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134F5B579D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635CB16B9BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C20F30648B;
	Mon, 15 Sep 2025 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQ2jbfZk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC03305E38
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937881; cv=none; b=soSvT/APueEAWWtvAvRvUss9nQg2/xWvdVq96PUCsxrLKmyqI2n0f+QIvUPnv/NCtpjXmmyfGHyyDPBiBkeJJdQ+F0Tndwddo3Woh+jtJWzYP6uUOx4QIU9Mi30xJ+oWqFoquqOtBAHzjoIG3PxLcBSdlY6wry6g2sGkgoHg8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937881; c=relaxed/simple;
	bh=PuD2/AVJjgaQUhP56rZ6uYNbgQpaBxiw8HoC/e+K17Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgfWhW4Tkv7+6yitP7FGlcm5l5WyLkw6ml7XlutpzTTDaT+GVvz77u9pkCNIbZ+riPfrvyoZDz2fyKOV8tBaK7tnnCduhZNwLV++MpA2rnTCJighPLS06GkYD5QeOx3DF2fDHqK8oHbFi9sNXb/0D7amhne7NvXRbWb9ll4/GsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQ2jbfZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294C1C4CEF5;
	Mon, 15 Sep 2025 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937881;
	bh=PuD2/AVJjgaQUhP56rZ6uYNbgQpaBxiw8HoC/e+K17Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQ2jbfZkW2kd4eMPxANoG075O0ITm6GkICgVnohN4+MKKP4+uoIuxiZrp6e3BaBgi
	 zHKg31NhGqoe7Mh4BcQtMG1H6/MyQgyNIXKyWt/oD6vsqc/9dQ0oRnaymcQXFnTlGc
	 uFqkY/pWfcef0pil9CjrZTn7bI4QUdAFxLwPbr/2lg9ELfmIGNo1IVSdHHGd8Gu6Oa
	 Ush/AxywoIHqfsUl4w4/1AN+yY9+vPFvNkBhuASHVQ8ccvNCax7fERoPVE6HhHAghK
	 CNaNQrF1oLhVzNpgL88GTsEs97WI0TPSeVFrr7hfTZ3jQ+80G8+4nnnuPwOuZDN7A9
	 RB6uodxrlmy1A==
Date: Mon, 15 Sep 2025 14:04:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 13/21] ksmbd_vfs_set_init_posix_acl(): constify path
 argument
Message-ID: <20250915-narzissen-mitbekommen-0951449eae45@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-13-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-13-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:29AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

