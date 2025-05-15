Return-Path: <linux-fsdevel+bounces-49109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BF2AB821F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF693B95F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 09:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD1D288C30;
	Thu, 15 May 2025 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD0ywOEm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7991C36
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300164; cv=none; b=YeznGFVu2xSHYYIi8iWiHu+tIcs3WGpR4I5NNuWI8bg44iElJ6TFlhqJwcwml7e1L5XJPjDo6SMWa5gzPaFFfFXfXfWdB5XxnGI1lh4/ydLdSf+B5zf0UL+GkQz68BUtE/6UJ6sJec5patBxg7+zR39wfvj2+/y0dX523mpiKq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300164; c=relaxed/simple;
	bh=YWB2Nq8HDiV9l8F/XA7QS85fgd8uR2zuXT+qacAL7Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+xHiTOPnnlmYD6wCdFcdQYNK6vpdHaS9ZsabcVNq/nmlR/7u3XMdKWesuwnOg8pGlxuKWWZ3LCMCygMwT9yMlBnaQ/1tJNW6nl+yM3XKtkonx0cHOUntfRCUy9xIwNNXI3fgYwJs9nggchWb5HHtyfgSGmbH0KVaIdFkgaKThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD0ywOEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BB4C4CEE7;
	Thu, 15 May 2025 09:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747300163;
	bh=YWB2Nq8HDiV9l8F/XA7QS85fgd8uR2zuXT+qacAL7Qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kD0ywOEmGFhp3W0I+2n0XOgpz3um/JzQ8tJB3g7KCEaluEVDGafFYISdWbgV95wQ2
	 GZPORQs1yu/RF2JsiZ6t+eUX7t3f6ROragc9SICOMmcmsnwJAq6pcVxfRmOfVsvozr
	 NYdQhhSs5PoYO0FA99VYxamaP7LoZiWDcsp7WKX5KJNC4oihUaNL3DtbJkQDX/xIsp
	 gPvjqzNub0NNdiUoPdjJ/rBVGLR39ZU7rkWHO0CNTLOLNt0nr+ZbFwqSJ86YbJqzsu
	 kS+vR/Tu575k/nQKz5GKWeBVsojCRVTky4fshNletx/mAvUy+fPUAkzaRn3xxg980s
	 egLW7diCaZcjA==
Date: Thu, 15 May 2025 11:09:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeremy Bongio <jbongio@google.com>
Cc: Christoph Hellwig <hch@lst.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs: Remove redundant errseq_set call in
 mark_buffer_write_io_error.
Message-ID: <20250515-wohnbau-rhodium-5a038e20165a@brauner>
References: <20250507123010.1228243-1-jbongio@google.com>
 <20250508050224.GB26916@lst.de>
 <CAOvQCn5UySp1U2SmfDG59GZAavfOa4dbRwSWzfT3tumQ8OCBQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOvQCn5UySp1U2SmfDG59GZAavfOa4dbRwSWzfT3tumQ8OCBQg@mail.gmail.com>

On Tue, May 13, 2025 at 11:36:35AM -0700, Jeremy Bongio wrote:
> Hi Christian,
> 
> Friendly ping. Can you take this bug fix?

Hey! This is already upstream. Thanks!

