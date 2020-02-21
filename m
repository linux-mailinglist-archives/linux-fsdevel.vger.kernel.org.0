Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A66F71686BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgBUSek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:34:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:39068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgBUSek (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:34:40 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A5A7206E2;
        Fri, 21 Feb 2020 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582310079;
        bh=AwjpQ9bU1S2PO28VwY0r/NJG8mG+uZ8wB0q2OyWZklI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XaZHrOsm4cKVGzTCJY6bfly9OlJApRJV01unB788BikFgj7nIXYnCUmRTcAAYB5Lk
         niWLuT62tt+H6Iz1PEcuGjjCzamgspIlE4BfnGw93Mvp/jtCANModDTSBO7mEresJ5
         Jxh+dq6sU2WasMLiA+ukMwijngpv7Ww26sVXImW0=
Date:   Fri, 21 Feb 2020 10:34:37 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 3/9] block: blk-crypto-fallback for Inline Encryption
Message-ID: <20200221183437.GC925@sol.localdomain>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-4-satyat@google.com>
 <20200221173539.GA6525@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221173539.GA6525@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:35:39AM -0800, Christoph Hellwig wrote:
> High-level question:  Does the whole keyslot manager concept even make
> sense for the fallback?  With the work-queue we have item that exectutes
> at a time per cpu.  So just allocatea per-cpu crypto_skcipher for
> each encryption mode and there should never be a slot limitation.  Or
> do I miss something?

It does make sense because if blk-crypto-fallback didn't use a keyslot manager,
it would have to call crypto_skcipher_setkey() on the I/O path for every bio to
ensure that the CPU's crypto_skcipher has the correct key.  That's undesirable,
because setting a new key can be expensive with some encryption algorithms, and
also it can require a memory allocation which can fail.  For example, with the
Adiantum algorithm, setting a key requires encrypting ~1100 bytes of data in
order to generate subkeys.  It's better to set a key once and use it many times.

Making blk-crypto-fallback use the keyslot manager also allows the keyslot
manager to be tested by routine filesystem regression testing, e.g.
'gce-xfstests -c ext4/encrypt -g auto -m inlinecrypt'.

- Eric
