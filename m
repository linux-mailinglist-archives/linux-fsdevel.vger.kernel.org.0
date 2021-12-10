Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17624709EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Dec 2021 20:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbhLJTOR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Dec 2021 14:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhLJTOR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:14:17 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C78C061746;
        Fri, 10 Dec 2021 11:10:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30AF3CE2C98;
        Fri, 10 Dec 2021 19:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4220FC00446;
        Fri, 10 Dec 2021 19:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639163438;
        bh=OhIkFbAwzWDv1Ibq3gz7iFMC1eiGcGS2sokbJtNM8nc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnv9Yqcjfa26kentu4/i4ThUyAz4f4N6lK6aTq3smNxz585ZuwVp62rru8mPw+zSc
         NTGHorx3yc9F3qWQlx7GhytzvSBLGy3kfwob41bIk5rzEV51krATAOKy+bsSk0NxSN
         vNAdO4msobSZkFRVwbdJLejyjQBMKpJWxcwuWuBMVxgWrRY5VLrJca2oPKAPrqKm4x
         6ffsXJ63YQAGWuNCI3m78HUxIZ/P5kzbpICyEV+F+QzKqrzQaTujLtR9+apsgRnm7l
         aQ316BKyN9AmbviWfNACu39DnSi36KsF2V4DUvEGNUEo11jCZ8YYtIkglnAkhsHJEC
         NK6jhCOczeeFQ==
Date:   Fri, 10 Dec 2021 11:10:36 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/36] fscrypt: export fscrypt_base64url_encode and
 fscrypt_base64url_decode
Message-ID: <YbOmLPKc03l3Md7q@sol.localdomain>
References: <20211209153647.58953-1-jlayton@kernel.org>
 <20211209153647.58953-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209153647.58953-3-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 09, 2021 at 10:36:13AM -0500, Jeff Layton wrote:
> Ceph is going to add fscrypt support, but we still want encrypted
> filenames to be composed of printable characters, so we can maintain
> compatibility with clients that don't support fscrypt.
> 
> We could just adopt fscrypt's current nokey name format, but that is
> subject to change in the future, and it also contains dirhash fields
> that we don't need for cephfs. Because of this, we're going to concoct
> our own scheme for encoding encrypted filenames. It's very similar to
> fscrypt's current scheme, but doesn't bother with the dirhash fields.
> 
> The ceph encoding scheme will use base64 encoding as well, and we also
> want it to avoid characters that are illegal in filenames. Export the
> fscrypt base64 encoding/decoding routines so we can use them in ceph's
> fscrypt implementation.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/fname.c       | 8 ++++----
>  include/linux/fscrypt.h | 5 +++++
>  2 files changed, 9 insertions(+), 4 deletions(-)

Acked-by: Eric Biggers <ebiggers@google.com>

- Eric
