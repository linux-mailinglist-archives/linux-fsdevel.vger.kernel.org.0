Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FF64A8CB0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 20:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353856AbiBCTrm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 14:47:42 -0500
Received: from mailout2.w2.samsung.com ([211.189.100.12]:22904 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353832AbiBCTrj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:47:39 -0500
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220203194738usoutp0276ca491d2bad9d5cad29a04a45dee11e~QXmaResRH2527725277usoutp02N;
        Thu,  3 Feb 2022 19:47:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220203194738usoutp0276ca491d2bad9d5cad29a04a45dee11e~QXmaResRH2527725277usoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643917658;
        bh=EmNkfNLA9li219ObPpJv7EjtIObDOw354ofHnjfwxh4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GsKNqeT7X952S/Z1/upCE3z1tG1lr2GQAxGw67VV/wqS55PiObsCJzdDnegWFwpza
         dVyA7h8uyVDyLOUJfO1iXA8pLDKrchAdd36PVsYbrxD6JWNLkWmvxygak56LcMPGE2
         Xf2ITxiHTGW2G1wjOp4vknZcz9znhfdzsJw9qaaE=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220203194738uscas1p133248633a850023d76c05f5fdc1b8fa2~QXmZ_kaDi3190531905uscas1p1o;
        Thu,  3 Feb 2022 19:47:38 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 33.6C.10104.A513CF16; Thu, 
        3 Feb 2022 14:47:38 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220203194737uscas1p2d97def35481ec0e965e6dc6a15398e77~QXmZdB1uH2691326913uscas1p2H;
        Thu,  3 Feb 2022 19:47:37 +0000 (GMT)
X-AuditID: cbfec36f-315ff70000002778-cb-61fc315a6040
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 8B.17.10042.9513CF16; Thu, 
        3 Feb 2022 14:47:37 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 3 Feb 2022 11:46:47 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Thu, 3 Feb 2022 11:46:47 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        "Vincent Fu" <vincent.fu@samsung.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
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
Thread-Index: AQHYF5o0LMwUDmubDUu2kNRmd7lMHKyAS6yAgAI7QoCAAAKFAIAAN5GAgAADtYA=
Date:   Thu, 3 Feb 2022 19:46:47 +0000
Message-ID: <20220203194735.GA249665@bgt-140510-bm01>
In-Reply-To: <YfwuQxS79wl8l/a0@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
x-exchange-save: DSA
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9A646861F09CB74EAB344C543E341AB7@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHd+69vb2UgJfH5Mz+MUu2acShKDYnyHDZFnP3iHFbMIMtjm7e
        AJFnW6Z1m7zCXGEdUJFhYZMCKQgKDBl20scAERGd3WoBO3USAQNMKDjpysvRXkz63+d3vt/v
        yfd3cig8sIvcQCWnyVlpmiQllBQQHVee3Hw1PmJJsj33exI13S0mUbnDhaOZrgc8pC6u4CPr
        qD8yTlfykOW/XAw9aHuKIUONGkNnm3ox9LC+FiDlgAVDSyMRSN09CJDRHoYMxn4CndGN8VHR
        kJ5Epikjjur7VjA0XDIGUOm3Ngz9rlkiUc89G4GalhAq+M7FR5Pmg68LGeutd5nS/Gk+k199
        h2CsN7KYtkYlyVyoy2ZODtcDpvN2DsnkXe/FmYq5f0lm6PpFjFHlT5PM7JidYDpGVHxmxmQj
        mZZ2G7E/KF4QfYhNSf6ClW6LSRAk3TEUYhnN1NH+wlIyB+jJQuBDQToSDhovrbKACqTPArjc
        psXdQiBdgMGfrKJnprzWWwRnOg/gwP0xHjc4AHwy2wm4hBnAE0OZbibp7XCx72fPTcH0Zmgq
        UWHuAE63C2DnuHJVoKggOgZqXe9wnj1wrqdmzb8PrszZeW4m6JegtfRHD/vRu2Cf8qrH40OL
        4R83zmBuBvR66Lx2zsM4HQLto9w5pANgTaUB53g9XLk0srayCP7tnOBzHAybnY9ILhsOh0+V
        rXEMrFqyERyHQZ12Cuc6BMD+06MEl30BdjUMe14F0r8KoHKihccJb8GZyco1kxAu39VhnKkR
        wLL5b/jccAHAigULVgJe1ng113g10Xg10Xg10Xg1qQa8RhCSJZOlJrKyHWnskXCZJFWWlZYY
        /nl6ahtY/eUDKz3pejBknw3vBhgFugGk8NBgv8Pli5JAv0MSxTFWmv6pNCuFlXUDIUWEhvjp
        klslgXSiRM4eZtkMVvpMxSifDTmYULx7wREgFxclUJnChwdUC1vfdlw+ZfksM1ahysYi9Tno
        r/7H2Ea5bkIdG3Hf9Bpubr44JfyqN1oo+uC4M0qi+m3yzeVUOPbhjriQcq1Pg2rzldppNoLX
        N1+VcPl8XoelrG45LS5KfHA4u1nvFMvNRXrtoCNDYR5v3fr1kczxj/0LWubbTj7+aN/TxSh1
        00K8uvNY/dWaSNUrorD9zzfEtT/aa3KIN61L8hXUmdO3GRJHX1Rs2RVNHff7hA7yNf7zXmxd
        9Q/PubpSemodhGI3Xewfadlp2xjkm1sANq2zB4iqvnzjWo2os2/nLwf8/7xnA+8n7Dm99/Y5
        V8iJm8VHoxdDCVmSJGILLpVJ/ge4EQJSVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0xTVxjGd+69vb00q1wKyBGnid1czMwqOFxODAOXDL2iMo2ZCbC03sgV
        CFC0hU3dvwpZEIRAmRDW1UEFC1LogG0KWUGhMGRo1dRKrdXBaLOgG3/NKrOBWa5L+u13znme
        3/t+OBQumRJEU9nKAk6lZHOlpIjI1mDat1Nj/WzMP96tyPSwkkS1s4s4mumfFKDqyjohsntW
        od7p7wTo9rPTGJrsWsaQ5UI1hi6ZhjD0Z3MjQKWjtzHkn4hF1QP3AOp1bUaW3hEC1Ru9QnR2
        rJtEfU96cdQ8vIQhZ5UXIO0ZB4ZsOj+JrI8cBDL5Efq6fFGIHl+V71jL2O/uYbTF00KmuMFN
        MPabhUxXaynJ/Nj0FfONsxkwv9zXkEzRjSGcqZt/SjJjN65gTEXxNMnMeV0Ec3miQsjM9DlI
        5oefHMT+8DRRfAaXm/0Jp9qScFiU5baUYcfM1ImRMi2pAd1kGQihIB0HizruEmVAREloE4DW
        P1px/jALoN7oFgRSEvoqgO1n1wWYpGPg8+FOPMAR9CbYV1WBBQo43SWCz5Y9L7QUFU4nQMNi
        Mp9JhPPWCy/zKXBp3rXiJOg3oF17foXF9DY4XHod52eVELDp+4IAh9Dvwjs367EAA3o19P3W
        tsI4HQVdHv4e0jRsstzCeY6EU5NLAp43wN99U0KeI6DZ9zfJd2XQWXPuJSdAvd9B8LwZGg1P
        cH6fMDjyrYfgu2tgf4uTqAJrdEGjdUEqXZBKF6TSBakagKAVRBWq1XmZJ9RbldynMjWbpy5U
        ZsqO5Od1gRe/cXTJmt4NHrjmZAMAo8AAgBQujRDn1D5nJeIM9uQpTpWvUBXmcuoBsJYipFHi
        qTStQkJnsgVcDscd41T/v2JUSLQGe3//WLhk3JAy0ZTiuG4r/ywmwrOxeDlmt/zxzkZfUeuC
        K11u86QXbdmZ4zh1ZN36yyNHD/svjYvCVJ+nHkrMN7ftbe/Zt/5no1hvku9uTBhceLg9HpvF
        UsP27LpWkvT6O6dVghlzqHLouKukZZdhfN/9yM7Xki1P3YNtnfFGln60ITdr1RWDYRAJt2X8
        mxkn3Oi2jSJpkkBzL/yDuVCZf1LRUaN3th1/D+v4MNp7pibtVaVdIjt/0ZTUkzhad/Ci71fr
        dmfo0dp0vfOja5Fs+5dhYrmtR5F6YEflx/17H8jqV7e8InizgT4Zb/Yu551bqKvaVH3oi/I7
        qltko+KvxeQ4KaHOYmPfwlVq9j+0L3Ec/AMAAA==
X-CMS-MailID: 20220203194737uscas1p2d97def35481ec0e965e6dc6a15398e77
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
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 11:34:27AM -0800, Luis Chamberlain wrote:
> On Thu, Feb 03, 2022 at 05:15:34PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 03, 2022 at 08:06:33AM -0800, Luis Chamberlain wrote:
> > > On Wed, Feb 02, 2022 at 06:01:13AM +0000, Adam Manzanares wrote:
> > > > BTW I think having the target code be able to implement simple copy=
 without=20
> > > > moving data over the fabric would be a great way of showing off the=
 command.
> > >=20
> > > Do you mean this should be implemented instead as a fabrics backend
> > > instead because fabrics already instantiates and creates a virtual
> > > nvme device? And so this would mean less code?
> >=20
> > It would be a lot less code.  In fact I don't think we need any new cod=
e
> > at all.  Just using nvme-loop on top of null_blk or brd should be all
> > that is needed.
>=20
> Mikulas,
>=20
> That begs the question why add this instead of using null_blk with
> nvme-loop?

I think the only thing missing would be a handler for the simple copy comma=
nd.

>=20
>   Luis=
