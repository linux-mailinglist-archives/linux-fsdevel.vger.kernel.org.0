Return-Path: <linux-fsdevel+bounces-73772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FEBD200F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 920D63024E4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023B3A1E81;
	Wed, 14 Jan 2026 16:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4nRKZlh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC053A1CFA;
	Wed, 14 Jan 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406601; cv=none; b=ArSTLvcdtQwJ7DDqO744QJiQMUGvL9ZQFsqfhFq0z2oHmIMhRiDN2zgOSVgb8jV6U1H6whCwKV2ezC6JYOb9FeOHuVzCN+9Zqx3DKkc2A7ViuNM+IjuR4NIbwwN4zp8LEtyVowZQN5Z7tPBzM2xFUu1lQrXduEJyMBrztkBTUeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406601; c=relaxed/simple;
	bh=yENF5FkQncRK9HFDX1eVS/9XVFz0RDFwIwZRbs/wM5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa7Ny+z8Idwh2JtoJwy2N/Si4JrKuy7zA7eOiuJMF8hxVIE/m2D/QOkMX0woIjRlU2eb/vGsCt9Tq4fhfpYf7LV7GgOwVfr75weULLcjYS+D6UmK0P7r5bIjMmZ+VKxA826VN6Pt5yATowTgf2tnbQQhjyOo7sUrzJVTZpBWYi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4nRKZlh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3EE0C4CEF7;
	Wed, 14 Jan 2026 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768406601;
	bh=yENF5FkQncRK9HFDX1eVS/9XVFz0RDFwIwZRbs/wM5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l4nRKZlhE5V8KG6T6p9sZ6+Uxb+0bD1da97c3vV6+bNFE48ZD+JW6ULV5xAbaRKze
	 B8DNJ+9ISjmHWHBTLDfRJBccSXt8Xr2cIS3vJaC0l7IqTbZfmM3w6f953b54svaotG
	 xYOIXiZbkhIS+cpPZExHgspsxFDI0vnu0Nj0qBAKBcz7CUPOOhsEK+Qm/eaYKDSV3D
	 B8+xABSeXUi1cFG1PO21qA7dD/bSUgx/+ddZk2ZR17Q2bTps5vFhCshJjvdlqzLzqk
	 QCuu/OoSuoAHJU+D3UYob1RKRqacZ0LrhXic6ATpONfHwyMQELK5k+kTtwAOH75XSX
	 DREW/MTN2ra+A==
Date: Wed, 14 Jan 2026 17:03:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	David Howells <dhowells@redhat.com>, DJ Delorie <dj@redhat.com>
Subject: Re: O_CLOEXEC use for OPEN_TREE_CLOEXEC
Message-ID: <20260114-alias-riefen-2cb8c09d0ded@brauner>
References: <lhupl7dcf0o.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <lhupl7dcf0o.fsf@oldenburg.str.redhat.com>

On Tue, Jan 13, 2026 at 11:40:55PM +0100, Florian Weimer wrote:
> In <linux/mount.h>, we have this:
> 
> #define OPEN_TREE_CLOEXEC      O_CLOEXEC       /* Close the file on execve() */
> 
> This causes a few pain points for us to on the glibc side when we mirror
> this into <linux/mount.h> becuse O_CLOEXEC is defined in <fcntl.h>,
> which is one of the headers that's completely incompatible with the UAPI
> headers.
> 
> The reason why this is painful is because O_CLOEXEC has at least three
> different values across architectures: 0x80000, 0x200000, 0x400000
> 
> Even for the UAPI this isn't ideal because it effectively burns three
> open_tree flags, unless the flags are made architecture-specific, too.

I think that just got cargo-culted... A long time ago some API define as
O_CLOEXEC and now a lot of APIs have done the same. I'm pretty sure we
can't change that now but we can document that this shouldn't be ifdefed
and instead be a separate per-syscall bit. But I think that's the best
we can do right now.

