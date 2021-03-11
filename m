Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2163380BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 23:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhCKWjz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Mar 2021 17:39:55 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:43778 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230307AbhCKWj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Mar 2021 17:39:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1615502365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OlKHNUcHPbriCZxdZTJEHdn+mHdyvcnC00QfjdqCVwM=;
        b=Jisw6FXsyFr4Mdju9X1ybey6R8AKVASI5DQ8aVtk46DWzZLD56pax8pJo7htjfEoyqIPBt
        ncFQ7ZvT1e/evzrssbPjuK1QgRd7A8K2voPiU1UHDqM/PggdvPqzg8Dtre51jtWa+6/lXI
        d/G01L9CW+XsESlXDrpsx9B33Tggcbo=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2176.outbound.protection.outlook.com [104.47.17.176])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-21-LI4XE8cjPAGQ33fodmUSRg-1; Thu, 11 Mar 2021 23:39:22 +0100
X-MC-Unique: LI4XE8cjPAGQ33fodmUSRg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne5o3FumT2k0LVc/oXdYMtn3CJjgExKIYjP3cCGKsUAfosDsMfHhhYUYcVV0NLAO1Gg3ttR5xwrzOVh+1BY2K6yOFZSoQjA4Yw3XEiSgSfZHGz/DEgDSAw+4Sz23tRfIjv5+bHioMQPAHlUkDT3lKQYc+jM57X/bVOJiYXTR0dDhhI3KMrMVZCThHjNDUCv2kRwlNhnmImF8S5W01FVMShvZ57xIUyixFzLnfT/lkCyGzn4tsqWm3kOQXngP54Twc0J3N5+lt40UvUikAtFAuYQgEj4nCyFz820H9iXWnl+BefWMRWwN23vraxDT9J7AOz58E/68whYdV3KX6KvnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlKHNUcHPbriCZxdZTJEHdn+mHdyvcnC00QfjdqCVwM=;
 b=TrjjnO7lc2B62C4itmd+GADfaTS04KwdcQ0XArBPPDSjHuLKfPO1jmg+q3mahQx4TmlfjjmqvNhp15ZFEgQN7OjoI8pBpXyLd0q0GHRfu7ebQDTG7IzioNfMJFSPlrcIm3yYyfHRG4sZml4EmpZTldvYWaRYNtATI1DNFH/wLw1rTZEd6Yvmo+L3EYzdUuls+45eCAkNC94IrTZgPUMRyuc+FpQ7xQJz/jUrVLz2oUv8hj+OUQj29VfQ8ZzkJSC/im5FwvNnCSimIBo0KtSZYhB5WjkyYGeSTpOpwSXVvd0zsYP6QJ1PAbLWT0Gc039JBslLuCt23UzeUR+NOD7zMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: talpey.com; dkim=none (message not signed)
 header.d=none;talpey.com; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com (2603:10a6:803:3::28)
 by VI1PR0401MB2381.eurprd04.prod.outlook.com (2603:10a6:800:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Thu, 11 Mar
 2021 22:39:21 +0000
Received: from VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9]) by VI1PR0402MB3359.eurprd04.prod.outlook.com
 ([fe80::9c1d:89de:a08e:ccc9%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 22:39:21 +0000
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Tom Talpey <tom@talpey.com>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     smfrench@gmail.com, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mtk.manpages@gmail.com,
        linux-man@vger.kernel.org
Subject: Re: [PATCH v4] flock.2: add CIFS details
In-Reply-To: <23052c07-8050-4eb8-d2de-506c60dbed7d@talpey.com>
References: <87v9a7w8q7.fsf@suse.com> <20210304095026.782-1-aaptel@suse.com>
 <45b64990-b879-02d3-28e5-b896af0502c4@gmail.com> <87sg52t2xj.fsf@suse.com>
 <139a3729-9460-7272-b1d7-c2feb5679ee9@talpey.com>
 <87eegltxzd.fsf@suse.com>
 <d602e3e4-721a-a1c5-3375-1c9899da4383@talpey.com>
 <878s6ttwhd.fsf@suse.com>
 <23052c07-8050-4eb8-d2de-506c60dbed7d@talpey.com>
Date:   Thu, 11 Mar 2021 23:39:18 +0100
Message-ID: <871rcltiw9.fsf@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [2003:fa:70b:4a76:c575:78b3:c551:390b]
X-ClientProxiedBy: ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::20) To VI1PR0402MB3359.eurprd04.prod.outlook.com
 (2603:10a6:803:3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2003:fa:70b:4a76:c575:78b3:c551:390b) by ZR0P278CA0105.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Thu, 11 Mar 2021 22:39:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b6f11f4-c979-4e17-bdba-08d8e4de8338
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2381:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB238124D2AC7023C6A6CAB913A8909@VI1PR0401MB2381.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOwkYuS70HgZXpTh/Q3MXqTN54ffas2qdeWO95l6xCWanZxaPWvf9IOvc+Onko7MDax1gRKX1SpYDpTLBeRjlprbI8izsdHXGcuQI2PH7VjO2+hJszcjBIBgPck0Xr89y/JVuePD5aZZF6ZqTxSFZ1VfREHq3/yVTr9zV9M3MHWh4SYSbYkAifIgYGNsWdYM8h1cUBj7V5JxazWUoxKGQTVo+rl12aflBrP6NQjJXyvXhLl4XCSizGhizhcajEXBqzev33NpN+rEbdfKC8NQTg3r/4yEiYJLPTTFYkgxGvbhDiowmn9iCxLYPUhKA7Oi73ezIGd0thIv0/2cUw8cJnkgZJcOyZD9mKxNAbq9DcQj6Sy9sSdcWc+klgRpLDPoAg0LeIkW7qZL9R3g/z2XeZRuvLKaoUn20c/oe10J6W49im/XKP1+09aPM9ZnYzFIgDxydrtORis+uUn32PUF39HWfO8AfmGodX+1VjcIbGjU3QJFVkkFspx2ZWNlj+pYpT4J3wAHYXD6lWeiXaOHfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39850400004)(396003)(376002)(136003)(66946007)(36756003)(66574015)(478600001)(186003)(66476007)(66556008)(52116002)(16526019)(86362001)(110136005)(316002)(8936002)(5660300002)(6496006)(2616005)(2906002)(83380400001)(4326008)(6486002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZnZncGtnRHZOa2YrRnRLeVFjSUtmaTJxa3AvS3l2YjN1bnNSbHdhcnpGdnZi?=
 =?utf-8?B?TXRDRlVQRnAzemFPUjM4OE81VlpJYWtPclYvMGtTaEoyU0hRTGw3TkcvWXlS?=
 =?utf-8?B?b3oxekpvSjhGVEd5QkhoT0thL3ArTHVWV3phTFNMaVZqMjhrWTA2NU5MOUZU?=
 =?utf-8?B?UCtGbEwxT0N1Zk95VUhtWmozL0RsZFAzT0dqRXIyL1Z6TU92NTVEbmJZU1pL?=
 =?utf-8?B?SnN6MVh2clNWV0JsM0g4M0RYLzNxNTBXazhkTWZabE9xTGxzMXRhSlhaV085?=
 =?utf-8?B?ZmhhakliVElxeUROUkdVTDhGM29XN2MySzRMbFVmWUE3UGdvbmpDYis0RnNJ?=
 =?utf-8?B?TjBOVmdiMEN6NmZ4YXhsdVo1ZEVMRzRVWjF1cmhEaXlNQTNBZEo5d1hUbTNV?=
 =?utf-8?B?N3NTWDFFaG5qbGxpdlJGcFFqbnJPNFZ4WmQ3R2h2QWdCMXhOa2RTYnE2MnVs?=
 =?utf-8?B?eUxqWGdVNmNRbHhwdzJROEV0NTgxYUE4ZFFGQnJwSWJjZGxiRnp2QU42UnMz?=
 =?utf-8?B?NGpqY00vTVFyNU1pdmR6TjZxTDhyTGxtQnNXOU0zb2pMSWc0WnU3NWRJMlJM?=
 =?utf-8?B?Y1hHL0Q0cVlGSFZ0NzRybU1zNVY4VHdQbFVmTUZkYmVaMGdKaVZZb29iMlE4?=
 =?utf-8?B?TGlacG1oMkl2WjJBa1dsUzA3Z3RXRjAraG40L09LU0NHbGxtdU12bTJteHBI?=
 =?utf-8?B?KzFZV3hlSXpuSWF3a016SzJkOEZmbXo5VllQTE9PZENLUWlvZFhVb3FOVVY4?=
 =?utf-8?B?cUU4dGxmZ29KM2F1M3ZUM0toM3FUS1VDWXp6aFYvSTRrQXV2NWlLcUh6QlJ4?=
 =?utf-8?B?RjFjOWhrVUpOUHdyQzhqbGdaSkhQS244and3bjFTNy9ZRWZxU0JHTU51dWpE?=
 =?utf-8?B?M1pzMnR4ODBRMmFYNnQ2UW02OFRPQUE4OXE3NFZ2QVM5Vnh2K1VQT2hkRzJL?=
 =?utf-8?B?WEdsQ1h1M2JvektUQUdPWUdZakJ0SW5QUldLWjBvNVFGUWduVWgyWUFBUkRP?=
 =?utf-8?B?bkVMRzRyU3NOY1RudUdPNEtCYXVxa1RKbkFiVUdKc2MwOTJ5TGErdjdXemFV?=
 =?utf-8?B?QmFPRVVWVmJ4U1E4byt2L0drcmpYNE1Lcm5mNU9nZjk5bU41Z2N5UVpQMVM4?=
 =?utf-8?B?dm4wTFdjOHRYSEpoMEpMV00xQXdIQ2lsZldQZGIrd0c5dWJhMVk2TC9OdGFa?=
 =?utf-8?B?Q0k4SExFZzN0OEVIOEFlTFpQdHN1L3JZdGhnTmVkLzVhK1pOYlhpb3M1MzNt?=
 =?utf-8?B?ZDFVTXFNa1N0VXJpZ3dYOUQyOXlScFNTZnJjSmRUMmpsMW5ZelZDMmhzQlJW?=
 =?utf-8?B?OHF2K0NZU3ovb3JVbXYzQ2s0aDFHdnBOakN2b3ozTFlHSmhhS2F3L1hRTHRu?=
 =?utf-8?B?ODh3N0Y1K2JMdER1bmxXZnlVRmk3cGtZMXNSWDdJanE5bmpoS0piMWdodEVC?=
 =?utf-8?B?WDZMZWxrR296WFpPZ1hYNEJyb3hWYjhFZXpLTHlSUmt5UGNIYzRCVVNWVXMx?=
 =?utf-8?B?Tnd0c0Q2YXM0ZlJwVFRjWGwwL1Z5UGRKdW5LVDJQbE9FbTNXYlBRek5DZG5w?=
 =?utf-8?B?bVViWmdRTUJ6dHBsRnE5RFpWVFEyT1dnSWtwMG9Qa0o1N2dEQmkzb3RmZnJD?=
 =?utf-8?B?TGJsaVpsR0NqS3JWVEthT1hEUldLd3IvVHNDMjRIalBheW95RWZPd1JaajJ3?=
 =?utf-8?B?cHR0UkZ6NVY4eUF4SkR4NW85OEtKZXpjeEdLZ0x0L3kzUGhIMXdZbjEwVnZR?=
 =?utf-8?B?YnNPMGcxdmFPTDltY1RtL0tEd2hsWnhSUEJjYjRhaGxJdVd3bGpjTDhEWEJo?=
 =?utf-8?B?dTg4b0FNaEFwMlVac1VuL25VSFI3ZjdoTDFaKzM0TXpuaFZ1L0tXc2pTMEUy?=
 =?utf-8?Q?4O+8sGUqwZjZw?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6f11f4-c979-4e17-bdba-08d8e4de8338
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 22:39:20.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt5H9sOzYvqycITfPUSCzoWUUCWHNbsZrlnwtZmORI0r5INTw84cSea9A2FU/lfA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2381
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ok, then I agree with your last paragraph. Here's the current version, with=
 semantic newlines:

 In Linux kernels up to 5.4, flock() is not propagated over SMB.
 A file with such locks will not appear locked for remote clients.
=20
 Since Linux 5.5, flock() locks are emulated with SMB byte-range locks on t=
he entire file.
 Similarly to NFS, this means that fcntl(2) and flock() locks interact with=
 one another.
 Another important side-effect is that the locks are not advisory anymore:
 a write on a locked file will always fail with EACCES.
 This difference originates from the design of locks in the SMB protocol, w=
hich provides mandatory locking semantics.
=20
 Remote and mandatory locking semantics may vary with SMB protocol, mount o=
ptions and server type.
 See mount.cifs(8) for additional information.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, D=
E
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)

