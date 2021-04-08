Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5482357986
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 03:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDHBUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 21:20:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhDHBUG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:20:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D16D60FDA;
        Thu,  8 Apr 2021 01:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617844796;
        bh=NMLFTBcNvVJDkTcx9oLGjPRmtBoThl8bXOibeYic2F8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkghelidwR6S6LVyReHiIdcYXCVsLBGXl/HiTXXOeKUVaKCtsIolh7d/eszttB/IR
         1wLF2ioNdu+YZzjbrpggFbbLrq2z+WM+ZXOrt9OJI1Qfk2EXS8ijKHZvhjcUJQyEYs
         HGbuvVz7WqM/rZ0txKkbOl2wmkS1grm8UmX/Hu2j6G0+hHaS7ujH2D5zpPKo9cLA5l
         ReUitlPcXRQ8eYTZ6Ot7F+rmN1qzvU0ekNRilHQ+BEcY+8x2VonVaVuZApsWL+syq6
         ab7MMGMfzhY0wv+2DQtINrWIcPspx0RgKAAEEbUxEW8LwPnfZ6t6pljYv0s9+lmSRO
         MiMkQHOCWqR7g==
Date:   Wed, 7 Apr 2021 18:19:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v5 03/19] fscrypt: export fscrypt_fname_encrypt and
 fscrypt_fname_encrypted_size
Message-ID: <YG5aOn/GEAIUfIll@gmail.com>
References: <20210326173227.96363-1-jlayton@kernel.org>
 <20210326173227.96363-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326173227.96363-4-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 01:32:11PM -0400, Jeff Layton wrote:
> For ceph, we want to use our own scheme for handling filenames that are
> are longer than NAME_MAX after encryption and base64 encoding. This
> allows us to have a consistent view of the encrypted filenames for
> clients that don't support fscrypt and clients that do but that don't
> have the key.
> 
> Export fscrypt_fname_encrypt. Rename fscrypt_fname_encrypted_size to
> __fscrypt_fname_encrypted_size and add a new wrapper called
> fscrypt_fname_encrypted_size that takes an inode argument rahter than
> a pointer to a fscrypt_policy union.

This explanation seems to be missing a logical connection between the first and
second paragraphs.  I think it's missing something along the lines of:
"Currently, fs/crypto/ only supports filenames encryption using
fscrypt_setup_filename(), which also handles decoding no-key names.  Ceph can't
use that because it needs to handle no-key names in a different way.  So, we
need to export the functions needed to encrypt filenames separately."

(I might have gotten the explanation a bit wrong... Point is, it's the type of
thing that seems to be missing here.)

- Eric
