Return-Path: <linux-fsdevel+bounces-23866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEE7934167
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 19:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4804628264C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FC0182A4E;
	Wed, 17 Jul 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xz/TYGku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ABE1822DC;
	Wed, 17 Jul 2024 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236979; cv=none; b=efqTzHNMDeb+QZO1ucSlJPQYBUBQOwdocnZXiQE4rQeOEWx3KoXj/SzgK5/MoDVIzSyySrVyj9GuylSUJZUF3zeFsRJcjTkkEH3XjwMVlF44M044gN+WdQFQRWa5mhv2Ct5XTh28c5JnNQk8oEyUOy1qXUEsfHRWEdcu6D72lFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236979; c=relaxed/simple;
	bh=vXLSOrGn/aah+WtVj2d/I7VJH4jg0Ee672xxZq8HGdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSoqKp9dkSdebbNkycxbb3yCh0pj4vdJ3RGptpfYYo4ME0j5NercjM2O8BAI4PZNfiVEncdPiZa3jOY76N7Z/yBzyh5TjV1q0osw9CbFRq0OcYFruvKqXAraw/2ZUnkCmCAADFG1nAvD/bGx4Nvm3/dQH5mnwthtn26GSnhxik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xz/TYGku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E854C2BD10;
	Wed, 17 Jul 2024 17:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721236979;
	bh=vXLSOrGn/aah+WtVj2d/I7VJH4jg0Ee672xxZq8HGdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xz/TYGkuAVjvLd8XZ+jmdmRyYX5twMMZcUExUiF2rZ8juVpUDFAv1ouulk9d7NkkV
	 Ir1E9rXBMoNu/GYRFIlwPsQTUVwrtPfYcPuNN8g2xtI+KpaSsC3bvrHUh5h+GTixK6
	 E9/TAZ56cwTqGb+1aRzxfbm6vdm9ydUGQZ+mMbR5xjgx7Y722NqgWTT/kcMKmCCW8n
	 W2L9ekz37YcRY8QhFAsL7wHQ7OMa2IX/kL5JWZxCoZPI4CIXcFzGNO7QAdCIwzdQBq
	 JtcfM7IbxfultoQC6D11woJBliUtTo7jYch/1xxxWGFYB/A1Qffajy/uFAs10+vUy7
	 E1/4g+1quc5Yw==
Date: Wed, 17 Jul 2024 10:22:58 -0700
From: Kees Cook <kees@kernel.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kernel@collabora.com, gbiv@google.com, inglorion@google.com,
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>,
	Jeff Xu <jeffxu@google.com>, Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] proc: add config to block FOLL_FORCE in mem writes
Message-ID: <202407171017.A0930117@keescook>
References: <20240717111358.415712-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717111358.415712-1-adrian.ratiu@collabora.com>

On Wed, Jul 17, 2024 at 02:13:58PM +0300, Adrian Ratiu wrote:
> This simple Kconfig option removes the FOLL_FORCE flag from
> procfs write calls because it can be abused.

For this to be available for general distros, I still want to have a
bootparam to control this, otherwise this mitigation will never see much
testing as most kernel deployments don't build their own kernels. A
simple __ro_after_init variable can be used.

In the future if folks want a more flexible version, we could make this
a one-way per-process flag, like no_new_privs.

-- 
Kees Cook

