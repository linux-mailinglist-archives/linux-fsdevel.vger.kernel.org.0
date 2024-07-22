Return-Path: <linux-fsdevel+bounces-24047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CAD938A24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 09:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D0C7B21054
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353C413D523;
	Mon, 22 Jul 2024 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuSvrH+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91046125C0;
	Mon, 22 Jul 2024 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633760; cv=none; b=aSQrJ9zZp2AJF2vyns9/v4WhUDaMV1kcsR0ezzER9UIQ4wDg/QVEKIEZ6egv5RDL3oxuUuSEG1af02gm3S1dfXEQf6g5QpXIKES0JDTwRzbBRCo1bMGOt9pIuCaK4rve4revYFwASj0gZ12d1AFBs6APJmzGD9p3Rl7/L4SnCqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633760; c=relaxed/simple;
	bh=4PAlQ+yg7Xd6+NV1GiGtYKKrx8OPRd5Ylb6fHrM5rtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sx3CTTxBiCstSrex/WK/krdN46YVsSJ3X8yQB38iNPPSR6NWIZL3Ehwgn77g/gE0+SUZ9SsXJFj5JFjEH0gU3ctu1Fjg8PVF0whF1FvGvWURZ+8+d6Q1Dnnq9cdUEBvRhK08u990i4lkgBNeEqbbVOliJVKiC1xyyTrOBBJMySc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuSvrH+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50368C116B1;
	Mon, 22 Jul 2024 07:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721633760;
	bh=4PAlQ+yg7Xd6+NV1GiGtYKKrx8OPRd5Ylb6fHrM5rtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuSvrH+UT0+Oji7/GcG4iWsS29iTEuq2ZxWZWdD9528PH8kkr7c+cZTMtkDo63oOJ
	 0FZ9PxPlqWD9d1PD3p3rDj88Frz72EQ0XuWXWbC3XTD2sOlM4TCi11JJwZnWKBNjFL
	 AmTjpoB5fKeXSdeMnlJXfA3LzsDkdqNoOwhCAr6Rv/Ciob3gN8jSUFzkaYdUFbaCZx
	 G/rNzDs18MnRSVA1g8v8gUb4lNPufVgqKVs1zFw7ra7E8yv0K3OLHGfZJSW6yGdCEb
	 Yc5zpQyJ9H4i35Ae9yh+MA1SKnJkhyFLFqnElNgrcZ/240b2Q090WOflYuS8z1GZxm
	 MV5H4wvyv3GtA==
Date: Mon, 22 Jul 2024 09:35:54 +0200
From: Christian Brauner <brauner@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Gow <davidgow@google.com>, 
	SeongJae Park <sj@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] execve: Move KUnit tests to tests/ subdirectory
Message-ID: <20240722-kuppe-pulver-17c740e4608c@brauner>
References: <20240720170310.it.942-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240720170310.it.942-kees@kernel.org>

On Sat, Jul 20, 2024 at 10:03:14AM GMT, Kees Cook wrote:
> Move the exec KUnit tests into a separate directory to avoid polluting
> the local directory namespace. Additionally update MAINTAINERS for the
> new files and mark myself as Maintainer.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  v1: https://lore.kernel.org/lkml/20240717212230.work.346-kees@kernel.org/
>  v2: file suffix changed to _kunit instead of _test
> I'll toss this into -next and send it to Linus before -rc1 closes.

Acked-by: Christian Brauner <brauner@kernel.org>

