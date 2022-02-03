Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795224A8CBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Feb 2022 20:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353872AbiBCTvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 14:51:50 -0500
Received: from mailout1.w2.samsung.com ([211.189.100.11]:10620 "EHLO
        mailout1.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353866AbiBCTvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:51:48 -0500
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220203195147usoutp01676c4aa0ce25a63250015b1c0745c326~QXqCKE-ox2175821758usoutp01c;
        Thu,  3 Feb 2022 19:51:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220203195147usoutp01676c4aa0ce25a63250015b1c0745c326~QXqCKE-ox2175821758usoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643917907;
        bh=xI6yBdL1mfc3lSXFQ8VzzVbFyQ2kUTgd06FK2pSdkHA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=pQzCjErMe9XMGa/viD7JwjBnOhvaPyFlGzO0hqaFrqa8NttQpoj7xz11BhLUWdRtN
         zf0MLQxLjCju8D4++jN+letKH3syFxdzeWwXd3OAgKoko2vbrReug+/PYy6JHPDCBZ
         zKGL6hNY1qBC/M9WPdX4U8x1aHXZ6p6WSXyEhwIg=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220203195147uscas1p2b483a50b33a6859e9785c50ffa598690~QXqB4SSH21454414544uscas1p2N;
        Thu,  3 Feb 2022 19:51:47 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id BF.DC.10104.3523CF16; Thu, 
        3 Feb 2022 14:51:47 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220203195146uscas1p1cb1a89b235bd53b2a0deb29bc1fceb22~QXqBfFeOs0908909089uscas1p1H;
        Thu,  3 Feb 2022 19:51:46 +0000 (GMT)
X-AuditID: cbfec36f-2fdff70000002778-49-61fc325334af
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 97.67.09671.2523CF16; Thu, 
        3 Feb 2022 14:51:46 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Thu, 3 Feb 2022 11:50:56 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Thu, 3 Feb 2022 11:50:56 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
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
Thread-Index: AQHYF5o0LMwUDmubDUu2kNRmd7lMHKyAbLYAgAIScYCAABSnAIAAMheA
Date:   Thu, 3 Feb 2022 19:50:56 +0000
Message-ID: <20220203195155.GB249665@bgt-140510-bm01>
In-Reply-To: <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
x-exchange-save: DSA
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <10580CE5E2C09A4AB87F082C038E3B17@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxyG951zenpo0nmERr6VRQFhGNgA2TCfcWOG6XKEP0ZCiM7E6Yke
        LuFmWmHAnHQSFi4qFwGhXsDCuApKUSBcZLQBwoDJ1payRlaQkm0gIDhEoMNZT03473nze9/k
        +ZKPwh21pJSKSTjHyRLYOHdSRLT2rzz6KDzAyvpXzTqghok8EpU8W8PRYu+0ABXmlQqRzvIu
        6l64LkCjL3/A0LT6FYa6VIUYqmvow9BfNZUAZQ+NYsg6tRcVasYA6jb5oK7uQQKVV88IUa6x
        nUQP57pxVDOwiaHx/BmACrIMGPpVaSWR9k8DgRqsCGVeWhOi2Z5vDrowOn0oU5CxIGQyKh4T
        jG4kiVHXZ5NMS1U6c3W8BjCdfyhI5uJwH86ULv9LMsbhNoy5nLFAMkszJoJpnbosZBYfGkjm
        7n0DEeZ0XPTpGS4uJpmT+QWdEkXnTnbgZ1+JUqZyLLgCaKkc4EBB+hM4VP8YywEiypGuA7BS
        s2EPmRj8784C/rbV1tBsPzQC+KDJZA/PAPx7pUrIhx4AzVW9AtuEpP3hxkDzm7mE3g0nyssE
        thJO54tg/rz+9ZyinOggeHsthO98Dpe1Knv/SzjxVEfYmKA94Gz7c6GNxXQg1A8ukjZ2oINh
        /9KjN31A74Crv9zBbIzTztBkKcd47e1Qdb3L/oQdcLNjiuTZDZpX/xHyLIFNq/Mkv/WF48VF
        dg6CRU9NOM8+sPr2HM47bIeDZRaC374He2vHCdu7IP1ABK+aR+yHQ3BG9budXaDBWIzzpXoA
        i178KORDC4Cl66NYPvBUbjFXbjFRbjFRbjFRbjGpAIJ64Jwkl8dHcfKABO5bXzkbL09KiPI9
        nRivBq//+dCmNrEdGE1LvhqAUUADIIW7S8SxJRuso/gMm5rGyRJPypLiOLkGuFCEu7O4OuYe
        60hHsee4WI47y8neXjHKQarAUgoCFZqbO0MrXlbs2vZTYkBm+ZN3vHI99KnhsWpj9Pv+a199
        vWfw2gG2r7bZo63/eOpIbUpRzJHdFyQRnZE+H6c8t3IF28bqivXS0DDP36QjezrTwtPLLrlH
        HMtPKaHPJ7elmz87nLfPtTf1fKfEIsoOZi9kDZRKDnn7O9zs/6JpqH9z/Ir1O7Vb1/yxQlWL
        yM8z2Wv9pN/96PXJw826E2M3ys3XItKHFUe9duWcli1uHnCN1ItDLbLWrqzGlaj9cizsoNOQ
        JfhIWmFH48XvHfcvTzrL8uYkIR9c6ZuPDInbdytOf+rGEzmmaJ3rOfphRKV0eqfricCf3V5I
        g6yMNtW7fsWdkEeze71xmZz9HxSbyH5WBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0wTVwDH8+6u12szzFnL+lD/sUyzTFfA4fY2N7bMjdzUuV8mkxnnGr1A
        UyhNWxw/loGyBSkDoZVKu0SKbSijyKSQQbRA2ooGcZtLYdQqU6Qd4bfoGDIautVjCf99Xr6/
        3ksehYsmeRsphUrHalTybCkpJBQlmOHFj3dG5Mmeha3IOXKGRKaHSzia84zxkOFMHR/5Q+tQ
        9+z3PHTryUkMjbmiGHJfMGDoB2cfhsYdNoDKB25hKDKaggze3wHqDm5H7u5+AtU3hvmoYriL
        RD1T3ThyXF/BUKA6DFDN6SEM/WKJkMj3xxCBnBGEvv1uiY8mez9/axPjH9zH1JTO8plS612C
        8f+cx7iay0mm3V7MGAMOwFy5XUIyp2724Uzdo79IZvhmJ8ZUls6SzHw4SDA/jVbymbmeIZL5
        sWOI+HDDZ8LXj7PZihOsJintC2FWxf3LuDoqzB/Vh/AS4KP0QEBBOhV2OtswPRBSItoJoKf9
        Bs4dHgI4E7iyqvQCaDCYiViEpJPh8vU2PMZiOhGO1Jt5McbpaiG81pasBxS1gU6DDUt7Ocub
        8JHvwqo9HY5M+5/WEPRzcLLrMT/GcfQuONg/R3Jbyzj8c6EaiwkC+m14bf7Xp2FAPwsXb7Rg
        3JYEBkP1GPcEGtrdnAfS8XBibIXH8RZ4b3GCz7EYti7OkFxWBgO1Z1c5DZ6dDuIcb4eNDVM4
        d6H1sN8cIrhsAvQ0BYhqkGBZM21ZU2VZU2VZU2VZU2UFvGYgydNqczLztSkq9kuZVp6jzVNl
        yo7l5rjAf99xYMWX0QX6gvMyL8Ao4AWQwqXiOKVpWS6KOy4vKGQ1uUc1edms1gs2UYRUEid6
        t+aoiM6U61gly6pZzf8qRgk2lmAVZQt7WuteGfDsmM7e/1V/py2/Vr+y7Z/78Xc60w59NGG6
        R6SmbZbMDldK1ovfr3IaXjW3qA7OY49Vl3psk8VFhSfcL7+m29N8/kBBY5KuoagWux3ueJDZ
        V1l0/lDGO/SpaOqU/u7h/J4DTUZbxcEdianC/RdbQdXllnKHe8IPEiXL59ZFsybnbJdmQkde
        su/bag3havWnxvGvlVW/RVwRV3VSgaH2mULZVX2k6cFur0rpzf1ANvONVWD8O6Psky3DbySU
        X1QXpO9+PlxsK2Q325dqeYfPtaeXm+LFjEmgiB55orQrOnqP7bT53nNKd53edocY1/HLzEaH
        9aTiavOglNBmyVNewDVa+b8tBB2K/QMAAA==
X-CMS-MailID: 20220203195146uscas1p1cb1a89b235bd53b2a0deb29bc1fceb22
CMS-TYPE: 301P
X-CMS-RootMailID: 20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
        <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
        <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
        <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
        <270f30df-f14c-b9e4-253f-bff047d32ff0@nvidia.com>
        <20220203153843.szbd4n65ru4fx5hx@garbanzo>
        <CGME20220203165248uscas1p1f0459e548743e6be26d13d3ed8aa4902@uscas1p1.samsung.com>
        <20220203165238.GA142129@dhcp-10-100-145-180.wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 03, 2022 at 08:52:38AM -0800, Keith Busch wrote:
> On Thu, Feb 03, 2022 at 07:38:43AM -0800, Luis Chamberlain wrote:
> > On Wed, Feb 02, 2022 at 08:00:12AM +0000, Chaitanya Kulkarni wrote:
> > > Mikulas,
> > >=20
> > > On 2/1/22 10:33 AM, Mikulas Patocka wrote:
> > > > External email: Use caution opening links or attachments
> > > >=20
> > > >=20
> > > > This patch adds a new driver "nvme-debug". It uses memory as a back=
ing
> > > > store and it is used to test the copy offload functionality.
> > > >=20
> > > > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > > >=20
> > >=20
> > >=20
> > > NVMe Controller specific memory backed features needs to go into
> > > QEMU which are targeted for testing and debugging, just like what
> > > we have done for NVMe ZNS QEMU support and not in kernel.
> > >=20
> > > I don't see any special reason to make copy offload an exception.
> >=20
> > One can instantiate scsi devices with qemu by using fake scsi devices,
> > but one can also just use scsi_debug to do the same. I see both efforts
> > as desirable, so long as someone mantains this.
> >=20
> > For instance, blktests uses scsi_debug for simplicity.
> >=20
> > In the end you decide what you want to use.
>=20
> Can we use the nvme-loop target instead?

I am advocating for this approach as well. It presentas a virtual nvme
controller already.=
