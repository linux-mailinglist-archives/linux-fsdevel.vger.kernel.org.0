Return-Path: <linux-fsdevel+bounces-25912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E3951B05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 14:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01F8BB230AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 12:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817451B0124;
	Wed, 14 Aug 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6vRqSf4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD419FA86;
	Wed, 14 Aug 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639228; cv=none; b=fsrWFBgxnsXWegZX4aIzaA3L4Nt558NpbaEpgc+SZCkc1yFYjbve/Nx77L/TO/+zSy63dEGR6HEqw5CgqEWLhxkW6ybF7EFnf9HtDY362PKK0KzitwywPPgTTI9BY6joyhHVWEl6gop+mpr2XyTzoXjp3Pr07bAcWJwn+4eOkmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639228; c=relaxed/simple;
	bh=MBPKv25gr6r46N/Y2VXTELWl42bD/ORmzDSUIttwH10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvtgi2Zx/IyKJsqzNWtFy6r9EIib7NpKUDtv9h+rp19o8kKPVwrlt4497EnzWv03+uxfBI9unU0C7JUiBN1yRAjsJcTC4V5buiO2j5Bk/CLopIjd2HUlb3ltgqxh0lyTfibWN9t49/kQFN5V2sDmXMrbGlmsYypool0PQJljuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6vRqSf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C523C32786;
	Wed, 14 Aug 2024 12:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723639228;
	bh=MBPKv25gr6r46N/Y2VXTELWl42bD/ORmzDSUIttwH10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6vRqSf4SwlwL+kaAh6ZBpoz9udu5Tk7ZYTJLabXyLwQQnQbAtKVNkQK6/H7kvhYg
	 CRVKWlsEXLyGSUhaNHtiLfWXfuryxky8vs+orOR0VAjxKgf9E4ss3RZ/TykeDKVDHt
	 2b0wDgdxoIzd/Bpcjggofv/4/wz3x3XNPAR8ZANH6QNCYs0rs1Wt1wDShTEyFn1pvf
	 cZ+dT/b7laTBIOo4bgmAGCyGMSOF8KWlflfNtB2ell/e7+sMeX0iw/3WAtz7irK1di
	 Xr4k+mbAJqCX2tsM1/6DCaVRc1u/lYQzAVmL+HuoaOfYtJH3Hwl0Y6q9j2bxVeOK+W
	 zP0fh1VLpqN9A==
Date: Wed, 14 Aug 2024 14:40:23 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240814-visier-alpinsport-027f787afa2c@brauner>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <6e5bfb627a91f308a8c10a343fe918d511a2a1c1.camel@kernel.org>
 <20240814021817.GO13701@ZenIV>
 <20240814024057.GP13701@ZenIV>
 <df9ee1d9d34b07b9d72a3d8ee8d11c40cf07d193.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df9ee1d9d34b07b9d72a3d8ee8d11c40cf07d193.camel@kernel.org>

> Christian took in my v3 patch which is a bit different from this one.
> It seems to be doing fine in testing with NFS and otherwise.

Every branch gets tested with nfs fstests (in addition to the usual
suspects):

Failures: generic/732
Failed 1 of 600 tests

And that just fails because it's missing your 4fd042e0465c
("generic/732: don't run it on NFS")

