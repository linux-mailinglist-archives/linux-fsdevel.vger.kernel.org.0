Return-Path: <linux-fsdevel+bounces-25264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D0A94A56D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6EDD280F5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93F61DF681;
	Wed,  7 Aug 2024 10:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAe6vQGp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455E91DE841;
	Wed,  7 Aug 2024 10:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026425; cv=none; b=J5abVWh2U6nK7O0PcvgQnX0StMrRp35PUPPQGYX1CwYb/pdP4BzkgVce3sLMtiaUV8j9vgE5PqLSA9UiJOQKD64Y5GWVHgfrwP85CI2fY/zH4p0iW/vvQ3txL02fb/ULjOMQXZhsmh4wC8wRVNoJ25rNH8zk0P1EFbIyQJrGi6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026425; c=relaxed/simple;
	bh=5BSdOkb+iDxlnAlZkWpaP8YnJiWaaw6FtzKmKu7mF7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlJ+X/Wml+qpGofj4vD2QDoTK+wAbCLXIxRjTWv6QhEOFbWNU3Y4gRSqNEva/eBEPwYDWZ/7xqRUJqfeLzBd3BMoUmGH1Dwei5aZZZUEMhOnyKvUoet4MMPxX3Jz6e05b0rE2HnDowsJ3RJ5hJ2sdLsL8WcxN51eTyIPQVCmyts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAe6vQGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9383C4AF0E;
	Wed,  7 Aug 2024 10:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026424;
	bh=5BSdOkb+iDxlnAlZkWpaP8YnJiWaaw6FtzKmKu7mF7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAe6vQGpj1ZsDTcw1xYHvSnJP4xAXpAjBxg+CXIPGK1whg7o0npI51HgfCyyEMO7/
	 lOal8ON8w++M5RHmlaj5k9aaaLS3oNoqUP/R+e31C/v8B1UsSBx9dcCgsGrhR8ZpwU
	 eSqbpDl8ZhgQhte/oDaNYYzuWNIcJnLqv0R7CRA4lH9doqDqRw+Pioe9h5qWEZpFxK
	 Rn6b8gyrnPrGabswUVgCD7t7m+ysj044W8XFxqcqsGFtvHpwKyHikVv48fvtY/GekQ
	 2YFl3ukW0NzyHapgXQCSa8En6t8nXrDps8yMbRFqNvTkEpn3mf9lxfuqtOmSiW3JC/
	 yxe17AdpCfBpg==
Date: Wed, 7 Aug 2024 12:27:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 13/39] do_mq_notify(): switch to CLASS(fd, ...)
Message-ID: <20240807-zeitraffer-milieu-b75a7470e0f0@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-13-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-13-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:59AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> semi-simple.  The only failure exit before fdget() is a return, the
> only thing done after fdput() is transposable with it.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

