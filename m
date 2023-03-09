Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5418B6B186E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 02:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjCIBE0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 20:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCIBEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 20:04:21 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349FCAF68F;
        Wed,  8 Mar 2023 17:03:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=makKs3V5Nnx0UPhpRFj/3kz4WiqifBK5DJ2Woh+4jJppjWj4KHCxK/WyuIicvDq5n8DFLGiSAE7pKuFfSmW0Rm7aQl+2FyHhzTsC6nxU6bwylZxCtVMLg61m8r53R1ToatjHIVz+v1l5s+Zf043JNHHgrpNDklz2WTCdP995/xzH0XFPl/ur94CpJ+VFyEk3m5u1aN6/aXVTjHBJJ8yHy+n8ViQI2I+eJWugFArB2pJ5kU7MowAF9uqanpZNN2vjvmGIv6VhTvDwwbGw1OLvWL1AMRswXHihNPQjxcnCaAVqZ3jPWd1+vncuDJByqk+L1kGIMnUBqt7ZM1J8P97cQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO5n518laOHNe624Axyz0DXAZC8IVYYIvXA9ksuQoM0=;
 b=jYMQzrEF6JTDWxSg2Nb9TOtIIz3vUWHIn2dHesVmK+1Vjh6iZf6xuSbNdiO6b3N1H2/KxSzSn19GR7Ln25+caPwTyU6PyMIy4fksH3m8JuVkDXwRbJ+3EvLhyhNrXSB3Zo3UkfgMQzigY6WCMhgxSF7QPKaeeE4oisaONSdMMl+ronua1XAPZQXruZjrh5+7exz1X63d9X9VRc4HaR9MDtawhXoI5BZ7OGJElmzgI2EW5KJYtXOWGLkQyQICL4JabIJUUuYBlhL4HLbxo9lKcltkbAHLwAmr2B+jqX2ZBoH4SQ0HiViUJYT0Nkcq9ZWjeYG7arUkqunOTWvkePf/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO5n518laOHNe624Axyz0DXAZC8IVYYIvXA9ksuQoM0=;
 b=BF4ApP2G41bKc7Lrf86fDxix+puXgb21z5Gtsnl6PcQzg5Hx/GrGYTsIZrg1C2SBpBniqtLnZgoukwhDtlF04SGUG2OxOg1swtaa9b3qFV5z8mkVZBsOOqOe/cdtxi/cic++28UeOvkVE/982mbuTeeDcxQwuecX0Tmm5smrrV8y5rxrVqIyiYic1L4phCzJ5My+snm5DdlTMxyGMrVM/XVIV44L1aZlnYH5eGXQUEr+ja3LLifz1C7KOUgnw8E7m1lMdk9ECfZLK38LArJVK+7nGy81iahHdOWGuf2RmlDFO6ep/4N021+9wHNPMKaRp5a68VGoLtRx0aJqwD5XrA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 01:03:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 01:03:52 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "brauner@kernel.org" <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] splice: Remove redundant assignment to ret
Thread-Topic: [PATCH] splice: Remove redundant assignment to ret
Thread-Index: AQHZUNG8E042L+4ihkmLXF77Zg+jgq7xpGKA
Date:   Thu, 9 Mar 2023 01:03:52 +0000
Message-ID: <525a319f-575d-e0aa-06d5-906f4071c81b@nvidia.com>
References: <20230307084918.28632-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230307084918.28632-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB6713:EE_
x-ms-office365-filtering-correlation-id: 1e6eb76f-2836-4a51-4c88-08db203a2603
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pM6v3qUeoi2xw9vqz10u03VwWZbwflyda+Jn/orBWto+NnQk8qXsHYlctIDqf2MUs8gnZwN4gequJXqCR72DiyFsG/CMpQ5PrrzLckclatFnIuEHXPxSThBKNdmiywksoQSpmgCOQWrOyJlfh0UoKPd0c0BlovmS2lrRR56Z96NqF3P21buaKcjjEnGkCeh3wQy5VM7KVaoICRZiQ0aWrlkxOoKEG+fv82bLQHr9UijUXCudq1khAZBob7qN8cpsPIMPSAVvTsoK0RWVEtTzGRUbY7TncRd6L6Mu06cdYErV3y/KjSRaT47rczHei1gJRA6+D7Rp9BKRC9cnNf8AyWVPp5Mf5bufRs6736NAoah4uSkpjIPdVJo+dHDtNVAMGK4r/fwUZOu3rcimulAcu1Mt/cksLgp1PzttwdZeWkGCq7p2A2KqqDnaH6SvWptZ8DcosvWnlzc9uJonwmcxzdA/LZMLXUaxip9rlA7LB7LpH23sHFrd9lbMyDhTPo3uSRR9gpx4bxWRfVht6ta0cMKL3dt2EYubrzCVkhLrWWv3OCZtdLv5F+cd6cOsULSttYb1QQHUZAS0l0S+EEz5iTxh/N5Wrv2MzBIdTRsprTwJHbK1mpvbzvFzls7zclSyASTxRYxbAg5buE9IRhEe9p/mf2D9T/KziyfulOCkETe/dTkJQpUA8gtXMkX1oDlqN48xG1cYMPMKBNuKWIOF0kLWQQtj5/tPgFYjYJxSwkVg6BWj/UYk6uF10P4NJOtANxSSM6XrfkI8+eCSuJCj6iv4UB7dNieiz/6JMxKX3WPQThMeYgCoH4VxitjF32/K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199018)(38100700002)(31696002)(31686004)(316002)(86362001)(110136005)(54906003)(66556008)(8676002)(66476007)(66946007)(64756008)(66446008)(122000001)(76116006)(8936002)(4326008)(91956017)(36756003)(6486002)(38070700005)(966005)(2616005)(478600001)(4744005)(5660300002)(41300700001)(71200400001)(83380400001)(2906002)(186003)(53546011)(26005)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnZaNlVkNy9HWUFiQ1Z6dFB2cXhNOWt6ZFdtNEJoMlZDK3NjYS9PRE15eENy?=
 =?utf-8?B?VEdxSUZKM1BmQnpLUjQzcWh6ME01dkRDVFl6anhWaDJXbzN5T2wxbFY4ZE5N?=
 =?utf-8?B?T1M1TkZRVzFkU01sc1haOHpaUjJSZEQ1SXdXZWhGQWpnWDVxU0FsdEt3V2Vp?=
 =?utf-8?B?eEZvRWtSQkN3dk9nYmxKZkhRTDRtakJxYWZiMlAyRzZ1ZkNYQmY1eUpBa1F3?=
 =?utf-8?B?MGFoUmRsMTk1V3RobjRhTDM5VEpZRndvWGJGVWVkdGZNUzVvRXRqczg4ODVB?=
 =?utf-8?B?VzBaSW5McEJDdzAwU1JiWEFNYWs1ajNJa3AzREhUL3l2LzFnTTFOMm9VNGVN?=
 =?utf-8?B?N1N0eDQwNmRMWTFGb09UUU1GU29BZG9XNjVrNHdvV1p4ZlNqUS9kV2FESVh1?=
 =?utf-8?B?SHNiTW9pNSs5ekgrUTNybm1LN1B4QXB3OWJweEovdHllM0ZKeGl4MkJpcVMz?=
 =?utf-8?B?YTdyNSsvZEJBVnRwT2swTkMrVjJNRzl5cDNNWTFwVDJQaWQ4TE0wMlFxbnBW?=
 =?utf-8?B?NG9nRzBJR2R1TXNiTmk3My9yWENUbUNldWs2VnplUWMvTkQzOThDSXcyRjV4?=
 =?utf-8?B?SnhqeTJUalVieVgzYjVaVWlHRGNJVUZtekVWdHhVa1o4aHBZckh6QUVjNnVV?=
 =?utf-8?B?M1I0UXFPRTVYUUtLR1dTNmlRSk5GcnZvQWU4QVluZExMR29IRnhvZCtPSVNL?=
 =?utf-8?B?Zk1SNGM4MzkzVVBGcDNFcldIMlFRMWx4KzFsbklXY0w0Zm9FMTdBWHlSZERt?=
 =?utf-8?B?Y0tzRHk5a0hZL2lvaGQzLzcwaWtPT09sSXU5QWtqb0Y5a2ljenJPa0swTWh1?=
 =?utf-8?B?NHZaaGNyb3k5SlpoekNVaHFyOVd6Tk5RZmtHaGhZVEVGQk9uUnp5djhURmFS?=
 =?utf-8?B?YzVFeHc5RjN0S2pUemNuZld0M2FSYTNTNG9EMTRsMmJSN3lKS1BSQlA5c3Jl?=
 =?utf-8?B?dUJucGZJTVg5WmFBUVk3Z1Jlb0RMdWs2SGE4RFcxOFpIRGtvMHMxQTdPb2Vo?=
 =?utf-8?B?YThxc2VQR3UydEFLVTJYOHp2M3BxMWs4ek4rakhmMUlmRW9YeEZiaWhQOU95?=
 =?utf-8?B?TG5GMXJUUVpPYS80L2EvSTIvbXd3VnF5MktSSlg3QmY0bXBxSTJxdFFFQTZz?=
 =?utf-8?B?bVdVaWlyR2RpL285dm1CQThsSnFqYjkvTWtHRDhGbUxHbXpCbjZDbEdSQzJk?=
 =?utf-8?B?T2NPb2xYTUgxczBra2ZoZEV3QWZVNE55NGtmTEtuM3dCaElUcXpHb2RBWjFR?=
 =?utf-8?B?MER0RXRwelU4ejFyYlhrRFEvRENZRCtsNUFUOG85Z05Ra01CTFZYY1kzMVFW?=
 =?utf-8?B?TmVHMXB1YUxZOTNDakc2ejdtTUw3a2xIQ0plaHY0bHRaQXNkV3lENllJOUMy?=
 =?utf-8?B?Y2lsQUhzM3pZYmtwUXRZWE9Va2dZcm8wbHhvcFgrZUkrclRxd2VlTUVOYitk?=
 =?utf-8?B?YVFtTkJxeHQ4WnhmdDdTNU1sUmJwc3V3WGdPWlN6WVB3cVpCckw5R21IWklZ?=
 =?utf-8?B?Zks5a2w1c1Rvc1k3ckM4SnFlQ1diYm9YZ3JCbmxrREhnWHI4eSsrcEY0NDc3?=
 =?utf-8?B?cFhnc3ZyYXZ2ajZzQW5XSCtweEk3OFJ4ZHF5RTlpMU04Q0N2eGFJSGcxSitN?=
 =?utf-8?B?eStERGlRUkI5U2xTWlpmTVdWbjZ3aFdNdW53N0kwd0ZSMFFWeTJaL1EzaGdi?=
 =?utf-8?B?ZUlVbGdUWGY2ZFpiSTU1eUhnYVpMeW5GaHRweVpaKzlaa1ZsNHVTc0RJdyt1?=
 =?utf-8?B?aHU2M0hQbE5Ub1VHTEFWd1Q4R2tpRTJFWVo1RXVvbkFBR0x6dlJhWm4rbHlr?=
 =?utf-8?B?ZnZ6R043QjgyL2JNZTBncTRmMjNORUlYNkV4WlBWYW9DT0Q2R0JJNzBwVGFE?=
 =?utf-8?B?ZzNySTN3KzB0TXV0SGJTajFnT25POEpMUTNkamRZelJLN0VjTXlTOUNmeUZK?=
 =?utf-8?B?dkl1L3VESGpOMnBDVEVlVnBZL1pCVDlEUTZOZlpmeDFRNW9MOHFJYkp2d3Ay?=
 =?utf-8?B?UjloamdicjAxditwZDhVQzB0NXBLWlhhVTIvaGR2azE0WVZmTEFTVy93ZXR5?=
 =?utf-8?B?YnVWd1NNK2wwUkV4WG9iaHArTTVlYSt3L3J4eDQvYStXM3NieWhuMlIzRDVI?=
 =?utf-8?Q?kDIlioNhwpRJosbwOOidzHiAG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22691334A237A44FBDD96EF62D87E405@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6eb76f-2836-4a51-4c88-08db203a2603
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2023 01:03:52.0530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1kRDBXZFPx9HLrgcgvaz5uPdyQFumUqQCbQQkTDxGXfisETmrKnizYNBA92wiRCUWNZY9zVK35XRvIzQ2YGeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy83LzIzIDAwOjQ5LCBKaWFwZW5nIENob25nIHdyb3RlOg0KPiBUaGUgdmFyaWFibGUgcmV0
IGJlbG9uZ3MgdG8gcmVkdW5kYW50IGFzc2lnbm1lbnQgYW5kIGNhbiBiZSBkZWxldGVkLg0KPg0K
PiBmcy9zcGxpY2UuYzo5NDA6Mjogd2FybmluZzogVmFsdWUgc3RvcmVkIHRvICdyZXQnIGlzIG5l
dmVyIHJlYWQuDQo+DQo+IFJlcG9ydGVkLWJ5OiBBYmFjaSBSb2JvdCA8YWJhY2lAbGludXguYWxp
YmFiYS5jb20+DQo+IExpbms6IGh0dHBzOi8vYnVnemlsbGEub3BlbmFub2xpcy5jbi9zaG93X2J1
Zy5jZ2k/aWQ9NDQwNg0KPiBTaWduZWQtb2ZmLWJ5OiBKaWFwZW5nIENob25nIDxqaWFwZW5nLmNo
b25nQGxpbnV4LmFsaWJhYmEuY29tPg0KPiAtLS0NCj4gICBmcy9zcGxpY2UuYyB8IDEgLQ0KPiAg
IDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9mcy9zcGxp
Y2UuYyBiL2ZzL3NwbGljZS5jDQo+IGluZGV4IDJlNzZkYmI4MWE4Zi4uMmMzZGVjMmI2ZGZhIDEw
MDY0NA0KPiAtLS0gYS9mcy9zcGxpY2UuYw0KPiArKysgYi9mcy9zcGxpY2UuYw0KPiBAQCAtOTM3
LDcgKzkzNyw2IEBAIHNzaXplX3Qgc3BsaWNlX2RpcmVjdF90b19hY3RvcihzdHJ1Y3QgZmlsZSAq
aW4sIHN0cnVjdCBzcGxpY2VfZGVzYyAqc2QsDQo+ICAgCS8qDQo+ICAgCSAqIERvIHRoZSBzcGxp
Y2UuDQo+ICAgCSAqLw0KPiAtCXJldCA9IDA7DQo+ICAgCWJ5dGVzID0gMDsNCj4gICAJbGVuID0g
c2QtPnRvdGFsX2xlbjsNCj4gICAJZmxhZ3MgPSBzZC0+ZmxhZ3M7DQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sN
Cg0KDQo=
