Return-Path: <linux-fsdevel+bounces-59619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11A5B3B4A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 09:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F19AE1C83877
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 07:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7982853F3;
	Fri, 29 Aug 2025 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4AIZPX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2442773CE;
	Fri, 29 Aug 2025 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756453647; cv=none; b=Z35U6EO6J2EWmd56yL9vVOyoI1BJ5Wd6X9BnH9BExbdCXs1JLyeFxZJvDWF7CPrHAR60UIfsS8gleXZJEdDGIFp3lOowZTQaaN3JYbWjq4DY8QTf4MN/TXp2Y06XjPjMYWfQU1kap0t1BaDqgXR9m5beqHxL07J1o2l8mreIzv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756453647; c=relaxed/simple;
	bh=jVcTms2XRzBB3PPSI+6P0avxqEAyTMICbgteK8vyCa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jl8NqiKM1am6ipwH9H0OjlUZcU6Kk7lZyUDUpaVIuHDarSY2LHda3rCX/vti4bWsWzis20vdayzatpDXUDRqcvKxH9rQO0yiGwR7QUJc+86L9Ja6M8BTy7Pg39e+qUgkONX0KpvjagpweopTNFGxg1NTmPb53bZT8qKBNXkxhRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4AIZPX2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8869C4CEF0;
	Fri, 29 Aug 2025 07:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756453647;
	bh=jVcTms2XRzBB3PPSI+6P0avxqEAyTMICbgteK8vyCa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4AIZPX2KulB4CP50f2BflpvqlD6meYtfPuQULgifWt3u55WfTwp69ARnOxyxS9/S
	 T3j14opGwFXdk3A3SuoIxrfAQF10xoLzx6hPqgoBixkOXOKjbHuK/qZsLgHSZMFptw
	 Z7Ad5mEeD5hUz+6ey1eBrKz6aLmsXJlCmN8UMaavsRNJ4Ur5uRWXKl4gNiTD07Z+5V
	 3Xh3tteHGBRBvXo92XD0ZFX/9rTzi3t2eVvF6taH7+aKQXtID14vMFjqiY9p0ISstP
	 zB0LcLMn9OUlfjKEOITyuuwK7DdxsB1umPsJPBVfs3pEaAFz/S3jJREVfNZ9j4EbHd
	 nmEyTUSpQm0/g==
Date: Fri, 29 Aug 2025 09:47:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jan Kara <jack@suse.cz>, David Howells <dhowells@redhat.com>, 
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] change the calling conventions for
 vfs_parse_fs_string()
Message-ID: <20250829-umliegenden-brummen-90546a7d0723@brauner>
References: <20250828000001.GY39973@ZenIV>
 <20250828000039.GA3011378@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250828000039.GA3011378@ZenIV>

On Thu, Aug 28, 2025 at 01:00:39AM +0100, Al Viro wrote:
> Absolute majority of callers are passing the 4th argument equal to
> strlen() of the 3rd one.
> 
> Drop the v_size argument, add vfs_parse_fs_qstr() for the cases that
> want independent length.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

