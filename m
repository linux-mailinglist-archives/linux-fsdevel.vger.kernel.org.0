Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0B213494E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 18:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgAHR0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 12:26:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729544AbgAHR0c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:26:32 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12EE220705;
        Wed,  8 Jan 2020 17:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578504391;
        bh=ij94aMQ07BTirE2iQNs+dEg6zAm/wuo0VueM7DAIze4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHEjZcS3fZyHeprMzzff0S4Qy7ZcDSwpql0QpUi80QfppmiZQy/P4oJ803uYuwA5v
         x1z5xr+45sSoD3DV04KiQ0p1hjw++k6Xwnn+gSKBhtW5tfWhW2/9kVKkkQ88eIbzQA
         xNgFPef3+sqSoWBVJZJ9OaQn9qe8KNklyQnyAd9c=
Date:   Wed, 8 Jan 2020 09:26:29 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
Message-ID: <20200108172629.GA232722@sol.localdomain>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-3-satyat@google.com>
 <20191218212116.GA7476@magnolia>
 <yq1y2v9e37b.fsf@oracle.com>
 <20191218222726.GC47399@gmail.com>
 <yq1fthhdttv.fsf@oracle.com>
 <20200108140730.GC2896@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108140730.GC2896@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 08, 2020 at 06:07:30AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 18, 2019 at 07:47:56PM -0500, Martin K. Petersen wrote:
> > Absolutely. That's why it's a union. Putting your stuff there is a
> > prerequisite as far as I'm concerned. No need to grow the bio when the
> > two features are unlikely to coexist. We can revisit that later should
> > the need arise.
> 
> With NVMe key per I/O support some form of inline encryption and PI are
> very likely to be used together in the not too far future.

The NVMe "key per I/O" draft is heavily flawed, and I don't think it will be
useful at all in the Linux kernel context.  The problem is that, as far as I can
tell, it doesn't allow the encryption algorithm and IVs to be selected, or even
standardized or made discoverable in any way.  It does say that AES-256 must be
supported, but it doesn't say which mode of operation (i.e. it could be
something inappropriate for disk encryption, like ECB), nor does it say whether
AES-256 has to be the default or not, and if it's not the default how to
discover that and select AES-256.  IV generation is also unspecified, so it
could be something insecure like always using the same IV.

So effectively the NVMe encryption will be unspecified, untestable, and
unverifiable.  That means that vendors are likely to implement it insecurely,
similar to how they're implementing self-encrypting drives insecurely [1].
(Granted, there are some reasons to think that vendors are less likely to screw
up key per I/O.  But inevitably some will still get it wrong.)

[1] https://www.ieee-security.org/TC/SP2019/papers/310.pdf

Also, since "key per I/O" won't allow selecting IVs, all the encrypted data will
be tied to its physical location on-disk.  That will make "key per I/O" unusable
in any case where encrypted blocks are moved without the key, e.g.
filesystem-level encryption on many filesystems.

And since the way that dm-crypt and fscrypt work is that you select which
algorithm and IV generator you want to use, to even use NVMe "key per I/O" with
them we'd have to add magic settings that say to use some unspecified
hardware-specific encryption format, which could be completely insecure.  As one
of the fscrypt maintainers I'd be really hesistant to accept any such patch, and
I think the dm-crypt people would feel the same way.

I've already raised these concerns in the NVMe and TCG Storage working groups,
and the people working on it refused to make any changes, as they consider "key
per I/O" to be more akin to the TCG Opal self-encrypting drive specification,
and not actually intended to be "inline encryption".

So let's not over-engineer this kernel patchset to support some broken
vaporware, please.

- Eric
