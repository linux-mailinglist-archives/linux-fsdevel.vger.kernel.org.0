Return-Path: <linux-fsdevel+bounces-9677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 829B78444AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 17:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0617BB24E78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F4912A15A;
	Wed, 31 Jan 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vV8ezNP9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="vV8ezNP9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2073.outbound.protection.outlook.com [40.107.15.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25CA6AA1
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.73
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719103; cv=fail; b=fHci81VpAi+QNDRVc5/WiK2AqpJXn+zOngUcZBgu11f8396ZIifWcAcSb829Vfy6IfYhTZK3dV+ukycUtJqODVxRGuJ+hAsl5z3Y4lEC4DBVHdUOz9MnDOrsu/CcsktRRcHSv7geFB7Nr1Rb5f5FoOX0VwkGRp/bmORcDiO2dX4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719103; c=relaxed/simple;
	bh=Viq7dqRyFFOoSBV0uXgv0PRLPFIu5pY3ySl1+Dm8vpo=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VJn6zDz7XZFcnEPOBQM1txUbtE9AEe7RNsfoLLz1UjjK7sHh2did3oJ+oK1Xn0qdt6KDPc4RZsYrs+zaCZPU6lCFFNCcPdC+kB+kNva0ctpJ4CS8HMMTxZiG5tJmrn579Ods5NVhi3f2tG/u6DLHudxtFl1HJii5H0im5xgmGK8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=vV8ezNP9; dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b=vV8ezNP9; arc=fail smtp.client-ip=40.107.15.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=G8mSL7o6d3g2p98A6024hBW0uc6iG34Le5iTH/Yuj8THhhMB0MyCe36TmZswR4+I8AqVQ6jDcbSsSr4n02z3UivQHLT7q522fLlzTLpayuCNOFM6PPpC/08s8eYFIdQMe2jwSuSrZi1++ceFmZ02trcoPYJ5tkcX2DJd+aEiPlMMjFa2+sCk9NfpJ+TmlAfCf94671xhZsmtPIDu2YM7vDYqJfzYID0qe1h7fvAdIoxtRLmVxrcIXJqR0qYZmsKm9vACk6+4sKDt7QxCvGg0y3X6v/lbm3sh9lc4BiPeVTbLb+vfXvy7p84xfToTSHXf4OtL6K26Or1yPDOrjNwEFQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WyJfM7NVsi9gf8bwBqmerjoT5AHop1nlz0xRtRpnOg=;
 b=QxiR629h14Nlf8URXFrCIcrhB3mY37xZHuObSSEIyTeaW30FCldZAyG7NwaxSU0+7UmXJfU3zNbgswxeDJkqDUHIKRHqeivhSfNBvwIw5x9a3cc36Gyy/POwGqvy1Je2acqgCQ4cQlY/gCL8Y19CGObf8r4UdynAG58vTO8WKw9A65rkCv3nGxjUBtlCiNTo6+Ui4fwrKko4EsTX4oPaM60uFq+kgletV7ERKAwQeC/YsOV0qETjHXXON6/7f7Y+LXfsyliTI3gQeX44VjPPeBbBMN0pYciDQ+PoEUPUB1elsOFpRfCbB628VfTlm/rvEWBqoQBF8j06Ed28P1XbfA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WyJfM7NVsi9gf8bwBqmerjoT5AHop1nlz0xRtRpnOg=;
 b=vV8ezNP9oUcBPuozCUDkZMgV+oxDIX9RRo8kv1yb/Lpk9I5wV+8GBbsTdKccGlWNMiAOShckLCsvxSf5mMNRRCJzJqetJfc9BItLTMKRme8oEoC4FnGXKcoRBSuYBX7gLviiYqlsMMjztn690x3ywrEdmKtF3ndwcNZGR1qunCo=
Received: from AS9PR06CA0342.eurprd06.prod.outlook.com (2603:10a6:20b:466::18)
 by PAXPR08MB7350.eurprd08.prod.outlook.com (2603:10a6:102:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Wed, 31 Jan
 2024 16:38:13 +0000
Received: from AM1PEPF000252DC.eurprd07.prod.outlook.com
 (2603:10a6:20b:466:cafe::95) by AS9PR06CA0342.outlook.office365.com
 (2603:10a6:20b:466::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Wed, 31 Jan 2024 16:38:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM1PEPF000252DC.mail.protection.outlook.com (10.167.16.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 16:38:13 +0000
Received: ("Tessian outbound c4f080b252bb:v228"); Wed, 31 Jan 2024 16:38:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6f8be72b99fd5f0d
X-CR-MTA-TID: 64aa7808
Received: from 32bcc3c651c2.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C0B2FBB9-E1AF-479C-92C2-C30877B4DB63.1;
	Wed, 31 Jan 2024 16:38:07 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 32bcc3c651c2.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 31 Jan 2024 16:38:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAe8AriO72RzHV+fd0pw6WIGj0CShrMrgFSyRQhjDaT+/uEdMyFnqGEknpSsHpccTXY75ebHitg8EUHUhyEnCY7h0a5Cvr156lF77TH/8diRER/qFPtlsPoAQ5BHxeCLzdP5dfd1e1hEZcm9WQRAFy72Qd8VVvwE0cQxQPoTs5ZoXCM2+YF9iXqYfrfwqx3Nru7wdvxLitOuZu/xeso0VhlsKApP6JP1RKgyeGM8nfBMQ/Um8TfAVS/NkrmTLPNOMjWPRoJPTqOUTj+AeMlu5x8iHOgZeH0pj8MSQlyPK7f7X17ZN4GMfhZlk4L+UKQpBLDbcR9MJi8QesTlm2pcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WyJfM7NVsi9gf8bwBqmerjoT5AHop1nlz0xRtRpnOg=;
 b=WiT6awGYizoFHR7Is32pc/5MAC5isvYR733HI1TrQ+4cx1gMghEMJhClGmsB9dJk9N60zfNT5xUY3ZxnRsg4qzjpEszagb7C0vK/rKEBldN+b8K6Kw8wfR1zFSpgbTMc8a10TS27NmtfxdeuhVC6bfLKqBq+IkjbeHuU37fgJGFyBojfDZ2nrNECiBR2hDMFlRoeIQHo1xiDr9BcgZzmqsm0OpyHpoUpQQ7wLClYGhrq3TuIE9ExGDVEb8NOM/AJ7uxGC+RIXjncdEom+C9ult+AR0V6pknV+IcLPHVmvWkkoxdcELzAmqnS/aIuhoyh3QxrBWkvmGmfeDEbdtBqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WyJfM7NVsi9gf8bwBqmerjoT5AHop1nlz0xRtRpnOg=;
 b=vV8ezNP9oUcBPuozCUDkZMgV+oxDIX9RRo8kv1yb/Lpk9I5wV+8GBbsTdKccGlWNMiAOShckLCsvxSf5mMNRRCJzJqetJfc9BItLTMKRme8oEoC4FnGXKcoRBSuYBX7gLviiYqlsMMjztn690x3ywrEdmKtF3ndwcNZGR1qunCo=
Received: from VI1PR08MB3101.eurprd08.prod.outlook.com (2603:10a6:803:45::32)
 by DU0PR08MB7437.eurprd08.prod.outlook.com (2603:10a6:10:354::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 16:38:04 +0000
Received: from VI1PR08MB3101.eurprd08.prod.outlook.com
 ([fe80::80b2:80ee:310c:2cb]) by VI1PR08MB3101.eurprd08.prod.outlook.com
 ([fe80::80b2:80ee:310c:2cb%5]) with mapi id 15.20.7249.023; Wed, 31 Jan 2024
 16:38:04 +0000
From: Lukasz Okraszewski <Lukasz.Okraszewski@arm.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Matthew Clarkson <Matthew.Clarkson@arm.com>, Brandon Jones
	<Brandon.Jones@arm.com>, nd <nd@arm.com>
Subject: [overlay] [fuse] Potential bug with large file support for FUSE based
 lowerdir
Thread-Topic: [overlay] [fuse] Potential bug with large file support for FUSE
 based lowerdir
Thread-Index: AQHaVGOz8JYJ8ZNYjU282lashynInQ==
Date: Wed, 31 Jan 2024 16:38:04 +0000
Message-ID:
 <VI1PR08MB31011DF4722B9E720A251892827C2@VI1PR08MB3101.eurprd08.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	VI1PR08MB3101:EE_|DU0PR08MB7437:EE_|AM1PEPF000252DC:EE_|PAXPR08MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 8392ecca-797f-4052-4627-08dc227b04e1
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 7SaNejoxh+NSYdQWa1UCpj+XkNOxrO3zADKG4F/iDykW+2Bdq/Kz68/1tsG9/NvTfwMmF+kopR5N3OfmWMhMgmGswt+/u7TK0YYlF9pF4zNtIHpmhTWmE2khPt0eZiJlKuIPqIWrlq8UvfyQ0nTEzWYZOHsmiP+tEpmhUGERgCtfenxnflsOzLQ03/1n7Aa2W+2YHhB4BAei3QFLYhIw5YvmxVUxjTqIePcaWqXD5uwXp4tzkI6rre5nXYV57qIz+WAFRl7MBi+6TFCNQvXopQNuuuR+mzAhUHwy1c0PcS/Lssas4HO+oWBweWzZUK7Rpux1ET8Br24c1V2yClKJ5b5AyHRNjdgcaQeR6VOWUxsXljqHqlQKXPXqkVvrmZ8BkVxjYarJ0BTIfmHMZs3UKSAvAwGtTPEyeQcZdS17qB+yOImcPcnp3AYNCvI14vsA9T8VZA2WXj4hJcgjofGdV5xvbn7lX4/iwgWvb2/V7PGu6RQ/2dt2MU9qxkWHJ0jKTLWCmUvEvh+lrSlnaso4ZvWi7mpKMaAPR9mNyxF4W6EqEvIMc6LXRWU8qxVXKx8up41vZiGHWZvXqyiWIwNgHpC8wjexrwewk3K+5APFdn32ztcyhRWHjepu1rDIlBgP
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3101.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(41300700001)(55016003)(316002)(38070700009)(6916009)(6506007)(7696005)(9686003)(478600001)(71200400001)(38100700002)(83380400001)(122000001)(54906003)(8936002)(52536014)(86362001)(66446008)(91956017)(5660300002)(76116006)(66946007)(66556008)(64756008)(2906002)(33656002)(8676002)(66476007)(4326008);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7437
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	2041cc76-999f-4027-f814-08dc227aff73
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JUiZSDKEP3dt29mhb/yvQca00oL7FoAlG+6xsjv483kfqe3IuLTKjAxNrEf1Z95NQsMAzIrfvOfKTpQPpFzr4bJjNeUMK6TK1pgJ1kgvlsKfiwvEuDs2GIXc/kagxW9gZ6yCLgy92xoDOGR9zjYQhymj9MldwpvpdjZaylzZpQYrAb2gZb4oJtRdy2ll0lu9zF6d/Tv3gK8c7SqPSyZYsf3Dkvp+VXvn1xlq4mgyNk5D6++KxjZSekZfvhcVebk7HNb4lODPwhyzyPg19F4HrLRnsoT+jx2k+5y8A+1Glx1/O3E4OVSHMZXbVGqC8+P+zPNymohVcSe40eDTiRpH99woWCQtyO0cn5X9bNTsgvfCwT8fKAfFgOvNj3BfvQNR6u+s8gUS7pZe4UqbdecnjRNpECQ27RlW/ydHt4c6DcFcWNMQpvx3FxgSzUccpilqTN6wNkAsnmXda7Eg/kJf9zFxY0GQN2vb79wi6tKpXhoW3QWrTJ4eCY0jeqQghKDu0h/t3Jp+bPywJFPJyT/eh82rOxBuuadNeYCSdECEo3A0lBIYwqTLTMod64HYzRCh/G6VNLbiTeQdzW6Kb4vIWpQynmYBS6uq4pC+A9XGdlBktAxSgrDdTJTi9fF2OEDxM5UbklShrZd+hGT7y4Z1XtNzXb/N9VgE98lVD8YcsXJ9prjIkCn3nrVOuVRSV4Gmmy9J7vi77fVPSEdpE2cIW4vbL+A09G3vQz04ppKVO4G6/GdQ7mzywqXfOlOqmdc1
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(40470700004)(36840700001)(46966006)(70586007)(36860700001)(54906003)(47076005)(33656002)(478600001)(82740400003)(41300700001)(356005)(81166007)(86362001)(83380400001)(26005)(2906002)(8676002)(316002)(8936002)(7696005)(70206006)(6506007)(9686003)(52536014)(5660300002)(336012)(4326008)(6916009)(55016003)(40480700001)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 16:38:13.7493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8392ecca-797f-4052-4627-08dc227b04e1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000252DC.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7350

Hello all,

I have stumbled into what I suspect may be a bug in the overlayfs/fuse stac=
k.

The repro script looks like this:
```sh
#!/bin/bash

set -xe

for i in large1 large2;
do
  if [ -f $i.squashfs ]; then
    continue
  fi
  mkdir -p $i
  pushd $i || exit 1
  yes $i | head -c 4GB > test.file
  popd || exit 1
  mksquashfs $i $i.squashfs
done

rm -rf work
mkdir -p work/{lower0,lower1,lower2,upper,work,mnt}

squashfuse -o allow_other large1.squashfs work/lower1
squashfuse -o allow_other large2.squashfs work/lower2

trap "set +e; fusermount -u $(realpath work/lower1); fusermount -u $(realpa=
th work/lower2); sudo umount --verbose -l $(realpath work/mnt)" EXIT

sudo mount \
  -t overlay \
  -o lowerdir=3Dwork/lower2:work/lower1:work/lower0,upperdir=3Dwork/upper,w=
orkdir=3Dwork/work\
  overlay \
  work/mnt

pushd work/mnt
dd if=3D/dev/zero of=3Dtest.file bs=3D4k count=3D80
popd
```

When writing to the file I see the following error:
```
test.file: Value too large for defined data type
```

The file can be read just fine, stat works.
Mounting the squashfs with sudo and a loop device does not have this proble=
m.

Now, dmesg shows:
```
[Jan31 08:38] overlayfs: failed to retrieve lower fileattr (/test.file, err=
=3D-75)
```
Which matches the overflow strace error:
```
openat(AT_FDCWD, "test.file", O_WRONLY|O_CREAT|O_TRUNC, 0666) =3D -1 EOVERF=
LOW (Value too large for defined data type)
```

I have traced the function to fail in copy_up.c, which eventually calls `fu=
se_open_common` which then calls `generic_file_open` directly.

The comment implies that `O_LARGEFILE` is only forced when called in a sysc=
all:
```c
/*
 * Called when an inode is about to be open.
 * We use this to disallow opening large files on 32bit systems if
 * the caller didn't specify O_LARGEFILE.  On 64bit systems we force
 * on this flag in sys_open.
 */
int generic_file_open(struct inode * inode, struct file * filp)
{
        if (!(filp->f_flags & O_LARGEFILE) && i_size_read(inode) > MAX_NON_=
LFS)
                return -EOVERFLOW;
        return 0;
}
```

I was wondering if there is a bug in the overlayfs/fuse stack which does no=
t set `O_LARGEFILE` when reading the lower dir file.

The same failure can be reproduced with `archivemount` so I suspect other F=
USE based filesystems may be affected.
Note that writing over small files (<2GB) works fine as expected.

Attached:
* `ovl_copy_up_inode_fail.log` - squashfuse + overlay
* `ovl_copy_up_inode_ok_loop` - squash loop device + overlay

My machine is pretty old `5.15.0-89-generic` on Ubuntu, we have also seen t=
his on `6.6.12-1-lts` Arch but I suspect this may still exist on HEAD based=
 on the code.

Please let me know if am I doing something wrong here or if this could be a=
 legitimate bug.

Kind regards,
Lukasz
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

