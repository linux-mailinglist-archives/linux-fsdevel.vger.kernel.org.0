Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B004E470AAA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 20:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343696AbhLJTtx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 14:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242184AbhLJTtx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:49:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A56DC061746;
        Fri, 10 Dec 2021 11:46:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D042B829D0;
        Fri, 10 Dec 2021 19:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D09C00446;
        Fri, 10 Dec 2021 19:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639165575;
        bh=cDYjWY1uGnUkOZkhLCUj6WGhk9R6dCgn96kJhaGE/p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHWR+QP3Jzo+Aql8myu1yp7a7OJCDNHpvUSx2nWT0FDS1w5byjya1lOI1DGlNzsd5
         jAc9jndq+QqK/VHcAx2w10ZAg1Ls2lIuNp3F97RlW2Oe3CLgn9C+SJaeTZCMop8zMM
         1iFzKKt+/snRaC9SXzOyqrg9wr0NppIx+2kIyFZot+Il+wBrUDSwT9GWrQJE/Qwa8O
         kHrv2eNz68/oPPjocmGgYPBpoLr6fUDsflQvEwLK17ushWWAH1vDMmdK2IjwYiBK6f
         nLppxWasG0v6XNIUa5Om8sXI/P74IEXiuysiM9kTPK45S20NCY7BFxFTRSBK69aobh
         Qd2PZdDZ8IoiQ==
Date:   Fri, 10 Dec 2021 11:46:13 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/36] fscrypt: uninline and export fscrypt_require_key
Message-ID: <YbOuhUalMBuTGAGI@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
 <20211209153647.58953-6-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209153647.58953-6-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:36:16AM -0500, Jeff Layton wrote:
> ceph_atomic_open needs to be able to call this.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/fscrypt_private.h | 26 --------------------------
>  fs/crypto/keysetup.c        | 27 +++++++++++++++++++++++++++
>  include/linux/fscrypt.h     |  5 +++++
>  3 files changed, 32 insertions(+), 26 deletions(-)

What is the use case for this, more precisely?  I've been trying to keep
filesystems using helper functions like fscrypt_prepare_*() and
fscrypt_file_open() rather than setting up encryption keys directly, which is a
bit too low-level to be doing outside of fs/crypto/.

Perhaps fscrypt_file_open() is what you're looking for here?

- Eric
