Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0614916B5BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 00:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgBXXg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 18:36:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgBXXg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=su7zxcSpmTZRMT/KaDln9XS6SD5jlWklN/1EnJqLTaY=; b=a8iBiTmLkCfR2U9kE0H0YYhTfn
        o/scgFru4hBFHzGI47rRZprkclexGVaEqLsg/rB+QSE6MOYe5nK5Y1JE/sYlvoTfKu9jWgQOBc04h
        sbbQ4fEsVPSyaV0j12+5FyNyWHxuj2OsU1d8qRaMZxJ/8ab/QhwonRXL1U4J2B0RsT1evDF4WLvD3
        Nki3qFEibQFrRTlru5egSP0PRrZb4Qdm9/KhXRx+RzSljbgj93kiY7faRf0dBqTSaibeFHOp3N4tJ
        wbdqJqnYtIVPFODIAQhv+tQ+vb02DXh4rvICJ6LbuJXKYUDZHVJSycZVvB6U1fjvMp3txTYeymc1R
        4jZ/y1eA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6NGz-0001wx-Mm; Mon, 24 Feb 2020 23:36:25 +0000
Date:   Mon, 24 Feb 2020 15:36:25 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 3/9] block: blk-crypto-fallback for Inline Encryption
Message-ID: <20200224233625.GB30288@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-4-satyat@google.com>
 <20200221173539.GA6525@infradead.org>
 <20200221183437.GC925@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221183437.GC925@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:34:37AM -0800, Eric Biggers wrote:
> On Fri, Feb 21, 2020 at 09:35:39AM -0800, Christoph Hellwig wrote:
> > High-level question:  Does the whole keyslot manager concept even make
> > sense for the fallback?  With the work-queue we have item that exectutes
> > at a time per cpu.  So just allocatea per-cpu crypto_skcipher for
> > each encryption mode and there should never be a slot limitation.  Or
> > do I miss something?
> 
> It does make sense because if blk-crypto-fallback didn't use a keyslot manager,
> it would have to call crypto_skcipher_setkey() on the I/O path for every bio to
> ensure that the CPU's crypto_skcipher has the correct key.  That's undesirable,
> because setting a new key can be expensive with some encryption algorithms, and
> also it can require a memory allocation which can fail.  For example, with the
> Adiantum algorithm, setting a key requires encrypting ~1100 bytes of data in
> order to generate subkeys.  It's better to set a key once and use it many times.

I didn't think of such expensive operations when setting the key.
Note that you would not have to do it on every I/O, as chances are high
you'll get I/O from the same submitter and thus the same key, and we
can optimize for that case pretty easily.

But if you think the keyslot manager is better I accept that, this was
just a throught when looking over the code.
