Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC4709D5A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 20:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfHZSSC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 14:18:02 -0400
Received: from ms.lwn.net ([45.79.88.28]:58840 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387768AbfHZSSC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:18:02 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C72BB300;
        Mon, 26 Aug 2019 18:18:00 +0000 (UTC)
Date:   Mon, 26 Aug 2019 12:17:59 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v4 3/8] block: blk-crypto for Inline Encryption
Message-ID: <20190826121759.6fa594b7@lwn.net>
In-Reply-To: <20190821075714.65140-4-satyat@google.com>
References: <20190821075714.65140-1-satyat@google.com>
        <20190821075714.65140-4-satyat@google.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Aug 2019 00:57:09 -0700
Satya Tangirala <satyat@google.com> wrote:

> We introduce blk-crypto, which manages programming keyslots for struct
> bios. With blk-crypto, filesystems only need to call bio_crypt_set_ctx with
> the encryption key, algorithm and data_unit_num; they don't have to worry
> about getting a keyslot for each encryption context, as blk-crypto handles
> that. Blk-crypto also makes it possible for layered devices like device
> mapper to make use of inline encryption hardware.
> 
> Blk-crypto delegates crypto operations to inline encryption hardware when
> available, and also contains a software fallback to the kernel crypto API.
> For more details, refer to Documentation/block/blk-crypto.txt.

So that file doesn't seem to exist; did you mean inline-encryption.txt
here?

> Signed-off-by: Satya Tangirala <satyat@google.com>
> ---
>  Documentation/block/inline-encryption.txt | 186 ++++++
>  block/Kconfig                             |   2 +
>  block/Makefile                            |   3 +-
>  block/bio-crypt-ctx.c                     |   7 +-
>  block/bio.c                               |   5 +
>  block/blk-core.c                          |  11 +-
>  block/blk-crypto.c                        | 737 ++++++++++++++++++++++
>  include/linux/bio-crypt-ctx.h             |   7 +
>  include/linux/blk-crypto.h                |  47 ++
>  9 files changed, 1002 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/block/inline-encryption.txt
>  create mode 100644 block/blk-crypto.c
>  create mode 100644 include/linux/blk-crypto.h
> 
> diff --git a/Documentation/block/inline-encryption.txt b/Documentation/block/inline-encryption.txt
> new file mode 100644
> index 000000000000..925611a5ea65
> --- /dev/null
> +++ b/Documentation/block/inline-encryption.txt

So we've been doing our best to get rid of .txt files in the documentation
tree.  I'd really be a lot happier if this were an RST file instead.  The
good news is that it's already 99% RST, so little would have to change.

See the info in Documentation/doc-guide for details.

> @@ -0,0 +1,186 @@
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

RST would generate this TOC for you, so you can take it out.

> +1. Objective
> +============
> +
> +We want to support inline encryption (IE) in the kernel.
> +To allow for testing, we also want a crypto API fallback when actual
> +IE hardware is absent. We also want IE to work with layered devices
> +like dm and loopback (i.e. we want to be able to use the IE hardware
> +of the underlying devices if present, or else fall back to crypto API
> +en/decryption).
> +
> +
> +2. Constraints and notes
> +========================
> +
> +1) IE hardware have a limited number of “keyslots” that can be programmed

Some people get irate when they encounter non-ASCII characters in the docs;
that includes "smart quotes".

Also, s/have/has/

> +with an encryption context (key, algorithm, data unit size, etc.) at any time.
> +One can specify a keyslot in a data request made to the device, and the
> +device will en/decrypt the data using the encryption context programmed into
> +that specified keyslot. When possible, we want to make multiple requests with
> +the same encryption context share the same keyslot.
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
> +We add a struct bio_crypt_ctx to struct bio that can represent an
> +encryption context, because we need to be able to pass this encryption
> +context from the FS layer to the device driver to act upon.
> +
> +While IE hardware works on the notion of keyslots, the FS layer has no
> +knowledge of keyslots - it simply wants to specify an encryption context to
> +use while en/decrypting a bio.
> +
> +We introduce a keyslot manager (KSM) that handles the translation from
> +encryption contexts specified by the FS to keyslots on the IE hardware.

So...if this were RST, you could have directives to pull in the nice
kerneldoc comments you've already put into the source.

I'll stop here...presumably I've made my point by now :)

Thanks for documenting this subsystem!

jon
