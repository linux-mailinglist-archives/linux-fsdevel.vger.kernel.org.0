Return-Path: <linux-fsdevel+bounces-39343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468CAA13003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 01:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83A993A5B04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 00:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D03125B9;
	Thu, 16 Jan 2025 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbTWIC2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CEEEBA;
	Thu, 16 Jan 2025 00:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736987541; cv=none; b=JVJMmK5l8GRuroYYkswgYI7dymzJ4JKP9KAywC4mEX0YIXF/EEiLh7J9ND9sTEnUKTt2UTim35hLSn8BeG7J+/lNuzz98pp6geD7hzO0Vrg5FsRmX+/JwmPn9yfkr88H445m3SS5/keACQk8WS3DiXWTRkobS/29GrcNS1cgvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736987541; c=relaxed/simple;
	bh=pehDXC7beIfWo0xsFyjMiQzNUjuFhFOAE81FaM8GUys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HKoR8gCN2Ls0VQJMeAd8OA9cXCiVEnZcBS31ABk0+DZvrl8w1aLg7ErPHFuIXrgV0nV0RT9iA+4WLVfE7NnY6zXpL4mCAiQYcrSscansUj1T7ZWLzFpdxTaHgMVbBPhcRxex6iA7DlmrdHTe9SWHlcDXKj4POW/ZUVd7iIUYJ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbTWIC2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F0CC4CED1;
	Thu, 16 Jan 2025 00:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736987541;
	bh=pehDXC7beIfWo0xsFyjMiQzNUjuFhFOAE81FaM8GUys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbTWIC2OknUqCHLK/CE9pZ3jnPTNEbI33BphNVsLlVfr/2loklbcmXauCTuqwrlXb
	 wzBZIgITT2LKYyoLarEJxCb7JqScfLxPMg/ysk5WceGtjUXAxHl8OAItEQC+ADiHW8
	 oAJN1O6mnn1RnrBNDo7yV31ggkB3dtWmXTNkK9oKfxGs8+4GOU2A60+8Fk+cubdvJf
	 iWdg72FJZvQind3CETXzprPs8w2Qy8MMr784RCJpl3addoVp8H2Soveyt93kvWYhSK
	 0G7IyuLDEIRUWatI9Zm/7CUSESu2YnVl8nV2iRuJGNbwc0oD+GA6Jk1jkIshdEdpaF
	 0UwjhxtKatiUQ==
Date: Wed, 15 Jan 2025 16:32:18 -0800
From: Kees Cook <kees@kernel.org>
To: nicolas.bouchinet@clip-os.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Neil Horman <nhorman@tuxdriver.com>, Lin Feng <linf@wangsu.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v4 1/2] coredump: Fixes core_pipe_limit sysctl
 proc_handler
Message-ID: <202501151630.87A0A8E7C4@keescook>
References: <20250115132211.25400-1-nicolas.bouchinet@clip-os.org>
 <20250115132211.25400-2-nicolas.bouchinet@clip-os.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115132211.25400-2-nicolas.bouchinet@clip-os.org>

On Wed, Jan 15, 2025 at 02:22:08PM +0100, nicolas.bouchinet@clip-os.org wrote:
> Any negative write or >= to INT_MAX in core_pipe_limit sysctl would
> hypothetically allow a user to create very high load on the system by
> running processes that produces a coredump in case the core_pattern
> sysctl is configured to pipe core files to user space helper.
> Memory or PID exhaustion should happen before but it anyway breaks the
> core_pipe_limit semantic.

Isn't this true for "0" too (the default)? I'm not opposed to the change
since it makes things more clear, but I don't think the >=INT_MAX
problem is anything more than "functionally identical to 0". :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

