Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04D31145EEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 00:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgAVXGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 18:06:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:42486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVXGw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 18:06:52 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A802465A;
        Wed, 22 Jan 2020 23:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579734412;
        bh=iDK9mhfatk0/hNugU/WPUPfmhu1Thz7bh75Z2DXYU/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MdMedgKfSUinhQoW7EX8dAKvj1YwqwHzlbb1cbzLT6dOt2HZWykDyFD3k2cNyhQyK
         8GB5uINMlhWRPvQRr20QS8SxKPsazWkqZ9NELkASmhvpjUozkcfUA+LLJ+HQqgq/Lb
         YogycmIn0nDOqv8LkTPXOOSGVMsOMS5102vK6M3Q=
Date:   Wed, 22 Jan 2020 15:06:50 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v5 0/6] fscrypt preparations for encryption+casefolding
Message-ID: <20200122230649.GC182745@gmail.com>
References: <20200120223201.241390-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120223201.241390-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 02:31:55PM -0800, Eric Biggers wrote:
> This is a cleaned up and fixed version of the fscrypt patches to prepare
> for directories that are both encrypted and casefolded.
> 
> Patches 1-3 start deriving a SipHash key for the new dirhash method that
> will be used by encrypted+casefolded directories.  To avoid unnecessary
> overhead, we only do this if the directory is actually casefolded.
> 
> Patch 4 fixes a bug in UBIFS where it didn't gracefully handle invalid
> hash values in fscrypt no-key names.  This is an existing bug, but the
> new fscrypt no-key name format (patch 6) made it much easier to trigger;
> it started being hit by 'kvm-xfstests -c ubifs -g encrypt'.
> 
> Patch 5 updates UBIFS to make it ready for the new fscrypt no-key name
> format that always includes the dirhash.
> 
> Patch 6 modifies the fscrypt no-key names to always include the dirhash,
> since with the new dirhash method the dirhash will no longer be
> computable from the ciphertext filename without the key.  It also fixes
> a longstanding issue where there could be collisions in the no-key
> names, due to not using a proper cryptographic hash to abbreviate names.
> 
> For more information see the main patch series, which includes the
> filesystem-specific changes:
> https://lkml.kernel.org/linux-fscrypt/20200117214246.235591-1-drosen@google.com/T/#u
> 
> This applies to fscrypt.git#master.
> 
> Changed v4 => v5:
>   - Fixed UBIFS encryption to work with the new no-key name format.

I've applied this series to fscrypt.git#master; however I'd still like Acked-bys
from the UBIFS maintainers on the two UBIFS patches, as well as more
Reviewed-bys from anyone interested.  If I don't hear anything from anyone, I
might drop these to give more time, especially if there isn't an v5.5-rc8.

- Eric
