Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E711470A91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 20:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbhLJTnp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 14:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbhLJTnp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:43:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA63C061746;
        Fri, 10 Dec 2021 11:40:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3481CCE2D07;
        Fri, 10 Dec 2021 19:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460F2C00446;
        Fri, 10 Dec 2021 19:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639165206;
        bh=GpeAELxeuYElSUePPOzI2ZryBz/fDeGFHld2SnLgdEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzojmhX9oxvP7TbeHVJQWhDmAJvmZLOLJOIPwVfjyxEDNTcYZbx6rU3Mz74yjOB9z
         cbxL/Zns+AezVtJMmGCb9XKZCX11Vy9hkOwpln6d26IeLAg6q8cvYY/A+PrUUJ2L28
         6P+ieFrtsxwVNqnmBR1C6D+agETdrZHPZ59aN6FVDSZyzSfNWxrafJ741hwCgVW52A
         F6jGiTgAgkOWOSMhjal7TvAd92ZKhdE1VVJYPzMdt3BdMcel2edfiCnqz1RDtsIdij
         OwI8huSCvRZTq2zfBK+k61p4xt2KQlPC4g9J4+Zkj3A3jNA1abj0TqeJNYHFQyKEQw
         JXf+HNT8FIXuA==
Date:   Fri, 10 Dec 2021 11:40:04 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/36] fscrypt: add fscrypt_context_for_new_inode
Message-ID: <YbOtFAg76ULzcJSq@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
 <20211209153647.58953-5-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209153647.58953-5-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:36:15AM -0500, Jeff Layton wrote:
> Most filesystems just call fscrypt_set_context on new inodes, which
> usually causes a setxattr. That's a bit late for ceph, which can send
> along a full set of attributes with the create request.
> 
> Doing so allows it to avoid race windows that where the new inode could
> be seen by other clients without the crypto context attached. It also
> avoids the separate round trip to the server.
> 
> Refactor the fscrypt code a bit to allow us to create a new crypto
> context, attach it to the inode, and write it to the buffer, but without
> calling set_context on it. ceph can later use this to marshal the
> context into the attributes we send along with the create request.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/policy.c      | 34 ++++++++++++++++++++++++++++------
>  include/linux/fscrypt.h |  1 +
>  2 files changed, 29 insertions(+), 6 deletions(-)

Acked-by: Eric Biggers <ebiggers@google.com>

> +	BUILD_BUG_ON(sizeof(union fscrypt_context) != FSCRYPT_SET_CONTEXT_MAX_SIZE);

Please line wrap at 80 characters when possible.

- Eric
