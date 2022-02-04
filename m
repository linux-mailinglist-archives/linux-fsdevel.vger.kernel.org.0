Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70544A928C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Feb 2022 04:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351014AbiBDDAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Feb 2022 22:00:43 -0500
Received: from mail-bn8nam12on2048.outbound.protection.outlook.com ([40.107.237.48]:64224
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229967AbiBDDAm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Feb 2022 22:00:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcYBOAQ3OzALWeKWRaKdZ/zRkRd+EdZznWeIPD88RWZpTf3qHbz4CdtOnPI3+Iuzu0KhZmYE5D7RlXUHjAo/Jpw5+hyATXbB0AwduGold/WzHa1rDqKdFVUDqYmQssrt+Q/ocgwf+51RcTicDwCvoNFKtxm+dYfzEcNSbTqzkbpt6miafAMHK+JKUvBKkS/ThZHf8zaO6Ginv9L9r32802nFsQzINdbBcJjdUmzRBMnL+FPm9vsSTRHbbub6Cx1okSWCOdiJsq/n92RZ6MtoloAr0oGt0DFE4BSdkEL3EOFSOu8tUXo/tz9ot3ay5sNCA3MWkLCCB/DTaOZiOtRwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rMiSFGPZ5PkY1DAbsHPjozSM1oqUlDkTmgh4xcmddY=;
 b=HaXXE4ExoeGqOaBDGj4xznaWVkYeDTzxjMiHeip9fcVXJGFoqzJaEVEhA1YAmkDiWf8ZQFFNFK+0wB+Ny9UbRyB+UiuHyLjmEXQwxA7MR8H5kdr1QQnsdlK/aJSke7+/L0DTOxpYUmSqK6g9edPBeq9f1bSTFP30sf4h2kBxf30yJsvbjxkqd7SYD8wfugfyPmZd8HidFbbOwBnSfdlC/ZI6BV0MEc4VvOv1UWRBM7dLPCtE1gV2/n/l2Dy/Ec2OOjK+2bG22/3/0xnt8WhFUvWXIMqjOdKeebJC8fPDm/fKoZzOvwf3VrdEV+IZcPlqJiGY+UlspO/R1MSX+pOVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rMiSFGPZ5PkY1DAbsHPjozSM1oqUlDkTmgh4xcmddY=;
 b=Q7se6yRGUYAxugeZcHXXel6hnGKOuL5EM8BX6ggLrI2iqeTtMX+67ASYX1n1YjNy70yy+xPETe2naiXXqrhTJWUOD0zsjRzdS2wwy2maj8prgT+s1YK0+nx/ZrvLM/X3SmhR0xk5JEg2UL/2Bg8bK0jocJhWAvyAql4dfxAkl7Z53UVi2dUG37MGEIDeKQG+fLHGtGH30pdslxWLX1P3kOBnH+fz8bXLCrlW17MTur8fYHLINiWbvpgbZIP96lKYfW8w3AGUJgFyzbJSeJgOSLGJqc5UcM6AQnU5dYYOFl1T1lqPgDtJnbw299dcx0VaK/WDubKFkLIgbUyMVscEtw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 03:00:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 03:00:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
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
        Kanchan Joshi <joshi.k@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Topic: [RFC PATCH 3/3] nvme: add the "debug" host driver
Thread-Index: AQHYF5pGTuc0vK6aW0WDOYv4vbM4lKx/xVyAgAI7dYCAAAKFAIAAN5GAgAAXUoCAAGVZgA==
Date:   Fri, 4 Feb 2022 03:00:40 +0000
Message-ID: <a281a539-6892-d7e2-cff9-57b5f3c22373@nvidia.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com>
 <20220201102122.4okwj2gipjbvuyux@mpHalley-2>
 <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <CGME20220201183359uscas1p2d7e48dc4cafed3df60c304a06f2323cd@uscas1p2.samsung.com>
 <alpine.LRH.2.02.2202011333160.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <20220202060154.GA120951@bgt-140510-bm01>
 <20220203160633.rdwovqoxlbr3nu5u@garbanzo> <20220203161534.GA15366@lst.de>
 <YfwuQxS79wl8l/a0@bombadil.infradead.org>
 <alpine.LRH.2.02.2202031532410.12071@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2202031532410.12071@file01.intranet.prod.int.rdu2.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f614316-f7af-40f7-b303-08d9e78a86d6
x-ms-traffictypediagnostic: MN2PR12MB4423:EE_
x-microsoft-antispam-prvs: <MN2PR12MB442307FA39C82A3452A3BE6EA3299@MN2PR12MB4423.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eMI77ym5lVmVvvtJte874ebZqEQys5dbJVoTT+Gh8L0RtoR26KH8sO9pxUnR//2PN7LMeG0L1Xiqjpg0sA/m/3LN0bMdulCSv9BDmoM3BW2Knpbpk49LQiAWYeI7IyXnNonJ0S1LmS6LT1iA5o7WSCIbO1UqEFWgjgvo4YNb45WGlvwuFKP0KlOZwOcV7jeqXNmj41UMzLgqo98wvMjkVtoT0MAtdYLj6j7PbDe6TQm/eansI+qe+rVgmUUZyQIkoSJcsJXOdsfhPLxFXjpIzCq/GqvwkphSdLF8TWRX5AIboWZ342ns2x4p6gOaUdw16Y6HMdFf4oLtZjx+4+OV8dgsxyRKIliyG1UgFYCHrrzdN7iH+RfaWWiFOkTB1u/OfQU4AnKQ1APDLFJge3KlEeoyvRbUgalRXHixfJxf3XGPBc87FMIMeAvLdefeqwrE0+F8aCE695xdxzH4bKcMQ2Q3sWo7ySglSLroK/FQWNUOChxIyjwbP4ZjgdEKRqxL9Glp9qkzfqSCgJk5TKX+LAHJTnJxZO41NjVXKGw00VVSaCPdlHpaJWYpHeUH0OSYjriJLscadSs8ObPXKVmgDjv09HQB/k5G98Z/ZSaIxtX6Pu+JsvVFDwBFi83rGR6oXoRv/fd/XWKQMaEIDUtWrNMqIjaE/B4r2UlyY/TciL7aoPg37zRem5l1MFkZwDWul8POsdSXU6hq8cyXCTZi0iEc5wLGMNEZXINVr6pvpOcyCS2ddziRAGmqLQQgP2wt/kWXVk9+t9W6NbQYmNv/2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(7416002)(6916009)(38100700002)(86362001)(122000001)(508600001)(6486002)(5660300002)(31696002)(2906002)(38070700005)(76116006)(316002)(91956017)(66946007)(66556008)(66446008)(64756008)(8936002)(8676002)(4326008)(66476007)(186003)(2616005)(53546011)(71200400001)(6506007)(6512007)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmhaMjFQNHhGUCtvMHROYy9NOTl1Q2xrME10cmxGMWJTU2tEVk10Z0Y0bmh2?=
 =?utf-8?B?TGs4bEM2MGlCaEwveEpRTGdSTjAyWTVOYkNyOUlrQ3A4SXluaW9XdjN5aFNr?=
 =?utf-8?B?RmhxVlVPYXJJbWFZdzdUbkpjVDlDNUcyejc0R1NmK3Nnd041QWFBSzgrYUo5?=
 =?utf-8?B?K1V1TnNteW9qdGxEc0llUmVobitjK01TSDF0ZGJPQmt4ZG5yVkJrMW1wTVFx?=
 =?utf-8?B?aDdRMWdpUXFtTWh4eDdEWk0vdFppdWkyd1ZPd1RpdnFRV1A3bjUvcHVaSWFt?=
 =?utf-8?B?Yno3YTQwcEVRNXpQMHdGSStzaWxVeW9VOEM1a2x1QlB5TDRNOGNrdUhWOHF5?=
 =?utf-8?B?c1Nkb0xQWXdDZWRnQzN0ZTE1SVg0S3JFVFk5RVpROHZsbWxQWTBCNE9STnRn?=
 =?utf-8?B?ZmZjOHBVUzhyQUhIbmJ6eDJPL1FzM0xJTWdia1djV2kyTVVUeU5FdVZXczNi?=
 =?utf-8?B?QmFVOTA1Y0hXVmdWSHhtdDI3Z21FeFFDbFN5RTFiWUZtRFF3YUk1ODFMaFpy?=
 =?utf-8?B?Q0Z0Z3BaOXlUckE5NHcrZVdPQ1ZIbDIvWWZOSkJ3SnZEdDAyckVDc0FRY2hN?=
 =?utf-8?B?cVN6RTdVcUlXNi9HQkduWFJOU0FlWTczUlJ6L0FoZWVwNmRGNVBPbkw4azRP?=
 =?utf-8?B?VUZqVHdIRFNkaEd2dGxqUjNHbzdEWDBJY1BBRU4zWkdZWGl6Y0hhalpHbzlZ?=
 =?utf-8?B?b1AvYnhJdXk5OUM4ZFlLNTkyK3VxNGRVaVJtOEREdlJlKyt0SVNDc2ZwSzZE?=
 =?utf-8?B?bjNSNWdHMFl4eTN4RWpOQUhTOHMxU01iNG5HaEV0ak9GbVN1ZzNaN2U3dmlp?=
 =?utf-8?B?RlNUajFJR05sV3JGVjdpdXdYZ2thbDc2TlZVZWUwdGF4SGtnQUlieUdoQjc2?=
 =?utf-8?B?YUNTMkpEVHRIRWFkK21lN0Y0amtaMGRBZG9MSVlqcC9yWFcwNGFJMjhyNHNN?=
 =?utf-8?B?UGs0ZlhqUHdNWWRSdUdHZFdibi9JVmE3V2Zsb25GTXZyeGQxWmxIRStWTkor?=
 =?utf-8?B?T1hnZmZjZFRSVFVJYWtuR2xyRXdpcEZ5R2UrTE1GVzBEVkFFMUtJRi9tNGNk?=
 =?utf-8?B?WXZnMU9Db012YUsxMWM1UzUwWkFtaUNCVnc4RkdNeWdnb21pNWk3bjZQa0lw?=
 =?utf-8?B?R0tPdVBWYzFTQml1bTBGVnVZVld1MlczZ1FHanVTMUN4QWFieXQyWm9ESFVW?=
 =?utf-8?B?MWhZZU9UV0tleGZJa2NXNjg3citSendyL3F5enhUdjJtWkZHN05hWVZsMTA5?=
 =?utf-8?B?d3JmaE9iUlFFNDBPWjl6UEFPNlFMa0Vua1AvSCtzUDh2RHpPWGhrNlZ3NHB0?=
 =?utf-8?B?QlBUaG9CNG1Ncm1EejJ2WWtibFBaWUdtSGNqeFhDY0pqTDdDWW5IZXNYTGpE?=
 =?utf-8?B?VTc5ZHBPNVpMYXVUMkpVdFl1UStjMkVJdWltZ0IxcGVHbmRVcVdoNWhKMFNW?=
 =?utf-8?B?LzdwOVYvYkZZeERtSG5URzU3MjloVHVPMmV3SjVKU1R4alE1SHlRbXlreHJ2?=
 =?utf-8?B?dWw0aSs5T3RmM3k5UDZhSjRiUWFqOE5nYmxqajhxRjZLUXpEMkZvN0hxa3hQ?=
 =?utf-8?B?bkFneWNMU0ZzdnEwWkZSVW1GbXJCVkhnODVycmhpL2J3cUhYZ3VjNXpuaTdD?=
 =?utf-8?B?azlVYksyZkF4RklHVC85enR3NnlpTUVwcHp4UE1hTUJHSC85b2kvRmtCcnlv?=
 =?utf-8?B?UytRT0FCT25tSXl0ZUcva0dRRVE3cWMyMGhsS1B0ZndpSGxrZ0VpS2FTRlpD?=
 =?utf-8?B?UjhVMWVYMFk4dFFJRXRaU0paNTRYTmxHN1VabUFtVDR3VEN3cjErMUFCdjhD?=
 =?utf-8?B?T2t1Z2RjRnRtc3UzL1M4TzVRK1l1ejJTaTk0djNMUmVLTDhLVHNqUVVKVHVk?=
 =?utf-8?B?NTE4MFQ2NldLd0JML20va2hvYnpGTFJzNERkcGZ1dm5JaWpmbWIzcXF1dzFn?=
 =?utf-8?B?SCtMaWthQ3N4dEtULzE0MERPYWpCTVRVWEROMGNWbXFsV09mYTdtcXNDbDRJ?=
 =?utf-8?B?UnM4S0NmdzFsOFRjYm55Y0pIWXZEZjdGODg3ZjZLMG50VGxWVHlWU1lVSFFj?=
 =?utf-8?B?UGgxSENXM0hBR2ZpZk5FeFBJS3AwRHJWdEdnQ2FoSUlVMk1ZWTRLOUhLbjdy?=
 =?utf-8?B?cWNDZVQvZmZTN2NxL3Uwa0x3VXpCYkxDRWlJMk1yRmNRWTB2eFdEalNTMnJq?=
 =?utf-8?B?NkVlRWdUVmVJTDRqZlZmTjJmeDBCSG5TSDhSTXdYY1hrVXhONERCQkR1R1RQ?=
 =?utf-8?B?aUhDSFdZVHFFUnNYRGhEZjJ3d2xBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8006ECFE16596F4AB76CA6E1CEB451A2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f614316-f7af-40f7-b303-08d9e78a86d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 03:00:40.1950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U0+FSGbxQAHm4WLzs5DrZHjvnQQaZ1OwOMdeYdvqn9BZynmSRCGvU5MDfbLxjixssci4P1/Py1SzMfW/ehX00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TWlrdWxhcywNCg0KT24gMi8zLzIyIDEyOjU3LCBNaWt1bGFzIFBhdG9ja2Egd3JvdGU6DQo+IA0K
PiANCj4gT24gVGh1LCAzIEZlYiAyMDIyLCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOg0KPiANCj4+
IE9uIFRodSwgRmViIDAzLCAyMDIyIGF0IDA1OjE1OjM0UE0gKzAxMDAsIENocmlzdG9waCBIZWxs
d2lnIHdyb3RlOg0KPj4+IE9uIFRodSwgRmViIDAzLCAyMDIyIGF0IDA4OjA2OjMzQU0gLTA4MDAs
IEx1aXMgQ2hhbWJlcmxhaW4gd3JvdGU6DQo+Pj4+IE9uIFdlZCwgRmViIDAyLCAyMDIyIGF0IDA2
OjAxOjEzQU0gKzAwMDAsIEFkYW0gTWFuemFuYXJlcyB3cm90ZToNCj4+Pj4+IEJUVyBJIHRoaW5r
IGhhdmluZyB0aGUgdGFyZ2V0IGNvZGUgYmUgYWJsZSB0byBpbXBsZW1lbnQgc2ltcGxlIGNvcHkg
d2l0aG91dA0KPj4+Pj4gbW92aW5nIGRhdGEgb3ZlciB0aGUgZmFicmljIHdvdWxkIGJlIGEgZ3Jl
YXQgd2F5IG9mIHNob3dpbmcgb2ZmIHRoZSBjb21tYW5kLg0KPj4+Pg0KPj4+PiBEbyB5b3UgbWVh
biB0aGlzIHNob3VsZCBiZSBpbXBsZW1lbnRlZCBpbnN0ZWFkIGFzIGEgZmFicmljcyBiYWNrZW5k
DQo+Pj4+IGluc3RlYWQgYmVjYXVzZSBmYWJyaWNzIGFscmVhZHkgaW5zdGFudGlhdGVzIGFuZCBj
cmVhdGVzIGEgdmlydHVhbA0KPj4+PiBudm1lIGRldmljZT8gQW5kIHNvIHRoaXMgd291bGQgbWVh
biBsZXNzIGNvZGU/DQo+Pj4NCj4+PiBJdCB3b3VsZCBiZSBhIGxvdCBsZXNzIGNvZGUuICBJbiBm
YWN0IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBhbnkgbmV3IGNvZGUNCj4+PiBhdCBhbGwuICBKdXN0
IHVzaW5nIG52bWUtbG9vcCBvbiB0b3Agb2YgbnVsbF9ibGsgb3IgYnJkIHNob3VsZCBiZSBhbGwN
Cj4+PiB0aGF0IGlzIG5lZWRlZC4NCj4+DQo+PiBNaWt1bGFzLA0KPj4NCj4+IFRoYXQgYmVncyB0
aGUgcXVlc3Rpb24gd2h5IGFkZCB0aGlzIGluc3RlYWQgb2YgdXNpbmcgbnVsbF9ibGsgd2l0aA0K
Pj4gbnZtZS1sb29wPw0KPj4NCj4+ICAgIEx1aXMNCj4gDQo+IEkgdGhpbmsgdGhhdCBudm1lLWRl
YnVnICh0aGUgcGF0Y2ggMykgZG9lc24ndCBoYXZlIHRvIGJlIGFkZGVkIHRvIHRoZQ0KPiBrZXJu
ZWwuDQo+IA0KPiBOdm1lLWRlYnVnIHdhcyBhbiBvbGQgc3R1ZGVudCBwcm9qZWN0IHRoYXQgd2Fz
IGNhbmNlbGVkLiBJIHVzZWQgaXQgYmVjYXVzZQ0KPiBpdCB3YXMgdmVyeSBlYXN5IHRvIGFkZCBj
b3B5IG9mZmxvYWQgZnVuY3Rpb25hbGl0eSB0byBpdCAtIGFkZGluZyB0aGlzDQo+IGNhcGFiaWxp
dHkgdG9vayBqdXN0IG9uZSBmdW5jdGlvbiB3aXRoIDQzIGxpbmVzIG9mIGNvZGUgKG52bWVfZGVi
dWdfY29weSkuDQo+IA0KPiBJIGRvbid0IGtub3cgaWYgc29tZW9uZSBpcyBpbnRlcmVzdGVkIGlu
IGNvbnRpbnVpbmcgdGhlIGRldmVsb3BtZW50IG9mDQo+IG52bWUtZGVidWcuIElmIHllcywgSSBj
YW4gY29udGludWUgdGhlIGRldmVsb3BtZW50LCBpZiBub3QsIHdlIGNhbiBqdXN0DQo+IGRyb3Ag
aXQuDQo+IA0KPiBNaWt1bGFzDQo+IA0KDQpUaGFua3MgZm9yIGV4cGxhbmF0aW9uIHNlZW1zIGxp
a2Ugd2UgYXJlIG9uIHRoZSBzYW1lIHBhZ2UsIHdlIGRvbid0DQp3YW50IGFueSBjb2RlIHN1Y2gg
YXMgdGhpcyB0aGF0IGlzIGNvbnRyb2xsZXIgc3BlY2lmaWMgaW4gdGhlDQpOVk1lIHJlcG8gaW5j
bHVkaW5nIHRhcmdldC4NCg0KLWNrDQoNCg0K
