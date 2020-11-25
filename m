Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528662C48F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 21:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgKYUUs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 15:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgKYUUs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:20:48 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031C0C0613D4;
        Wed, 25 Nov 2020 12:20:48 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id 62so1541732qva.11;
        Wed, 25 Nov 2020 12:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WSMpmf065AQQA16C6I8/f4Nb2MRTg2VCPV1Y+4Omok0=;
        b=aJS9gum5t6FoUnqNb5tw+YGyXQwCcI0whcaK5FVUTCKP/Za8Nic1QhStF8Oo0uQqh3
         L0EDWq8ANbf//uV8OcD8fNbj84N8b+UQW4VBsfkFxUd2wm2oiv8y2r+1szMOd2mKe/Fb
         jB/Rs1PwcZGahhDQ4EgDOj2cTvwscYJwDpscmIsBSgDUECsxq7ybIy99pl7t6EZACtmJ
         OQNz/R2bfBUvVHHvYpCiFswvCFs5ojv+6B+BefCSzh9yvMi9oo4QZXO9E+nIcmmPD3xg
         TfQqkbB+/KLVpkZTEMiMjSIt1e2srUeyrPlr4iowCq3gB3eKpa4DgFQSorpcJb38qFDX
         0fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WSMpmf065AQQA16C6I8/f4Nb2MRTg2VCPV1Y+4Omok0=;
        b=UGfls1NoonR1K3EVNs6b3dBnMdT06wc+ZVqUMXyRDvq6zdD+KNE617+mLxMc8CbNF3
         09HChV0J5pHYNFZsueknibCzhMFmDqxssmbBHeUpO9VBDCOYJHMtimAq4xGLVGdhyPiS
         o3V5YBZP2AvpKQ7sfoKgCHOu6j5lfC0P7aPSBu3gIMeUipEiGwyZqpCGyORBSfneUUEe
         ovRDsm6L67472FJ55aoqWorCa3Gh4x77IFZj94FdjOdJDbGcVI9MtlbWM4gmKjSlV1ju
         /P1oLNlz++xtAXe/KL10T3ZaQV0nef+0T4+e0smCKEahYPoT26Ll3XUTZT7K3wkD9GMV
         Mrdg==
X-Gm-Message-State: AOAM531M3wS4Q155lV/8vfK1/D8pdpPNiBIDDe+KPDXcdPSGKLGBtGsD
        MGsSJ/tzLm5HAliz2rIMEno=
X-Google-Smtp-Source: ABdhPJxGb7WJXeWnQukVsz1bsvc4/cmOCaTprUECQMhH8XohgWi8umM00Y/Xc9aCwh7r/SWLyDpYFQ==
X-Received: by 2002:a0c:b505:: with SMTP id d5mr4999671qve.59.1606335647135;
        Wed, 25 Nov 2020 12:20:47 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id y44sm486168qtb.50.2020.11.25.12.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:20:46 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 15:20:23 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 25/45] block: reference struct block_device from struct
 hd_struct
Message-ID: <X768hzEnD/ySog5b@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-26-hch@lst.de>
 <X714udEyPuGarVYp@mtj.duckdns.org>
 <20201125164515.GB1975@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125164515.GB1975@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Nov 25, 2020 at 05:45:15PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 24, 2020 at 04:18:49PM -0500, Tejun Heo wrote:
> > Hello,
> > 
> > Please see lkml.kernel.org/r/X708BTJ5njtbC2z1@mtj.duckdns.org for a few nits
> > on the previous version.
> 
> Thanks, I've addressed the mapping_set_gfp mask nit and updated the
> commit log.  As Jan pointed also pointed out I think we do need the
> remove_inode_hash.

Agreed. It'd be nice to replace the stale comment.

> > Also, would it make sense to separate out lookup_sem removal? I *think* it's
> > there to ensure that the same bdev doesn't get associated with old and new
> > gendisks at the same time but can't wrap my head around how it works
> > exactly. I can see that this may not be needed once the lifetimes of gendisk
> > and block_devices are tied together but that may warrant a bit more
> > explanation.
> 
> Jan added lookup_sem in commit 56c0908c855afbb to prevent a three way
> race between del_gendisk and blkdev_open due to the weird bdev vs
> gendisk lifetime rules.  None of that can happen with the new lookup
> scheme.

Understood. I think it'd be worthwhile to note that in the commit log.

Thanks.

-- 
tejun
