Return-Path: <linux-fsdevel+bounces-11623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 247AB855808
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 01:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DA61C20F77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 00:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB6A145B17;
	Wed, 14 Feb 2024 23:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYwKIyLm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBC41420D3;
	Wed, 14 Feb 2024 23:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954862; cv=none; b=D6m4zAwL+XHnMVPIwNHiwF9iMx4TE441fJfd9AgiZ0xbCWecbsNXCpUPlpoXMRKf4X5KMGx1MVJ+1ZULuBIblFu+S8XnYzjpNkXRhByV9R3p8Hh/11bmR9F9gmLFBNx0yzxKODwUrp7WqWE+u6juoxpobEFP9H1V2KnhfijGpdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954862; c=relaxed/simple;
	bh=fD+Liot/QopPw+J8SWLX1NF1pMEzg08c+fYf47+/ctw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2aySUFQnij82EjqA5rBvkxLmiMcaxLzFFGv3yECPw3AjRES/ejmNz/8D2nkiiq1AH2ULLhdrUYd7VhFcWvJ1KUYFmAUMJuc25F4di3IjtGRB830nyeabWXAC+fl8LqKAXp/g1HhN0GNIL/RKIA5V9Skh06pUB7v5DDGzJzpYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYwKIyLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0201CC433C7;
	Wed, 14 Feb 2024 23:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707954861;
	bh=fD+Liot/QopPw+J8SWLX1NF1pMEzg08c+fYf47+/ctw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYwKIyLmjfx/iNGFuuukgKoIaDIGRgp05j11I/Y/OMzg4vfGzYpR+o2GtOJkJfa68
	 yjlhjS0ZShMfa/yFKM2ykpHGDOu8ZiZC/tFAa6AjWUgpNHst6aP0vzNjkBkcAWQP5P
	 kagaV6CWhSY2PV5obxunqx65x+BiXvkPALRSzTeq8Rgy6k8oA1I05cKsOX5jmWjqyS
	 v8GJDLB7cOBnfCFc8y3vN7So34rbiUVJEGaE4BWGyhyQn617fblfgTO2Y3wgfYjRc6
	 P8O/QIsLRDQCVgTs/cO3F5MPEdpvndCQ9xEnGQYBi7rUxV8W0u/y8/SJzNETQG3rdN
	 r/+MZuoVb8MgQ==
Date: Wed, 14 Feb 2024 15:54:19 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: viro@zeniv.linux.org.uk, jaegeuk@kernel.org, tytso@mit.edu,
	amir73il@gmail.com, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH v6 02/10] fscrypt: Factor out a helper to configure the
 lookup dentry
Message-ID: <20240214235419.GG1638@sol.localdomain>
References: <20240213021321.1804-1-krisman@suse.de>
 <20240213021321.1804-3-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213021321.1804-3-krisman@suse.de>

On Mon, Feb 12, 2024 at 09:13:13PM -0500, Gabriel Krisman Bertazi wrote:
> Both fscrypt_prepare_lookup_dentry_partial and
> fscrypt_prepare_lookup_dentry

Neither of these functions exist.

- Eric

