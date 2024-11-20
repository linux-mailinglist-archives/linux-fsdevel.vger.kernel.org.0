Return-Path: <linux-fsdevel+bounces-35277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DADA9D3597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE94F1F24D22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF22C175D5A;
	Wed, 20 Nov 2024 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATojxO5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D6D60DCF;
	Wed, 20 Nov 2024 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091811; cv=none; b=KH5PbZtlaPxbbcS1NEqRmNlLIKPQsq93Mjvhr5ZyJLa8/Cq4mCPxyLM0a34DSeEb85RapbiJi0jbgMHJ1oVCopaOhGkDCAlRGI/cRcQqZYxSVtzh7vi2gJYC3ahQ6APkHNXopfP6TkR4PLQA3VYBZ/LfLh5DpK5WQXXFwmTu10E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091811; c=relaxed/simple;
	bh=s3ybmZ+VLfqqhBLlXqh9eJHCy+npnwwZoO4G5H/Gdvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anDkUfEcUXKjHIuS3sVok86P7yvO9/quofg6l85xwc2BhN4XBEtG4oiT9pBfJJSDpj0lvl/htl7ZNjuVpKZN8phQvHZSnOm860+H+111sJuFTrQfAZTxOjLq9b66kZQDqlJPDrrD4jEgMgdVCgd5gAZxTf++MGUpgT2reLhdzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATojxO5/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E60C4CECD;
	Wed, 20 Nov 2024 08:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732091810;
	bh=s3ybmZ+VLfqqhBLlXqh9eJHCy+npnwwZoO4G5H/Gdvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ATojxO5/2XvITDWTWEwaFVdudV1xxhuCW22QXFp6T2+zKOB1B+H78hN5SNnmFUPIm
	 RbJuafLMGNFkJlZMAcMbwpoCiuvxPp1pYSvJ1RLeU98TnDbsND8cnkJBM3vcSSJmGo
	 NastYTiELnLQGFq4zbgD5/dDhJq0c72q95fE6vsfvLE6SgfcNh3eviGetYYVmj4F2M
	 0X1PGI+YGiwNdsCoMMoiqmM7xOBG2efLWBBLs2QYe3GY/aJeDYfwj8Zp0Rl/zaZJOl
	 yJfGJzm4y+crfOK/UlSeZorRrtnW2lDFFAv/fWtIdagtwPDw+JLTfP85LyWAJaXlW6
	 dEhlLGBZnYeDw==
Date: Wed, 20 Nov 2024 09:36:46 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] vfs: dodge strlen() in vfs_readlink() when ->i_link
 is populated
Message-ID: <20241120-harmonie-ankam-96a9a270908d@brauner>
References: <20241118085357.494178-1-mjguzik@gmail.com>
 <20241118115359.mzzx3avongvfqaha@quack3>
 <CAGudoHHezVS1Z00N1EvC-QC5Z_R7pAbJw+B0Z1rijEN_OdFO1g@mail.gmail.com>
 <20241118144104.wjoxtdumjr4xaxcv@quack3>
 <CAGudoHECQkQQrcHuWkP2badRP6eXequEiBD2=VTcMfd_Tfj+rA@mail.gmail.com>
 <20241118154418.GH3387508@ZenIV>
 <CAGudoHHJwreaSZirs6qfQw5-qRnyHsFLeKp_=T2=S_J=VezKLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHHJwreaSZirs6qfQw5-qRnyHsFLeKp_=T2=S_J=VezKLg@mail.gmail.com>

> Apart from the few things I posted I have no immediate plans to mess
> with anything vfs (I do have some plans to reduce the cost of memcg
> though).

Woh woh woh, you're our new perf specialist. You can't just wander off. ;)

