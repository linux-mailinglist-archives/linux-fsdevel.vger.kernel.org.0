Return-Path: <linux-fsdevel+bounces-25537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52894D2B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74AB1F213BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2024 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E6197A68;
	Fri,  9 Aug 2024 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwHcZV3A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78099175AB;
	Fri,  9 Aug 2024 14:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215331; cv=none; b=canPymCC+0f48/8qVx/tkhvdZQybyho9/E84xvc42KEiMRBOWAjgQt7DknaokTznzcQE0AxVH55fS6Cb+BgEWj+RcJfWZtifXzn+qfNFcOV8Qj36dtx+13eluZugVvH8URu27iBI+UCRoT/PSXRj5OjmM35xkKoJPnIJxUk3Gxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215331; c=relaxed/simple;
	bh=9hdG9Gd6W3+jb1cuyDJd2RwshB5BxCV52o81ISHdv7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVXhD8dWdCPe/lRlekiyVFtPgZBMD73JCvw2yXlvsX5DuhvbkOcq/cykTRZIvsE/X4e0VxlAjGGBi2m7Z8p+4uoIbS2Zam0mu0ZrWvanJ48FoTomxTuaKRwxPmNRooJ2mWrElYENkdSuJ0aVVT/xDuLZZ+dg1UQMuRkA+9yv+nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwHcZV3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C591C4AF0B;
	Fri,  9 Aug 2024 14:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723215331;
	bh=9hdG9Gd6W3+jb1cuyDJd2RwshB5BxCV52o81ISHdv7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwHcZV3AUe2QsAJnXPivzCIDlt/usDRlt3JEMBL80ciflLET/AmqnphcXjiFXreyT
	 B774PcO6p+kbc432+LJ/UMN9UWxxQqBYGm1uBGhXwu/OLNgf0tgMfgY4WyCOvxGG7u
	 5j03e+B4hKzcV3vIaPaaWnIrIJ5kfLse37P0d4yUXFeCZb4SQzUnQYUdmVeDfieLZi
	 t/rGwYQ+PO9M2NPHPBZknCZeYuXjit9zndAMEcI2mVUvK13E9Bd50p8/eXQWM8ZAu2
	 12fcwoTEn2TE8IKKqNlbqK4AatSUsK77C3BemgQ1iw3tR+ktY8g1d3Mp0/TLlx3P1i
	 GVJV1LTNm0XjA==
Date: Fri, 9 Aug 2024 16:55:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: don't overwrite the nsec field if I_CTIME_QUERIED is
 already set
Message-ID: <20240809-ausrollen-halsschlagader-02e0126179bc@brauner>
References: <20240809-mgtime-v1-1-b2cab4f1558d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240809-mgtime-v1-1-b2cab4f1558d@kernel.org>

On Fri, Aug 09, 2024 at 09:39:43AM GMT, Jeff Layton wrote:
> When fetching the ctime's nsec value for a stat-like operation, do a
> simple fetch first and avoid the atomic_fetch_or if the flag is already
> set.
> 
> Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> I'm running tests on this now, but I don't expect any problems.
> 
> This is based on top of Christian's vfs.mgtime branch. It may be best to
> squash this into 6feb43ecdd8e ("fs: add infrastructure for multigrain
> timestamps").

Squashed it. Can you double-check that things look correct?

