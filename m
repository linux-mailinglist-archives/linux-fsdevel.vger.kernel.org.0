Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDACD493059
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 23:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349736AbiARWLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 17:11:08 -0500
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:35617
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233791AbiARWLH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:11:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUOkrdhvsiYQ0h8Cd2JFAvkSxchABjF8D2ZuYQuyalz5hm3Wh0Hc/lxKinT+DGs5PnvMe0c8MjOU4LYBWVLtYjmVpa9HBc+hMBjKr/PU1h3XxFOO7A+3VKx2lXcP75CnAOtMeloCQdqMfwcWOBSyH2Hbani7osf4nqJkij15KUrHxjHxYoxK2kA59BW70vs94dTUUs4oAxKgWxRsRDYJFWyoli00XpbdOmGoKUhD5d2Kbe5FVTP0jCWq8lr2sXy4O+IHQnlM5kzMCBylxV+XdsM8ftnOoIlIErAXtNtkMrjzUELza7cGaZNnF+qEVC79ImG0TLN1B4n9MvI8mqSeJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7W6lHAj2LoZRdhgNrVK68jx3YXevYUKyU9h4DHJ8Ns=;
 b=ge9GII017o4g2mydJwuNzpgZ0UNRr/EGcur2oU/1eIThpqqGynCQN83+rCwTEdApSN5UV6L4kCgztLOGshn583DYXrX+UfHr0917oppYjlUgYeMfbygcIWMEKyXmtkN4wv3wTMrM+qD/nQgHvDvJ8n5E9NWEo+CicSBqD2tfb0w/r8JKwN8bSoCjTTIPxhISJObAk2hJGKrIyPBMofz02Pkc8UyHX7JUrD40GRsUUCgYLaLPUTEAWChsbv/pEm0dCEqpxBA29lUi1rpBZxPzQLHRIuwpK6uGzkF/RnIfoB5uBjIKKGW32UFlIseG2LTF092kAf8eaLMZsMznGasdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7W6lHAj2LoZRdhgNrVK68jx3YXevYUKyU9h4DHJ8Ns=;
 b=Smu0nY/ooUtddj+lq9zl50nZjjD5oZNrnOdKX8SdwuTOOiHb+aUmU41D+R90jUgwZ+Xwo0dJpfzObi/exMhlyDhLtPobJdTjGwdExzuRzHVj2NmtKKBSfdJKmjIaDbX4S0YBRjHGth64KFjszs8X3jV6RE3ZH4n1E3cKZDKCsQdCoytOzaV/lDb2mrpmi+FQhXk1kgOf7Y3xwkh9iAPQdSPj1ODdFSksJyrlv85Ixw5tbwD/acHb7WGNRgz6B8KAUCE2tKcsnEBifFY85rqoAyCJIdIPnXHY3pRqO3wnZV3O9JhZAZ1FCFx5QlFMgbkm5Y4+ie2rs0wE7pvFqDIkJQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 22:11:06 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 22:11:06 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Pavel Begunkov <asml.silence@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.co>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>
Subject: Re: [PATCH 14/19] block: pass a block_device and opf to blk_next_bio
Thread-Topic: [PATCH 14/19] block: pass a block_device and opf to blk_next_bio
Thread-Index: AQHYDDwGw/z8koRieUq7/a1KG8yv26xpWBsA
Date:   Tue, 18 Jan 2022 22:11:06 +0000
Message-ID: <245eaa0a-0796-0227-4abf-d1b78953557e@nvidia.com>
References: <20220118071952.1243143-1-hch@lst.de>
 <20220118071952.1243143-15-hch@lst.de>
In-Reply-To: <20220118071952.1243143-15-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a888d85c-26d6-4ada-9ceb-08d9dacf6cb9
x-ms-traffictypediagnostic: MW2PR12MB2379:EE_
x-microsoft-antispam-prvs: <MW2PR12MB23797C1654E266B5F4D43140A3589@MW2PR12MB2379.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SIy/rV163bbf5Quo5xEqWxZ7KNopDmfTIGB4GjyFSO6ZUfw/v3nHaAUJp6utstP31pP5VJSzYjDbMxSqvLKEt2vWCYCbSKHxyJGto/EmEv5xIrmXe7Jt8UqziohVSVNray7WmySDQQKGQ1BkzGqEASoB38lt0mm6KfAvQdIMBYilYudAhX7L41ou7Zsqb05to0hm/xhRJYNUujoPz8YNbaAcZ2QHGb1RylFyd4HAw8kA/MZAlOetMMvrlUNiCxm9zsNrMd42DZp34T3DOOcJ/alQXN6UVxRjWyy60F+gyALLPcnDBWeg0cfPjjcyo1LK80cb/oWcjZerg7q9mEgbeA4Rjkl1il8KkDOsg669Hdz/OGGkHTREZ25xr2FpW8+ZUPnMXgF8v9nxZ8Vb3g6B2hmfVLvS5zWayJMUQVlp2YG99AUl5wtk32ktaM4Sq//Qhrlyhb6AdbqFkmgs6EmeRw0QSHNTeDTP5RFqJnqeskCSaui2+8uKzJ7IN8CORiJmYzGAVEC3UMotxbnQu1fwDrBTM4LgArHyTHR763HHjHAT75YlNCRVbL2Rp0oPC125/VHNJMyU4boILGnFkt83T2pBrYI0i5KvnAExQe4Zn399iUnj7d4B/GjlFhsqoBCbBmE6xbNoPglzWprklHbB/g5MgjuwhakxgrvbuG+T/GlZA6pfrhaBv5PwhVkyULgVw39CquozpGUdmSmziM+Tb1WDDOMFZJ7vsT3ew7ecv/hn7hC9wO93bNIun34Arvxby8phcnxoCNxAhMcCJJ9ypQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(38100700002)(558084003)(36756003)(54906003)(8936002)(91956017)(71200400001)(8676002)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(31686004)(316002)(186003)(86362001)(53546011)(6506007)(83380400001)(4326008)(6486002)(110136005)(2906002)(5660300002)(2616005)(38070700005)(7416002)(31696002)(6512007)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXNOTlY5VmsrVVQyS2xlTFJXMVRFaVN1ZmlZQlQvdWg0eXgyS2J5ODBXSm84?=
 =?utf-8?B?MGFHNnlOY3lRa3BZb3QrdlVxY3ZFRTlrR052ZEZZb1JFc1RlamUzNFdlcEY4?=
 =?utf-8?B?ZmU4YXpqMDgyUHJYZmcvKzlRRCs2MHJkc01EUysvbGZPTlZHZU1YblB5anIy?=
 =?utf-8?B?OXhwTkY1TDZxbUM2cEVwQ01DK0VYSjVSSmRnVnRBUmlMVm4vTGdGR3FBUnJG?=
 =?utf-8?B?bGlNdGhwSGY2VnZOSjVkSEY1cG5iUXJjVU9FcEc1SDNpNWJrYnBtejVkNkg4?=
 =?utf-8?B?T2NqeHBWRnkrSGgzSm9NeTJrQlczSXd2ZVNNZTJtU1Fuamh0WitwamNsUDFO?=
 =?utf-8?B?aGFSbXY4am5wdGF3blZibXpSNTNwcjdka0U1RWt2UCtpOS9UemVFOUtaWlBX?=
 =?utf-8?B?Zmd3T0NhWUl0VHFSOFBUOUx3S2V5NHhHRzg4K3IwU3BrZC9ZSXJicUczM3h0?=
 =?utf-8?B?ejRzakRzRy9IQ3Y2aHc3dWxWSisrbStxZGxWN01aR05KNUdKZityZFNuTG9L?=
 =?utf-8?B?SzdwdnFqejBEczJWN2MzMGJXNTNGYUt3TTBpbjg0eGUyRk9VeWRmMTA2NFZv?=
 =?utf-8?B?ZFZlT1ZUZEVRa3hIRDZka1hhUjlSQjVPS0hVYUw4YllqWFRNcGIvQVQ0dHZz?=
 =?utf-8?B?a2dLTDBlSlRrUkFxMnZBSCtmRTM5THBTVG1LbXJvYXg2cWtwd3QrbnV6ZWVI?=
 =?utf-8?B?Nnkwd1lINEIwZ3I3U2djZGQ1RVJkdWZBUWVhQjluTUpQNHZsektsdFdqcjZM?=
 =?utf-8?B?NlUrM014bFE2T3ZzTy8vZmxpdVRQUHorRHkvQXZqQ1ZwNGQzRHJ6dE5JbzBX?=
 =?utf-8?B?Q2VRZExIOGx5Nk5hb0wzU2ZvR3ExcmtNS2lsNDlsalYzQVRZVG1MVmJIM0xS?=
 =?utf-8?B?YWhRMVJnNVNBTXNpUmRPMzczVzZzRW0vNWNxK3QydEFpaVVXNzdkTWtzdGJP?=
 =?utf-8?B?eTN0L21jQW45MzBsWDdDWmhIY29UczVkWGduTExzd1Q5Rlh6dHZjNGd1YzEy?=
 =?utf-8?B?NGVhc3VqTTRwUkUycGdGNWUxTkVtYjRQRmRrMFBLOU93akc1MnpiQXozcmNk?=
 =?utf-8?B?MFMya0RXclUwY3grU3g2QW5QbVhNMXJyNFhzNVhVQllIRk9YajhJRmxsNkFL?=
 =?utf-8?B?WU1razRCU21rQlNTT2FLU3hTR3JPS0RjVVZ5V0NpNXp1dE9KVlY1V1MzZ3VE?=
 =?utf-8?B?aDMvNzZWVnQvWHlwN0hkMHJWZ0JobFZFTldmSkEwWCs3ZHhUSTB3djV0cGtS?=
 =?utf-8?B?T1VpQXdwTklGYWFwRERYbjdadWh6NHcyYUs1L2RBTnp1WmVaUGY1RFFQcHdK?=
 =?utf-8?B?QnZONWh5aTZhcXJNaE56Q2oxWGxTT1dqamY0TTQxWFBLbzAzUlRuUkVVWjUy?=
 =?utf-8?B?M2lBZ1VwZG9DN3lDdzBnNndRZ25aVXlRaFR6cWRXY2FEMDFhTVJ6Y1JGNkxa?=
 =?utf-8?B?bldjUkZITWRzK2p0NmtTTkt4Z0JLaldQZ1Q0UUVzL2oxMjNrMFUvcGl6YzlG?=
 =?utf-8?B?Y1g5Njd6VWVtUE9nNDUxUU1YL0tzdTZZQVBPU1hxbDdESzZNYUt2T2dWQzBs?=
 =?utf-8?B?VDlwbXplU1hHMlFDQWFsSTQrSWFEOXZOaDI2YVAvaFd5dWtNOFdJUzlyVXB0?=
 =?utf-8?B?WDc5VFR6Zkt6OC9zQzhWTDFaNWhXamtwbFFqL2M4NCtLUVM1SlVuRnRvNmxa?=
 =?utf-8?B?UTRXWE5wS3RWZnNaZnR4WDhPcWdjTU9DOFIzRVl4MnBiSUw2amdybkp4ODh4?=
 =?utf-8?B?NWEzODdSazA1TnErby9OWVh6aEpQeDFxYmFUOXRPVWFPQldmeWhiK3ZMZjVX?=
 =?utf-8?B?d0RyY05qTVV0cndPMUJYbk4zV0tmeVo4SjYxeVZGUnBmU29VdUtJQ0dwS2dG?=
 =?utf-8?B?dXNQdEprRDZmZ3FoV0Z6VDduZmRCTU1uVHRNK1QxN0UxUDZnNG4wcnhvQlNm?=
 =?utf-8?B?bTVpRytvL3BOeUdvd0FUNWJmckc2RzlSWC9JWUU5Wm01Rzh0NnJ3R3hSODFq?=
 =?utf-8?B?a1V6YUJMVkZmMElWUk5ueWtXZnQxUUJDWkFielZrckp1TkRPaTYxaW1uRHl4?=
 =?utf-8?B?OWxpL1pKVXg5TFgzWWNKQTQwRktCZVJLU1A0Y1U4R0s3WWJ0UWM5QTVVcnNQ?=
 =?utf-8?B?OVF0dU9BbWJHL1Z1Q3lSNWNMdUcrVnRxR1dUczUrVkg5QmZxc2ZEOHlnR2ZQ?=
 =?utf-8?Q?KEmWXYPX+xGG2zwoV91NUDuw1pwSUPp6qnAM3pkHYbuB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72D9A4819752A44299892B2C633A7AB8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a888d85c-26d6-4ada-9ceb-08d9dacf6cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 22:11:06.6199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a2HPNadh3RAvu5rrPYoSKIG/9zBtGDAHn9makgk4Sctcy2J/SjLXcjcFMvQtiY5cGE4LckViTTCGAB+0JCJP1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8xNy8yMiAxMToxOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEFsbCBjYWxs
ZXJzIG5lZWQgdG8gc2V0IHRoZSBibG9ja19kZXZpY2UgYW5kIG9wZXJhdGlvbiwgc28gbGlmdCB0
aGF0IGludG8NCj4gdGhlIGNvbW1vbiBjb2RlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IC0tLQ0KDQpJIHNlbnQgb3V0IHRoZSBleGFjdCBw
YXRjaCBmb3IgdGhpcyBvbmUsIGFueXdheXMgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg==
