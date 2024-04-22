Return-Path: <linux-fsdevel+bounces-17398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027988ACFBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 16:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2618F1C2118F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF680153518;
	Mon, 22 Apr 2024 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MFIdc6q2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WT1DGBga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4027D152DFB;
	Mon, 22 Apr 2024 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796862; cv=fail; b=VeqGijNh+5aSXgaavtiNj4I6+YNeCtKB78tBfLyKFdiKuzVAey6BHxvfXEVkKrKSgdiRp59sbWW+HMqEEATZgO9/vcRibZKW/sabNFbHhu/veIlPBMzja234hcqmbjdPEWXSlu1e5lgA+K5nfaEXpxrVj+5fRGMPXRUKUMEhwtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796862; c=relaxed/simple;
	bh=C3S5CpYzbTFYSyscUzb5VFJmE83nZ7++8K27ay9153Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4AHr6QNtvxzl/eGLcOIp6cM8HwkFB+1Vtrj0ULSSbjbWHYYBdxZY57bDIZLTpnBXi9jZgn/esJ4rVoxRsx9mPADSqfykCTVB8VwXA+kZv0gLGrGPC3Fv+zyybAZhgiYsvcy+BOLCXWW/VSsDEOWSNj9R7LEwv1/j5NLQdoOIyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MFIdc6q2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WT1DGBga; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDXxpD005865;
	Mon, 22 Apr 2024 14:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=49ljf2saGMeHE+yHQnzEON1DLcaRD15VYQp+BpxZ63M=;
 b=MFIdc6q2PHY5/sYhZdluCdul0D1yjzpoFil0+T8CSUaWDUtG8kbcaGivOpREPK6LTW8E
 iZNjAVAl4UjHmR4n/A4+7DMiF4DiG3+xqGvTvrwSeIY+FsyA5rk+6SXp6HxbG5z58T6+
 4FKaq3vo3MY2spx0A9MQqzCfvkxSUQIqwZdziavAY7Y7F24NpwGqRcWTr8yP0W60VNZe
 pSc8PaiHtOglyxNDpiyHvEXC10Ooj4rV0V2QrH4jfFbZ+1hxR6Mebah7fOydyl0gxYZ7
 4tpJrg+mwcFHKf+A5EJVGl0EB3p4Xkai6N6g1pQRJ/SsALtuc/suayFWmH4KtYMIb1zd PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44ettkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43MDtRdq020139;
	Mon, 22 Apr 2024 14:40:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45c7wtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 14:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJNymi9JuaHTNTbg+QCS4+J3gmHc+YFsQ56IC+BKtgT74EToW5o7QZA1OCoibBbhEqKFtq6n3coQmqk/2ZiayohemSsOGsrWBfNmVFYQbcbjEXa8faE4IYx0C/BOa392OYl0X0vqmv4RBbpoqNoJuM1mdT6Xl+WXWfzENoVSt6YbBLkji+nMfS/N2lYhgjPYSyL/Dh+3d4k/0WGL7lKOxUoz/rg2EnoRycD9bW4GQGxfjUGbL+GrXKMN7QfbuRjJtke0OzHmmZaArrxFikmIcWuQZkRVwamKpC2Be/4RgCaYJerrrUEkfblELeJskNgm38NAM7lp+k3+nFcrlYaVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49ljf2saGMeHE+yHQnzEON1DLcaRD15VYQp+BpxZ63M=;
 b=Dg9jZSuUuLHOSbVBHP+TlwlNuZnJK6IR3NGvjHv9dSP8xc4PSKJHoIQ5dAEggyZcxeWB4lEjZPi08BttnOCaM2hbKQM5hdl8iEXu8Lid40HqKRuG8dvEXGAT1kPt9+DMRwOEnljsaS6D8W5At9VaubIoCdMwNcGhhI+fwBdXEHy3RVWcnJ/AMbCqZIW+gG5H7X+nyWuztjXpT9QPXi4Zvgor0s2GKmumha6AxP7ZFBVSG0g3BzAMvJ0QVhpgQR6FI06id1/M/49YlmyyMEFsKTNKUJkWCoTS8NUmvtOJleiEf2fjeeksxh0YywRjess8r11/X8Pzw+WJPwG48BLT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49ljf2saGMeHE+yHQnzEON1DLcaRD15VYQp+BpxZ63M=;
 b=WT1DGBga20bmArTahxr18MAQyUzb/PMHIXc3mmznjWdZM95rp5kEKW0Z7uaaTXkDVjlJwRh3nDbNYs2tlOKtntkXE6V6nfTHabN3CY62OQXsgJ4nrmACXeWa3RLb/vQzPBb6ougqvrUwGEuQKsiFo9Pz/7odeHru7UEMHTGzGvY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5039.namprd10.prod.outlook.com (2603:10b6:5:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 14:40:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 14:40:28 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
        willy@infradead.org, dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
        martin.petersen@oracle.com, nilay@linux.ibm.com, ritesh.list@gmail.com,
        mcgrof@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
        jbongio@google.com, okiselev@amazon.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 7/7] fs: xfs: Enable buffered atomic writes
Date: Mon, 22 Apr 2024 14:39:23 +0000
Message-Id: <20240422143923.3927601-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240422143923.3927601-1-john.g.garry@oracle.com>
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:208:32e::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5039:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d443e1-91eb-4c8e-c1f6-08dc62da2782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zRM6Uv6Z0Bbq74ih3W/3ysGIBIN4YmVk4mPARry70/xVM9mZBKM6ryyylKH1?=
 =?us-ascii?Q?XSicF/ifHvH9HGRcO8CNaIw7u36Uu5ASfEND+GcuXZI13a2maJxg0sy13iQg?=
 =?us-ascii?Q?mRdB6aMpI1QegtebP5Ow0xk1mDCgD/sOrOj3/w67ZKMdKI1K65fX0QI1GCL1?=
 =?us-ascii?Q?9EwWNGqzIyEA1AeN688cUJD71ACijQl3lkrCoKvpqL23KUlAhy8Lcqw/a+W2?=
 =?us-ascii?Q?Y1Wyn1i2NI44c9/dSyCxCheG0JlwrIKnT5ivSE7TnmehVsinNx30FYCVUbgY?=
 =?us-ascii?Q?vLPay5tXG/R5RqrXXSeUfbb7pikgShGdCbM6Fq9ZP0uaD5zauSk1+XriX3S4?=
 =?us-ascii?Q?tf5/obILh6fWwujJMb3CR26oY8IuvwSI3h3xsCk664PfEWK1rpJz6WK2lUFO?=
 =?us-ascii?Q?nl75EMatCvQJKbTDf3uv1nNdrdcRcFCk/G8xUIw2jo4Z2ZAhIM0twzGHx/sq?=
 =?us-ascii?Q?eG7QBNW8qf9geDQFO8v4pBCz3B8qM2626DKSdNwfFXjYsPIhXGxfSRxz0h9D?=
 =?us-ascii?Q?Sz/09tizmxVU0vhxYnhMO2GRUckVAl4PbC6lAQZ+7hBTaZ9TNxXqe1m6dks4?=
 =?us-ascii?Q?UfCeBS6YcND85Syhg3+mFgfUiAlWCPCoWkdMXMzGKmqsgdq7630Z0W+VvXWs?=
 =?us-ascii?Q?JFNli69R+tnZn0GTB73OQqk53QQWwBCkT1UZyV/YJMHv0RMviRUCouN+aHFQ?=
 =?us-ascii?Q?eEKaQrOJrrEhS0U81BQG9Q+V8h7QwDrIKqbAL9tft1J/aHMjNrrqD70iukjP?=
 =?us-ascii?Q?809Xj8E7uS4diYGJbOuwISQsON7l3mur6DWdVyJYwhIZFMHvbx9T3k+7rUZJ?=
 =?us-ascii?Q?91E7sup6CYhJY9nsL5tyQIq14iZnhNvnviVPDopJTfFST7IyaQSG/dL+vgsf?=
 =?us-ascii?Q?Efwksi40JNVwnq+TUu+pxMRjYQ1gTwoi2onjbT02IOwDBhmMIyW/ukkERQCJ?=
 =?us-ascii?Q?vGH+pwXCUSfjbpbU8IHlScEW0NPXzlWFCik92SMqrdRU3USsb/GrnEDibLl+?=
 =?us-ascii?Q?bs6kHpV5S7TWc1g3FuVS7jomLCeCAzrqkLxAi+mt5NGHZo1SUv2oz97kVc8J?=
 =?us-ascii?Q?/DyShQB2yy/cTC6YZqyr2dwhTyiDEeebsZABnshSghyY+H6ffjCzVLM+qWEs?=
 =?us-ascii?Q?tlyIkaWthRERbrsVqryI/0m5Z+vAoaMofMx24Sud0Wj9WhCYDZZju5zlblkV?=
 =?us-ascii?Q?BubkepMUtD5hgn1Z2j/KJIdVrcpbaLivaPW67v/bkfI9nxCL9TUgKCOHHKqL?=
 =?us-ascii?Q?o0CRsyYDd3GgyBH5K5w2z2n8xKjde1FUpVhm3IOyXDEAq5LcCebmiI9DpqyI?=
 =?us-ascii?Q?hpz3zCV/ozxTyERWEmItZOV9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?j8HHgEdiSA2uEdNWPYI7AzOiNe/HFJRgm4+2FmnKEFr1gHes7jCNAAh1ZgJQ?=
 =?us-ascii?Q?KXpCypjON8AkZBamQn4MXqeD5BU+JU5Zxv2V0jlJheVlwTvNHMF9u8z3GPj8?=
 =?us-ascii?Q?jbTCctwfLZdz1pQUtBi8F3vB/Y2HN+oL3a5AVMJG88OUV+GtO0BkyWGABzdn?=
 =?us-ascii?Q?21r6pT4QiCRwoRLOqw1K7nUS+TBQLepSTG4YyqYCT8MMQH8g5bffaqqDGFaZ?=
 =?us-ascii?Q?Db4J0/vNTv+cUIO6Z58kuuUH7jKO41yTRLE1RYIg99+kEgivQkBmwiJm+WZl?=
 =?us-ascii?Q?M0Fs8NMymzOZECuh8xxgsof6cWSas6bROCQQndxku1xA3YGxAUjXu5BWiRUU?=
 =?us-ascii?Q?f8qaODJ3Q/7gv9ftqjJs36teVucWjcygaVI1tcEnXJAHq01pzbPiyL9/rGPb?=
 =?us-ascii?Q?6G0HjCXT/wNCA4pSYqhSpZepTju5iUuuqgKipiuYEz8uw/9O+DxvTzW1NWjw?=
 =?us-ascii?Q?2gE6KcttFVLxhVcGL2Mqc1DjG1awAEtF+IpZpomeSzIyuol7+yEAUcbZ5Dwy?=
 =?us-ascii?Q?gAP7PgvyDzpALGQRZgPJ1Cs0sC79ctVm7gaPiggi6GAV8A4hfSPEYqzISk4p?=
 =?us-ascii?Q?FiOTXVxM/Ijswaso6e4Lr0pKinLB51vRCsOEoNVkIHuxm4yKv60XVx0FddzS?=
 =?us-ascii?Q?7xpOfNvUwRKEXEPz8qnDt9643UdLjUh7//r1fwTCSstjeFLB+adUMkk+13vW?=
 =?us-ascii?Q?Wot98OGLVWqgULcmIJIUFjwo7mTRbVFOwMyaEgzvMBICrZ9krTTQY86K3bZ8?=
 =?us-ascii?Q?Pe7d+uP5+FyVk1g85wNJHJ120nWYkgDrHpznbPJdcjzhgA9BXNLsHB0lVvtS?=
 =?us-ascii?Q?jB7cmJ9ql4tmDsDtaNYO+ZHkbQPNe95QAtxrWtYBasNOOTQMeLNDuaUkbjsN?=
 =?us-ascii?Q?bWIKCLzAh5UaxipuphjYtgqk3CoUWSoyc/yk+LdsLFDHpSHhAthDMKB5JcAl?=
 =?us-ascii?Q?4cXt1Y40T7Jx8RY3PNxKnmENNIljeyUBdp3cKDkjVMTry7Vi7pK2gpaLWrrl?=
 =?us-ascii?Q?WeTYmz6ddP21YjsdTJvfk7/okccjnVlwG06qGSoSsVaadYCOvBiT982yga2Z?=
 =?us-ascii?Q?dxFVSXpy7FFulKp/xIAtHqtniHvdaCVKwMIwtueRskYuntt/D5ba3k77N2yb?=
 =?us-ascii?Q?mrNDbSPBV3SSj2X6fYbYLCBtZwBaB8IZU293B9tJY3NMBzWVo4ao/3/wJ2zU?=
 =?us-ascii?Q?WVkMl0p068TJ+S0un/16Z9wpBkMmvp3aNK8XGw8eH3aLP22MqRSCmx5M9N8h?=
 =?us-ascii?Q?H0CW9tbSZGyWtmRr698LLZxgFcGCEaXAoBQok3IWgl0Iogs16lHlYVOauB8z?=
 =?us-ascii?Q?MAN7oh6q61X7aePIJ+Wsup4bMtKw70fcD5JWeqPbTSOfvSbFFVEHz9hCevBj?=
 =?us-ascii?Q?AJtkAIr7/HHiVHN8Wso60plbPG49MsPNPDSuePIZBbVEb1ryPIbc9lvpW7dR?=
 =?us-ascii?Q?Er9isl+4BsZWJu47jJXqRIbUIYOHIKwOAJTC+NJ/KFbJvyjUvWs7ENC4lMqk?=
 =?us-ascii?Q?i7UWQgt72pekon5JK73F0rcxoF45lKd+z2GfCQTn0gMhVEWw9J4jPLWOCvyw?=
 =?us-ascii?Q?ha372VcJ8xrRvwBpljj9rXy9yii8YLm4UJGFTTnCQvTORcSpvDEmRWoJakg2?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Vq9UCMnHatsSovFh/02kR1sW3LEwM0TVCcjeS1ya+LO54JVVOCipjDDtwk7SKFlpwqatZa0UY4391uZW98OwIaCl0prCxubO1FwaF3zlRdrHal10xmrgbWOcXZ01lghBe2sj1pOI8gjXxoHhVLnjDFKsZR4n4nQY1tsJwvFXN5sGpa497uyPzWe5NpY1HSRLE+0CCwKn2/5raUJEug2sQWU2Q0Dzoimpc5egrS72yjMmKB4gzRGirtSyyKJFCYjeRRlpwRkPlTXdX2ni/qU/J0fw98/HpkDdsCRT5JdSM3IfsvlYVRTF7rRs484TVH/oxPgFQJZZswWkZeYTQI4EXCqFXnlHwU2Vgn5e2YkDZ3KMpbOQzjICDzneBHyPcIbDZkcOT/4F2nP7cWPJsjICmZ29Z3ko/mfyKEAVwww7gKMaSazzM2cJ9okpGmTDKhBCu4nWriD5GVinjS+VLZM8PaZaLeXSeUOIgHx1QacrONnxnYJ1w5nERanZq5OtDuAK1EAc111WCPVSQ+gOCgvQwtwB/ceONV8zoKpU/p+aONZBFih/WJ5dHL2ZOIeoO/sKjVzgZo03Zi3xo9TFAIXlj6jqmr5DHINP5MgGx/PbubA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d443e1-91eb-4c8e-c1f6-08dc62da2782
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 14:40:28.6172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3jiSkxdK314/w4cZby3Ijx7FD0P/gFuT+xmfpc9aut0a3V9sx75UN2cOvvqJrNFTZ8UzJzhZNEyCA/smRpLVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220063
X-Proofpoint-ORIG-GUID: Z_U_9O15snWMq5vMoQPfL_7A70juNBRI
X-Proofpoint-GUID: Z_U_9O15snWMq5vMoQPfL_7A70juNBRI

Enable support for buffered atomic writes, in addition to already
supported direct IO atomic writes.

The folio mapping order min and max is set to this same size for an inode
with FS_XFLAG_ATOMICWRITES set. That size is the extent alignment size.

Atomic writes support depends on forcealign. For forcealign, extent sizes
need to be a power-of-2 and naturally aligned, and this matches folios
nicely.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_inode_buf.c |  8 ++++++++
 fs/xfs/xfs_file.c             | 12 ++++++++++--
 fs/xfs/xfs_ioctl.c            |  3 +++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_inode_buf.c b/fs/xfs/libxfs/xfs_inode_buf.c
index abaef1137b97..38e058756b1e 100644
--- a/fs/xfs/libxfs/xfs_inode_buf.c
+++ b/fs/xfs/libxfs/xfs_inode_buf.c
@@ -181,6 +181,7 @@ xfs_inode_from_disk(
 	struct inode		*inode = VFS_I(ip);
 	int			error;
 	xfs_failaddr_t		fa;
+	struct xfs_mount	*mp = ip->i_mount;
 
 	ASSERT(ip->i_cowfp == NULL);
 
@@ -261,6 +262,13 @@ xfs_inode_from_disk(
 	}
 	if (xfs_is_reflink_inode(ip))
 		xfs_ifork_init_cow(ip);
+
+	if (xfs_inode_atomicwrites(ip)) {
+		unsigned int folio_order = ffs(XFS_B_TO_FSB(mp, ip->i_extsize)) - 1;
+
+		mapping_set_folio_orders(VFS_I(ip)->i_mapping, folio_order, folio_order);
+	}
+
 	return 0;
 
 out_destroy_data_fork:
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2fbefd60d753..d35869b5e4ce 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -782,6 +782,16 @@ xfs_file_buffered_write(
 	ssize_t			ret;
 	bool			cleared_space = false;
 	unsigned int		iolock;
+	struct xfs_mount	*mp = ip->i_mount;
+
+	if (iocb->ki_flags & IOCB_ATOMIC) {
+		unsigned int extsz_bytes = XFS_FSB_TO_B(mp, ip->i_extsize);
+
+		if (!generic_atomic_write_valid_size(iocb->ki_pos, from,
+			extsz_bytes, extsz_bytes)) {
+			return -EINVAL;
+		}
+	}
 
 write_retry:
 	iolock = XFS_IOLOCK_EXCL;
@@ -1241,8 +1251,6 @@ static bool xfs_file_open_can_atomicwrite(
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 
-	if (!(file->f_flags & O_DIRECT))
-		return false;
 
 	if (!xfs_inode_atomicwrites(ip))
 		return false;
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d115f2601921..d6b146c999f6 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1169,10 +1169,13 @@ xfs_ioctl_setattr_xflags(
 	}
 
 	if (atomic_writes) {
+		unsigned int folio_order = ffs(XFS_B_TO_FSB(mp, fa->fsx_extsize)) - 1;
+
 		if (!xfs_has_atomicwrites(mp))
 			return -EINVAL;
 		if (!(fa->fsx_xflags & FS_XFLAG_FORCEALIGN))
 			return -EINVAL;
+		mapping_set_folio_orders(VFS_I(ip)->i_mapping, folio_order, folio_order);
 	}
 
 	ip->i_diflags = xfs_flags2diflags(ip, fa->fsx_xflags);
-- 
2.31.1


