Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14170EF3D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 04:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfKEDM0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 22:12:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbfKEDMZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 22:12:25 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C0D206B8;
        Tue,  5 Nov 2019 03:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572923544;
        bh=hCqiCSjlrDhL5SGAV3AMEdP6Wu47sW0wJnkXEfvsLDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ri2wHRty9kxlKC9gQp5N8RoTQPWUoA55ALYg1PirNxKLDJn3ZgT/m/zKOqgfEIUqm
         Ua2KFn6GvKBaanq+gHvxNHv86uoy/TSVumd9fbUnuZNJrrygfaLQn9RVQTUVh3s+Tu
         TNbhm3BZI6egc58lOzR1Oc8dCl+b9DOCQFLY3J+w=
Date:   Mon, 4 Nov 2019 19:12:22 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-scsi@vger.kernel.org,
        Kim Boojin <boojin.kim@samsung.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 7/9] fscrypt: add inline encryption support
Message-ID: <20191105031222.GE692@sol.localdomain>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>, linux-scsi@vger.kernel.org,
        Kim Boojin <boojin.kim@samsung.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-8-satyat@google.com>
 <20191031183217.GF23601@infradead.org>
 <20191031202125.GA111219@gmail.com>
 <20191031212103.GA6244@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031212103.GA6244@infradead.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:21:03PM -0700, Christoph Hellwig wrote:
> > > 
> > > Btw, I'm not happy about the 8-byte IV assumptions everywhere here.
> > > That really should be a parameter, not hardcoded.
> > 
> > To be clear, the 8-byte IV assumption doesn't really come from fs/crypto/, but
> > rather in what the blk-crypto API provides.  If blk-crypto were to provide
> > longer IV support, fs/crypto/ would pretty easily be able to make use of it.
> 
> That's what I meant - we hardcode the value in fscrypt.  Instead we need
> to expose the size from blk-crypt and check for it.
> 
> > 
> > (And if IVs >= 24 bytes were supported and we added AES-128-CBC-ESSIV and
> > Adiantum support to blk-crypto.c, then inline encryption would be able to do
> > everything that the existing filesystem-layer contents encryption can do.)
> > 
> > Do you have anything in mind for how to make the API support longer IVs in a
> > clean way?  Are you thinking of something like:
> > 
> > 	#define BLK_CRYPTO_MAX_DUN_SIZE	24
> > 
> > 	u8 dun[BLK_CRYPTO_MAX_DUN_SIZE];
> > 	int dun_size;
> > 
> > We do have to perform arithmetic operations on it, so a byte array would make it
> > ugly and slower, but it should be possible...
> 
> Well, we could make it an array of u64s, which means we can do all the
> useful arithmetics on components on one of them.  But I see the point,
> this adds significant complexity for no real short term gain, and we
> should probably postponed it until needed.  Maybe just document the
> assumptions a little better.

Just in case it's not obvious to anyone, I should also mention that being
limited to specifying a 64-bit DUN doesn't prevent hardware that accepts a
longer IV (e.g. 128 bits) from being used.  It would just be a matter of
zero-padding the IV in the driver rather than in hardware.

The actual limitation we're talking about here is in the range of IVs that can
be specified.  A 64-bit DUN only allows the first 64 bits of the IV to be
nonzero.  That works for fscrypt in all cases except DIRECT_KEY policies, and it
would work for dm-crypt using the usual dm-crypt IV generator (plain64).

But for inline encryption to be compatible with DIRECT_KEY fscrypt policies or
with certain other dm-crypt IV generators, we'd need the ability to specify more
IV bits.

- Eric
