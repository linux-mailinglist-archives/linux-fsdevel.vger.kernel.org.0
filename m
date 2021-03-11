Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84D9337B50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 18:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhCKRqN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 12:46:13 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:20121 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhCKRp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1615484755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YqqsE7wVeN2QWcworCRjzlWd6xO9mJ6xN5fjh/UjToE=;
        b=SSW5hw/6UVJKrkhII9kcd46GQw9VCyoCD3slORu/9ZlUrv38+g+0/BZMJ1vlZm4txyneOW
        fKYSzcHm0ix+h8pDoO5czAOlsRnNeK/VzAQrQylf6B95hFlTL7HageW82AGWAgeW05JvPz
        rzieGWKrvXC4QpRo7bfLPuQM+ueBu1I=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2050.outbound.protection.outlook.com [104.47.2.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-28-54Ab5tUuN3GtHcL4cD-rUQ-1; Thu, 11 Mar 2021 18:45:54 +0100
X-MC-Unique: 54Ab5tUuN3GtHcL4cD-rUQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxkWzWehR4X7SN6uCPnwkADj7CZTP5ORNGAfKm4nRn0SwiqsWbPNB+6F5RF2l+mta3eOliICSe/p8fyxxynprN81G0x7dBNTVFbxVGUAin06aOfFiNwr07jBedHj5nk61FP8Xbt5u7gXpayg9MfSpD4EMQmOgi647z7Jz7YGd/6BO3TJO2D7yfJ5tZ0JGJu4RkxPvMVQUF3hmbIr+P/MJ3LxKrPMQ9j9VEpJo0Id6aXM6ChJmJFRQNu2tNMfUldi008Rt739LDIvRsdgFjnXh32MfwadGBdiFCEPv1gQ3rTwcfZKhbRxKqQzbPDbuX0Fcwm08t5lDPw0szPpTX1Vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YqqsE7wVeN2QWcworCRjzlWd6xO9mJ6xN5fjh/UjToE=;
 b=DRkMCSSyknUUurlOlGL4dgeW+yl0JBCG9ewF18szrxAPQ7jFTaZ1ycOhL1hYj0VL7FXDRNr5eslY20Rm7ku3RwQa42QWdc3kqI4SB731+jGrMWNcGW2O+4TemPlAfKnkXvpIua71Le+yVA+myXzfC13giXBB4M6ULT3Hg0cAUknN328Zf+uASRO90PERkUHphpiAN9UQeF9HJKJJh4PmCZBtKi68xkscMqm0DM0VqWWsLUsCdFurCdIJz7mH44kpOlu1hB/RunjGJYq5DjibjF40nSKj2MuHfPtK+mf3kqFWmBR/3pQb8Tl1nTLZCRkj9KdLpyiduH42WEtGyTepLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VE1PR04MB7487.eurprd04.prod.outlook.com (2603:10a6:800:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 11 Mar
 2021 17:45:52 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 17:45:52 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Tom Talpey <tom@talpey.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     smfrench@gmail.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mtk.manpages@gmail.com,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v4] flock.2: add CIFS details
In-Reply-To: <d602e3e4-721a-a1c5-3375-1c9899da4383@talpey.com>
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
 <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com>
 <87eegltxzd.fsf@suse.com>
 <d602e3e4-721a-a1c5-3375-1c9899da4383@talpey.com>
Date:   Thu, 11 Mar 2021 18:45:50 +0100
Message-ID: <878s6ttwhd.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:70b:4a76:c575:78b3:c551:390b]
X-ClientProxiedBy: ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::23) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a76:c575:78b3:c551:390b) by ZRAP278CA0013.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend Transport; Thu, 11 Mar 2021 17:45:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec34cc5b-c613-48aa-d2e6-08d8e4b583db
X-MS-TrafficTypeDiagnostic: VE1PR04MB7487:
X-Microsoft-Antispam-PRVS: <VE1PR04MB7487654019917DC278FA6602A8909@VE1PR04MB7487.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q72vialvpKgXkiySOI+V1G5uHTQiAsfB8ze8NTmXONVOIoTj0Js37Fl628x+fxTOc3kLIySKGAlDy4o02JPxTHXcBmYFM8HSMSZ0DkPZHjXS4UmuWFBDr9mkj5Y0y4E5dMfxxznwN9phjkWZIgUH8zyhkNUD+IBFN9cVNqSy1HOFHwkN75uLgWatRHQj1gUEu6yz7u1p6hGXnNjv+ig7xiG/6uvu1pneM3ftlo6jKW6PVGqj9/ofkSS5U4SqUiB0eAGQgtUeAqme03GeYi6eu2yUj2Zqu3kSGZV0xDcRuX+lgg5t1TgaAqTqtaaizxqNeoDYr/0oDoZtJGQmsQiHcrH9v6a9uHOzGZSbim9MYjKL8ikR0iTLcZr0TO90LuVYd8LxWbi1/xKJSvVOiu1E3f7PB0F7WaBwgC5d+t2552UyEcvV1FIOiNBDkgNJNEFUCTGr3+Ws2xt1ovHQ80c1t6BHoSSmbzS4JA6K2MXgdejuPG5tqf3zr0qD0oR3iKaWLonKAayXhJ+2J1IWzoNCsbrkhkpyzPNC6hWvv3ew+mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(136003)(39860400002)(4744005)(86362001)(478600001)(66946007)(66556008)(66476007)(83380400001)(36756003)(186003)(52116002)(6496006)(6486002)(4326008)(5660300002)(316002)(8676002)(8936002)(110136005)(16526019)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TEhDdGR4TFdMelg1UHhjM1ZnUVU4eSt2Lzd5RUtiQ0xZT09vNGlwUkg0aklV?=
 =?utf-8?B?ZUxxbTJ0b0NFQzdob3ZYMVVFZlVSZWdjbFNFMGJLcW1aZEtGTTBNR3hzeWUr?=
 =?utf-8?B?akE1bWlTWXpNM0NJNkc3cVhLbGRoZXJPbmhkeHNoYm1oTGhLOEdYNHgwSmNz?=
 =?utf-8?B?R0hpM1NuV2UrU0ZVTFRIMzNIeDhmd3lMV09MWFRHc3pUOUVlQ01FaksxU0J4?=
 =?utf-8?B?cGs3WFJtUXNzS1huNWwwU0EvUXArblhxWU5mVnZsY053MHphbmg3MFU5ek1W?=
 =?utf-8?B?WVRZZUNaVDBkUEpucExXc3pSLzRUOGJla2tzRkZlS2JweFkzWXpXUHlZZnlG?=
 =?utf-8?B?WXpUK3VHZUNqWlVlMU9vTytCSTBRY1Q3TFgwRjlwZGl5QjB1cGdpSDRBQlkw?=
 =?utf-8?B?M3ZVaDI3S1hLRDh1Z2c4RlMxNVZDbmFJUDYxT1FvNkJuTFVvQ0hEZTBETUY4?=
 =?utf-8?B?OGwwTXBHUGNMN1JNRld2eE9kb0RkTGd1Zk9aS1pJL1BrVVo4Q0FRYW0vU1c4?=
 =?utf-8?B?aVZMcTdjZ2NJaGpNd0lTLytrMi93MHVRRXZqQzVGanRabmoxZXA0SUhGSDg4?=
 =?utf-8?B?YnE5cUsydE5GRXJTcWZtK1o5d2J0am10QkYvbUVLNytPcU9kOE04VlRhWExJ?=
 =?utf-8?B?QnYrY1RZTW13RFB6cmdLVFRnR2orbkR2NlJOMEplVFJBZWV3VUx0YkNMTGlI?=
 =?utf-8?B?a2xUd1pXQWt6cWJTTzlvWWZNYlZOQWk3VytXNlZrZjVpdmFCRXF3MnNreTdm?=
 =?utf-8?B?T21YWDFrTG5mTVpFTE9JWDhKZ2w3WGZ6ckNERlprVGpUZ0ZWU3B6K0lKNVJT?=
 =?utf-8?B?U1htRS9SbTVuMXowUHVvYzhjUWlEREZDQ3NIeHFsdW4wYVNVWldSVmtYRnNa?=
 =?utf-8?B?bk03Z0FzTDJxQmpRZnRLUHpWbnlQbUsxb2lJRDM2djcwbmxBUkUrbW5QU2x3?=
 =?utf-8?B?RHZEd3BkdUo4L3YrTUEyU2EreG9xWWs2aTdQdnhCOFhURDRaUDRkek0veXpq?=
 =?utf-8?B?UFBYRHdUTDBiVlU2b2JhSFFxMXVTMnJNaHhIVzRKb2owaFpWT1pMSlFTZW5y?=
 =?utf-8?B?ZGpCWDZBUHlhbFpGc2RZWjc0QUF2eTh2T1czWldWcmVhR0IxOGtzNTFERW9W?=
 =?utf-8?B?WEY2MGJwOXNleElsR1hvN1labHpiakZMQVB2a0JlTjJleE5ESTBJclM4eml6?=
 =?utf-8?B?d1ZFY09nN3o4VVZPbFROYjFhZTc2S3gvWmFUUU1USTRPcWNMelRoV3NtbWw1?=
 =?utf-8?B?Y3RWZnNMWWQ3MzJqTGptV2MxcVJMR0F5enJ4NWNHZEVkakFZMkp6TWkyYVhX?=
 =?utf-8?B?RU1tQ0NuWHFzZkVVQXYzMGk0d2REYzViWUNaYkF6VFJBZ0VEZHpXMlI0VXpa?=
 =?utf-8?B?cHNpM3U4N2djd3U1SXBrSk4xV2lrRXpDSEptMUk0N09QQ05CZURLNGFNL0VW?=
 =?utf-8?B?VDBmWnNKNnppd09WcVdqcDF5M3dkN3lvNk82WDNGU2RNeGw5Wm5pemJ3dWtY?=
 =?utf-8?B?UVlRQUdZVmpEOFgzVy9yYWpXL1EvVUNUdWZXSVdHd2s5ZTJqUjE5bENxTTV3?=
 =?utf-8?B?S3ZxQTFYZjJXSi9JcHNKUWF1R1JTZmUyZ0hydWMzUm56YUxOR2NQRkVLQmxR?=
 =?utf-8?B?YkpwcVZDM1lxOGoxSlNvMnZiWnFRZ3BrYkRmb2hOeEJyVXAvY1lqUzJUc0h3?=
 =?utf-8?B?VnZVUXcraXpFZWdiUEVYTC9GT21nZjJHZnhOLys4SkRLREYvaFl2bmlGK29z?=
 =?utf-8?B?dkRQVVRCcWE3VHpwL0xHSjJQZmRCK0dVQzJlTzFTN2JjRmk2VTU1UlRHNVZU?=
 =?utf-8?B?d2l4Ri9IVXRRVUZBeTNHSjByZW9xRTMwNE0reFlkanVLRk1zWkp5bGlPTjlN?=
 =?utf-8?Q?ipt6Vg5e4VSXN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec34cc5b-c613-48aa-d2e6-08d8e4b583db
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 17:45:52.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4679xfVkDPvNBh5Y8FXLZi6/Pj6AMEZl3wVrFr7jtKCVBWn1lSUPqJwEPOMgnVJN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7487
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Tom Talpey <tom@talpey.com> writes:
> and simply state (perhaps)
>
>   "Remote and mandatory locking semantics may vary with SMB protocol,
>    mount options and server type. See mount.cifs(8) for additional
>    information."

This would be the complete addition to the man page? I feel like we
should at least say it is *likely* that:
- locks will be mandatory
- flock() is emulated via fnctl() and so they interact with each other

Which are the 2 aspects that really diverges from the expected behaviour
of flock() and likely to hit people in the wild. Mentionning this will
send people trying to debug their app in the right direction.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

