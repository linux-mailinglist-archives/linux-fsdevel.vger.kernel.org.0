Return-Path: <linux-fsdevel+bounces-31874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A564099C6FF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 12:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A921C226A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07015B14B;
	Mon, 14 Oct 2024 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWFGtbsm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB9C33998;
	Mon, 14 Oct 2024 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901089; cv=none; b=fMIT+jwlqNYPQyl9MzYZw++fIHmLIAVg62f1VkkNp/+d7Ur/zzi1I+lcui9k4yyqzbYSGs8/XphWn0epI0AaMgu3HSceKGnsk38HOJKwNvIryERi3GBU+664YI3D7+nlm/YvsA/o/TFUgp+GKL2MLX9jS6QZkBV72gQXmqR6blE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901089; c=relaxed/simple;
	bh=cpXQpXGfkC93e7PWjOy7pV4nCkySyydw1pZxWZb1LGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LtX06FzX+oE8h1OFcy2ZG0A5IhkSZenmPrDF7vePEByjBzMtvJn3EjwMJusA5+EoEJIlK4P7OeWSFvuFT1CW/VKABXHmOBekcQlfIxrHsvr8lMIQXc93Zw5UPZko5z9/M6LP//8j2MH3TFxMYGcjVsKAyONc6v90XrwpkUUJ/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWFGtbsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3FBC4CEC3;
	Mon, 14 Oct 2024 10:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728901088;
	bh=cpXQpXGfkC93e7PWjOy7pV4nCkySyydw1pZxWZb1LGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWFGtbsmw68gcPOubz/SxqrGBGPP1I/oPXxhb5n4nrAmlHlOyz4XfUKeXvtHRNkyh
	 obuaoAgLNetumsEtb2vJ075OlFvEOIQM/dch8YPmn1J+NPXZvjN34RlmWRnBBUhEHl
	 TfqLawysA7mDm++jnmfISzAEk2FT9Ll6y6zSJlwc3z85PJc5srTS2BWWIyc6bg5yWa
	 o3Q2MVn9ApvwiSBc6KNJIJ4FBUrPzVKx1/UQdGbEhYxcdzAtyI9LhfZuibWfMderOO
	 InHYgsimhpcb96XwAKyuTHgxf4lZ7jcp1RlJjp0c1lGBh4Bl6oEo79MGDidYPCEWSv
	 gFEemntcilpmQ==
Date: Mon, 14 Oct 2024 12:18:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, kpsingh@kernel.org, mattbobrowski@google.com
Subject: Re: [PATCH bpf-next 0/2] security.bpf xattr name prefix
Message-ID: <20241014-zeigt-nachwachsen-ef41e225b73c@brauner>
References: <20241002214637.3625277-1-song@kernel.org>
 <CAPhsuW6nv=-wEaoPxB_+VQTkfnvYzBtfjbrg2EeNK7jjN6V83g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhsuW6nv=-wEaoPxB_+VQTkfnvYzBtfjbrg2EeNK7jjN6V83g@mail.gmail.com>

On Fri, Oct 11, 2024 at 10:40:02AM -0700, Song Liu wrote:
> Hi Christian, Al, and Jan,
> 
> Could you please review and share your comments on this set?

Yes, as I said in-person, I think adding security.bpf is fine.

