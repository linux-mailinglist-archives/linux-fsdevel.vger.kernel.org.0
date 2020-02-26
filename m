Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D07F16F4C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 02:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgBZBMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 20:12:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729777AbgBZBMJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:12:09 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 877AA20732;
        Wed, 26 Feb 2020 01:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582679528;
        bh=0pd2L0V39Irh1qfpzk47vY1wiZKCu530Z4tcoP6sR2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4o0t5Q2Gvf1XVm3IJMpJ1c3Ex2gM86Q5S6WwXI30ghOQkr8vYWiOSgdos5lz3xCC
         C21NH2ik1z+wUtTahz4GwWJZGKKqJi0BDgszJz+gl26eL5OfQCP8N/vPJyxpOnTLAr
         GyErSh1DcqsYjcY6A7tig9yx1gAG2DSyidmA9z7I=
Date:   Tue, 25 Feb 2020 17:12:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: Re: [PATCH v7 6/9] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200226011206.GD114977@gmail.com>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-7-satyat@google.com>
 <20200221172244.GC438@infradead.org>
 <20200221181109.GB925@sol.localdomain>
 <1582465656.26304.69.camel@mtksdccf07>
 <20200224233759.GC30288@infradead.org>
 <1582615285.26304.93.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582615285.26304.93.camel@mtksdccf07>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 25, 2020 at 03:21:25PM +0800, Stanley Chu wrote:
> Hi Christoph,
> 
> On Mon, 2020-02-24 at 15:37 -0800, Christoph Hellwig wrote:
> > On Sun, Feb 23, 2020 at 09:47:36PM +0800, Stanley Chu wrote:
> > > Yes, MediaTek is keeping work closely with inline encryption patch sets.
> > > Currently the v6 version can work well (without
> > > UFSHCD_QUIRK_BROKEN_CRYPTO quirk) at least in our MT6779 SoC platform
> > > which basic SoC support and some other peripheral drivers are under
> > > upstreaming as below link,
> > > 
> > > https://patchwork.kernel.org/project/linux-mediatek/list/?state=%
> > > 2A&q=6779&series=&submitter=&delegate=&archive=both
> > > 
> > > The integration with inline encryption patch set needs to patch
> > > ufs-mediatek and patches are ready in downstream. We plan to upstream
> > > them soon after inline encryption patch sets get merged.
> > 
> > What amount of support do you need in ufs-mediatek?  It seems like
> > pretty much every ufs low-level driver needs some kind of specific
> > support now, right?  I wonder if we should instead opt into the support
> > instead of all the quirking here.
> 
> The patch in ufs-mediatek is aimed to issue vendor-specific SMC calls
> for host initialization and configuration. This is because MediaTek UFS
> host has some "secure-protected" registers/features which need to be
> accessed/switched in secure world. 
> 
> Such protection is not mentioned by UFSHCI specifications thus inline
> encryption patch set assumes that every registers in UFSHCI can be
> accessed normally in kernel. This makes sense and surely the patchset
> can work fine in any "standard" UFS host. However if host has special
> design then it can work normally only if some vendor-specific treatment
> is applied.
> 
> I think one of the reason to apply UFSHCD_QUIRK_BROKEN_CRYPTO quirk in
> ufs-qcom host is similar to above case.

So, I had originally assumed that most kernel developers would prefer to make
the UFS crypto support opt-out rather than opt-in, since that matches the normal
Linux way of doing things.  I.e. normally the kernel's default assumption is
that devices implement the relevant standard, and only when a device is known to
deviate from the standard does the driver apply quirks.

But indeed, as we've investigated more vendors' UFS hardware, it seems that
everyone has some quirk that needs to be handled in the platform driver:

  - ufs-qcom (tested on DragonBoard 845c with upstream kernel) needs
    vendor-specific crypto initialization logic and SMC calls to set keys

  - ufs-mediatek needs the quirks that Stanley mentioned above

  - ufs-hisi (tested on Hikey960 with upstream kernel) needs to write a
    vendor-specific register to use high keyslots, but even then I still
    couldn't get the crypto support working correctly.

I'm not sure about the UFS controllers from Synopsys, Cadence, or Samsung, all
of which apparently have implemented some form of the crypto support too.  But I
wouldn't get my hopes up that everyone followed the UFS standard precisely.

So if there are no objections, IMO we should make the crypto support opt-in.

That makes it even more important to upstream the crypto support for specific
hardware like ufs-qcom and ufs-mediatek, since otherwise the ufshcd-crypto code
would be unusable even theoretically.  I'm volunteering to handle ufs-qcom with
https://lkml.kernel.org/linux-block/20200110061634.46742-1-ebiggers@kernel.org/.
Stanley, could you send out ufs-mediatek support as an RFC so people can see
better what it involves?

- Eric
