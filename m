Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BEF1C1F91
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 23:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgEAV0x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 17:26:53 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:60731 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAV0w (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 17:26:52 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 969305ee;
        Fri, 1 May 2020 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=mail; bh=Rh6xj7VSHsXpYqNI0fr453COz6c=; b=Ri8cPWQ
        ym7a7UOrLp4K3siXQff8GIM8c3tKIaKedUvptR4G8MJgmC2eUkARTEZZy3BQ6HxA
        op9jAKubI0F0ZBjjEwZjZ2gQUwF6ogtaYslvw2glHNfVfbUFmxaO8G9cxQBqEnFV
        c4BKD91ZXS4WMr66nbTzs4NkqOaDAKOGmXOXtw87R1wlceUkbKdvq0hfQLTNFSWh
        Z8m476S/dlYkk2tavE2XVuQtVujA9XqMMsRYxrntDtUvkXs9hPmk83AMDYfGfZEw
        C1gUV/S61zTioEF4KH/AzLpl8rab7O+YkCgcS8MgSFRNXO6zSPFoRF2a11UdUWlR
        veQ9BETwiAAU3Nw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4e20e9e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 1 May 2020 21:14:45 +0000 (UTC)
Date:   Fri, 1 May 2020 15:26:48 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v2 0/2] Add file-system authentication to BTRFS
Message-ID: <20200501212648.GA521030@zx2c4.com>
References: <20200428105859.4719-1-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428105859.4719-1-jth@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Johannes,

On Tue, Apr 28, 2020 at 12:58:57PM +0200, Johannes Thumshirn wrote:
> Currently BRTFS supports CRC32C, XXHASH64, SHA256 and Blake2b for checksumming
> these blocks. This series adds a new checksum algorithm, HMAC(SHA-256), which
> does need an authentication key. When no, or an incoreect authentication key
> is supplied no valid checksum can be generated and a read, fsck or scrub
> operation would detect invalid or tampered blocks once the file-system is
> mounted again with the correct key. 

In case you're interested, Blake2b and Blake2s both have "keyed" modes,
which are more efficient than HMAC and achieve basically the same thing
-- they provide a PRF/MAC. There are normal crypto API interfaces for
these, and there's also an easy library interface:

#include <crypto/blake2s.h>
blake2s(output_mac, input_data, secret_key,
        output_mac_length, input_data_length, secret_key_length);

You might find that the performance of Blake2b and Blake2s is better
than HMAC-SHA2-256.

But more generally, I'm wondering about the general design and what
properties you're trying to provide. Is the block counter being hashed
in to prevent rearranging? Are there generation counters to prevent
replay/rollback?

Also, I'm wondering if this is the kind of feature you'd consider
pairing with a higher speed AEAD, and maybe in a way that would
integrate with the existing fscrypt tooling, without the need to manage
two sets of keys. Ever looked at bcachefs' design for this?
https://bcachefs.org/Encryption/

Either way, I'm happy to learn that btrfs is a filesystem with some
space baked in for authentication tags.

Jason
