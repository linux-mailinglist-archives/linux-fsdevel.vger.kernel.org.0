Return-Path: <linux-fsdevel+bounces-56050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CBEB1231B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 19:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DBF25A229F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214992EFD9D;
	Fri, 25 Jul 2025 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YbnygLmP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98022EFD88
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 17:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753465381; cv=fail; b=L47F7Zi0npyZfFyrqY5DHC5roEfOuh3mrKvnTJHQmn5zIradRkFMZ9T/bzyWy62HIHYxFwpjTUvcoItZ7j/XLch6uoG334D55qrWOds3QgfvSOBIr9Kpbm7D6sE+x82HiHgot+1uftujnISYhw2B/kBZpnua1ckccxZgQQs5l1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753465381; c=relaxed/simple;
	bh=ej9ZyMxUdxIu0cJyI+Wdt2FVsWtOZ6W/ThI4kJzHbbA=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=RVs3aCRpeL8+ae9U3r764o6LjvQ4FaSvsAhRvUOViocb/ZsRoQxMElhlxbfL3/+Y1KOVg2aeMi+JEkHTLc5+ilTlbIA1MkoGPz/CalJVOGYRKNuhq0us4nVBBwV4UOv8SynAogeHR0L7qztvV2sm+s1xM2MOdUW9cpn5KWA2dPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YbnygLmP; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56PBBWLO024224
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 17:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=pmMQhVD4IXkqaoJtrsTfymf63FJcdBfJUF6+MEs8kLQ=; b=YbnygLmP
	Zkxah1hqbJ0XfhjNa6yr75SAegRhrTiDkWSKUcYQ0odkU6V9vAOG7mILVmymNErs
	bhtQbgILYOdxvDf6gaRRQ5AT1fbmnc+HnnSffOQpMt3yfZuaY998nrvpHgF65l7C
	u4bLCvdbeDxyJMCMHqC76lxqOoI7onv425AaOndoBbTmXK5AAHye2oe4C2/cfHvT
	qn3QTsUzAwApVapOfqvu8AzlfXsXJIEcXA2bLgADXGKyhcQV+XCe7Qn6TkB4E9yL
	UKzaexrGwnUTT6DrGZwIN0gGcdQaLosAVYG4dK3Ewm/ibs4Pvs1iEKV8tJYgu9k8
	4FSLkv4zzDoIzg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wchvcjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 17:42:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56PHgwIp011637
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 17:42:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 483wchvcja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 17:42:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1II0B1TFYmfqCZfeALCoGfJVP3cc0Vw7A7Cfhiq2gc5sWhr8KO41DYeJsW3wdDnMoNNF9rV7W57bVMQ7v0h4yciHjuPYuW2Q3tGy7H5bZ+jcOfU3lWFBekOf4MqgqVD3G4es0o7tisYVyKx/zGEkb8QfWfc39ioQcIa+B7NWVcx7+XTWwuLpKCOSk3rvVclwXAaUhkGUo/ExlOM3SisDhnEU8tqAQhZkl1JY0erPmFntRctCyS12w7PajVNYMfLaaucjBxpMOxFFe7EptfgHEmGG9FQ61pvAHHG2uAwHe7E9kZ+lNtPV6GISE2NHUMCH+aneIxBxohh6NDK48ghFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4Vm8nlowfJtjbYPP2hzxdpwLeN1XyDpjYHq8GhoTjI=;
 b=XGnb7RmAKalgVh2dILcrQc3gZVIYXQyNBhAP0ZenhBGlq+s/AjkMSGG4LEGcOIbn7FENv9qgZrdrA6F5T9Ph8j1dr1hKxWin+2793uzZvA5/zIn3gG4ntVCw51r6kk28lrTk9bzAa7XaolacDG+pdL/OggxGpi30eVhO/zx+0OpJO1IJj8Sxv56n96/UkHsJksGt2dtn9WDEM/EULjabP09oDm+Jryz6Edv03mROQl1ZqVwKgqtnT+IGFDF/aDGDaQRrprovVKB8EdIuQ9EHXUfDoq/Wa3xPLoumKCb3TH/14Bgowt5RYu5rGZ7ZpLoiD+9M90+7x/z8jLh4S7fZhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DM6PR15MB3765.namprd15.prod.outlook.com (2603:10b6:5:294::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 25 Jul
 2025 17:42:55 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8880.026; Fri, 25 Jul 2025
 17:42:55 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "penguin-kernel@I-love.SAKURA.ne.jp" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "willy@infradead.org" <willy@infradead.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
Thread-Index:
 AQHb91IJ4dXLt/uuZkqRbEGinlBUibQ2uTqAgAAmwgCABfRaAIABJ7GAgAAu4ICAAAmKAIAABPwAgAA/FgCAAHUJgIAAE2cAgAENGoCAAAaQAIAAzLAAgADYSYCAACXrAIABSPWA
Date: Fri, 25 Jul 2025 17:42:55 +0000
Message-ID: <2103722d0e10bbd71ad6f93550668cea717381bc.camel@ibm.com>
References: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
	 <954d2bfa-f70b-426b-9d3d-f709c6b229c0@I-love.SAKURA.ne.jp>
	 <aHlQkTHYxnZ1wrhF@casper.infradead.org>
	 <5684510c160d08680f4c35b2f70881edc53e83aa.camel@ibm.com>
	 <93338c04-75d4-474e-b2d9-c3ae6057db96@I-love.SAKURA.ne.jp>
	 <b601d17a38a335afbe1398fc7248e4ec878cc1c6.camel@ibm.com>
	 <38d8f48e-47c3-4d67-9caa-498f3b47004f@I-love.SAKURA.ne.jp>
	 <aH-SbYUKE1Ydb-tJ@casper.infradead.org>
	 <8333cf5e-a9cc-4b56-8b06-9b55b95e97db@I-love.SAKURA.ne.jp>
	 <aH-enGSS7zWq0jFf@casper.infradead.org>
	 <9ac7574508df0f96d220cc9c2f51d3192ffff568.camel@ibm.com>
	 <65009dff-dd9d-4c99-aa53-5e87e2777017@I-love.SAKURA.ne.jp>
	 <e00cff7b-3e87-4522-957f-996cb8ed5b41@I-love.SAKURA.ne.jp>
	 <c99951ae12dc1f5a51b1f6c82bbf7b61b2f12e02.camel@ibm.com>
	 <9a18338da59460bd5c95605d8b10f895a0b7dbb8.camel@ibm.com>
	 <bb8d0438-6db4-4032-ba44-f7b4155d2cef@I-love.SAKURA.ne.jp>
	 <5ef2e2838b0d07d3f05edd2a2a169e7647782de5.camel@ibm.com>
	 <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
In-Reply-To: <8cb50ca3-8ccc-461e-866c-bb322ef8bfc6@I-love.SAKURA.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DM6PR15MB3765:EE_
x-ms-office365-filtering-correlation-id: 8da57dea-aeb9-4948-f129-08ddcba2b02a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U0trRkYra3g4Ly82Z0lVOWlkZnBlNCtSK1lNNEZzV1FMdmM1dGNqdUJwUk1S?=
 =?utf-8?B?KytXN056UTNnTXNqdEdHYUFKRWt1dVdoQ1Rsa1BUdVJldzYycStoK0wzMmdZ?=
 =?utf-8?B?c0tXRzZWWGtxVmdsb1ZJYW85TW4weE1YenJsZWxKMEhDWE14ZXA0YUhiTnBI?=
 =?utf-8?B?ditJejBMd25LRWxOb2w4ZkNNQkxxdFZIV2VsNDU4QnVpWS9VVmpSSkJoTUtv?=
 =?utf-8?B?azh5VStXT1k2TDJ1WnJwZVlPSDJnWVRtSVZRQ3JpNkVVMGI0b2JNL2wxcGsy?=
 =?utf-8?B?NzRVZ3dWOHd6b1BDVG1qTHFMdjBNSXhVYmcxekM3cnZ3TnpYOVdoZHEvY01i?=
 =?utf-8?B?clBxVTBFQi82dG84K2liQWltUHJBSFJ0ZTlnMVBncnd1TUdtY0FqY0JrYkFX?=
 =?utf-8?B?TU9LMFRMR2JTRzNCWUtnS3RDUEU3YlNpMVlmU01oTjVRTG1rdVVTbUMyeXdE?=
 =?utf-8?B?SXlZeitKSTNnR2cvOEo3SUtRWmE2R0ZWNm9zWlFtRmdQYndVNHZKY1UwTlJH?=
 =?utf-8?B?SlBLa1lGTmxpUXRBdUM1LzBxR053TUQzQnY4SFBFeVdDRHFmc3M3L2M0bEda?=
 =?utf-8?B?VVkvRmZXSHF5K1ZYSlNpVDNBbW9xQU5la1pocGRwd0dxNlZCSFllRllENzFX?=
 =?utf-8?B?eEdQTjhZcllqWEt4SHdNZENKekpPVWh0ZisyVmkrL3dBZnYyVzJja2lKNXFJ?=
 =?utf-8?B?U3FtOEZ2STIzNVlBaTlkZkhxMFJHbnRUeVFJV3pxTXFMS2NKVFd0OVNJeHdr?=
 =?utf-8?B?WmNWVmNSM3VuUVlLSGd1Uk5LNkdIZUxiMThsSkd6U3BJSGYreHhoTGJlRDFL?=
 =?utf-8?B?eGUyNkhBZ0RtaXlVYVhTS1hvWk9UclVxcGlycjZucWhBdXFOa2xCaXJsVDN5?=
 =?utf-8?B?RmswT2djQ093RGNFNk5UR2hTSUpGNzNOTFN1bUtTeXFXUUR1VUZYYmdOV2No?=
 =?utf-8?B?NFpEL0dMRnk4Q3dYYy9PZWNjNWp4VW1aQVdFNUhzV25mM1d1eHE0enFSWUxn?=
 =?utf-8?B?THZDMWZYNHBvUDBsYThRU05KMzlwSWlDTytxSXNrUUZJMzJOay9xSUNMZ3hm?=
 =?utf-8?B?YjBvWEFDMG5Dcnk2RC9ZQkZJZ1p1T2hTZ01SbklqK0M3dkZUSzdVd2ZCVFd5?=
 =?utf-8?B?RzZKcEhIRitvc0ZOb1RTSHFvSEVxTjNIeVp2Y2VwMUpidW1lTUR1MXQvUG1B?=
 =?utf-8?B?b0xpL0hhVS9JRXJwZHlONS9mYUZKMXdCalJzUnoyOVZGclRIZk56R3NIMVZh?=
 =?utf-8?B?RVQ0ejJiN3g4bVVTbTNSODFid1ltWkZzbE9yZWNtMVJWZStWaWNRb2dKV1Rz?=
 =?utf-8?B?bHV5dG9VTEh3UjNiNDFUcjdGaFVzWk9mM1NOZldkYWhjTmJKVWdxd0RNYS9F?=
 =?utf-8?B?S2JldU9zRlI0NDgrSmJORzRzd2wzNEluNFBGSnBsOWwxSDlsWElDUldYNmJh?=
 =?utf-8?B?SjlmeHJjc1FVanpZUHkzUE1TRldPOFk5eGJ5UllDbHNJTjhQUk1kV1lvNXps?=
 =?utf-8?B?OGZwV2tObFVZRHJMR3pBNWRlUkJ0N2hpY0FuSXp0c01sMVNoNThqREZuS2Fs?=
 =?utf-8?B?eU1hd3NxTVpPQThmbFhid2k3WFp2NWVDa2lPWkF4VkRTYWpSejVnaUc1cnpS?=
 =?utf-8?B?d0xkVU5ldWFHMTFWTkw1N1RqaVFnc3RyYTBDUk9KemdSZjBNNTFlL3ZOSFUy?=
 =?utf-8?B?TFZKRFdHSHdkTkl1b1VQVEVsQjJDUWdXSFNGSExjeThrOHZ6S0pld001QlNS?=
 =?utf-8?B?YjRVUXdiWWcweldLaGFQYkVsZjJqUzlPczRnOTdwVmdBc0RPNXNkRURuZndi?=
 =?utf-8?B?cE1UY1J5UVRrOHM4VEJweG1mY0NoQ1pxTjJkSm1hRng0eWZHeHVyMzVFdm5k?=
 =?utf-8?B?Yk9JUU51MnRPK21oTVIyN3oxOTNBSGhUZnNDNUZHekdmZStxWktDYkFoNHNW?=
 =?utf-8?Q?ouG7NqY2UbQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QitjT1dpNDhydjRDTmhOS2NIays3MGlEeWJoY3o0c084SngyUXJiOE8zK3JQ?=
 =?utf-8?B?TytLb2V5dXFqU3RWUXFRSk1YZEhDSUY2czRuOG9GdS9LbjZqUkhVVWF0NUF1?=
 =?utf-8?B?cW5zNE9mQXZuQVFvRnZHcFh3cU00d3RBdk5VQm9VYjFvQ2ZkRDRBME55eGht?=
 =?utf-8?B?VkQyYVJKdTdvY1I4d0FoOEMreWV4dHRQYUM0aTNjRTlNakp2bGNsT1Q4REtK?=
 =?utf-8?B?QWlsZXRwTGY3bmZ1V01CdE1Bc3JJVWpiQjM0UEUvOEs1bTFKSXRhazJtK25B?=
 =?utf-8?B?QVd5V3RwcCtRdnQzWFBIaWdtaDJhd09YUk9QWExhRjZiT05xMVRweVIrZ2VZ?=
 =?utf-8?B?Q3JsSlFnRVFPakJUM0h3UVBVMHN5TGlvbzlRR0tyRGpVNXF1WWplN1BsUUVU?=
 =?utf-8?B?WllZcTJHc2Y0d0J6cnR4YUZaUUVDRStSdFU4S3Mrd054MmtPOStpcmxOUTEw?=
 =?utf-8?B?aXBLSm1GSWpUZUtzRlJvazZhQ0swcjJYV0IrM0ZWNDlybkdVMnN1bysyWlp4?=
 =?utf-8?B?bkdTOU5Tc1ZRR3RRSkJaVXdkeGcwWTBXbmZqRGZNM0NnRjdDMGZQUFpSVHEy?=
 =?utf-8?B?bHM2T0RrM2t6eS92S1V4bzBUQkxTWmRlL0MvK0UvOHFtNUhhS056N2xrdlhz?=
 =?utf-8?B?SEw2NC83MjJOUlFGektTaXNMMm9WUmpzek0vODhKcEtLeGQ5TXhrL2EzdTBz?=
 =?utf-8?B?emx4d0U0NnVCUFhPTDl5VmFldDlwdmlCeTloRWtISzlPZVJwU0M4Sit3OThG?=
 =?utf-8?B?bWJiY2RlQVp2WUJpYlVPVlZZcDJIYVV3bFhXUTVteWJISjFJT2VGZVVOeitJ?=
 =?utf-8?B?eG9yTkNkWXhLZktnVkNwdXVQWXg4bjhzeUtrWUpUSW9uODZWS0tuSndiU3dV?=
 =?utf-8?B?T2dQVGNuNWVHNEFuM1dnT1o3UkpvdlkrWURHcjB5NTNHZ0s5MS85bkFlTzQ2?=
 =?utf-8?B?VmNOVnlKdUx6WGZzTC9UeFJTTm53QUhRSzVnL05jMzFtdmtoZjkvMXZQZWUr?=
 =?utf-8?B?YzI5ME1pTGd1Y1YxaFhnR2Z0ZWlkVXl6Rm9maERyNW5zbHN4dXdEUWlpSzA0?=
 =?utf-8?B?YzZnV2dDVVMzUS9wQWc3R2FjYVZBSGZiZmo1dmZvZUgwY1F5d3NHcTFVRnBU?=
 =?utf-8?B?OHFXR2pzaERLd1JZcG9xKzIzYVJXWHlFVWNtUTFOMDVXMVZLeEtjZ2RsWEky?=
 =?utf-8?B?dnNibW45SmIrTG1KMmhmOGxVTTJDVzBiR3FrRWRrTzJTWURrcUpIQTdsUFZS?=
 =?utf-8?B?blJmZ2JKMFl1Z2U3UXR2d2ZHMXQwWVZtdUNJNlhpVzlSdHNyMDVJMG5qWmlC?=
 =?utf-8?B?U1B5YUFpa1pvblArWlExU0liRG5WcFhRZURIZ3U4UTNZaE9KdUJ1VTFxU1gv?=
 =?utf-8?B?RUhUQ1Mxa3ZCQ2VFZDJwUTkyMGZVUWFsckI5ZDdIektGMTBUekhETHE2YWZm?=
 =?utf-8?B?Q2E5YytCSlhtN2I2ekZLWDhhU2ZGV1ZmbGg1SjFscGZCYWdsbEFLL2s0K1E0?=
 =?utf-8?B?UVBTQm9QRFBTamsvS1BoTTdWVTd5NXJ3NlBuUlVSSDRvMlhGbjB6cytzSmt1?=
 =?utf-8?B?ekEvdm9xNEh0T2xId0NQMU0vSmpzRFFXQTFOOHNrbUoraFcvdlREYXZFdHd3?=
 =?utf-8?B?anFlYUFraGZnYWxpZE5DVTc1Ny9OVEFSNjBuK3krei94SDFMTnlDb3FxbVM0?=
 =?utf-8?B?M2YxdkdYdHVRb1ZEVWRtQmd2c0VQOERkSHhsMlR3SE5FQW9KSUloaU1nVDUw?=
 =?utf-8?B?aFE4V1JHb1BhdDlKckVkaWIybEdtZ2ZlMzNWZEpsRk4rdzk1OHp3SXBTU2JL?=
 =?utf-8?B?NlJGa1FUMjI0Z1Zyb3pWYU5JY0sxVGNaRXJkdUpORWZkd0pBSFVGV1pZU0VL?=
 =?utf-8?B?bGlVcXpFR0xDRElVWlFHdkxIRlJSK1I3TUIvQTVqRDR4QS9NQy9iVDd4NDI0?=
 =?utf-8?B?ZnNUeTZMUS9nR2hOb0RFUUdtMWVtWkhZTjdydy9jVjMweVNqSjNuNXlFUDk5?=
 =?utf-8?B?UWdaT1FndXI3eGdxOWY1dXlNRERPa01RTHNYMndFa09SVDRrcDI4ZkpLcEls?=
 =?utf-8?B?WENjaERCZE5OT0tLbUFKQmZTRDBnNDRSUGVTMUg5VURCZ2c0Qmc4RlZnSG01?=
 =?utf-8?B?ZXdScGwyekV2OUtaSkRhVGR0QklvVFhuK2JlMURqVXNRSXRlVkFaZlFVS0VL?=
 =?utf-8?Q?/tSL1YXrU9MBuE9+pgkMC4E=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da57dea-aeb9-4948-f129-08ddcba2b02a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 17:42:55.6594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZHxp8nTmFVQKKJdR9E5hQYH3TMSnnnrpF7BC24nsdjIS75ZVU8Sey9LXAIkyBHXoeQiJxxi8MkoA02nz3cf/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3765
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDE1MiBTYWx0ZWRfX5Gs9suVeoT3y
 StPoYHdT9m2sC37elMwk5SvcAs5ZuWpvGgnrvWmxG1K09zBmBUngfGh8LfQ2uKWeBy/FTjpbzO5
 w0wynZcPWdVIB6EmefRcRyC63Aurnh/zTFHpIcv8NaUhQP3xxXbFIJR1OxWd3trmmR+DIKRPiSE
 hi6etvaI/xOggzsTY3jWG0r96aB6FMI4izT7g9Qe4ileE6zR9LQyVvr7tjeUZ4qj//jJucgCzbI
 QDsqU4jxEVXKjLM8T/5NuDy2Wf7X1kv6HEJ4q6aO+Mq1m/JWGtxHNw+71JiWx7nfbjmFBbCh/Rl
 21nOOamSITTCaJMoSg1uEqmEV3lTDeQ/u5jQeYrArvfwQwWtStKhCegtqZt2llW6cpLw0FAwTJy
 ZUSWPuAkL6K5n++AAjwhxZFkI3pbeZ3vZ//wtrZXyk00zLcU09Io83W7cNSVdaZjvM3NU2FS
X-Proofpoint-ORIG-GUID: O7BT4_U2xd3XQWIbA7c-KKpU53nWhkhk
X-Proofpoint-GUID: O7BT4_U2xd3XQWIbA7c-KKpU53nWhkhk
X-Authority-Analysis: v=2.4 cv=G+ccE8k5 c=1 sm=1 tr=0 ts=6883c222 cx=c_pps
 a=bu/IKwmYeS9Jib3vFHOoZQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=t-IPkPogAAAA:8
 a=dpABhI1dQ5ollNZ7Ci0A:9 a=QEXdDO2ut3YA:10 a=55wNQ-xyllsA:10
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CDFEA29CF7D4D41A98EBBB4AB953875@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v3] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2507250152

On Fri, 2025-07-25 at 07:05 +0900, Tetsuo Handa wrote:
> On 2025/07/25 4:49, Viacheslav Dubeyko wrote:
> > On Thu, 2025-07-24 at 15:55 +0900, Tetsuo Handa wrote:
> > > Then, something like below change?
> > >=20
> > > --- a/fs/hfs/inode.c
> > > +++ b/fs/hfs/inode.c
> > > @@ -318,6 +318,9 @@ static int hfs_read_inode(struct inode *inode, vo=
id *data)
> > >         struct hfs_iget_data *idata =3D data;
> > >         struct hfs_sb_info *hsb =3D HFS_SB(inode->i_sb);
> > >         hfs_cat_rec *rec;
> > > +       /* https://developer.apple.com/library/archive/technotes/tn/t=
n1150.html#CNID     */
> >=20
> > We already have all declarations in hfs.h:
> >=20
> > /* Some special File ID numbers */
> > #define HFS_POR_CNID		1	/* Parent Of the Root */
> > #define HFS_ROOT_CNID		2	/* ROOT directory */
> > #define HFS_EXT_CNID		3	/* EXTents B-tree */
> > #define HFS_CAT_CNID		4	/* CATalog B-tree */
> > #define HFS_BAD_CNID		5	/* BAD blocks file */
> > #define HFS_ALLOC_CNID		6	/* ALLOCation file (HFS+) */
> > #define HFS_START_CNID		7	/* STARTup file (HFS+) */
> > #define HFS_ATTR_CNID		8	/* ATTRibutes file (HFS+) */
> > #define HFS_EXCH_CNID		15	/* ExchangeFiles temp id */
> > #define HFS_FIRSTUSER_CNID	16
>=20
> These declarations does not define 14, and some flags are never used desp=
ite
> being declared here.
>=20
> >=20
> > So, adding the link here doesn't make any sense.
> >=20
> > > +       static const u16 bad_cnid_list =3D (1 << 0) | (1 << 6) | (1 <=
< 7) | (1 << 8) |
> > > +               (1 << 9) | (1 << 10) | (1 << 11) | (1 << 12) | (1 << =
13);
>=20
> Some of values in this constant are not declared.
>=20

It means that we need to declare the missing values. But hardcoded bare num=
bers
are really bad practice.

> >=20
> > I don't see any sense to introduce flags here. First of all, please, do=
n't use
> > hardcoded values but you should use declared constants from hfs.h (for =
example,
> > HFS_EXT_CNID instead of 3). Secondly, you can simply compare the i_ino =
with
> > constants, for example:
>=20
> This will save a lot of computational power compared to switch().
>=20

Even if you would like to use flags, then the logic must to be simple and
understandable. You still can use special inline function and do not create=
 a
mess in hfs_read_inode(). Especially, you can declare the mask one time in
header, for example, but not to prepare the bad_cnid_list for every function
call. Currently, the code looks really messy.

> >=20
> > bool is_inode_id_invalid(u64 ino) {
> >       switch (inode->i_ino) {
> >       case HFS_EXT_CNID:
> >       ...
> >           return true;
> >=20
> >       }
> >=20
> >       return false;
> > }
> >=20
> > Thirdly, you can introduce an inline function that can do such check. A=
nd it
> > make sense to introduce constant for the case of zero value.
> >=20
> > Why have you missed HFS_EXT_CNID, HFS_CAT_CNID? These values cannot use=
d in
> > hfs_read_inode().
>=20
> Is hfs_read_inode() never called for HFS_EXT_CNID and HFS_CAT_CNID ?
>=20

The location of Catalog File and Extents File are defined in superblock. As=
 a
result, Catalog File cannot contain a record with CNID HFS_EXT_CNID or
HFS_CAT_CNID. And if hfs_read_inode() receives these values, then it is some
corruption of Catalog File.

> >=20
> > >=20
> > >         HFS_I(inode)->flags =3D 0;
> > >         HFS_I(inode)->rsrc_inode =3D NULL;
> > > @@ -358,6 +361,8 @@ static int hfs_read_inode(struct inode *inode, vo=
id *data)
> > >                 inode->i_op =3D &hfs_file_inode_operations;
> > >                 inode->i_fop =3D &hfs_file_operations;
> > >                 inode->i_mapping->a_ops =3D &hfs_aops;
> > > +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inod=
e->i_ino) & bad_cnid_list))
> > > +                       make_bad_inode(inode);
> >=20
> > It looks pretty complicated. You can simply use one above-mentioned fun=
ction
> > with the check:
> >=20
> > if (is_inode_id_invalid(be32_to_cpu(rec->dir.DirID)))
> >      <goto to make bad inode>
> >=20
> > We can simply check the the inode ID in the beginning of the whole acti=
on:
> >=20
> > <Make the check here>
> > 		inode->i_ino =3D be32_to_cpu(rec->file.FlNum);
> > 		inode->i_mode =3D S_IRUGO | S_IXUGO;
> > 		if (!(rec->file.Flags & HFS_FIL_LOCK))
> > 			inode->i_mode |=3D S_IWUGO;
> > 		inode->i_mode &=3D ~hsb->s_file_umask;
> > 		inode->i_mode |=3D S_IFREG;
> > 		inode_set_mtime_to_ts(inode,
> > 				      inode_set_atime_to_ts(inode,
> > inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->file.MdDat))));
> > 		inode->i_op =3D &hfs_file_inode_operations;
> > 		inode->i_fop =3D &hfs_file_operations;
> > 		inode->i_mapping->a_ops =3D &hfs_aops;
> >=20
> > It doesn't make any sense to construct inode if we will make in bad ino=
de,
> > finally. Don't waste computational power. :)
> >=20
> > >                 break;
> > >         case HFS_CDR_DIR:
> > >                 inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> > > @@ -368,6 +373,8 @@ static int hfs_read_inode(struct inode *inode, vo=
id *data)
> > >                                       inode_set_atime_to_ts(inode, in=
ode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
> > >                 inode->i_op =3D &hfs_dir_inode_operations;
> > >                 inode->i_fop =3D &hfs_dir_operations;
> > > +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inod=
e->i_ino) & bad_cnid_list))
> > > +                       make_bad_inode(inode);
> >=20
> > We already have make_bad_inode(inode) as default action. So, simply jum=
p there.
> >=20
> > >                 break;
> > >         default:
> > >                 make_bad_inode(inode);
> > >=20
> > >=20
> > >=20
> > > But I can't be convinced that above change is sufficient, for if I do
> > >=20
> > > +		static u8 serial;
> > > +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inod=
e->i_ino) & bad_cnid_list))
> > > +                       inode->i_ino =3D (serial++) % 16;
> >=20
> > I don't see the point in flags introduction. It makes logic very compli=
cated.
>=20
> The point of this change is to excecise inode->i_ino for all values betwe=
en 0 and 15.
> Some of values between 0 and 15 must be valid as inode->i_ino , doesn't t=
hese? Then,
>=20

If you have mask of valid or/and invalid, then you can simply check that th=
is
mask contain  the flag. It will bed simple bit state checking. Currently, t=
he
code looks weird, not clear, complicated, and inefficient.

> >=20
> > >=20
> > > instead of
> > >=20
> > > +               if (inode->i_ino < HFS_FIRSTUSER_CNID && ((1U << inod=
e->i_ino) & bad_cnid_list))
> > > +                       make_bad_inode(inode);
> > >=20
> > > , the reproducer still hits BUG() for 0, 1, 5, 6, 7, 8, 9, 10, 11, 12=
, 13, 14 and 15
> > > because hfs_write_inode() handles only 2, 3 and 4.
> > >=20
> >=20
> > How can we go into hfs_write_inode() if we created the bad inode for in=
valid
> > inode ID? How is it possible?
>=20
> are all of 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 and 15 invalid value f=
or hfs_read_inode() ?
>=20
> If all of 0, 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14 and 15 are invalid valu=
e for hfs_read_inode(),
> and 3 and 4 are also invalid value for hfs_read_inode(), hfs_read_inode()=
 would accept only 2.
> Something is crazily wrong.
>=20
> Can we really filter some of values between 0 and 15 at hfs_read_inode() ?

0 value is invalid.

#define HFS_POR_CNID		1	/* Parent Of the Root */
#define HFS_ROOT_CNID		2	/* ROOT directory */

These values are legitimate values.

#define HFS_EXT_CNID		3	/* EXTents B-tree */
#define HFS_CAT_CNID		4	/* CATalog B-tree */

This metadata structures are defined in MDB. This is invalid values for
hfs_read_inode().

#define HFS_BAD_CNID		5	/* BAD blocks file */

This could be defined in Catalog File because MDB has nothing for this meta=
data
structure. However, it's ancient technology.

#define HFS_ALLOC_CNID		6	/* ALLOCation file (HFS+) */
#define HFS_START_CNID		7	/* STARTup file (HFS+) */
#define HFS_ATTR_CNID		8	/* ATTRibutes file (HFS+) */

These value are invalid for HFS.

9, 10, 11, 12, 13, 14 can be defined as constants and it is invalid values.=
 Foe
example:

#define HFS_RESERVED_CNID_9    9
#define HFS_RESERVED_CNID_10   10
...
#define HFS_RESERVED_CNID_14   14

#define HFS_EXCH_CNID		15	/* ExchangeFiles temp id */

This could be defined in Catalog File (maybe not). I didn't find anything
related to this in HFS specification.

So, 1, 2, 5, 15, etc can be accepted by hfs_read_inode().
0, 3, 4, 6, 7, 8, 9, 10, 11, 12, 13, 14 is invalid values for hfs_read_inod=
e().

Thanks,
Slava.

