Return-Path: <linux-fsdevel+bounces-16535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C2E89EFAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 12:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859C31C22999
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 10:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151F158215;
	Wed, 10 Apr 2024 10:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h01NLqdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6E5155737
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Apr 2024 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744215; cv=none; b=YIocs0GUhCY8gm+DkU/B98YetKVxOLYxEqKAVLREKpAAcwgCiTwsZ/PvW6jdIJqpxkhZTlnDFFMLa0Pry6bfoYeM21z1r4qrhuRZoJZV1P8z2lyOR3+2BE9xXkh2s0G7oVKxSGaiJiIKlprZpxI2qZtW5nJPZtp3AiL69+mHHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744215; c=relaxed/simple;
	bh=aRc91Z0/LQWa5LLhujtzzeI34GTfUxbZxZtfPqEbeGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnSpwYVMz9fQn0ftRTI7kBs+5Amj6caULaVosLdU5p2+g1O0/qGKH6F2+h6At6BvMJG+WHLWS6wb9CxG/Wb9A5O3N1R9NjOQZwuIWfGlgaCivex6CpQZXjYGkK3K1vSHPtDn8eI42rTYiMktTZuasnClI3vnjr/D86b3KwC+h90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h01NLqdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23264C433F1;
	Wed, 10 Apr 2024 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712744214;
	bh=aRc91Z0/LQWa5LLhujtzzeI34GTfUxbZxZtfPqEbeGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h01NLqdMj2ihEsuFGdsAV7M6yWob1PHTywB0OoyC9gkUD6X3JVk/ScSVBbWNjNKvh
	 8u8Yl3AjdolC6o8lbPIXGtceakFhAmg22SDQ3S1cKsOp6oWYLvt2bLgx5ImAuUtPxP
	 HhVZSBcoYUwsfMW4h8hwoG5MdlMu1vJONn58KcMilfsnHlkPM5aKuNEfRB8DP4Ma4B
	 h8K+wMIYmpOZ49CJgOUwWkEyc5nURXFzxXMaPBXk6P3Mev6rVRnA35uBxCR6Pgh5an
	 dz44zJNDNV1d3lm2BcFGck5XgN5GuK1wvib96LlpPZSbit3yu/9LzaHsCNCFbzcnbR
	 lSwg8IVADMCBw==
Date: Wed, 10 Apr 2024 12:16:48 +0200
From: Christian Brauner <brauner@kernel.org>
To: John Groves <John@groves.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, John Groves <jgroves@micron.com>, john@jagalactic.com
Subject: Re: [PATCH 1/1] sget_dev() bug fix: dev_t passed by value but stored
 via stack address
Message-ID: <20240410-mitnahm-loyal-151d4312b017@brauner>
References: <cover.1712704849.git.john@groves.net>
 <7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a37d4832e0c2e7cfe8000b0bf47dcc2c50d78d0.1712704849.git.john@groves.net>

On Tue, Apr 09, 2024 at 06:31:44PM -0500, John Groves wrote:
> The ref vs. value logic used by sget_dev() was ungood, storing the
> stack address of the key (dev_t) rather than the value of the key.
> This straightens that out.
> 
> In the sget_dev() path, the (void *)data passed to the test and set
> helpers should be the value of the dev_t, not its address.
> 
> Signed-off-by: John Groves <john@groves.net>
> ---

Afaict there's nothing wrong with the current logic so I'm missing your
point here. It's casting to a dev_t and then dereferencing it. So I
don't think this patch makes sense.

