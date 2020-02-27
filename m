Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B01172887
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 20:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgB0TZr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 14:25:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727159AbgB0TZq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:25:46 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6ADC24691;
        Thu, 27 Feb 2020 19:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582831546;
        bh=kGU0a0I3IvKdb4w1iUhQ37ywQbN9rjfpMR5iKdjutug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V3StYee0L66BoNn9KcVM2tPtSK3paFsNrIKznwTf8CK9KxeFhi3ZH/ln7EP5hXIAr
         HAUNj01Ixcs9roRcSoN5rmOMIs2EkSno4j81M0pJkUBY7UL2ArRgnsY8mn83Xw51Q9
         aQsDsd891ZxVxCj7opcQJOBy1jaEwhuOgnfsz6oI=
Date:   Thu, 27 Feb 2020 11:25:44 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 3/9] block: blk-crypto-fallback for Inline Encryption
Message-ID: <20200227192544.GE877@sol.localdomain>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-4-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-4-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:50:44AM -0800, Satya Tangirala wrote:
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

In v7, only blk_mq_make_request() actually calls blk_crypto_bio_prep().
That will make the crypto contexts be silently ignored (no fallback) if
q->make_request_fn != blk_mq_make_request.

In recent kernels that *hopefully* won't matter in practice since almost
everyone is using blk_mq_make_request.  But it still seems like a poor design.
First, it's super important that if someone requests encryption, then they
either get it or get an error; it should *never* be silently ignored.  Second,
part of the goal of blk-crypto-fallback is that it should always work, so that
in principle users don't have to implement the encryption twice, once via
blk-crypto and once via fs or dm-layer crypto.

So is there any reason not to keep the blk_crypto_bio_prep() call in
generic_make_request()?

I think performance can't be much of a complaint, since if almost everyone is
using blk_mq_make_request() then they are making the function call anyway...

- Eric
