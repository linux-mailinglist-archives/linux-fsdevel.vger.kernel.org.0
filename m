Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2873E32D003
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 10:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbhCDJtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 04:49:19 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:20328 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237863AbhCDJtM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 04:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1614851285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsgFyzpF/6PZOjZQJC/Ktwv6qT+QJePk4dYjfkkMm5k=;
        b=gf9XTX4Bza/t9jBFHKOTU0k4P9wruLyL8GtjWcnvRwcyYu+Wa8mMNcCOfuzQ/yQoQhtd0m
        x/j4Fge+FKlMMdIwPNcHehMjj+ChSvOilN6gIkrxcZfErvYxZg+5yy0nFIHe/0NpIVRzjr
        ypXWXR9o6zD1rYTBno1OSH1gj/bFuJo=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2050.outbound.protection.outlook.com [104.47.14.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-UAkPoPWBNiK-33VPS2ZllA-1; Thu, 04 Mar 2021 10:48:04 +0100
X-MC-Unique: UAkPoPWBNiK-33VPS2ZllA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChrFri6vUa2/MAu4MdV2J1G+qHke/JcM8rWbMNwuSM9GN74egh6oT8KuQzIHJbfj3iLD4Hetx4tlZqzVBIpplo/sXNP5dpmyVLd9XpItLSYtFQvFmkAVgVQzYqKPWlwtaOzZKYYMTS/j7uwY1bNtsetmU1522B22S0gqdL5d1YWSwLHwmPdNuf378AUn7P0odwQ2P30buYxRtGtj0PqiKWZov0GVCiRcDs6+2IWxMy7wGn1vxtF1wVZ1GMIaoD5nXfLcJu7esUUd4qzL+yKxhnBaJ2vrX1e1jft7QrCs/vT0T7AYhzv31nXxvXpviJj8yUvgv+SyFJIVqkoyGtMweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsgFyzpF/6PZOjZQJC/Ktwv6qT+QJePk4dYjfkkMm5k=;
 b=AcLfGFc1lJwSSTXhKRWG4hlcx4P3A/3DUAcGsZEDtNaj7lX9x2//vy82jDkPXJG8OdrcC+N7CdMRgXD1KDE3nxdi3AgpxmutXokoAIp9wtgsIW/hzO2kwhJ57VC8k4g3FhOKn9AMcI5Rx7CxQegc0aYsJfyfNsD51T8z4/oAKKCiXnK1XqX2xg600BSVNg/YOAgvl/wjACEWkdn7P3xCMIedmB0qCs3WQfuazSvd1xCs8++AZbtWGTSp8SLgo+LmGQwkrbW7kVt2rosmETwyluMvUJjD9lluvQzUdKdPgbUXtWNIG/JYND0oVrnRoKz+kCXTJTXKMgZWB9qUrwumuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB3232.eurprd04.prod.outlook.com (2603:10a6:802:8::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 4 Mar
 2021 09:48:02 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 09:48:02 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com
Cc:     smfrench@gmail.com
Subject: Re: [PATCH v3] flock.2: add CIFS details
In-Reply-To: <be8416d4-64f8-675e-3f46-f55dddf1e03b@talpey.com>
References: <17fc432c-f485-0945-6d12-fa338ea0025f@talpey.com>
 <20210303190353.31605-1-aaptel@suse.com>
 <be8416d4-64f8-675e-3f46-f55dddf1e03b@talpey.com>
Date:   Thu, 04 Mar 2021 10:48:00 +0100
Message-ID: <87v9a7w8q7.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:70b:4a22:792c:d376:dd41:4ec2]
X-ClientProxiedBy: ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::25) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a22:792c:d376:dd41:4ec2) by ZRAP278CA0015.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 09:48:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dec7956a-3b48-41a4-9438-08d8def299ed
X-MS-TrafficTypeDiagnostic: VI1PR04MB3232:
X-Microsoft-Antispam-PRVS: <VI1PR04MB32320BEA914967BD9E5AEEC3A8979@VI1PR04MB3232.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pS79prbHocYjW75eVVwjkhOlCbOw89BEEuzhx3AZZ2ycALphVBz9B56A9zkcFtOkfkwG/n2ZR0aatKaMic+fqbyWNVjSOIdG8XoMS1cOYu8k/DBZH1hIyGl9ojVIFl6DOKIX6dYZE4xn4BdBMq/aoNlFl1jRg3s1rPpqvVQZYOkNDMclpfd3DhA3jSzbaZnOk+Nt21lREwlM8ZjcUD8vTjci8L3UeU/x4ajItwqEw+i5ddATjue0VcFMNd31CFhKfXWxGi1j/UxdZnzv1ggYdG7ezO/uFvQEo8MBzQrJ2wwH3iw4LNPRlMeQCE1TDEn3IS23iTqIcwkTTmNxLJENwp4lojC3hjzo9ZS9KCRqXGOXYFyFS+DFDraoT4+p0u/rTUu2ZFO16FMdbWI9WsuSZqw4mDgBzHK8XNKUksKLZCoUha1q2L/Vbqrn3pPlM7+DwuyeTTpQpeuWqXS9PlDSa3uEzGPxDUnMfiR1bZpD6Rk5Rxo5G7lml5Zva85wpY3BGdNMLVjxKfiMQqxUuPA/QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(39860400002)(136003)(5660300002)(83380400001)(6496006)(4744005)(66476007)(2906002)(66556008)(2616005)(36756003)(16526019)(186003)(6486002)(66946007)(4326008)(52116002)(478600001)(8936002)(316002)(86362001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0QyKzdoN2pTNGgyNjhzaGdNeDRtOE9BcmdIZER3UnpXcUc4YjYrNDErcy9F?=
 =?utf-8?B?bWpEb0NkSWZUWWszRTM0WnZNWXcrNHBPNXpITkFDSVZIOUF3Q2tySmFUV2s0?=
 =?utf-8?B?UUVneHppOFpVRXpibFBZSDdIbnhJZ2tvRk5FZVE4cnpYUjJUdHBhamlnTURa?=
 =?utf-8?B?Vy9vbmt1QmJpZk1PZzRiSW0yZ0dlOUE5bENnN1RIVWRoN0R0TC92NVVLWlh5?=
 =?utf-8?B?MDBMU09Ba2I3NTd1UkdoZzJyRmZtelBhNXRYL1NvOGhzemtWR3BMaVFtYVhi?=
 =?utf-8?B?N25EVlprV0xEcjBmbWJFS2JPV1lhRnFoQ0ZrNWc3aCtiV3ZLQVRRaVR2WjZX?=
 =?utf-8?B?VUNkbkxOK2VSd05UQnFMQUpXMEJPcHdSWGxBNjZXcWdoY3FvVFJxaHBrUnJC?=
 =?utf-8?B?NTl1dWVMUlI2cFppUC9MZCtkUFdjb2Vub2VQeWRZVDlIUzBwS2tLLzkwUzAz?=
 =?utf-8?B?RzNTRkJwK1ZYb013V3BtSFUyVmYvRzNQc3AwaUtQZEFVOXVQQjZOcndKM3dT?=
 =?utf-8?B?SFo5V1BkN0M5VlAxSEUrWlMwcWk4UVdQbXJhTDcvUmc0dXpjbFRiczgwblhZ?=
 =?utf-8?B?cW80bXRpeVVsbFlRTDM3ZTkwVGl5UGdJZGYxV1drV1V6NkpyYzk0QjBnaVhp?=
 =?utf-8?B?d3gzRXFSMWREN1dwNmFwVWhhUFRMWXQ5ellHa0tHS2lFdU1oZWxoNFZ0OVBX?=
 =?utf-8?B?Q3dqbXZHRk9yaCtWVlJtNnBHK3pkM0NlYXdoVm5zV0Q5RXFNdU1XSTBtK2Y1?=
 =?utf-8?B?b2pxWVFPMTZkeUNDRDlsMDZpTkhkem1ZSE9CU3p6VEpzdDBjY2thMHo1UUxw?=
 =?utf-8?B?amZpc1pnSktpbENZenE0Q0RNQTlrR2VZQVNVVGRRVlU0RUxYaFlORHB1Qy9h?=
 =?utf-8?B?SWFVUzA4dFJTeDlCOVM2ekltT3pNTGZSOUxQdUtRY3ViVzdWQWRWMUgzQmNk?=
 =?utf-8?B?L0orT0RKb0NSK2RsTHAwQi9QK0dvNU5IWkErUWpmckY4WkhJcHZyYkpJa1Rj?=
 =?utf-8?B?Y0l1WU1sNkROeGFIRG41OEkrZFA0Z1psako4TE81MHd1V3EzSm5xTUZ1allB?=
 =?utf-8?B?SFdwOUIzK1ZJWFAxNHNkTWFpdDJOdDR5blZoL0swSnltdmlnb3FTWlNza2Uz?=
 =?utf-8?B?R05ORE1uVEszdmJRQlp3VlQrUjlFWDY0VnQ4dTNPVGlMQXRiT1lQalU1cE9H?=
 =?utf-8?B?WGlNc09tMFZ0UEZadkZjVlVFU0crUFpWVitzN25JZGZkTTlUQXZYMHlXWlpY?=
 =?utf-8?B?Y2xDS2lnbGo5cmR1c1FHZ2VTLytQc1E3b2wyWnlWMkZuSDNNWXRmcVVsSFk1?=
 =?utf-8?B?WXVaWWNkSmcwV2E3cHBHMFRqVFdOd0tydVQ0YmhDaTJNRTEzUmhjZmlBcWxJ?=
 =?utf-8?B?Syt1eDN3WjJha0xJNEJhMEE5emtaSVZZeDdQaGdLRlVCM1VaUHBhTU9XcmVv?=
 =?utf-8?B?UlhHdEMxMkNiQnNDOHhtSkE3Ui9LYWNNOW0yMnVsS0dJMkx0MHpWOE92RWdE?=
 =?utf-8?B?ZjR1YTRDbDU3ZzRzNDR5LzQvUFozRkVDVTZESnVHaGFZVGU3azRuZ0VmOFJ3?=
 =?utf-8?B?dnVLMDV5ejBSUVUzczZmdzJLOS85SnNaOVp5YUZNVU5VQ2tSbSttWDl0T0du?=
 =?utf-8?B?RWJUR2JjUWNRbXVzSTJsczBIU3BQTkxTRElFZWR6OWdZWEMwVkU1TFFySG42?=
 =?utf-8?B?NzA3OVllUCswd3pnSS9TeTVaNUxtTzV6L3FOd0gxMm83ZHBHekFidzlSV2JR?=
 =?utf-8?B?NUl2eTR4RVExVHd5SVFiK1VtczFxNjlKaFV1VG5uL203S2JLTDBLQ3lJR3VU?=
 =?utf-8?B?K1RITW1SN2JKVFd0eVZsU1FJZ1dkMHJRa3NJbCtwd0JXZ2lvM3kybUZrVWNn?=
 =?utf-8?Q?mtMYLByO+ecoE?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dec7956a-3b48-41a4-9438-08d8def299ed
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 09:48:02.1649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fzhb+RmdNC/VKsdv1lv9QQqz8e1qA44hV/M6x4xlzi/2BjxWDE+sYrlc7K7uVLOW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3232
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tom Talpey <tom@talpey.com> writes:
> It looks great, and sorry to be a pest, but I just noticed - it's
> EACCES (not EACCESS).

No worries, thanks for the review.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

