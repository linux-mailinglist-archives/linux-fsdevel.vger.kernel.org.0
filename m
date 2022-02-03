Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914474A90E6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 23:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355899AbiBCWxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 17:53:37 -0500
Received: from mailout2.w2.samsung.com ([211.189.100.12]:48802 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiBCWxg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 17:53:36 -0500
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220203225335usoutp0262d19d5493a26b0a4c1ffc024bdcfd37~QaIwmwB3Q1807918079usoutp02E;
        Thu,  3 Feb 2022 22:53:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220203225335usoutp0262d19d5493a26b0a4c1ffc024bdcfd37~QaIwmwB3Q1807918079usoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643928815;
        bh=P8iFln1vTh31HniSBbBfkrPb5ufwoscktLN/SPSvqtU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=kBoDDV7N3IWTsJg18SoFSKrC1dKOSdhiESaQXs19kU9Og0dHecHqXM4gFpEYQTVF2
         Uy33O2mEp3wp3jYch8aG5fa6UH1xMESpvkFj3S0h1fQTHqCscCBELkG9ww3WJoCqgw
         Cqf0fn035dp1fxRTFHM5MR/eVOPgC5CjRiyECkbI=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220203225334uscas1p1549c0f1a4417c55925d56f53cbff11c6~QaIwb8ss40411504115uscas1p10;
        Thu,  3 Feb 2022 22:53:34 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id DC.33.10104.EEC5CF16; Thu, 
        3 Feb 2022 17:53:34 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220203225334uscas1p2cb08fa69376935551d792df32e67acdc~QaIwHlPgw1507515075uscas1p2L;
        Thu,  3 Feb 2022 22:53:34 +0000 (GMT)
X-AuditID: cbfec36f-315ff70000002778-d5-61fc5ceecc28
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id CF.C7.09657.EEC5CF16; Thu, 
        3 Feb 2022 17:53:34 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 3 Feb 2022 14:52:43 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Thu, 3 Feb 2022 14:52:43 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Mikulas Patocka <mpatocka@redhat.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Vincent Fu <vincent.fu@samsung.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Topic: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Index: AQHYF5o0LMwUDmubDUu2kNRmd7lMHKyAS6yAgAI7QoCAAAKFAIAAN5GAgAAXUoCAACBXAA==
Date:   Thu, 3 Feb 2022 22:52:43 +0000
Message-ID: <20220203225336.GA255651@bgt-140510-bm01>
In-Reply-To: <alpine.LRH.2.02.2202031532410.12071@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
x-exchange-save: DSA
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F9A50E2F9923F248A4158F3A5B0B3FDC@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xbdRTH+d1e7r3UMC8dwk+qWSRuJrJ1g4zltwXR6BJvNEsWwWl0zl7h
        jvGeLWyiRpnNCA8ZFIGVIo8ij61sA8scz46U7iHrRkoqa61DhgMU2MpjSnl0IOV2Sf/7nN/5
        npPPSX6UQGQgQqjEtAxOlsamhBJC/MqN/wZ2OA672F3KqQjUPFxEoPLZJQGaMTzwRSVFKhJZ
        xjYhvaPSF5kXT2HogW4NQz11JRg633wdQ383/QRQnsmMIddoOCrpuwuQ3h6GevT9OKppHCdR
        gbWDQFen9QLUdHMVQ7bicYCUuUMYGlC7CGT8cwhHzS6ETn+/RKKp3iNviBnLb+8ySoWDZBS1
        93DGcieT0WnzCKat/lvmB1sTYLp/zyaY725fFzCq+X8Jxnq7HWMKFQ6CmRu348yV0UKSmbk6
        RDAtl4fwg5s/EkbFcymJJzjZzmip8FiraoI83rbpC2NFbDY480w+8KMgvRuWrozgbhbR5wEc
        UezLB8J1Po1Bw6km8mno1p12gm9cBPDeTAPJF7MAVmobfPmiF0BdTvXGLoLeBVdu/ixwcyD9
        IVxeegjcIQHdIoTKkuH1BkVtpqOhZukdPvM6nDfWefKH4NzgAuZmnH4ZmgbqN9796UiYm79M
        uNmP/hguducCNwM6CDpvXdjIC+hgaB+rwXjtAFhX2SPgOQiudo0SPL8ER5yTntMC4SXnI4Kf
        lUBbWamHo+G1ajXOcxhs1Ex7HAJgf8UYzs8+Dw3nbLj7Lkh3CuHQ2VrP0v0wt2DCw2J49oLF
        E9ICWLqQQ/JFG4CqZTNWDLaqvczVXiZqLxO1l4nay6QW+GpBcKZcnprAySPSuJMSOZsqz0xL
        kMSlp+rA+i83rRrTO4DVPifpAxgF+gCkBKGB/snlK6zIP57N+pKTpX8qy0zh5H1ATOGhwf6N
        ia2siE5gM7hkjjvOyZ52McovJBuLjQlSpTum11RvTz58K8llLeNqtAWRP65JfYzF1+5HxQ1C
        S75ov2vn3b+6qt5/MrzyR1GcdSqpxejaF/h1PR6y5x9D1x770Vi5Jexx9GDZJ7LX4j+LujSc
        bE/Ip2K3Sqdnm1UHzL0VzrYAaaTm8Ij4m3bJ0kJDmOIxrqnISjxJdt04GBH3XusrJoe4aU05
        Mdm57YhOvmgu7f+qKJmazPklcuJo2a9odvuhKkP2cLh6PrWq27L38z6Ge1F/ZvdzSWqyfHt1
        TENKkoR9MtjSmfwo5uKJFY3UxzbvvJ9h2jLT8ewLfuIcbUDClvbqrBBHuKuQ/cB67nLmYljv
        mz5ReTu27Q3F5cfY8FcFMjn7P9xzj6VUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHOffe3l66lF0e2qMsbkPnomydjRseE8bcHzN3YxnLNGoUcVe5
        gY6HpOWhhggbSqDTYnEQLDgfENhgQSkIhmdoNaQUHFJLa6c4B1XbanlsrrYgTGiX9L/P73e+
        j3OSQ+FhDt5qSpqZzcky2fQoUkBIC7Hy912J8+wmzZM1qOl+GYkqpz04muqf4KHysio+Mk6G
        oB5XNQ+NvPgeQxOaRQx1Xy7H0K9NNzH0uKEWoFLDCIbmH0pQuXYMoB5rNOru0RPoQr2Nj340
        XydRr7MHRw0DCxiynLEBpCoxYeiWep5EunETgZrmETp5ysNHjr6kbZGM8U48oypy8Zmii/cI
        xjicw2gaS0mmta6AOWtpAEzX3UKS+WHoJs5Uzf5DMuahDow5XeQimRmblWDaH57mM1O9JpK5
        0mYivg7fK4hN5tKluZzsg7hvBalXqx7xs1pDjujO7SwEytcUIJiC9IdwcLiDVAABFUY3Adg4
        ovQP0wDerXHyfEMfgPano2DJQtKb4NxAC77EEfQe6PU8BUsinL4igMNazysHRYXTcfCS5wuf
        5hM4q7vs1++CM7f/xZaYoNdBw6265b2Q/giWKLz+ZgsBHSfmlkXB9D74oqtkuRjQK6F78Lfl
        PU6LoHXyAuZ7Aw3run/HfbwC2icWeD5+Gz5w2/k+joDN7mekzyuGloqf/BwHb/ysJnwcDesv
        Of0XCoX6c5OEz7sK9v9iIc6AVeqAanVAlDogSh0QpQ6Iugh4jUCUI5dnpByRb87k8sRyNkOe
        k5kiPnQ4QwNefUfDgi7xOhi3zoi1AKOAFkAKj4oQplXOsWHCZPboMU52+IAsJ52Ta0EkRUSJ
        hMx+1YEwOoXN5tI4LouT/X+KUcGrCzGJQLrrTlW+yptvt2DiLt1W8bir5USxM9m++JL3+sag
        HddWCvftOJorquWfjxQFrSh451nIaGS95Bi2ffdiHF7T2XbyjVMP4iscurJiRXOf+3mewBi7
        Jzyk4qDnU7P3c5HdEbP9+Ft2c/ys8hvbQedC22dK6XjzVJKhseDjG2uPC6uzi3NDzR36BCKo
        c0uo/X5a6mgpZw3+S1KqbMkzTT3WxE8btf2sXihOfw89iWXa16zbOxB9L2tg7Or5GPfm9Rm1
        I7xHb24ZJFs3PH9Xsk1m0Fd+t9aWwM9W4kFbE7xj1VlDiV+9PFQXS+ljFAl/sI6df7f3bvgz
        SZXP3a6hvuyMIuSprGQjLpOz/wEQteiU/QMAAA==
X-CMS-MailID: 20220203225334uscas1p2cb08fa69376935551d792df32e67acdc
CMS-TYPE: 301P
X-CMS-RootMailID: 20220201183359uscas1p2d7e48dc4cafed3df60c304a06f2323cd
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
        <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
        <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
        <CGME20220201183359uscas1p2d7e48dc4cafed3df60c304a06f2323cd@uscas1p2.samsung.com>
        <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
        <20220202060154.GA120951@bgt-140510-bm01>
        <20220203160633.rdwovqoxlbr3nu5u@garbanzo> <20220203161534.GA15366@lst.de>
        <YfwuQxS79wl8l/a0@bombadil.infradead.org>
        <alpine.LRH.2.02.2202031532410.12071@file01.intranet.prod.int.rdu2.redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 03:57:55PM -0500, Mikulas Patocka wrote:
>=20
>=20
> On Thu, 3 Feb 2022, Luis Chamberlain wrote:
>=20
> > On Thu, Feb 03, 2022 at 05:15:34PM +0100, Christoph Hellwig wrote:
> > > On Thu, Feb 03, 2022 at 08:06:33AM -0800, Luis Chamberlain wrote:
> > > > On Wed, Feb 02, 2022 at 06:01:13AM +0000, Adam Manzanares wrote:
> > > > > BTW I think having the target code be able to implement simple co=
py without=20
> > > > > moving data over the fabric would be a great way of showing off t=
he command.
> > > >=20
> > > > Do you mean this should be implemented instead as a fabrics backend
> > > > instead because fabrics already instantiates and creates a virtual
> > > > nvme device? And so this would mean less code?
> > >=20
> > > It would be a lot less code.  In fact I don't think we need any new c=
ode
> > > at all.  Just using nvme-loop on top of null_blk or brd should be all
> > > that is needed.
> >=20
> > Mikulas,
> >=20
> > That begs the question why add this instead of using null_blk with
> > nvme-loop?
> >=20
> >   Luis
>=20
> I think that nvme-debug (the patch 3) doesn't have to be added to the=20
> kernel.
>=20
> Nvme-debug was an old student project that was canceled. I used it becaus=
e=20
> it was very easy to add copy offload functionality to it - adding this=20
> capability took just one function with 43 lines of code (nvme_debug_copy)=
.
>

BTW Kanchan's group has looked at adding copy offload support to the target=
.
I'll let him respond on the timing of upstreaming, I'm under the assumption
that it is also a relatively small patch to the target code.

> I don't know if someone is interested in continuing the development of=20
> nvme-debug. If yes, I can continue the development, if not, we can just=20
> drop it.
>=20
> Mikulas
> =
