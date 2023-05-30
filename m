Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5389D715BFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjE3KmC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 06:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjE3KmA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 06:42:00 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645048F
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 03:41:58 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230530104154epoutp03845435e3ed4ff1a641c5568007651767~j5cO19yi-2517925179epoutp03J
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 10:41:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230530104154epoutp03845435e3ed4ff1a641c5568007651767~j5cO19yi-2517925179epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685443314;
        bh=e4TeZbW46dphNnP8CuNH+8k9Da2YCsqAHU9OQBI1OwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zkbl9mb3ylHviCR0tv364qYFl0onIn9JYq5uc2HBDHdAqdVqUcp6Gz2Fd4IMYNtnf
         Mu6VEFA3JXrbMLNwB6GN3WEPRhqxla30s+fk3p8nsG6Mc9chhqosqGT4TTlXP5lT5m
         kGvwI7+XNzRjr9CNm33p7dQfBbCFzzaXmWgWNv38=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230530104153epcas5p2876a4c3f4e06f0e8e6c882b2fd33ffef~j5cN-Evjq0384103841epcas5p2h;
        Tue, 30 May 2023 10:41:53 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QVpqM4sc2z4x9Pw; Tue, 30 May
        2023 10:41:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.91.44881.FE2D5746; Tue, 30 May 2023 19:41:51 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230530102050epcas5p24882da82b49dc397d3ab694d51658705~j5J2J-5Pj2734627346epcas5p2e;
        Tue, 30 May 2023 10:20:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230530102050epsmtrp2dd099d94863ef09ba0c46326022e7ff0~j5J2IXIeD0209902099epsmtrp2H;
        Tue, 30 May 2023 10:20:50 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-2c-6475d2ef7820
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.4D.28392.20EC5746; Tue, 30 May 2023 19:20:50 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230530102045epsmtip13a67ba165c229e2b47ea3d055ff9f54b~j5Jw0ZBr42118821188epsmtip1C;
        Tue, 30 May 2023 10:20:44 +0000 (GMT)
Date:   Tue, 30 May 2023 15:47:40 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v11 2/9] block: Add copy offload support infrastructure
Message-ID: <20230530101740.lsb3mnt5zx6n7tzn@green245>
MIME-Version: 1.0
In-Reply-To: <ZHTm/v1jTZhcpDei@casper.infradead.org>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO3eXuxcH7LIr0xEyaLMxQXAXlvWgrFBa3UAbm9SZdISu7B2W
        ZB/tZTWhAkFRNOIVhMtOPkJRQEB0cuWhsLwJ2pCQoHiYoJUpAgoKAe2ya+N/n9/3fL9zfr/f
        mUNw+EaeGxGtimW0KjpGiC/i/lC/cqXP6A2dXHSveDkqa2viIENZCY6SMmY5qLg/HUf36scB
        yn34lIOGrgejmgf5Dqi39iqGqk9nYeh8cSOGLqYTqOrUGIYa5+/jKMt0E6CRbj2Gavq8UXVN
        Kxd1VRpwNFAy74BOnB3hoWM9RhwVNs9hyJSdjCHj8AGASu+NclFLnzsyzzY7oJknBjxkGdX1
        SxilH+zAqav6fh5lHrjIpXKz2nDq0jkvqqtDR1UUpeJUxXgWj2rJm+FSlwoSqKreRJxKS36A
        U2MjfVxq9Fo3Tn19uQhsEezYE6RgaDmj9WRUkWp5tCpKJgz7MGJDRIBUJPYRB6I1Qk8VrWRk
        wo2btvi8Ex1jWZLQcy8do7NIW2iWFa5eH6RV62IZT4WajZUJGY08RiPR+LK0ktWponxVTOxa
        sUjkF2AxfrxH0Tx3iavp5X1WdOo3biJowI8CRwKSEpg8Nck5ChYRfLIKwN72Y/ZiHMCDx3OA
        1cUnJwA0l/s/SwzOmB1spkoAu+tPY7biDoBPzhZYCoLgkq/Dw22+VsRJb/jjPGHFJeQb8J/L
        flY3h+zE4bj59kIXAjIMDv9UvpB0JqVwao62ys6kC2w9Psy1sqPl2rmmPzEru5Ivw7wzjxf6
        hOQdR3hldNA+zUZ4JaXSzgL4d/Nlno3d4MSDGru+D57/5hxuCx8EUN+jB7aDYHioLZ1jZQ6p
        gHkp/fbAMpjTVorZ9MUwbWYYs+nO0PjdM34NlpSdtPuXwptTB+xMwUcp1Tzbfu4CWPCVmZsB
        PPTPTad/7j4br4WpD5Mc9JZlcEh3WDhH2HAlLKtcfRI4FIGljIZVRjFsgMZPxez7/70j1coK
        sPCFvEKN4NbQQ18TwAhgApDgCJc4y2hWzneW0/vjGK06QquLYVgTCLA8VSbHzTVSbfmDqtgI
        sSRQJJFKpZJAf6lY+JLzCllrJJ+MomOZPQyjYbTPchjh6JaIrQLp7VXbwgVh4k2dhxbTQ6Kf
        rz1e1WJapokeDvUp3+yxvuNCmsskXFe9jT/o7/iFMXxFocfOF/796K9gHZiX7RRsTWhKfTPk
        frdS0D59YjvrVFu7zTjJe/TBXGZlfnNpwqe7vLy3Nx7+drYz9Ogn63ridQFrZIZEXbggvSek
        qtMznr9Uv3uSei/kbY/fv/w1+62h/Y3v1/U47XYiiz1Kcgqk6EUD0zA9E1In3t94duvyd103
        jsSVu3xfHZCEsoMOP/08i4mPy9cCxfXbdTc2n2nIlLhn1N1qrR95NTdRubbPxTt+h2Z9k1m6
        dyzFsDX3QtL2uF2mgVfubmifyDSoj/S7Tvf+IeSyClrsxdGy9H8wQ8YVywQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCSnC7TudIUg6MLdCzWnzrGbDFn/Ro2
        i6YJf5ktVt/tZ7N4ffgTo8W0Dz+ZLR7st7fY+242q8XNAzuZLPYsmsRksXL1USaLjf0cFrsX
        fmSyOPr/LZvFpEPXGC2eXp3FZLH3lrbFnr0nWSwu75rDZnFvzX9Wi/nLnrJbdF/fwWax/Pg/
        JotDk5uZLHY8aWS0WPf6PYvFiVvSFuf/Hme1+P1jDpuDrMflK94es+6fZfPYOesuu8f5extZ
        PKZNOsXmsXmFlsfls6Uem1Z1snls+jSJ3ePEjN8sHpuX1HvsvtnA5tHb/I7N4+PTWywe7/dd
        ZfPo27KKMUA4issmJTUnsyy1SN8ugSvj6UzRgm7Wirubv7A0ME5g6WLk5JAQMJG4//s8K4gt
        JLCDUeLNv1SIuKTEsr9HmCFsYYmV/56zdzFyAdU8YZT4cOYAWxcjBweLgKpE+yk9EJNNQFvi
        9H8OEFNEQEPizRYjkGpmgetsEpOurQUbLyzgLfHk3AYmkBpeATOJ7/8SISY+Z5SYuOwaWA2v
        gKDEyZlPwE5jBqqZt/khM0g9s4C0xPJ/HCBhTqCL/x17wQRiiwrISMxY+pV5AqPgLCTds5B0
        z0LoXsDIvIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzhtaGntYNyz6oPeIUYmDsZD
        jBIczEoivLaJxSlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJx
        cEo1MHk/vpn7nu+FXZZp20KzgNvLi+xrKy/Z3WYK7SlPcvo5WVvxc4xka95jE3XuY+uPz2jy
        VcqYxF4+LyV9z6MA1vl7dgmmsXZy+mlf6vyuct4r+qOS9cWCawse3I9ifRmY+Ugz7vz+SzGh
        wnn397UJ3X0j735+qdPUGOHlLRuuf1qQNdPsRcnd9E33NdcnN1TL7RPamXfeRH27oGf7fLFL
        r8pZj+YWqzIYVLr2tHZmlLXWvOssf9JuukGVKfdeQ0BktLaRw/boohkrYxj2dlx78OOq7m0Z
        YzbplB9ydflTu2UXz/yn/zRit1Ds04btD/R1F34x+9feebzt/N6N4sLyZ2Icr91wNq9Xe7j7
        kk+nEktxRqKhFnNRcSIAIU/XjIoDAAA=
X-CMS-MailID: 20230530102050epcas5p24882da82b49dc397d3ab694d51658705
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_312ff_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8
References: <20230522104146.2856-1-nj.shetty@samsung.com>
        <CGME20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8@epcas5p2.samsung.com>
        <20230522104146.2856-3-nj.shetty@samsung.com>
        <ZHTm/v1jTZhcpDei@casper.infradead.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_312ff_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 23/05/29 06:55PM, Matthew Wilcox wrote:
>On Mon, May 22, 2023 at 04:11:33PM +0530, Nitesh Shetty wrote:
>> +		token = alloc_page(gfp_mask);
>
>Why is PAGE_SIZE the right size for 'token'?  That seems quite unlikely.
>I could understand it being SECTOR_SIZE or something that's dependent on
>the device, but I cannot fathom it being dependent on the host' page size.

This has nothing to do with block device at this point, merely a place
holder to store information about copy offload such as src sectors, len.
Token will be typecasted by driver to get copy info.
SECTOR_SIZE also should work in this case, will update in next version.

------dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_312ff_
Content-Type: text/plain; charset="utf-8"


------dpMjS_Krfo.HeTa1.nqRY6lfIY-msh.FGO-xMH_14-IlSSmS=_312ff_--
