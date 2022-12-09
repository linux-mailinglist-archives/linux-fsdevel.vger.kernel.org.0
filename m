Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B38BE64AF43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 06:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiLMFRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 00:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiLMFQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 00:16:44 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6570D265C
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 21:16:37 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221213051634epoutp0324ab6cda73926b19a5bbde78c7945076~wQoN4BbqV2379623796epoutp03R
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 05:16:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221213051634epoutp0324ab6cda73926b19a5bbde78c7945076~wQoN4BbqV2379623796epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670908594;
        bh=QxHkV8f0T9aQCziyCAgUI4r43c/a6epYs4DzPhkuUQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XSz+jgkApkhY5IhBuXCJJDIlTj8DZzhcSq7VcDPTJoV1fBTA14POqI+tva/W9DtJ3
         xsaWgO2Fzhno079FIsrMAVkjmzZqZZ+KDA3KwN9SVks79AxOyJbWAuUyUmqr8vMsaq
         1EPf4vCoDDaZEX8ihUL/2GyEIyDAAnuuH6OS9hbU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221213051633epcas5p1acad91d5c441ae413be866ef0006e6c6~wQoNOFeCt1665916659epcas5p1v;
        Tue, 13 Dec 2022 05:16:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NWRYW365cz4x9Q2; Tue, 13 Dec
        2022 05:16:31 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.8C.56352.FAA08936; Tue, 13 Dec 2022 14:16:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221209082824epcas5p1495ea0cd5680031da91328545784dbd7~vEqkTqdW91652516525epcas5p1P;
        Fri,  9 Dec 2022 08:28:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221209082824epsmtrp2d616e2963ae733260207e0c15aec456e~vEqkSaXUc2823228232epsmtrp22;
        Fri,  9 Dec 2022 08:28:24 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-5e-63980aafdd77
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.A8.14392.7A1F2936; Fri,  9 Dec 2022 17:28:23 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20221209082820epsmtip28ebb1c81323d609b832fef7c6b72c53f~vEqhFnDep1568415684epsmtip2z;
        Fri,  9 Dec 2022 08:28:20 +0000 (GMT)
Date:   Fri, 9 Dec 2022 13:46:57 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 02/10] block: Add copy offload support infrastructure
Message-ID: <20221209081657.GA6230@test-zns>
MIME-Version: 1.0
In-Reply-To: <Y5B2pCiYsWb5hdrI@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVCTdRzA/T3bng3uxj3xcvyYqdysRHkbAutHB4WH1VMiUfZH2fGyG49A
        jG3tRQ2vmAolkIJAoqMLpAbICI7JEcgobmqTEcchAY43wQacioC8ZGFAG8/s/O/zfX+7L4fh
        XsrmcdKlKkohFUn4uCuz5fpuv8BG14tiQfUZAjVafmOgU0VrDKQfK8TR055eBuqYK2cha2cb
        hq7ob2Ko/fJjDN3ceISjyeVhJio2DQI0NaDFUMewPzJ2dDFR/7XvcFRRPcVGppLTGDpvvspC
        rbaTAC3pctio4eE8E90a3op618ysaG9Se7cHJ9u0Y2yyd7yJSfb3qElDXR5OXv0xm2y3anDy
        7Ok5u0PuXRY5/8sATp5rrgPkkmE7+XVnAUYabI+weLfDGZFplCiFUvhSUrEsJV2aGsU/cCgp
        JilcKAgJDIlAr/J9paJMKoq/PzY+8K10iX1+vu9RkURtV8WLlEp+8OuRCplaRfmmyZSqKD4l
        T5HIw+RBSlGmUi1NDZJSqtdCBIK94XbH5Iy0618NA7kl8vhE+SCuAaWCfMDhQCIMNszj+cCV
        4060A7iwYWHSwiKAP2lGnMJfANaX5bLygctmxK3iQUAbOgDsNtQ4hWkAJ/42YQ4vJvES/OHB
        DO6ogRP+sHuD41B7Enw4NqZnO5hBaJhwyko42IOIhfnrzbiDuUQA1FZUMWh+AXZdsjEd7GJP
        2d1Xupnei9gJO1vMmKMuJPQucHq1DqO72w81fYXOTj3gA3Mzm2YeXJrrwGk+Bq+U1uJ0cA6A
        2iEtoA1vwFxLIYPuLg2uzM45k26D31oaMFrvBs8+tTn1XNj6/TPeCesbK50FfODgk5NOJuEf
        C7rN/PalYvDCZFYR2KF9bjjtc+VoDoCV7Yu41r47BrEV1qxzaNwNG68FVwJWHfCh5MrMVEoZ
        Lg+VUsf+P7hYlmkAm++x50AruDexEGQCGAeYAOQw+J7cl/0uiN25KaLPsyiFLEmhllBKEwi3
        3+o8g+clltn/S6pKCgmLEIQJhcKwiFBhCN+bqys9I3YnUkUqKoOi5JTiWRzGceFpsPKm3IFL
        q+qS0M9mzJqH7/EFg3HLQvk4yijbsPhvsQSfY1e5VNbo6+4fHi32+2fH6HSs18fLi4Ejx3V7
        TyQXuMasSg4abifWi2tFH3jnbjFyk73rfdpM6yUJOuNQnPcdz6Gc/d37Ck7kjf+ul2RJeQsN
        P7+vMzd/YWs9xKx4xfhnUVKiD3Vv19tmo8+M51o6e1ecDfP9VNt4v1+V0P9RtnXSYo2eZWf6
        j6SvVVfkBdxIaFn+VeB/ubNtsm80tqY/QXinKqgru5bqeSdF2XQwz/P2mx9GH/0kZvabG7xo
        a3vkvwn5j9/NKih7otx+JNr4pc4t+eI2+OKplRxr4pF9HisBGi6fqUwThexhKJSi/wB3NAeB
        pwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzH932ep+eejrOnu6zv1XZtD2M6HTe/vowYY4+hobFk1KlHNXeV
        OxE2ndIPZ5XCcFGULtUWLkvcxbnQL+0kF8UxXPLr+kHDlkp3zfjvvffr/f68//hQuNBO+FPx
        Cfs4dYJCyZB8oraBCQy+OlgQPTeLQddaHuEo7eQIjqoceSQabrPhqL6v0At1WW5jqKLqIYZM
        lwcx9HDMRaK3Q90EKrB2AtRj12OovluKzPXNBOq4c4FExYYeHrKeSsdQfmONF6pzHgXoe9kx
        Hqr+0k+gpu4AZBtp9Frhx+rftJHsbb2Dx9pe3yDYjrZk1lh5nGRrrqSypi4tyeak940HMt54
        sf137SSbe7MSsN+NEjbLcgJjjU4XtnFKBH9pDKeM38+p54RE8eOqc55gSbolKWXvzUALXME6
        4E1Bej5sKugEbi2kTQAOfI6Y8MXQMPIAn9AiWDHay9MB/njGCWBv1iDhBgQ9HZZ+7iV1gKJI
        Wgpbxyi37Usz0OGo8uRxOo2ARZ0vSTcQ0euhbvSmRwvo2VBfXIJPHP2FwfJMJ28C+MDm807P
        AE4HwRejnzD3AE4HwPJRz4D3+G5r+2nMrafS06ClthE7CXz0/7X1/7X1/9qXAF4JxFySRhWr
        0siT5AncAZlGodIkJ8TKohNVRuD5fNCsOnCrckBmBRgFrABSOOMrMBjyo4WCGMXBQ5w6MVKd
        rOQ0VhBAEYyf4ImuOVJIxyr2cXs4LolT/6UY5e2vxazmhmydDxJzzILs1huHfweG5Lpqcd7X
        i62uUF72UOGyvVJ+5h0VsTjcN058/cUk/tqtM5deMVssOfjhXaeG7Ns719SVnn2+Z31AOG/s
        1tN7XX2iuy2mDUTeR3ODeO0P0dAWQaCEWLTjR97KD2HXtJGTg/ybJmWVnUuRyOzsoX5HRpTk
        fk0FHgVW9SgFuvx56fOPhA0Xrv4ZfnDddP47+cfFMw3JaDLIYDrq4tjgXWcsZzI5sfaT/H71
        soiYksZZ5ZtPpIaKOkZU7bmSlgjisaxE0r/JnjKQUdRc2Gfc9uxVS7afgZuy28/m/W3nlxlV
        a6T6/IV7pctt65QGU7xwjCE0cQp5EK7WKP4ATwCvr2gDAAA=
X-CMS-MailID: 20221209082824epcas5p1495ea0cd5680031da91328545784dbd7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_1f9a1_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061017epcas5p246a589e20eac655ac340cfda6028ff35
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061017epcas5p246a589e20eac655ac340cfda6028ff35@epcas5p2.samsung.com>
        <20221123055827.26996-3-nj.shetty@samsung.com> <Y33UAp6ncSPO84XI@T590>
        <20221123100712.GA26377@test-zns> <Y3607N6lDRK6WU7/@T590>
        <20221129114428.GA16802@test-zns> <20221207055400.GA6497@test-zns>
        <Y5B2pCiYsWb5hdrI@T590>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_1f9a1_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Dec 07, 2022 at 07:19:00PM +0800, Ming Lei wrote:
> On Wed, Dec 07, 2022 at 11:24:00AM +0530, Nitesh Shetty wrote:
> > On Tue, Nov 29, 2022 at 05:14:28PM +0530, Nitesh Shetty wrote:
> > > On Thu, Nov 24, 2022 at 08:03:56AM +0800, Ming Lei wrote:
> > > > On Wed, Nov 23, 2022 at 03:37:12PM +0530, Nitesh Shetty wrote:
> > > > > On Wed, Nov 23, 2022 at 04:04:18PM +0800, Ming Lei wrote:
> > > > > > On Wed, Nov 23, 2022 at 11:28:19AM +0530, Nitesh Shetty wrote:
> > > > > > > Introduce blkdev_issue_copy which supports source and destination bdevs,
> > > > > > > and an array of (source, destination and copy length) tuples.
> > > > > > > Introduce REQ_COPY copy offload operation flag. Create a read-write
> > > > > > > bio pair with a token as payload and submitted to the device in order.
> > > > > > > Read request populates token with source specific information which
> > > > > > > is then passed with write request.
> > > > > > > This design is courtesy Mikulas Patocka's token based copy
> > > > > > 
> > > > > > I thought this patchset is just for enabling copy command which is
> > > > > > supported by hardware. But turns out it isn't, because blk_copy_offload()
> > > > > > still submits read/write bios for doing the copy.
> > > > > > 
> > > > > > I am just wondering why not let copy_file_range() cover this kind of copy,
> > > > > > and the framework has been there.
> > > > > > 
> > > > > 
> > > > > Main goal was to enable copy command, but community suggested to add
> > > > > copy emulation as well.
> > > > > 
> > > > > blk_copy_offload - actually issues copy command in driver layer.
> > > > > The way read/write BIOs are percieved is different for copy offload.
> > > > > In copy offload we check REQ_COPY flag in NVMe driver layer to issue
> > > > > copy command. But we did missed it to add in other driver's, where they
> > > > > might be treated as normal READ/WRITE.
> > > > > 
> > > > > blk_copy_emulate - is used if we fail or if device doesn't support native
> > > > > copy offload command. Here we do READ/WRITE. Using copy_file_range for
> > > > > emulation might be possible, but we see 2 issues here.
> > > > > 1. We explored possibility of pulling dm-kcopyd to block layer so that we 
> > > > > can readily use it. But we found it had many dependecies from dm-layer.
> > > > > So later dropped that idea.
> > > > 
> > > > Is it just because dm-kcopyd supports async copy? If yes, I believe we
> > > > can reply on io_uring for implementing async copy_file_range, which will
> > > > be generic interface for async copy, and could get better perf.
> > > >
> > > 
> > > It supports both sync and async. But used only inside dm-layer.
> > > Async version of copy_file_range can help, using io-uring can be helpful
> > > for user , but in-kernel users can't use uring.
> > > 
> > > > > 2. copy_file_range, for block device atleast we saw few check's which fail
> > > > > it for raw block device. At this point I dont know much about the history of
> > > > > why such check is present.
> > > > 
> > > > Got it, but IMO the check in generic_copy_file_checks() can be
> > > > relaxed to cover blkdev cause splice does support blkdev.
> > > > 
> > > > Then your bdev offload copy work can be simplified into:
> > > > 
> > > > 1) implement .copy_file_range for def_blk_fops, suppose it is
> > > > blkdev_copy_file_range()
> > > > 
> > > > 2) inside blkdev_copy_file_range()
> > > > 
> > > > - if the bdev supports offload copy, just submit one bio to the device,
> > > > and this will be converted to one pt req to device
> > > > 
> > > > - otherwise, fallback to generic_copy_file_range()
> > > >
> > > 
> > 
> > Actually we sent initial version with single bio, but later community
> > suggested two bio's is must for offload, main reasoning being
> 
> Is there any link which holds the discussion?
> 

This[1] is the starting thread for LSF/MM which Chaitanya organized and it
was a conference call. Also in 2022 LSM/MM there was a discussion on copy
topic as well. One of the main conclusion was using 2 bio's as must have.

Bart has summarized previous copy efforts[2] and Martin too [3],
which might be of help in understanding why 2 bio's are must.

> > dm-layer,Xcopy,copy across namespace compatibilty.
> 
> But dm kcopy has supported bdev copy already, so once your patch is
> ready, dm kcopy can just sends one bio with REQ_COPY if the device
> supports offload command, otherwise the current dm kcopy code can work
> as before.
> 
> > 
> > > We will check the feasibilty and try to implement the scheme in next versions.
> > > It would be helpful, if someone in community know's why such checks were
> > > present ? We see copy_file_range accepts only regular file. Was it
> > > designed only for regular files or can we extend it to regular block
> > > device.
> > >
> > 
> > As you suggested we were able to integrate def_blk_ops and
> > run with user application, but we see one main issue with this approach.
> > Using blkdev_copy_file_range requires having 2 file descriptors, which
> > is not possible for in kernel users such as fabrics/dm-kcopyd which has
> > only bdev descriptors.
> > Do you have any plumbing suggestions here ?
> 
> What is the fabrics kernel user? 

In fabrics setup we are exposing target side NVMe device, to host as
copy offload capable device, irrespective of target device's capability.
This will enable sending copy offload command from host.
From target side, if device doesn't support offload then we emulate.
This way we will avoid data copy over the network.

> Any kernel target code(such as nvme target)
> has file/bdev path available, vfs_copy_file_range() should be fine.
> 

From target side, fabrics device can be created in 2 ways,
1. file backed device: In this setup we get file descriptor. In fact in our
patches[4] are using vfs_copy_file_range to offload copy.
2. block backed device: Here we have only blockdev descriptor.
This setup we can't use vfs_copy_file_range since we are missing file
descriptor.
Your input on how we can plumb blkdev_copy_file_range with bdev would help.

> Also IMO, kernel copy user shouldn't be important long term, especially if
> io_uring copy_file_range() can be supported, forwarding to userspace not
> only gets better performance, but also cleanup kernel related copy code
> much.
>

Using uring is valid if consumer of copy_file_range is userspace.
But there are many possible in-kernel user of copy, such as dm-kcopyd,
garbage collection case such as F2FS GC, also fabrics as explained above.
We can't use uring from these layers.

Present implementation of vfs_copy_file_range(CFR) lacks
a. async implementation, which helps in nvme over fabrics
b. multi range(src,dst pair) support
So here we see going to blkdev_copy_file_range actually regress our present
result. But we do see a goodness of using mature vfs_copy_file_range for
emulation.

[1] https://lore.kernel.org/linux-nvme/BYAPR04MB49652C4B75E38F3716F3C06386539@BYAPR04MB4965.namprd04.prod.outlook.com/
[2] https://github.com/bvanassche/linux-kernel-copy-offload
[3] https://oss.oracle.com/~mkp/docs/xcopy.pdf
[4] https://lore.kernel.org/lkml/20221130041450.GA17533@test-zns/T/#Z2e.:..:20221123055827.26996-7-nj.shetty::40samsung.com:1drivers:nvme:target:io-cmd-file.c

Thanks,
Nitesh Shetty

------dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_1f9a1_
Content-Type: text/plain; charset="utf-8"


------dP7Qx9dcwq0e3k-gT5OC2TLFeuRm6-MlOT8i1nwxNxOSTL6J=_1f9a1_--
