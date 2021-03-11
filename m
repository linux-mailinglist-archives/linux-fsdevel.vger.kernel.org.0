Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE326336F9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 11:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhCKKML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 05:12:11 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:24394 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231639AbhCKKL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:11:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1615457517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hyfXm/lHsEsWfHwR7OYRpZcC3TLUEhq9i1no0kSpZFs=;
        b=hsd4bmXatv+qPw8X8N8rmE6wOskpwTT22ov+hht2m5tBd6NCx+9w/d1navKUocCH00Zjsi
        K4Qy6qtziP0TDDF9SWZcH06aUM6pmX4t1eCWRu/HblpKBnDs5iYklii60FMyIM0DRcQjeQ
        Z+1cvsusUlcn5g3wGBRaKA9Atx/m6BE=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2169.outbound.protection.outlook.com [104.47.17.169])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-34-R9P_uuVMN9SXHnkudY7eOQ-1; Thu, 11 Mar 2021 11:11:56 +0100
X-MC-Unique: R9P_uuVMN9SXHnkudY7eOQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3oC1S2/CruVcueT541e+eHkSMJHeYsrFTqMRyIXofHmB7lh+XHty2v35gHrBJXYHPpl/QU0TiKeBUvm5ORrOYwVY26PVivSCBWYoOr9JTUgQ6EUSLwsyjsz9pEUi6NpQn+HsTYz/bviqVgn8YEYubx+fiT7gwfUyd8t8u4PYf+/8m00H5XXPckEaVjKuMUkNoxzqiY2ZLtXa1leyH6omh1YJI7+B0CbDyZWBuy5CmmhFUE7wO7UsSKUcf/clOB2Ke4Bihe6ByWY8j7pLAeQlSGtftD8B0rCwLkT68YMXFEK/zv9KB0AZUNRzxw0lzRj0vRayMGZL7UHXHMWwqMSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyfXm/lHsEsWfHwR7OYRpZcC3TLUEhq9i1no0kSpZFs=;
 b=IN+o3Y/83zNqu2nw4b7LjoOAe1qMlzJlOlsu4eW53eVfyrDVZSWUfkgjPz4zP5Ut+zK/g9bmzNK6CQiTnAQTGJu1VU7Z/znn9SaGbTtgKOE8Lw50J5lnfvz27gpstx3GbL9EkF3cboy9vyH5vSCp1JhekoOiolqYX/Yy1jVZawJBXQQrz1wjqassiRDj7iuIaVJZctpe9znOnT3eKVD5pc3H+ERB6FNRlNWmZ5e7SBoxe5J+WJDjucM04BpLB7RuzxYuFcmUEvt7fQLVjbZaKd8sUTtqqKMh/uFcvi8Y8FSCncXpN4/JiplX0ldWtSJ5iRvFuHcTBmcLDcsRO4SyLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB4320.eurprd04.prod.outlook.com (2603:10a6:803:49::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 11 Mar
 2021 10:11:55 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 10:11:55 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     smfrench@gmail.com, Tom Talpey <tom@talpey.com>,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org
Subject: Re: [PATCH v4] flock.2: add CIFS details
In-Reply-To: <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com>
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com>
Date:   Thu, 11 Mar 2021 11:11:52 +0100
Message-ID: <87sg52t2xj.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:70b:4a83:b8f5:d569:2662:f8fd]
X-ClientProxiedBy: ZR0P278CA0095.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::10) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a83:b8f5:d569:2662:f8fd) by ZR0P278CA0095.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27 via Frontend Transport; Thu, 11 Mar 2021 10:11:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 110c0f28-3577-48db-95e6-08d8e47618b0
X-MS-TrafficTypeDiagnostic: VI1PR04MB4320:
X-Microsoft-Antispam-PRVS: <VI1PR04MB4320F4F8AA298E7C6BE92340A8909@VI1PR04MB4320.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZWz4fDYQDOhrVi12+xbulJ0BKHUhBDsVZoaMUBTyZR6VHUNklL9zhqVuHJgU+XHk2exNqlyXWSMDIRPbJ6xbJf0gIkejlrADbz0u+Zk9kTv5SKBqysGJIAbBVMOdLvFSgjwUW8TLACcSCLwCIZcaB1r8diHELy6efBe/YlUCQD+QSBW09bIo20dN3Fje+px4ch/iiBLO3EIw5AKF70wajs3wU3nNkFA9jX189055+Mtk8Ga1RdLGORypFCkUNkU6M6XPsN45jG5e/t1D4Pu94tj+VWpKfHPiH1RcME8//o7TFtt4JKtKGRXHZuVt47U9iatpEiMha9WUAxwnsGpqvGFOyigKeaN/DofJqS6mYx+3dQh5sL8huJO9PJNX3uSJsyMQGu/bH+DIrXZ3mfVI111weMHYfI9lLyQsY29j5Y9VjBCHy2ONI7vdPf73583ABSB2Ln9oNjF+9bVBbyEoCIDutEUN12ZviEo4sV5N0/lkpmSHCjQ0hXibYYW4mwyxDgQ/i4ivlFp0MFWuiz3ogg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(39860400002)(136003)(396003)(8936002)(52116002)(66946007)(6496006)(66476007)(66556008)(6486002)(4326008)(36756003)(5660300002)(8676002)(316002)(2616005)(16526019)(4744005)(478600001)(186003)(83380400001)(2906002)(86362001)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?emRYekFyY3JxU2ZzcndVZEU3UlZUT1lFck0zRXJEb01QYXU3ZXNiNVVqN1BW?=
 =?utf-8?B?ckZHNG5KVUpaYnVoK1AxUWtrWi9tb2lud2tDNGQ0RHE5cU5WdGgzakd6UnVt?=
 =?utf-8?B?NXBpMVRxK1FHSXVsMElTTWQ5UXlpTzRZUGp5dmw4U08wS2llZzdnU0VTbWpo?=
 =?utf-8?B?QzF3MHBxb2poTGw2WDFKYzhrVWxHK3JPV1hrZUpkODU1cFpmQmltZ2Y3c01B?=
 =?utf-8?B?bkROTkxNeHVKMk5XVnF5Ty9QQTA1VEplaGMxZmtQQ1FqRzBSYlVQblIxWlBi?=
 =?utf-8?B?dUVna2NZTm96RFV3TW1EZjJ2VzBiQXdUVFpFRGtEeWlLLzVYYXJOZWVPWnQ2?=
 =?utf-8?B?dXpSMmlHZllEZkxpc1pFcUxPMjBKQ1paMCswVHNPL0dBQnE4NVVvaDIrRlJa?=
 =?utf-8?B?MlM2aU9VL2I3ZjMydHUyMzlwSlVkR1dSaEdVeFZQeDZtalBqcHIvWDg2Vi9P?=
 =?utf-8?B?YXR3ZEt1aHFvbkVJQlorSTl0L0ZSaVF5NSt5TEx3YVcrMzFaSSttWGxaN3Bu?=
 =?utf-8?B?UWkzb0pUQ0ZTMVdtZlJhdm5FQ2ZPZysrRkpkR2ZpMkI4ZW9DWHNsMjFhMENR?=
 =?utf-8?B?dTFwdGF5cktoS0o1ekpsZ0w2ZWlFcURDMEQrbWlYdktBOWdsNWI5OElGSWpC?=
 =?utf-8?B?RmVFVTU1eTNFdnRTUDR4dnV0RzNaYVlXNUZ2U0hqZnFidStkcUp6NEtNWVYv?=
 =?utf-8?B?d0RHazY5RmdCVTd2bzVLVzRpZ2pjOVhDYk96ZmNrUU80TXJpbXFRYjFGSTNC?=
 =?utf-8?B?QmZ4TXprZWY4a3g1eGxNeTVkUS9xdmJTM2F0Sm1iMlNuTlZvL2RrUFA5d3V5?=
 =?utf-8?B?cnVsdTRFcUEvMENyVGN5VVBodUxUck1hMEZYaGpLV1lvNW5YS3h4ME4rTk42?=
 =?utf-8?B?aHR3QUVBZDdnVG55Y0V5TEdmUTlNVVBkS2NVclpoRkFjejBkUmF3Zlk5VVRB?=
 =?utf-8?B?T3VDNndhL3Z6Um5hT2Y2bkdXVXNwWi9yNHBOU2ZJZ0RIck9STnBwdEk0Wmc3?=
 =?utf-8?B?RHhGL3B4OVg4MzduNkdiUG9jWEpiYjltSnJVUXlBVForWEZ0TTRBcElTbXdP?=
 =?utf-8?B?RnJaUS9tV1RNbmdycUhDSCs5Q0M0MzhKZWpTY09jODhhcml6aHlXc1EyV2Mv?=
 =?utf-8?B?UG5Ra1JKN2pPRzhKQjBZdTBhVFVocUVEdGhyMHhPM0tjRm5tYUVhTkFWaUYr?=
 =?utf-8?B?NzBUOXQ5L0Ird01zKzhyK3NYaEs2T1JqWk5pMG15NmVsRGlyVDR6ZHJpR3dG?=
 =?utf-8?B?MXRVUzZOdkFMNVpsTGk2bm1jVWZDZmpYZGR4OVRKdEFnUklUVEdZaTF6MzNp?=
 =?utf-8?B?a0JhVmZhekQwZVhURzc2SndBSUt0S0p6Sm5SVFVvQnpZTVlwMXgxcnFYSVJT?=
 =?utf-8?B?WkRYdlZLcGpVSGEwVDFDQWZETjA4SG1uQkEvNW5NS2EwcktvMlpyNERndDdD?=
 =?utf-8?B?SFNFUDlnYVNraU9mUDkvd1ZvbTB3eGk0VE1EOGpRVTlrUnNrczdQOHMxeDdC?=
 =?utf-8?B?UTJoUnZLKzFhUm9jeVlyTklUZU5FOEpGOHlVWTIyNk13K0o3NEczSVFpMzBp?=
 =?utf-8?B?RFc1TWQwRE1Zeitnak9aU1J3bzlUMGx1NHFCdkcvRGpGaXMvcWh5blIzMkFm?=
 =?utf-8?B?NkJZdW5XZ05oYXl6bnZjNzEwZ3dNeEg1SFdiVmFld21OQmR3SFhiZFpkb1Ew?=
 =?utf-8?B?blV6endBL3BXU1dwZHd4WnVOR3E2Njd5ZEIyWTFFZHBucUl2cWlJRnR1bTI0?=
 =?utf-8?B?aW5oTHRBL1Fid1VLVDIvWlNZV3pVeDBodFl1eUxublRmMUZRZ0tLb1o4MEFD?=
 =?utf-8?B?Qmtsc1d2UzVESnRwMU16RUgzUXh6Rk9BRml5UGJTK0VJQVJ2Vk9HbGxMZFdP?=
 =?utf-8?Q?zDAoLhvpQEgRM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110c0f28-3577-48db-95e6-08d8e47618b0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 10:11:54.7513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OUpOU217ell02iiYsQvJT8KBoXx7fAo8GAAgNmTBjIi269sE0OcIYNrthFVZ9ZO8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4320
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Alejandro Colomar (man-pages)" <alx.manpages@gmail.com> writes:
> I agree with Tom.  It's much easier to read if you just say that 'nobrl'=
=20
> torns off the non-locale behaviour, and acts as 5.4 and earlier kernels.=
=20
>   Unless there's any subtlety that makes it different.  Is there any?

nobrl also makes fnctl() locks local.
In 5.4 and earlier kernel, flock() is local but fnctl() isn't.

> BTW, you should use "semantic newlines":

Ok, I'll redo once we agree on the text.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

