Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B55B30CA0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Feb 2021 19:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238630AbhBBShY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Feb 2021 13:37:24 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:51816 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238631AbhBBSgE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Feb 2021 13:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1612290892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jiiDOpFntu83b5XdDkP7UbqlS+JaMPdLMTFraEnPpFo=;
        b=k11WidkHLlpixord1QtrSyiCYLGRJFKnSXTEQsoSBu3pOQHzhIvO9B60aHrtgjUfLIc/BN
        lNU4ZYYeTqAVQayd4v9cKkWrcOY9vqIZ85FweOdIc2Xap59YpeKDY35X/aulquj0FRaj6n
        8t1SExek5sokzEfGZBDOB1DOdF6qitw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-8-ghh-CacKO8GI2U0JSdDoew-1;
 Tue, 02 Feb 2021 19:34:51 +0100
X-MC-Unique: ghh-CacKO8GI2U0JSdDoew-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhAlBVyqyEQbzvgdW658x7OR6M944aAXwsZJ6JcQyc6WLELFr4QlNNHy2CA3HGSP2owAlRoWoElX0a38m60P9HIE44Rz0X6g9lKrQCZq6hfs8WmYjgRw4Rx3uTscDZOlLcaD+l1KJfCysysMnNLpvTkYj01Drq5qtbefMtxk8OX+3yuQrpGLXmUmN2Cqb1HzjpXaoXLDPzGFnEIxQrVPnyd4iP7UIewdaZxTqlgK+x3sI3Q+5oJXEVJx24tR+tUT6zJ/asc4UbPCXHU8e/o2EZzQlWD+D1KoOT99R0FSApLMglzM7VKRqD1trtGvWcpiGpgNq6l4P016JRy0cUi15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiiDOpFntu83b5XdDkP7UbqlS+JaMPdLMTFraEnPpFo=;
 b=AFBxjgyRK6phMAnCePKOqMQThLWp2Ulsm7WAC3ponYY7EgrdAmb1JY0HCX0pIZIMEF+QUXVsnk7KOPqqM1Blc/4LpZYk50VTklKT0v9ZkPEKsMCibRczxiaHc/2/zDjexn/VZ7mLJ3GpUUWoy2lKgjiAwHUKA9hp5j/GkVq74N/TosPOJ5BysJ3tcgOlSOg3eiQbAk5LfqVetFMlzA5sFvdQFG6JqEbP5QAqkLcctsRZTK1MAikpe7Sn28u7TEDKC4h9YKCZmODn8t/EcdSCO1pky4u4g04aGjsYrGtMkq2YCzGvQFb+9WexOVAYcOnk6fkK9PZ2rSB9O9pn63Kx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR0402MB2910.eurprd04.prod.outlook.com (2603:10a6:800:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 18:34:50 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3805.022; Tue, 2 Feb 2021
 18:34:50 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Subject: Re: [PATCH v3] cifs: report error instead of invalid when
 revalidating a dentry fails
In-Reply-To: <CANT5p=qpnLH_3UrOv9wKGbxa6D8RUSzbY+uposEbAeVaObjbHg@mail.gmail.com>
References: <CANT5p=pK3hQNTvsR-WUmtrQFuKngx+A1iYfd0JXyb0WHqpfKMA@mail.gmail.com>
 <20210202174255.4269-1-aaptel@suse.com>
 <CANT5p=qpnLH_3UrOv9wKGbxa6D8RUSzbY+uposEbAeVaObjbHg@mail.gmail.com>
Date:   Tue, 02 Feb 2021 19:34:48 +0100
Message-ID: <87o8h28gjb.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:9f33:33e3:4e11:8cc3:3b4d]
X-ClientProxiedBy: ZR0P278CA0104.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::19) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9f33:33e3:4e11:8cc3:3b4d) by ZR0P278CA0104.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17 via Frontend Transport; Tue, 2 Feb 2021 18:34:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a26ddb3d-d394-470f-9342-08d8c7a9395b
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2910:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2910334E670FFEBE7685625CA8B59@VI1PR0402MB2910.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9a94VmZ8TU6D7NprPcEwESob9+uPGOp/cwTLAMIkhXnVDILs324gB0r+dZqNM7m6dZXTQ2ILakYevzsoMSnNQ2lGmcw3XZoMUVuQDv5NqLI/JI26RP4m08621sTji7YM9S4Kv4vJgJcl2Mi8cqliBJR2hxByi5e6YbqLtyfjB/PClBpcWLSE7YDO1t0lWTmoqVGi6hgjL311+AJmC5NkMMOmS5JL53AJWLfJNUhI53B7z48uUQ5DbQrxrb1iPzL06nvz7Fq88g3uodW+bqHqkSL0gumL7owbmp8tAwrRnsR0K9AVgBn2uWGQRV9cQ4Yl4VA5drGZBucXyTAhCDEc2K6G/uNfIUrq1bDfkWYpUQkYW4DzgtZOSF8wd+w8xo2SOtK66DthcnlMqIgIOUD6aPFSLi9pFJF+ob96ygUNhvUaGYHnmsqI1S7jvSZbUnpkgCn0x1knsHDHMiwM0EWrDuYBVZTf6teU3rL9C65FUI0GD17vHi2uq/96YXXDmi/0aeepOz0s0vS+A1iiSNrWAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(39860400002)(136003)(376002)(54906003)(36756003)(66476007)(86362001)(8936002)(52116002)(2616005)(4744005)(6496006)(2906002)(478600001)(66946007)(316002)(8676002)(16526019)(5660300002)(83380400001)(6916009)(6486002)(66556008)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlA0Qlk3VDRhcWtqVlNLQU5jM0FmSHlxUnBqYy9SOEp5cEFBTk5ORGthYzNk?=
 =?utf-8?B?SE93dTNVSG1FbGdvc1YwbGNma0ZYVlpkNWExYUtMQURBK21QdlhYOW5TS2xM?=
 =?utf-8?B?RjJWRHI2VmNXdC8xNjBLTDliR0FxUnptT2lFaTVMcy91Vi96enlaQ1N1M2lR?=
 =?utf-8?B?U2JwcTVnNFpJVk5wb3BYWTJxVzN5azU3UEVoS0w2dXFvYjBpaVRyWUZYQXlP?=
 =?utf-8?B?RlBhc3BFWlFKV0s2T2kydkhiOFNDNWg3KzVSZ094WHdmbHBIS0RpVjR0N2Iv?=
 =?utf-8?B?V05YMU5HWFN6SXd1NmEweFJDdUV0N0NVVktmMmkyMHVOamI3QXBQWlppRy9m?=
 =?utf-8?B?V1RCUjFWWHhmLzhtekVIL00yUnZhUlREbFdEdEZpZnpaTEZhdDNNMXErV1Q0?=
 =?utf-8?B?d0x6aEdrNkNQQmhxNXpLWVZoRXhJVExvZlpZVGZkYlhvSVFScWJ4SkkwRHlE?=
 =?utf-8?B?bnlBaWttdGxvMzVvd0hrTTFlTGFSdWNUMmJULzNmTjhRTU16N0FybmRiRUFZ?=
 =?utf-8?B?QUNINHF1YVhJb0VKMTlCc0JvRVdmRUp3Umo3ZDZYOUUvZmVMaHZHNEZ1K3la?=
 =?utf-8?B?ZjBoSmFrd1pCRWpnR0JDUVpxZDFEQ0xxU2dEVXdtZmdybkVMSkU5bzVjcEU2?=
 =?utf-8?B?aUVjK29Sb1dsVVhCemg3ajE4dFFOTm1mMEVKTEpKamEvWUpWODRIVm5heUlz?=
 =?utf-8?B?cTJ2TFJ0aDZUbGUxNnNjOFRiQk5NQzh2ckRGUkRuS1c1RlpxQS80UVVpWnJL?=
 =?utf-8?B?TU9ZSU55SlZEbHNDZVZoTXMvWHJwb3ZybDBWcTdEMWNnUVhXeXRHRlRCU1Z0?=
 =?utf-8?B?ZjI4U3QrazZvU3RKTWdwMllpVWlwanBWK0ZVUzNNczFIMm4vZkhlSHRLWVN2?=
 =?utf-8?B?VGFtMzRMZU1MRW0rZ2Ftc0V4Z3B2dDlXaWRiUW5jYk4yVkhtbE5qWnB0c3Bz?=
 =?utf-8?B?b1NrTW5pa0MzeHM5REJHdDBpZHp3VlRnZFc3N2R2RjlaQVNTL3doeitrNDht?=
 =?utf-8?B?MkVwblpPd3VLbDFOZVNuS1UzbldHVkY5enB2MVQ0d3B1ZWFLWjYyZE9JNE5P?=
 =?utf-8?B?YVZsMy9ldGlLditGOEl3WEZ6cWVrdm9odEY5MUhVdFhWY2RoUHY4V2hwNXJ5?=
 =?utf-8?B?NGQ3eFpzbG5TYUE5QXhrTmlYRWpPa01SOXR5M2w5SHUwc1c0citONmJ0UGFy?=
 =?utf-8?B?NnhiWGQ4QnJ6K0VxeXJaL2lUMVJmQXl5Zk4vWGlIWnBGRHdGZmVRWjZIelRY?=
 =?utf-8?B?bzdPaE1DMy91U1lDejBXaC9FTFp2emdWZ1lZVmgybW9IMDBvRTBaS0hDcmxZ?=
 =?utf-8?B?UjlPOGNRTnRjODFqeXUxczd5OXVMd2Ira21ycXAxRFM1TlpTWkVyOFlKOGxC?=
 =?utf-8?B?ZTZ5MmlzTWF5VXR3RG83S3NUcUtXQTRzSDIrWUdRS3NTb2NzSHdZMWVzekx0?=
 =?utf-8?B?UjBnTnM4QStKbE9pZHFCY1Y1eS9BUnN1b3R6QTBDRlFaWWs5UHhId3dxYnVm?=
 =?utf-8?Q?E6GYHsEuWwMQEXeBLz7IvNqdrJa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26ddb3d-d394-470f-9342-08d8c7a9395b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 18:34:50.0437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tt+0sgGUuk9V2YvdWMHHp4L0JuVxJOY4631hpzd86R3/6WLXwtPMdQRRES/6XYB/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2910
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> writes:
> This looks good to me.
> Let me know if you get a chance to test it out. If not, I'll test it
> on my setup tomorrow.

I've done some tests: the reproducer cannot trigger the bug, accessing a
deleted file invalidates, accessing an existing file revalidates. It looks
ok.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

