Return-Path: <linux-fsdevel+bounces-44217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E29A65E7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 20:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB10117982E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8CD1EB5C6;
	Mon, 17 Mar 2025 19:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA5nUqXy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3DC1A01D4;
	Mon, 17 Mar 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742241129; cv=none; b=PQfEj/pDqHuXPKi3rxvm9FYsZ9owjGV/Y23tp7B9gMQ7H2+L6YvXh7h5zPZKNEJZWuCavb0s4FBBE1Z8TvyW4kscgfbtPBvZikFD1Wn9Csaf/bgtGDJAx4+jYSqkzRW3oIZ2gTPs5Scvd1uK3v1f5jGFO+YPPS2Psj6f0rWqcoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742241129; c=relaxed/simple;
	bh=mK1/sze64QSgg0NQN+WjWcDMklW7x/9lpZesWAfQdGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp5xWVJJNvAuv0zhK7DzZUNcJ+umaP6hVazQy0HYnYLQv8egud/BwMh7Ip3hCr9jRPHLmOVkZaofKMD6BgzBw2iLNV+FmPGxJ9l5dQq5BbQhtG/V9OjGBozrvH9vB9Yp07Fvag1Vr6vMhjoHSR2a2lWSq8+edjtCopYr+rzwvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA5nUqXy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F314C4CEE3;
	Mon, 17 Mar 2025 19:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742241128;
	bh=mK1/sze64QSgg0NQN+WjWcDMklW7x/9lpZesWAfQdGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rA5nUqXybLg41f5gOmXlFkmHkEyHC6qQ7d7J7UQrcm5J45xxEumebjdsGEq7BVtN6
	 aPqQfToqhlfcbqe408psHclVvhdEzr4nsNPLRX+sr5zUDXWHMBLG8EIHdigtBAVF/Q
	 9iwHPC4n89PWZcypEsVjrCBNZfgbz+LFyNU0IIBmRtYUNdy6LFALCNQcSed+9ioQKP
	 cqBCb2ATkOwQw9ehlu9OhHwfg0MGThbXbjNN8farhKOS26cqL1yFOrSlU7yIEVKh6D
	 QPgAlT1uhazShTSI5O6VHeBj3lwD7mCBhBRKoIPNFLGIErfss6IOMGzw+49b6HCBKB
	 0KaZJhZr5RJPw==
Date: Mon, 17 Mar 2025 20:52:02 +0100
From: Joel Granados <joel.granados@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Kees Cook <kees@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] tracing: Move trace sysctls into trace.c
Message-ID: <hymr4ao557bzcovr4xs4d47t35bjfasydh2poed35wf4ad5xyx@vke56gyq3ntg>
References: <20250313-jag-mv_ctltables-v3-0-91f3bb434d27@kernel.org>
 <20250313-jag-mv_ctltables-v3-3-91f3bb434d27@kernel.org>
 <a25daa5d094cf613e2f52fe716a17edf9fb26448.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25daa5d094cf613e2f52fe716a17edf9fb26448.camel@physik.fu-berlin.de>

On Thu, Mar 13, 2025 at 05:34:38PM +0100, John Paul Adrian Glaubitz wrote:
> Hi Joel,
> 
> On Thu, 2025-03-13 at 17:22 +0100, Joel Granados wrote:
> > Move trace ctl tables into their own const array in
> > kernel/trace/trace.c. The sysctl table register is called with
> > subsys_initcall placing if after its original place in proc_root_init.
> > This is part of a greater effort to move ctl tables into their
> > respective subsystems which will reduce the merge conflicts in
> > kerenel/sysctl.c.
>   ^^^^^^^
fixed. thx. Will not send a V4 unless there is a bigger change to
review.

Best

-- 

Joel Granados

