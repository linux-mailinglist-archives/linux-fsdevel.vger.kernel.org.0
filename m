Return-Path: <linux-fsdevel+bounces-23877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA3A934361
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 22:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA031C210F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 20:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E5E1850B8;
	Wed, 17 Jul 2024 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lalYT496"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0D524205;
	Wed, 17 Jul 2024 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721249618; cv=none; b=ATTPoUODCMv3fJk2GjbcEkJgPHLdkqsGEKEppEPY5UigAHqD99RctFJZJugT3RO2SPRKb5AxtvXhmg60qUnI0vleItdCQdbyB0O59/oxM4p3npl5p96JuNkkmDF296a3i+/hX75IN9JSPoRJbzfBFYnPlOIpSZvq8Gwk3eBV/hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721249618; c=relaxed/simple;
	bh=PAC0XAD5h5KSIY92fLN5w0D6dZqt0PDGf1vPOyQgb9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2qQBzM3Sk9M5Nvpwb6+crxa9QIiUMmkalPs8TPPH01hHVaRurByBt6remkvEuwBtUO3jw22M/FI8ZpmfyJ7imnxKZ13biDBa911VW9vyfNXNDd2gXFm986Cov1/nPql3ABPXA1rS3gC7o1AEKkDBJ5XlXdSWFdXADN7kVqBEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lalYT496; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66360C2BD10;
	Wed, 17 Jul 2024 20:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721249617;
	bh=PAC0XAD5h5KSIY92fLN5w0D6dZqt0PDGf1vPOyQgb9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lalYT496H46aL/ZFWsjDkM+ZkEBRQYvIlIb6Av/4wLvntPc3PirnRvy3I5eLhwtPa
	 T2RxBUmJCt+HaqCOHLzWT8GxdECpqaLrPsp75MIuutp/gQpriluHxmp+UydLtEIDCw
	 WQJkZ2rNFV/ds5MWCOxPLfoE1WtQ2Qaa4DITyi5zH7vpODpC3q8K7YU5uxsZ6zQmLw
	 9nVqxBXs/3wSt+mw9yz/PQd5QXD3YpFkoHkCCvElS3Z0cCdluZQVPwox0eMpl0RCdc
	 /yuF9vSOvW2Ee6A78To5TGNJnr02xiA7oq5O/d3923wiBoqH7N4iRQD5vQUmKsPFds
	 FPB/IN8abQoWQ==
Date: Wed, 17 Jul 2024 13:53:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kernel@collabora.com, gbiv@google.com, inglorion@google.com,
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>,
	Jeff Xu <jeffxu@google.com>, Jann Horn <jannh@google.com>,
	Kees Cook <kees@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] proc: add config to block FOLL_FORCE in mem writes
Message-ID: <20240717205335.GA3632@sol.localdomain>
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
> +config SECURITY_PROC_MEM_RESTRICT_FOLL_FORCE
> +	bool "Remove FOLL_FORCE usage from /proc/pid/mem writes"
> +	default n
> +	help
> +	  This restricts FOLL_FORCE flag usage in procfs mem write calls
> +	  because it bypasses memory permission checks and can be used by
> +	  attackers to manipulate process memory contents that would be
> +	  otherwise protected.
> +
> +	  Enabling this will break GDB, gdbserver and other debuggers
> +	  which require FOLL_FORCE for basic functionalities.
> +
> +	  If you are unsure how to answer this question, answer N.

FOLL_FORCE is an internal flag, and people who aren't kernel developers aren't
going to know what it is.  Could this option be named and documented in a way
that would be more understandable to people who aren't kernel developers?  What
is the effect on how /proc/pid/mem behaves?

- Eric

