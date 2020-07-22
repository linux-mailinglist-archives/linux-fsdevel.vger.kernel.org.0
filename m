Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C140022A28C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 00:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgGVWoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 18:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbgGVWoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:44:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCFDC0619DC;
        Wed, 22 Jul 2020 15:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M1S5XB5jiOs5OBOB/2wH4SZBx30nFn9Ws/CcKpaLIvw=; b=Vk6TjZt44S+/o/6Za+Yv8f+njY
        HByLP468kZDGhNcS1rfX0KpYuV5q+9yAZdxTk2zCbasyjrcuzHK1ql0TqJnEOCKG1qmX38vWiIf3y
        anIhRutn1IkLiYU2CX13chtoOhugQ9623I/k3Bgc54XywPpW05WhcM8cu/kvK8VHohtCLFF/fyeLv
        DnB4vDru6uXeWEYNCJWxMlXp15X41KriDq9C6mt3VV7kq5oYEclCox3a3nFCgh/LhDRjvErgVkMob
        gKUJx5RUghjFtfTVXD6EadMlsi29AnTVT1WT0L4UOwu27vikJZkKvWaN/izhcaXw++r3sG5Gbs/aK
        GtGsxJxg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyNT5-0005no-5i; Wed, 22 Jul 2020 22:44:07 +0000
Date:   Wed, 22 Jul 2020 23:44:07 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Satya Tangirala <satyat@google.com>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 3/7] iomap: support direct I/O with fscrypt using
 blk-crypto
Message-ID: <20200722224407.GR15516@casper.infradead.org>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-4-satyat@google.com>
 <20200722211629.GE2005@dread.disaster.area>
 <20200722223404.GA76479@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722223404.GA76479@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 22, 2020 at 03:34:04PM -0700, Eric Biggers wrote:
> > Which means you are now placing a new constraint on this code in
> > that we cannot ever, in future, zero entire blocks here.
> > 
> > This code can issue arbitrary sized zeroing bios - multiple entire fs blocks
> > blocks if necessary - so I think constraining it to only support
> > partial block zeroing by adding a warning like this is no correct.
> 
> In v3 and earlier this instead had the code to set an encryption context:
> 
> 	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
> 				  GFP_KERNEL);
> 
> Would you prefer that, even though the call to fscrypt_set_bio_crypt_ctx() would
> always be a no-op currently (since for now, iomap_dio_zero() will never be
> called with an encrypted file) and thus wouldn't be properly tested?
> 
> BTW, iomap_dio_zero() is actually limited to one page, so it's not quite
> "arbitrary sizes".

I have a patch for that

http://git.infradead.org/users/willy/pagecache.git/commitdiff/1a4d72a890ca9c2ea3d244a6153511ae674ce1d8

It's not going to cause a problem for crossing a 2^32 boundary because
pages are naturally aligned and don't get that big.
