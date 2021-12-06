Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438FC46A4AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 19:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhLFSgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 13:36:13 -0500
Received: from mail-mw2nam08hn2232.outbound.protection.outlook.com ([52.100.162.232]:63617
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233544AbhLFSgN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:36:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDHiRhxKX1cLUvQP3acWeg1A9Hp8dXRNZ5ikGQADswiJOE2YSjrVu0h71mDUalPkUWselG6ppydX5b4NO8I5jNdP5pjptg0q5HVYVOza3FtJstEivFdc6cRx2W/DCb1NTXB95AeK0GyPwKXZ5Vjro3RWG2/fLQyqv/MC0sSVPGOMOvhkRwqjXLzL7jmsFhxdIC6BMDdX0d3nRSaTSqjI22Yff01AinOVzdaMjvstmr5zuVpilzYJjRJog+v2nwoRxDke5gGSBj9s73MFsy1EBVElOVJWoiDvwZklqKdQ8f45uvSnGPQPPqz4xFWH6u24CW3vMknHlYgMfNNXY3AKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=eB6G23410ay7Zud9HIkGVZPPr4zlQpcCHXBzCrOQIHgSvbqM+ZI00ygIODLX2fNAaAaDwYiHbYjMFJwlKnGo3CpOeNBOhx8rljJz/rbQ4ONz6IXcNl3NUFFAJUwV2dOj/jlbXpmKztL10X/lNyzjskUjIOh+jfm2H3qLJ3IhSrI1nNhMpms9aOJfKcUy6ThdnocEitvPvH+19KAuljznvb/VGVpeMwLQjhZ+qzyCgAzUfNxP2rYRZTq58HGgyZKxsy16aR/VUBd8OGixXBrdJJcssJWRiwEdK7z1p+Yl4kXiqcu7y0X7dXRlIHrL2sRqhHnWoDWfa1v1W3mdNqO6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 146.201.107.145) smtp.rcpttodomain=sbcglobal.net smtp.mailfrom=msn.com;
 dmarc=fail (p=none sp=quarantine pct=100) action=none header.from=msn.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fsu.onmicrosoft.com;
 s=selector2-fsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTkULZ5UHExQp4+lt+mjKcEqTWLs4cv4821EJcQtSYE=;
 b=HvOcZ5BLddEQcs/KdGSqcvoFqph+Gljqa3uvNRewW2jElJfvdMuaAmoC8B0j1VovlWcBkU2luPwhyjVkwFQr/zi+tH/wcQzOjNqX5FcGPXefIQiWSoq1UsPrTutSjo/izu6dEkvMWQQ22JqNhmLjMKdB/DjOQS/k5U6VMDvgZYg=
Received: from MW4PR04CA0122.namprd04.prod.outlook.com (2603:10b6:303:84::7)
 by PH0P220MB0620.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:ea::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Mon, 6 Dec
 2021 18:32:35 +0000
Received: from MW2NAM04FT067.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::47) by MW4PR04CA0122.outlook.office365.com
 (2603:10b6:303:84::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Mon, 6 Dec 2021 18:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 146.201.107.145) smtp.mailfrom=msn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=msn.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 msn.com discourages use of 146.201.107.145 as permitted sender)
Received: from mailrelay03.its.fsu.edu (146.201.107.145) by
 MW2NAM04FT067.mail.protection.outlook.com (10.13.31.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 18:32:34 +0000
Received: from [10.0.0.200] (ani.stat.fsu.edu [128.186.4.119])
        by mailrelay03.its.fsu.edu (Postfix) with ESMTP id 29F67951AC;
        Mon,  6 Dec 2021 13:31:58 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re: From Fred!
To:     Recipients <fred128@msn.com>
From:   "Fred Gamba." <fred128@msn.com>
Date:   Mon, 06 Dec 2021 19:31:17 +0100
Reply-To: fred_gamba@yahoo.co.jp
Message-ID: <422f2388-cac7-4582-9d4c-49bcb70e5b84@MW2NAM04FT067.eop-NAM04.prod.protection.outlook.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f669e5e7-f60b-4b96-3070-08d9b8e6c5ae
X-MS-TrafficTypeDiagnostic: PH0P220MB0620:EE_
X-Microsoft-Antispam-PRVS: <PH0P220MB06209C02C86985684A07EB44EB6D9@PH0P220MB0620.NAMP220.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 2
X-MS-Exchange-AntiSpam-Relay: 0
X-Forefront-Antispam-Report: CIP:146.201.107.145;CTRY:US;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:mailrelay03.its.fsu.edu;PTR:mailrelay03.its.fsu.edu;CAT:OSPM;SFS:(4636009)(84050400002)(46966006)(40470700001)(86362001)(47076005)(9686003)(31696002)(70586007)(2860700004)(786003)(70206006)(316002)(356005)(6266002)(7596003)(5660300002)(6862004)(3480700007)(82202003)(31686004)(6666004)(83380400001)(40460700001)(508600001)(2906002)(8936002)(82310400004)(8676002)(35950700001)(6200100001)(7416002)(7406005)(956004)(26005)(336012)(7366002)(7116003)(480584002);DIR:OUT;SFP:1501;
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVBBZjdWZ21pY1cxU09TRDFsMGRkNFh4bHpZVEc3S3dXcGhPbGdmNVBYL2k4?=
 =?utf-8?B?TUFwOVhqb2lGNDRNOXNnTzlWT1M2UDVtQkhpTkVpTHZJVUczSXNQbld1Rkls?=
 =?utf-8?B?cERkUmpwR2FWMXlZcW9UeFg2Z05udXZxa2ozSG9RZEV3UTh0eG5mME5Hd3h5?=
 =?utf-8?B?ZmszdTRMekJyMnVsTGFiN0lmMDJZc01keGQ1QURjajg5U0djSzg0T0dYczcz?=
 =?utf-8?B?c2NIOFhOZXJHc1VzS3B5U0s4SjhSMDNHOTE1TXBRU3lhcy9wcWhBNDVTaTJT?=
 =?utf-8?B?b28zTlh4MkNvOXlLVUZUd0hleVRIbkwvMXpTeGhUYTNMSGJBSmlydWQrTWUz?=
 =?utf-8?B?MDdGbGo5c0kwMlVxckFYZGszSnBlbndXbzBiaFJtWkNrWnp2a0w4WEl0WUNy?=
 =?utf-8?B?TTliYnhYeTJhSXBhUXpaSTMvZ1FYYW9UQWdaeFZOYVRzYXNBSE0vYXZSVzc3?=
 =?utf-8?B?ZXBkaWlnNENYcW1ROFZwRHBQaXUrVlZ4a1didnZlaWc5OGJHK0RDTXNuK3VT?=
 =?utf-8?B?SWJJb3JycHlLYmRPVERNc0FQM1VudEc5dnNZVVhNTncreXNQbjRQTWVvajZm?=
 =?utf-8?B?bllzSmhvSFdzNjliZ2tJVGRNTHBRNUppRld1bWlkTDB4VTdmcThFcThYckhp?=
 =?utf-8?B?MW9tYWtmRjZXcnlacUp1bkx4N3M5b0xlcVZ1RFoxZXVTbjExemhrbGdXNG9R?=
 =?utf-8?B?Z1lmTnZDWS9NZFE5a0lIZ2FwSnBuRDJ3dWt4UFlZYU5zR0syMURDWlhDZ29J?=
 =?utf-8?B?ZmExanNra0ZNZ29yakh2UHRuTVVoU0FZOS90R24zeWFaRDNoeW8zU09rR1FG?=
 =?utf-8?B?SXJGUnBtbHgzV3BZSzNvWEhqdmJQSmxhdHR3V0VzYk1keHJyRGtsSHRLaDYw?=
 =?utf-8?B?WlN1ZjFqMXdoZlVyRVN4Z2tnaTZyMzI4cDdtSFhxTWxuZlN2UkRPcnRrYnRM?=
 =?utf-8?B?eHpwcC9TZEZnL01YeWFGOGtCTTlrK0xHNUp0QkE3RHZmL1l6QVVCZkNSRzYw?=
 =?utf-8?B?Z3VsaFFGVnpjVkdjQUFQSC8wd0k5WDF1OExWTzUyMmo0YzFoMkVaY3VQdThy?=
 =?utf-8?B?UnB6b3FvNld1Z04wYkZZZEg2OWZMamdPSjJjMXhjQ1FRdEZRSVhPK1FjcWZ5?=
 =?utf-8?B?cTIzNk93aVRvcE5iQ0ozeVZVMTRSREhKS1RBMVB1bU9aNUJJOGw1WjRPZEhC?=
 =?utf-8?B?NGxUSnR4eFVNd2sxTVZsdDhrN2c3MTZ0b1o1blpBZVo2T1N0K2lhdzM3clk4?=
 =?utf-8?B?K3hwTWYwd24xdGt1QjRRU1NlQWllSHY2RW5MZk96K3ZDR1AwL25ScWE0eENW?=
 =?utf-8?B?Y2VjVzdvSm9yYkdic3ZxWkF5NW54RkxxdHJGL2xhcnlFbXNoekNWM01Wbmxv?=
 =?utf-8?B?SVZ6UHgwMkFWN2VjS0VvTFg0UDVLWWJzS2hqQU9ib3JLT1BjdVptZk45UGdL?=
 =?utf-8?Q?1j1FzjDO?=
X-OriginatorOrg: fsu.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 18:32:34.6277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f669e5e7-f60b-4b96-3070-08d9b8e6c5ae
X-MS-Exchange-CrossTenant-Id: a36450eb-db06-42a7-8d1b-026719f701e3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a36450eb-db06-42a7-8d1b-026719f701e3;Ip=[146.201.107.145];Helo=[mailrelay03.its.fsu.edu]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT067.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0P220MB0620
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I decided to write you this proposal in good faith, believing that you will=
 not betray me. I have been in search of someone with the same last name of=
 our late customer and close friend of mine (Mr. Richard), heence I contact=
ed you Because both of you bear the same surname and coincidentally from th=
e same country, and I was pushed to contact you and see how best we can ass=
ist each other. Meanwhile I am Mr. Fred Gamba, a reputable banker here in A=
ccra Ghana.

On the 15 January 2009, the young millionaire (Mr. Richard) a citizen of yo=
ur country and Crude Oil dealer made a fixed deposit with my bank for 60 ca=
lendar months, valued at US $ 6,500,000.00 (Six Million, Five Hundred Thous=
and US Dollars) and The mature date for this deposit contract was on 15th o=
f January, 2015. But sadly he was among the death victims in the 03 March 2=
011, Earthquake disaster in Japan that killed over 20,000 people including =
him. Because he was in Japan on a business trip and that was how he met his=
 end.

My bank management is yet to know about his death, but I knew about it beca=
use he was my friend and I am his Account Relationship Officer, and he did =
not mention any Next of Kin / Heir when the account was opened, because he =
was not married and no children. Last week my Bank Management reminded me a=
gain requested that Mr. Richard should give instructions on what to do abou=
t his funds, if to renew the contract or not.

I know this will happen and that is why I have been looking for a means to =
handle the situation, because if my Bank Directors happens to know that he =
is dead and do not have any Heir, they will take the funds for their person=
al use, That is why I am seeking your co-operation to present you as the Ne=
xt of Kin / Heir to the account, since you bear same last name with the dec=
eased customer.

There is no risk involved; the transaction will be executed under a legitim=
ate arrangement that will protect you from any breach of law okay. So It's =
better that we claim the money, than allowing the Bank Directors to take it=
, they are rich already. I am not a greedy person, so I am suggesting we sh=
are the funds in this ratio, 50% 50, ie equal.

Let me know your mind on this and please do treat this information highly c=
onfidential.

I will review further information to you as soon as I receive your
positive response.

Have a nice day and I anticipating your communication.

With Regards,
Fred Gamba.
