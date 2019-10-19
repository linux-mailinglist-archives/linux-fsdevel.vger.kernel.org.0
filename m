Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9E54DD647
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2019 05:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfJSDQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Oct 2019 23:16:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJSDQg (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Oct 2019 23:16:36 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ADA9222C2;
        Sat, 19 Oct 2019 03:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571454995;
        bh=zYnXUkPGRdV0F5xVTBfK5dqMZk6w0uvJov5eBWJea+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1cAwSSENm0BzvrTIy9555f/1ct1aBbCWZsgM6p1t+dnyArgrvs6BFKu5ULbjXhq9
         lNUK6AaG3nkwdtuFcuKcbdfhfJxFKC6izOFtfspFbJEgSc4MG3URmtzWcc3ZN0sgN+
         2lPPk34ZzBmtCZuAxziKRNIWt2VRFI3TZHIShEL8=
Date:   Fri, 18 Oct 2019 20:16:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
Subject: Re: [PATCH 1/2] fs/buffer.c: support fscrypt in
 block_read_full_page()
Message-ID: <20191019031634.GA76786@sol.localdomain>
Mail-Followup-To: linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Chandan Rajendra <chandan@linux.ibm.com>
References: <20191016221142.298754-1-ebiggers@kernel.org>
 <20191016221142.298754-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016221142.298754-2-ebiggers@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:11:41PM -0700, Eric Biggers wrote:
> +static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
> +{
> +	/* Decrypt if needed */
> +	if (uptodate && IS_ENABLED(CONFIG_FS_ENCRYPTION) &&
> +	    IS_ENCRYPTED(bh->b_page->mapping->host)) {
> +		struct decrypt_bh_ctx *ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);

Technically this should check S_ISREG() too (though it happens not to make a
difference currently).   I'll fix it in the next version of this patchset.

We probably should add a helper function fscrypt_needs_contents_encryption()
that returns IS_ENABLED(CONFIG_FS_ENCRYPTION) && IS_ENCRYPTED() && S_ISREG().

- Eric
