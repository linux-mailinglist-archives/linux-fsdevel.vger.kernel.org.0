Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC656773B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 02:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjAWBAG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Jan 2023 20:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjAWBAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Jan 2023 20:00:05 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3A912F30;
        Sun, 22 Jan 2023 16:59:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYIZpCgYGHSBybMNosVMM9g0TuVlngBmVoVk4CJgfVmpC5bBRZKLtYQxUCFi4QZkSV1yImmxfw/OER+eWh22yhf2X1ysuSmpiKoIJAuLtHljES7d0YfdFeoj6uFWgXUYqSlEDKlnGXF4RC70Aqk1Tc6RoMFaHao+SSF0lfonH+/UI886gz1YE5Vt+sYPxT1C0FoBaKymKek/Ui2iI7oQP11iPCrRYdKw7dGUjAgww2xCSZbaEOEqJ2yFbcwA/3VHaAMo+7aa1px8OqOqXYRaDMXYrykrBEH+J9cgHOVauFwf5SyZEsCGYqr/nu82hI7vLeCHtbSyvH51zJ1RtAMt3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+KFjfesObm3WW5AWlzfGZlbu09MQxzrXfocmCr2N7g=;
 b=Duaq0DIvw7kICwrl6K9XmydVVm1YDzoIh+fOyz44Q+UUXypchaJKDIiTYmVSokKzrwqIcXI3JViGTzJibQb2bBr1QWrsfaG1WabHTgSyHZmZ8+QnTMT0EieMpnR9zCM9addkQzbjhZs78BagSHx7V7EPu+A8pb33D4hKkremwZaY48fGLOrzVk5+tLkgkCZBFhugPAHg4AC82rdUQa5fuM6uJklpS6b6KZ0/dfCqpdUM8ogrRWLxwH9L6EoymyYCI9u7BKpX1vRD6FrOuHvV8gy70nfN6GUS2oqC6FgUNNJRcyrORhepE3/h1mP4xoBOwvbBnqCAYKfHCSkLqrUSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+KFjfesObm3WW5AWlzfGZlbu09MQxzrXfocmCr2N7g=;
 b=LGLnaAGttJRtNWRP9T14PmAIutm2O66rIFKEzkA2xmU5U2xUidTvoeiMJ7sYQshjmZEjQtMkvVKIbtEQH1NglASEtAxZbK4s8643BrpV6i+Y5/JQ5gYL78HbvnsmfIXiezLihaPdTe1bLEtpFnz+D1BA0U0MlCpvCsYAG3Rj2cuYh6uf+aWzkxxBl9zCFE8+VDnm0t9bsOrpFNzz7I7Wo/bFuwERn7Ijmbs6ImUu9kvG9hZTdCXFTyXTpcWeT0YjzJSkG+IwWff6nIPotYpuRCWAzS4OzfX02EfNywabwJSDNU6KKbhY4JLkVkUahal7kzImRFyTOnoQEVmRW5v49A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.27; Mon, 23 Jan
 2023 00:59:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 00:59:47 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org >> linux-fsdevel" 
        <linux-fsdevel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Theodore Ts'o <tytso@mit.edu>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status, an
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status, an
 expansion plan for the storage stack test framework
Thread-Index: AQHZK5fy4D60HvoJAkGWFwtQ6nnwK66lAiUAgAYyowA=
Date:   Mon, 23 Jan 2023 00:59:46 +0000
Message-ID: <9a8c1645-c4bc-728e-6002-ae6986286c56@nvidia.com>
References: <e24383ca-8ba8-3eb3-776c-047aba58173d@nvidia.com>
 <20230119022056.plpe5wejji6gl3fp@shindev>
In-Reply-To: <20230119022056.plpe5wejji6gl3fp@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB8517:EE_
x-ms-office365-filtering-correlation-id: 8b1056ca-b516-4f69-aa10-08dafcdd1f45
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ceh3TeHXQLnkHPtdtlBJeA6YB0aKpHo5VCYBAGZQdMSExyFEtNvbl7IR9vcPFYHWWkRT98slm0BZT0lilwZnaEt6z+jXKsd/SybXJyLe+jlxsx0S1c1i+ccD4L5bOLDPaPHPfbS3xlXAaa6OV3+bvq7SS3MXwLrVz8eLV8nq5H4S6ZQsIu10NUU3Bcrl/EYq3zavs1F7U3+JAJtUKBtNULHYfwRwWI4/hNTYWyXbWnppBodobPl5w7wwffi43had5hMfI9oeZmVzz3qErR4INWgM9nSHNuNorbaaDycqzCS7P/c76IWNOIIeh4hAcZf3rNJi59BbXHdATsvMdY3VyXoBg6PoxKdDNk9IM0cPF1FLyTrWh5IWBJ1C/3nycpldXruTyGYq/qqSXNmIzcZBy4kyRrdW1A1SMXd+CVZVo+wFa7KfkmEZ41k92E05WummJTOilbQa942qo8OvneT7S6HfqJVGAV2FX11h8UUTVluiDDPYayFkARwfI88WKZHevfsbB8cOra24nVdc5D17KUsoyQTxK2+CeB+ccpxocE6Eu36ygkT8B7U9CeEoWMPW4r9GXgB0fV98c8OiWtlj2uD70kwZDg23bsvV5R0fmLJ0Gm088hAVt2O6zUgNJpbZwQlCQ+rImm/kcb4SXQgO3C1puPS9+3Fdp/lyU85eeQy0pZ4IviDubGwtzIu4eJC0pX+TncttcLe08+tyIx5keV2wIUCzlerrQtQJ946W+8kzTxy5goLsK9++0XV5HpNHX1XFct4dCA5CC6F2Tl83/X6elqEBgO13gDbLZ4fvduHGF96JMlDbpDzb03iECF9bjeqTXMmu5Ye5WcUOfmSelhcMbPHjwiphTUm1YkIUicw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(8936002)(31686004)(4326008)(7416002)(66476007)(66446008)(8676002)(64756008)(66556008)(66946007)(91956017)(5660300002)(6916009)(76116006)(53546011)(71200400001)(38100700002)(31696002)(478600001)(2906002)(6506007)(186003)(6486002)(36756003)(966005)(2616005)(316002)(122000001)(54906003)(6512007)(83380400001)(41300700001)(86362001)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEhYSFlMMWk2eHdGSklhVVFHbENHQW1ZdTljbERiOUFZMFR1R2o2N3lCYnJp?=
 =?utf-8?B?ejNGUzZaTW1mTVlBZUpMUVFmNWdoemVWT1RZMGQrQVZMVi9CTmNMcmpCM0lv?=
 =?utf-8?B?RVVFVk5jeTZmVmlnTDRmaUpQSE1yT3NiR3RSOE9wMnRrVGdrN3A2WW9VbldD?=
 =?utf-8?B?V2dvR0YzSThSWk1tZmtLRmx4S2RyQ2tnL0praXdDRE5zRUZLQ25GZWtMMUFz?=
 =?utf-8?B?a2pYbDJYU1BERC9oNGdmT3l4MTVDdXNlTkxuckpWUlhuVUJFdDc4TzhCT3gx?=
 =?utf-8?B?YVBUSjkrOFhGR3FMMVVmRUZ3M3JVMkFsYTFFNmRZaFZOZlNZTzkyaHpqaFB4?=
 =?utf-8?B?ekI2aUFrcTVsbnVjazJNRVVKZjd3U3VWNmxVQVd6RUg0WUNZSnhlT0x5Z0pk?=
 =?utf-8?B?aTVCWWRWbkFRTWFrdFhUMWNJa0FVRFYxcVYzWWZNMmhXaW1aVDl1NGtrTjNp?=
 =?utf-8?B?aFIwTldnUkFFU0FYQkZpT1RockMvUk5OWWR6djRtamFUM1dOZjM3Mkh5eWds?=
 =?utf-8?B?aXhKQlhMcFp6a2d6dlRKR0trcmFlZjhKQVd3YkVHVTFOcjVUdklEVUYxUk5P?=
 =?utf-8?B?dysrRm5DTWxUelJWcWllTE94eFV5Q3U0REcwYU03OW1IN1VPbk5JWTFGbWZj?=
 =?utf-8?B?eFEwbVpYZG9Gb0RkMGNXYnBtd0xHTmRoZ3pTVklhbXNTZWYxa3p4OXZ1Q1pT?=
 =?utf-8?B?dE15NDBTTUhkUVlmV1ZzWEVtTlIydTFCeWhYaXFRK1hvbTJpQ3M2UnlzMlNk?=
 =?utf-8?B?SHk2Z1hjMm50TjJ2clJNYTljKzhMUVp0OWFZNzhDckRMR0h2VEZaVVZDMkVv?=
 =?utf-8?B?WUk4VGpTRWI0UVNOUC9xaXFZTXBYb2lGMGQ3N2llOEdqRmlZdzdaVm0vVzlN?=
 =?utf-8?B?azIrZm5VdERqeU9SSzNKUHRyVjlsa2JjQ2tNcEw3RjgzZURTaWFnRzlkYmF4?=
 =?utf-8?B?ZUlabHZQamNaR09TR3l0b0YwOVMyZFgzVkYyY2VyelBSTWRRUjI3ZEVHbDhi?=
 =?utf-8?B?U2FpTWlHTE5LNFV5MEdvU0dmM2JwYnhZcGdjMWlzQzVCN0thK01EdFVHMmdx?=
 =?utf-8?B?R1pCSWRsSFBzSUNJZ3AwT1JXZmR4WXdvYU9jTmlIL1lXTzZpUy9KdDUxQ1Rp?=
 =?utf-8?B?TmdUeEpBQ0hkcGx0OWNLNDJiMldLdVdHOWtDOTluUkFUN1lvR09IcGhFemIr?=
 =?utf-8?B?dTN1b2dPdmRxK3A5cUJvRnAxSkJmUUxlbkc0N21qb0c4SDhmeStyeXhMNWVY?=
 =?utf-8?B?Sm5ONS9jcmNIWXJjbGU5NEtKem1SM1lpN01xYTVyd1BoaUdLSHV6YnlCTGFI?=
 =?utf-8?B?OUc3S2dzTjRxWktvV0k3bXVQRkN6Mmp1Y2pDMmI0OExKN3A4dEoxQXIyWU54?=
 =?utf-8?B?T1VLV1g0Nm0vNTU1cnJWQ1duclFsVFM2aTlvbjN1Y09GTXFRMlRPc3Q0K2Zu?=
 =?utf-8?B?OVIwakFpYlJKR1AySFhFdCtRODZiZ0U2SXFpOWVaUElLNUQ4QW9Bc2t2OFRm?=
 =?utf-8?B?Mk9UVjVQSzRNS3dKYm5UL3kyZW1YQlZlWnNMcFc4NkVXeElhTXJHaUFVYnY3?=
 =?utf-8?B?T2pYYXhHNC9GaUJSOUlPV1Y5MmE3bWttZHdDVUFhV1I5OEM4TU95cFRBQmxL?=
 =?utf-8?B?RWRRYjZNSkl4OXBMVFBPTUpqYnpqSWJBdWYxT2lncUFNZjlWR2Q1ZjJHR2ta?=
 =?utf-8?B?SkRLYmtqRWZURVlMZFlOb1dWbnFGSHpyQ3Y2Q1YrZ3FqWG9pSmR3eXltb3dJ?=
 =?utf-8?B?UVJHN3E5cFlUV2VhbGxaMzNCcVBjY2h4OE10bU1GQWdQQlZULyt2bCtyRjBP?=
 =?utf-8?B?bzQ5V05yRnpKYXAzbXNLSjMyTFN3c1BQa2VyZGNUWklZcTNZTm9zOU5Xcnhw?=
 =?utf-8?B?S1dLNVI3ZUhDUi9RQWZ6QzMrQnoxUUlBNURHbFAxV3ZkQStKNFRNc25Ka1B0?=
 =?utf-8?B?MUhQVVF6b0ZMcE52SzUxRmpBSlFQYWY3bmc4Z3l2ZS8yUVdDbHc4V3ZHOEdq?=
 =?utf-8?B?a1hPbjcxYjg3bEZVL2ZMSWxXbFpNVThJRzlRWWI1VWNXeEZuVDhwZjE5Q3pT?=
 =?utf-8?B?VnpYc1FvYVZqNFVRdGdaVkNncmp3SUVUZGlrVTZwRk1qRVZkVWk4KzR3UUsr?=
 =?utf-8?B?ZmRhVlF3ZDd0aWlnalFoNzd1NW0vanNneGswS3hrR1N3aEltQzc4eU0xdXZl?=
 =?utf-8?Q?GLJR351scyqBp4Z7gFC14zGFYgy89s+j6bcnihMRWhCU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD02A1E988E6D34EA2DBF52D34455603@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1056ca-b516-4f69-aa10-08dafcdd1f45
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 00:59:46.8665
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WrvqsW1zl1FQyfnjAbRNKCsyJLDBltvrgHlIe2qRTKGEgDcrA6VS4VFjihk7vTb8dkefXbktbJ80lsN3hrdvLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8517
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8xOC8yMyAxODoyMCwgU2hpbmljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gQ0MrOiBNaWtl
LCBkbS1kZXZlbCwNCj4gDQo+IEhpIENoYWl0YW55YSwgdGhhbmtzIGZvciBicmluZ2luZyB0aGlz
IHVwISBJIGRlZmluaXRlbHkgd2FudCB0byBqb2luIGFuZCBsZWFybg0KPiBmcm9tIHRoZSBkaXNj
dXNzaW9ucy4gSGVyZSBJIG5vdGUgbXkgY29tbWVudHMgYWJvdXQgdGhlbS4NCj4gDQo+IE9uIEph
biAxOCwgMjAyMyAvIDIzOjUyLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IFsuLi5dDQo+
PiBGb3Igc3RvcmFnZSB0cmFjaywgSSB3b3VsZCBsaWtlIHRvIHByb3Bvc2UgYSBzZXNzaW9uIGRl
ZGljYXRlZCB0bw0KPj4gYmxrdGVzdHMuIEl0IGlzIGEgZ3JlYXQgb3Bwb3J0dW5pdHkgZm9yIHRo
ZSBzdG9yYWdlIGRldmVsb3BlcnMgdG8gZ2F0aGVyDQo+PiBhbmQgaGF2ZSBhIGRpc2N1c3Npb24g
YWJvdXQ6LQ0KPj4NCj4+IDEuIEN1cnJlbnQgc3RhdHVzIG9mIHRoZSBibGt0ZXN0cyBmcmFtZXdv
cmsuDQo+IA0KPiBJbiB0aGUgc2Vzc2lvbiwgSSBjYW4gdGFsayBzaG9ydGx5IGFib3V0IHJlY2Vu
dCBibGt0ZXN0cyBpbXByb3ZlbWVudHMgYW5kDQo+IGZhaWx1cmUgY2FzZXMuDQo+IA0KPj4gMi4g
QW55IG5ldy9taXNzaW5nIGZlYXR1cmVzIHRoYXQgd2Ugd2FudCB0byBhZGQgaW4gdGhlIGJsa3Rl
c3RzLg0KPiANCj4gQSBmZWF0dXJlIEkgd2lzaCBpcyB0byBtYXJrIGRhbmdlcm91cyB0ZXN0IGNh
c2VzIHdoaWNoIGNhdXNlIHN5c3RlbSBjcmFzaCwgaW4NCj4gc2ltaWxhciB3YXkgYXMgZnN0ZXN0
cyBkb2VzLiBJIHRoaW5rIHRoZXkgc2hvdWxkIGJlIHNraXBwZWQgYnkgZGVmYXVsdCBub3QgdG8N
Cj4gY29uZnVzZSBuZXcgYmxrdGVzdHMgdXNlcnMuDQo+IA0KPiBJIHJlbWVtYmVyIHRoYXQgZG1l
c2cgbG9nZ2luZyB3YXMgZGlzY3Vzc2VkIGF0IHRoZSBsYXN0IExTRk1NQlBGLCBidXQgaXQgaXMg
bm90DQo+IHlldCBpbXBsZW1lbnRlZC4gSXQgbWF5IHdvcnRoIHJldmlzaXQuDQo+IA0KPj4gMy4g
QW55IG5ldyBrZXJuZWwgZmVhdHVyZXMgdGhhdCBjb3VsZCBiZSB1c2VkIHRvIG1ha2UgdGVzdGlu
ZyBlYXNpZXI/DQo+PiA0LiBETS9NRCBUZXN0Y2FzZXMuDQo+IA0KPiBJIHRvb2sgYSBsaWJlcnR5
IHRvIGFkZCBNaWtlIGFuZCBkbS1kZXZlbCB0byBDQy4gUmVjZW50bHksIGEgcGF0Y2ggd2FzIHBv
c3RlZCB0bw0KPiBhZGQgJ2RtJyB0ZXN0IGNhdGVnb3J5IFsxXS4gSSBob3BlIGl0IHdpbGwgaGVs
cCBETS9NRCBkZXZlbG9wZXJzIHRvIGFkZCBtb3JlDQo+IHRlc3RzIGluIHRoZSBjYXRlZ29yeS4g
SSB3b3VsZCBsaWtlIHRvIGRpc2N1c3MgaWYgaXQgaXMgYSBnb29kIHN0YXJ0LCBvciBpZg0KPiBh
bnl0aGluZyBpcyBtaXNzaW5nIGluIGJsa3Rlc3RzIHRvIHN1cHBvcnQgRE0vTUQgdGVzdGluZy4N
Cj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1ibG9jay8yMDIyMTIzMDA2
NTQyNC4xOTk5OC0xLXl1a3VhaTFAaHVhd2VpY2xvdWQuY29tLyN0DQoNCndlIHJlYWxseSBuZWVk
IHRvIHNvcnQgb3V0IHRoZSBkbSB0ZXN0Y2FzZXMsIHdpdGhvdXQgZG0gdGVzdGNhc2VzIGl0DQpu
b3QgYWxsb3dpbmcgdXMgdG8gY3JlYXRlIGJhc2VsaW5lIGNvcnJlY3RuZXNzIGZvciBibG9jayBs
YXllciwNCkkndmUgYWxyZWFkeSBkaXNjdXNzZWQgdGhhdCBpbiB0aGUgbGFzdCBMU0YuDQoNCj4g
DQo+Pg0KPj4gRS5nLiBJbXBsZW1lbnRpbmcgbmV3IGZlYXR1cmVzIGluIHRoZSBudWxsX2Jsay5j
IGluIG9yZGVyIHRvIGhhdmUgZGV2aWNlDQo+PiBpbmRlcGVuZGVudCBjb21wbGV0ZSB0ZXN0IGNv
dmVyYWdlLiAoZS5nLiBhZGRpbmcgZGlzY2FyZCBjb21tYW5kIGZvcg0KPj4gbnVsbF9ibGsgb3Ig
YW55IG90aGVyIHNwZWNpZmljIFJFUV9PUCkuIERpc2N1c3Npb24gYWJvdXQgaGF2aW5nIGFueSBu
ZXcNCj4+IHRyYWNlcG9pbnQgZXZlbnRzIGluIHRoZSBibG9jayBsYXllci4NCj4+DQo+PiA0LiBB
bnkgbmV3IHRlc3QgY2FzZXMvY2F0ZWdvcmllcyB3aGljaCBhcmUgbGFja2luZyBpbiB0aGUgYmxr
dGVzdHMNCj4+IGZyYW1ld29yay4NCj4gDQo+IE9uZSB0aGluZyBpbiBteSBtaW5kIGlzIGNoYXJh
Y3RlciBkZXZpY2UuIEZyb20gcmVjZW50IGRpc2N1c3Npb25zIFsyXVszXSwgaXQNCj4gbG9va3Mg
d29ydGggYWRkaW5nIHNvbWUgYmFzaWMgdGVzdCBjYXNlcyBmb3IgTlZNRSBjaGFyYWN0ZXIgZGV2
aWNlcyBhbmQgU0cNCj4gZGV2aWNlcy4NCj4gDQoNCkFncmVlDQoNCi1jaw0KDQo=
