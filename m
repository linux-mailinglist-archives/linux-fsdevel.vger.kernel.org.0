Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B248168F412
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 18:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjBHRNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 12:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBHRNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:13:37 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C51F93E
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 09:13:34 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230208171331usoutp015b5c1f6c4ef8c7e076562e761f806a56~B6LeK8yxR1034910349usoutp01L;
        Wed,  8 Feb 2023 17:13:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230208171331usoutp015b5c1f6c4ef8c7e076562e761f806a56~B6LeK8yxR1034910349usoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1675876411;
        bh=jS9EDCsrGhv8+ngo1hMd3tcnFro4QWCozfC5QofOKZY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ExwSqJ+z2hiT7IeYvwLpTjg58JIimCT9E9jFrlUibv7KX/OlrLJKS/vyFisuY97+Y
         uQ/9q4yivUQ7g+5j4VpUl/C6h//D7PuwoUJqzjrAxCXETlirmTfEJUxyGOtf2yvfwW
         ptLT7p9EvgHRhV0bNcGcXNR/+bZI7z1ZFGhyrTdo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230208171331uscas1p2a0d37a25ebc406df1738cda20485a8c7~B6Ld-HyVL1473914739uscas1p2h;
        Wed,  8 Feb 2023 17:13:31 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 20.C2.49129.B38D3E36; Wed, 
        8 Feb 2023 12:13:31 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230208171330uscas1p2e9137efb8903c47a54d1b9c8b48d85be~B6Ldscj2j1277212772uscas1p2X;
        Wed,  8 Feb 2023 17:13:30 +0000 (GMT)
X-AuditID: cbfec36f-167fe7000001bfe9-74-63e3d83b4b34
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id E5.24.11346.A38D3E36; Wed, 
        8 Feb 2023 12:13:30 -0500 (EST)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 8 Feb 2023 09:13:29 -0800
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Wed,
        8 Feb 2023 09:13:29 -0800
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Hans Holmberg <Hans.Holmberg@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "Dennis Maisenbacher" <dennis.maisenbacher@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        =?iso-8859-1?Q?J=F8rgen_Hansen?= <Jorgen.Hansen@wdc.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "javier@javigon.com" <javier@javigon.com>,
        "hch@lst.de" <hch@lst.de>,
        "guokuankuan@bytedance.com" <guokuankuan@bytedance.com>,
        "viacheslav.dubeyko@bytedance.com" <viacheslav.dubeyko@bytedance.com>,
        "j.granados@samsung.com" <j.granados@samsung.com>
Subject: Re: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
 devices
Thread-Topic: [LSF/MM/BPF TOPIC]: File system data placement for zoned block
        devices
Thread-Index: AQHZOjDDUZpAXLX4TUqlcfdOqdocu67F0woA
Date:   Wed, 8 Feb 2023 17:13:29 +0000
Message-ID: <20230208171321.GA408056@bgt-140510-bm01>
In-Reply-To: <20230206134148.GD6704@gsv>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <95A0B7830A31B54A8494B974547F52D9@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7djX87rWNx4nGyxewmox8/IPRovW9m9M
        FguOPmW2aLzfyGQx4c1RdouVq48yWTxZP4vZovP0BSaLv133mCz6Jjxmtvjz0NBiz96TLBYT
        2r4yW9yY8JTRYuLxzawWHRveMDoIePw7sYbNo3nBHRaPTas62Tx232xg85iweSOrx+dNch7t
        B7qZAtijuGxSUnMyy1KL9O0SuDLuHJrEWHDJpWL/uj+sDYwzLLsYOTgkBEwk5rxk62Lk5BAS
        WMko8WqFBoTdyiTx4moNiA1SsmfyHKYuRi6g+FpGiSuLDzFCOB8ZJZ5d2s0C4SxllJjxv48F
        pIVNwEDi9/GNzCC2iICmxOyFS8E6mAVWskns3vsaLCEsECrx8OkHJoiiMIn2rY9ZIWwjieXd
        i8FqWARUJJY//gIW5xUwlVi9qosdxOYU0JCY2NHFCGIzCohJfD+1BmwOs4C4xK0n85kg7haU
        WDR7DzOELSbxb9dDNghbUeL+95fsEPV6EjemTmGDsO0kPj3YCDVHW2LZQog7eYHmnJz5hAWi
        V1Li4IobYB9LCCznlHhxfREjRMJF4s2aL1BF0hLT11yGsvMldrVdgTqiQuLq626oI6wlFv5Z
        zzSBUWUWkrtnIblpFpKbZiG5aRaSmxYwsq5iFC8tLs5NTy02ykst1ytOzC0uzUvXS87P3cQI
        TIWn/x3O38F4/dZHvUOMTByMhxglOJiVRHi/T3ycLMSbklhZlVqUH19UmpNafIhRmoNFSZzX
        0PZkspBAemJJanZqakFqEUyWiYNTqoFJ2+1u7wuuJ7633jbO/2l3MXibA5vOLc7pbA92prov
        KbvrMHHeZ47z7usK9/csSNvFKPvU+rb4NxmRmebXX0+cWBB6W2ErlyP7nUlB+1uPLzmdlsdv
        3lUssyv3dfuaedydiXV/NNafnrHwpnzfmrO27W39VYJ+U67eeFURffB1kNjCVGXJiZwX88K2
        rH6k57ltpp3io02+Otyt/S9tRGodvkSa2PJ1qV+6Yad9RfW5Kb/wC0v3GRuU5TIk9rfPypd1
        7llgu/TDv9Rs81SZja2zMlbGud65GBS3f6qZrbua3GL+iYqmZxt3bwlJjnW/F+/oczdGMYTB
        80q++d9DOpzRU2by1jrVH46dtUvzsJgSS3FGoqEWc1FxIgB1aztb9AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWS2cA0SdfqxuNkg0nrdSxmXv7BaNHa/o3J
        YsHRp8wWjfcbmSwmvDnKbrFy9VEmiyfrZzFbdJ6+wGTxt+sek0XfhMfMFn8eGlrs2XuSxWJC
        21dmixsTnjJaTDy+mdWiY8MbRgcBj38n1rB5NC+4w+KxaVUnm8fumw1sHhM2b2T1+LxJzqP9
        QDdTAHsUl01Kak5mWWqRvl0CV8adQ5MYCy65VOxf94e1gXGGZRcjJ4eEgInEnslzmEBsIYHV
        jBI7Lwh1MXIB2R8ZJeY82sEE4SwFSvybwgZSxSZgIPH7+EZmEFtEQFNi9sKljCBFzAIr2SR2
        730NlhAWCJV4+PQDUDcHUFGYxPN5WRD1RhLLuxeDlbAIqEgsf/yFFcTmFTCVWL2qix3iimqJ
        bW0XwOKcAhoSEzu6GEFsRgExie+n1oBdyiwgLnHryXwmiA8EJJbsOc8MYYtKvHz8jxXCVpS4
        //0lO0S9nsSNqRD3MwvYSXx6sBFqjrbEsoUQJ/MKCEqcnPmEBaJXUuLgihssExglZiFZNwvJ
        qFlIRs1CMmoWklELGFlXMYqXFhfnplcUG+ellusVJ+YWl+al6yXn525iBKaR0/8Ox+xgvHfr
        o94hRiYOxkOMEhzMSiK83yc+ThbiTUmsrEotyo8vKs1JLT7EKM3BoiTO6xE7MV5IID2xJDU7
        NbUgtQgmy8TBKdXAlFqz2HZDzvwFBUtCAy4c+HRUMVCcMbtQcvJJyxnVvZ4PfqkZTri6c+pb
        7quOARuFI0ujXtVPN9t+/s3ZNSvTTrdVyd6oCDvpJH1nyj/Gu+dCq9j7OKfInd6qePrYNyam
        6ln91cf6/jb5Mv/9JfxiU1ZD1bFmuauOXttOqs+Xusdpkd7mI+gRLpe7IljL4OQfnvvCP0TU
        Hx5OaPi0JL9DUW+K5rO9r9a/UylSNP91JNokpsb5pcAKRlndzXOsA6r+Tnz0Ot+65+yULYvN
        pujsZldsN1ZZwGWQ+vTEk797dixcob4yqMLZ9WNzgUXMMs+nAduyD3O/i5dXEpcOlahV7ulh
        ktuz8viXi9HrVM8pKLEUZyQaajEXFScCAMcQX4+SAwAA
X-CMS-MailID: 20230208171330uscas1p2e9137efb8903c47a54d1b9c8b48d85be
CMS-TYPE: 301P
X-CMS-RootMailID: 20230206134200uscas1p20382220d7fc10c899b4c79e01d94cf0b
References: <CGME20230206134200uscas1p20382220d7fc10c899b4c79e01d94cf0b@uscas1p2.samsung.com>
        <20230206134148.GD6704@gsv>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 06, 2023 at 01:41:49PM +0000, Hans Holmberg wrote:
> Write amplification induced by garbage collection negatively impacts
> both the performance and the life time for storage devices.
>=20
> With zoned storage now standardized for SMR hard drives
> and flash(both NVME and UFS) we have an interface that allows
> us to reduce this overhead by adapting file systems to do
> better data placement.

I would be interested in this discussion as well. Data placement on storage
media seems like a topic that is not going to go away any time soon. Interf=
aces
that are not tied to particular HW implementations seem like a longer term
approach to the issue.=20

>=20
> Background
> ----------
>=20
> Zoned block devices enables the host to reduce the cost of
> reclaim/garbage collection/cleaning by exposing the media erase
> units as zones.
>=20
> By filling up zones with data from files that will
> have roughly the same life span, garbage collection I/O
> can be minimized, reducing write amplification.
> Less disk I/O per user write.
>=20
> Reduced amounts of garbage collection I/O improves
> user max read and write throughput and tail latencies, see [1].
>=20
> Migrating out still-valid data to erase and reclaim unused
> capacity in e.g. NAND blocks has a significant performance
> cost. Unnecessarily moving data around also means that there
> will be more erase cycles per user write, reducing the life
> time of the media.
>=20
> Current state
> -------------
>=20
> To enable the performance benefits of zoned block devices
> a file system needs to:
>=20
> 1) Comply with the write restrictions associated to the
> zoned device model.=20
>=20
> 2) Make active choices when allocating file data into zones
> to minimize GC.
>=20
> Out of the upstream file systems, btrfs and f2fs supports
> the zoned block device model. F2fs supports active data placement
> by separating cold from hot data which helps in reducing gc,
> but there is room for improvement.
>=20
>=20
> There is still work to be done
> ------------------------------
>=20
> I've spent a fair amount of time benchmarking btrfs and f2fs
> on top of zoned block devices along with xfs, ext4 and other
> file systems using the conventional block interface
> and at least for modern applicationsm, doing log-structured
> flash-friendly writes, much can be improved.=20
>=20
> A good example of a flash-friendly workload is RocksDB [6]
> which both does append-only writes and has a good prediction model
> for the life time of its files (due to its lsm-tree based data structures=
)
>=20
> For RocksDB workloads, the cost of garbage collection can be reduced
> by 3x if near-optimal data placement is done (at 80% capacity usage).
> This is based on comparing ZenFS[2], a zoned storage file system plugin
> for RocksDB, with f2fs, xfs, ext4 and btrfs.
>=20
> I see no good reason why linux kernel file systems (at least f2fs & btrfs=
)
> could not play as nice with these workload as ZenFS does, by just allocat=
ing
> file data blocks in a better way.
>

For RocksDB one thing I have struggled with is the fact that RocksDB appear=
s
to me as a lightweight FS user. We expect much more from kernel FS than wha=
t
RocksDB expects. There are multiple user space FS that are compatible with=
=20
RocksDB. How far should the kernel go to accomodate this use case?

> In addition to ZenFS we also have flex-alloc [5].
> There are probably more data placement schemes for zoned storage out ther=
e.
>=20
> I think wee need to implement a scheme that is general-purpose enough
> for in-kernel file systems to cover a wide range of use cases and workloa=
ds.

This is the key point of the work IMO. I would hope to hear more use cases =
and
make sure that the demand comes from potential users of the API.

>=20
> I brought this up at LPC last year[4], but we did not have much time
> for discussions.
>=20
> What is missing
> ---------------
>=20
> Data needs to be allocated to zones in a way that minimizes the need for
> reclaim. Best-effort placement decision making could be implemented to pl=
ace
> files of similar life times into the same zones.
>=20
> To do this, file systems would have to utilize some sort of hint to
> separate data into different life-time-buckets and map those to
> different zones.
>=20
> There is a user ABI for hints available - the write-life-time hint interf=
ace
> that was introduced for streams [3]. F2FS is the only user of this curren=
tly.
>=20
> BTRFS and other file systems with zoned support could make use of it too,
> but it is limited to four, relative, life time values which I'm afraid wo=
uld be too limiting when multiple users share a disk.
>=20

I noticed F2FS uses only two of the four values ATM. I would like to hear m=
ore
from F2FS users who use these hints as to what the impact of using the hint=
s is.

> Maybe the life time hints could be combined with process id to separate
> different workloads better, maybe we need something else. F2FS supports
> cold/hot data separation based on file extension, which is another soluti=
on.
>=20
> This is the first thing I'd like to discuss.
>=20
> The second thing I'd like to discuss is testing and benchmarking, which
> is probably even more important and something that should be put into
> place first.
>=20
> Testing/benchmarking
> --------------------
>=20
> I think any improvements must be measurable, preferably without having to
> run live production application workloads.
>=20
> Benchmarking and testing is generally hard to get right, and particularil=
y hard
> when it comes to testing and benchmarking reclaim/garbage collection,
> so it would make sense to share the effort.
>=20
> We should be able to use fio to model a bunch of application workloads
> that would benefit from data placement (lsm-tree based key-value database
> stores (e.g rocksdb, terarkdb), stream processing apps like Apache kafka)=
) ..=20

Should we just skip fio and run benchmarks on top of rocksDB and kafka? I w=
as
looking at mmtests recently and noticed that it goes and downloads mm relev=
ant
applications and runs benchmarks on the chose benchmarks.

>=20
> Once we have a set of benchmarks that we collectively care about, I think=
 we
> can work towards generic data placement methods with some level of
> confidence that it will actually work in practice.
>=20
> Creating a repository with a bunch of reclaim/gc stress tests and benchma=
rks
> would be beneficial not only for kernel file systems but also for user-sp=
ace
> and distributed file systems such as ceph.

This would be very valuable. Ideally with input from consumers of the data
placement APIS.

>=20
> Thanks,
> Hans
>=20
> [1] https://urldefense.com/v3/__https://www.usenix.org/system/files/atc21=
-bjorling.pdf__;!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2V=
KMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirD4LbAEY$=20
> [2] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D4=
62cf2bb-27a7e781-462d79f4-74fe4860008a-ab419c0ae2c7fb34&q=3D1&e=3D66a35d4b-=
398f-4758-82c5-79f023ada0b4&u=3Dhttps*3A*2F*2Fgithub.com*2Fwesterndigitalco=
rporation*2Fzenfs__;JSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29OSHK=
5LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirB3JeheY$=20
> [3] https://urldefense.com/v3/__https://lwn.net/Articles/726477/__;!!EwVz=
qGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0iE=
TvqHpyuKD6UpBapa6jkGmbktirPUCJNUc$=20
> [4] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D7=
eb17e0e-1f3a6b34-7eb0f541-74fe4860008a-0e46d2a09227c132&q=3D1&e=3D66a35d4b-=
398f-4758-82c5-79f023ada0b4&u=3Dhttps*3A*2F*2Flpc.events*2Fevent*2F16*2Fcon=
tributions*2F1231*2F__;JSUlJSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94=
o29OSHK5LD8GlXL_2VKMGS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirgbmZXI0$=
=20
> [5] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D1=
9cdffac-7846ea96-19cc74e3-74fe4860008a-1121f5b082abfbe3&q=3D1&e=3D66a35d4b-=
398f-4758-82c5-79f023ada0b4&u=3Dhttps*3A*2F*2Fgithub.com*2FOpenMPDK*2FFlexA=
lloc__;JSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2VKM=
GS7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirL2CmpSE$=20
> [6] https://urldefense.com/v3/__https://protect2.fireeye.com/v1/url?k=3D6=
ed08255-0f5b976f-6ed1091a-74fe4860008a-2a012b612f36b36a&q=3D1&e=3D66a35d4b-=
398f-4758-82c5-79f023ada0b4&u=3Dhttps*3A*2F*2Fgithub.com*2Ffacebook*2Frocks=
db__;JSUlJSU!!EwVzqGoTKBqv-0DWAJBm!WC4RGRyZ9YioNTLW94o29OSHK5LD8GlXL_2VKMGS=
7Z5e0cojtPDKfqU0iETvqHpyuKD6UpBapa6jkGmbktirJuN380k$ =
