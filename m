Return-Path: <linux-fsdevel+bounces-16428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F180889D58C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 11:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF51284CC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3035880BE3;
	Tue,  9 Apr 2024 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGrn0NCd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D780604
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 09:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654782; cv=none; b=H9Tx+M7MXQveVOOPCNbF+i/9DjmfUg0VGVuMLEer3hGoYEVOzUKLGRgS+eZk0NJZHtdI5w8yIALrOAGPDTXj2z2fInhp9W1IvM+B7PR/tSmVs6tbmNJK3GMNJMhIqcEvV32lxm1JgHKUMotVOi5BCzgMqyBbioL253HHPabvYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654782; c=relaxed/simple;
	bh=M/8wTUUABhPC4JtHnZfMb3ngOM+mJXw2PLVjPBTyJ4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiJ8DCnH7ZNX052WRNUi06PZHnVNeEGJjv6oupjybFZSR6L4vCUWyo38LmxdAMUkkKV1MPuCSxAOFSl3OJolpUS4VWGg4mlSRyq2MA8nsQCPjP5Wfcyoaf8dofZWh2WRSrYtjRtJ9a3oaHEdjuYgqFxqeLC26UUd1aJYP25oPg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGrn0NCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB914C433F1;
	Tue,  9 Apr 2024 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654782;
	bh=M/8wTUUABhPC4JtHnZfMb3ngOM+mJXw2PLVjPBTyJ4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGrn0NCdj8vV0o4K5tyvXwwT40VDvQFPrAorORrDLH3/YhfLYgiAns13aaXJkoJZv
	 vjO2veAX4TePnto1lALQncl95uAiP8pe7Vh8SjrfGobQDthyOsb1ZJ4lgRZq06YXQ6
	 YbtUJ0Mitd/z6BjBitholkl8l+s8PrLPlKxdcswO+v0zK0FbfGGfDpAWV7W7CLBsDl
	 Z26nxxHq/utGC2wi1NIeKZ17O0bE3qDxkiIusvfanf4AxodbJ7CF4wfTG0p9vjgJdo
	 2bWZSvs3w2fJtpCUCUOwWPuXT7XS5ABja1MmxwXjEQMwmzqc5hEtXTn19zZny8vgsW
	 +/Nkr0tAcafiA==
Date: Tue, 9 Apr 2024 11:26:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH 6/6] remove call_{read,write}_iter() functions
Message-ID: <20240409-amten-deplatziert-9dbfa2362c02@brauner>
References: <20240406045622.GY538574@ZenIV>
 <20240406050233.GF1632446@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240406050233.GF1632446@ZenIV>

On Sat, Apr 06, 2024 at 06:02:33AM +0100, Al Viro wrote:
> From d8c77afeb9912f5eca06f53cbed7fc618c71b46b Mon Sep 17 00:00:00 2001
> From: Miklos Szeredi <mszeredi@redhat.com>
> Date: Mon, 28 Aug 2023 17:13:18 +0200
> Subject: [PATCH 6/6] remove call_{read,write}_iter() functions
> 
> These have no clear purpose.  This is effectively a revert of commit
> bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()").
> 
> The patch was created with the help of a coccinelle script.
> 
> Fixes: bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()")
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

