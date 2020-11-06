Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1165F2A9B34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 18:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgKFRvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 12:51:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgKFRvB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:51:01 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8FD2151B;
        Fri,  6 Nov 2020 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604685061;
        bh=AoXlPZXpHyAt8nSZY7QrSbqoHAJncxCabKt0S2lrriE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMFdoB+qGBJDUSXBs3zEFsHYY4+pvgORPQDZbY6oVtzoO/QYTzJjqE9u2Sy4ve+58
         5J3MT3T8ac5TaiVKiqX4ZsW1kjIMkGzOrG+0R1OT1GvMraUsjEqiChTwvglKF7fpbh
         JmGwNhpqXmYDjT2XwIYcrio9l02m4Msm/KyP88BM=
Date:   Fri, 6 Nov 2020 09:50:59 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] fscrypt: remove reachable WARN in
 fscrypt_setup_iv_ino_lblk_32_key()
Message-ID: <20201106175059.GD845@sol.localdomain>
References: <20201031004556.87862-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031004556.87862-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 05:45:56PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> I_CREATING isn't actually set until the inode has been assigned an inode
> number and inserted into the inode hash table.  So the WARN_ON() in
> fscrypt_setup_iv_ino_lblk_32_key() is wrong, and it can trigger when
> creating an encrypted file on ext4.  Remove it.
> 
> This was sometimes causing xfstest generic/602 to fail on ext4.  I
> didn't notice it before because due to a separate oversight, new inodes
> that haven't been assigned an inode number yet don't necessarily have
> i_ino == 0 as I had thought, so by chance I never saw the test fail.
> 
> Fixes: a992b20cd4ee ("fscrypt: add fscrypt_prepare_new_inode() and fscrypt_set_context()")
> Reported-by: Theodore Y. Ts'o <tytso@mit.edu>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied to fscrypt.git#for-stable for 5.10.

- Eric
