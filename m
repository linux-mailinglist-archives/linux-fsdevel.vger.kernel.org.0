Return-Path: <linux-fsdevel+bounces-39712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1BEA17261
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948B616B22D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B232D1EEA46;
	Mon, 20 Jan 2025 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZUYbIJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7791EE7C0;
	Mon, 20 Jan 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395190; cv=none; b=BLbsyWRkRbgmys/7KKidEZwRmh/czGXcN7wXQGWqaQPvH23AzwJ+M+XV/UoR/NLKL6tYQW7VWe6vPT8lOWoXpVrbkZac30fAcDzelwUMseCh/svhBtq9stkZtf2HRHG5q+AyyYSNy3i11uZACFlGDF/Bz0rMwj57jiZ2lJc6jkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395190; c=relaxed/simple;
	bh=oDwoLUxTBAZCGcLc4HCgDK8vQ0LLZP86wNXamvbjVXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThQW8dU7uJtsaPWbI8m4bFcohl1m1oG2PSA6Phgie7/XA77w8ZU44cIdew8Top26QNHNIIOtSrWLwgU0Qaw3qxHuy6cBvgWVn0jZyeph7tK5Eqhi/AXWm6FNEUSFCr+VXrMCvAaUDgYti2yfBDpcqgRbreRPa+wdocnKXDlqdtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZUYbIJO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E53C4CEDD;
	Mon, 20 Jan 2025 17:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737395189;
	bh=oDwoLUxTBAZCGcLc4HCgDK8vQ0LLZP86wNXamvbjVXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZUYbIJODYGR/tSZJxTmPkHml7FsA5FwS8p+wofLYAugpyWp4wqWYrfSm4HmZr0R8
	 rnmEp4SqUZ3Gvpf3LgTOzNJuW5tacQ4JARMC/7mEK4NUysh4llJaDftMR3Ps+6CDAZ
	 ELFF9LJ/LvuYM/zBWSRCyNddhYkAgkmPUlOLrc67O1+SPdLKd6T8Ff2dpOU0AjZaFH
	 m5n4MeQVYi0gX/ffs3kZ0Xth1DuFDC1t84mOfRwvhyA9Ke1ZAF4sCGuuKJNagbjdRM
	 Zd2EIGwlk6Xr54JVpqcwjLiaoEWYUtFjqPfXjAqvJTlxk67Ulqch37uRPB8onMHCi+
	 swypEp9PqzS/w==
Date: Mon, 20 Jan 2025 09:46:27 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, fstests@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Error in generic/397 test script?
Message-ID: <20250120174627.GB2268@sol.localdomain>
References: <20250120172542.GC1159@sol.localdomain>
 <1201003.1737382806@warthog.procyon.org.uk>
 <1113699.1737376348@warthog.procyon.org.uk>
 <1207325.1737387826@warthog.procyon.org.uk>
 <1211247.1737394900@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1211247.1737394900@warthog.procyon.org.uk>

On Mon, Jan 20, 2025 at 05:41:40PM +0000, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > It would be enlightening to understand what the issue was here.  Did you
> > explicitly disable these options, overriding the imply, without providing a
> > replacement?  Or was this another issue specific to unmerged kernel patches?
> 
> I enabled CONFIG_FS_ENCRYPTION in addition to the options I normally use, but
> didn't realise I needed to enable CONFIG_CRYPTO_XTS as well.
> 
> David
> 

So you had an explicit '# CONFIG_CRYPTO_XTS is not set' somewhere in your
kconfig that overrode the imply, right?

Wondering if the following commit should maybe be reconsidered:

    commit a0fc20333ee4bac1147c4cf75dea098c26671a2f
    Author: Ard Biesheuvel <ardb@kernel.org>
    Date:   Wed Apr 21 09:55:10 2021 +0200

        fscrypt: relax Kconfig dependencies for crypto API algorithms
        
        Even if FS encryption has strict functional dependencies on various
        crypto algorithms and chaining modes. those dependencies could potentially
        be satisified by other implementations than the generic ones, and no link
        time dependency exists on the 'depends on' claused defined by
        CONFIG_FS_ENCRYPTION_ALGS.
        
        So let's relax these clauses to 'imply', so that the default behavior
        is still to pull in those generic algorithms, but in a way that permits
        them to be disabled again in Kconfig.
        
        Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
        Acked-by: Eric Biggers <ebiggers@google.com>
        Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

