Return-Path: <linux-fsdevel+bounces-17228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3888A934D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 08:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C2B28201E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 06:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB0D37719;
	Thu, 18 Apr 2024 06:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIFbs274"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F223D2D03B;
	Thu, 18 Apr 2024 06:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422565; cv=none; b=sGQa1+cwVRruMHxy2pJDFQeYKux2k5UKEsodJQhamiE+ZN3nu1Ks4KgPOfdqdGPRdtX/tWXJxqParhg3aNubm1IfLxiG8d7RCzs3fxL44W66ukmHch4QmpygdQ0PxyekxNNW9yy4aetXxlVQIKAVcncFqmqm6fYBuf2JeHEgxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422565; c=relaxed/simple;
	bh=MMUcfHaGa+xhMWh8LjjONaHLn3xh9RaU58sTpqt1ZVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGBM4y7VVSp5tXCW9LvqF+SMjAhQfpNzovXjC4irrEQgWgRhOV3YHPwXKlsosKfWM5jhm8mowEwVLgWQm/70wgwsWxzJP2wRAtanbclyACemvBGMrVbB1skh8ZmWxILi/LAIbB2YxrQUmljUfUMwK5Ho1yfd+ss67Q4tabsubKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIFbs274; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814E9C3277B;
	Thu, 18 Apr 2024 06:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713422564;
	bh=MMUcfHaGa+xhMWh8LjjONaHLn3xh9RaU58sTpqt1ZVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIFbs274RDLlipX0UH0jdK5RQ9Hd48Ca9Mr4t74jL9eG9vF2W/T4pwzH/9hewfUl8
	 HrGO9tLqEREKUrSwf4fmixfWAgQiZyfRQIjM31x8muYKeE1BX4qfQbmPmR8t/LM7wd
	 H4YV6UUdsxu6fQVUUWqfX/soeBB1wTIQ+CbqwMjyZ0j9nc1NpVh3TH5PoT8cytTG/C
	 B4iYUnuswDAe9ypE7GEON59G52DOgKT2mqMD0a61bpyT4UjBa0PyYnNUook4+DIOSY
	 5caP/STYskHk46G0irQ3jQ+TxOOlW7sfiw1hlj1yTvNx/OksNsQFfaMHWBxDAfH6VR
	 gEQ9GThO6Ff5Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rxLTq-000000000ZI-2Jir;
	Thu, 18 Apr 2024 08:42:46 +0200
Date: Thu, 18 Apr 2024 08:42:46 +0200
From: Johan Hovold <johan@kernel.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 00/11] Bugfix and refactoring
Message-ID: <ZiDA5uUq7a7tR78a@hovoldconsulting.com>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>

On Wed, Apr 17, 2024 at 04:03:46PM +0300, Konstantin Komarov wrote:
> This series contains various fixes and refactoring for ntfs3.
> Fixed problem with incorrect link counting for files with DOS names.
>
> Konstantin Komarov (11):
>    fs/ntfs3: Remove max link count info display during driver init
>    fs/ntfs3: Missed le32_to_cpu conversion
>    fs/ntfs3: Mark volume as dirty if xattr is broken
>    fs/ntfs3: Use variable length array instead of fixed size
>    fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow
>    fs/ntfs3: Redesign ntfs_create_inode to return error code instead of
>      inode
>    fs/ntfs3: Check 'folio' pointer for NULL
>    fs/ntfs3: Always make file nonresident if fallocate (xfstest 438)
>    fs/ntfs3: Optimize to store sorted attribute definition table
>    fs/ntfs3: Remove cached label from sbi
>    fs/ntfs3: Taking DOS names into account during link counting

All the patches in this series appear to be white space damaged and
cannot be applied.

Most of the patches are lacking proper commit messages, and the bug
fixes should be clearly marked as such with a Fixes tag and CC-stable
tag where appropriate.

Also don't mix fixes with cleanups and refactoring unless the former
really depends on the latter.

At least move the independent fixes to the front of the series.

Johan

