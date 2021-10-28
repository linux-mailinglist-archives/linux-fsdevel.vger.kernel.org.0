Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0D43D880
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 03:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhJ1B3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 21:29:20 -0400
Received: from mail-dm3nam07on2072.outbound.protection.outlook.com ([40.107.95.72]:35553
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229505AbhJ1B3U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 21:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ssp5BvngCsY4s5jGFNomwySwsFdnzwIsXeyFiZkCLSN0T/E1C/tKWqT4YQ1KYnOViiV7O4OZUwpOox3ebSIs55/46isxjv72s8umC7mr5brTJ9RKxLjjlm0WYjTm0QgDBzPs/+sdjp/RmewItPjxqaphkmEVdeAsjUUEDfRbHN3aELEg02zldHY/U2hJ7ZFHZ6NJMxoafFDn5yIl5dcwKifdrUDi3VQL3EY6jlAO26ksthph2CZTvEbMbMNbSD/kz967A74ewNon1EOTRSXAC4AmQi13V6+ThsbEb78z7FRB4Nu75sXMK/jqgdxAKJ7x8xhokfoVtMpF6ya18KfR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR2FteA4hUBmjwSOd/CzGiRD9N0OJowHrm6Fh5e4OC8=;
 b=Z+a8kye2B/JXmnDayBfoxIJi+czOcorsZ2Sb8Z6XQexcAObT+ijwZNcy3IehGhq6VjBs32qB8oyPji/A7qo8RyUANmX3kYlxJJYYWGQfGMGWArtDWfOib7MCpVd6NsK/EFLFYZlMdcQXGkri5FyZwkLSewezLpawh3MlHRPzy62YttuT1hOvUdIrElnF0fcxIhXjvJXCq0O3oonVl+IethkB/gpPlQyLta2jAPKcT7tnuIaAxY3M0QaoLxyPdwNitbWzqAM7SjXMFQ8U5SJsCRq70gcvi5n9AS+ScXGOa0+BAUFxveuwKDeVgqVqmB1DS9q36jlbrvU1pLr2te/wDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR2FteA4hUBmjwSOd/CzGiRD9N0OJowHrm6Fh5e4OC8=;
 b=fG4SzqB4TWk6GsUGGt/2dWD7e+MNwqQwIC9fZM543ibN5sfnrIVgVZlhnsJ8Z3IGaa5i9ilCfQI+xP62KtEt4B7g3x07hHrOMKL+gtmnmOLBgTHK5qfBaE1dFAwDajdRotiAsy9WIqYk4u8sWoknILpHMIVhYuZRrYIW2NrA3uCLacsIgY/775JNTcwiNI79FYoKAKsQffK0vZrytYceqOQwm8xipooTABZMDII2NsnQL0IoW2bmMnoyMdVk3zya+d59nF9zaXMe7B4DHBaXCAYfwh7TuxaIAKeNAkYbDKic/KETOgINVGp8jEqXy6ErugMmvhrZzCC2r3LzEmyaqw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Thu, 28 Oct
 2021 01:26:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4628.020; Thu, 28 Oct 2021
 01:26:49 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Wunderlich, Mark" <mark.wunderlich@intel.com>,
        "Vasudevan, Anil" <anil.vasudevan@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 01/16] direct-io: remove blk_poll support
Thread-Topic: [PATCH 01/16] direct-io: remove blk_poll support
Thread-Index: AQHXv1qH+P943erAV06OqdujCsuajKvntwsA
Date:   Thu, 28 Oct 2021 01:26:49 +0000
Message-ID: <fee8bc8f-728b-6193-d735-8974b7ec427c@nvidia.com>
References: <20211012111226.760968-1-hch@lst.de>
 <20211012111226.760968-2-hch@lst.de>
In-Reply-To: <20211012111226.760968-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 254117d2-f602-4fbd-8e87-08d999b203bf
x-ms-traffictypediagnostic: MW3PR12MB4395:
x-microsoft-antispam-prvs: <MW3PR12MB43957162271AFEE91F67BCD1A3869@MW3PR12MB4395.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ElYayvUpx/+kO3g6kFR/ewFa3EtOgE6he0lYQpwpD8tvcddcFVBDJjdbakuvm4CDZRRX5v+3pPl97r2LppFZaeLyp137YGlqIrvEpd2V2zE6iESW8Pgxf0nw6y4/8kI695cEZglkgWQ5xhspzUs3NWY3ecUCr/HhDiKUFrMPuc0KObLB8/jH47t36MNIPgKNpy6yPW5cwFSRk09VOG9y4MtPBUfs/BzDPYrwZDPv0mDBWV+ULrwrcxA18IQD9jrCP0sCzowFLE/nVM1OZJq5Fz9tWFiJZbiH3scin0M1VZvWAF3WC5tflVan6eUdXkNRZo/Cw/l65845tuweskZXezbIuNJOBISHNCNbCKE7Jmi50qgSXLR4nPHKGFQZ8zWw0/yblQIyoeuSHTy7UZuN5/mEMcVhkUsIMkHN1wuP15VdwFphPrzw072JzKS8xGB9oAWL4I2gfbqyjH418h7mMZ8Uh5fZhWZCBHO7UsBSOng91wV0A3k5s745oUmw6punpuCesHqVkwltV5Y0rSQVs5fbkL01orYxKc06VR12G5TNybr5L0P7JQf/zD7dvNE255z6b860U+qMsZOVzSh899gBHcr+tPZyHz8+y8PpBGErtW4iXi13ZsHrHBcl3rVXLmiROUeuU7V6gkwzYllpOFVGVyw1AAEMGJDbw/YpUREoewEet5edzFpOaLdMl66mB/KDrPJmI3qV3BL4uJL67O0gnZB4qAUvqeN1b8a75MvDkPOAYgn15mw2oeDSt0PO5o1qbbztZE9VhwjKEmQaYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(66946007)(4326008)(66446008)(64756008)(2616005)(91956017)(86362001)(8936002)(31686004)(2906002)(76116006)(38100700002)(54906003)(6486002)(71200400001)(5660300002)(66556008)(8676002)(508600001)(31696002)(7416002)(36756003)(110136005)(186003)(122000001)(38070700005)(6506007)(53546011)(316002)(6512007)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDYvblhBVlppU3ZOZWt1ejJDdmhZaWxLb1h0b2xYRXJ4eWhtVS9KS0pEWFFk?=
 =?utf-8?B?eGpuMmt5ZG1nMGhGeUpQejB2Sk9LSDlVRVh4Zjl6MnpaN1pSNXFkV2pPNDN0?=
 =?utf-8?B?cDVRc2czbzRoQm1VMmMzMVVIbDFZOVRpOFdSK24yRk00TExydERqK3J0Kyty?=
 =?utf-8?B?ZUpMOXhJTEdqSURISy9aZXFKNW9Ec05Fdm1yeGpyd2UzKzdVMXBjSC9rZkxH?=
 =?utf-8?B?S1JaS1lsUDZZVnVwVlZ6Z3htTUpLTUxwdXVad2VhcVRXcUpXb3R4bklrUmo2?=
 =?utf-8?B?NVdUWHJFMzlUL0FUb3M3Ym9NZnd4anFNdCtnZDY2cDdJYndYWkFyT1ErTito?=
 =?utf-8?B?YjhIOERnMHhmWWJWNHdSOTFUYm05a3ExTVpMZzVQT09vTHhvcUE1L3ZzL2RE?=
 =?utf-8?B?SEt4QnhwYnMva21ERnl6bTZ6V29iOVdRRWg3Um1CSndwU3FvNmcybmx3bkJ0?=
 =?utf-8?B?ekhldjh0bElPWHpnbmRRUjZTOFNDL1V5NjRubHArYU02Z1NaTm9pK2k1WTNj?=
 =?utf-8?B?VGk2QUYzUFB3QVY5YXF6SFd2bjhTMm1IajR5bGpRYXROYXF0QkQ2emxKS1Z2?=
 =?utf-8?B?UGFPaThRTHB0VDQxZWtQc2E1OTROdS9MZk5jVWVmejVPVTVIalR3MTVzKzZu?=
 =?utf-8?B?UEY4Rll3Sm0xdzRZRTlneFFVS2JDQU05dlgxbzgyZmp3N0E1OW41TS9XdC8r?=
 =?utf-8?B?dC9YcW1xQ2NaKzA2UVVvRm5mWWN0eEMydGx6dHloWVhvQWRIa3poTnlGaThn?=
 =?utf-8?B?UFFUeTdRaWZCQTdrRHBCYkx3OWhzdXBjcFFjbEUvV2xUQ2pZMEJDSjkyTEtq?=
 =?utf-8?B?Z0lZVUZpa2d5ZjBTUStLVWY0WGhzelJZUlgrNTQ2OFJXeWNER0d4N1ZJSVo0?=
 =?utf-8?B?R2gzMzNqbUlPbmx3c0I4RGJVOCtLSk9JdlZobmgxQjJHYzhXZUIvTWo3dXZ6?=
 =?utf-8?B?MUhFRmtpbUlta2M5SWU3RzRnQkpnQlFiMlYxN0FyUUgyNWdsSHUva1JSellw?=
 =?utf-8?B?TFJEMXpnUitWVERFRy9FeDBjQ2NIcngrbTI1dmRaaG5WNEUrVnhQSDZla3dP?=
 =?utf-8?B?dlYwWlVvcEx4ellsQzFmSk5oYzdBRXZLeHBxR1BUWFZLRXhHV2RTT3JHQm9X?=
 =?utf-8?B?cWpYbFNBUFV4Z01zL2JrY2RmQzl1UFhuV0NBUkc2UkNVcmVHamx0RVZnakhm?=
 =?utf-8?B?a1NiWnl1cFM5L0lGUmd5SHRZWnJpYlR0TXNIeWFDYTFsb3JFVTVzT3dwUTdw?=
 =?utf-8?B?c3l0WFlNVUd0SlZ5Rk1lRzJwSEpPak0ybm9kVWIxb2IvSUJUSi9aSnlaR1pO?=
 =?utf-8?B?VDRQcXd4VXZJNTY3bXp6ZUxMMmRiNUNpNFhxTHJjNVllUXpqTG92UDlreXFN?=
 =?utf-8?B?R2pDTnBCaFloWjc2QjVwL2U5eDFKQ3FGV0V5UEF3dllReW0zeVlMOXlYVk0v?=
 =?utf-8?B?aTkxbDJ1TlRxaDFDbzRVbnpCME5jNDJtQ05ibU44MkhNL1hOajJueWlvL3Zz?=
 =?utf-8?B?YkNiRm5EK3p6RFB1MVBBNWdhZnNDTmxOMkthQVFtVmFFemZqZFhJWDhUdnJu?=
 =?utf-8?B?WGRzaFZrYzkxS3NnRnNQS1FDOVNjc0xDOUFacGZUeE54Q1RLVm5aUkVqMzZV?=
 =?utf-8?B?UCtQc1dORWIvUEdYVmdaSU5nRjZQOXV0MTFnVzRpa2x0TzljbXVPUzZkU1Jy?=
 =?utf-8?B?RFBhakhQSEdZekt1NXV3WkRvUkZQQjBpWXdqZnNydStXbGoxWjB4ZVFpV3Nk?=
 =?utf-8?B?SUE1V2RXWmRrUGZEQVpZTHdJaU53anVsSVV2QmJRTzBSQysvNGsvYnpFMmlv?=
 =?utf-8?B?UUJNdXhZNUltaDBnRkQwdnFIajU2RXNNVTdQTkVjN0R6M1lMK0ZXaHNkajk5?=
 =?utf-8?B?amdWc0kybkw0Qyt1ZTU5QnUybnhTaTQzU3FOaHZHNnV6VkRvVmVMeU9EcEow?=
 =?utf-8?B?M3N4QTErMnlWU1kzNXNiVDNSSTVyRDVHME9pcXFiK2lDVnhSK1A5TXdOV1BG?=
 =?utf-8?B?NWg1cUo0bm1Wd2w4R0QySHhWb0NFakVRYkFYUFRJQTVzc2RzREhEQkVaN2Js?=
 =?utf-8?B?YzR4Y1BoNXk5TjQxQ3IyTEt2L0RIUkhCUnlzTytqR3piYzQzRmc4KzJkU05i?=
 =?utf-8?B?bDhTS1loZm53bW9lRXJudUVoZFlHSFZ3b0tTWVJWNDFnRllKci9abGVjRUZR?=
 =?utf-8?Q?s2/no+gKDH2DFRQkRDZ4bLWP+tC0Rc/y0RDXv4kNKOSV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DE6B88B8B522F4CA9E1064607FF4E3C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254117d2-f602-4fbd-8e87-08d999b203bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 01:26:49.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLihO4cmjvGQhl75hmCtK8x9m51eNGZ4Ab2uXf+PVIqT56FQukbkLE/9+AdTQGDqEDAQ4gXNVJxKsCgcI6fNfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTAvMTIvMjEgNDoxMiBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZSBwb2xs
aW5nIHN1cHBvcnQgaW4gdGhlIGxlZ2FjeSBkaXJlY3QtaW8gc3VwcG9ydCBpcyBhIGxpdHRsZSBj
cnVmdHkuDQo+IEl0IGFscmVhZHkgZG9lc24ndCBzdXBwb3J0IHRoZSBhc3luY2hyb25vdXMgcG9s
bGluZyBuZWVkZWQgZm9yIGlvX3VyaW5nDQo+IHBvbGxpbmcsIGFuZCBpcyBoYXJkIHRvIGFkb3B0
IHRvIHVwY29taW5nIGNoYW5nZXMgaW4gdGhlIHBvbGxpbmcNCj4gaW50ZXJmYWNlcy4gIEdpdmVu
IHRoYXQgYWxsIHRoZSBtYWpvciBmaWxlIHN5c3RlbXMgYWxyZWFkeSB1c2UgdGhlIGlvbWFwDQo+
IGRpcmVjdCBJL08gY29kZSwganVzdCBkcm9wIHRoZSBwb2xsaW5nIHN1cHBvcnQuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gVGVzdGVkLWJ5
OiBNYXJrIFd1bmRlcmxpY2ggPG1hcmsud3VuZGVybGljaEBpbnRlbC5jb20+DQo+IC0tLQ0KDQpM
b29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0KDQoNCg==
