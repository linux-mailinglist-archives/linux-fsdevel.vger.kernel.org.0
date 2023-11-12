Return-Path: <linux-fsdevel+bounces-2782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 280907E9272
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 21:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129941C208FE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 20:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20262182D5;
	Sun, 12 Nov 2023 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ut0JJClr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F5C8C6
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Nov 2023 20:14:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9EDC433C8;
	Sun, 12 Nov 2023 20:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699820074;
	bh=oRGBYTEliw7AYNH0BwmcNNXHy3XA7EOZkxh+XB9u+Ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ut0JJClrFdy6dOuewkyVjfw1vgHAeJAl8qrEiyAKAlJAh0XDXXOgn6ChGU7/PI9WY
	 4uqz1paKLXnHOT2mivdX7zlfp2SifYQyL10L129FKLp6fHTkpKa1EaLrAciVw1TPP5
	 Nr0r9PR0tH7iLbZPFNl0SjxtdGUpcnJHG4uuxBidNyOqf7iqQjJRDRz2zUclNb+RNy
	 ZocyNlCH0qSpUkqcWClsWjlxiiUgd+kpkeMh0ctD/tdPq7ZRmASNlWzc80FpF26ojo
	 CuLRCH3HFRcupN3rxgy2I5ORlgvyoJxeNoQ8xb6mRGY36KqoisripSZK+KoyL3ToKR
	 cDH4yN7xHSHJA==
Date: Sun, 12 Nov 2023 21:14:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH v1 0/1] fs: Consider capabilities relative to namespace
 for linkat permission check
Message-ID: <20231112-bekriegen-branche-fbc86a9aaa5e@brauner>
References: <20231110170615.2168372-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231110170615.2168372-1-cmirabil@redhat.com>

On Fri, Nov 10, 2023 at 12:06:14PM -0500, Charles Mirabile wrote:
> This is a one line change that makes `linkat` aware of namespaces when
> checking for capabilities.
> 
> As far as I can tell, the call to `capable` in this code dates back to
> before the `ns_capable` function existed, so I don't think the author
> specifically intended to prefer regular `capable` over `ns_capable`,
> and no one has noticed or cared to change it yet... until now!
> 
> It is already hard enough to use `linkat` to link temporarily files
> into the filesystem without the `/proc` workaround, and when moving
> a program that was working fine on bare metal into a container,
> I got hung up on this additional snag due to the lack of namespace
> awareness in `linkat`.

I agree that it would be nice to relax this a bit to make this play
nicer with containers.

The current checks want to restrict scenarios where an application is
able to create a hardlink for an arbitrary file descriptor it has
received via e.g., SCM_RIGHTS or that it has inherited.

So we want to somehow get a good enough approximation to the question
whether the caller would have been able to open the source file.

When we check for CAP_DAC_READ_SEARCH in the caller's namespace we
presuppose that the file is accessible in the current namespace and that
CAP_DAC_READ_SEARCH would have been enough to open it. Both aren't
necessarily true. Neither need the file be accessible, e.g., due to a
chroot or pivot_root nor need CAP_DAC_READ_SEARCH be enough. For
example, the file could be accessible in the caller's namespace but due
to uid/gid mapping the {g,u}id of the file doesn't have a mapping in the
caller's namespace. So that doesn't really cut it imho.

However, if we check for CAP_DAC_READ_SEARCH in the namespace the file
was opened in that could work. We know that the file must've been
accessible in the namespace the file was opened in and we
know that the {g,u}id of the file must have been mapped in the namespace
the file was opened in. So if we check that the caller does have
CAP_DAC_READ_SEARCH in the opener's namespace we can approximate that
the caller could've opened the file.

So that should allow us to enabled this for containers.

