Return-Path: <linux-fsdevel+bounces-59307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F27B372AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 20:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF4D168CB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0C371EA1;
	Tue, 26 Aug 2025 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez1sD5dN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0312A1FECAB
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234619; cv=none; b=KheJJr26ZQ8UAoKxF9tqSWo7JJhWGMqyHo+Fof8PswI5hmf73v9a9mIrLi3J/j4lJFYslc5On7Wl7iMgrPOHxMSFRROCiCfYrnHcCDNTugtSSc1ZXSaFewQRXKqVdjdmYNumBPF6WolM50jJQhPChKHiNcY9pvc00NOT+EgOuQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234619; c=relaxed/simple;
	bh=lf5QZd6ZoCEbt0aTe9X9Hia1eSHRpFwYaz95xMSxIIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m28XtBBegGOtZFj/5nrLJwjQM6H3zuKcezVYdencaO6LIG/8TkgLN1BmdhuGc1T33mp180lczJ76FGR57+1rTrAGl7lnZ2Mxvhnbt6I4J0yodvdVWs2Md7p20Exe0c2fOT1/jeaWv4+x2QX5fbv4IDrKadGQBO5qc1+J5gLOJ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez1sD5dN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820C1C4CEF1;
	Tue, 26 Aug 2025 18:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756234618;
	bh=lf5QZd6ZoCEbt0aTe9X9Hia1eSHRpFwYaz95xMSxIIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ez1sD5dNM3BIcbuUsftSB8isnMKd5Y9LE+ttHJOU+aP1JgUDLzJ/0a/q9K/3SJshJ
	 2fkPoArehqpMUj164gwbKOcNPZkmn45/DzuXJwm/+SAzcTrjKcotmPHtQBcpmpDdee
	 ZV1aflRr2EQONBoeGEAXvP3y8rbI0qwvG3IFPg/ujxcpkPgwcp7+kIHYIW80G6G0Sy
	 xaTTEqRH0YCR/n6uvZsUr2/Tdmk6dG/mq+Fd7Sm5kbnt/Ri5h9poj27HKfZG68fIdA
	 kxd6BvTTr/5Iv+nwOqrUNLadzUsLRIdGZo7a1addM6n3/6JiaNLKIWZt8VB9PaHQBg
	 4mq/k9tQcKITA==
Date: Tue, 26 Aug 2025 11:56:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] fuse: implement file attributes mask for statx
Message-ID: <20250826185657.GB19809@frogsfrogsfrogs>
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs>
 <175573708630.15537.1057407663556817922.stgit@frogsfrogsfrogs>
 <CAJnrk1bOE3g_wtBtYhGBGPL_sDXPZgAwo6pgVOhadFoPuDeHZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bOE3g_wtBtYhGBGPL_sDXPZgAwo6pgVOhadFoPuDeHZQ@mail.gmail.com>

On Thu, Aug 21, 2025 at 05:01:01PM -0700, Joanne Koong wrote:
> On Wed, Aug 20, 2025 at 5:51 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Actually copy the attributes/attributes_mask from userspace.
> 
> This makes sense to me.
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks!

--d

> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h |    4 ++++
> >  fs/fuse/dir.c    |    4 ++++
> >  fs/fuse/inode.c  |    3 +++
> >  3 files changed, 11 insertions(+)
> >
> 

