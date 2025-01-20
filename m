Return-Path: <linux-fsdevel+bounces-39713-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD625A1726C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 18:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE67165046
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FE81EE02F;
	Mon, 20 Jan 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfVydj9P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546DDC2FB;
	Mon, 20 Jan 2025 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395625; cv=none; b=bty+XKUVBX/9oSZG7diBG8epuqgFHitI7NzwapbDBX8jJaE2ocp7UIJspAC17L6NNtYPmzVtQTwgaqrUiCjfCrcWhh2aoPNfmVQX3+Fq4Un/PcB9n66b/WVDa6SlB2zB3i+pWKRsNqpf4Nz+ypdobAKh4ouJBcj2NAgm6yqUfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395625; c=relaxed/simple;
	bh=M9hVVTw+W9gkBVfhsdVP2N8HEG6k5h7e7LKj/8vkT2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrGgasDYr9LGWOj6OuBaAoTPfEF05gL4IYwrtVu8QC2Ua4xxXe0p+eyceAi+xRfJ5Hbz743iLM5S7Zk1cSx5rAeW/ly1ddl5cC7fM6RqW/sshMA5TbJuHJ7dz+GcOBrm5nyZAapxIig6oHM7YK1dLTN6u6D/pCTxQ9vG6Rw3KBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfVydj9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC43FC4CEDD;
	Mon, 20 Jan 2025 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737395625;
	bh=M9hVVTw+W9gkBVfhsdVP2N8HEG6k5h7e7LKj/8vkT2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZfVydj9PUliRJoLOYAgHaJfObzf2seitXdJB3M6SSkhQP93FtlvExQisZCD1z2bct
	 yS8bMSfVRPc9GRAqf9ZAipaR6ALFr0r6nL3zp7svuu0wkL2RWwyD3JVF5dT+vVy5C+
	 orKSZ2MbAN0UlIZURsgf81Sx28esjMuYfr0/JaFgOTjGapUCY/KdlpeRgWI12V73Wi
	 VC/9/2UD2XQHEhYK4Eb3TDzTifBjpd4J83n4G/VSKwd/5lGfTsgV7CXFX8svj44MTz
	 8cseLI2wRlolpxmv/jeA6E/PerxeiqUaEf8UYo14AE/+/Vg5yUDb6Tpeb/OCdOSeSZ
	 gLhG7VKNNsglg==
Date: Mon, 20 Jan 2025 09:53:43 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Alex Markuze <amarkuze@redhat.com>, fstests@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Error in generic/397 test script?
Message-ID: <20250120175343.GC2268@sol.localdomain>
References: <20250120172542.GC1159@sol.localdomain>
 <1201003.1737382806@warthog.procyon.org.uk>
 <1113699.1737376348@warthog.procyon.org.uk>
 <1207325.1737387826@warthog.procyon.org.uk>
 <1211247.1737394900@warthog.procyon.org.uk>
 <20250120174627.GB2268@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120174627.GB2268@sol.localdomain>

On Mon, Jan 20, 2025 at 09:46:29AM -0800, Eric Biggers wrote:
> On Mon, Jan 20, 2025 at 05:41:40PM +0000, David Howells wrote:
> > Eric Biggers <ebiggers@kernel.org> wrote:
> > 
> > > It would be enlightening to understand what the issue was here.  Did you
> > > explicitly disable these options, overriding the imply, without providing a
> > > replacement?  Or was this another issue specific to unmerged kernel patches?
> > 
> > I enabled CONFIG_FS_ENCRYPTION in addition to the options I normally use, but
> > didn't realise I needed to enable CONFIG_CRYPTO_XTS as well.
> > 
> > David
> > 
> 
> So you had an explicit '# CONFIG_CRYPTO_XTS is not set' somewhere in your
> kconfig that overrode the imply, right?
> 
> Wondering if the following commit should maybe be reconsidered:
> 
>     commit a0fc20333ee4bac1147c4cf75dea098c26671a2f
>     Author: Ard Biesheuvel <ardb@kernel.org>
>     Date:   Wed Apr 21 09:55:10 2021 +0200
> 
>         fscrypt: relax Kconfig dependencies for crypto API algorithms
>         
>         Even if FS encryption has strict functional dependencies on various
>         crypto algorithms and chaining modes. those dependencies could potentially
>         be satisified by other implementations than the generic ones, and no link
>         time dependency exists on the 'depends on' claused defined by
>         CONFIG_FS_ENCRYPTION_ALGS.
>         
>         So let's relax these clauses to 'imply', so that the default behavior
>         is still to pull in those generic algorithms, but in a way that permits
>         them to be disabled again in Kconfig.
>         
>         Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>         Acked-by: Eric Biggers <ebiggers@google.com>
>         Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

By the way, CRYPTO_XTS is basically useless.  E.g. on x86_64 you really want
CRYPTO_AES_NI_INTEL.  I should probably throw in a selection of that (similar to
what CONFIG_WIREGUARD does where it selects optimized code for each arch),
though I've been hoping for this to be properly solved at the crypto API level.

- Eric

