Return-Path: <linux-fsdevel+bounces-35302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AF59D3867
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102171F23E24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 10:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58119D06B;
	Wed, 20 Nov 2024 10:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Azh29eYh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3D156669;
	Wed, 20 Nov 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098811; cv=none; b=WCChM30X/hEq6xJChzXwnbjOilq2WjT9B8FxPPIe9EUVGyMJNcg2FcNLd2VIAdRApoSC0anHHEbqD6ek3IvtduaO+ICZFVpZH2C3pFh1V3ma8hY5f51bxa3itEvj4+zC58nKQvQVnEaeVadmAHMkEX7ehS/mcZbo31S/1P4tFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098811; c=relaxed/simple;
	bh=pP8qSG+oupMtkwIy7hIPfIrFfr0X4ixyagHCt04slCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sk5zEjHWHZF3Z3Ac+qH2qpOjvY5bNl1daMZRUp9TX/9xJBFbhvhIX75F/wwQ6+BvvN8NfmZowYWErz1iPtUNgDgDhlSlavdghI/A/CQxDfFPNK/CrCr2hHIKli4Rqp5n8699KghPgmwlnZJk5BkppRSnx80OQz76ujBTRFqYXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Azh29eYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCDBC4CECD;
	Wed, 20 Nov 2024 10:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732098810;
	bh=pP8qSG+oupMtkwIy7hIPfIrFfr0X4ixyagHCt04slCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Azh29eYhGMZUKKlu8Y18syyzvqyK9GloDzu+mMA+FEGu6cQXmGo7JmQuezhyiK6kq
	 SODz0W+jLlFcuZxhHFP6b/3sj5lEfKVEqj5h2D/0LZ+zsm87Y0/nwMuPcdATBd+Tv1
	 cdhYhwhXq37kz1+bHgSAwWoCvOw5Cx2RoUO1aB1qTTiTPYQHiTgBUK80dOmmdDrvtC
	 zG29/7zQeyJfuf6l7Czi54YykUmAgVp+2fUdPmpRyLjiDbwijB68qbL/+PrwDzSdT4
	 9R+fPNbhHLS2biwsON5rVXjoZnwm6wR9OyPnAa28QuSz3RyMaFKe2XCF9UspI+Zj8t
	 YMKoVnsQ6gRVA==
Date: Wed, 20 Nov 2024 11:33:25 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, hughd@google.com, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/3] symlink length caching
Message-ID: <20241120-werden-reptil-85a16457b708@brauner>
References: <20241119094555.660666-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119094555.660666-1-mjguzik@gmail.com>

On Tue, Nov 19, 2024 at 10:45:52AM +0100, Mateusz Guzik wrote:
> quote:
>     When utilized it dodges strlen() in vfs_readlink(), giving about 1.5%
>     speed up when issuing readlink on /initrd.img on ext4.
> 
> Benchmark code at the bottom.
> 
> ext4 and tmpfs are patched, other filesystems can also get there with
> some more work.
> 
> Arguably the current get_link API should be patched to let the fs return
> the size, but that's not a churn I'm interested into diving in.
> 
> On my v1 Jan remarked 1.5% is not a particularly high win questioning
> whether doing this makes sense. I noted the value is only this small
> because of other slowdowns.

The thing is that you're stealing one of the holes I just put into struct
inode a cycle ago or so. The general idea has been to shrink struct
inode if we can and I'm not sure that caching the link length is
actually worth losing that hole. Otherwise I wouldn't object.

> All that aside there is also quite a bit of branching and func calling
> which does not need to be there (example: make vfsuid/vfsgid, could be
> combined into one routine etc.).

They should probably also be made inline functions and likely/unlikely
sprinkled in there.

