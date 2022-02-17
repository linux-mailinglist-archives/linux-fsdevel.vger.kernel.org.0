Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CA44BB116
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 06:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiBRFBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 00:01:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiBRFBO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 00:01:14 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE742BC05E;
        Thu, 17 Feb 2022 21:00:46 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220218050045epoutp02c83876128818ae25395bb57d6abea6ff~UyLWH7WAW2920729207epoutp02i;
        Fri, 18 Feb 2022 05:00:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220218050045epoutp02c83876128818ae25395bb57d6abea6ff~UyLWH7WAW2920729207epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1645160445;
        bh=ynd2eDxDUnwe6F3ojujuTTawvN0c+2nk4kTWnIu/dlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=preDF4sdme9KivomaANav12YBXH4hmpjkSNO7FcMAzUz+tLDV5JQJS6dGzJJWfquo
         RbFkKbnV/2WEXiYegV011cUym40GHA211szifeEdkVdyscKykI+ZKnt4nAKChHd+zx
         yLcoVcp1GLCo9WeisnN+u5wLzWsu+oguD89b3ICA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220218050045epcas5p268ef3f00ae6635c8035d5bfbcb14a2ca~UyLVV-p3W2406724067epcas5p2u;
        Fri, 18 Feb 2022 05:00:45 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4K0KJl21lBz4x9Q0; Fri, 18 Feb
        2022 05:00:39 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.F7.05590.6F72F026; Fri, 18 Feb 2022 14:00:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220217130715epcas5p2159ed983a5d32b04709d44b6c155e12e~UlK08gd8s1495614956epcas5p22;
        Thu, 17 Feb 2022 13:07:15 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220217130715epsmtrp106f09d07c77a34cb19ee343b972efdf0~UlK06Jz2_1226812268epsmtrp17;
        Thu, 17 Feb 2022 13:07:15 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-47-620f27f65a47
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.9C.29871.3884E026; Thu, 17 Feb 2022 22:07:15 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220217130710epsmtip197f0af2b21b2d267e9a7e52f7935cd7f~UlKwioze70271602716epsmtip1S;
        Thu, 17 Feb 2022 13:07:10 +0000 (GMT)
Date:   Thu, 17 Feb 2022 18:32:15 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Add Copy offload support
Message-ID: <20220217130215.GB3781@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220214220741.GB2872883@dread.disaster.area>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA01TazBcZxjOd87u2SWDY4N8NJnoarUi2A22n7hURmpOKz+0mWmnmWRYnMFg
        d7NLJG1nECJFZZE20ZXEJVpxGUow29hNGopx60qFEreoS9OktUik7mr3SJt/z/vM87zXebk4
        b4Rjx42WxNNyiTiWT5iyGlucnFxevGURJnhcw0M1nW040gw9Y6PKUSWBLs8t40h/b5KN8pT5
        HFTfNgZQ35Q50s4WsFHvUgqGJus2MaQpycNQeWUrhv4ouwFQU/E8hjK6ejG0NiFErZt/Eyiv
        eQCg6X4VhrQPnZFG28FCfbevEqjw+2kOyvpNTaA7T7U4KmvfwNAvqjUCqadSAGoZ62eh6qd6
        FkqvXQTo/FfLHKRbb2f786m+B0GUaryHoHJTZzlUZwmkflSNcijdWC2LSi0aYVF9PQlUXUUG
        Qd0qTaIuDZYBqmkomaDOdbfiVP7Cc4LKTp0lqPnph6zg3cdjfKJocQQtt6cl4dKIaEmkLz/o
        WEhAiKdIIHQReqF3+PYScRztyz9yNNglMDp2a318+9Pi2IQtKlisUPDd/Hzk0oR42j5Kqoj3
        5dOyiFiZh8xVIY5TJEgiXSV0/CGhQHDQc0sYGhM1sDgMZHk2Z3qUNslAb5kJTLiQ9IANfRUg
        E5hyeWQTgMruNIwJFgDMqhvZDl4AWDe3yskEXKPl1ypnhtcCWLjyNWFIxSNnALyvTDBgFvkm
        bJ1oZxn0BOkMuza5BtqKdIR5eWrc4MXJbgIWpH9p9O4iRTCz4SowYDPyAOxYv8hhsCXs+HaK
        ZcAmpDe8rl42aqxJB/hTY7uxOUheM4XZ4xWAmecIrK0uwxi8Cz5pr+cw2A7+qUznMIYsAJe6
        x7fd+QCm5qQSjOpdeF+zjhnaxskoOHorkKH3wm86q41JcdIcZq9ObRcwg+rrL7EDrKop2k5j
        Cwf+SSGYbVFwMeMEs627AD67scTOAftUrwyn+r8aA51gzW03lbHYPpjaUIAz9GuwbIP7iqII
        EBXAlpYp4iJphafMXUIn/nf5cGlcHTC+2f4gNfj90ZxrM8C4oBlALs63Mpu7ZxbGM4sQn/2M
        lktD5AmxtKIZeG6dLRe3sw6Xbv2pJD5E6OEl8BCJRB5e7iIhf7dZZ+QPYh4ZKY6nY2haRstf
        +jCuiV0yllTS3/tB2mZA0sfnl+uqdra10uURzRasx9NnnFQFJ7qQ+DtovqDLeb0wcNZyeGnd
        666+ssMPn3b2c4wmvWuG11omuzi81S8u6XoPhY7MmITErV0Ix9Mz8qcLd+pOXxhjC1rCPLSl
        YTamgZKJjcQ9Rccbr2yAIqrfd8enQe/Vfxgbp3VvukyPDQxWk/NpDqOamxvtpxoPnNItgWFs
        Jn3donjHJ+H16frS993OYr4BMyT7IH7n0efW4cUBiaIaevBahD7/2MpJvqPi3JBp9Rt/0W9v
        +qt9y0NtFYI076N7lT7Wh61yrZ+4XWm4+KC01P8jDf7zc//qTXXJzJ5Kp5M3V7L4LEWUWLgf
        lyvE/wIvcgCf7wQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTVxjHd+49vb2UVO+KykEzzeoLwwqDuM2TaJzZgjvGKMtmYuLctOgV
        69qCLSjyYcMV5ygio74EK1ZaiCgghiJQgSq0Qi3oRAsOyMQ4XsxGdkEYiyCFrbBlfPvl/8/z
        e54PD0vLykSLWZU2mddplWo5I4HVbvnSSAOZFx89YXkL32hppnF916gIlz7NYfD54XEaDzX2
        irApJ0+Mbzb3AOzrm4edwkURbnt1nMK99mkK19tMFL5W2kThF8WFANdZX1I4s7WNwpPPY3DT
        9B8MNrmeANzfYaaws1uB651eiH21+Qy+fKVfjLN+djD49qCTxsWeKQr/ZJ5ksKPvOMDung6I
        yweHIP6+YgzgE6fGxfih3yPaJCe+9q3E/OwBQ3INgpi02BC5ZX4qJg97KiAxFPwCie9BCrGX
        ZDKksuhbcqazGJC6rnSGfHe/iSZ5I38yJNsgMORlfzf8NHSXZMN+Xq06wuve3bhXcrDb5aWT
        KkNSG8ZyQTq4Pt8IWBZx76HHZQojkLAyrg6gUqsTGEHQP3kYuuK/S89yCLo29UIcYBnXB5Bl
        TBtgyK1ETc89MOBhOAVqnWYD8QJuFTKZHHTASXNtDPrB72ACRQj3ATJW5c/4pdwa5PWfFs8u
        vgNQ0a+//1u8ibwX+mCAaS4cTVoe04EFNLcEFU+xs/EyZKi6OHNbELceWRzjM6MLueWoodpD
        /Qhk5jkm8xyT+X+TeY6pAMASEMYn6TUJGn1MUoyWPxqlV2r0KdqEqH2JGjuYeajVEQ5QUzIc
        5QIUC1wAsbR8gXS4URovk+5XHkvjdYl7dClqXu8CS1goD5W2Gb17ZFyCMpn/mueTeN1/LcUG
        LU6njNvj+zdPTBQNHF6na4UZ9+9mRNxzhi4M39f5vsL/WhMUe2ADyQPBKvuxdhu7LVbkq+1U
        FaYyb6+QbX8tLSzsdQtx608vOjW0dliRVtP+RtWmUNtK1Hwo4vO1ruzN0ugV1w9rLkFT7lGb
        IsP9YUOzYF+6xQCfKKfd1orLR+rOFCAh2nr73PJImbDoq7hlVZWSgo4WPmM0e+TViGndlm+o
        6vxPIqU5936zfXRix+7auNHg/KKuVMTxseFrvoh4JGRt/SvNc7K8wvRlze6rzDuDEzuyVIK2
        0dPRkBiSefNkZdmt+VA94HnWIg62Jm+EndvU4zmPLGd3ugbCPoPVN8o/lkP9QWXMalqnV/4N
        ksnh0b8DAAA=
X-CMS-MailID: 20220217130715epcas5p2159ed983a5d32b04709d44b6c155e12e
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----7Im1L.vKorTl163deO4rxYDAHxkziUWsBhtki-3JrW1s26Hg=_8dd40_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080551epcas5p201d4d85e9d66077f97585bb3c64517c0
References: <CGME20220214080551epcas5p201d4d85e9d66077f97585bb3c64517c0@epcas5p2.samsung.com>
        <20220214080002.18381-1-nj.shetty@samsung.com>
        <20220214220741.GB2872883@dread.disaster.area>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------7Im1L.vKorTl163deO4rxYDAHxkziUWsBhtki-3JrW1s26Hg=_8dd40_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

 Tue, Feb 15, 2022 at 09:08:12AM +1100, Dave Chinner wrote:
> On Mon, Feb 14, 2022 at 01:29:50PM +0530, Nitesh Shetty wrote:
> > The patch series covers the points discussed in November 2021 virtual call
> > [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> > We have covered the Initial agreed requirements in this patchset.
> > Patchset borrows Mikulas's token based approach for 2 bdev
> > implementation.
> > 
> > Overall series supports –
> > 
> > 1. Driver
> > - NVMe Copy command (single NS), including support in nvme-target (for
> > 	block and file backend)
> > 
> > 2. Block layer
> > - Block-generic copy (REQ_COPY flag), with interface accommodating
> > 	two block-devs, and multi-source/destination interface
> > - Emulation, when offload is natively absent
> > - dm-linear support (for cases not requiring split)
> > 
> > 3. User-interface
> > - new ioctl
> > 
> > 4. In-kernel user
> > - dm-kcopyd
> 
> The biggest missing piece - and arguably the single most useful
> piece of this functionality for users - is hooking this up to the
> copy_file_range() syscall so that user file copies can be offloaded
> to the hardware efficiently.
> 
> This seems like it would relatively easy to do with an fs/iomap iter
> loop that maps src + dst file ranges and issues block copy offload
> commands on the extents. We already do similar "read from source,
> write to destination" operations in iomap, so it's not a huge
> stretch to extent the iomap interfaces to provide an copy offload
> mechanism using this infrastructure.
> 
> Also, hooking this up to copy-file-range() will also get you
> immediate data integrity testing right down to the hardware via fsx
> in fstests - it uses copy_file_range() as one of it's operations and
> it will find all the off-by-one failures in both the linux IO stack
> implementation and the hardware itself.
> 
> And, in reality, I wouldn't trust a block copy offload mechanism
> until it is integrated with filesystems, the page cache and has
> solid end-to-end data integrity testing available to shake out all
> the bugs that will inevitably exist in this stack....
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
>

We had planned copy_file_range (CFR) in next phase of copy offload patch series.
Thinking that we will get to CFR when everything else is robust.
But if that is needed to make things robust, will start looking into that.

--
Nitesh Shetty

------7Im1L.vKorTl163deO4rxYDAHxkziUWsBhtki-3JrW1s26Hg=_8dd40_
Content-Type: text/plain; charset="utf-8"


------7Im1L.vKorTl163deO4rxYDAHxkziUWsBhtki-3JrW1s26Hg=_8dd40_--
