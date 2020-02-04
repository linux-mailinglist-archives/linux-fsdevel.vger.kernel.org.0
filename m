Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179F8151CB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgBDO6e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:58:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35520 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgBDO6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:58:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AfAKF0TXjgF6cXOTs0IpvR8bmv7Y5y+OTvhW+uwkYRk=; b=jToIu+2geApo4hExEekSN8//Dd
        2Rr+plF0PB/eoNuH+8VtbAXDE4wYNJTu1b6Hwfffr8N7g3sN6DCWKoRtmBGp+SWEVhVij0/295+Xm
        3KYG9tLY7mPgoajeQTZgnjfrZ6xrGHk8TzUFisU2KUe3DsgMpPSiIh3ixf2CkKWhkGlX/KElGf4dk
        iZlJn5y8HhHxHYup8syqlIqOrhpMUibNDf2+udSBBTeqGaFZy2Kf3MVIgiD56cJ3muEF4LrO4XjLd
        fU8nHmNSSwQ/sLJtRKRlo+OkWXSuQnCeW7JZuczjuyrd1raDGzt3bW6Mw90hAGtEGOlHripIRvONT
        GICtGCaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyzeq-0001AI-T3; Tue, 04 Feb 2020 14:58:32 +0000
Date:   Tue, 4 Feb 2020 06:58:32 -0800
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
Message-ID: <20200204145832.GA28393@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
 <20200201005341.GA134917@google.com>
 <20200203091558.GA28527@infradead.org>
 <20200204033915.GA122248@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204033915.GA122248@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 03, 2020 at 07:39:15PM -0800, Satya Tangirala wrote:
> Wouldn't that mean that all the other requests in the queue, even ones that
> don't even need any inline encryption, also don't get processed until the
> queue is woken up again?

For the basic implementation yes.

> And if so, are we really ok with that?

That depends on the use cases.  With the fscrypt setup are we still
going to see unencrypted I/O to the device as well?  If so we'll need
to refine the setup and only queue up unencrypted requests.  But I'd
still try to dumb version first and then refine it.

> As you said, we'd need the queue to wake up once a keyslot is available.
> It's possible that only some hardware queues and not others get blocked
> because of keyslot programming, so ideally, we could somehow make the
> correct hardware queue(s) wake up once a keyslot is freed. But the keyslot
> manager can't assume that it's actually blk-mq that's being used
> underneath,

Why?  The legacy requet code is long gone.

> Also I forgot to mention this in my previous mail, but there may be some
> drivers/devices whose keyslots cannot be programmed from an atomic context,
> so this approach which might make things difficult in those situations (the
> UFS v2.1 spec, which I followed while implementing support for inline
> crypto for UFS, does not care whether we're in an atomic context or not,
> but there might be specifications for other drivers, or even some
> particular UFS inline encryption hardware that do).

We have an option to never call ->queue_rq from atomic context
(BLK_MQ_F_BLOCKING).  But do you know of existing hardware that behaves
like this or is it just hypothetical?

> So unless you have strong objections, I'd want to continue programming
> keyslots per-bio for the above reasons.

I'm pretty sure from looking at the code that doing inline encryption
at the bio level is the wrong approach.  That isn't supposed to end
the discussion, but especially things like waking up after a keyslot
becomes available fits much better into the request layer resource
model that is built around queuing limitations, and not the make_request
model that assumes the driver can always queue.
