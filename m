Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4504F22A316
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 01:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733191AbgGVX01 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 19:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGVX01 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:26:27 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB54206E3;
        Wed, 22 Jul 2020 23:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595460386;
        bh=V9trLkUFJYAMyFKA/1meM08ujEXVHEc7LNqv69S5GpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1d1DqX/gictuOp3LaVtqdX9rXHFtYOgW0vHODNQAInHZ9LTw1DVDF6W/ElRvm03jp
         PRlIyPPMKp5xFPXvGrMUiRU+5p+CJgf/eRkjmre2XAM0349UwcdiNR4HcmaYSU7d3z
         mYi37IUaWUWxByy9kmqOyCDIyjpBrlQe09hnK0k0=
Date:   Wed, 22 Jul 2020 16:26:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200722232625.GB83434@sol.localdomain>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-4-satyat@google.com>
 <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722223404.GA76479@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 03:34:04PM -0700, Eric Biggers wrote:
> So, something like this:
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 44bad4bb8831..2816194db46c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3437,6 +3437,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
>  			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
>  
> +	/*
> +	 * When inline encryption is enabled, sometimes I/O to an encrypted file
> +	 * has to be broken up to guarantee DUN contiguity.  Handle this by
> +	 * limiting the length of the mapping returned.
> +	 */
> +	if (!(flags & IOMAP_REPORT))
> +		map.m_len = fscrypt_limit_io_blocks(inode, map.m_lblk,
> +						    map.m_len);
> +
>  	if (flags & IOMAP_WRITE)
>  		ret = ext4_iomap_alloc(inode, &map, flags);
>  	else
> 
> 
> That also avoids any confusion between pages and blocks, which is nice.

Correction: for fiemap, ext4 actually uses ext4_iomap_begin_report() instead of
ext4_iomap_begin().  So we don't need to check for !IOMAP_REPORT.

Also it could make sense to limit map.m_len after ext4_iomap_alloc() rather than
before, so that we don't limit the length of the extent that gets allocated but
rather just the length that gets returned to iomap.

- Eric
