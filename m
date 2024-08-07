Return-Path: <linux-fsdevel+bounces-25274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BB094A5D0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E55E1C213DC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11541DF678;
	Wed,  7 Aug 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQvkGQnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B861B9B40;
	Wed,  7 Aug 2024 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027196; cv=none; b=nI6aoImcrvXu6Wtf6BXQKxOzMZTCS4YZQVD3M7wy/9bi7+vCvLbQ3TgCgxrcmytsQOFu5TWtc/mW004sGcifAmkwVzNzOeOd1GH0R1cOHMf4VjOmB6HxcRI1tMOuMF66pFTA7CwaoirIj7mvijQfexcMprL2yZWcvsfCTx5MUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027196; c=relaxed/simple;
	bh=7usnr5/ys9PKWWvSRxFCFA9k/aLcaxOUnKKNT6Kbvj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEWqz24KqL1x1zEb+BtXBYlZuJmRtSlQ2nWI4KxDwsP+fqNBQVZSc78oP1IbPAB+59rQ9c5H2Ey9e8K6kk599T788ya3qFkhGNLk0O6xhoEzDBiTUY5B71tOSZifzzR21EPN4HDRiW9CM213p6wl7W7RHI7jv60zhfx17RX0sGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQvkGQnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E65EC32782;
	Wed,  7 Aug 2024 10:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027195;
	bh=7usnr5/ys9PKWWvSRxFCFA9k/aLcaxOUnKKNT6Kbvj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQvkGQnnMsQlcTTzLwQRwS4nuQ8VDz0lln7HB8kDhSig38oO7OrkzXOvrbVeeiaGC
	 3UMz7X9ijp4w3becGoIeFgq/iP9suKsmEZnKd37M8CUZwUEwVH4eSdLas3ENM9157d
	 qyIYR9ofiOMRwZl9TRXmR5jTyO8OLrdaWJG28uc7XWexM6S9HpRfE3TJG+/hM7aAM+
	 IgUTcPNW//O8WOZsn4XgUILevCpwYR8AvZKqvuUJUNch5jdF+27KCu/NO2qYFivYUP
	 UG/U3Ewthu0eA8Ttztey/sQ3aLmoEbqeQ6wrEL2QRcvkfFEE1HhJMXQP8fIYn8NhFw
	 Y25naIQN1Grrg==
Date: Wed, 7 Aug 2024 12:39:50 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 26/39] convert cachestat(2)
Message-ID: <20240807-zocken-umstand-a87d9f5fcdaf@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-26-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-26-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:12AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> fdput() can be transposed with copy_to_user()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

