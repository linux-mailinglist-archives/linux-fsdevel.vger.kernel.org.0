Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BAE4C4A4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 17:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiBYQOy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 11:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242686AbiBYQOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:14:52 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6D21A8CAE;
        Fri, 25 Feb 2022 08:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iClmmIVYJ9Qzg5YdE+qfg3doHjQhyxZHEtHxzEXkThV8TN8AOMVWRfODRUg3YP/k2Xuel21Q2VrHGPDctgGgvQMM4M6Wz/GaOj5I54UZnFj5dE4+fUr8W7q53aJmEy96MXSYAI9VhB8NnNQapAKwU8n39yb9ZMbpLPUjIA26e75d9AicorxIf29ucUvkEEY8hz4QhAsBhMpTK+h3vGeTUI4/W/NdcU9FEWznfPzsNPx7OLUb6Abs5zSJvjLAMYFlV+OBwHF1MTw0pwgIKkhOkN86Lj0zgHKDey4BoyLMZLncnusTt1SZUPLczxUfYjm01xLxRpr0VUQVRgBjuHVdTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOoU0zZ5SibtUHvEVLO57/fc1JHW9HIDLYRWF6+ySQ8=;
 b=LfT066TKM4Wgit2vFJRcUxgNRSrM4x0XbDNgenmhXcjcyDiY5qWZKU300eZRemjS8uqV0m6kuWDbcmBOaOX8wEkuJOWA6wepTVjbRoV7OJVouxSXqTTQPQUVl+pjK0faTDctisiFM/srNSqYspobS1/uTvkLq+xeu9WPya9Rd239ndo/etXARAj1VHf2ZWBocuDfRL9YyiS4VY9WhOVOlWaeGbAAWZtxEBP6vpBMSCn8JBuc44cTB904j9XVaqHX2ORvS/sFUJjrQ30Cn3MEY0m0VgRpT7qInUJNFgqMIEbts95sR2pL/y3nCHBWW3k5dQrxpGoSHWkQurGPRfdZFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOoU0zZ5SibtUHvEVLO57/fc1JHW9HIDLYRWF6+ySQ8=;
 b=SjiVlTt2+CgcEoSJ2s6OhcBHzQVt4w8gNpNOvHEL/7w0qsDn4PrkGIebN5TeS+bweTGhLbn+00I8NFn405+uDfwxpy89KbxmfGpgx0Vl1LOkPvkXJKjQayVg+xADSea7knqPXV3d89Dqxtod3i5zyxm7lZte/2CqPi5T6fJLCIxSDKBzPe0VQ2+zZH83DfhrFJ21QP8hKNf3e3UQcSZepc42yVLWfcxrVlOyuRPLcq9E5zD2flo/qUGoxNBzVtbpoCo0UGNcYJL+TxkKp+xFt0cqNxuFP12AthZPfNaVrNiC4n5GGw6XCATAU5wlEaYeKUtm8Rc1z/hIazPfsvPwpQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB5540.namprd12.prod.outlook.com (2603:10b6:208:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Fri, 25 Feb
 2022 16:14:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.4995.027; Fri, 25 Feb 2022
 16:14:14 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Jan Kara <jack@suse.cz>
CC:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/7] block, fs: convert Direct IO to FOLL_PIN
Thread-Topic: [RFC PATCH 0/7] block, fs: convert Direct IO to FOLL_PIN
Thread-Index: AQHYKiTHzNIA+sagGE+MTrrVwGEMP6ykK6QAgABFh4A=
Date:   Fri, 25 Feb 2022 16:14:14 +0000
Message-ID: <1d31ce1f-d307-fef0-8fce-84d6d96c6968@nvidia.com>
References: <20220225085025.3052894-1-jhubbard@nvidia.com>
 <20220225120522.6qctxigvowpnehxl@quack3.lan>
In-Reply-To: <20220225120522.6qctxigvowpnehxl@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0fbd9ef-02e4-4ec9-8c94-08d9f879ddad
x-ms-traffictypediagnostic: BL0PR12MB5540:EE_
x-microsoft-antispam-prvs: <BL0PR12MB5540C0F5771BEFCB2221F36CA33E9@BL0PR12MB5540.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vS8XG2zIrCgAy+7hnaHyUmjQ3eq/0T8+eLIpsyhyGYMxYI4vVXeeCCU/l3gu+0urc2qSQnmDm65L6FwHygoopLIJ3e6Ek7sdqpXWXMid9Hb6/aQBrGMpAPXfXazKKPd78mYfZGuoWK8nHdIOaJ4R6B6x+pI5PqYQIp54/Rabtkr0NxQO+LRFrpbwlkZJTmkI3uI3c7jH5VfL7A/ft9zDAiIVFx08cOT+8Q+Q0mpBouHAzr1AGcLQTvhOe85EfRLPRi1XFaqs0wMxZjs8t7UtQN007d/IqK0PmcN7daBgbivlvsCNWRVgwLgI4+U5+pip6F8VpVVsLahNZf7SI5/XH0eBqOg0Eb4oRnBw6OobEnK2/rFc7l+BhbhY8b44Y9dfPRBzOtiUS6IFsEE2bkCTHnhJmcJX1922kQps4+3n82DK3TtzqFxDwc8DZ9OUHh4u5wYk03LdwJ2SGdnyqginw6m/2bBcjTCBOSYT+LX1pRIKGvz4Elp54C9oIWa5UYknRw930eENj0wVHrvbPQgI7iXsfPB6M06ax23D0S56STOqc8IqSVznxFuk20eMcig9Y051OoZoey5541ef4ocuWD489KwcdC/ZU42G6PqDQQfmR6+hWQpKogHWl56oO0e+OQ2/IgofxV+H9BCto5V4udPEKIKTVuUoM7bVLSH1lyCcO7D/5zeEnTTvkGYDsGugUQgi2/bWh15KW1eclEhbp8B2HovQBK/b3OHSxVlHk01JtdmwDl+OQXl0DX15bzhIw5XjI2XpvTOaYgWASsh3QUWGwTdmgzIsfMdcoP94eY/DzHKFOh9iaBUmZ5rSHvTVsSaizVfoDW5qnq8uCfWG8K3TCgxMD+K3XGUt4plcCU0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(4326008)(66946007)(66556008)(316002)(66446008)(71200400001)(6916009)(64756008)(8676002)(38070700005)(186003)(6506007)(38100700002)(53546011)(122000001)(2906002)(76116006)(91956017)(5660300002)(54906003)(7416002)(508600001)(6486002)(8936002)(36756003)(31686004)(6512007)(86362001)(2616005)(83380400001)(31696002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGN0T1Y1aHBIMERPTjB5Q3psdFNmakdpQ0lHcEZaUkkrYzVvZ2pMTjVROUJw?=
 =?utf-8?B?ZURNcWl0VUZWVnRRSmZBOXcvRG9QSUdpVWRLOHVJb1pDY1F3aDlkb2NhZmZu?=
 =?utf-8?B?NU94MytWdkZFN0ZSK3NMQ3FqK0lkeXBpZFI5SzdmaVp4RW0vS2d0bDJ0M1VT?=
 =?utf-8?B?S3diQndyaFFXOXVycGxlRlRxOWNUQUZ0dlg2aEtwYjRNeC93N051cVRTT0du?=
 =?utf-8?B?M1lkbEZ6cDFlUjlRWUdwcjI3THBqdWNEWDNZOURIMUpyQWRCNmJsejdEVXoy?=
 =?utf-8?B?aUdJVlhFaWRiOXltSWdKdnlsOVBzaW9zNEdlaFkydzd0RURta0ljSzhMSTR4?=
 =?utf-8?B?bjVvdElrYnhYZVl6SXVXOWY3YW1qcE1ucFFrWGR0ZmxWMWJyNmpqWm43Z1NY?=
 =?utf-8?B?em9kZDExWFJCTnBDSXp4MlNhQStxdU93aTdJTVd5M1VGZ0UzWVp4eXUyajZL?=
 =?utf-8?B?SUgxUGdCUnZZdEt5OCtYNXR6U0ZXaURVQVpoa2RCb0Zmd1UxbXAyOGNqVWwy?=
 =?utf-8?B?clBYNnRBQjB2YVFBZGtNbkpjRDdSRHV6TW9IbDBZbXRwcmpONVVMeGYwT1g5?=
 =?utf-8?B?NDV0YXNKZ3BvVmR6czVadzdFV0lGTmtOYS9VaWp5STFLS3lLbU10eFA0SHV5?=
 =?utf-8?B?YVV5aGxhWHZJL09BZmp1QVpHMDVucG9XTmgveTU4d2lDbkJTSjdMZzBLTUdI?=
 =?utf-8?B?UGpGSXd0YzJ6R2JObUMzV0RJWEZBanhFUE12T3o4NWU3VzBGL0JwSEZxVXFK?=
 =?utf-8?B?SkFEaWx2ZXhsR0w3dkVFUTQvQ2ZXcHY4YW4ydTVvQU5PNHpoQURMdzU4L0Zx?=
 =?utf-8?B?MXdnSWlqNzRKUXgvWmNuVzc1Nmxqa0xHZEhUWlREMTJ6ODcvMGV1WW5JbWg4?=
 =?utf-8?B?WkZFNjJCQXFOUkh4M28zRGtBRXQrZndwK2VEZUZiVzVHcUdTTkVQRnYrS21Q?=
 =?utf-8?B?OVBNeUN1S2p2WUNCZDd4LzhYWFVBM1BwTndyVGc3cnIyZHdkdncrUVkyT0Qv?=
 =?utf-8?B?KzFqTDhNWFE4djRCait6RURtRzZGN3JNc1NObjZtSE9zQ1YrVFdZTzNMa1Ns?=
 =?utf-8?B?T20zU3I2SmtieTJ4MytwY0xlUFRockk2MWp4d2tlZ1dlWmk0a2dKc1JKdUx0?=
 =?utf-8?B?R0dXaDUvVEo3dm5ZeUZVODNSUjRiOVRTeU5vSlNWSmwzK0txa29ZMXZnMFNY?=
 =?utf-8?B?Nm9tbWwvS3BhMHd4Vk5XT3Bxb2tyS0V5eUtQRjh6UERvYjlER3FxTy90d1RD?=
 =?utf-8?B?R1VnYmlHZVhvdXFwVWwwMVNJb3hkVEJIdlBUNWJmbjJ2aGFvR1VZS25jYzBK?=
 =?utf-8?B?Ris2TmtJTys4TzFJVmV4YzB6RVlGVHo0eEZrdC84NmhjVmpKTkJjZzkyYmpa?=
 =?utf-8?B?Y0VSK0FUQk9MNFkwc0I4L0NKbUpsQ3RCRjJ0UlNuZ1JoV3NkSFNvNHVPdU5S?=
 =?utf-8?B?cm01UXRhKzNIZ0ljWXpsUTR3cnVUNjVCTXNVYmgyMGJYWmN6QXZ6aTFQaEth?=
 =?utf-8?B?WWgvaEQwUDhlMGVaMlFMK29sTW50Vm96Q21kTE5SeWVjaExPQnZPazRSN2VF?=
 =?utf-8?B?cWdnaUF2L1NUM3diemw5RTE1aFYxYXdaS0xYcldwOHI3Qmh4U1ZqU0JjbmFM?=
 =?utf-8?B?WnlkbjdlUUUvdjBaN0ZLRU9TWlNFRzhockF4V01tRDcycGpEazhlTnFDL1o4?=
 =?utf-8?B?dldlNFlYSVdTbjFaSEF1SFF0Rmw5WHQrYmVPWmJVVWhwbHdFTUtZdllYV1BB?=
 =?utf-8?B?N28rZEpMdFZtNUlQTjlvTkRhTE5HeXdvb2gxRkpGVEoyT1I2QnY5U1BwSVln?=
 =?utf-8?B?Y0MyVVpwTFk5ZFI2SkFrbEhHbStzc0lUQUVPRTJQNVdpc0xGTnBJTVhXWUMr?=
 =?utf-8?B?OFhudlFuT1E0eWIxeDFTbGMwMkc4RmRicmVhUEtlQnBvQlNEaG9BODJqVnZV?=
 =?utf-8?B?NWgyQmlXK2VDSkFhMjFmWlFIcUFiaGRpRHFIRDlTZ0tjVjVWOG1mY2VyRUM2?=
 =?utf-8?B?bE44NWlHUVAwZFpJbHJ5clFkY3FVQ2VZQTAvVUpjMU5EV2RlL01WSy9HbzBq?=
 =?utf-8?B?OElKZVRIRS80cUt3ajFQT2lvWjhncEdwa2RJYlhQalN5bm1TOG1STFpvUWxw?=
 =?utf-8?B?S3M0aFJTS3haVXQ1VDRlaDhWZ0tzQWt5SU9XclpORG8vZWxMTDN0ejVtekkx?=
 =?utf-8?B?NDFjY0dwMTVtMS9kZXB4VWZoRWt4RE5FT0czSG1zVThhWTNJUlhBQlJseWs1?=
 =?utf-8?B?T3YrMzJNTWtXMFJ6R0pWbjR1Uzd3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A60E36E7FE0B1745AE0156E7550B30FE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fbd9ef-02e4-4ec9-8c94-08d9f879ddad
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 16:14:14.2255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eIMn/bA5XfPfin7b7TKzmVa0NkKjKb18FhBSubYsmerqhwlBNqAFMszmdNQkUoF2VYlx3EucmvTCDLkj557WeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8yNS8yMiAwNDowNSwgSmFuIEthcmEgd3JvdGU6DQo+IE9uIEZyaSAyNS0wMi0yMiAwMDo1
MDoxOCwgSm9obiBIdWJiYXJkIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gU3VtbWFyeToNCj4+DQo+
PiBUaGlzIHB1dHMgc29tZSBwcmVyZXF1aXNpdGVzIGluIHBsYWNlLCBpbmNsdWRpbmcgYSBDT05G
SUcgcGFyYW1ldGVyLA0KPj4gbWFraW5nIGl0IHBvc3NpYmxlIHRvIHN0YXJ0IGNvbnZlcnRpbmcg
YW5kIHRlc3RpbmcgdGhlIERpcmVjdCBJTyBwYXJ0IG9mDQo+PiBlYWNoIGZpbGVzeXN0ZW0sIGZy
b20gZ2V0X3VzZXJfcGFnZXNfZmFzdCgpLCB0byBwaW5fdXNlcl9wYWdlc19mYXN0KCkuDQo+Pg0K
Pj4gSXQgd2lsbCB0YWtlICJhIGZldyIga2VybmVsIHJlbGVhc2VzIHRvIGdldCB0aGUgd2hvbGUg
dGhpbmcgZG9uZS4NCj4+DQo+PiBEZXRhaWxzOg0KPj4NCj4+IEFzIHBhcnQgb2YgZml4aW5nIHRo
ZSAiZ2V0X3VzZXJfcGFnZXMoKSArIGZpbGUtYmFja2VkIG1lbW9yeSIgcHJvYmxlbQ0KPj4gWzFd
LCBhbmQgdG8gc3VwcG9ydCB2YXJpb3VzIENPVy1yZWxhdGVkIGZpeGVzIGFzIHdlbGwgWzJdLCB3
ZSBuZWVkIHRvDQo+PiBjb252ZXJ0IHRoZSBEaXJlY3QgSU8gY29kZSBmcm9tIGdldF91c2VyX3Bh
Z2VzX2Zhc3QoKSwgdG8NCj4+IHBpbl91c2VyX3BhZ2VzX2Zhc3QoKS4gQmVjYXVzZSBwaW5fdXNl
cl9wYWdlcyooKSBjYWxscyByZXF1aXJlIGENCj4+IGNvcnJlc3BvbmRpbmcgY2FsbCB0byB1bnBp
bl91c2VyX3BhZ2UoKSwgdGhlIGNvbnZlcnNpb24gaXMgbW9yZQ0KPj4gZWxhYm9yYXRlIHRoYW4g
anVzdCBzdWJzdGl0dXRpb24uDQo+Pg0KPj4gRnVydGhlciBjb21wbGljYXRpbmcgdGhlIGNvbnZl
cnNpb24sIHRoZSBibG9jay9iaW8gbGF5ZXJzIGdldCB0aGVpcg0KPj4gRGlyZWN0IElPIHBhZ2Vz
IHZpYSBpb3ZfaXRlcl9nZXRfcGFnZXMoKSBhbmQgaW92X2l0ZXJfZ2V0X3BhZ2VzX2FsbG9jKCks
DQo+PiBlYWNoIG9mIHdoaWNoIGhhcyBhIGxhcmdlIG51bWJlciBvZiBjYWxsZXJzLiBBbGwgb2Yg
dGhvc2UgY2FsbGVycyBuZWVkDQo+PiB0byBiZSBhdWRpdGVkIGFuZCBjaGFuZ2VkIHNvIHRoYXQg
dGhleSBjYWxsIHVucGluX3VzZXJfcGFnZSgpLCByYXRoZXINCj4+IHRoYW4gcHV0X3BhZ2UoKS4N
Cj4+DQo+PiBBZnRlciBxdWl0ZSBzb21lIHRpbWUgZXhwbG9yaW5nIGFuZCBjb25zdWx0aW5nIHdp
dGggcGVvcGxlIGFzIHdlbGwsIGl0DQo+PiBpcyBjbGVhciB0aGF0IHRoaXMgY2Fubm90IGJlIGRv
bmUgaW4ganVzdCBvbmUgcGF0Y2hzZXQuIFRoYXQncyBiZWNhdXNlLA0KPj4gbm90IG9ubHkgaXMg
dGhpcyBsYXJnZSBhbmQgdGltZS1jb25zdW1pbmcgKGZvciBleGFtcGxlLCBDaGFpdGFueWENCj4+
IEt1bGthcm5pJ3MgZmlyc3QgcmVhY3Rpb24sIGFmdGVyIGxvb2tpbmcgaW50byB0aGUgZGV0YWls
cywgd2FzLCAiY29udmVydA0KPj4gdGhlIHJlbWFpbmluZyBmaWxlc3lzdGVtcyB0byB1c2UgaW9t
YXAsICp0aGVuKiBjb252ZXJ0IHRvIEZPTExfUElOLi4uIiksDQo+PiBidXQgaXQgaXMgYWxzbyBz
cHJlYWQgYWNyb3NzIG1hbnkgZmlsZXN5c3RlbXMuDQo+IA0KPiBXaXRoIGhhdmluZyBtb2RpZmll
ZCBmcy9kaXJlY3QtaW8uYyBhbmQgZnMvaW9tYXAvZGlyZWN0LWlvLmMgd2hpY2gNCj4gZmlsZXN5
c3RlbXMgZG8geW91IGtub3cgYXJlIG1pc3NpbmcgY29udmVyc2lvbj8gT3IgaXMgaXQgdGhhdCB5
b3UganVzdCB3YW50DQo+IHRvIG1ha2Ugc3VyZSB3aXRoIGF1ZGl0IGV2ZXJ5dGhpbmcgaXMgZmlu
ZT8gVGhlIG9ubHkgZnMgSSBjb3VsZCBmaW5kDQo+IHVuY29udmVydGVkIGJ5IHlvdXIgY2hhbmdl
cyBpcyBjZXBoLiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KDQppZiBJIHVuZGVyc3RhbmQgeW91
ciBjb21tZW50IGNvcnJlY3RseSBmaWxlIHN5c3RlbXMgd2hpY2ggYXJlIGxpc3RlZCBpbg0KdGhl
IGxpc3Qgc2VlIFsxXSAoYWxsIHRoZSBjcmVkaXQgZ29lcyB0byBKb2huIHRvIGhhdmUgYSBjb21w
bGV0ZSBsaXN0KQ0KdGhhdCBhcmUgbm90IHVzaW5nIGlvbWFwIGJ1dCB1c2UgWFhYX1hYWF9kaXJl
Y3RfSU8oKSBzaG91bGQgYmUgZmluZSwNCnNpbmNlIGluIHRoZSBjYWxsY2hhaW4gZ29pbmcgZnJv
bSA6LQ0KDQpYWFhfWFhYX2RpcmVjdF9pbygpDQogIF9fYmxrZGV2X2RpcmVjdF9pbygpDQogICBk
b19kaXJlY3RfaW8oKQ0KDQogICAuLi4NCg0KICAgICBzdWJtaXRfcGFnZV9zZWxlY3Rpb24oKQ0K
ICAgICAgZ2V0L3B1dF9wYWdlKCkgPC0tLQ0KDQp3aWxsIHRha2UgY2FyZSBvZiBpdHNlbGYgPw0K
DQo+IA0KPiAJCQkJCQkJCUhvbnphDQo+IA0KDQpbMV0NCg0KamZzX2RpcmVjdF9JTygpDQpuaWxm
c19kaXJlY3RfSU8oKQ0KbnRmc19kaXJjdF9JTygpDQpyZWlzZXJmc19kaXJlY3RfSU8oKQ0KdWRm
X2RpcmVjdF9JTygpDQpvY2ZzMl9kaXJjdF9JTygpDQphZmZzX2RpcmVjdF9JTygpDQpleGZhdF9k
aXJlY3RfSU8oKQ0KZXh0Ml9kaXJlY3RfSU8oKQ0KZmF0X2RpcmVjdF9JTygpDQpoZnNfZGlyZWN0
X0lPKCkNCmhmc19wbHVzX2RpcmVjdF9JTygpDQoNCi1jaw0KDQoNCg==
