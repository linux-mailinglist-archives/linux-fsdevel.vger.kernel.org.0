Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC34153736
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 19:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBESFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 13:05:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbgBESFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lnr7mIt+S4K5BkVzezLQyquUi1haUDf4FzQ/dLHJa44=; b=ZyV7jooypoITHaGMYAmvuzyIwy
        HOVxgMBez/QZL+gNVTmE4TQMMhWwEutxaKSc79ksCTj4cM6VJk/KCRWXVCX4yKtHTBtCLTIcqFICX
        UrrTcw1fUf71hmJR7LukbyWk46bMLT0ScUhFZRsq8FxIAXTUAl/mNM2sQ2R5/fAPwhWlHfvewEXB0
        MCDiGPKdoIy+2Wv3BuzDpIPHU39BfK3834knDyI9BKyijJ0cMDDoR3Jq15lnj8Gg5YtGnJhzXVw2T
        af2+rZThDCahfxdXN31wKsNmzhWsuKPhhpePWiyN926spZ7H0kqWAfnCRQguXu8Is4pV0jS2QAtOD
        BNVGtw6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izP3V-0001Ma-CA; Wed, 05 Feb 2020 18:05:41 +0000
Date:   Wed, 5 Feb 2020 10:05:41 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 0/9] Inline Encryption Support
Message-ID: <20200205180541.GA32041@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
 <20200201005341.GA134917@google.com>
 <20200203091558.GA28527@infradead.org>
 <20200204033915.GA122248@google.com>
 <20200204145832.GA28393@infradead.org>
 <20200204212110.GA122850@gmail.com>
 <20200205073601.GA191054@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205073601.GA191054@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 11:36:01PM -0800, Eric Biggers wrote:
> The vendor-specific SMC calls do seem to work in atomic context, at least on
> SDA845.  However, in ufshcd_program_key(), the calls to pm_runtime_get_sync()
> and ufshcd_hold() can also sleep.
> 
> I think we can move the pm_runtime_get_sync() to ufshcd_crypto_keyslot_evict(),
> since the block layer already ensures the device is not runtime-suspended while
> requests are being processed (see blk_queue_enter()).  I.e., keyslots can be
> evicted independently of any bio, but that's not the case for programming them.

Yes.

> That still leaves ufshcd_hold(), which is still needed to ungate the UFS clocks.
> It does accept an 'async' argument, which is used by ufshcd_queuecommand() to
> schedule work to ungate the clocks and return SCSI_MLQUEUE_HOST_BUSY.
> 
> So in blk_mq_dispatch_rq_list(), we could potentially try to acquire the
> keyslot, and if it can't be done because either none are available or because
> something else needs to be waited for, we can put the request back on the
> dispatch list -- similar to how failure to get a driver tag is handled.

Yes, that is what I had in mind.

> However, if I understand correctly, that would mean that all requests to the
> same hardware queue would be blocked whenever someone is waiting for a keyslot
> -- even unencrypted requests and requests for unrelated keyslots.

At least for an initial dumb implementation, yes.  But if we care enough
we can improve the code to check for the encrypted flag and only put
back encrypted flags in that case.

> It's possible that would still be fine for the Android use case, as vendors tend
> to add enough keyslots to work with Android, provided that they choose the
> fscrypt format that uses one key per encryption policy rather than one key per
> file.  I.e., it might be the case that no one waits for keyslots in practice
> anyway.  But, it seems it would be undesirable for a general Linux kernel
> framework, which could potentially be used with per-file keys or with hardware
> that only has a *very* small number of keyslots.
> 
> Another option would be to allocate the keyslot in blk_mq_get_request(), where
> sleeping is still allowed, but some merging was already done.

That is another good idea.  In blk_mq_get_request we acquire other
resources like the tag, so this would be a very logical places to
acquire the key slots.  We can should also be able to still merge into
the request while it is waiting.
