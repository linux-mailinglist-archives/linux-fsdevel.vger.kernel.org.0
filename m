Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2CA41274EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 06:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbfLTFKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 00:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbfLTFKj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 00:10:39 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54001227BF;
        Fri, 20 Dec 2019 05:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576818638;
        bh=EsQwVleOkQSbN4HSmdTMp1F5mGJkLCIuwjwRgIoHL9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWETL7LzZvhtFii87WBO8PsOBIKERTQk2mfOdAClWrQxJ15Gw/XjDXjmI7MoBIICX
         Fpc0yKZFf91HSV1c8lRzvUGwEqw6oCI2tLWdpjgCUT+93WoV7lTVq7rl/GrcbnA5q2
         CVg2Nc6rhhy6tUursJJtXKMdeKkw0LsoJ0r13Dvg=
Date:   Thu, 19 Dec 2019 21:10:36 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 3/9] block: blk-crypto for Inline Encryption
Message-ID: <20191220051036.GE718@sol.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 06:51:30AM -0800, Satya Tangirala wrote:
> diff --git a/Documentation/block/inline-encryption.rst b/Documentation/block/inline-encryption.rst
> new file mode 100644
> index 000000000000..330106b23c09
> --- /dev/null
> +++ b/Documentation/block/inline-encryption.rst
> @@ -0,0 +1,183 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +Inline Encryption
> +=================
> +
> +Objective
> +=========
> +
> +We want to support inline encryption (IE) in the kernel.
> +To allow for testing, we also want a crypto API fallback when actual
> +IE hardware is absent. We also want IE to work with layered devices
> +like dm and loopback (i.e. we want to be able to use the IE hardware
> +of the underlying devices if present, or else fall back to crypto API
> +en/decryption).
> +
> +
> +Constraints and notes
> +=====================
> +
> +- IE hardware have a limited number of "keyslots" that can be programmed
> +  with an encryption context (key, algorithm, data unit size, etc.) at any time.
> +  One can specify a keyslot in a data request made to the device, and the
> +  device will en/decrypt the data using the encryption context programmed into
> +  that specified keyslot. When possible, we want to make multiple requests with
> +  the same encryption context share the same keyslot.
> +
> +- We need a way for filesystems to specify an encryption context to use for
> +  en/decrypting a struct bio, and a device driver (like UFS) needs to be able
> +  to use that encryption context when it processes the bio.
> +
> +- We need a way for device drivers to expose their capabilities in a unified
> +  way to the upper layers.
> +

Can you add an explicit explanation about how inline encryption is different
from "self-encrypting drives", like ones based on the TCG Opal or ATA Security
standards?  That seems to be a common point of confusion.

Also, this documentation file really ought to start by briefly explaining what
inline encryption is and why it's important.  Then only after that get into the
implementation.  Don't assume the reader has already read a bunch of commit
messages, cover letters, articles, code, etc.

- Eric
