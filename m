Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC90316862B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 19:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgBUSLM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 13:11:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUSLL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 13:11:11 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F44208E4;
        Fri, 21 Feb 2020 18:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582308670;
        bh=+Cb4JLP4AzzeUHtnURjqmhLOWjfrHEnJh6ZcrHPfzIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjjOcC1DgFPJx0n0W5Nn6sNEYOnHeArMulQiOCQ4eexPuzr9eFQvsRUz0vIrVkkl1
         YVEguzqY8Go0OdhJE+DDsByPVTEPPqTi3fX5JPN9j33JL7ACiwqD4Atau7D5PoSDQ6
         Z/q7kG6l1EuZMlqYb0P1zmwE4APm4LXlkELsQOzE=
Date:   Fri, 21 Feb 2020 10:11:09 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        Ladvine D Almeida <Ladvine.DAlmeida@synopsys.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>
Subject: Re: [PATCH v7 6/9] scsi: ufs: Add inline encryption support to UFS
Message-ID: <20200221181109.GB925@sol.localdomain>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-7-satyat@google.com>
 <20200221172244.GC438@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221172244.GC438@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:22:44AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 21, 2020 at 03:50:47AM -0800, Satya Tangirala wrote:
> > Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> > encryption additions and the keyslot manager.
> > 
> > Also, introduce UFSHCD_QUIRK_BROKEN_CRYPTO that certain UFS drivers
> > that don't yet support inline encryption need to use - taken from
> > patches by John Stultz <john.stultz@linaro.org>
> > (https://android-review.googlesource.com/c/kernel/common/+/1162224/5)
> > (https://android-review.googlesource.com/c/kernel/common/+/1162225/5)
> > (https://android-review.googlesource.com/c/kernel/common/+/1164506/1)
> 
> Between all these quirks, with what upstream SOC does this feature
> actually work?

It will work on DragonBoard 845c, i.e. Qualcomm's Snapdragon 845 SoC, if we
apply my patchset
https://lkml.kernel.org/linux-block/20200110061634.46742-1-ebiggers@kernel.org/.
It's currently based on Satya's v6 patchset, but I'll be rebasing it onto v7 and
resending.  It uses all the UFS standard crypto code that Satya is adding except
for ufshcd_program_key(), which has to be replaced with a vendor-specific
operation.  It does also add vendor-specific code to ufs-qcom to initialize the
crypto hardware, but that's in addition to the standard code, not replacing it.

DragonBoard 845c is a commercially available development board that boots the
mainline kernel (modulo two arm-smmu IOMMU patches that Linaro is working on),
so I think it counts as an "upstream SoC".

That's all that we currently have the hardware to verify ourselves, though
Mediatek says that Satya's patches are working on their hardware too.  And the
UFS controller on Mediatek SoCs is supported by the upstream kernel via
ufs-mediatek.  But I don't know whether it just works exactly as-is or whether
they needed to patch ufs-mediatek too.  Stanley or Kuohong, can you confirm?

We're also hoping that the patches are usable with the UFS controllers from
Cadence Design Systems and Synopsys, which have upstream kernel support in
drivers/scsi/ufs/cdns-pltfrm.c and drivers/scsi/ufs/ufshcd-dwc.c.  But we don't
currently have a way to verify this.  But in 2018, both companies had tried to
get the UFS v2.1 standard crypto support upstream, so presumably they must have
implemented it in their hardware.  +Cc the people who were working on that.

- Eric
