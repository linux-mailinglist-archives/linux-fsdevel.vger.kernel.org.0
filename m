Return-Path: <linux-fsdevel+bounces-4946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D688069BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 09:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8AF4281B13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DBC1A702
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kI3+x6cL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF14D45;
	Tue,  5 Dec 2023 22:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zj19OT35l/+mIcCqWZ6fohPK6X21wl0h9UR/4ViNXPw=; b=kI3+x6cLUXISOwH/TeGvVik8uG
	+oSqdDxiERGHH6utl9cAgn+FhHhNhiEcHq6y/SGR0zLq28YTNmmsJ7vWYj5jcM2209qwrHcIFQXCy
	xLcoDNze0+29iOjy03vDfxS4sJhuKncUZxcY/vwkyGT3iNATQxsujtlUf9+U1QE98M7RQw3pM81yZ
	pUP845HHr7dwcWchWCL90A4KAmjK0Mn/n1bv8Ca/dPD2vJz4g5QaO/OlIjtbZWlAXDzEzpnde9faX
	gxCQpHyKrBP+Bj3b0bHFvKf0IgMdgS6dTzlmwrL8Adtz/QWLB2fkQNRSOzKw4Uehgzd0KAMU7owgl
	PH9tJTGA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rAlXw-009DhU-2v;
	Wed, 06 Dec 2023 06:38:12 +0000
Date: Tue, 5 Dec 2023 22:38:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] fscrypt: move the call to fscrypt_destroy_keyring() into
 ->put_super()
Message-ID: <ZXAW1BREPtCSUz4W@infradead.org>
References: <20231206001325.13676-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206001325.13676-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 05, 2023 at 04:13:24PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> btrfs, which is planning to add support for fscrypt, has a variety of
> asynchronous things it does with inodes that can potentially last until
> ->put_super, when it shuts everything down and cleans up all async work.
> Consequently, btrfs needs the call to fscrypt_destroy_keyring() to
> happen either after or within ->put_super.
> 
> Meanwhile, f2fs needs the call to fscrypt_destroy_keyring() to happen
> either *before* or within ->put_super, due to the dependency of
> f2fs_get_devices() on ->s_fs_info still existing.

And that means f2fs should free ->s_fs_info in ->kill_sb after
the call to shutdown_generic_super.

So the right thing here is:

 - change f2fs to free ->s_fs_info later
 - move down fscrypt_destroy_keyring in the keneric code to happen
   after ->put_super


