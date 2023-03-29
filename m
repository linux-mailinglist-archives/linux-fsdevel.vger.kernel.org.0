Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF8E6CD837
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 13:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC2LKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 07:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjC2LKj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:10:39 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096651FDB
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 04:10:34 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230329111033epoutp03a7954a2700737ea14d3774fac6ea5bd1~Q31ivYOne3195931959epoutp03R
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 11:10:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230329111033epoutp03a7954a2700737ea14d3774fac6ea5bd1~Q31ivYOne3195931959epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680088233;
        bh=Xk+nH/TKHZ2otMFv1dPDB9/vDYwI4owFqXLVfiYqr5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g35lzFk+iQunlTGitO0HvRTJl27P6Md5l9mLwEqXLuLft2hFy6C45P9A+flSaXfZi
         aP8SJv4tXAPTqt0WxXJ3IwT4HRG8xfpHzMX5OnczXxW6aLeMzByq3o8nuQ/A8miQmQ
         f/eHP8DcJzJ32BeRJU3pGzdxJaz6lIHXrbpgdjv0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230329111032epcas5p4d136e23b1114a6a012bd1dcdce095e8d~Q31iEcnFw1699116991epcas5p4P;
        Wed, 29 Mar 2023 11:10:32 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PmkP23Ghsz4x9Q1; Wed, 29 Mar
        2023 11:10:30 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.74.55678.6AC14246; Wed, 29 Mar 2023 20:10:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230329104226epcas5p1a6c8373304372ec2c02573ac59a7e8d8~Q3dAAFZeX0051700517epcas5p1L;
        Wed, 29 Mar 2023 10:42:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230329104226epsmtrp142b1ba35c822a3a46a762710d3a53155~Q3c--A1i30671106711epsmtrp1c;
        Wed, 29 Mar 2023 10:42:26 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-f4-64241ca6b704
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.0B.31821.21614246; Wed, 29 Mar 2023 19:42:26 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230329104223epsmtip1c86cdb99c232682a50f105b430b65e80~Q3c80kGNQ2021320213epsmtip1R;
        Wed, 29 Mar 2023 10:42:22 +0000 (GMT)
Date:   Wed, 29 Mar 2023 16:11:42 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 1/9] block: Introduce queue limits for copy-offload
 support
Message-ID: <20230329104142.GA11932@green5>
MIME-Version: 1.0
In-Reply-To: <e725768d-19f5-a78a-2b05-c0b189624fea@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTH87u3vS2Y6l0B91sZyMpDB8Ja1sLtAkIcwxsekcU5gwtCR69A
        gLbpw6FmjofoYOMxxCnVbMCAOVCYsCFQykiRUQqMRR4GtgFzJVPeA2WZBLBwi9l/n3PO9+S8
        ctgo91sWj50i11AquTSNj9kzmrv2e/vW7PWQCWqvvEw0mG+jRHbxOkrUPSjCiNmuZUBcXHqG
        EmsDgyhhWPiOSYx1tiJEe2UJQlyr60YIfcUThOjenMeIEuMoIKZHdAhhGPch2g29DGKo7XuM
        uFwzzSKMX+UgRIslCxD1s4sMwjTuTAyu9zBDd5NDw5GkbnIAI1t1D1jk4MTPDHJoQEs21uZh
        ZFPVGVI/lomRBTkLVkHuJJNc7BjByMIbtYBs6vuUXGl0JRst80jMS++nBiVTUhmlcqPkiQpZ
        ijwpmB/5TvzheHGAQOgrlBCBfDe5NJ0K5odFxfiGp6RZV8B3+0iaprW6YqRqNf/AG0EqhVZD
        uSUr1JpgPqWUpSlFSj+1NF2tlSf5ySnNIaFA4C+2ChNSkztyN1BlvjDj5sgVViYweeUDOzbE
        RXDueh6SD+zZXFwP4D+3h23GMoB3+6uZtLEC4NXrE8ydlDv9fbZAG4Bf3rrJog0LgH+PFm+r
        GLgnXDpXZWU2G8N9YN8me8vtiIvh/PlcxhajeA0TLt7fljvgx+DF4SnWFnOs8j9ulTFp3gV7
        yyzbejs8HP7Zt4BssRPuDjubexC6oQY7WN95nOYw+M05HUqzA5zpucGimQf/KvrCxqfgtdIf
        sK2eIf45gLrfdYAOhMBccxFKN5cCTUsbtgQX+LW5HqH9L8KCNYutMAe2XNphd/hjQzlG8x44
        +jTLxiQsXq+yLegZgJUPH4Ni8IruueF0z9Wj+XVYrl/GdNbdobgzvLrBpnE/bGg7UA6YtWAP
        pVSnJ1FqsdJfTp36/+KJivRGsP0i3hEt4OHUkp8RIGxgBJCN8h05a6N8GZcjk378CaVSxKu0
        aZTaCMTWW11AeU6JCuuPyTXxQpFEIAoICBBJDgYI+bs5rwb3JnLxJKmGSqUoJaXayUPYdrxM
        RDkoXo9KzZKYKo891herFQ4zH+TO3nUpFzafDq2Ouhfpqhh8z3ApPDb18MmGI8mqHO67C40V
        Gd4eVZxdKsOAZ8dy19m5gezQ0dDYJ79W+zadYMq0GZ5xhpCTjLWgOxGfOS5k/+vtuhl7hrs6
        L2EJIscTwjgtphOFb+/Lf1PgIivQT9+LDfQIv0DJSgrOjtknHA3sdz/qVejk8trIkcUa57hO
        jiI6rFnKdfY3dq/Ulf7GWY07dL+itqXt+Gr/o72rm2lPzTPc6DyvCVGHS4TxhcvRB0/zfPJK
        ois+nFvPlsSXDbeGTpkNvMn21kecEIeY0o5+zpSjGUnPMlne2vjlPPMnPkOdLBV6oyq19D/z
        ynCPqwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCSnK6QmEqKwauvvBbrTx1jtmia8JfZ
        YvXdfjaL14c/MVpM+/CT2eL32fPMFnvfzWa1uHlgJ5PFnkWTmCxWrj7KZLF74Ucmi6P/37JZ
        TDp0jdHi6dVZTBZ7b2lb7Nl7ksXi8q45bBbzlz1ltzg0uZnJYseTRkaLda/fs1icuCVtcf7v
        cVYHcY/LV7w9Zt0/y+axc9Zddo/z9zayeFw+W+qxaVUnm8fmJfUeu282sHn0Nr8DKmi9z+rx
        ft9VNo++LasYPTafrvb4vEnOY9OTt0wB/FFcNimpOZllqUX6dglcGd1rTrAVHNer2PJ/GXsD
        4zyVLkZODgkBE4lzZ06zdjFycQgJ7GCU2PvsLCtEQlJi2d8jzBC2sMTKf8/ZIYoeMUrcfXQX
        rIhFQFXiQ/cSIJuDg01AW+L0fw6QsIiAqcTbnlYWEJtZYBWrxL1duiC2sECIxLQrD9hBbF6g
        8kf7Z0It/sko0TblHitEQlDi5MwnUM1aEjf+vWQCmc8sIC2x/B/YfE4BN4kXp98xgdiiAsoS
        B7YdZ5rAKDgLSfcsJN2zELoXMDKvYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjn0t
        rR2Me1Z90DvEyMTBeIhRgoNZSYT39zWlFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJ
        pCeWpGanphakFsFkmTg4pRqY1s3Qi+PIut/wauYp/2ftceuSPxhM/3RMgNvFySb3mYFUfvs+
        FjG+lmQOeWnn5+dlDy9Yzvj3aVvYgkcB28ReyDyXqwxmiuoXfZZfIOm0V0HuW69y+ler/W2H
        F9lm75515uT/BZuyrmtevBvF2V94MkrViTerPmjba86PmzN8Hy2Ya/1hA1vvj5K2eX5hX94v
        PGJx2POlyFPnicen2HwIa1njHnZe+4XAKqPupu3z2SsOLb1tdyCl+pSZxBFt7Zatx+V+501v
        kGjpuOh74HrNho4d5wvuZhb88fy5p0BI9OeGn2XH9jUlcFi9ZLulkBemqu/inLn16yPhgE6W
        udcLw51n3TrzPmi/aYjSBnVPJZbijERDLeai4kQARjFdhmwDAAA=
X-CMS-MailID: 20230329104226epcas5p1a6c8373304372ec2c02573ac59a7e8d8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_118142_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230327084216epcas5p3945507ecd94688c40c29195127ddc54d
References: <20230327084103.21601-1-anuj20.g@samsung.com>
        <CGME20230327084216epcas5p3945507ecd94688c40c29195127ddc54d@epcas5p3.samsung.com>
        <20230327084103.21601-2-anuj20.g@samsung.com>
        <e725768d-19f5-a78a-2b05-c0b189624fea@opensource.wdc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_118142_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Mar 29, 2023 at 05:40:09PM +0900, Damien Le Moal wrote:
> On 3/27/23 17:40, Anuj Gupta wrote:
> > From: Nitesh Shetty <nj.shetty@samsung.com>
> > 
> > Add device limits as sysfs entries,
> >         - copy_offload (RW)
> >         - copy_max_bytes (RW)
> >         - copy_max_bytes_hw (RO)
> > 
> > Above limits help to split the copy payload in block layer.
> > copy_offload: used for setting copy offload(1) or emulation(0).
> > copy_max_bytes: maximum total length of copy in single payload.
> > copy_max_bytes_hw: Reflects the device supported maximum limit.
> > 
> > Reviewed-by: Hannes Reinecke <hare@suse.de>
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> > ---
> >  Documentation/ABI/stable/sysfs-block | 36 ++++++++++++++++
> >  block/blk-settings.c                 | 24 +++++++++++
> >  block/blk-sysfs.c                    | 64 ++++++++++++++++++++++++++++
> >  include/linux/blkdev.h               | 12 ++++++
> >  include/uapi/linux/fs.h              |  3 ++
> >  5 files changed, 139 insertions(+)
> > 
> > diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> > index c57e5b7cb532..f5c56ad91ad6 100644
> > --- a/Documentation/ABI/stable/sysfs-block
> > +++ b/Documentation/ABI/stable/sysfs-block
> > @@ -155,6 +155,42 @@ Description:
> >  		last zone of the device which may be smaller.
> >  
> >  
> > +What:		/sys/block/<disk>/queue/copy_offload
> > +Date:		November 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RW] When read, this file shows whether offloading copy to
> > +		device is enabled (1) or disabled (0). Writing '0' to this
> 
> ...to a device...
> 
acked

> > +		file will disable offloading copies for this device.
> > +		Writing any '1' value will enable this feature. If device
> 
> If the device does...
> 
acked

> > +		does not support offloading, then writing 1, will result in
> > +		error.
> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_bytes
> > +Date:		November 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RW] While 'copy_max_bytes_hw' is the hardware limit for the
> > +		device, 'copy_max_bytes' setting is the software limit.
> > +		Setting this value lower will make Linux issue smaller size
> > +		copies from block layer.
> 
> 		This is the maximum number of bytes that the block
>                 layer will allow for a copy request. Must be smaller than
>                 or equal to the maximum size allowed by the hardware indicated

Looks good.  Will update in next version. We took reference from discard. 

> 		by copy_max_bytes_hw. Write 0 to use the default kernel
> 		settings.
> 

Nack, writing 0 will not set it to default value. (default value is
copy_max_bytes = copy_max_bytes_hw)

> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_bytes_hw
> > +Date:		November 2022
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RO] Devices that support offloading copy functionality may have
> > +		internal limits on the number of bytes that can be offloaded
> > +		in a single operation. The `copy_max_bytes_hw`
> > +		parameter is set by the device driver to the maximum number of
> > +		bytes that can be copied in a single operation. Copy
> > +		requests issued to the device must not exceed this limit.
> > +		A value of 0 means that the device does not
> > +		support copy offload.
> 
> 		[RO] This is the maximum number of kilobytes supported in a
>                 single data copy offload operation. A value of 0 means that the
> 		device does not support copy offload.
> 

Nack, value is in bytes. Same as discard.

> > +
> > +
> >  What:		/sys/block/<disk>/queue/crypto/
> >  Date:		February 2022
> >  Contact:	linux-block@vger.kernel.org
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 896b4654ab00..350f3584f691 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -59,6 +59,8 @@ void blk_set_default_limits(struct queue_limits *lim)
> >  	lim->zoned = BLK_ZONED_NONE;
> >  	lim->zone_write_granularity = 0;
> >  	lim->dma_alignment = 511;
> > +	lim->max_copy_sectors_hw = 0;
> > +	lim->max_copy_sectors = 0;
> >  }
> >  
> >  /**
> > @@ -82,6 +84,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
> >  	lim->max_dev_sectors = UINT_MAX;
> >  	lim->max_write_zeroes_sectors = UINT_MAX;
> >  	lim->max_zone_append_sectors = UINT_MAX;
> > +	lim->max_copy_sectors_hw = ULONG_MAX;
> > +	lim->max_copy_sectors = ULONG_MAX;
> >  }
> >  EXPORT_SYMBOL(blk_set_stacking_limits);
> >  
> > @@ -183,6 +187,22 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
> >  }
> >  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
> >  
> > +/**
> > + * blk_queue_max_copy_sectors_hw - set max sectors for a single copy payload
> > + * @q:  the request queue for the device
> > + * @max_copy_sectors: maximum number of sectors to copy
> > + **/
> > +void blk_queue_max_copy_sectors_hw(struct request_queue *q,
> > +		unsigned int max_copy_sectors)
> > +{
> > +	if (max_copy_sectors >= MAX_COPY_TOTAL_LENGTH)
> 
> Confusing name as LENGTH may be interpreted as bytes. MAX_COPY_SECTORS would be
> better.
> 

Agreed, we will make MAX_COPY_TOTAL_LENGTH explicit to bytes.
We also check this limit against user payload length which is in bytes(patch 2).
So there is a inconsistency from our end (patch 1 and 2). We will fix this
in next version.

> > +		max_copy_sectors = MAX_COPY_TOTAL_LENGTH;
> > +
> > +	q->limits.max_copy_sectors_hw = max_copy_sectors;
> > +	q->limits.max_copy_sectors = max_copy_sectors;
> > +}
> > +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors_hw);
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
> 

------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_118142_
Content-Type: text/plain; charset="utf-8"


------KU2CxbTk4.ftA7vvsvzLW4bt.-m_7jRTbTuK1k18jgDVn8pS=_118142_--
