Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91E316ED5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 04:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfEHCNE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 May 2019 22:13:04 -0400
Received: from merlin.infradead.org ([205.233.59.134]:43750 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEHCNE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 May 2019 22:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KLUJds55VK5wfuQIecfJeAznkW/rjS8krJ4iieQMrlM=; b=tssjbXhtg14AjIn8ih+V1mun7c
        KuZfpq0AzpZeVpXGTJldMwIPiHg3wF1ZKju0TTzme4FU1wiYttpO7ECWDDTCz+XGh1chMohxVAjOY
        s8m2oERwJPQw3Pac2MrN5a8EX0e3iyAti6mAxtH2aACg182I6+L0CIBJOd7nim9p5keeOgT5H2jF8
        29pCRV9/FN6eEDLi/b3u+hGfohtOJbTRlMEuAziF6bVloBoZJUATWTg/RleOGwU9+h9ZSQmn+KQEn
        13dizgMXllhEVD5myM8ErBFxdaqz47OvrctYksjrYS8AyAY0pm3dVUj9eg3sOFtZ7bwnMvcGnmprD
        xrnzJfKQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOC4i-0008WM-LS; Wed, 08 May 2019 02:12:53 +0000
Subject: Re: [RFC PATCH 1/4] block: Block Layer changes for Inline Encryption
 Support
To:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
References: <20190506223544.195371-1-satyat@google.com>
 <20190506223544.195371-2-satyat@google.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a1632db-c59a-6ac1-87d7-9307e4744aa7@infradead.org>
Date:   Tue, 7 May 2019 19:12:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506223544.195371-2-satyat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
This is documentation comments...

On 5/6/19 3:35 PM, Satya Tangirala wrote:
> diff --git a/Documentation/block/blk-crypto.txt b/Documentation/block/blk-crypto.txt
> new file mode 100644
> index 000000000000..a1b82361cb16
> --- /dev/null
> +++ b/Documentation/block/blk-crypto.txt
> @@ -0,0 +1,185 @@
> +BLK-CRYPTO and KEYSLOT MANAGER
> +===========================
> +
> +CONTENTS
> +1. Objective
> +2. Constraints and notes
> +3. Design
> +4. Blk-crypto
> + 4-1 What does blk-crypto do on bio submission
> +5. Layered Devices
> +6. Future optimizations for layered devices
> +
> +1. Objective
> +============
> +
> +We want to support inline encryption (IE) in the kernel.
> +To allow for testing, we also want a software fallback when actual
> +IE hardware is absent. We also want IE to work with layered devices
> +like dm and loopback (i.e. we want to be able to use the IE hardware
> +of the underlying devices if present, or else fall back to software
> +en/decryption).
> +
> +
> +2. Constraints and notes
> +========================
> +
> +1) IE hardware have a limited number of “keyslots” that can be programmed
> +with an encryption context (key, algorithm, data unit size, etc.) at any time.
> +One can specify a keyslot in a data requests made to the device, and when the

                             in data requests
or
                             in a data request

> +device will en/decrypt the data using the encryption context programmed into
> +that specified keyslot. Of course, when possible, we want to make multiple
> +requests with the the same encryption context share the same keyslot.
> +
> +2) We need a way for filesystems to specify an encryption context to use for
> +en/decrypting a struct bio, and a device driver (like UFS) needs to be able
> +to use that encryption context when it processes the bio.
> +
> +3) We need a way for device drivers to expose their capabilities in a unified
> +way to the upper layers.
> +
> +
> +3. Design
> +=========
> +
> +We add a struct bio_crypt_context to struct bio that can represent an
> +encryption context, because we need to able to pass this encryption context
> +from the FS layer to the device driver to act upon.
> +
> +While IE hardware works on the notion of keyslots, the FS layer has no
> +knowledge of keyslots - it simply wants to specify an encryption context to
> +use while en/decrypting a bio.
> +
> +We introduce a keyslot manager (KSM) that handles the translation from
> +encryption contexts specified by the FS to keyslots on the IE hardware.
> +This KSM also serves as the way IE hardware can expose their capabilities to
> +upper layers. The generic mode of operation is: each device driver that wants
> +to support IE will construct a KSM and set it up in its struct request_queue.
> +Upper layers that want to use IE on this device can then use this KSM in
> +the device’s struct request_queue to translate an encryption context into
> +a keyslot. The presence of the KSM in the request queue shall be used to mean
> +that the device supports IE.
> +
> +On the device driver end of the interface, the device driver needs to tell the
> +KSM how to actually manipulate the IE hardware in the device to do things like
> +programming the crypto key into the IE hardware into a particular keyslot. All
> +this is achieved through the struct keyslot_mgmt_ll_ops that the device driver
> +passes to the KSM when creating it.
> +
> +It uses refcounts to track which keyslots are idle (either they have no
> +encryption context programmed, or there are no in flight struct bios
> +referencing that keyslot). When a new encryption context needs a keyslot, it
> +tries to find a keyslot that has already been programmed with the same
> +encryption context, and if there is no such keyslot, it evicts the least
> +recently used idle keyslot and programs the new encryption context into that
> +one. If no idle keyslots are available, then the caller will sleep until there
> +is at least one.
> +
> +
> +4. Blk-crypto
> +=============
> +
> +The above is sufficient for simple cases, but does not work if there is a
> +need for a software fallback, or if we are want to use IE with layered devices.
> +To these ends, we introduce blk-crypto. Blk-crypto allows us to present a
> +unified view of encryption to the FS (so FS only needs to specify an
> +encryption context and not worry about keyslots at all), and block crypto can
> +decide whether to delegate the en/decryption to IE hardware or to software
> +(i.e. to the kernel crypto API). Block crypto maintains an internal KSM that
> +serves as the software fallback to the kernel crypto API.
> +
> +Blk-crypto needs to ensure that the encryption context is programmed into the
> +"correct" keyslot manager for IE. If a bio is submitted to a layered device
> +that eventually passes the bio down to a device that really does support IE, we
> +want the encryption context to be programmed into a keyslot for the KSM of the
> +device with IE support. However, blk-crypto does not know a-priori whether a

                                                             a priori

> +particular device is the final device in the layering structure for a bio or
> +not. So in the case that a particular device does not support IE, since it is
> +possibly the final destination device for the bio, if the bio requires
> +encryption (i.e. the bio is doing a write operation), blk-crypto must fallback
> +to software *before* sending the bio to the device.
> +
> +Blk-crypto ensures that
> +1) The bio’s encryption context is programmed into a keyslot in the KSM of the
> +request queue that the bio is being submitted to (or the software fallback KSM
> +if the request queue doesn’t have a KSM), and that the processing_ksm in the
> +bi_crypt_context is set to this KSM
> +
> +2) That the bio has its own individual reference to the keyslot in this KSM.
> +Once the bio passes through block crypto, its encryption context is programmed

                          is   block crypto
                 the same as   blk-crypto?
If so, consistency would be Good.

> +in some KSM. The “its own individual reference to the keyslot” ensures that
> +keyslots can be released by each bio independently of other bios while ensuring
> +that the bio has a valid reference to the keyslot when, for e.g., the software
> +fallback KSM in blk-crypto performs crypto for on the device’s behalf. The
> +individual references are ensured by increasing the refcount for the keyslot in
> +the processing_ksm when a bio with a programmed encryption context is cloned.
> +
> +
> +4-1. What blk-crypto does on bio submission
> +-------------------------------------------
> +
> +Case 1: blk-crypto is given a bio with only an encryption context that hasn’t
> +been programmed into any keyslot in any KSM (for e.g. a bio from the FS). In
> +this case, blk-crypto will program the encryption context into the KSM of the
> +request queue the bio is being submitted to (and if this KSM does not exist,
> +then it will program it into blk-crypto’s internal KSM for software fallback).
> +The KSM that this encryption context was programmed into is stored as the
> +processing_ksm in the bio’s bi_crypt_context.
> +
> +Case 2: blk-crypto is given a bio whose encryption context has already been
> +programmed into a keyslot in the *software fallback KSM*. In this case,
> +blk-crypto does nothing; it treats the bio as not having specified an
> +encryption context. Note that we cannot do what we will do in Case 3 here
> +because we would have already encrypted the bio in software by this point.
> +
> +Case 3: blk-crypto is given a bio whose encryption context has already been
> +programmed into a keyslot in some KSM (that is *not* the software fallback
> +KSM). In this case, blk-crypto first releases that keyslot from that KSM and
> +then treats the bio as in Case 1.
> +
> +This way, when a device driver is processing a bio, it can be sure that
> +the bio’s encryption context has been programmed into some KSM (either the
> +device driver’s request queue’s KSM, or blk-crypto’s software fallback KSM).
> +It then simply needs to check if the bio’s processing_ksm is the device’s
> +request queue’s KSM. If so, then it should proceed with IE. If not, it should
> +simply do nothing with respect to crypto, because some other KSM (perhaps the
> +blk-crypto software fallback KSM) is handling the en/decryption.
> +
> +Blk-crypto will release the keyslot that is being held by the bio (and also
> +decrypt it if the bio is using the software fallback KSM) once
> +bio_remaining_done returns true for the bio.
> +
> +
> +5. Layered Devices
> +==================
> +
> +Layered devices that wish to support IE need to create their own keyslot
> +manager for their request queue, and expose whatever functionality they choose.
> +When a layered device wants to pass a bio to another layer (either by
> +resubmitting the same bio, or by submitting a clone), it doesn’t need to do
> +anything special because the bio (or the clone) will once again pass through
> +blk-crypto, which will work as described in Case 3. If a layered device wants
> +for some reason to do the IO by itself instead of passing it on to a child
> +device, but it also chose to expose IE capabilities by setting up a KSM in its
> +request queue, it is then responsible for en/decrypting the data itself. In
> +such cases, the device can choose to call the blk-crypto function
> +blk_crypto_fallback_to_software (TODO: Not yet implemented), which will
> +cause the en/decryption to be done via software fallback.
> +
> +
> +6. Future Optimizations for layered devices
> +===========================================
> +
> +Creating a keyslot manager for the layered device uses up memory for each
> +keyslot, and in general, a layered device (like dm-linear) merely passes the
> +request on to a “child” device, so the keyslots in the layered device itself
> +might be completely unused. We can instead define a new type of KSM; the
> +“passthrough KSM”, that layered devices can use to let blk-crypto know that
> +this layered device *will* pass the bio to some child device (and hence
> +through blk-crypto again, at which point blk-crypto can program the encryption
> +context, instead of programming it into the layered device’s KSM). Again, if
> +the device “lies” and decides to do the IO itself instead of passing it on to
> +a child device, it is responsible for doing the en/decryption (and can choose
> +to call blk_crypto_fallback_to_software). Another use case for the
> +"passthrough KSM" is for IE devices that want to manage their own keyslots/do
> +not have a limited number of keyslots.


-- 
~Randy
