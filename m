Return-Path: <linux-fsdevel+bounces-26749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25CD95B957
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 17:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B82B2852D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796801CBEAE;
	Thu, 22 Aug 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4whLqsB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1171CB31B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 15:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724339417; cv=none; b=s7Pi6Gvzg2vKn/nOuRhQc4Hqdk4luWhr3xgl2BCFN2IwlY6bOuZ+ZjWmLMAxKAKMMrOb/GZTm9L274nnUzSEsy7h74Ag1lgcehPBeBYXzIJykIOUWQ+lWiDu+7sIjr4Ut7d/owvswkEuHE4wih1ui/AbkBF8eYJI3fVmFaw2L/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724339417; c=relaxed/simple;
	bh=16N9pf7XuO2lnyfaeSTYhTBYjEkgWZZVl7/3OwOm/ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4WaQhLe7vPxLmwcOtg/YEn3fvSJjuPtOd13tokt5g/sn8+vhIYOLwNiki8feNJogUGsKwCnP0Iw/Kq+vywkn4+x+SGUZRqwQIGA1QWfxVt1XTNmAIJAA1TdMSJvjEjHxAlEMVP07ao+QgyXAJES2sqWS6jvpKCFpNL02cOTYyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4whLqsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAABC32782;
	Thu, 22 Aug 2024 15:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724339417;
	bh=16N9pf7XuO2lnyfaeSTYhTBYjEkgWZZVl7/3OwOm/ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4whLqsBT36Kv7FQ0Q+LoYr2VfrgIETtOGI8YOdIh592o1KpJ8E06Sm8kPzyWSsfd
	 SfKnXaUQvt9+rqgD2leLcv3wkJWCTumSwdSU/ikYDcwsEmfv6b5DVEl2IB+T5nmpmk
	 5idKpqXn4nHCbDTs93Zg8+MRAediKPBUpTuX7zty30phO0UGKooTZ/+Cq+pCWZ6XTh
	 CLC0NUH7FkwXXc7GVVmupPTopa2bVulcHqVG1re+3cE02XtVMLI6xVwgbJDZxmbN2o
	 kFM2f3Pm5KFaJS3CICUq/scD9vrvxYpu8RYxXkmIXC+ST1xR+sEWohRwtZcW+YulaL
	 FAHkiNja6Q/bw==
Date: Thu, 22 Aug 2024 17:10:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: switch f_iocb_flags and f_version
Message-ID: <20240822-soviel-rohmaterial-210aef53569b@brauner>
References: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
 <19488597-8585-4875-8fa5-732f5cd9f2ee@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <19488597-8585-4875-8fa5-732f5cd9f2ee@kernel.dk>

> Do we want to add a comment to this effect? I know it's obvious from
> sharing with f_task_work, but...

I'll add one.

