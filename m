Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E031405A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 09:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgAQIwL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 03:52:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAQIwL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uk9hxsXkJLJEIYTwSPwZJzvzik2eaj4S5b5zonlGVPQ=; b=Xe/CtTAFsYpJiKhxglqQxcAqx
        1AQ17yCuDFnvlbeQtnVS4VfE/kRKCfkJD3sitm2mM0G4dCe77//iKVnxbl8AZv9RFNUDF7ZUDV4Lc
        smvCh5aM31Ilh1kWMdVSO4reC7dFS0i3NVL+2lZGOzRZKTWWPuZi8fZK1MWWLq16HQ6KvLHlyXsVf
        yaUfSde9vSsxFQRQGFL3nwNpVYGIVcnyjXFys/E8MI8n3Llg+Io7Il+cd6tlJjxc45r0ZbzMQf2Kg
        hJrKxm6h2/id5QP+c0f9SFr2oTVcJx51WzrIDd7fN5HIVlkMaWm6RyCz7RqXcEA5TPPJxaSdsj9Sm
        muWh7jG7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isNMQ-0003GX-3o; Fri, 17 Jan 2020 08:52:10 +0000
Date:   Fri, 17 Jan 2020 00:52:10 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 0/9] Inline Encryption Support
Message-ID: <20200117085210.GA5473@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108184305.GA173657@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Satya,

On Wed, Jan 08, 2020 at 10:43:05AM -0800, Satya Tangirala wrote:
> The fallback actually is in a separate file, and the software only fields
> are not allocated in the hardware case anymore, either - I should have
> made that clear(er) in the coverletter.

I see this now, thanks.  Either the changes weren't pushed to the
fscrypt report by the time I saw you mail, or I managed to look at a
stale local copy.

> Alright, I'll look into this. I still think that the keyslot manager
> should maybe go in a separate file because it does a specific, fairly
> self contained task and isn't just block layer code - it's the interface
> between the device drivers and any upper layer.

So are various other functions in the code like bio_crypt_clone or
bio_crypt_should_process.  Also the keyslot_* naming is way to generic,
it really needs a blk_ or blk_crypto_ prefix.

> > Also what I don't understand is why this managed key-slots on a per-bio
> > basis.  Wou;dn't it make a whole lot more sense to manage them on a
> > struct request basis once most of the merging has been performed?
> I don't immediately see an issue with making it work on a struct request
> basis. I'll look into this more carefully.

I think that should end up being simpler and more efficient.
