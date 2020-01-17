Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49FB414057F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 09:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgAQIcZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 03:32:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52620 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgAQIcZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 03:32:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Y9Ep/eeYbaIxxVmlhJEobd6cxmZ0LGEzXqlvP1MkkLE=; b=Tpb+CKn0VYnlSFFimCbPKAl7h
        NZt0oWSreQSTUNdpWR/rpSkjPMbJwbLyrAXp0GXq85PtjBXoFw1Nb17SKs1nb5c+lJDtvebqaP6Nn
        PJ3v9S6vdmcJ81DbbxbqxjY8815Mn4BGtmTDozpzMMRhnF1qTOr+AfAu59zqZPjRG2rgRvwDB1W3D
        I35Kd62ZVVxFsEssqdYG5Ss2a9MA70WeqsGgU19KnbRkhtdLVkZ+munwtJYkhd/4VFVgZAJCn+Ed1
        8mVPnJ5nfpCrYyOiUTPWXC88Fl42EawWl32m5908L829v3FaylM7QIRNMMmEaG0oa96IcftbBfqbS
        vmrXSPRBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isN3F-0004ZQ-RD; Fri, 17 Jan 2020 08:32:21 +0000
Date:   Fri, 17 Jan 2020 00:32:21 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v6 2/9] block: Add encryption context to struct bio
Message-ID: <20200117083221.GA324@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-3-satyat@google.com>
 <20191218212116.GA7476@magnolia>
 <yq1y2v9e37b.fsf@oracle.com>
 <20191218222726.GC47399@gmail.com>
 <yq1fthhdttv.fsf@oracle.com>
 <20200108140730.GC2896@infradead.org>
 <20200108172629.GA232722@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108172629.GA232722@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Eric,

On Wed, Jan 08, 2020 at 09:26:29AM -0800, Eric Biggers wrote:
> The NVMe "key per I/O" draft is heavily flawed, and I don't think it will be
> useful at all in the Linux kernel context.  The problem is that, as far as I
> can tell, it doesn't allow the encryption algorithm and IVs to be selected,
> or even standardized or made discoverable in any way.  It does say that
> AES-256 must be supported, but it doesn't say which mode of operation (i.e.
> it could be something inappropriate for disk encryption, like ECB), nor
> does it say whether AES-256 has to be the default or not, and if it's not
> the default how to discover that and select AES-256.

I've talked to people involved with the TCG side of this spec, where
all the interesting crypto happens.  Currently the plan is to support
KMIP wrapper keys, which specify the exact algorithm and operation
mode, and algorithms and modes for the initial version are planned to
be AES 256/512 XTS.  I also had a chat with an involved person and
they understand the principle that for the inline crypto to be trusted
it needs to be interoperable with (trusted) software algorithms.  So
I don't think it is all doom.

> IV generation is also unspecified, so it
> could be something insecure like always using the same IV.

From talking to one of the initiators of the spec, no it is not intended
to be unspecified, but indeed tied to the LBA (see below).

> Also, since "key per I/O" won't allow selecting IVs, all the encrypted data will
> be tied to its physical location on-disk.  That will make "key per I/O" unusable
> in any case where encrypted blocks are moved without the key, e.g.
> filesystem-level encryption on many filesystems.

File systems don't move data around all that often (saying that with my
fs developer hat on).  In traditional file systems only defragmentation
will move data around, with extent refcounting it can also happen for
dedup, and for file systems that write out of place data gets moved
when parts of a block are rewritten, but in that case a read modify
write cycle is perfomed in the Linux code anyway, so it will go through
the inline encryption engined on the way and the way out.

So in other words - specifying an IV would be useful for some use cases,
but I don't think it is a deal blocker. Even without that is is useful
for block device level encryption, and could have some usefulness for
file system encryption usage.

I think that adding an IV would eventually be useful, but fitting that
into NVMe won't be easy, as you'd need to find a way to specify the IV
for each submission queue entry, which requires growing it, or finding
some way to extend it out of band.

> I've already raised these concerns in the NVMe and TCG Storage working groups,
> and the people working on it refused to make any changes, as they consider "key
> per I/O" to be more akin to the TCG Opal self-encrypting drive specification,
> and not actually intended to be "inline encryption".

While I have my fair share of issues how the spec is developed that
isn't my impression, and at least for the verifyable part I heard
contrary statements.  Feel free to contact me offline to make sure we
can move this into the right direction.

> So let's not over-engineer this kernel patchset to support some broken
> vaporware, please.

Not sharing bio fields for integrity and encryption actually keeps
the patchset simpler (although uses more memory if both options are
enabled).  So my main point here is to not over engineer it for broken
premise that won't be true soon.
