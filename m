Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4906270D4ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 09:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235175AbjEWH2G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 03:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbjEWH1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 03:27:36 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179FB18B
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 00:27:16 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230523072712epoutp020f5c713cf4a4b0995ec9ba4db52c2411~htRPO1mEz0235102351epoutp02V
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 07:27:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230523072712epoutp020f5c713cf4a4b0995ec9ba4db52c2411~htRPO1mEz0235102351epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684826832;
        bh=rQUWV+UuU8XdtuuAO2kK75l817gnXAls71mYpkwqbKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rd0kdCSmYZr67SPWymQnp/lXDpuZmcSnHRG3LO9f9TA+fUUgdjeFrsHuoe5mc9Yy1
         GdRy6XVjLol3o3VRy/fkc3I+J0iqG5HWswsyMPuYrgWeO7Eu8iSMnOg3OwVBA7IBIC
         mM/fSzsYPLootr29I9OAAjqfpAhtIrEJF15T3j2w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230523072711epcas5p3e6c66813d663ca942b50297a815c37c9~htROn8T0c2669626696epcas5p34;
        Tue, 23 May 2023 07:27:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QQQqx6tSCz4x9QF; Tue, 23 May
        2023 07:27:09 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.2A.16380.DCA6C646; Tue, 23 May 2023 16:27:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230523071830epcas5p4b6a07de13274dacda50248545c6fcc22~htJo0_Ch21309913099epcas5p4K;
        Tue, 23 May 2023 07:18:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523071829epsmtrp2966efaa9ec6287e6d593034a25c605ad~htJozkfAa1509815098epsmtrp2V;
        Tue, 23 May 2023 07:18:29 +0000 (GMT)
X-AuditID: b6c32a4b-56fff70000013ffc-8a-646c6acdc44b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.16.28392.5C86C646; Tue, 23 May 2023 16:18:29 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230523071826epsmtip18aa6407b5ba7be72746b14764a90e1d9~htJlK9C6B1635116351epsmtip1I;
        Tue, 23 May 2023 07:18:25 +0000 (GMT)
Date:   Tue, 23 May 2023 12:45:28 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v11 1/9] block: Introduce queue limits for copy-offload
 support
Message-ID: <20230523071528.GA15436@green245>
MIME-Version: 1.0
In-Reply-To: <dba0bdea-4f64-8b3c-d366-1046860ccf07@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH87u3vRSysstr+wFpxBKGgEArhf0wgI8p3qwmY26EzcxAhRsK
        lLbrQ3RsgmMuk8XhQBhWnk5BHpMBikgBoc6VR7FCBwgOdAbYIpOnDDYmDGhZ/O9zvud38v2d
        c3JYuL3WyoWVIFXRCqlIwiVsGA13vDx9exIlcbzLv+5ANV0/46igpppAn597gaOqkSwCTd6Z
        Ayhv5m8cPb69C7VMXWSiobZbGGq+lI2hiqq7GKrNYiFt6SyG7q4+I1C2bgCg8X4NhlqGfVBz
        SycDmZoKCDRavcpExWXjVujrwUYCletXMKTLycBQ49gpgK5NTjNQx7ArMr7QM9HyUgGxm0OZ
        fhFSmkc9BHVLM2JFGUdrGVRedhdB1V/1pkw9aqqu8gxB1c1lW1Ed+csMqv5yGqUdSieosxlT
        BDU7Psygplv7Ceqb65UgwuFwUoiYFsXRCjdaGiuLS5DGh3KF70W/FR0YxOP78oPRm1w3qSiZ
        DuXuOxjhG54gWRsS1+2YSKJekyJESiXXPyxEIVOraDexTKkK5dLyOIlcIPdTipKVamm8n5RW
        7eTzeDsC1x7GJIknFjOY8lbJ8e72JyAdnInKBNYsSArgxI8VIBPYsOxJLYBLk3OWYA7AQpMe
        NwfzAA6slIHNksLff2OaE00AVuUYMXMwAWCusZjIBCwWg/SAvYad60iQPrB7lbVe60h6wtyc
        5g0HnJwi4Pf9V4j1hAMZCTVtBmyd2aQvvL3y0MJ2sPPCGGOdrckweGOmD19nJ9IdtjXoN3wh
        +dQappearMy/2wevDJgIMzvAp/rrFt0Fzk+1WPQUWHH+KmEu/gJAzaDG0toueLora8MBJ8VQ
        k1uFmXUOzO26hpl1W3h2ecyis2Fj0Sa7w+qaEouBMxxYPGVhCvZfGCXME5oF8NFNPXYObNG8
        1J3mJT8zb4cl2jlCszY9nHSF5SssM3rBmib/EsCsBM60XJkcTysD5QFSOuX/lcfKkuvAxhV5
        CxvBk8czfjqAsYAOQBbOdWR3pCTF2bPjRCc+oRWyaIVaQit1IHBtWd/iLk6xsrUzlKqi+YJg
        niAoKEgQHBDE577O9gztjLUn40UqOomm5bRisw5jWbukY4xtn5bM2954RewU+cdCM9qbF7V1
        f/q92bL55z/tTVqoN3CWoxl6r5s+573z3zniF5NWyQ7Z7XfA8NpJWa9dPhA26YR7uk1HygOe
        GYrv3/vsB0+ZuwJzTdOEFzk6Hmoo/8iDbn918XTSUc7BodbvOA7SE/9GHOhXThjdktl/epV9
        EHHsgSGs+I1e18hL4X22+XzfkaAQzqHCk0UZX1ZIjcKM92PiP05NtU7cZrAXJtB5an1B5tvq
        xgXy4dJ0n6GNZ7q4vd3jH1Xp2PGZr3CMI9gTkTD3vNMu+K/W1EFFSC3ZZS1SPMhu3Hr0fjkY
        ydt3WN/yoWjL/ijVrL/WS2LzrjORKOYylGIR3xtXKEX/AexofTHOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTVwDH997dvR5sNWeB8YCMuBLiUicKor4xV1SIu6nROdElW6I2cAKT
        ImmLIksYzGXGEhQhY/YEUSMqqGWFjeEAIe2Q0pUpAzYpgqIFNp0I/QMRRru0zTL/+yTfX/98
        WUo2T4ezmdk6QZOtypKjQLrJIo9c3pmRlbbSY1hN6m23KFJZfw2RL0sXKHJ1+CQiTywuQCqm
        XlDkQXsiaZs8w5DBjhuQtF4og6T2aickppMsaTk/DUmn5ykiZebfARkbECFpcywjrW3dNOn7
        qRKRkWsehlRfGpOQ4j+aEbnc5YbEXH4UkmZnESDGJ89oYnVEkNsLXQyZn61E69/g+/q38OL9
        HsTfEIcl/O0RE81XlNkQ33hFwff15PINdccR3+Aqk/DW0/M033jxC75lsBDxJUcnET895qD5
        ZzcHEH/i+zrwYdAngevShKzMQ4JmhXJfYEa1aw7muDPz+otnmULwMEUPAljMxeOqiVFGDwJZ
        GdcM8J0ZPeMXwvClhZ8pPwfhWveExG9yAuwq+hvqAcvSXDTutSd4EXHL8C8e1msP5pbib8pb
        gddOcTMIG2/afT1B3C4sdtihl6XcctzuHoL+zmmAe0uGGL+wGHcbnLSXKU6B77r/8m1RXAS+
        7PYNBHBK/MPUb77OEC4KdzR1wVKwWHwpLb6UFv9PnwNUHQgTcrTqdLU2NicuWzgco1WptbnZ
        6TGpB9UNwPcPhaIZtNZNxZgBZIEZYJaSB0uthw+kyaRpqiP5gubgXk1ulqA1gwiWlodK7+i7
        98q4dJVOOCAIOYLmPxWyAeGF8H23+LXt0VtrU7bWJIbIihNqPqj9R7beeg/UDEWqe7vJ4xCL
        Cf0Zi+QfKaO+Ld5x4R210v6Kpf3dW8y56LwwneQ5Dja2XP/RcpeOfwQHLs7cjxtcNQrnCpKH
        rRW2gH7dWpU2CZ89fkXNrqM+m3Lnrxlf5HgvWVkSmX/6BZ0R9Ti3YK70TPkxp6Jovyup5/pr
        G8FI6IqV+54ORVS8WrB9/PVPU7eFF9XrwjdULdlpNHg+7sxLnsDyNbsS1fFwU+MpAzO7MSH6
        +ao9W1MXxZl2f9U0/+tuO3O2x7jjyJuV48HyJPHtnekPnFXH9hTQm4NMNkP15OfS0VDHQzxe
        +t2h/SkzclqboYpVUBqt6l89Uxt8jgMAAA==
X-CMS-MailID: 20230523071830epcas5p4b6a07de13274dacda50248545c6fcc22
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----kPHV7voJGfjLavpOfz2TLZSfqzzSedGz1kraSQUx2cheHG0X=_139f8_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230522104526epcas5p30d6cb07abadb068a95ab1f90dea42d4e
References: <20230522104146.2856-1-nj.shetty@samsung.com>
        <CGME20230522104526epcas5p30d6cb07abadb068a95ab1f90dea42d4e@epcas5p3.samsung.com>
        <20230522104146.2856-2-nj.shetty@samsung.com>
        <dba0bdea-4f64-8b3c-d366-1046860ccf07@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------kPHV7voJGfjLavpOfz2TLZSfqzzSedGz1kraSQUx2cheHG0X=_139f8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Mon, May 22, 2023 at 08:45:44PM +0900, Damien Le Moal wrote:
> On 5/22/23 19:41, Nitesh Shetty wrote:
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
> >  Documentation/ABI/stable/sysfs-block | 33 ++++++++++++++
> >  block/blk-settings.c                 | 24 +++++++++++
> >  block/blk-sysfs.c                    | 64 ++++++++++++++++++++++++++++
> >  include/linux/blkdev.h               | 12 ++++++
> >  include/uapi/linux/fs.h              |  3 ++
> >  5 files changed, 136 insertions(+)
> > 
> > diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> > index c57e5b7cb532..e4d31132f77c 100644
> > --- a/Documentation/ABI/stable/sysfs-block
> > +++ b/Documentation/ABI/stable/sysfs-block
> > @@ -155,6 +155,39 @@ Description:
> >  		last zone of the device which may be smaller.
> >  
> >  
> > +What:		/sys/block/<disk>/queue/copy_offload
> > +Date:		April 2023
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RW] When read, this file shows whether offloading copy to a
> > +		device is enabled (1) or disabled (0). Writing '0' to this
> > +		file will disable offloading copies for this device.
> > +		Writing any '1' value will enable this feature. If the device
> > +		does not support offloading, then writing 1, will result in
> > +		error.
> 
> will result is an error.
> 

acked

> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_bytes
> > +Date:		April 2023
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RW] This is the maximum number of bytes, that the block layer
> 
> Please drop the comma after block.

you mean after bytes ?, acked.

> 
> > +		will allow for copy request. This will be smaller or equal to
> 
> will allow for a copy request. This value is always smaller...
> 

acked

> > +		the maximum size allowed by the hardware, indicated by
> > +		'copy_max_bytes_hw'. Attempt to set value higher than
> 
> An attempt to set a value higher than...
> 

acked

> > +		'copy_max_bytes_hw' will truncate this to 'copy_max_bytes_hw'.
> > +
> > +
> > +What:		/sys/block/<disk>/queue/copy_max_bytes_hw
> > +Date:		April 2023
> > +Contact:	linux-block@vger.kernel.org
> > +Description:
> > +		[RO] This is the maximum number of bytes, that the hardware
> 
> drop the comma after bytes
> 

acked

> > +		will allow in a single data copy request.
> 
> will allow for
> 

acked

> > +		A value of 0 means that the device does not support
> > +		copy offload.
> 
> Given that you do have copy emulation for devices that do not support hw
> offload, how is the user supposed to know the maximum size of a copy request
> when it is emulated ? This is not obvious from looking at these parameters.
> 

This was little tricky for us as well.
There are multiple limits (such as max_hw_sectors, max_segments,
buffer allocation size), which decide what emulated copy size is.
Moreover this limit was supposed to reflect device copy offload
size/capability.
Let me know if you something in mind, which can make this look better.

> > +
> > +
> >  What:		/sys/block/<disk>/queue/crypto/
> >  Date:		February 2022
> >  Contact:	linux-block@vger.kernel.org
> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index 896b4654ab00..23aff2d4dcba 100644
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
> 
> UINT_MAX is not enough ?

acked

>
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
> > +	if (max_copy_sectors > (COPY_MAX_BYTES >> SECTOR_SHIFT))
> > +		max_copy_sectors = COPY_MAX_BYTES >> SECTOR_SHIFT;
> > +
> > +	q->limits.max_copy_sectors_hw = max_copy_sectors;
> > +	q->limits.max_copy_sectors = max_copy_sectors;
> > +}
> > +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors_hw);
> > +
> >  /**
> >   * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
> >   * @q:  the request queue for the device
> > @@ -578,6 +598,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >  	t->max_segment_size = min_not_zero(t->max_segment_size,
> >  					   b->max_segment_size);
> >  
> > +	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
> > +	t->max_copy_sectors_hw = min(t->max_copy_sectors_hw,
> > +						b->max_copy_sectors_hw);
> > +
> >  	t->misaligned |= b->misaligned;
> >  
> >  	alignment = queue_limit_alignment_offset(b, start);
> > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > index a64208583853..826ab29beba3 100644
> > --- a/block/blk-sysfs.c
> > +++ b/block/blk-sysfs.c
> > @@ -212,6 +212,63 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
> >  	return queue_var_show(0, page);
> >  }
> >  
> > +static ssize_t queue_copy_offload_show(struct request_queue *q, char *page)
> > +{
> > +	return queue_var_show(blk_queue_copy(q), page);
> > +}
> > +
> > +static ssize_t queue_copy_offload_store(struct request_queue *q,
> > +				       const char *page, size_t count)
> > +{
> > +	s64 copy_offload;
> > +	ssize_t ret = queue_var_store64(&copy_offload, page);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (copy_offload && !q->limits.max_copy_sectors_hw)
> > +		return -EINVAL;
> > +
> > +	if (copy_offload)
> > +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> > +	else
> > +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t queue_copy_max_hw_show(struct request_queue *q, char *page)
> > +{
> > +	return sprintf(page, "%llu\n", (unsigned long long)
> > +			q->limits.max_copy_sectors_hw << SECTOR_SHIFT);
> > +}
> > +
> > +static ssize_t queue_copy_max_show(struct request_queue *q, char *page)
> > +{
> > +	return sprintf(page, "%llu\n", (unsigned long long)
> > +			q->limits.max_copy_sectors << SECTOR_SHIFT);
> > +}
> > +
> > +static ssize_t queue_copy_max_store(struct request_queue *q,
> > +				       const char *page, size_t count)
> > +{
> > +	s64 max_copy;
> > +	ssize_t ret = queue_var_store64(&max_copy, page);
> > +
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	if (max_copy & (queue_logical_block_size(q) - 1))
> > +		return -EINVAL;
> > +
> > +	max_copy >>= SECTOR_SHIFT;
> > +	if (max_copy > q->limits.max_copy_sectors_hw)
> > +		max_copy = q->limits.max_copy_sectors_hw;
> > +
> > +	q->limits.max_copy_sectors = max_copy;
> 
> 	q->limits.max_copy_sectors =
> 		min(max_copy, q->limits.max_copy_sectors_hw);
> 
> To remove the if above.

acked

> 
> > +	return count;
> > +}
> > +
> >  static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
> >  {
> >  	return queue_var_show(0, page);
> > @@ -590,6 +647,10 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
> >  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
> >  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
> >  
> > +QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
> > +QUEUE_RO_ENTRY(queue_copy_max_hw, "copy_max_bytes_hw");
> > +QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
> > +
> >  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
> >  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
> >  QUEUE_RW_ENTRY(queue_poll, "io_poll");
> > @@ -637,6 +698,9 @@ static struct attribute *queue_attrs[] = {
> >  	&queue_discard_max_entry.attr,
> >  	&queue_discard_max_hw_entry.attr,
> >  	&queue_discard_zeroes_data_entry.attr,
> > +	&queue_copy_offload_entry.attr,
> > +	&queue_copy_max_hw_entry.attr,
> > +	&queue_copy_max_entry.attr,
> >  	&queue_write_same_max_entry.attr,
> >  	&queue_write_zeroes_max_entry.attr,
> >  	&queue_zone_append_max_entry.attr,
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index b441e633f4dd..c9bf11adccb3 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -295,6 +295,9 @@ struct queue_limits {
> >  	unsigned int		discard_alignment;
> >  	unsigned int		zone_write_granularity;
> >  
> > +	unsigned long		max_copy_sectors_hw;
> > +	unsigned long		max_copy_sectors;
> 
> Why unsigned long ? unsigned int gives you 4G * 512 = 2TB max copy. Isn't that a
> large enough max limit ?

Should be enough. Will update this.

> 
> > +
> >  	unsigned short		max_segments;
> >  	unsigned short		max_integrity_segments;
> >  	unsigned short		max_discard_segments;
> > @@ -561,6 +564,7 @@ struct request_queue {
> >  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> >  #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
> >  #define QUEUE_FLAG_SKIP_TAGSET_QUIESCE	31 /* quiesce_tagset skip the queue*/
> > +#define QUEUE_FLAG_COPY		32	/* supports copy offload */
> 
> Nope. That is misleading. This flag is cleared in queue_copy_offload_store() if
> the user writes 0. So this flag indicates that copy offload is enabled or
> disabled, not that the device supports it. For the device support, one has to
> look at max copy sectors hw being != 0.
>
Agree. Will changing it to "flag to enable/disable copy offload",
will it be better?

> >  
> >  #define QUEUE_FLAG_MQ_DEFAULT	((1UL << QUEUE_FLAG_IO_STAT) |		\
> >  				 (1UL << QUEUE_FLAG_SAME_COMP) |	\
> > @@ -581,6 +585,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
> >  	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
> >  #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
> >  #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
> > +#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
> >  #define blk_queue_zone_resetall(q)	\
> >  	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
> >  #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
> > @@ -899,6 +904,8 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
> >  extern void blk_queue_max_segments(struct request_queue *, unsigned short);
> >  extern void blk_queue_max_discard_segments(struct request_queue *,
> >  		unsigned short);
> > +extern void blk_queue_max_copy_sectors_hw(struct request_queue *q,
> > +		unsigned int max_copy_sectors);
> >  void blk_queue_max_secure_erase_sectors(struct request_queue *q,
> >  		unsigned int max_sectors);
> >  extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);
> > @@ -1218,6 +1225,11 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
> >  	return bdev_get_queue(bdev)->limits.discard_granularity;
> >  }
> >  
> > +static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
> > +{
> > +	return bdev_get_queue(bdev)->limits.max_copy_sectors;
> > +}
> > +
> >  static inline unsigned int
> >  bdev_max_secure_erase_sectors(struct block_device *bdev)
> >  {
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index b7b56871029c..8879567791fa 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -64,6 +64,9 @@ struct fstrim_range {
> >  	__u64 minlen;
> >  };
> >  
> > +/* maximum total copy length */
> > +#define COPY_MAX_BYTES	(1 << 27)
> 
> My brain bit shifter is not as good as a CPU one :) So it would be nice to
> mention what value that is in MB and also explain where this magic value comes from.
> 

Agree. Even I had similar experience :). Will update the comments to
reflect in MB.

About the limit, we faced a dilemma,
1. not set limit: Allow copy which is huge(ssize_t) and which starts
consuming/hogging system resources
2. set limit: what the limit should be

We went with 2, and limit is based on our internel testing,
mainly desktop systems had memory limitation for emulation scenario.
Feel free to suggest, if you have some other thoughts.

Thanks, 
Nitesh Shetty

------kPHV7voJGfjLavpOfz2TLZSfqzzSedGz1kraSQUx2cheHG0X=_139f8_
Content-Type: text/plain; charset="utf-8"


------kPHV7voJGfjLavpOfz2TLZSfqzzSedGz1kraSQUx2cheHG0X=_139f8_--
