Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30949D7A8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 02:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbiA0B6D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 20:58:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:32886 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiA0B6D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:58:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4AB761C2A;
        Thu, 27 Jan 2022 01:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3D1C340E7;
        Thu, 27 Jan 2022 01:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643248682;
        bh=eCvemmKn1glANDLwNe15EfZc8W8g0wsGFmOFB9BvvC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjlkKC4WeI35e6cztiGpo6Nl2E4EbMcy52YSs/MUwxSxXG6uTgStbm3sn0lUIxNaI
         1c8Q297Brzzd8N3N902RmMVG1nW40YsvofDWZfEzX6c+ML5oqA5JDo1MswW0TSFOlv
         Vl8NcqG80ikE75oWQX2GVWwQpXxOmlI8nZ+a0gVz3w5kNwzz0ioXANm6XMZ/8sW1Tk
         Jog7/OOL8VPiEX5utEy/4ELQcA98/N0DeFU8wzUZk/5k409V+AHB1DGCkX464jDkjY
         18rE2j6no0CQTf54xPsUvmlol9g42S/4HmQzWzWvd06HBxW2vOvKlbDF6zZMDjZyyU
         I6ChYXWS8FShQ==
Date:   Wed, 26 Jan 2022 17:58:00 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: Re: [RFC PATCH v10 03/48] fscrypt: export fscrypt_fname_encrypt and
 fscrypt_fname_encrypted_size
Message-ID: <YfH8KBOLGA+zPInc@sol.localdomain>
References: <20220111191608.88762-1-jlayton@kernel.org>
 <20220111191608.88762-4-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111191608.88762-4-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 11, 2022 at 02:15:23PM -0500, Jeff Layton wrote:
> For ceph, we want to use our own scheme for handling filenames that are
> are longer than NAME_MAX after encryption and Base64 encoding. This
> allows us to have a consistent view of the encrypted filenames for
> clients that don't support fscrypt and clients that do but that don't
> have the key.
> 
> Currently, fs/crypto only supports encrypting filenames using
> fscrypt_setup_filename, but that also handles encoding nokey names. Ceph
> can't use that because it handles nokey names in a different way.
> 
> Export fscrypt_fname_encrypt. Rename fscrypt_fname_encrypted_size to
> __fscrypt_fname_encrypted_size and add a new wrapper called
> fscrypt_fname_encrypted_size that takes an inode argument rather than a
> pointer to a fscrypt_policy union.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Eric Biggers <ebiggers@google.com>

Please make sure to run checkpatch.pl, though.  There is still some weird
indentation in this patch.

- Eric
