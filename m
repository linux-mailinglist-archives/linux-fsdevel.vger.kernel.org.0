Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2719116841A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 17:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgBUQvN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 11:51:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36344 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgBUQvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ljeDBtIhvMl7XkvIGfVYLN9gAQL27p/c67Gbwn9I/5c=; b=dfTjZxKR1/3QPd5yLOq9tyh5dh
        WW35vcZB2LeZ6eSWMMJtyu+t6W9N1vf8XbRYXZTXLXsG0zAsq3E6Fp0njWa2+7VoAFOZqiHvIX95D
        DrhMl8XWSo2HkJYCAjwc6doBR6qqvejseLhDyrvtjCf3SDd7UwRHJMOT1BWA7aH2k4uSyUW51Fno8
        FUXtu+b4pQd5eJD1uokxaAHJ3XodWUhVHLeXqngqeJbPmdXASEZtE8X9lTE4wctYk1/OjAcVt6cbg
        ASE1G6bB2VNJod5BBqDf6cpqLPT9NZRNoymmtrQuDlHLBLbANFzhRfdcnRfC11Ib1PDkxXJG7KRTg
        DkdEiXbQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5BWA-0008Cb-DS; Fri, 21 Feb 2020 16:51:10 +0000
Subject: Re: [PATCH v7 3/9] block: blk-crypto-fallback for Inline Encryption
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-4-satyat@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9c81a71f-9322-7f89-fa3d-4511f162d085@infradead.org>
Date:   Fri, 21 Feb 2020 08:51:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221115050.238976-4-satyat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/21/20 3:50 AM, Satya Tangirala wrote:
> Blk-crypto delegates crypto operations to inline encryption hardware when
> available. The separately configurable blk-crypto-fallback contains a
> software fallback to the kernel crypto API - when enabled, blk-crypto
> will use this fallback for en/decryption when inline encryption hardware is
> not available. This lets upper layers not have to worry about whether or
> not the underlying device has support for inline encryption before
> deciding to specify an encryption context for a bio, and also allows for
> testing without actual inline encryption hardware. For more details, refer
> to Documentation/block/inline-encryption.rst.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  Documentation/block/index.rst             |   1 +
>  Documentation/block/inline-encryption.rst | 162 ++++++
>  block/Kconfig                             |  10 +
>  block/Makefile                            |   1 +
>  block/bio-integrity.c                     |   2 +-
>  block/blk-crypto-fallback.c               | 673 ++++++++++++++++++++++
>  block/blk-crypto-internal.h               |  32 +
>  block/blk-crypto.c                        |  43 +-
>  include/linux/blk-crypto.h                |  17 +-
>  include/linux/blk_types.h                 |   6 +
>  10 files changed, 938 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/block/inline-encryption.rst
>  create mode 100644 block/blk-crypto-fallback.c


> diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
> new file mode 100644
> index 000000000000..02abea993975
> --- /dev/null
> +++ b/Documentation/block/inline-encryption.rst
> @@ -0,0 +1,162 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Inline Encryption
> +=================
> +
> +Background
> +==========
> +
> +Inline encryption hardware sit logically between memory and the disk, and can

                              sits

> +en/decrypt data as it goes in/out of the disk. Inline encryption hardware have a

                                                                             has

> +fixed number of "keyslots" - slots into which encryption contexts (i.e. the
> +encryption key, encryption algorithm, data unit size) can be programmed by the
> +kernel at any time. Each request sent to the disk can be tagged with the index
> +of a keyslot (and also a data unit number to act as an encryption tweak), and
> +the inline encryption hardware will en/decrypt the data in the request with the
> +encryption context programmed into that keyslot. This is very different from
> +full disk encryption solutions like self encrypting drives/TCG OPAL/ATA
> +Security standards, since with inline encryption, any block on disk could be
> +encrypted with any encryption context the kernel chooses.
> +
> +
> +Objective
> +=========
> +
...
> +
> +
> +Constraints and notes
> +=====================
> +
> +- IE hardware have a limited number of "keyslots" that can be programmed

                 has

> +  with an encryption context (key, algorithm, data unit size, etc.) at any time.
> +  One can specify a keyslot in a data request made to the device, and the
> +  device will en/decrypt the data using the encryption context programmed into
> +  that specified keyslot. When possible, we want to make multiple requests with
> +  the same encryption context share the same keyslot.
> +
...
> +
> +
> +Design
> +======
> +
> +We add a :c:type:`struct bio_crypt_ctx` to :c:type:`struct bio` that can
> +represent an encryption context, because we need to be able to pass this
> +encryption context from the FS layer to the device driver to act upon.
> +
> +While IE hardware works on the notion of keyslots, the FS layer has no
> +knowledge of keyslots - it simply wants to specify an encryption context to
> +use while en/decrypting a bio.
> +
> +We introduce a keyslot manager (KSM) that handles the translation from
> +encryption contexts specified by the FS to keyslots on the IE hardware.
> +This KSM also serves as the way IE hardware can expose their capabilities to

                                                          its

> +upper layers. The generic mode of operation is: each device driver that wants
> +to support IE will construct a KSM and set it up in its struct request_queue.
> +Upper layers that want to use IE on this device can then use this KSM in
> +the device's struct request_queue to translate an encryption context into
> +a keyslot. The presence of the KSM in the request queue shall be used to mean
> +that the device supports IE.
> +
...

Hi Satya,
ISTM that we disagree on whether "hardware" is singular or plural.  ;)

My interface search foo (FWIW) says that "hardware" has no plural version.
Anyway, my best evidence is in your intro/commit message, where it says:
"when inline encryption hardware is not available",
so it must be singular.  :)

cheers.
-- 
~Randy

