Return-Path: <linux-fsdevel+bounces-4947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B57A78069C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 09:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51215B207CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B71A704
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJQrbUJ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDC10A37;
	Wed,  6 Dec 2023 06:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8508EC433C7;
	Wed,  6 Dec 2023 06:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701845072;
	bh=clSKz/jK1stOdFKIDru6SJ+yJtrLdEpewW4sorh372I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nJQrbUJ25c99pZOtc+L0rYqfvp9TySSKo/mCyWaJ6Cdn8B1j0l2kVWUchjX/xcGK2
	 KRdZ0SwhQlregqgpkD6oB6GM9jJBsuwn7OgGccdEJvFYxMdPYKQsMXhpdr0ISmDD2v
	 2owdMTgr/5xiIz8IGETqvor4PuEmHs6KWFSh5jcA4UlSpp3HmNhsss5cvXdC5pfAUr
	 ofIPj54Y5STUtHCzramLrhhetTM8tF5qhhL5XIorkkNm7nsIyIwlduMOkhFxYx+cWh
	 BjNpz9a4dnV2wvBWUnDEoBuymQ65gI14h953htGRbk2CE8U714LumP7+QTA3dwpR+n
	 I0moIFj619nmA==
Date: Tue, 5 Dec 2023 22:44:30 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] fscrypt: move the call to fscrypt_destroy_keyring() into
 ->put_super()
Message-ID: <20231206064430.GA41771@sol.localdomain>
References: <20231206001325.13676-1-ebiggers@kernel.org>
 <ZXAW1BREPtCSUz4W@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXAW1BREPtCSUz4W@infradead.org>

On Tue, Dec 05, 2023 at 10:38:12PM -0800, Christoph Hellwig wrote:
> On Tue, Dec 05, 2023 at 04:13:24PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > btrfs, which is planning to add support for fscrypt, has a variety of
> > asynchronous things it does with inodes that can potentially last until
> > ->put_super, when it shuts everything down and cleans up all async work.
> > Consequently, btrfs needs the call to fscrypt_destroy_keyring() to
> > happen either after or within ->put_super.
> > 
> > Meanwhile, f2fs needs the call to fscrypt_destroy_keyring() to happen
> > either *before* or within ->put_super, due to the dependency of
> > f2fs_get_devices() on ->s_fs_info still existing.
> 
> And that means f2fs should free ->s_fs_info in ->kill_sb after
> the call to shutdown_generic_super.
> 
> So the right thing here is:
> 
>  - change f2fs to free ->s_fs_info later
>  - move down fscrypt_destroy_keyring in the keneric code to happen
>    after ->put_super
> 

There are lots of filesystems that free their ->s_fs_info in ->put_super().  Are
they all wrong?

- Eric

