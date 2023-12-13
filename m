Return-Path: <linux-fsdevel+bounces-5806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341C2810903
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 05:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3FA21F21330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4FDC15D;
	Wed, 13 Dec 2023 04:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESGwNjjd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73944C126;
	Wed, 13 Dec 2023 04:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D837CC433C7;
	Wed, 13 Dec 2023 04:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702440965;
	bh=Sm2xni/yO4uLZhO8Ls0pGmkunre/vAumqSeRpbDvwNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESGwNjjdHPmsyFo5sUB3uBkLlQ9Dn0izlXHp83PXgMISQMa461F4F3L+ATwIENvC5
	 OxP6xFneMI34UG5ChOwtjF1bfjO/zWPvVvCp2VP/Wqdu27HMkyoacGWL4pnnJFTgVA
	 ohF3nfslLWF0H1Him3wIaw+RbYhEsSVNp3xh/Kl/VCloIvYsZNmaLCahOOQ6nP6WdL
	 Oyj/CsnzC62hFpuYLr8/zWMZnhUhCWvwSxHgEiSpR8TS9JLC0lyJ3E1RjoGO6EotWw
	 H2uepXIU8iv42OVQQULIc1RBi159tnbOVbA8lv/nYmGFZco8wv85+YYQQQkTkA3feG
	 8BFTrqZABj4jw==
Date: Tue, 12 Dec 2023 20:16:03 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 02/46] fscrypt: add per-extent encryption support
Message-ID: <20231213041603.GA1127@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <5e91532d4f6ddb10af8aac7f306186d6f1b9e917.1701468306.git.josef@toxicpanda.com>
 <20231205035820.GE1168@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205035820.GE1168@sol.localdomain>

On Mon, Dec 04, 2023 at 07:58:20PM -0800, Eric Biggers wrote:
> > @@ -53,6 +55,28 @@ struct fscrypt_context_v2 {
> >  	u8 nonce[FSCRYPT_FILE_NONCE_SIZE];
> >  };
> 
> Hmm, I think we're going to want fscrypt_context => fscrypt_inode_context too...
> Also FSCRYPT_FILE_NONCE_SIZE => FSCRYPT_NONCE_SIZE.  I guess don't worry about
> it for now, though.

Actually for the nonce size, I'm now thinking you should add a new constant
named FSCRYPT_EXTENT_NONCE_SIZE.  It will have the same value as the file one,
but it's a logically separate thing.

- Eric

