Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A1317AA39
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 17:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEQLl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 11:11:41 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40164 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgCEQLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uen6VLar276Fa0qz/XOKv1RvuUuLbo9suzCz5NScJNI=; b=tow7fovI56zU/zHIFBvyQFjPvu
        oxu7I0rkCiFvKuf0jEyycgSOkgif2ymuw5tLBs0Iv2NiEPVqH11+DMB5tD5Y1H5n5aG/6Y8W7Z8/g
        I9rzwwornx2tBwTtWTg7Jy50rRRciiS730r/9jfMQuw/uB3cN+ipx7Q+YO+vTUh+5OgwpnmMwOvPd
        xjsFxPMQlR8JlJEeUjcvs7Uk/1Dg1af47nYqVfza4SpnXum9WuKlu4VGLvQsHemNL/GQhsJkzwJID
        JJsVbxURX6EkP2HNco5kV4mp9mkq4B9IciJaI9mhKj378teu4MbbrEbnSAeqCsMgEfix3nL3UWdSI
        wvQ8JOIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9t63-00054F-6B; Thu, 05 Mar 2020 16:11:39 +0000
Date:   Thu, 5 Mar 2020 08:11:39 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 1/9] block: Keyslot Manager for Inline Encryption
Message-ID: <20200305161139.GA19270@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-2-satyat@google.com>
 <20200221170434.GA438@infradead.org>
 <20200221173118.GA30670@infradead.org>
 <20200227181411.GB877@sol.localdomain>
 <20200227212512.GA162309@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227212512.GA162309@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 01:25:12PM -0800, Satya Tangirala wrote:
> I think it does make some sense at least to make the keyslot type opaque
> to most of the system other than the driver itself (the driver will now
> have to call a function like blk_ksm_slot_idx_for_keyslot to actually get
> a keyslot number at the end of the day). Also this way, the keyslot manager
> can verify that the keyslot passed to blk_ksm_put_slot is actually part of
> that keyslot manager (and that somebody isn't releasing a slot number that
> was actually acquired from a different keyslot manager). I don't think
> it's much benefit or loss either way, but I already switched to passing
> pointers to struct keyslot around instead of ints, so I'll keep it that
> way unless you strongly feel that using ints in this case is better
> than struct keyslot *.

Exactly.  This provides a little type safety.
