Return-Path: <linux-fsdevel+bounces-20932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63ED98FAED6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 863811C210D1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B13814386D;
	Tue,  4 Jun 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m7b1vL+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AFD13B5A2
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493472; cv=fail; b=TzRllpQPPjIFD0TX/pYpE3VnvBI8r7AwwwmhTJxK/R9Fc356s60pUOXFDOLo0rw58iwwC9Oc9QZLj+kacAs86CQHQS0qlGr3zjNoHS+nF/qmtxAiX1DWStw41d2htIPY547P/OfI4RJ6TSd9QizgpjnVS+HiolobUIJqFv5Udb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493472; c=relaxed/simple;
	bh=E0aCIbaDsymCBshJc30JngCnNeqQMjV1GrooFQYPZZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jwugP5VaY3cycup1CmIGxg+NLDz4hgtNotRZ9Drwt61rGI2JTKtFGHWd44EmautacMBkigVSpnHaXdoGKAfWN9HELFGjG44ggcFXbOSZekf/66AnDrnbYRxxyN4EAnWlbePbjq/oMC2AkjMNgrGvPMl4c2rR7cMd9x0FyeWHVts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m7b1vL+a; arc=fail smtp.client-ip=40.107.223.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZABPXpBKfXIgbCrofc7TZrdvCPOWnGoag6hA+b2SV4e31Z8NKDtYI68eDJXGTc8nloJajhjlBs/Iv8F+2xDYPEhBbzXGUJokdHskQ7iYHNCnnwVIRXqLVf5+0V4XqFRTQRABHzDGNM7B7cC7HUaFnqHyf2KvQBMzr+N7NhX5kdyRjulEFpYLngnwSzFkBLYrtPLSyjeX7TM7j8ZjtYESHO9buLhDgYJ+ZPH2tgvox7ocgPBLN9JxVGQD5n8JtPfpg/5fxA8eZz/3Einy+55Oc8rSn9+Gtyp2pne08X8+7zi0RHQZWAInxCCqIr4Okbhb5CyseScR7Kpfzz6IVHkG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0aCIbaDsymCBshJc30JngCnNeqQMjV1GrooFQYPZZ4=;
 b=DmKMPyIMRqsIS1GaqDItRsXIo53MSoefODYNDXg1owQwe2Sxib1cQxZisAx5SIP3osPUCjwQCAsClMS2Kqxjuigt++p63h/xNG/B+lJcCdxD2VnU/EjhYYUacQ3VRrREShfGZrAWk9FopNl/jYBIRIf0kqBcib4j9Otj9w+R4iAlTpohCSILVCA0MotONUVcaRL5XNwN3tuM8FrQT8dA91uUdOneBxD1hT57pNJjRkyYE+DuohoT5U/aY4vdYEF8uTJcrmtbg172R8HAQjoEq+7UcgKfsT+5rWDCtg9Exi30/ejI9qFnXlqeDDItpXZTZ29o7exHdU5RRpEm1S2mrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0aCIbaDsymCBshJc30JngCnNeqQMjV1GrooFQYPZZ4=;
 b=m7b1vL+aMq8EHdIc2asBKYHGkaqdHyF0oKi3AFxvt85ht9DvFqAF2//2g+7RosxCWiOf2Pb7BIJQ+j4rZsPeYftFV7KxmMQmlc1P2dkSxjlEJjYPmzbS+mBltmi7WOjBobAk3rmhDRBR7T5mGRQmirZiZDIedlTdvbVYtB4G51717DbInESmN9x33opNYp1NmSrJ/4YDfgrgWI63TyjggCQ9N7FB7cFTi9E62uWEtU4aiuLvYIq33GY+lV+oaT5C8wdAo3W2VI+OqHAf4RuGfWGHcBqFjdmCAU2guJ5+PJl+8yxSE53Ogfakvt4vrd6VR10IH3IvPqbBxtezksXBig==
Received: from SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 09:31:07 +0000
Received: from SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19]) by SN7PR12MB7833.namprd12.prod.outlook.com
 ([fe80::6f09:43ac:d28:b19%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 09:31:07 +0000
From: Peter-Jan Gootzen <pgootzen@nvidia.com>
To: "miklos@szeredi.hu" <miklos@szeredi.hu>
CC: Idan Zach <izach@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"stefanha@redhat.com" <stefanha@redhat.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>, Oren Duer <oren@nvidia.com>, Yoray Zack
	<yorayz@nvidia.com>, "mszeredi@redhat.com" <mszeredi@redhat.com>,
	"angus.chen@jaguarmicro.com" <angus.chen@jaguarmicro.com>,
	"bin.yang@jaguarmicro.com" <bin.yang@jaguarmicro.com>, Eliav Bar-Ilan
	<eliavb@nvidia.com>, "mst@redhat.com" <mst@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"lege.wang@jaguarmicro.com" <lege.wang@jaguarmicro.com>
Subject: Re: Addressing architectural differences between FUSE driver and fs -
 Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Topic: Addressing architectural differences between FUSE driver and fs
 - Re: virtio-fs tests between host(x86) and dpu(arm64)
Thread-Index:
 AdqybnzAiozTvtlkQFaloMBVG2WGpwDHcmEAAADKEAAAAQAmgAAAdzaAAAm2tYAAAoHLAAABHCqAACK6xwAAAOV6AAAAntkAAADMmIAAAFipAAAAbt4A
Date: Tue, 4 Jun 2024 09:31:07 +0000
Message-ID: <8c28a7f83f66a30de13380c9b5f48b64d7c7c17f.camel@nvidia.com>
References:
 <SI2PR06MB53852C83901A0DDE55624063FFF32@SI2PR06MB5385.apcprd06.prod.outlook.com>
	 <b55cb50b3ecf8d6132f8633ce346b6adc159b38c.camel@nvidia.com>
	 <CAJfpegsppbYbbLaECO+K2xpg8v0XZaQKFRZRTj=gJc9p7swdvQ@mail.gmail.com>
	 <bbf427150d16122da9dd2a8ebec0ab1c9a758b56.camel@nvidia.com>
	 <CAJfpegshNFmJ-LVfRQW0YxNyWGyMMOmzLAoH65DLg4JxwBYyAA@mail.gmail.com>
	 <20240603134427.GA1680150@fedora.redhat.com>
	 <CAOssrKfw4MKbGu=dXAdT=R3_2RX6uGUUVS+NEZp0fcfiNwyDWw@mail.gmail.com>
	 <20240603152801.GA1688749@fedora.redhat.com>
	 <CAJfpegsr7hW1ryaZXFbA+njQQyoXgQ_H-wX-13n=YF86Bs7LxA@mail.gmail.com>
	 <bc4bb938b875ef8931d42030ae85220c9763154f.camel@nvidia.com>
	 <CAJfpegshpJ3=hXuxpeq79MuBv_E-MPpPb3GVg3oEP3p5t=VAZQ@mail.gmail.com>
	 <464c42bc3711332c5f50a562d99eb8353ef24acb.camel@nvidia.com>
	 <CAJfpegu3kwv9y1+Yz=Ad_eJt7-fNJbxgJ8m2_B=Su+Lg6EskGQ@mail.gmail.com>
In-Reply-To:
 <CAJfpegu3kwv9y1+Yz=Ad_eJt7-fNJbxgJ8m2_B=Su+Lg6EskGQ@mail.gmail.com>
Reply-To: Peter-Jan Gootzen <pgootzen@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7833:EE_|DM6PR12MB4267:EE_
x-ms-office365-filtering-correlation-id: e47e14ea-b1ea-44bb-6af0-08dc84790fd6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjF1a3NzN1NvR2Q3TkVwK3NYY1o3TE9USlBULzhQbTluZWxCN1g0UkVCc0xS?=
 =?utf-8?B?RWJKQWpJMTBaMGZ1ZklCbzRqR0Z6V2hNMi9reGFyU0Rzc0ZnbmtUcURKbmh5?=
 =?utf-8?B?cStCTjVYUm1JUitTejNFMEE0WXlDMkpCbDVBVFU4V3dsZzdFU0VFYWEvc3Qr?=
 =?utf-8?B?VWNJSEw2OXA0M0NaTUYrQXkvL3VNTy84MFgzblhXU3k4bSs4RXJOLzFzdjky?=
 =?utf-8?B?THJRWmNERmR6dVlxb2tnSWpzbWprcWpscnh1T01taFpHb2lxeVJpcFlrdi85?=
 =?utf-8?B?dnIwbDdmRXhnUDMxT0UyU1gyWTJKdGNjZjlReCtnc2tJMzA0NGpocExmVHZQ?=
 =?utf-8?B?SndHV29FSHpFTUZpeE1nN1pUT21nblMxaE5VMXNpa1FpSUJQaWg4MDV1NXh5?=
 =?utf-8?B?UGdFTkFoa2R1UW0vZVJpbnoyNHd4MUppbTgrUGtwRlZ2ejE0VVo2bGt1dnNQ?=
 =?utf-8?B?QU1DTFJGanE0SW5zeFEwQzROUlluUzhYT25NZlB0cWxKcW9MQ1lhR2VJL1FL?=
 =?utf-8?B?VHhOY2RlTnhjeksxa3pqdy9JaW5TMTIwN3o1RjNXOU9EMDgwNFRpdUNJd3Bp?=
 =?utf-8?B?azZTNVFZMm00aWVmTHJzKzFvaFgxbDlkNUZ6Sm1QOGJsVzdlVWJldnZFTk9o?=
 =?utf-8?B?UjJuSGdwV1BJR0M2d0FnOVRxcmxzbng0VWphZlZ3YlNINFRtU05YbXJoNDRH?=
 =?utf-8?B?QldaU2IzbUx6N0tzMlM1Y2I4U0pQdFdyTGZnVXM3a2ZqOGNXWFEraTZtNHhJ?=
 =?utf-8?B?d0RkR3FOQ24rT3d0MWNYT2kwL3VjT1ZhZEVlM2c0TGUrQ2UwcnUzT2l3WTgy?=
 =?utf-8?B?NDlTWndOOUwybDgxYnFwaS9pem9yNDFGNUhtdHZpYm5iMUo2cmpWUzQrOVg2?=
 =?utf-8?B?d0VYMGdUeGI2TEZxcHZ1WWFKekRkSzRXbnNUeldVN0RrUmRleXpiVzVMMElX?=
 =?utf-8?B?SUcwZFZSRyt3YTJreU91elo0YnkvN1VBNnZLMlVjNSsxQmY4YmxaRGpvQnlR?=
 =?utf-8?B?YWw0emdVQjM5MUgwd3BCaWZuZW1zZGs4L0gwVGwzTFpORFdqS21tKzRXaE8y?=
 =?utf-8?B?dkZEY3dRbTQ0blh0aVhDTk1CZTZuYjBmQWRqaGxuUHltem9BeFhFSm1tWlVv?=
 =?utf-8?B?aDRMWHROSzlDbHIrZW5rcUNmUnNqSEdhbW9QMW5IODBEV3duQngxNjBYQm5v?=
 =?utf-8?B?Qy9VRGZPZ25udFpQeGFzbDJFM1krazRiS0dRZGlSdC9vdVgvZFZLZ2sxdVBV?=
 =?utf-8?B?RmZsQ2poclA0TUo1anNXcDlkUE8vSHFUazFTV0JkMzh3MmlvSHpNZHdDdVEv?=
 =?utf-8?B?ZWpmdFRmR3RuaDJ6SklsVWlSc1E4TC93MTRiKzVVUm44VnB5eDAvWFBhdHBX?=
 =?utf-8?B?TE9jVnFXdjJBYmc5VjlKalNpYjhERS8wVHpUVk9OR2xIbHNmQ3Rranp4Y2kr?=
 =?utf-8?B?eHNWR0I0K2dVNFZsTlRwa1ovRGF4TnpVN0dIbHNLbjc2dnlYc29LKzZhUUps?=
 =?utf-8?B?cmxKdVNOTEIyaE1BOHZqY3V2S3pBaUR1djVncnFWYnNGSEhJc21qN0R5dmEz?=
 =?utf-8?B?akdxR254eXlnYkpxWVBrdmhteFcwb0ZRMUlSWGVVa004MEpaN3VpK2lxNUQr?=
 =?utf-8?B?dXgxdDNkTnRKYTU5b0xDREFmcjFLQkh5QkM4YmZKNWQwZFJDdTUxQ0RFVUx2?=
 =?utf-8?B?YUdrR2dIYzZnaWtkaFBSdWNvTVFmNm4yR0FqSU1BaityRlpOSE5LS1VFTkh1?=
 =?utf-8?B?cGZNbHNBSk1TTjdJaDdzbm1uQ0NOVlJ2VENPTGdnVzB0RU5ManJjR3o2NnV6?=
 =?utf-8?Q?H8+typUdtmL8MlqSV/ug1EXJ5wI0IFzsKWW90=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7833.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUNwMXA3bDNlRmltUWthVHNzcEhHUjRUMWNtNkY5MmdJdVdLVWhXSG8ydXpC?=
 =?utf-8?B?M1RKZzF2SkllZjhUczlWaEU0UzRFWTR5Q05zU1gxNmxHb2JmNEJIdlVPVXgz?=
 =?utf-8?B?KzliWnl2dWpsL2JxdGNDK0pKVVNkRHVRQVNsTHkzajZWV2ZSNjZibHBQVzRC?=
 =?utf-8?B?bDBjR3pkeEVOSkErc2VZZDVyQVRBcjRLZXZjUmp1amZ3cG10VExkT1hEMzNT?=
 =?utf-8?B?ZldPenZwR0VGTGxxUHFoazhubVVtWGdyeXFqcU5hNGVuWHlLV1plRkpUSDBY?=
 =?utf-8?B?eXJ5ajlSYmFJTVdVVkgrbjRnY1QyS2VIaldKbWVoODhoU1YwMGR0U2xOb1g5?=
 =?utf-8?B?S0RFSk1LVVN0ZjJUWXdSMWFGYVBLWFAyRXNhZEV2SlM4VkNUNEJqUUdNZ05l?=
 =?utf-8?B?VVJ0Skpha203a1hJMkw3RG8xMURIUE1FVEtDN1FxWkNGWGk3VGJ5RlQ0NExu?=
 =?utf-8?B?YklLOFByNGtqazZDbXREZGNYbG9acHZvNUFLMjI1a3g5bmsrQjdmRXlDV2tj?=
 =?utf-8?B?OWNJcTQ5amRWeXI2Q205cWdnbWFKeUdOM0hvRzJQb2czdHg0V3BZSUxDOWty?=
 =?utf-8?B?TXoySWpoTWJzOXNSWUpwcFNXNHFRdFNESmhPNW02TzQzSW5PSGZoaHZhMjhK?=
 =?utf-8?B?Qkt6UXgrY2ZqWS9TWnVwakx5cXdmL2hsOWhsVWhZZmhqcTBXZmMza1JmRFZL?=
 =?utf-8?B?NXljNk9pTUpLS1pITkNOVXMwUTlYL3A1S2xMVGt0eXFrUTJMZG1GQ29BbTh0?=
 =?utf-8?B?R1RRL0h1Yjh1Uk5zNXBlbDdaYXhnOW9wNFY5aVRLdXhaa2lkci9ocWRYYUxj?=
 =?utf-8?B?cWJSaW8ycS90cWtrRVREdEI1TmxvVlVwTnZ2N250WGFUZUlXMElZcXZaamI5?=
 =?utf-8?B?dEdGcnNobC9YK1FaR0VrQXZCQ2N6M2xIRjhPbTlyK3pmaEF2c0FadFd1amJk?=
 =?utf-8?B?WXp0YmV3MitzSmkyK1kybXQ4NFJ3a2ptYzMyTUZ6WkFyQjhvYURFTWxKL05X?=
 =?utf-8?B?azNSOXVRaVdoME9kTklRMlJETW1lZ0xvMVZ5ZEVvbUlYNFVNMGJSS3JOVkpx?=
 =?utf-8?B?TVQ4eGYyQ1RtbkEyTVZYRmNJSkZ0WDFvQkM0S1hjRStSNkxCRmV4RjArdmRk?=
 =?utf-8?B?bTkyQ1pKL0NleWJOY2ExaWt0NmtNYUVyWm5rczh3UjlRWVdzc2djeGhXb1Y3?=
 =?utf-8?B?VW1UZmZYZUpDSVNDUUZMa3BkNkk1UzdzOXR0dXI1R2ttWVNGSDAyTStHazVO?=
 =?utf-8?B?Y1FJdy9iU3BFSW4vVk50UXdoYlZMcGthQUt6TXBMOXB6SUJZb2hWd29uTE15?=
 =?utf-8?B?V2c3bTl6bnMrWWQwVm9NVm9UNDlIN0hlTlpQSGtVdTM0Ni9XSXJhZ3RpV3VS?=
 =?utf-8?B?RFdtU2g0UDdWVkJSUmN6dXp2YlpLMHF0VlNTZTluYWpRa3pIMnBtNXliVlJJ?=
 =?utf-8?B?cm5PTmduWENNWkprMUYvN0ZydkVZNE16YUxlUTVYc0hDK0xtVU1IazdoSEJq?=
 =?utf-8?B?T2xoRVliYjhiUWdIdlVFblRIY2RYSnIyckIwY05BanFVWS92d2lQNlRmV3Zj?=
 =?utf-8?B?K1NybGRPYTFOQkhNalMvVVljSDFhY2hZS3B3OXcvNmNQK2NRcTNFT2NWZEk5?=
 =?utf-8?B?OStzZk9iQlJ0cDdSdnl3ZHZtZnRyNnZmcjFFc0srYS9yUDdTTThBQTRxSXRC?=
 =?utf-8?B?RXR5a0JyTENwRnhqa05PMS8zc00vNW1hZThJbHA3VW5BUWM5Ynp6TjVGQ0xW?=
 =?utf-8?B?UzJ6S3crRUY4WjViR3Q5QW83cHdlb2ZyMy95UHFncVhMNWtKM201cm1DdnNw?=
 =?utf-8?B?STNnM0Q3Z1EwOEIwWldZeFYyZW5DTnM0ZGhhVXNTQTdUTWxRWHU1RENSb3lp?=
 =?utf-8?B?cTdLbTE4bTRzRE9wWjdsMjBzYlBORFNMVFdudmpqZGUrTVg3MWpheUd3Mjlp?=
 =?utf-8?B?MGNTMEdoa3lNbmtRM1pXYmxoYVlTUnB3aDRQSWRTS2JtTk9tOU1ZODRicWNn?=
 =?utf-8?B?L3hmODd5Z3l3aDJCNGEvZ2FobmRFL3NYeDUyRlJqb0UxY0E1Z3JhcnV0cTFh?=
 =?utf-8?B?TTZIeHhRd3hQTHBpK3dWNXlsbms4NEhIMVZvV1Q5TXFTTUxZQ09GY3NVckJE?=
 =?utf-8?B?cm1ScFl0azhxa2pEU1lhQytJa1lnM1E4Nkk3eS9McFlOUzRtenZLVURyckhE?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B28BD449C20914A80C0EADA0FE1E455@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47e14ea-b1ea-44bb-6af0-08dc84790fd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 09:31:07.0916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G55FWu/5tY7zVNKOf3xxMI/Q9KY3CHe5mWSWOM6DVhqJbd/fStGig7o1koGSZg6q+S721riG3ALxZZzdTCP4zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267

T24gVHVlLCAyMDI0LTA2LTA0IGF0IDExOjE4ICswMjAwLCBNaWtsb3MgU3plcmVkaSB3cm90ZToN
Cj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVu
dHMNCj4gDQo+IA0KPiBPbiBUdWUsIDQgSnVuIDIwMjQgYXQgMTE6MDgsIFBldGVyLUphbiBHb290
emVuIDxwZ29vdHplbkBudmlkaWEuY29tPg0KPiB3cm90ZToNCj4gDQo+ID4gT3B0aW9uIDIgaXMg
ZGV0ZWN0YWJsZSBpZiBmdXNlX2luaXRfb3V0Lm1pbm9yIDwgQ0FOT05fQVJDSF9NSU5PUiwNCj4g
PiBub3QNCj4gPiBzdXJlIHlldCB3aGF0IHdlIGNvdWxkIGRvIHdpdGggdGhhdCBrbm93bGVkZ2Ug
KG1heWJlIHVzZWZ1bCBpbiBlcnJvcg0KPiA+IGxvZ2dpbmc/KS4NCj4gDQo+IFVzaW5nIHRoZSB2
ZXJzaW9uIGZvciBmZWF0dXJlIGRldGVjdGlvbiBicmVha3MgaWYgYSBmZWF0dXJlIGlzDQo+IGJh
Y2twb3J0ZWQuwqAgU28gdGhpcyBtZXRob2QgaGFzIGJlZW4gZGVwcmVjYXRlZCBhbmQgbm90IHVz
ZWQgb24gbmV3DQo+IGZlYXR1cmVzLg0KT2ggdGhhdCBpcyB2ZXJ5IGdvb2QgdG8ga25vdy4gU28g
Zm9yIG5ldyBmZWF0dXJlcywgZmVhdHVyZSBkZXRlY3Rpb24gaXMNCm9ubHkgZG9uZSB0aHJvdWdo
IHRoZSBmbGFncz8NCg0KSWYgc28sIHRoZW4gaW4gdGhpcyBjYXNlIChhbmQgY29ycmVjdCBtZSBp
ZiBJJ20gd3JvbmcpLA0KaWYgdGhlIGNsaWVudCBkb2Vzbid0IHNldCB0aGUgRlVTRV9DQU5PTl9B
UkNIIGZsYWcsIHRoZSBzZXJ2ZXIvZGV2aWNlDQpzaG91bGQgbm90IHJlYWQgdGhlIGFyY2hfaWQu
DQpJZiB0aGUgc2VydmVyIGRvZXNuJ3Qgc2V0IHRoZSBGVVNFX0NBTk9OX0FSQ0ggZmxhZywgdGhl
biB0aGUgY2xpZW50DQpzaG91bGQgYXNzdW1lIHRoYXQgdGhlIHNlcnZlciBoYXMgdGhlIHNhbWUg
YXJjaC4gQmVjYXVzZSBpdCBjb3VsZCBiZQ0KZWl0aGVyIHRoZSBzYW1lIGFyY2gsIG9yIG5vdCBz
dXBwb3J0IHRoaXMgbmV3IGZlYXR1cmUgeWV0IHdoaWxlIGJlaW5nIGENCmRpZmZlcmVudCBhcmNo
Lg0KDQpBcyB0aGlzIGlzIGluIHNvbWUgc2Vuc2UgYSBidWctZml4IGZvciBjZXJ0YWluIHN5c3Rl
bXMsIHdvdWxkIHRoaXMgbmV3DQpmZWF0dXJlIHF1YWxpZnkgZm9yIGJhY2twb3J0aW5nPw0KDQot
IFBldGVyLUphbg0KDQo=

