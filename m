Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFAC4E8C78
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 05:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbiC1DOX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Mar 2022 23:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbiC1DOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:14:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2108.outbound.protection.outlook.com [40.92.18.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B4B50B31
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Mar 2022 20:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8XMMzHd+/jiTyD5EV5vAhnFWI4zPmKDwWwJg5xWYpjB/2RedYU9cigVrCnnl913gK56x1nXMGNiCtCikTkIeKXMj+xyPkGs3O6hXj4aesLlC+6ZjLxhWr5vt8cQ7z9za7Pj2IrvDpHRBXNRjD1oMdTjKnovNBGbL4+nGsUdkxkagCvrghLoDBUNOAaFPR23j5E0RZYjpGXA5ekZ+KLqWvyEi7Wcz/nwSDaJiJk5ubb3UPL7FshdFsojhqPzR/kdkKo1m8qjy43pIGvd+qiQRqY/mLvV/3hDJTH5NBsT5Tgo8RYpbKBxWFpA3uhHN90XhiLktkK6PsbeYbnE6zcvwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzZ8egp4NxB2BWpHp7tkSBzcZc7lifPSOiMNyAj14X4=;
 b=cVdRtYAtSHCh2ZNPYZPX84IIL7hBqMXG9RvAFABoT4pNdSoaWvafTp3I+0bOvf5WkaFQ8EVYD6e2W0xdLnxI98LYuPNc4OsLXmYYbl22PPyTuwHiQqkwVwDuGx1LtCdpBD+fAOkLPCT0vMfxDjFFydVlw7ritsuSmZ/G8gR8h1b1EzllfrGKN8fSTP9hmHK4DLGbq8ymkTWFHpSvF0IPzGDgG02d3kVf7IAb8APfZI0ZZ2lePSBM7J0/FCPqqATrSO1T3F7shPFR04Wlc5teNCybp3i6OzDCOhswVG5v9TaRlDOXc1B2IvxzuX8IWxA1x7DOmgcBzW5uqlVSbLq09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MN2PR20MB2512.namprd20.prod.outlook.com (2603:10b6:208:130::24)
 by DM6PR20MB2746.namprd20.prod.outlook.com (2603:10b6:5:13f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 03:12:38 +0000
Received: from MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::9478:70e3:10c0:b16b]) by MN2PR20MB2512.namprd20.prod.outlook.com
 ([fe80::9478:70e3:10c0:b16b%6]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 03:12:38 +0000
From:   Bruno Damasceno Freire <bdamasceno@hotmail.com.br>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Bruno Damasceno Freire <bdamasceno@hotmail.com.br>
Subject: Re: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Topic: [regression] 5.15 kernel triggering 100x more inode evictions
Thread-Index: AQHYPN5CzLbpGwv62Eyf/QOJSNQRSqzOeNCAgAWocgM=
Date:   Mon, 28 Mar 2022 03:12:38 +0000
Message-ID: <MN2PR20MB251203B4B5445B4B0C4148C9D21D9@MN2PR20MB2512.namprd20.prod.outlook.com>
References: <MN2PR20MB2512314446801B92562E26B5D2169@MN2PR20MB2512.namprd20.prod.outlook.com>
 <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
In-Reply-To: <07bb78be-1d58-7d88-288b-6516790f3b5d@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 03e7dbd0-ec36-810e-54ae-a6fed71ae806
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [GXTAzOXCS1yNySrDfh3BIvAPexmxKbbY]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2148f25-267b-4f59-730a-08da1068d091
x-ms-exchange-slblob-mailprops: S/btQ8cKWiR6nMXE5xGBKE2J0Wx9WygQfbudtaJYsEQAmWwVdoybKt064UJuacKPB6/ZebAYG6hxhAIZjbGxuQv+NVvJlFaj5D/hV7BDpsJIuwTutWFXJ61LpKE9YBy5YrA7zJemJq1Ehw1Z+d7Roxz5sGgzK6J1Wx+QVMO1cmCYgBCqXAspkCh6QRJAXri33xzu3hggwuAmHCtUzdpKlD5JWjrwixDTeOUHpzmZeJ4XMNBWwAsrDSdOIxxUBOXTd3fpvf/N5qwOXWd5MmjQkkfgqUlqUIpkkbZ6Yyfe4KoDp5e4H/ETpWU3r2O0JCRZQjq6/B65tQOJoOaVy3g7NwiBPlRwb7rVvHUjWQxNEbGfVFL4PGzArYnrLDH3pJDoard4gCFGlJkEfZWqnZ69uvE2Lu/w170kcy4V3xZceteHZeg/XH2apj8M2S2OfHe0wlfthaS1kUi+lhrTFviO6K4qYjHdAA+1qXaRnPxPcYMA/0UE9Mv4gY+6FtlMDvkEKI1dfTZuPIpV7bwQM/9rSr0YG+YA2oawRk0VgN4eGHnUkDIqBSUSykJAziROUXNkVICUw35N//e4u0Mxh7KE2eTx3rrQy/yob9j6GZiU2pGIFQnQm/71F2uu11ASnROoO2dgJeoMt2UPNruI9Iz406MCIqfRv3pn9Zlhez0PfK8+xEnyAuHa+QPaIP/iEu7C+ffSRrkkRME41lRfS0yfueK+0Aj5mBa1xw45eEEvUA+NXGuKbgNFagRProQuVQFVSgOVmiJHpP8=
x-ms-traffictypediagnostic: DM6PR20MB2746:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HoOAWkhVhbmowkhYlW97bVIWWXBQht52JIGR6mQChsb7LHNnUWv1h+97/ei9bkWe5neZWRghiL+iXBBwuZHssOTP5fj7bbjf893eY2knJqv05LIMTxo6y7fCgo21u7sZE1OVqqae300cDoKd3Fr4eui2AuCu1lkkIEFE984K2E7H8V0QAo2T0ySg8irxZMA4CuD+6n93Tt12w9hBkjOwhMlAzrDIHHufpVn8LiF6cj9CBNO+qTCRySW+hQWF82noz1RF7z2QT4N0mriS9Ql3zXH0Wi5ciSQuOsFdZNyEqxbzgA0XxA9TLvp0JO+aYbs2R5I7Lb0oP55SmYv2ApZyEo1DlIZO1OcQzzKaa7MmQiQZtis5MqMnvxIB5byh0KTG2HmU4tn+90nQb8jKKIgbz4TqU5QyYzeM/VERguuHwAlN/+BMg38bljGkqKGlvopv+3SGP+oy7mo3V4DkxTTaOwxGwX///13nVB+deRghoITT6k3yIyMt4rp/9za9HCp+Ygpkh9vJe4vwxTw+y+pow++fYzUV+9QxshWt75OSBvWUbIoSUSARm7j8kjQXrxUguPYd5rChCe+DD9j+M0mNDxBTF0osJ4gVuD3s5PS7nC0vEAYdmuo2ZCaRi77hz5t
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f+RhgWZ8LTgL/FhtQ69XpXtTE0rR4lHlyX7PsVCSmankFkQUY29mI/StXH?=
 =?iso-8859-1?Q?OgEsO+/G95ntAyYdykck2UmMQwDA+5oeT9bRq2RCnQcGr7HEU88CiXBAOS?=
 =?iso-8859-1?Q?zK2KRd6QrlnfevJcDiJOtXCO2S4FDZ5m7NtoPhyB7FepQDFRxdaklO3vG6?=
 =?iso-8859-1?Q?Du4WglB8VnPb24SOjws45GONEvfLcinLtC5fiv+wBRuWqZj4JtLA31Rauo?=
 =?iso-8859-1?Q?Kz1nfTmnsx1XYLqB+TovlK7ujgdSn81u50/+oyybdFMIJTmmYe6F9HXry5?=
 =?iso-8859-1?Q?UeT+MJhl9ovl8EAlt0weob9knW0ennfFgOjhXcz6A6ZsicCiMKSGoucnBi?=
 =?iso-8859-1?Q?/BWoIa5KdEDJpH8LKHpWX0KaQhnLyyHP97aUXEkeOjz7rs95KZ5LZASiP6?=
 =?iso-8859-1?Q?NosklJxDC5+OIHOMpHazQQtvAd+hzygSLtDObxnEZpv0appujC3QnxlvQ9?=
 =?iso-8859-1?Q?Yb7iad5ieTfbJZn6tAvjks8yw4F0kEvj3fmhvYGgyHe7bNM2wZ9usTSCPC?=
 =?iso-8859-1?Q?bJtcChv1h/4qQ4AF6nKiVpaDOH/wXoBbRdV3rGfnXrMxlQWydyvoL/MD/K?=
 =?iso-8859-1?Q?c/TpSzLP3PsETIU7wElLBcXl3bhT9uTRnip8MCH3lvPMLqN4dVz+iGPAZA?=
 =?iso-8859-1?Q?fowmoxax0QCVOmBN7yGqF3zqz9+GViqUnFPhuJ5t+fFoTH+KrEQJ7dqvRP?=
 =?iso-8859-1?Q?yDSC0qyly8Rvq+sEN+Dd4RAgu50OGl5RoBTCCtQHw8RmR68tTnD0Hp7vr3?=
 =?iso-8859-1?Q?DhaJA37/ZY4MMhG7pjxTms5h9rf5+o0zK93SWuTIAjA0E8d1YOusi61V/H?=
 =?iso-8859-1?Q?2wamx7L+xnDVxRDjL2f76OPmHMHJjC9ogbsriF+4xX0Hf+QZ+/5UaJtLN5?=
 =?iso-8859-1?Q?Ifl0LM1RM04BmG64RaZa1y4ZwIJvy2GrFZoi133/MsqMuersR/JsDIIKxZ?=
 =?iso-8859-1?Q?7nMivqjpM/z3XZC0xlvgPe8CFoutB1zXVwG1GD8ZD7/4kleBTcPgxfJbjj?=
 =?iso-8859-1?Q?X8eWJ5j3moI6DCRabNBhk6bs46+FNbz68w6bFSmwLEQ1tZLEpM+gZAyssk?=
 =?iso-8859-1?Q?aa/0qP5VemtxDyJd+38JPzYRZHgYhQq9A3gkUMC5nxtZyeD3TuL4W6BIHd?=
 =?iso-8859-1?Q?WIx2y2KFUigfPLSHVbgrULjvu3lMqwHCyOMh9RV36t3PDAKPr5wJF6dIyI?=
 =?iso-8859-1?Q?kc08o4jB/h2AfAemkb71D2SaZY1+i2ZzCza0yfQ/nygmHA0xoYH1RyadiY?=
 =?iso-8859-1?Q?tQZJgLJgivU7gnRGkfkWZwzlHxa2MTh2VgxWSTmr17rcSCMczVSpKgncIu?=
 =?iso-8859-1?Q?0NWJ4tNTUB+WEQdLRoy8r1BsmpyfsZVIXcne61xvSP5AQqf4CU1DQhG+DI?=
 =?iso-8859-1?Q?ZN3TgAUUnJqcB/QlNm0Wr7xz3MsZKj2isqooIXjL1zh3uaSgpCRcrZqMQD?=
 =?iso-8859-1?Q?hW1mRfXm0iydUNgpgSypwe/03ajZbiUgzMgMCQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-9803a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR20MB2512.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d2148f25-267b-4f59-730a-08da1068d091
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 03:12:38.7401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR20MB2746
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

___Updated test results

These results were obtained with the script I've made to research this regression [1].
[1] https://github.com/bdamascen0/s3e


Main results

The regression was reproduced on:
-several different 5.15 kernels versions across several different distros.
-all 5.15 kernels that I have tried on.
-the 5.15.0-rc1 kernel from the opensuse tumbleweed comunity repository.
-the 5.15.12 vanilla kernel from the official opensuse tumbleweed repository.

The regression could not be reproduced on kernels versions other than the 5.15.

The vanilla kernel test was suggested by Thorsten Leemhuis to make sure downstream custom patches aren't causing the symptoms.
The vanilla kernel test result shows the exact same pattern verified on downstream kernels and fully validates the regression.


General test results for the 5.15 kernel series (x86_64)

opensuse tumbleweed ----- kernel 5.15.12 --- vanilla --- (kvm)
.. 250 files - zstd:         13327 ms @inode_evictions: 31375
.. 250 files - lzo:          13361 ms @inode_evictions: 31375
.. 250 files - uncompressed:  1204 ms @inode_evictions: 499
opensuse tumbleweed ----- kernel 5.15.0-rc1-1.g8787773 - (kvm)
.. 250 files - zstd:         13875 ms @inode_evictions: 31375
.. 250 files - lzo:          15351 ms @inode_evictions: 31375
.. 250 files - uncompressed:  1231 ms @inode_evictions: 499
opensuse tumbleweed ----- kernel 5.15.12----------------------
.. 250 files - zstd:         12500 ms @inode_evictions: 31375
.. 250 files - lzo:          12327 ms @inode_evictions: 31375
.. 250 files - uncompressed:  1482 ms @inode_evictions: 499
debian bookworm --------- kernel 5.15.0-3 - (5.15.15) -- (kvm)
.. 250 files - zstd:         12343 ms @inode_evictions: 31375
.. 250 files - lzo:          14028 ms @inode_evictions: 31375
.. 250 files - uncompressed:  1092 ms @inode_evictions: 499
Zenwalk 15.0 Skywalker ---kernel 5.15.19 --------------- (kvm)
.. 250 files - zstd:         14374 ms @inode_evictions: -
.. 250 files - lzo:          14163 ms @inode_evictions: -
.. 250 files - uncompressed:  2173 ms @inode_evictions: -
ubuntu jammy jellyfish -- kernel 5.15.0.23 - (5.15.27) - (kvm) 
.. 250 files - zstd:         17521 ms @inode_evictions: 31375
.. 250 files - lzo:          17114 ms @inode_evictions: 31375
.. 250 files - uncompressed:  1138 ms @inode_evictions: 499


General test results for other kernels (x86_64)

opensuse leap 15.3 ------ kernel 5.3.18-150300.59.54----------
.. 250 files - zstd:           668 ms @inode_evictions: 251
.. 250 files - lzo:            693 ms @inode_evictions: 251
.. 250 files - uncompressed:   661 ms @inode_evictions: 252
opensuse leap 15.4 beta - kernel 5.14.21-150400.11 ----- (kvm)
.. 250 files - zstd:           811 ms @inode_evictions: 251
.. 250 files - lzo:            912 ms @inode_evictions: 251
.. 250 files - uncompressed:   993 ms @inode_evictions: 251
opensuse tumbleweed ----- kernel 5.14.14 --------------- (kvm)
.. 250 files - zstd:           888 ms @inode_evictions: 251
.. 250 files - lzo:           1063 ms @inode_evictions: 251
.. 250 files - uncompressed:   778 ms @inode_evictions: 251
opensuse tumbleweed ----- kernel 5.16.14----------------------
.. 250 files - zstd:          1398 ms @inode_evictions: 250
.. 250 files - lzo:           1323 ms @inode_evictions: 250
.. 250 files - uncompressed:  1365 ms @inode_evictions: 250


Load test results (x86_64):

opensuse leap 15.4 beta - kernel 5.14.21-150400.11 ----- (kvm)
..   50 files - zstd:            261 ms @inode_evictions: 51
..   50 files - lzo:             256 ms @inode_evictions: 51
..   50 files - uncompressed:    317 ms @inode_evictions: 51
..  100 files - zstd:            450 ms @inode_evictions: 101
..  100 files - lzo:             461 ms @inode_evictions: 101
..  100 files - uncompressed:    471 ms @inode_evictions: 101
..  150 files - zstd:            618 ms @inode_evictions: 151
..  150 files - lzo:             624 ms @inode_evictions: 151
..  150 files - uncompressed:    612 ms @inode_evictions: 151
..  200 files - zstd:            822 ms @inode_evictions: 201
..  200 files - lzo:             933 ms @inode_evictions: 201
..  200 files - uncompressed:    747 ms @inode_evictions: 201
..  250 files - zstd:           1128 ms @inode_evictions: 251
..  250 files - lzo:             974 ms @inode_evictions: 251
..  250 files - uncompressed:    936 ms @inode_evictions: 251
.. 1000 files - zstd:           3517 ms @inode_evictions: 1001
.. 1000 files - lzo:            4373 ms @inode_evictions: 1001
.. 1000 files - uncompressed:   3797 ms @inode_evictions: 1001
ubuntu jammy jellyfish -- kernel 5.15.0.23 - (5.15.27) - (kvm) 
..   50 files - zstd:            424 ms @inode_evictions: 1275
..   50 files - lzo:             423 ms @inode_evictions: 1275
..   50 files - uncompressed:    207 ms @inode_evictions: 99
..  100 files - zstd:           1744 ms @inode_evictions: 5050
..  100 files - lzo:            1838 ms @inode_evictions: 5050
..  100 files - uncompressed:    373 ms @inode_evictions: 199
..  150 files - zstd:           4785 ms @inode_evictions: 11325
..  150 files - lzo:            4660 ms @inode_evictions: 11325
..  150 files - uncompressed:    689 ms @inode_evictions: 299
..  200 files - zstd:           9763 ms @inode_evictions: 20100
..  200 files - lzo:           10106 ms @inode_evictions: 20100
..  200 files - uncompressed:    938 ms @inode_evictions: 399
..  250 files - zstd:          17550 ms @inode_evictions: 31375
..  250 files - lzo:           17337 ms @inode_evictions: 31375
..  250 files - uncompressed:   1373 ms @inode_evictions: 499
.. 1000 files - zstd:         143614 ms @inode_evictions: 101132
.. 1000 files - lzo:          146724 ms @inode_evictions: 100314
.. 1000 files - uncompressed:   7735 ms @inode_evictions: 1999


Load test results comparisson for compressed files (x86_64):
ubuntu jammy jellyfish - compared to - opensuse leap 15.4 beta

50   files gives aprox.  1.6 x more time and aprox.  25 x more inode evictions 
100  files gives aprox.  3.8 x more time and aprox.  50 x more inode evictions 
150  files gives aprox.  7.4 x more time and aprox.  75 x more inode evictions 
200  files gives aprox. 10.8 x more time and aprox. 100 x more inode evictions 
250  files gives aprox. 15.5 x more time and aprox. 125 x more inode evictions 
1000 files gives aprox. 33.5 x more time and aprox. 100 x more inode evictions 


Load test results comparisson for uncompressed files (x86_64):
ubuntu jammy jellyfish - compared to - opensuse leap 15.4 beta

50   files gives aprox. 0.6 x more time and aprox. 2 x more inode evictions 
100  files gives aprox. 0.8 x more time and aprox. 2 x more inode evictions 
150  files gives aprox. 1.1 x more time and aprox. 2 x more inode evictions 
200  files gives aprox. 1.2 x more time and aprox. 2 x more inode evictions 
250  files gives aprox. 1.4 x more time and aprox. 2 x more inode evictions 
1000 files gives aprox. 2.0 x more time and aprox. 2 x more inode evictions 


CPU usage results:
The regression causes significant CPU usage by the kernel.

ubuntu jammy jellyfish -- kernel  5.15.0.23 (5.15.27) - (kvm) 
.. 1000 files - zstd:         137841 ms
    real    2m17,881s
    user    0m 1,704s
    sys     2m11,937s
.. 1000 files - lzo:          135456 ms
    real    2m15,478s
    user    0m 1,805s
    sys     2m 9,758s
.. 1000 files - uncompressed:   7496 ms
    real    0m 7,517s
    user    0m 1,386s
    sys     0m 4,899s


Test system specification:
host: AMD FX-8370E 8 cores / 8GB RAM / ssd
guests (kvm): 2 cores / 2G RAM / ssd
test storage medium: RAM disk block device (host and guest)


TIA, Bruno
