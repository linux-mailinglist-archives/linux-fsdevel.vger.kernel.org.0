Return-Path: <linux-fsdevel+bounces-12431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D085F3CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429DD285159
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8547C376E6;
	Thu, 22 Feb 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puVMFDPM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE08374E6
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Feb 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592559; cv=none; b=rnsl06iTM8nC29xUNNyqgK1qc/evVvQRCPtOQwkHcheS6c8EQCC9MYnHWyX+7HfJwervN75nnxU/yd589Ca3ZtZI4kpg0i3WaykByEKEI5iBrfodIL/QBh0+oQwklaKOldfl4/lSpDwa6Jg5vqM+aTEtMsAI/hC7w/fWUpfbK38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592559; c=relaxed/simple;
	bh=+9OsRvCVRghnYnaEw7EKLBL9WkFoFFnIzJgKslYO7og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEP+EcctF7T51fJHofwQAIv/lnAZxltgDnD7mMyCKf3VLBbNmgpZVFPkBKaIzIeL0hKLRwgtUXq3FY+Jnsxy5oYjyGVm+jPR4RedHzxsM3EnBh8gCyNCdDnvbqY03sOAJHL4/GqGe5koQO4zZ0F+6PKnhWMbd80cn2U+/GhTjxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puVMFDPM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039B6C433C7;
	Thu, 22 Feb 2024 09:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708592558;
	bh=+9OsRvCVRghnYnaEw7EKLBL9WkFoFFnIzJgKslYO7og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=puVMFDPMG+hnSysIIsdNShPlXhSx8xM23mjEUZEkHLg4SBwvvfFj+XqeqAm6WdCZk
	 M9S7s6YPVa3zPRabi1jJCTU31YhXJSXzP8rBzBhNk71T+VCYtbiICCi+KujzR609dU
	 TgrXPPhmdvABb7PJS4uiWUCY9LDQPTedYl6kH51WlIw6VZ8kFluCfEby8oiwf2ENh3
	 zw8B3AtAz35px2YNc1sVvHlz3VBH20K/1WhqsBRkR4017209f2zDpbgH0bhYiw3oto
	 MivNE9gGx7W3oiAeyWiXQo41utmNVpPUQ6WltbWNtodn0MNSVVYQug7pizVRyExJcQ
	 YuAWSySiLUL0w==
Date: Thu, 22 Feb 2024 10:02:34 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Jan Harkes <jaharkes@cs.cmu.edu>, 
	Bill O'Donnell <billodo@redhat.com>
Subject: Re: [PATCH] Convert coda to use the new mount API
Message-ID: <20240222-frisur-beinen-757f10dc3b8a@brauner>
References: <2d1374cc-6b52-49ff-97d5-670709f54eae@redhat.com>
 <20240221-kneifen-ferngeblieben-bd2d4f1f47db@brauner>
 <3f5ed838-17c2-4a2f-b46c-658cb5b31718@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f5ed838-17c2-4a2f-b46c-658cb5b31718@sandeen.net>

On Wed, Feb 21, 2024 at 08:52:33AM -0600, Eric Sandeen wrote:
> On 2/21/24 12:23 AM, Christian Brauner wrote:
> >> @@ -313,18 +342,45 @@ static int coda_statfs(struct dentry *dentry, struct kstatfs *buf)
> >>  	return 0; 
> >>  }
> >>  
> >> -/* init_coda: used by filesystems.c to register coda */
> >> +static int coda_get_tree(struct fs_context *fc)
> >> +{
> >> +	if (task_active_pid_ns(current) != &init_pid_ns)
> >> +		return -EINVAL;
> > Fwiw, this check is redundant since you're performing the same check in
> > coda_fill_super() again.
> 
> That's an error on my part, sorry - David had it removed in his original
> patch and I missed it. Would you like me to send a V2?

Ah, no need. I could've just removed it but since you did anyway I'll
just take your v2. Thank you!

