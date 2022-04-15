Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2E25024B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 07:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349890AbiDOFtF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 01:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiDOFtC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:49:02 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2046.outbound.protection.outlook.com [40.107.96.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC26740A20;
        Thu, 14 Apr 2022 22:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwA28g/vQTNduBROKV754mUMzxIhkxw6nhWNj9LXK3pIMDgmRN7mCojVpzi8zsQoP1Yq3CEnrn6/DNPk2DDYFaZPRGAwNFKwn1Pq3G3w7dpaywH9QGkj11HrbRneYJ5bznkbVLzD78VcXOXoYrP2bakk/PGh0VwJA4Jf63GlolTQLsL4e4ILrTIhkx6BOOL8g9WCKMgv/JADC39HYFKFJHR+Xs8Z4VJIKHgWSU7Elhu3rKxYf6cfyucUT4kTaG/cfr1acIY5lHwA2ZbGDGD1PIRBCgj/l70+kicabB6oXcB+88dKvQD/fcQLbNlbrQdMnBiZHJQOzRIXF1bNzwmhow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll6nOnUsFN4t09CavEjEFdgdIftb6EE+wpAq2T7XWI8=;
 b=lMTWH1XE/HfLoP+K10KfKTFl7wnlFMUUhM6ymMXSZoauF0qSaabvuyr6VHKB1e0qtc5D9oSNZpOgvS9SHiJZ5I/55B94I5TUERwQyzvKkDT/pFAIhh4NvukL20JDy121zF3f/val+9tGkpVGKW58Sxcw4qimPomTzT5PI9ni0YcAj7QYz9pprCA1nEcusFpsaPjaS8Njgb4rcrkTCBzHJFz0Zp/2nWQAWiE4yiaWSo2d8oxbBTqtzofw4/UavFaApVVBo7xEuOasRSnClPQhFlz46d5GmdB72ALmMZ5V64XIcEvthNEg0cQi3Af/HFUSgoc59EIBBpAcPs2nKEkQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll6nOnUsFN4t09CavEjEFdgdIftb6EE+wpAq2T7XWI8=;
 b=ppRLTkwLk6uegRJ2kfkGhWth1BBuonhTnRrzZ9Un7tjuB0GULPSRiaczQgUkJsyzpYnevIx+ZFRiDRhQIR/udWanzMKbOuvh6xNUzIgKfw2LeV3XTqYPKNm9KrNPUr/EqJ+v8Vu8lBWcpvEWCKdFTiZu8/Y/bpycbLdnGnMpP74amXzuPEo6m2kAo+rfWauBp/tVU7gLcfg+1KAVsP7A4GLeLtKoyI2G+ClrLlQuWeRfEigiQd6QWBHxQYpzbWto1yEQT43IV17ysfDx3I713iJzzSIELWtCGagp+9269anNe6S76f29QxYfpaZYBOBHZk6za0WIxP/ECbVELFUhpg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR1201MB0169.namprd12.prod.outlook.com (2603:10b6:4:55::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:46:33 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:46:32 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Coly Li <colyli@suse.de>
Subject: Re: [PATCH 22/27] block: refactor discard bio size limiting
Thread-Topic: [PATCH 22/27] block: refactor discard bio size limiting
Thread-Index: AQHYUITpUnTHchxryEq5+LCXZWuKpazwd0gA
Date:   Fri, 15 Apr 2022 05:46:32 +0000
Message-ID: <d3f73a4f-0d45-6627-7878-9b5acd47842f@nvidia.com>
References: <20220415045258.199825-1-hch@lst.de>
 <20220415045258.199825-23-hch@lst.de>
In-Reply-To: <20220415045258.199825-23-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9b589c8-cb4a-4ba4-a30a-08da1ea34bfa
x-ms-traffictypediagnostic: DM5PR1201MB0169:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB01695F76C1A4B9A7D05A3F7AA3EE9@DM5PR1201MB0169.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VOFzXF/s96NsYbBCYoyP+Oqyrbo7ZvySarnLRF7ZTp6sy8qxvAl38W1b3iHUqaUeX8qz3GMN+qFT0JGb0/6aWm9O+1hhIvw77xbO2yTllmJhR3Lt7TRH8Ih/6krLUtCDg/KLCzdP6EtLbWyHqJsFOBk9QZi+Jdf7ktdltvMZdfTGcqg/GtsHXgwytDp3/3BHa7RZv4CMTRiforweHkzX6rhZQUbhHXfX3qgCVX6xsn3qBMqbPW72/h3/tu2p+WSmKmb+LaYHADTssjdesb9wusH0HnmLfZC9hd55NDHkhwSEJjghkUvRMFQEsh1KvVKoQrtB4DjUg0ZSApUd63FFA8xt4OcLIcOO4PsN/sjBxXjGQ2cb5r8PVoRu/yNjyv84c9yC8f3gy1R3gnNW1Dqu/ZUkIvw9SiUkDg6U7dY8UbecAYBhZRsHGUtUViHiJYON3dSfvKaGX38RUIGG/yPM8FZYYuawjdoDNL12/MMR+hJLoT/hZdl1lu1rPaZ4VRRpoA1UcaS9qeldpb3c4xeQpV8TgRcsZg90HoAPRNpCSKfJSJsWhFB4kAw1XUX8sXUpXgykfyTR5h1H6A3x3h5VO5n67XpNrSc2Tyf40kCZfPcYlFZKOOT0O/4XuuqIY19aXpXjjtrIodvoM0aI+cWoOvLmovj0zTEANUyleszRXiElvmrFroYc9epemyTr2r52FDFSLyKlBX4s/B4IOrGsWKtBYUWQ9RaofryxfBm47b5nk+dodGVkY4HSgZN+2dDventXpgL6bl654kMamsVYVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(110136005)(71200400001)(64756008)(8936002)(83380400001)(2616005)(31686004)(2906002)(38070700005)(316002)(6506007)(53546011)(6512007)(66446008)(7406005)(122000001)(186003)(7416002)(76116006)(66476007)(66946007)(91956017)(66556008)(508600001)(36756003)(5660300002)(54906003)(38100700002)(6486002)(86362001)(31696002)(558084003)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVdCWElBQWNxMytqeUo1SThNS2NFL2FaVitHUUNldkxvMDllVVZIbXJhWEhP?=
 =?utf-8?B?YWJWNzBjSDY4TTZQVCtNTXlZVzR1bzNOalJkVVZwTXFtZUt1ajFleFZBUUFr?=
 =?utf-8?B?WnRUM0ZlYU9YOVZ0bWRLaEZKY2MzbjRYVlFuaWliMEZpRkpwOWVmMHRGUU8r?=
 =?utf-8?B?R3BORVRldHVHMi9HVzlxa3Z1Q1JzUmwvYlUwdVhKK08yRTJCeVJ3L2xCUHBs?=
 =?utf-8?B?VHhpSXh5cTVuT0RPYjJZWHMxcVJXV3FxZjQ0QTc5Rys2a0Y0SWgzazdZY1Jy?=
 =?utf-8?B?S2NyWmIxM0VIMFBOWjRVUjlkeUR6VitGUXRiZElSTEQrRXhMa3dOT0ZwdmZv?=
 =?utf-8?B?aGJ4S2pFQ3N5a21FZGR3V0wrOXlTQytVamVOb000cDZ1K0hpL0NMbDlSdmlV?=
 =?utf-8?B?VG1CUXp2eHRud2d2STJxNVYxZllxbTUydFQ3ZkV6S2YydXAycVhDL0ttbEdo?=
 =?utf-8?B?V0xCbi83cW5MenBkWG5vWnNKQVl1YzdDTi9lelljK08rcjdwMEMvT0p4NmpQ?=
 =?utf-8?B?cE1nUjNBOUU4d29MeGxYRFNKYTRsMElKanNwSjdKYktpa0VRWXJOK0tEODJD?=
 =?utf-8?B?SGNkaXJKdlNZQWdQelpJWTlwdStHeU1sekV0d3RPOUlrbHdCTGV1UTV0Ymkx?=
 =?utf-8?B?aWg0eXdjQzhGK0FkVWkybGs0eTQvOWk5UkJSRGp5ME01dmFqdk5QME9tTHdS?=
 =?utf-8?B?a2dNeXZ3aGk5em90aUVSeEdGcFg0SldKQ3hOeWtoQXlFQk90bzdrM3o0R2Z5?=
 =?utf-8?B?OUdGdXJ4N0w3eXlRQWllSWhJR2hNZ25MTFlsaE80emU3UU9WcFZlTTU5eXNQ?=
 =?utf-8?B?OFZ2TUoyY2Nkb1UraHVxY3VlMDdLNjhBUWdEUzk5ZlRhTU9iczRmSjA1c2hC?=
 =?utf-8?B?Y2lqSDdJa2NXclZBSzRYT3RYVlNSQzVJZ2V6RkhadytSRkxzQ1NWbFJUNFAy?=
 =?utf-8?B?T1FlR1FPckR6d2g3bjJWNXl0emJVK1NVYUVaakc2RElBSTB2NDB6SDNKL1dp?=
 =?utf-8?B?MmQ5TmM1b1ZQVTkyVGZraXJaNHNMVkFMeXN5ZGUwMFdjWUZvZmZHdGh4ZmhC?=
 =?utf-8?B?K2JnQjNseU5TZXQxd1hTdHd6T25KYUFsd0h0ODhZcUpINFB0cFBtcGp0L3Qz?=
 =?utf-8?B?Mk5GaXBGbHJVNUJnMCttTm0wZUEzM2t5T0cyLzhOMThyRGpwdG9xQURzMnFF?=
 =?utf-8?B?dDRJRm1UaXIvbUs4MWRQemM2SERMUHI0aDVndEROcVRNTFRpbFNkYktiUE5P?=
 =?utf-8?B?WndUdDlYUW1EeVR4UE85Q0M3dlVza1ptaXdvblVlVnhJbC80S3V1b0Njcjgy?=
 =?utf-8?B?ZnFtKzRTMU5KNEx0ZTR5ZUtCY2ZOcjdVZ2N1VXV5eGJ2eThLbEZaWkxQK3d5?=
 =?utf-8?B?UWQrWS9yRkxISnhPbWRQN25jdmFOSzc4SWhpaGxGQjA2bDFIaUFlL1ZjeEkz?=
 =?utf-8?B?OWxOWEVCZVZwMjFVVm9XeUVIZ3VYVWIxUWphZTMvb3Y4eU1URVluUzFUYTBX?=
 =?utf-8?B?ZkFsVTVqaGJhM1VJbFV6UEE2MGlad2RxYmtuR0tiV29PbU1BYzM5cVZIZVV2?=
 =?utf-8?B?VG16N2NlQ3ZBWk1tbjUrbXVOTDFVY0d3VEMwRlg2N0drTTUvU0dEd2tCZHo1?=
 =?utf-8?B?WVBxT0Q4RFdLRDFKVEVDUGxHbzBVQVNtVmI0cG9HVzhzTWF2RllZRXVybEZt?=
 =?utf-8?B?TGNNNkRLMUZORks3S2w1S1dEL3R4QjB5cnBHUktqd0VVNjlRc1UzeUxsTXpT?=
 =?utf-8?B?MzN0MmdWODMySXVwOTVFTHJxcE5TenVCdUhjemliMzdlbG1SNnNsMjgwbDJZ?=
 =?utf-8?B?TWxRZjFucURhZ1VXV1Zmd3B5VW9HRmdNcnBvVS84YWRBUW9OdGxzVzRFaWRH?=
 =?utf-8?B?TmV1Z0VHSFU2amdPNkxoODBWOUlRaE40Z1hVTUNpNDU0SDIwSkVDYlpXdys3?=
 =?utf-8?B?WEs1S3JMRXNjVGJpMWp5czBMTjZ2RWJzWExyS1JkZ1VCNFQ5TlUxSU93c3NP?=
 =?utf-8?B?Mm91WC9HRmhSejBlRWJFd1F5TnlFcmFQNWdOdDgwR3JvTW5yTWtyOFFSb0Zx?=
 =?utf-8?B?UTNDaFluaHBJU1Zwelg3VEhYU3ZjdmFlallmVVRkQXhjeFZhdlpWSmpyMEw3?=
 =?utf-8?B?dmliaXV0b2V1UzdXbmppby9YUDZVSnRHRTNRaTIwQ1N6Q1pTZFBtamdlY3ZW?=
 =?utf-8?B?bUorTXBOZ1FNY3krQWkzdVJHWnFJSStBcG8vTm8wSHV1TEd4WkZhRk1EN1Fl?=
 =?utf-8?B?MzVKWTR4S2lMYTY0OGtaUW5oUHNrRlBvVkkvUjB5M05teVVnVExvdGRjV0Nj?=
 =?utf-8?B?SElQTElOcHVCRnpKQVY1S1NEUEtUenRhbjdRQWlZWTMwSDIrT0c2UFJpT0t4?=
 =?utf-8?Q?R2jwV8YoRmuWle80=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C40943C50889249AD34D58B6AD3A631@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b589c8-cb4a-4ba4-a30a-08da1ea34bfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:46:32.8003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ASbusO8W34q0zkWuXk1qiivnBz95QaMhMAdwYhU6fcikvNpkn9x0Er0VaGbVy82Z3hkljoFFymMKBrM9EwUVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0169
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNC8yMiAyMTo1MiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IE1vdmUgYWxsIHRo
ZSBsb2dpYyB0byBsaW1pdCB0aGUgZGlzY2FyZCBiaW8gc2l6ZSBpbnRvIGEgY29tbW9uIGhlbHBl
cg0KPiBzbyB0aGF0IGl0IGlzIGJldHRlciBkb2N1bWVudGVkLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFJldmlld2VkLWJ5OiBNYXJ0aW4g
Sy4gUGV0ZXJzZW4gPG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tPg0KPiBBY2tlZC1ieTogQ29s
eSBMaSA8Y29seWxpQHN1c2UuZGU+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1i
eTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==
