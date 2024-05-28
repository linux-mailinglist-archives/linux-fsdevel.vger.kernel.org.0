Return-Path: <linux-fsdevel+bounces-20322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD868D1719
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F341C22ED5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67C13E898;
	Tue, 28 May 2024 09:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SeoMYBfz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EBB13E3E4;
	Tue, 28 May 2024 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716887885; cv=none; b=g8k10XE+PHoK5JDOsZiz6aRsea/gaznk7jbOvUB/XP2rwETjdPbRSY13om23lscxD72cjZM+ApxV/uDoRh2+lQYTC2mfTtHAKYVcV9nIGQc5Dhnbv6RnbkTLqSfJFMSpIkNoQCzVe5KlxkBcvtVhNLN3mpB+54tK6UYfPdSCeWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716887885; c=relaxed/simple;
	bh=sHDgCQroYrNtRfGIVFtzULC0y1sPXOLnGzZzrn+ZRQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEiCp/4RzAQld/LV6dBn1pAOg/RvUvsWEF1tBjBAvJ+5DiccABpEEfWo2ESB4WFGzKZKtcfV7UESkdSz0kQEMcfa+pNXs+zwjmaDHsVgaMmqi1RRneC9R/pq/yPI8C/Y0RELovoyfPHyDpiktuVY+g14MW/WoMqiXW34b3MV7+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SeoMYBfz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C188C4AF08;
	Tue, 28 May 2024 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716887884;
	bh=sHDgCQroYrNtRfGIVFtzULC0y1sPXOLnGzZzrn+ZRQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SeoMYBfz+kd2DFmF2s6i6cDdVAc1SIqumXsbNcwxNaVG9Iz6Tn4mTXo9w/9nztWDm
	 o1wKhbLzY7Rv0Dta0Rtlq7G1HjyqJv7kbB1R/39bXLne+kd6MpySpQwoDDgxC80Gcr
	 mwVV/fe/G8paLDBn9vjyei6j9CSOPiVYl3O+7s26Ha2g6cq42W50N/SBfsP1oONQ9O
	 5dEQ/YgzIVMX4Y1+RPeBbhqBzZd3NZrJoQbC40qtkIZf0/30Q1QLcXP9TReS8OA63Z
	 q7dEDukMfbD/UMD8lx+agQZJNlnvbFo0EZWvc2G76BJXBU3J87fX750C9iejdqRpky
	 nKK8uRO7orjHg==
Date: Tue, 28 May 2024 11:17:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240528-gesell-evakuieren-899c08cbfa06@brauner>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlWVkJwwJ0-B-Zyl@infradead.org>

> > Hell, if you twist my arm I'll even write the patches for this.
> 
> I'm also happy to help with that despite very limited time, but I'd
> rather avoid doing the misguided mount ID thing.

As I've said earlier, independent of the new handle type returning the
new mount id is useful and needed because it allows the caller to
reliably generate a mount fd for use with open_by_handle_at() via
statmount(). That won't be solved by a new handle type and is racy with
the old mount id. So I intend to accept a version of this patch.

