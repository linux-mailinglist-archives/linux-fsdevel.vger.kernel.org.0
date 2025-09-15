Return-Path: <linux-fsdevel+bounces-61381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D94B57BB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C161776DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C43081CC;
	Mon, 15 Sep 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0+SEQxX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6BA1C5499;
	Mon, 15 Sep 2025 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940411; cv=none; b=rw+rJuhsdUKY+zRjNbB6EkXODynSypyYdaWUeRxsKCpAGKkicVFamWkDZcJ9E6bJcUxCy1HAQhsCDdUXNj8F6suUdz7MknHX84X9nbiJMSTIDgRYsJ24zVrZQzmowNFlhZfUjKVMiq4iVOgmtSzvt1eohbDsh4H5yyRq1saV/iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940411; c=relaxed/simple;
	bh=rVtPNivDYWxe5YtU5sM63rbFOVe/NGZD9DSZ06+ZQWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SNWx0pbtwNy41Rx0tERZi0AF38giMG8Uf5dHoUZeUNvomxFexYnWiVWU96BGDW36XOcs5ANGI22tskWZjr8RTNa8ILTn6GY+mt9Oom2bfPTnxvlrZ2H9nGFMtB6OCp62D1vP22rC5+wVtgxzqQ4zjcbWTVgRvYr7ZXDBKn8c9U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0+SEQxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73421C4CEFE;
	Mon, 15 Sep 2025 12:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940410;
	bh=rVtPNivDYWxe5YtU5sM63rbFOVe/NGZD9DSZ06+ZQWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0+SEQxX9so3/Enlgd5FPqGvAhuxnyB1a6gB56WGHOmI1Ar6b4NOya+j+kZ4MSLiw
	 pZZUGUbPmmFD6SaH6HHBICDv/AT+yPNUFtdCTip6km5lkD7nHpU3c15VkcuzHfwgJs
	 /X9Ij3hMvwta8+pzQGywg53eYW7mxySK5g+Bb/b0+TcyDVpraSlERyIlZrKUVsM94a
	 MQXNMxP/pyCT0SE3c5dIjbDBQdH7gqkUW3dhmWBP8LQxlcPCI1/TLChTghy8R6Ls+n
	 jIuKYpYMOXiGuNXlScQRMgsMpIjTNcSsUf2GJK0CxrZaMvKCI38yMOy6AqgM3FykDg
	 eUo3+KpxcpThQ==
Date: Mon, 15 Sep 2025 14:46:46 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	jack@suse.cz, neil@brown.name, linux-security-module@vger.kernel.org, 
	dhowells@redhat.com, linkinjeon@kernel.org
Subject: Re: [PATCH 6/6] make it easier to catch those who try to modify
 ->d_name
Message-ID: <20250915-loslegen-zielbereich-dd84c4631cf5@brauner>
References: <20250911050149.GW31600@ZenIV>
 <20250911050534.3116491-1-viro@zeniv.linux.org.uk>
 <20250911050534.3116491-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250911050534.3116491-6-viro@zeniv.linux.org.uk>

On Thu, Sep 11, 2025 at 06:05:34AM +0100, Al Viro wrote:
> Turn d_name into an anon union of const struct qstr d_name with
> struct qstr __d_name.  Very few places need to modify it (all
> in fs/dcache.c); those are switched to use of ->__d_name.
> 
> Note that ->d_name can actually change under you unless you have
> the right locking environment; this const just prohibits accidentally
> doing stores without being easily spotted.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

