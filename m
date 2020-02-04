Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D481521E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 22:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbgBDVVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 16:21:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727566AbgBDVVO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:21:14 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB9E52082E;
        Tue,  4 Feb 2020 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580851273;
        bh=KKB12bjPksD5iDE0UW+8PafWpWM7BZjKsP6ut1aSK0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxmTWCjiquUMY/wLyhosQzPiJUtMVJpf+m1lgxRnrRYaMOAsKMe+YztcbPWFAAUfW
         iI4xdmUCwP/eczU9zRInuGln1AqHPidnOQJDDwEhMnsC7PSPpuh221PGtC+P6WWC9o
         fNNO9pXc/hjVFXtQuzkp0Oh/c6mafWyPFwBNDC30=
Date:   Tue, 4 Feb 2020 13:21:11 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 0/9] Inline Encryption Support
Message-ID: <20200204212110.GA122850@gmail.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
 <20200201005341.GA134917@google.com>
 <20200203091558.GA28527@infradead.org>
 <20200204033915.GA122248@google.com>
 <20200204145832.GA28393@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204145832.GA28393@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 06:58:32AM -0800, Christoph Hellwig wrote:
> On Mon, Feb 03, 2020 at 07:39:15PM -0800, Satya Tangirala wrote:
> > Wouldn't that mean that all the other requests in the queue, even ones that
> > don't even need any inline encryption, also don't get processed until the
> > queue is woken up again?
> 
> For the basic implementation yes.
> 
> > And if so, are we really ok with that?
> 
> That depends on the use cases.  With the fscrypt setup are we still
> going to see unencrypted I/O to the device as well?  If so we'll need
> to refine the setup and only queue up unencrypted requests.  But I'd
> still try to dumb version first and then refine it.

Definitely, for several reasons:

- Not all files on the filesystem are necessarily encrypted.
- Filesystem metadata is not encrypted (except for filenames, but those don't
  use inline encryption).
- Encryption isn't necessarily being used on all partitions on the disk.

It's also not just about unencrypted vs. encrypted, since just because someone
is waiting for one keyslot doesn't mean we should pause all encrypted I/O to the
device for all keyslots.

> 
> > As you said, we'd need the queue to wake up once a keyslot is available.
> > It's possible that only some hardware queues and not others get blocked
> > because of keyslot programming, so ideally, we could somehow make the
> > correct hardware queue(s) wake up once a keyslot is freed. But the keyslot
> > manager can't assume that it's actually blk-mq that's being used
> > underneath,
> 
> Why?  The legacy requet code is long gone.
> 
> > Also I forgot to mention this in my previous mail, but there may be some
> > drivers/devices whose keyslots cannot be programmed from an atomic context,
> > so this approach which might make things difficult in those situations (the
> > UFS v2.1 spec, which I followed while implementing support for inline
> > crypto for UFS, does not care whether we're in an atomic context or not,
> > but there might be specifications for other drivers, or even some
> > particular UFS inline encryption hardware that do).
> 
> We have an option to never call ->queue_rq from atomic context
> (BLK_MQ_F_BLOCKING).  But do you know of existing hardware that behaves
> like this or is it just hypothetical?

Maybe -- check the Qualcomm ICE (Inline Crypto Engine) driver I posted at
https://lkml.kernel.org/linux-block/20200110061634.46742-1-ebiggers@kernel.org/.
The hardware requires vendor-specific SMC calls to program keys, rather than the
UFS standard way.  It's currently blocking, since the code to make the SMC calls
in drivers/firmware/qcom_scm*.c uses GFP_KERNEL and mutex_lock().

I'll test whether it can work in atomic context by using GFP_ATOMIC and
qcom_scm_call_atomic() instead.  (Adding a spinlock might be needed too.)

- Eric
