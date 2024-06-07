Return-Path: <linux-fsdevel+bounces-21262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC76E9008D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A8D28BAEE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1706E54660;
	Fri,  7 Jun 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJ48PDrZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896A194C68
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774038; cv=none; b=KMt4dgOMC6fRPZMD0vTpKGg15j8A+kxH58h77Iq2LQXc2dOBuaR0Ok7/+SN3LDwnY1YaHXqECQtTSw6h8iYEUJ3Qqn0Ch9z6AqcOAoF+9ixGye5x236HcQDx4KvNTh8p7qsOrKHtcGNg6GAiWK9TVubhAg3EP8+W3HuSYZMr23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774038; c=relaxed/simple;
	bh=gpmY6853elS1LMpQE6oJ+Lu4b+5rITvh+ikAoCdX8OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyJgVkaDcJWEetwfCR3e5aaI9P+1k8BlRDottNrvhJLOOw67lFVaByPBK0wyYXAtN4fs41ZyNFL/D7YJ1Y1Tsom/hnucSuWyXRWDFWPyohiDXdEDo7V+qPuXvWZ6tfM3R50GyAL5vC0ZsuYtae3rfWy5jAWqcG5ZYOy6cynlLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJ48PDrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F787C2BBFC;
	Fri,  7 Jun 2024 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717774038;
	bh=gpmY6853elS1LMpQE6oJ+Lu4b+5rITvh+ikAoCdX8OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NJ48PDrZu33ZWnXvGy9o0uAgNczNqm+2czMStEAt6qwUspsjIzvRb3DDV4FD9BmQv
	 qkwH2qeLydFRWWdtkEJRTnAIO7FBhS9vutAnn1d9PBWG0KPA6Y1OSaQHJP/myC7jfH
	 2F6NAACKdrzrMX9TSJb84fJfGBSkc2Zm6rE/sZG2vd9zshemk8Rl0WoR6bN25DgxJG
	 K4xA6n64773kkd5gcgfvIUgMvX+ckzUguLr6X4d6+eYUorjePu3LK0H4PkyukX4edi
	 HPTv3o3pqrC9FGjm6M34638m5z1L4uWlvRXeAiTaYB+hHENsxs8CtD2AxZ/rSC+TEk
	 IV2eX8ZJXFGRw==
Date: Fri, 7 Jun 2024 17:27:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 12/19] bpf: switch to CLASS(fd, ...)
Message-ID: <20240607-covern-beute-693e54df065a@brauner>
References: <20240607015656.GX1629371@ZenIV>
 <20240607015957.2372428-1-viro@zeniv.linux.org.uk>
 <20240607015957.2372428-12-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240607015957.2372428-12-viro@zeniv.linux.org.uk>

On Fri, Jun 07, 2024 at 02:59:50AM +0100, Al Viro wrote:
>         Calling conventions for __bpf_map_get() would be more convenient
> if it left fpdut() on failure to callers.  Makes for simpler logics
> in the callers.
> 
> 	Among other things, the proof of memory safety no longer has to
> rely upon file->private_data never being ERR_PTR(...) for bpffs files.
> Original calling conventions made it impossible for the caller to tell
> whether __bpf_map_get() has returned ERR_PTR(-EINVAL) because it has found
> the file not be a bpf map one (in which case it would've done fdput())
> or because it found that ERR_PTR(-EINVAL) in file->private_data of a
> bpf map file (in which case fdput() would _not_ have been done).
> 
> 	With that calling conventions change it's easy to switch all
> bpffs users to CLASS(fd, ...)
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

