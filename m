Return-Path: <linux-fsdevel+bounces-43881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C6EA5EE0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 09:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E2016EEA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9864726136A;
	Thu, 13 Mar 2025 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ1+d4DL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD5725F994;
	Thu, 13 Mar 2025 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741854560; cv=none; b=br7o3BRxHIPNrjLbPo6FwE5m/SNvQSsbZO9OaenBIV4tws9kha12ASks2TljpqfPvb5DoaSLnpPgwk9rvZYfhF0NrXmmaCzPoCyRTdtIuA94s4aTn8N3WVY7rjDGTQ+KbbM25sTnIFY8tKTyI4WQ8lXKCsEyUVOyWiCf/7j8KcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741854560; c=relaxed/simple;
	bh=O09GVeEuVHeCa3ne5jBx4qdVNsD8e8YYV6YO3FG8m3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9NlmPzF7psGEpuCVVUhtcgLaqaph1xisobLOxIrC7ZftJ+p6vxbu1zDfUMczozeye1O2e2brPEbbdse0EGEkSm0xEkBsDq0/wdMQE17dn1XtTzODZ5gn9+GqJ9Jg3kNFCShLMxzWLq99YooIOM7oVPDOwE5xxv1zzefMwMxncA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ1+d4DL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A6FC4CEDD;
	Thu, 13 Mar 2025 08:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741854558;
	bh=O09GVeEuVHeCa3ne5jBx4qdVNsD8e8YYV6YO3FG8m3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQ1+d4DLO3webXYHvz9KgpDefEPBf2U4c9Tgz05y29T1pcp47qcrQ6Rjfp+Jg5ziu
	 +Yn1xLLZ4twmFvM2ckVBGJbqP15C1QKXNJqzSLcLiX3yyj6sU4JTN+6LBEceMzcwwP
	 t+pkhIFKLiQlyuZ+u5/RrndtQXL1G2hjW4VTekv8lZl+64EU164iUYqivcMwKPZNxg
	 vkQAfOe3NzWJiOUlOCFK6kLmJPRQg0IZhzkyW7B6W6D7UdftJBovv/GP0dnHFcTyFD
	 JZo+OlufRO+AjvIjWUQA5bPF7epjj0x+6U4QLlvsl9G4XJLt6OYaZ2FMop31JOeZjM
	 SkAL+O4mcxRmA==
Date: Thu, 13 Mar 2025 09:29:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 4/4] qibfs: fix _another_ leak
Message-ID: <20250313-kuppe-stich-9a14279590c4@brauner>
References: <20250313042702.GU2023217@ZenIV>
 <20250313043020.GD2123707@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250313043020.GD2123707@ZenIV>

On Thu, Mar 13, 2025 at 04:30:20AM +0000, Al Viro wrote:
> failure to allocate inode => leaked dentry...
> 
> this one had been there since the initial merge; to be fair,
> if we are that far OOM, the odds of failing at that particular
> allocation are low...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

