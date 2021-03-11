Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56EF337A90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 18:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhCKRNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 12:13:55 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:24068 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229938AbhCKRNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1615482811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIAHQTJzhnVOg1bEKJMUjT8wxBd0N4+6N+ey323s3m8=;
        b=abFVFZF6qGuF7HbTMBaOkOk+je+4+zFaZecJwWkidNJjMLGoFbFFlmX05YB+RdmZzV6Qye
        o6d2VEIOy8E18kIyyEehD4rFrQivhbeBF7/26AswKxK49vvlC7wOMqJiHGBZ8rQkeS+06F
        7CLdtPkHiGOhryc57yU3DMxuck82pTk=
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur02lp2059.outbound.protection.outlook.com [104.47.6.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-26-Hrj1XnogNECyaOdpH8uXXg-1; Thu, 11 Mar 2021 18:13:30 +0100
X-MC-Unique: Hrj1XnogNECyaOdpH8uXXg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=becyHnyuKm0xwqpJtksbIftRKl4cn89YUZOG+28DF2mWiZLRCMznaI/nP7mF+3zRxmSOfDIVj03e9zh48mLwBgMt7jmBFMsbzmtrLbdbo+du9itXP7vsryG6//XbrsJKmZwF455JXMx5cvNvWgLjy2cI7Ia2j3lpCRCTmYsiwVQnB13133tHRgUlKyQi/IRS034VTDpRImGuaTFLSb1hPoskj1OHZRmLuHvcUjJ+szV7L3L5c8K2BF7/9Ap7f+jsmjQ0agNP79OqxHlUjcFMxPFaDkxEcq67p1yb7VGEFKHr6bbE73pVcWSMBfni18esrokaG7jKDJe3NQFS+cB+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIAHQTJzhnVOg1bEKJMUjT8wxBd0N4+6N+ey323s3m8=;
 b=lyIC0cT+ue3zf1QNlKXSmz3pfpRJZI0udm5wrqXFqjFpibdjVk89MTQfeNIZ21uQAhUXgBP03Mi/BmNLbCCim/Ex+5qY/+kLkALh9LJnrXAZ2EhElNXfrOSM6hM4Sd3iPi2ORsc4ffLIH0F5jZHBm+N3GuF1O9GDOx/tC0XOG5AVRLnIzYV6Nc4eSWlkwcjpPPC7+mwhQb9g4g5uAPMMeQtIM/pNAvDQIqZDo6Kx/kWgtRdkEsfjgv0k8ltwrDdNRGM8itFXm+6p//vN1e6R6Fc52FkVaPbKcV+Q7NLb/m0Rv0N0aZLqyEeD0qCUpxtaMWF4U65gQmuhWtNOe4IehQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR04MB6911.eurprd04.prod.outlook.com (2603:10a6:803:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 17:13:28 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 17:13:28 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Tom Talpey <tom@talpey.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     smfrench@gmail.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mtk.manpages@gmail.com,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v4] flock.2: add CIFS details
In-Reply-To: <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com>
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
 <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com>
Date:   Thu, 11 Mar 2021 18:13:26 +0100
Message-ID: <87eegltxzd.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:70b:4a76:c575:78b3:c551:390b]
X-ClientProxiedBy: ZR0P278CA0026.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::13) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a76:c575:78b3:c551:390b) by ZR0P278CA0026.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 17:13:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5e07346-28f0-4c6b-e4b2-08d8e4b0fd17
X-MS-TrafficTypeDiagnostic: VI1PR04MB6911:
X-Microsoft-Antispam-PRVS: <VI1PR04MB69117343C7D968D8FD12D11FA8909@VI1PR04MB6911.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIRjadCowk+RiADpLM8JDOFZmHf9BAmX8DPUZ7w0yDhUz0JqpnGBx5M7YysuUEW2rn5VMip36C9j3ajSDYIrKjaAXwwQMsgu2OrWXbwsTP49SPKubeuBLVu4T7Hqo2LAKilKLuRAB8nFiUPSyrN3dgXh2fnQJps3jTCAKITz+i3eo1P53YQFiF+O/GmpOm3OfCnshilMfUxWPOeLFdBosBk681wxMJP+ykEtmusQ3X3gwYkOK5dLeEU4gwk8WmAzLk7HW1N1qWiysChBx09PNHCGm2cy6ei/l/F6DDIt6q2/1oeq/GW/+BEefeurjEfp/RLLeYEfuJN8IKq7BojY3MYg8T8hRUfKvWSAZ/wHAlkr5y+TU6X9/ZNNBIBPtBf3eUlEw8a/UuoxYGgidGOsZRc/hAurUFsLv64Oopc1/PrB0QKM28kFVI389Bs1ygf4bD9o4lHKkoSunyHt0jV7jQ5NhkeI8EphEsqz1tZCwbJ2yDBl8V4Meyu1nSfpQFbLFdv+hX9XwDmm/YNWqbz+Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(39860400002)(366004)(186003)(53546011)(478600001)(8676002)(2906002)(316002)(110136005)(2616005)(83380400001)(52116002)(5660300002)(86362001)(36756003)(6496006)(66946007)(6486002)(66556008)(16526019)(8936002)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?T2FidlEzTnk2Ujk1TDBFb3JndkpCc3RyeThjT0JVa2JMVVJoNkt4QkRyS0lQ?=
 =?utf-8?B?ZEovUC90L1VROW9LQ2RIaEdRVUZYem11Y1JRQ3RmQXdlMElvRFRlYTBpV1Vs?=
 =?utf-8?B?MjRYcW1PVTB6dDhPQ0pKZXcrWGpDWDU4U1h0NFJFVTlYRVFKbjRwTkhKMlpO?=
 =?utf-8?B?clplUk1DUk9idUlhZTVlbzdsV01rOTlnZTBXb0RsUzg2NFlYNExSbXFpNEtN?=
 =?utf-8?B?Y1BpV1VLbmszT2I2WXFiRnBSemphRStiUHB1alZBQ0I1OE9mWTBQZVRSNnZ1?=
 =?utf-8?B?cTNLOUI1dXRYOWp2YXVFK0RTKzY2cGF2eEk1NFFFRGthYmViK0ovdG1XSUtP?=
 =?utf-8?B?YndtZ3UxTjU4L25XLzFzbndKN2oxZUJqV3FER1hRRk1DSC92ZDkxZHB1c3FB?=
 =?utf-8?B?YTlsRWFMK1pkZ2tZQWVZalpiOFdwYUFyTEJtZFU2UDFrSFk4K1Y0eFFvV2x5?=
 =?utf-8?B?bkMrQnJvQ1lDcHkrV0ZVazE0SXRqbnFYZGNMUXVZY2l5MFhUMUtOcE05V3Rj?=
 =?utf-8?B?K0lpamRnTklNNHc5OW8yS2xwVDBlRlkxaVM3UGRNaU8wc1dEQ3U1STl6UDlK?=
 =?utf-8?B?aTBVaHUwUXcrT0tzYjlUYTdyM210Z0dIUXdWdkI2bVlkZExqNlNCbGFDSDVl?=
 =?utf-8?B?eFVMemx5TjcxOUQrZ2hrdVhIUkVhL2wxS0l0Tzk0dGdKQVh5cnR0MmY1cjNm?=
 =?utf-8?B?MXNlYUZNaHVlckh4MURNR3VtUXg3VGE4TUR4cmhBMFVmeTRSQUVqTnhlZDdS?=
 =?utf-8?B?bGJqL0tEaDFQUG9qZWtMeFNCL09aSlI3UU5nZnAxZ3hIeEw1dUlZQW5ua3dF?=
 =?utf-8?B?T1ljSjVERzNHb29kNzVja2pqQy93RVNydWpFeG5wM0JNNnc3SmVUQ2R3NnBq?=
 =?utf-8?B?TlJuUFhOc0tPTitLUUpDNU5PK2FhN3lPS0Z1WW9kYzc5eTRPNHpOTWVOUmpk?=
 =?utf-8?B?Q21TRFBFa3JTdDFJbHJxTjI2MmRRN1VjNEdGckM3em01OTE0ek12VUFEL2dw?=
 =?utf-8?B?cUt2WTROaVNTVXRLVnlYU0pnVllSS0VBbnRiS1NJQXMrd0FzTU9CVGxRN2J3?=
 =?utf-8?B?R05RQmtQYjMzcFo4eC9BRmhaclQ1UC9EMnhlMGRyN0ZvRHN5TXNQWno2WTVs?=
 =?utf-8?B?K0Z3RU1NOXg5bVF5UlJGd1ZmMDlPLzh1VzJ6NUg5STF4U0hIbW1lWmtndXhD?=
 =?utf-8?B?dnhKbFJKRDlKN3lVeVNjVHlIdWZnVkJ0OWdQZGcvZmpZaDNkUFBXTVI0RG9p?=
 =?utf-8?B?bnVhVGVNNjdPTjhmWXNUMDRJNlhGMjZUSWRsWThsK2dhWkMwRXkvalhPMjVH?=
 =?utf-8?B?VzI0dWJnV2d0UlA1MWF0TzRFL1BBL25pY1dPT0phWnpFL1JVSm1RMHJIdEc1?=
 =?utf-8?B?a3JibFdhZHJaVG1FTHRXckN2MnhmWGZUR1hUTmRmZ0lNT0l6MG82WjFDVXZN?=
 =?utf-8?B?SCtzN2x1NkFoY21Pa3l5UWdFd0EyK2tRQ2NQVWk1TFBGbFJleW8rUVpyWUJL?=
 =?utf-8?B?ZGRmdmxQUnFVWkcyOGR2UTd0NkpvcHJOZ1ZLTmpLeFRMRE9SYXRlOGQ5MVNE?=
 =?utf-8?B?aEQxcW0rMWptRlRyZnZubDVJcU54QXFuR1kybjU2dnNqV2hoYVpFbk03S0dN?=
 =?utf-8?B?S0E1d0xxUm1mTXlldnhZWDIzMzZhQ25pWWQ1S3hGUG9sSnNFMG5uMmVlZFhk?=
 =?utf-8?B?Q2xGTW9hd2YyWlZrN1U4OXhLaERObGljdVJRVjZTMHZhM3RPNUppZ3NPLzEz?=
 =?utf-8?B?Z0FkZ2IyNGFKeDdVR2plcVUwSStickRuZzdoTzR0QkpoWFlqS3IwTUFZSTlG?=
 =?utf-8?B?MENOL2ZzbElGc21ONUpHQXhqeGk5RlBEN2M3K1B6T0JBeVN2bThMK2U1QWJR?=
 =?utf-8?Q?b5HcrlC9j9GgT?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e07346-28f0-4c6b-e4b2-08d8e4b0fd17
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 17:13:28.5753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPCPWdgBmMItu7DvvyJcWhYqBcw3j+PyY0qNeRkl2N0oiatDQtFJ1pmztYSQiA8z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6911
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tom Talpey <tom@talpey.com> writes:

> On 3/11/2021 5:11 AM, Aur=C3=A9lien Aptel wrote:
>> "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com> writes:
>>> I agree with Tom.  It's much easier to read if you just say that 'nobrl=
'
>>> torns off the non-locale behaviour, and acts as 5.4 and earlier kernels=
.
>>>    Unless there's any subtlety that makes it different.  Is there any?
>>=20
>> nobrl also makes fnctl() locks local.
>> In 5.4 and earlier kernel, flock() is local but fnctl() isn't.
>>=20
>>> BTW, you should use "semantic newlines":
>>=20
>> Ok, I'll redo once we agree on the text.
>
> I wonder if it's best to leave the nobrl details to the mount.cifs
> manpage, and just make a reference from here.
>
> Another advantage of putting this in a cifs.ko-specific manpage
> is that it would be significantly easier to maintain. The details
> of a 5.4-to-5.5 transition are going to fade over time, and the
> APIs in fcntl(2)/flock(2) really aren't driving that.

I was trying to write in the same style as the NFS details just above (see
existing man page). Give basic overview of the issues.

> If not, it's going to be messy... Aur=C3=A9lien is this correct?
>
> cifs.ko flock()
> - local in <=3D 5.4
> - remote by default in >=3D 5.5
> - local if nobrl in >=3D 5.5
>
> cifs.ko fcntl()
> - remote by default in X.Y
> - local if nobrl in X.Y

Correct.

> Not sure what the value(s) of X.Y actually might be.

AFAIK fcntl() was always remote by default.
And nobrl was added in 2.6.15 (15 years ago). I wouldn't bother
mentionning X.Y, it's already complex enough as it is.

> It seems odd that "nobrl" means "handle locking locally, and never
> send to server". I mean, there is always byte-range locking, right?

Yes the option name can be confusing. Byte-range locking is always
possible, but with "nobrl" it's local-only.

> Are there any other options or configurations that alter this?

I've taken another long look at the cifs.ko and samba code. There are
many knobs that would make an accurate matrix table pretty big.

* If the mount point is done on an SMB1+UNIX Extensions
  connection, locking becomes advisory. Unless
  forcemandatorylock option is passed. This will eventually be
  implemented for SMB3 posix extensions as well (I've started a
  thread on the samba-technical mailing list).
* If cifs.ko can get guarantees (via oplocks or leases) that it is the
  only user of a file, it caches read/writes but also locking
  locally. If the lease is broke then it will send the locks.
  The levels of caching cifs.ko can do can be changed with the cache
  mount option.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

