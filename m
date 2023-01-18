Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCEA672D04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 00:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjARXxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 18:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjARXw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:52:56 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD27E11E98;
        Wed, 18 Jan 2023 15:52:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buTdALoX2/crAAvH1Qdba5zhQa09TMTt7gi7QcBL+0D/XIAbsiMyRH8WbJwal+HyytMEMkDVW7hXYMFZHm4aiG3rwrwFEeoasOZVLPPmiyu6rLmSGjW1l+QNDOE3xXRGaAZ41ZlkawQplkSEyzUQJlJCAej7TNmnPqkNHH0eZBtd7Kycdr7PSGthEZGCNT3A+k5yql+p6s1wfk8/III91xT9076qRWWW2pnIUzBs2m3mi1vfL9uo2mn2Pw47IJIEwxHNVlPNKnKOMev66XT1Bgkw4FdRi8gkx7f0rc5upurNWVBUlcUxQ7QtHR/sf+kk40TVn0QtXpJxSu97h9jJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYuLILd2OSfCKrlKhCgBsBQTIdOgq+ZozYfbUB+P58Y=;
 b=gxTRRoip07ntsfzNXJNwADW0XxZG5OUUQ7mRnafQI94R+xIakEh22FiOSFjS6/QJZf8/5p+jr7r4CRaVAtvmEPKPGFeSwN79+kouiJ9iV2nCVYgT0mGePt7wFASy6bU33/Z0QnxZVc5NBoUgxofJo5OOQUd2qaI76KxKQgLRbVCG8I3Flk+M9ZCudJix+bVmZdpwq6K5dqWA+Svzt0oxsScXjDslOH90BKXuMbrNblce+VZ0gXk4DKLTXEisq64z+AXXS9YUJ6DDDz/vQCX3w75uKr3upcrUYKiCsVDyPVphXkyWYHzt9/yLN6wwm+bcM6NUrDVIyN112fAVH0+m1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYuLILd2OSfCKrlKhCgBsBQTIdOgq+ZozYfbUB+P58Y=;
 b=ZwocqYRh5sgFyu8xjAXGM/SMFmXeLyN9r80ZP6F8MoX8UASEc7GM7zRCNN7Ha6ZBXnvWYlZGpK2IUEMhC6bPuDxnefzY6FfsPwJLUd/jGvLzAhyaNOeMPV2zD46hE/G/frlXcC+zCLgsnblHRIYHoPfHJKY5o6hGSLVuKv4/VV/V7m9Q9axe7iQFe1UwJTiz3YG4dU1ufZuQTBR10rWC0wz8qWMOl4n5Vt/whYHltHz6CLlORSPCJmTJELD7SbL2yFX1jfc1f1DS2xbjIhNNh9J2CXXzQejue3FEXow3sBMXGdJwNpnOeJ89kFd8T2c2SKg/6sxGXKCPBvp4Xp0Yiw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Wed, 18 Jan
 2023 23:52:39 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.6002.024; Wed, 18 Jan 2023
 23:52:38 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org >> linux-fsdevel" 
        <linux-fsdevel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        Amir Goldstein <amir73il@gmail.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "jack@suse.com" <jack@suse.com>, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, Theodore Ts'o <tytso@mit.edu>
Subject: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status, an
 expansion plan for the storage stack test framework
Thread-Topic: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status, an
 expansion plan for the storage stack test framework
Thread-Index: AQHZK5fyQKUFtoPftkeiJLNotrztlw==
Date:   Wed, 18 Jan 2023 23:52:38 +0000
Message-ID: <e24383ca-8ba8-3eb3-776c-047aba58173d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CY8PR12MB8412:EE_
x-ms-office365-filtering-correlation-id: 61237885-2bca-4cef-d08f-08daf9af14af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LpAoFAqc3IE4ryqF2ky9neTp6ypBEJwRrWSbuOYqRlGGnuawyACpPw3V1USfTB9DStFSrtntzMGYz7LRL5ooF/9ZnxOzm0FG3QEUG7KQTgG82m7Vs9KPPzBNzqLbKBgCdFVF9s7fkR1obQruNWBiMBXkP8usItXyxm7XlrrxfupzdLvVWl4bKXyK2mk1tOPKiPniOCF5c7dZH81UaTVYv62sFW+s7wNRKR4oZrEvCrcLXa5HUddWnAnbf/pp2drbc4nfT3cf8r4tnkZZRkH/U1W2WO69dCs8OkXQ5en12ijezB4blyltidYSJeCFNOK69vFti73BTFQKf1UuN/Ly+K11MEYPl7CPUxRk2rkVTU7NaIPxqPfmsSMiQUHj19mebVP6dow3S8g+Nr1nPFzObvKfZUHeoE/pI+jBxs86Ms9IdibbYmoyP5TSzATQqyI4WF4dLnF1LvBJJHQ9WIZES+xhha5yCltyZNP2kTHh2VmCvX23KWYhqOWpQmYwjCz6TdNVe/a6X0X9SpMbnssFvVWeY7P+X5CcA4JOs+u3M0Ft0QeatL/vtm7zI0rKGsHMwlN7Dq7HVHha06gSCijn9l4HIjM0qUjY7+fSDF4zQULKINJSCuNQvqTMKerIb45FGbhNc9RExJ8AaJCI7LAFzFuS3Bq+96rwUJXUVJJfw7BRQ6SiMCPx9MVexRkmhTXpTFCE37PstTSkyFscllcWcTHzZtlAPWLC3yEUmRKWrT02TMMG8w99CTnug7Rm9+kC36ZVNfix5SbyNuPrb5Uc9MEAZZ8wf5sUMoKQrAAaqIByN2+iny2twd0QIgcOXA5xX93XenoIXkfdhLIA1nEW6Fynyjxurfy5dWa96E8HI5M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(36756003)(31686004)(8676002)(38070700005)(8936002)(76116006)(66946007)(66446008)(64756008)(66556008)(2906002)(31696002)(7416002)(86362001)(122000001)(83380400001)(38100700002)(5660300002)(91956017)(66476007)(54906003)(6486002)(71200400001)(316002)(966005)(110136005)(478600001)(4326008)(41300700001)(6506007)(2616005)(186003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUNhVEUyRjJXaUxGRi9XR1BSTEhETE9rV2oyVVprUUNHUjVhQ05VVlFGQ1lH?=
 =?utf-8?B?azczVXRaV3dEUHlXd3JtZXZDdUxaYU1vTnZNMUVXNXIyZUlPck5RTGRGQzhn?=
 =?utf-8?B?Y25jVDlSTEVtOTFyOERHYlJBc3pzalV3Uk4ySDMxSFRBdVNRTzhYSWpFQkJE?=
 =?utf-8?B?TVJja1dtUXNaL3ZrS1QzQ0t5ZlhINGFhNWpGZ3RCQ3Z3bjE0aDV5WitkZlZG?=
 =?utf-8?B?OWpkUlBkNS9KclBzb1hlMVlab1ZSZWdQbkVlajM0R3NVNjZaanNBTmMrOGlP?=
 =?utf-8?B?YlJRTzlkb2hoMWZBUW1GbUxxU0dXSVorWUtTTkJVMUtORS9lTkdtSCtteFFk?=
 =?utf-8?B?aElBcnFTN3ZyUWhLT3JBQ3NvV25HbUhMM1RTamp2NlpFOXpyQTc1cVdjc0xY?=
 =?utf-8?B?MDY0d0c2ZjdRanZLZlVmUjk1bmR1bi9RTit4RWpBdDNuWkRVR0d1YUNtdzNP?=
 =?utf-8?B?ckJQVThFc3NYeWc4VXNwY1ZWV05PN1l6ZGRORjRkRE93b3ZiNGVXVnpKeW03?=
 =?utf-8?B?dkxGSGZEUDgrZXJhS1duM2IrMERtcHplKzVCZW1NclJ3dGpXbVg3b2RaWmxM?=
 =?utf-8?B?Z1poMzZscWk1UjR2UkRMWGdGNFpSeDFkTFZIOHh2eXhjTkRITkNhN1g3cGlv?=
 =?utf-8?B?UlNTODFDZXpENjJPNG1xaStyRWhzbWZrWjdIZCtNdkRzeWJRbDBXLy95ZXJF?=
 =?utf-8?B?b0FGZEVtNnBXS3EwemErcmtvTG9tRXlydUZvbzh0M0Z2OEtXYVByOXF1em5v?=
 =?utf-8?B?aWM4UktmUEtZN3UwRzMzY212amJkYTJLOFAvUHJNWEwyYldKU1VCNnEybHVE?=
 =?utf-8?B?WW5yNFh0VW00S1lCM21vZXdMQUREUCtHdGNpN0ZEVGpKT1kvRklIY0tCcXNF?=
 =?utf-8?B?SWZxNFN6ZUh2dE9oVWh6SFQ5OFZwMDFNMDNaZ1ZPcHkxdENsVDFkbTZZcXVx?=
 =?utf-8?B?amttQVJmS2tHMmVaNVJkM1R3TFRwdFhwR09NeW9sOGxBMUU3RnpabXUrNDU3?=
 =?utf-8?B?WG5YRkxIaTFEVVMzeUdmME1GL3BQSkVBRi9XeTFQL3BXOGVVRkU0QktTc0Yv?=
 =?utf-8?B?cDNLWCtHeGhseHlrMjBJYnhMT05RTkNOd0V6MWVBcnRXOFZrK29wTWZQcTJa?=
 =?utf-8?B?Vlljdll1Z2R4R1oydDdCQ01RSWJjTmd4WDN0cmgzVS9ZREdBWU4wbTVpOVdm?=
 =?utf-8?B?VzF2VmNCRDFBSzBDQjZLMmtDbHFvU3R5Z21kU2NicXNJWVlnNkZ3dHZFejdx?=
 =?utf-8?B?cWtmY3A5dDBhbTBobGVCK0swN2xWOWRjcTVkOCs0QWdQREJaUkhFU2x5TzQ3?=
 =?utf-8?B?bURXR0RrQzU0N0R2V2Y4L2VLaGNnUWJoRytPWGt0K3hqdUpXanJZTmthVkls?=
 =?utf-8?B?d3gyNmh1a1JSRW9pbWt3K2ZGOFpxUWZPZm1uM2NqWDROcGppR3JPVEJiTnA4?=
 =?utf-8?B?SXNLWVVsT0gzKzhWS3pDSTIzSWZ6U3BaSFlRd3Eydy9DMXI5V0VXOU1MQXFn?=
 =?utf-8?B?YjQ4RVUrZURRTklGOGJQUmQvZ2krSU5sQUd2NEJaMklydHZFT1RPRUdVeHFN?=
 =?utf-8?B?RjBST0FCMDIvODBaRmxzcnRpOHdTdEVmRGpXVkp3OVVyYUhzZzE1K2NZT2Jv?=
 =?utf-8?B?UEwrRDVxd0FPRk01dWNmalBmOUR5YVJoYWl1ZHcyd01ybzh6N01rWndBSE83?=
 =?utf-8?B?Ym5Vbk4vdjBoeDZtdTA2TGtMc1JjY2U4eURXTDl0YWZZdFNnQmRZWmZJK0Ny?=
 =?utf-8?B?UHpuL1QvNVZiS2ZER25ydmtrZzJ3NmtKYzhoZThLVTI5RkxObSs0VE9OUmlP?=
 =?utf-8?B?ZGpSWHB6Ny8zaEZ5ZXpGQm5KS0htVE1KS1drRktScVpxeDhRTC9SM1VQaFRx?=
 =?utf-8?B?YU5MNmVSTGpDamhKVENDOFRxSUdUeldmc01NRWZjaXZSeDRLZU16b3owMno2?=
 =?utf-8?B?d25FTzR3Q3NqeWFCb1NORUhqcHB0ZTZzTUhkMTROWjBobkVhUjVucGVZbUd0?=
 =?utf-8?B?cEtLR2NXVnR5RndNSXZubWRUSmdnVU9POGlEMXBidlBQUkdDNXNIQlNWd2FH?=
 =?utf-8?B?Q0N1OVNOL28yNFBkUDc4a1lpZ2k1NWxISUE2UmJrTmFVeW5xL2haei9UYThr?=
 =?utf-8?B?TFlxc2orYi9nNThWdlp4eEwxcUpKR1Y3bVNvSElEWEE2eDFoWlI4V1FSTzBT?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33714CC63C24DB4C91F504C726C3B549@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61237885-2bca-4cef-d08f-08daf9af14af
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2023 23:52:38.7693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KL09huuNo5460oMOaQTmHiLaPhjv0ELbBj0vy9/fmRCcB7bkye73Qe2HFyXijp4gbVrupgWv7adkgDQRpWZGAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksDQoNClNpbmNlIGRpc2N1c3Npb24gb2YgdGhlIHN0b3JhZ2Ugc3RhY2sgYW5kIGRldmljZSBk
cml2ZXIgYXQgdGhlDQpMU0ZNTSAyMDE3IChodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNzE3Njk5
LyksIE9tYXIgU2FuZG92YWwgaW50cm9kdWNlZCANCmEgbmV3IGZyYW1ld29yayAiYmxrdGVzdHMi
IGRlZGljYXRlZCBmb3IgTGludXggS2VybmVsIEJsb2NrIGxheWVyDQp0ZXN0aW5nIHRoYXQgaXMg
bWFpbnRhaW5lZCBieSBTaGluaWNoaXJvIEthd2FzYWtpIDotDQoNCmh0dHBzOi8vbHduLm5ldC9B
cnRpY2xlcy83MjI3ODUvDQpodHRwczovL2dpdGh1Yi5jb20vb3NhbmRvdi9ibGt0ZXN0cw0KDQpB
cyBMaW51eCBLZXJuZWwgQmxvY2sgbGF5ZXIgaXMgY2VudHJhbCB0byB0aGUgdmFyaW91cyBmaWxl
IHN5c3RlbXMgYW5kDQp1bmRlcmx5aW5nIGxvdy1sZXZlbCBkZXZpY2UgZHJpdmVycyBpdCBpcyBp
bXBvcnRhbnQgdG8gaGF2ZSBhIA0KY2VudHJhbGl6ZWQgdGVzdGluZyBmcmFtZXdvcmsgYW5kIG1h
a2Ugc3VyZSBpdCBncm93cyB3aXRoIHRoZSBsYXRlc3QgDQpibG9jayBsYXllciBjaGFuZ2VzIHdo
aWNoIGFyZSBiZWluZyBhZGRlZCBiYXNlZCBvbiB0aGUgZGlmZmVyZW50IGRldmljZSANCmZlYXR1
cmVzIGZyb20gZGlmZmVyZW50IGRldmljZSB0eXBlcyAoZS5nLiBOVk1lIGRldmljZXMgd2l0aCBa
b25lZA0KTmFtZXNwYWNlIHN1cHBvcnQpLg0KDQpTaW5jZSB0aGVuIGJsa3Rlc3RzIGhhcyBncm93
biBhbmQgYmVjYW1lIGdvLXRvIGZyYW1ld29yayB3aGVyZSB3ZSBoYXZlDQppbnRlZ3JhdGVkIGRp
ZmZlcmVudCBzdGFuZC1hbG9uZSB0ZXN0IHN1aXRlcyBsaWtlIFNSUC10ZXN0cywgTlZNRlRFU1RT
LA0KTlZNZSBNdWx0aXBhdGggdGVzdHMsIHpvbmUgYmxvY2sgZGV2aWNlIHRlc3RzLCBpbnRvIG9u
ZSBjZW50cmFsDQpmcmFtZXdvcmssIHdoaWNoIGhhcyBtYWRlIGFuIG92ZXJhbGwgYmxvY2sgbGF5
ZXIgdGVzdGluZyBhbmQgZGV2ZWxvcG1lbnQNCm11Y2ggZWFzaWVyIHRoYW4gaGF2aW5nIHRvIGNv
bmZpZ3VyZSBhbmQgZXhlY3V0ZSBkaWZmZXJlbnQgdGVzdCBjYXNlcw0KZm9yIGVhY2gga2VybmVs
IHJlbGVhc2UgZm9yIGRpZmZlcmVudCBzdWJzeXN0ZW1zIHN1Y2ggYXMgRlMsIE5WTWUsIFpvbmUN
CkJsb2NrIGRldmljZXMsIGV0YykuDQoNCkhlcmUgaXMgdGhlIGxpc3Qgb2YgdGhlIGV4aXN0aW5n
IHRlc3QgY2F0ZWdvcmllczotDQogICAgIGJsb2NrICAgICAgICA6MjgNCiAgICAgIGxvb3AgICAg
ICAgIDo4DQogICAgICBtZXRhICAgICAgICA6MTUNCiAgICAgICBuYmQgICAgICAgIDo0DQogICAg
ICBudm1lICAgICAgICA6NDQNCm52bWVvZi1tcCAgICAgICAgOjkNCiAgICAgIHNjc2kgICAgICAg
IDo2DQogICAgICAgc3JwICAgICAgICA6MTYNCiAgICAgICB6YmQgICAgICAgIDoxMA0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KOSBDYXRlZ29yaWVzICAgICA6MTQxIFRlc3RzDQoNClRoaXMgcHJvamVjdCBoYXMgZ2F0aGVy
ZWQgbXVjaCBhdHRlbnRpb24gYW5kIHN0b3JhZ2Ugc3RhY2sgY29tbXVuaXR5IGlzDQphY3RpdmVs
eSBwYXJ0aWNpcGF0aW5nIGFuZCBhZGRpbmcgbmV3IHRlc3QgY2FzZXMgd2l0aCBkaWZmZXJlbnQN
CmNhdGVnb3JpZXMgdG8gdGhlIGZyYW1ld29yay4NCg0KU2luY2UgYWRkaXRpb24gb2YgdGhpcyBm
cmFtZXdvcmsgd2UgYXJlIGNvbnNpc3RlbnRseSBmaW5kaW5nIGJ1Z3MNCnByb2FjdGl2ZWx5IHdp
dGggdGhlIGhlbHAgb2YgYmxrdGVzdHMgdGVzdGNhc2VzLg0KDQpGb3Igc3RvcmFnZSB0cmFjaywg
SSB3b3VsZCBsaWtlIHRvIHByb3Bvc2UgYSBzZXNzaW9uIGRlZGljYXRlZCB0bw0KYmxrdGVzdHMu
IEl0IGlzIGEgZ3JlYXQgb3Bwb3J0dW5pdHkgZm9yIHRoZSBzdG9yYWdlIGRldmVsb3BlcnMgdG8g
Z2F0aGVyDQphbmQgaGF2ZSBhIGRpc2N1c3Npb24gYWJvdXQ6LQ0KDQoxLiBDdXJyZW50IHN0YXR1
cyBvZiB0aGUgYmxrdGVzdHMgZnJhbWV3b3JrLg0KMi4gQW55IG5ldy9taXNzaW5nIGZlYXR1cmVz
IHRoYXQgd2Ugd2FudCB0byBhZGQgaW4gdGhlIGJsa3Rlc3RzLg0KMy4gQW55IG5ldyBrZXJuZWwg
ZmVhdHVyZXMgdGhhdCBjb3VsZCBiZSB1c2VkIHRvIG1ha2UgdGVzdGluZyBlYXNpZXI/DQo0LiBE
TS9NRCBUZXN0Y2FzZXMuDQoNCkUuZy4gSW1wbGVtZW50aW5nIG5ldyBmZWF0dXJlcyBpbiB0aGUg
bnVsbF9ibGsuYyBpbiBvcmRlciB0byBoYXZlIGRldmljZQ0KaW5kZXBlbmRlbnQgY29tcGxldGUg
dGVzdCBjb3ZlcmFnZS4gKGUuZy4gYWRkaW5nIGRpc2NhcmQgY29tbWFuZCBmb3INCm51bGxfYmxr
IG9yIGFueSBvdGhlciBzcGVjaWZpYyBSRVFfT1ApLiBEaXNjdXNzaW9uIGFib3V0IGhhdmluZyBh
bnkgbmV3DQp0cmFjZXBvaW50IGV2ZW50cyBpbiB0aGUgYmxvY2sgbGF5ZXIuDQoNCjQuIEFueSBu
ZXcgdGVzdCBjYXNlcy9jYXRlZ29yaWVzIHdoaWNoIGFyZSBsYWNraW5nIGluIHRoZSBibGt0ZXN0
cw0KZnJhbWV3b3JrLg0KDQotY2sNCg0K
