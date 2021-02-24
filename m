Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60C4C323B23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Feb 2021 12:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhBXLOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Feb 2021 06:14:33 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:52382 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235108AbhBXLM2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Feb 2021 06:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614165069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zlgC0xc+KdU2wwL4SRhPjCrmqXtOSbc1UqEaZTyUZ6Q=;
        b=WAXBktR/JIn2BMM9lF+4sZ1wLiokyu4rFiHFxyHN/gIuX2Mk2YS5VndungYOXf4P6NPwe3
        gLUtiCz587jVJ8oGvv6UsBRRY0ovNkP7hUu8p+CDcI/4GZGe+P+umw1sIIchAXsZ1P7b/r
        hI1nF1rtm+kIZlZ2WJOe8+f4CvgPQIU=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-30-yTTTumQ6NMu9D9kxe4gm0A-1; Wed, 24 Feb 2021 12:11:07 +0100
X-MC-Unique: yTTTumQ6NMu9D9kxe4gm0A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mp6s6N9awGXSPkYR2WEyqBSycWTm1MaVtUl0tY/GUAwL+7P24tWXkN4eaWpdbaJwGBibfLjvHkg9GnnKG5cUN0J36Xwx5eF6SKiuN8lWTtZo7RkL20DSCnwUC5VpEoSS0jEwB5o3qTgm0U8jtHmlUelJEKt4qLhu97GY2+Bhci0TGqxyF+4ByRcrngmcPc/DCzyEBmL+5vG+YsTZf1JDP6dLzt89Vkgubuhya6wBFr6VguQksfjU6sxxmuDqXUJJayIzkvLcGNR0Cbh2kSnRg057j0oP/3PsccErh56+jLxghWQp2EVBBdonjeFBoySA21l0jOYF7mKLQ8uQmATIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlgC0xc+KdU2wwL4SRhPjCrmqXtOSbc1UqEaZTyUZ6Q=;
 b=Ql2qC17274DSw6A4N7Gej0YjzXnFB5XA6wp1KkCHSwxDyIgpfVTtIOQmVz83oqwAxlIQoQcnOz0nuiitFvbuNIvyLXvcsY97O9muJwUekHnjgUwNnnCUPr443djMtMp4bXDoFgiNZXnRWesR7RMgM/yMhvE4t+EjCjg/4edkJVsDQdS8KNZa791vjm8Os5v6Ns0lD+K+rsXGkDOIEEIptCDA3g9CSAHLzohS3vR7MTrlrpEB1CkdNPMUBSXvaL3t14DMcM6Xr2lvTSk0wOjFeTDSlZ39mULkSo166P3gGywM3BA0JRPn9NkoL7cjZsJr+p5pvnJ91Ej3dSzJObbouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Wed, 24 Feb
 2021 11:11:06 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3868.032; Wed, 24 Feb 2021
 11:11:05 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Steve French <smfrench@gmail.com>
Subject: Re: [PATCH] cifs: ignore FL_FLOCK locks in read/write
In-Reply-To: <CAKywueSCbANjCzPMnWJx7CXQM4kWO4pHtAhgpwwchMqCOcV0Lg@mail.gmail.com>
References: <20210223182726.31763-1-aaptel@suse.com>
 <CAKywueSCbANjCzPMnWJx7CXQM4kWO4pHtAhgpwwchMqCOcV0Lg@mail.gmail.com>
Date:   Wed, 24 Feb 2021 12:11:03 +0100
Message-ID: <87tuq1zpo8.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:705:9b67:cb08:1e9e:69ee:ac94]
X-ClientProxiedBy: ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::14) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:705:9b67:cb08:1e9e:69ee:ac94) by ZR0P278CA0027.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 11:11:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0fdc762-4ddd-45b2-9749-08d8d8b4e125
X-MS-TrafficTypeDiagnostic: VI1PR04MB6928:
X-Microsoft-Antispam-PRVS: <VI1PR04MB69287F4CAD63C773F42DE6FEA89F9@VI1PR04MB6928.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbjW85canC3X22ieBFi3LaNgwDCmNzND7fTvqeS4gnauTk+GqkvPWm+svoccovfNAEKf5zuBFXRG0Zig7z4L4Ox+WkGeU8UaqmkwUu41OnMZ3XYFkY/l3hj5a0DRDPMvnZb9BQbR0gVhZ0jKgjIepOi60RjVE5QOlnFLQj4InmtEoZzhAMlrIW5vThYQAznzr61uUs4ZqMJVfuJxaHIK/w7yn29Z7Mh9i3Po7OLbAjuWU9W5qpVRTpC3nDeJgAfq3rrMv2jb3prl2UZXRMBeZptMrCgMPwrpp2eeZ+vxXTviFxggCTLB18xsBl40paQXZ4n5Dlj6K6FApV5UtpMke2hniiwSBz0l+ue6BoywEtIvQab8TTG88IlE5MKAkhclNWdTsFgguWHxw6w2X1wAvpmooCCdtNmqO6vcQQn+4pXdBlgBiLztqi+ppsUE4RGcEUkjki7DCI0Nen1u8MKJSdyQR79Py2bd9V+CFAVTst+Vv1cIioNgRKSMYSSrfRD0f9JY+NTSEoy/sShhNu4dmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(396003)(376002)(39860400002)(83380400001)(4326008)(186003)(478600001)(16526019)(5660300002)(8936002)(66946007)(86362001)(8676002)(316002)(6916009)(54906003)(6496006)(66556008)(2616005)(2906002)(6486002)(66476007)(52116002)(36756003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?b1l5b3NJTnBaazNvaytSK3NGVVVaelJaWGk0cy9PRjJiSG1PRnV4ZGZCUzlF?=
 =?utf-8?B?RW5MTlZ3cTFldGxsdm1uNm9JWmpyMGgzM25iVFpSYTNwL0JadmI5WU53T0l1?=
 =?utf-8?B?NWVKYVFjaGZLUUo0MjVrVnFYVXFqa2JYTS9XOUExbWxHMzRyUDB2NThYZU43?=
 =?utf-8?B?UkZNUllnQUUwQUlLQm0xZ0xRTVFzL2FDTkljQjBBUnJlVFErTUpYNzhqZndq?=
 =?utf-8?B?KzJ0SGNsVGwyenpPQlBET28xemFTZXR3SlhPUlFBR0ZJQzZTYUx2dU1wTG5z?=
 =?utf-8?B?ZHAxVXpjQk9TcHNSb3JqWlI4N0Vid1BFRGRQSXk3QzJodksrNnVHcC9JZjU5?=
 =?utf-8?B?bnVlb09NV09DRlp1bytTUjBIRm9xenVZMkJkTDNFbmJaSWpnQVVyNlkyaWR3?=
 =?utf-8?B?dkxLOWp1aXFsRDByZ3NzeS9hTEM4ZFVTVnNHdFlOV295THc5YjhTczZzYm1V?=
 =?utf-8?B?SDZETklQZkhsNnJReHpUZUlYcitVM0VRVHNpMmFvR0xveHdXaWdUcUMvM09S?=
 =?utf-8?B?NnIrUStYU09PMEd6VXkyMGgzbXBsRkpIVFJsd0dKQzl5elJoQTB5L3c2QnJn?=
 =?utf-8?B?c3JnZ2RvTHVaWjdUaFRNYTRuaytsTFVmM1JxSmJBaFlVTjBieUxEUjRjd09U?=
 =?utf-8?B?MVpUQXlZbytSbjVNMy9Ga1VGU1NUeUZ0Um9BaVZlSnRVTWFpdjdqaTFIOGps?=
 =?utf-8?B?UGtWM3VVdEFJdFlHcHBkdy9oNzZEUkFzVWhETHlTdE4wdVFOcUo1dG5hV0Zi?=
 =?utf-8?B?TTBtQW9Hb0tJM1RhMU5rUjFMNmNQSzVNVWtLblp5TG1oS2FMMXhpa3VENUdq?=
 =?utf-8?B?em5JUVZHam9HdVhvcjcyN1RQU3MwNWREcHRDS3d3S3I3enk2ckFRdkFyUTZX?=
 =?utf-8?B?S0pUU0RueitKZzFYUXVzbTY4M1NqcTJMdlJvVXNvQm1Ta1Q4UEpVZjJ3eFRE?=
 =?utf-8?B?MTB2WExWbkl6M1BsakhQeTc4TlpzS1BNZGxua0kxNk9hQURQV2loV0d3V0Qy?=
 =?utf-8?B?TWM1aWgxNjBpK24vb3p6T0dxeDB6TzJCLzg4NGxxUWJmVkJ1Y1M1K3diTFVR?=
 =?utf-8?B?ZVRDSFhwSisrWUFCL2ZpS042T1gwUUZTRG1UUFdic1hiMzhiWGhMajYxU3Rx?=
 =?utf-8?B?ZDg4VWlacFVKYlVaWjluUVY2bUEyTXV3cE5vb2ZEZWw2R1M2THpBOHowY1Rq?=
 =?utf-8?B?R1dwNmFhZW81L25lZDEvVTVrWmFTZUtpbWNmeHZkdnNkZmVidE5nZTdFZWpB?=
 =?utf-8?B?Y1N4aEJHVXNzakV5aC9KWkFCWXFLcjVMYmRBdVJzdThJVGFDSHpLd3lSdzQ0?=
 =?utf-8?B?SXdCTys4Slo5dzdNallrL2hEamtRMXFBVXFiZkdLZ1VRd0dMd2VDMTBiZFlI?=
 =?utf-8?B?V29weUZETUozNzR2S1ZnanBOZmFNTGhsbEtxVlkwT3JQandwL3JPU0ZuQ0dz?=
 =?utf-8?B?ZmxjU2Qxb2tRMlZpbDE2SnZLMnU1ZUc2VnJ2ekpkYitnT20xOENCcFVEaG1w?=
 =?utf-8?B?YlZpSVZ6R1U0MXAzMlNEOHd5L1RJbGtKSzhkbGQ4eHI0bXNReEorSG1IaUpH?=
 =?utf-8?B?TTFrWmsvcVNpU0RORnYwTVdWWVJvdXlEQjdIV2pEVXVCM2J2aXRSanhTTHJy?=
 =?utf-8?B?bGxsNTUzUE5kNVpYZktzSGpXQm5CK3hDVENBS1BuNWp1VXMvc3BpM0o4QXdZ?=
 =?utf-8?B?bFhsRnJTNkliYXgyWm4xcEpzRXNCR0JzOFArSjdreTA1cktWOWZvbGJndlc2?=
 =?utf-8?B?RExLYSs3QWJQd0d1bUR4NDErVzlWTzBhZlcvOWdRZGlhcEZ4czJwOFpzSGZn?=
 =?utf-8?B?OWpncm9HNldJeFI2S0RoVUVEQnVxM2xBeklMOTJrZjhoODVDY2NtL0NXMDRv?=
 =?utf-8?Q?+7dAbyBOzmBkX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fdc762-4ddd-45b2-9749-08d8d8b4e125
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 11:11:05.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7UnK1b4JtVceNpja4ZKITyQ9zs5alX1JBRi4cdEmw0ryHVcKPgRhR4MEhvu+f22
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pavel Shilovsky <piastryyy@gmail.com> writes:
> If a flock is emulated on the server side with mandatory locks (which
> is what we only have for SMB2 without POSIX extensions) then we should
> maintain the same logic on the client. Otherwise you get different
> behavior depending on the caching policies currently in effect on the
> client side. You may consider testing with both modes when
> leases/oplocks are on and off.

Hm.. you're right, the write will fail on the server side without
cache.

I guess we should document current cifs behaviour in the flock man page.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

