Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E674A017B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 21:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351160AbiA1UJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 15:09:01 -0500
Received: from mailout2.w2.samsung.com ([211.189.100.12]:44103 "EHLO
        mailout2.w2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351143AbiA1UJA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:09:00 -0500
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Jan 2022 15:08:59 EST
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220128195958usoutp02c0e46ba47e68ca09cf1b84efe722349d~Oh5d5bkbw0963609636usoutp02e;
        Fri, 28 Jan 2022 19:59:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220128195958usoutp02c0e46ba47e68ca09cf1b84efe722349d~Oh5d5bkbw0963609636usoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643399998;
        bh=w/0vTRlHUQEp+0DDyJjHJ6+/n6TE+u21y+XXF1J2XN8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Dq/uuWM0gQ/a/t2oZagyN/6egi23cKRJncCYxpbIhrUTrVgOFra4J4SpvBQwlFVXk
         GIoDtE2F0VtsvYDP4VQlqHMBCCR5CTE0oie/E/Zsr2bo7VsvEFkysgPJG/sNVeYJAD
         NHbuubK1s8tB+rQXDc+7e4EreoieLc0x37IOz6+A=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220128195958uscas1p274d56b7f5a807ecb3d259126017ce3ce~Oh5dupTS50535205352uscas1p2Y;
        Fri, 28 Jan 2022 19:59:58 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id CF.D2.09687.E3B44F16; Fri,
        28 Jan 2022 14:59:58 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220128195957uscas1p1ce366917e0e2702ea61957a5221ae739~Oh5dP7WPA0942509425uscas1p1A;
        Fri, 28 Jan 2022 19:59:57 +0000 (GMT)
X-AuditID: cbfec370-9c5ff700000025d7-0e-61f44b3e1725
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id FB.F1.09657.D3B44F16; Fri,
        28 Jan 2022 14:59:57 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Fri, 28 Jan 2022 11:59:47 -0800
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Fri, 28 Jan 2022 11:59:47 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
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
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "Hannes Reinecke" <hare@suse.de>,
        "kbus >> Keith Busch" <kbusch@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>
Subject: Re: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Topic: [LSF/MM/BFP ATTEND] [LSF/MM/BFP TOPIC] Storage: Copy Offload
Thread-Index: AQHYE018isCsN3oz40OdcqzMcXhV7qx5YsQA
Date:   Fri, 28 Jan 2022 19:59:47 +0000
Message-ID: <20220128195956.GA287797@bgt-140510-bm01>
In-Reply-To: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
x-exchange-save: DSA
Content-Type: text/plain; charset="us-ascii"
Content-ID: <795CC14C0A3B064B8E80D872868A1CF5@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHd+69vb10K7l0nZzCErJumG248pAt5w9lyFy8g6m4sGxxEdfN
        O+gGlbTiNhcyNgUVRR4jK9YYBBloQXQ8yqtllseqKPIoBeyGCwNFIAKtAhZZme2tCf99vuf7
        /Z3f9ySHwkV6MoBSKA+wKqU8RUoKCP2fC71vRcU9kodZ215AVaN5JPp13omjOdM4DxXmFfOR
        ZcIXGWfP8FDf458wNF67iiFDWSGGLlZ1YWiy8jxAK2PhqLB9CCCjLQQZjNcJVFJxl49ODDeR
        qG3GiKNKswtDBcesGLqlXSFRxx0rgapWEMo66eSj6T8SoyWMZTCOKTg8y2csPelMre44ydSV
        /8j8MlIJmNbbmSTz880unCl2PCKZ4ZuNGJN7eJZk7HdtBKMfy+Uzc21WkrlcbyWYuhs/xIt2
        CzbtY1MUB1lVaNTnguSHphaQ1rn1O2ujHmSC+k05gKIgHQlnmgJzgIAS0RcBPFtWBDiRhcHx
        gU7wLFRq2smdXwIwW2fBOWEHsM9xlODEVQDzXPVPHR+KpMPgE/PvHhbTMmi1jfDdIZwu8IE1
        mgaP8SL9AWy6koe5V4jpWFg+GMHlI+ClhRzCzQQdDA1FLcDNQvptuNy97GEfOgrOzpXw3Azo
        dXCpuxpzM077Q9tEiYch7QfLzhhwjtdBV8sYyfEr8J+lKT7HYliz9IDkZjfAc60OL0fB3u4s
        750hsKJ0Buc6+MHrpycIblYCTRdGPI+HdIMA/q1v9C7YCpuPrXo5EGqqLd6QDsCixWw+J+oA
        LF7uw/JBsHZNc+2aJto1TbRrmmjXNDkHeDrgn65Wpyax6o1K9luZWp6qTlcmyb7cn1oLnn7t
        G66OtCZgs9ll7QCjQDuAFC4VC4trHXKRcJ/8+0Osav9eVXoKq24HgRQh9RdWKK7IRXSS/AD7
        DcumsapnLkb5BGRikuN73ghnpf9V+w5f2NYlapDglEa5YXQqf3vQ7dbJr4Ot52M/emxxxiVG
        bm6sdn2RH69q7Dy947JfasZnmo3kzMHi0r3P9atrol9/Qlp3Pd8BbTt8yxNwekhT5UwezEgI
        zNtiHn9AB+le+xd0+cYyh3wKgvUnHHMRZ4cysjLEL13TRE6tf8doejgQeurD3xZPdYdN58bw
        Epaz+wXrc9sFhvzJ1JCTZr7t43v37t9/d1Ec88lXzfidoMSp5vmBeaHBvmXPNUlP9MtmxvZ+
        b0D4rluKT0MpyWbBkXjjUcXo6m6ntlCsl84eQZPkyHvKqxKX0T7BvLotJaa/p2taFhS68JeU
        UCfLw9/EVWr5/295zJ5JBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWS2cA0SdfW+0uiwex2NYvVd/vZLKZ9+Mls
        8f7gY1aLSf0z2C0uP+Gz2PtuNqvFhR+NTBaPN/1nstizaBKTxcrVR5ksni9fzGjx56GhxaRD
        1xgt9t7Sttiz9ySLxfxlT9ktuq/vYLPY93ovs8Xy4/+YLCZ2XGWyODfrD5vF4XtXWSxW/7Gw
        aO35yW7xan+cg6TH5SveHhOb37F7XD5b6rFpVSebx+Yl9R6Tbyxn9Nh9s4HNo+nMUWaPGZ++
        sHlcP7OdyaO3+R2bx8ent1g8tj3sZfd4v+8qm8f6LVdZPDafrg4QiuKySUnNySxLLdK3S+DK
        +HxwF2PBEZeKq9u3MTYwbrHpYuTgkBAwkVh40L+LkZNDSGA1o8Tu0/VdjFxA9kdGid87zzBB
        OAcYJXq2NjKCVLEJGEj8Pr6RGcQWEdCTuHrrBjtIEbPARE6Jt73rmUASwgKeEjs29DOBbBAR
        8JJYcsUIot5IYu3XLhYQm0VAVWLPlF1gM3kFTCV+nfrFCLFsIqPE6a8/2EESnAJ2Eu/ez2cF
        sRkFxCS+n1oDNp9ZQFzi1pP5YLaEgIDEkj3nmSFsUYmXj/+xQtiKEve/v2SHsEUk1n1/ywbR
        qyOxYPcnKNtO4vypVqiZ2hLLFr5mhjhIUOLkzCcsEL2SEgdX3GCZwCg5C8nqWUhGzUIyahaS
        UbOQjFrAyLqKUby0uDg3vaLYOC+1XK84Mbe4NC9dLzk/dxMjMAme/nc4ZgfjvVsf9Q4xMnEw
        HmKU4GBWEuGdselTohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFej9iJ8UIC6YklqdmpqQWpRTBZ
        Jg5OqQamzbtmbjb/7VsZYqqxfc0LrpMO2/VMntxYx8hXnrmr4OmCeA+Gp1P8HvAU72DtOLdQ
        7mx9vUhDSMOqDMvFJ9seuuzq+fZk8d3331SnysxYv9drtXHOm3KWh5yaPdqnuuc7n8k7+7HF
        vMLXamXj2mcn0uTWBXhOl1jyOF16Q8Xn+KxYria7gg3Tv9drfoiyuL/PflrKjd9G0nkL09Pq
        /FXeTTnaclDD5oj6IdnJrPM7duYXfuX+714fr5jc6fAi5Ps7vw08vEF7ZJQX7jmUPfH+Ko8X
        gv92+PIonJrkpyb0OTrj+5Uds79JHOUVXsB/tj58S3aC1zxXfS1HgfmrHYTkYp/4X7jYvkwn
        wo8pR+aiEktxRqKhFnNRcSIAbkztBfEDAAA=
X-CMS-MailID: 20220128195957uscas1p1ce366917e0e2702ea61957a5221ae739
CMS-TYPE: 301P
X-CMS-RootMailID: 20220127071544uscas1p2f70f4d2509f3ebd574b7ed746d3fa551
References: <CGME20220127071544uscas1p2f70f4d2509f3ebd574b7ed746d3fa551@uscas1p2.samsung.com>
        <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 27, 2022 at 07:14:13AM +0000, Chaitanya Kulkarni wrote:
> Hi,
>=20
> * Background :-
> -----------------------------------------------------------------------
>=20
> Copy offload is a feature that allows file-systems or storage devices
> to be instructed to copy files/logical blocks without requiring
> involvement of the local CPU.
>=20
> With reference to the RISC-V summit keynote [1] single threaded
> performance is limiting due to Denard scaling and multi-threaded
> performance is slowing down due Moore's law limitations. With the rise
> of SNIA Computation Technical Storage Working Group (TWG) [2],
> offloading computations to the device or over the fabrics is becoming
> popular as there are several solutions available [2]. One of the common
> operation which is popular in the kernel and is not merged yet is Copy
> offload over the fabrics or on to the device.
>=20
> * Problem :-
> -----------------------------------------------------------------------
>=20
> The original work which is done by Martin is present here [3]. The
> latest work which is posted by Mikulas [4] is not merged yet. These two
> approaches are totally different from each other. Several storage
> vendors discourage mixing copy offload requests with regular READ/WRITE
> I/O. Also, the fact that the operation fails if a copy request ever
> needs to be split as it traverses the stack it has the unfortunate
> side-effect of preventing copy offload from working in pretty much
> every common deployment configuration out there.
>=20
> * Current state of the work :-
> -----------------------------------------------------------------------
>=20
> With [3] being hard to handle arbitrary DM/MD stacking without
> splitting the command in two, one for copying IN and one for copying
> OUT. Which is then demonstrated by the [4] why [3] it is not a suitable
> candidate. Also, with [4] there is an unresolved problem with the
> two-command approach about how to handle changes to the DM layout
> between an IN and OUT operations.
>=20
> We have conducted a call with interested people late last year since=20
> lack of LSFMMM and we would like to share the details with broader
> community members.

Was on that call and I am interested in joining this discussion.

>=20
> * Why Linux Kernel Storage System needs Copy Offload support now ?
> -----------------------------------------------------------------------
>=20
> With the rise of the SNIA Computational Storage TWG and solutions [2],
> existing SCSI XCopy support in the protocol, recent advancement in the
> Linux Kernel File System for Zoned devices (Zonefs [5]), Peer to Peer
> DMA support in the Linux Kernel mainly for NVMe devices [7] and
> eventually NVMe Devices and subsystem (NVMe PCIe/NVMeOF) will benefit
> from Copy offload operation.
>=20
> With this background we have significant number of use-cases which are
> strong candidates waiting for outstanding Linux Kernel Block Layer Copy
> Offload support, so that Linux Kernel Storage subsystem can to address
> previously mentioned problems [1] and allow efficient offloading of the
> data related operations. (Such as move/copy etc.)
>=20
> For reference following is the list of the use-cases/candidates waiting
> for Copy Offload support :-
>=20
> 1. SCSI-attached storage arrays.
> 2. Stacking drivers supporting XCopy DM/MD.
> 3. Computational Storage solutions.
> 7. File systems :- Local, NFS and Zonefs.
> 4. Block devices :- Distributed, local, and Zoned devices.
> 5. Peer to Peer DMA support solutions.
> 6. Potentially NVMe subsystem both NVMe PCIe and NVMeOF.
>=20
> * What we will discuss in the proposed session ?
> -----------------------------------------------------------------------
>=20
> I'd like to propose a session to go over this topic to understand :-
>=20
> 1. What are the blockers for Copy Offload implementation ?
> 2. Discussion about having a file system interface.
> 3. Discussion about having right system call for user-space.
> 4. What is the right way to move this work forward ?
> 5. How can we help to contribute and move this work forward ?
>=20
> * Required Participants :-
> -----------------------------------------------------------------------
>=20
> I'd like to invite file system, block layer, and device drivers
> developers to:-
>=20
> 1. Share their opinion on the topic.
> 2. Share their experience and any other issues with [4].
> 3. Uncover additional details that are missing from this proposal.
>=20
> Required attendees :-
>=20
> Martin K. Petersen
> Jens Axboe
> Christoph Hellwig
> Bart Van Assche
> Zach Brown
> Roland Dreier
> Ric Wheeler
> Trond Myklebust
> Mike Snitzer
> Keith Busch
> Sagi Grimberg
> Hannes Reinecke
> Frederick Knight
> Mikulas Patocka
> Keith Busch
>=20
> -ck
>=20
> [1]https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D39=
33d1bc-66a8e8f3-39325af3-0cc47a30d446-55df181e6aabd8e8&q=3D1&e=3Dc880f1d4-0=
275-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Fcontent.riscv.org*2Fwp-content=
*2Fuploads*2F2018*2F12*2FA-New-Golden-Age-for-Computer-Architecture-History=
-Challenges-and-Opportunities-David-Patterson-.pdf__;JSUlJSUlJSU!!EwVzqGoTK=
Bqv-0DWAJBm!BhtIUewpIpaTRbAVe6VvjiRs-431N4ehiLybkoGuMxLiIvcuYlijJGJWlXVggCI=
71vV3$=20
> [2] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3De=
9dc0639-b6473f76-e9dd8d76-0cc47a30d446-03d65bc9ad20d215&q=3D1&e=3Dc880f1d4-=
0275-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Fwww.snia.org*2Fcomputational_=
_;JSUlJQ!!EwVzqGoTKBqv-0DWAJBm!BhtIUewpIpaTRbAVe6VvjiRs-431N4ehiLybkoGuMxLi=
IvcuYlijJGJWlXVggLInnHhS$=20
> https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D13eb4=
7ed-4c707ea2-13eacca2-0cc47a30d446-3d06014a33154497&q=3D1&e=3Dc880f1d4-0275=
-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Fwww.napatech.com*2Fsupport*2Freso=
urces*2Fsolution-descriptions*2Fnapatech-smartnic-solution-for-hardware-off=
load*2F__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!BhtIUewpIpaTRbAVe6VvjiRs-431N4e=
hiLybkoGuMxLiIvcuYlijJGJWlXVggJJSlhVh$=20
>        https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=
=3D8ba72fbf-d43c16f0-8ba6a4f0-0cc47a30d446-359457fd63a1a13d&q=3D1&e=3Dc880f=
1d4-0275-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Fwww.eideticom.com*2Fprodu=
cts.html__;JSUlJQ!!EwVzqGoTKBqv-0DWAJBm!BhtIUewpIpaTRbAVe6VvjiRs-431N4ehiLy=
bkoGuMxLiIvcuYlijJGJWlXVggGCerEbv$=20
> https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D75b96=
fa9-2a2256e6-75b8e4e6-0cc47a30d446-0403b00d6ff1bab8&q=3D1&e=3Dc880f1d4-0275=
-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Fwww.xilinx.com*2Fapplications*2Fd=
ata-center*2Fcomputational-storage.html__;JSUlJSUl!!EwVzqGoTKBqv-0DWAJBm!Bh=
tIUewpIpaTRbAVe6VvjiRs-431N4ehiLybkoGuMxLiIvcuYlijJGJWlXVggK0Hp6vG$=20
> [3] git://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git xcopy
> [4] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D3=
a49563e-65d26f71-3a48dd71-0cc47a30d446-3cecc3d55115742b&q=3D1&e=3Dc880f1d4-=
0275-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Fwww.spinics.net*2Flists*2Flin=
ux-block*2Fmsg00599.html__;JSUlJSUl!!EwVzqGoTKBqv-0DWAJBm!BhtIUewpIpaTRbAVe=
6VvjiRs-431N4ehiLybkoGuMxLiIvcuYlijJGJWlXVggPvo936U$=20
> [5] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D9=
10e6991-ce9550de-910fe2de-0cc47a30d446-c412c0c3c4c51c2b&q=3D1&e=3Dc880f1d4-=
0275-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Flwn.net*2FArticles*2F793585*2=
F__;JSUlJSUl!!EwVzqGoTKBqv-0DWAJBm!BhtIUewpIpaTRbAVe6VvjiRs-431N4ehiLybkoGu=
MxLiIvcuYlijJGJWlXVggIprHJMJ$=20
> [6] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D0=
ab886e2-5523bfad-0ab90dad-0cc47a30d446-df0ae4acca6d59f2&q=3D1&e=3Dc880f1d4-=
0275-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Fnvmexpress.org*2Fnew-nvmetm-s=
pecification-defines-zoned-__;JSUlJQ!!EwVzqGoTKBqv-0DWAJBm!BhtIUewpIpaTRbAV=
e6VvjiRs-431N4ehiLybkoGuMxLiIvcuYlijJGJWlXVggB4MUwfa$=20
> namespaces-zns-as-go-to-industry-technology/
> [7] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D4=
4a1a51b-1b3a9c54-44a02e54-0cc47a30d446-8577b144c92493eb&q=3D1&e=3Dc880f1d4-=
0275-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Fgithub.com*2Fsbates130272*2Fl=
inux-p2pmem__;JSUlJSU!!EwVzqGoTKBqv-0DWAJBm!BhtIUewpIpaTRbAVe6VvjiRs-431N4e=
hiLybkoGuMxLiIvcuYlijJGJWlXVggEa99Fso$=20
> [8] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D0=
745845d-58debd12-07440f12-0cc47a30d446-53178030a251a9d8&q=3D1&e=3Dc880f1d4-=
0275-4c86-ba38-205de0f24f69&u=3Dhttps*3A*2F*2Fkernel.dk*2Fio_uring.pdf__;JS=
UlJQ!!EwVzqGoTKBqv-0DWAJBm!BhtIUewpIpaTRbAVe6VvjiRs-431N4ehiLybkoGuMxLiIvcu=
YlijJGJWlXVggJUxR2B3$ =
