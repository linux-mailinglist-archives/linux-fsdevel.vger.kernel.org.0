Return-Path: <linux-fsdevel+bounces-55747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A420FB0E4F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 22:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C710C3A2E82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 20:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0500228540F;
	Tue, 22 Jul 2025 20:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J07hDbA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2121F1302;
	Tue, 22 Jul 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753215934; cv=none; b=MwkIZfJAfV93CkfJSdJYqfi/CoZP2DHxaEq/uedkjqcdHlPmBEcO/SDMfcfVfSN/xDlEahEuUEikihnyjO/vtDkM7YtZER16jWBIbOtrijp+S/ltxU8Yu9FqoJIJLYEfDBk4skqUPB3OyHGdMMIZD0MQV+7znd/pb9sfJZ+v0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753215934; c=relaxed/simple;
	bh=TIf3NsdmEk/yrK4CMZgSPuLtTPbuV8WEvW9XXtuvd2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2ioNAlH8Gr0z8flAXqbKY4PqsfPo0izfN148xb2txUobqQhmQkKs664psi4NbzY0XWEgjtYiKobrdHGw3rErhKQAJHQi5+hmb6DWpOTZvDAnMGxLbnk1NWbC8atwX8fHrCzEghFBmBfIc36QtbbSMPRX/efIJEB1PPCn0fZeNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J07hDbA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A05C4CEEB;
	Tue, 22 Jul 2025 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753215934;
	bh=TIf3NsdmEk/yrK4CMZgSPuLtTPbuV8WEvW9XXtuvd2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J07hDbA0mJhMgihS7BNUeZANNqUufoft2y/uQjLxb5qWwYrp/W4K0Y4ZBkrmVT4Hl
	 yX3HrnPOKvVj0LXN/zIX1CJyQ1YDHegm5h+PL1tzYVofhD4VoY5+RRCsceiRnBOqtc
	 WG9xr6qJdXbaAuF6VJVJ79cZIPE44T6DKNBa7FE90fwj+remAhqADqJ0CPhfcCIxXJ
	 rPZFkkhTWOSafYOEnGHn/Awi22WPTvTSZCKFRfUGvkTc642+7yOoNXrQIH0DYrHXaZ
	 AoOLoKc2Cn3SVq2PpL11c0FEdObx4VhwW3T0N9LkXeMCmVbUSrN51i+CivgmcrqyXE
	 EcEIA8t/RiXLA==
Date: Tue, 22 Jul 2025 13:25:31 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	"Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH v3 09/13] fs/verity: use accessors
Message-ID: <20250722202531.GE111676@quark>
References: <20250722-work-inode-fscrypt-v3-0-bdc1033420a0@kernel.org>
 <20250722-work-inode-fscrypt-v3-9-bdc1033420a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722-work-inode-fscrypt-v3-9-bdc1033420a0@kernel.org>

On Tue, Jul 22, 2025 at 09:27:27PM +0200, Christian Brauner wrote:
>  static inline void fsverity_cleanup_inode(struct inode *inode)
>  {
> -	if (inode->i_verity_info)
> +	if (inode->i_verity_info || inode->i_sb->s_op->i_fsverity)
>  		__fsverity_cleanup_inode(inode);

Similarly to fscrypt_put_encryption_info(): I think this should look
like:

    if (IS_VERITY(inode))
            __fsverity_cleanup_inode(inode);

i_verity_info != NULL implies IS_VERITY(), so that would work and avoid
adding extra dereferences to non-verity files.

The converse isn't necessarily true, but that's okay as long as
__fsverity_cleanup_inode() handles i_verity_info == NULL.

- Eric

