Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D4F01A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 16:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbfKEPj7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 10:39:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48538 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbfKEPj6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 10:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XQdcZ/rCMxPfhUJE8nbWkRrJsdxA+Vm56qg50/+E1Cw=; b=Ocp9xiaKzYOCoNB+oT3sxZPTQ
        GZZmpeZz1Pkbx3hL5igN2A9nnxgJeh5ZX0h0RFq6u88ua22HGxw6tlKR923/wrmQM4d9cJFXkqmXz
        7p6KUsYbiy3UTrhyHmOUjEl4g1vqoBwf3i4ju5z28ZkYAEfqGXc4DjckNzm91NOiLwHOAtuFuuhfP
        /u+IK73URb7cxkeIV7/gM5hFZ3aGu6h+2cn2G7ik8OqisFdebxIl9EiPUqch0yc5uCTcNG4K9OCbX
        VW4f/V+e6xpqbfC64GJBGkXaIedjYx1UzWAGjYoerE2gtLIaBhKqYngoD0iVUT+cjBXJ4SKNeqg0x
        wuaWM8E5g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iS0w1-0000HC-RP; Tue, 05 Nov 2019 15:39:57 +0000
Date:   Tue, 5 Nov 2019 07:39:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Satya Tangirala <satyat@google.com>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v5 3/9] block: blk-crypto for Inline Encryption
Message-ID: <20191105153957.GA29320@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-4-satyat@google.com>
 <20191031175713.GA23601@infradead.org>
 <20191031205045.GG16197@mit.edu>
 <20191031212234.GA32262@infradead.org>
 <20191105015411.GB692@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105015411.GB692@sol.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 06:01:17PM -0800, Eric Biggers wrote:
> I think that "Severely bloating the per-I/O data structure" is an exaggeration,
> since that it's only 32 bytes, and it isn't in struct bio directly but rather in
> struct bio_crypt_ctx...

Yes, and none of that is needed for the real inline crypto.  And I think
we can further reduce the overhead of bio_crypt_ctx once we have the
basiscs sorted out.  If we want to gain more traction we need to reduce
the I/O to a minimum.

> In any case, Satya, it might be a good idea to reorganize this patchset so that
> it first adds all logic that's needed for "real" inline encryption support
> (including the needed parts of blk-crypto.c), then adds the crypto API fallback
> as a separate patch.  That would separate the concerns more cleanly and make the
> patchset easier to review, and make it easier to make the fallback
> de-configurable or even remove it entirely if that turns out to be needed.

Yes, that is a good idea.  Not just in terms of patch, but also in terms
of code organization.  The current structure is pretty weird with 3
files that are mostly tighly integrated, except that one also has the
software implementations.  So what I think we need at a minimum is:

 - reoranizize that we have say block/blk-crypt.c for all the inline
   crypto infrastructure, and block/blk-crypy-sw.c for the actual
   software crypto implementation.
 - remove all the fields only needed for software crypto from
   bio_crypt_ctx, and instead clone the bio into a bioset with the
   additional fields only when we use the software implementation, so
   that there is no overhead for the hardware path.
