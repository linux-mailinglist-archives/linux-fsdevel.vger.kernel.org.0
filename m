Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CFA493053
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 23:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349397AbiARWKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 17:10:21 -0500
Received: from mail-co1nam11on2077.outbound.protection.outlook.com ([40.107.220.77]:61024
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233791AbiARWKT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:10:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTxRABRUhmS/yBeBy4NYJORHrHnnNss0PH+mgSJ0hAlIVWp7Htbu20cXjIy2RjretjHTMhHwXofgSKJ1EUUr7xk+Nn/2ZUYcYZtfIGjCUrAKczG/K6R0z5n8TIRkc/K8ifs1XJdejW9sEgx9bZ2SsXynBOAIZw/8JHo8AghaT38rDztmqKOa1VbSZe0uaRM3I4SHJqTSeeXqV72M7mxa5sAm9IyWSkvba38sj+2aRS5i98a/MYVTAz/Xtssw3a79JMwW98ZYnyFXtTf/VywwbnLAQ56XHoN55blee/Jd2NyoBUUzxcXIMzQ7VjF3P+0v0LOVYMblLItRsm+aSHSgeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10TAAnZvOSR4S0y2NuqUH4W60yc9IevVM3hnAGv74bc=;
 b=oAc1oucyUMt7e/0jx2XtEhXIV3/yPfGQ4pSOT1YfIyDV+6nFi+tvCJ7eSK78fcTx1eK98GRubjoPsbg11Ia433gLG1PNUrsLWnoyu+nJjvZjrZpmRpxWd6E3qeoYVhrECRuMQg4WZdGS7FRE5YWMDkI8fIYU+QRKkGJNBBuY8PQ5BGTYRDnKtkNUCu0Svo2vK79rlphbG+38sa7JDUNARihIiLazNvGhoF+ap+UouYGecBJQb7V8oVWsCDuiSWsgGSHwV1VRFmoerthZplu3MZTSsgY2j/L8ENfi+1kYG97lYJr2noug3P+Wqo11X61BGoq+ztJTin7KsGEecivvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10TAAnZvOSR4S0y2NuqUH4W60yc9IevVM3hnAGv74bc=;
 b=FhXV9Xl012EiGpClBUVVB8qPdyvxDkKnr5exmZ2iEUFQt7zImZmW9VVJDXZcagdYqGYNJxzP0jHifQ5OSrksjNkg/czJQX91qU/TKVvDdpAYnYo+MuRHqVUGKixBRXKG8Y+c/j5H4VUkVjhvkRnjkTGV1/qDOPvYx2EmfMXppiGSNA7A/DXelI29lqc3sUzj4Cey6XJoHRVAvahqcV+GxQ6sQ8fdkJfakpeeti/rmQuUw+cMgCiaR+FtrhVQi8ebUUeYCgklDblHrRLRKhunNSV9HsJtOM2D/4ovfTSaNQ+DmnuRWYSHqIobASY3dXsnA+0JvbgIc2Q4q1ETfu58+w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2379.namprd12.prod.outlook.com (2603:10b6:907:9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Tue, 18 Jan
 2022 22:10:17 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.007; Tue, 18 Jan 2022
 22:10:17 +0000
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
Subject: Re: [PATCH 13/19] block: move blk_next_bio to bio.c
Thread-Topic: [PATCH 13/19] block: move blk_next_bio to bio.c
Thread-Index: AQHYDDwIi23zfbZWP02cbOp5v0GjmqxpV+AA
Date:   Tue, 18 Jan 2022 22:10:17 +0000
Message-ID: <898045a2-19a4-15ba-a352-ce1767f17cac@nvidia.com>
References: <20220118071952.1243143-1-hch@lst.de>
 <20220118071952.1243143-14-hch@lst.de>
In-Reply-To: <20220118071952.1243143-14-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3621004d-42ef-40d2-624d-08d9dacf4f4e
x-ms-traffictypediagnostic: MW2PR12MB2379:EE_
x-microsoft-antispam-prvs: <MW2PR12MB237997490FA666B9FF821D5FA3589@MW2PR12MB2379.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s02X2IWbX4rKx8KySN+biMpWmkIFrCBJBvbfdvBsF2wiHI8e/5CB5IcNgwc6amdCF73sviR5k5KMr5Z4ll36fqJXTZU0hQfniPWiPeJfPbUgJdSJjJljUVThr74/33qayKtzM9+PGtJILtW+BdTvO4LamCTArcZVsBX0We3rJHMdN9QAyYxr0NUquqlgQq3a2M8e/kWZ9DFGMrtlHZ/Mgiroqb2XS4Z3E62A0OyL73LPNMqfX8HX5UaT7t+nBjBqJ0RLeAoueglXtTwNx9NDUR9tDSMo2j+aNwZjGWblJmD4GhCvWSDcoST19IcyvTRqppgaPX+LIu0X4NVJTk/4FkFhfd6s4eXt6lpfioAyjapjwAyuCZ3YulUfmFVsDxBkUq4GACtJUZyz2soaPKPSdB7yx6gLRFel/IUa16h3tztRHZlRf2uCsVRqIjr9qYipvuNKA4vd88L4013HJIBT66SIhQ/3uFuntGqtSIraDJkOownNEfXzd/G4WQ01byRy5KThFSqsW3ePI2hQ2MONg2RE82RfI0IodeyQeBt3SDxb6+43DVAHZ4IMH62eSWkwyF/RgBii/4drf+CQOhohzGsv6uYT+alaTO4prvKQewa0+DX9qFazy4NpWgajuuYuKxrI/4JVDMS/xyZhgBIYO0azX8tp9dq3JlDMy23Z/wzQhLVPR7zTyg1NCwBL4cHWyOXpH1jqGXYDPehWmsKMva7i65WuVcYCey8vtnqToQzTulI1kEIgocmmp2s+Faa/sM9z+8rolOUFWd0mwWOnLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(38100700002)(558084003)(36756003)(54906003)(8936002)(91956017)(71200400001)(8676002)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(31686004)(316002)(186003)(86362001)(53546011)(6506007)(4326008)(6486002)(110136005)(2906002)(5660300002)(2616005)(38070700005)(7416002)(31696002)(6512007)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUZ6YmhENUNEd0hLU3BzWlhWYmJlVm5YamdCNDBrNDNJcUlyZ3hDMnlRcUJN?=
 =?utf-8?B?bEZtMEZqMlduNy9VUVJHKzBLa3Y3dlN0QXFJTFl0VUtrZURQZWJ5OHNHMlg4?=
 =?utf-8?B?b1lsVnBVQVczTG8wT2pYUVhzOXdxeUphNnZEZGpZVFcxY2lZN08zR05UMmlV?=
 =?utf-8?B?ZTFjV2x1eEc3QnJVcDlsSWhQYnhkTis0T1EzWTgxc2hkWFBxSUtFV2F2MzZr?=
 =?utf-8?B?aTFWbm52NmNmZ05SRUh2RXQ4clZiemFObnVQTW9Td290ZElsVDNraThOSE1r?=
 =?utf-8?B?TW5PM1FtYklna29GTENDcjJYdDFuNWlNNXJuU241TFdFNWpMMCsxRE5FZklm?=
 =?utf-8?B?ZncxaDRkankwWFhnT2N3ZC85VlNqN29HM3pwZElvQyszV3UxTFVTKytncVA3?=
 =?utf-8?B?Q24vaFVQa3RkOUx2TmxBUXJVa3Z0bVVLKzNUSzJOUmpPUS9WTlQzUHRDYUdL?=
 =?utf-8?B?OFZmTnJGM1pIRjQxZS9yY2g4djNiYlBuRWZ2elVZeWxLdElGU1o4ZER3c0ZP?=
 =?utf-8?B?b1ViM0ltWkFRaHRtR3FEWkNTdGFpQ3JBRW9FdDkwcXN6R1ZGK01XdWs2S0Ra?=
 =?utf-8?B?OWFXNWw2bDBkNG93ZlpwWVJlNjY2WWxlUXFnWFhXUDRaRDNNUzVpbmdMd2Zy?=
 =?utf-8?B?RGlZc2ZHSjJGRDltVldJY2Z5WVc5VmJTd0FSbTVEM3Nnd3BaWVR0TDN4YXFy?=
 =?utf-8?B?OEgzY0Q2aGthUk5LMDBlelM4UlBHNytpOE9ya21NZFhicmFiZjdqRUxqSi9o?=
 =?utf-8?B?S0k5clg4QUhSZTg2STY5VmZUUVhFTXFNTHIyYytJMU1mZ05yc1M2VlBldXY5?=
 =?utf-8?B?ald3cHpqYy9id29UWkQvOGpmbDJMWXlSU2dyYWwvK0F0NENaQTlScnZtNnRq?=
 =?utf-8?B?REMybHNSUTQrYnZzRDVocjdjWGVUY0NVTlNKYXFJYTVXMHFlRGVjai9XV1B1?=
 =?utf-8?B?K3ppWTNpS2J4WlRNZWxDd2VRQTZKNDRBQmRlOWUwR25WNUorQ1BRSDZiNE5a?=
 =?utf-8?B?cVFaM2gyRE5iODE0djU5bVlVUEo1c3k1eHVES1VsdzJ1b0h0d3dlSlBUWmVB?=
 =?utf-8?B?M2lnbjh4UEJsRFhXQXJqdW5mbjA5YWsxQkhsNGlLNlQ4RTk2dXp6VjNQTC9K?=
 =?utf-8?B?Umo5OEo1cHpRWENKc2YrU0hOYzdibFZyQ0g3N1d2bFNPTkNVamZDUFl5K1VJ?=
 =?utf-8?B?MzluSGlxR0h1SkhBUEVCaDd3OWovajQxUWJFYXJidWtONTl2V1lLaTZUaFdn?=
 =?utf-8?B?QVpXU3lQSDZHc1BycEh3MmFUSGhXTllGeXJteTRtUEpocWhCYlVEK0grQmxs?=
 =?utf-8?B?ZmtMS3EyL3BtZEE2UG9FOTg2NzhqbTdtNHpyTW5zYmM4QjM5Ym1Gdjg4MUFE?=
 =?utf-8?B?cHBiY0grRkZaWXlDa0l1cFFGMmtzS0FRT3hQendVV3p4Y1Q2Z09XVExvcklG?=
 =?utf-8?B?VEZiajJjdkpEcUh2S3V4cW8wRFZMaU0zNkt3RGNna0tSQnNWNVpmZDZ4UjQ5?=
 =?utf-8?B?UHpiZk5Id2Q4cGV3WXo1NHVURWNidzIydUQ3Rm1kaUR0YkdPRnlKTUszK3Bs?=
 =?utf-8?B?YmlsQTI0YVB3Sy9kYjNKc3Erb2wzVEZ3RkFYTXRpQ2Z4ZjdNVXFORjU2R2NT?=
 =?utf-8?B?Mnhtc3duYjBxTHlpZ1ArYVQ0NWpBMnEydmYzSUZaSVNoUVBkQVZVbWMxOUhE?=
 =?utf-8?B?WDh1bTRyYThHSnozUGxLT0c1ZVFJTU9ZcHZ1QU5WWEx1SWJ2VzZIUDNPb1g2?=
 =?utf-8?B?cFRjK2V3Zk5jMFQrRXc4N3gzc3dFWkFXeThKMUJFZ1laenFWTWpiczRtNi9B?=
 =?utf-8?B?U3N4YlBmb09CTkcvRjUxTVRGSnJ3Yk5NaEhSRG9zZk5NMFh4VjVnY01qbGdu?=
 =?utf-8?B?MldrZUxrTWxGQjNTTmw3bnpJNFBDOEp5Y1NUQTJpOWFmd0dLZGJEWnBFWFl1?=
 =?utf-8?B?SG1WRWRoVDJQUXV6QmhUazFybCs2bERQa0NsTzZnK1BtOFdDUzRpc2cyMWVu?=
 =?utf-8?B?bGlPejg3SmxpMlJWQXluN3NBQmZSUCtWY1hHdlRGRllFT3ZBWklNOU12M2Jn?=
 =?utf-8?B?TnhlMDRlbG9Vb0FlZDlPSEpTYXltUzlnVmM1TGZ3K3U1WXNMOHlBMjlHcGx4?=
 =?utf-8?B?QzRETlRVWnpBQnprTnZ6V21GT1NXWnVuZFpieFk5ZVVDOFZiWVFaNFdJTlZv?=
 =?utf-8?Q?iCDaB4IKaPjMnFjoRwrMGDEO3HjW+GEP0SrMW/NArikj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B517DE78369F2A41BFFA7CE0A7153DC7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3621004d-42ef-40d2-624d-08d9dacf4f4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2022 22:10:17.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zj5k0blmXFkwJkXgnsmSuImlrYYFcoQQK20MteejdX9QG8EDrKYlnMCCxPbP8Ay7cdDtxYWYd2jyIv9ntTJBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2379
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMS8xNy8yMiAxMToxOSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEtlZXAgYmxr
X25leHRfYmlvIG5leHQgdG8gdGhlIGNvcmUgYmlvIGluZnJhc3RydWN0dXJlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQoNCg0KTG9va3MgZ29v
ZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Cg0K
