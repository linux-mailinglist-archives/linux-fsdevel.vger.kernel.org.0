Return-Path: <linux-fsdevel+bounces-59062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F559B340B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47F7169578
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6B5219A7A;
	Mon, 25 Aug 2025 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxJroWLG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5DF273D73
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756128624; cv=none; b=odWisr8lXgiigm3p90BE27ESLK933Lg/g8kSBi+myBUw44vSFjjqM7odpNDJAYjy8JOgqx9K6DbYOq5DFcReYk8xwi2GV125LhbL79Fiadr8vuKt6N6c1MzqFd1YEr3Ilmka46TSFaQK4iYF13Yj3F/tg3H0Qug3Ea2M9YcHD0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756128624; c=relaxed/simple;
	bh=JP46pJhKfIyAcNZ3ut4WGRVwVYQY6iYDfSX08YqnI+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seLpRqpB+Cx8ywpnPvi0PrFoTuibVqalsSStnVQLZNBtX7lM1ZB79bsLhjKk/uYcOTjrUaLBWlJ1cOsaJCeNm4ZgbHnS68G8JJ9vkFk4bCLUe76OChDmiuDhJqLQoINc6Xpiw6u2nEx+KYR0zU3WjjkrTpXrBTBOS5ziyLJW4qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxJroWLG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213CBC4CEED;
	Mon, 25 Aug 2025 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756128623;
	bh=JP46pJhKfIyAcNZ3ut4WGRVwVYQY6iYDfSX08YqnI+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OxJroWLGRRbdD9CHybcNxVyrvT42+p8rdKjAo/qQrNAnKklWl0llvuyGQdzi8M0qv
	 WRKQ1J6BqVmLWGGgUbs6f7+44AW+w2Nt9Cqdl9T36CeMgldReDPcpUb9tKH9aJOdeH
	 nT6HgupYnYMTVZpGptZwZ0PdGwnx5dQvbljdlpOOuWIyBT1gobNZeqFQZrF7qON05n
	 baayv7uihsjMC0h/AcTO2QM+H51cRVPlPOVNFFqrRyOXi9TaE0skiVdr2VnFUTpnCf
	 yv0wXcs/09uI9llalMVaVoaGz25tfKl58r8GaLM7BB+JJtO8Mp3vwPce1Bwptmqn5C
	 nQpf3eUcRjeTQ==
Date: Mon, 25 Aug 2025 15:30:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 36/52] do_mount_setattr(): constify path argument
Message-ID: <20250825-kommilitonen-fugen-7b7315027f3f@brauner>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
 <20250825044355.1541941-36-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825044355.1541941-36-viro@zeniv.linux.org.uk>

On Mon, Aug 25, 2025 at 05:43:39AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

