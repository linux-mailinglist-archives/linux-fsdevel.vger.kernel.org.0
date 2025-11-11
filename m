Return-Path: <linux-fsdevel+bounces-67785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F543C49E8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 01:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9971434BC7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 00:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB025484B;
	Tue, 11 Nov 2025 00:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K2tM3Wqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C52AE8D
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 00:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822114; cv=fail; b=UpfgDs/1Ld9gJNtp3hHD/2eODhg5LfrbzShRaicrl1LyrbxuuqT4ohVb/1Ai2wyyb6BkxXOz5KSHn3QRGoxSa8nO923QSd9LKtNE77DlCZUGGOW/vuFJCDWfhUq38jTivxYdDmEzubhur0h+iO5GYRl9W8VOWg+jtpIewl6b1WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822114; c=relaxed/simple;
	bh=v555xd8gSJJDQVEDcQSScbeQWI4/YmeY1VNKuot67uw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=af8Bi+LSajTcrVOnndAbhDGaPgnYXu55vXxcfMm56sUTwsRtyogA1sUx2jm/oMFVwwfk9/uo5hHlS6CiJ68NpMp219ghokcVu5YMej2xcC/6owFKtwtA43Yu/3pMsdXbdxfUIDR6fXIgxUiWnAsysWJbt23G7i03VWxujorkZ4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K2tM3Wqc; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAF4BTY012181
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 00:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=oHkKW1fOudVMTx5MFDwmdtnftXTle102CRUJTE9nAbM=; b=K2tM3Wqc
	D5/vSHdP3e0TNOeWtvR3DPCvI20V8tb2U0wdP3WcVBGk6JSYBbZLkFtjiMTHQ45s
	tLXo8CapS5LJ04oclJ6kelbiez/CWRvcbDONTLoDFiEw5RurRN9H3S3HPYaKPls0
	S58TDfcdOpN3shivL3eNQUTtXx8+XlG3kxYV+bnXi0EnQqRsGEIAf9DanFHktFtD
	rcOfRIvLff0OlT93q3xMT/mxAqf3KuB+FQ+GB4injHHdMS92/6vigYNlVds5osF7
	vYTab7r+04Ny5E3akOEUbf/LVDhu0wclbmZ//Tk8QWYNk5DBPZaQ3+GPa50gZsfv
	sUI7NDJGsklGdQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjrman-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 00:48:32 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AB0mV0u018641
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Nov 2025 00:48:31 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjrmad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 00:48:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPkDDNr7B8JjtSjKNLtEvjxcJsFTDqKMYSZmqFD7YaWD68RkCswXI+HhJU3le26ZNaSKdpFo2EZ6SrXBL7rFSrSuDfJYZ+hT6RsoWbK1YAnN0kfemcPPbi7WQkx1KJD/nd9Ih5ee806l0HP9E7lkmiO/HXi+Iqar7K/fCauSrfuz2FMVAKzusjF4483JyRTAuWWHZHUr59T51Oc/FB4n3Z/lu4grktCvKB7brP/7TdjEVMapuoa1KE2lMC6vVWCjthq/IKtx6mUH4nI0wMXzfT+V7vLPbAdDO9wy2WGhPjDDIWudWWBrueO7xixZ53a40JYzMigYcO+YZTGetWoWGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wX6UbuXjay2DMyh5uZB9qKxv0RQZXkH9aKjttnH7sM=;
 b=aYGJtk8qkYXZVZBXcHzsqBWraWoxdOzug4rxz0aCGS5FyGNafvXaW7QbIu69UlztcCqp6EMopSXVFWr+2eSpbKjpjYSNKbUjGdkpjzKYRZMrRZSl6NIZf/JEynBvt4romWc7IBHpib7tNUJynVmMAba4hldwgh68bt+vA2AzolePB26aKF29wTh+iqQ/UuBl7wEJyc47D/AZwExhsMew3np1/tgXFIrTHsc2spVu00/D6kMz7+uvhsKb9pEm5kIS1mhS+ZWeHaCnUVttG9ZbqINwnnpUjAw7kWe5sc9ulcBS0a+qf/80hSgxBACcY/3sPEAf57ol4yGF66uWDWOdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB5955.namprd15.prod.outlook.com (2603:10b6:806:2e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 00:48:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 00:48:28 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "contact@gvernon.com" <contact@gvernon.com>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel-mentees@lists.linux.dev"
	<linux-kernel-mentees@lists.linux.dev>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "penguin-kernel@i-love.sakura.ne.jp"
	<penguin-kernel@i-love.sakura.ne.jp>,
        "syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com"
	<syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2 1/2] hfs: Validate CNIDs in
 hfs_read_inode
Thread-Index: AQHcUp5BSokm2L2+yEOPPOOLb835xbTspIuA
Date: Tue, 11 Nov 2025 00:48:28 +0000
Message-ID: <10acb67e66aa0b05ef2340178e761bafaab20af9.camel@ibm.com>
References: <d2b28f73-49c8-4e30-9913-01702da4dfe4@I-love.SAKURA.ne.jp>
	 <20251104014738.131872-3-contact@gvernon.com>
	 <e13da4581ff5e8230fa5488f6e5d97695fc349b0.camel@ibm.com>
	 <aRJ8uYyD0ydI8MUk@Bertha>
In-Reply-To: <aRJ8uYyD0ydI8MUk@Bertha>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB5955:EE_
x-ms-office365-filtering-correlation-id: 34ae3dbc-5245-4b2d-ce43-08de20bc0777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Uy9IWUhpUGVMNnFtUmJ6L1V2VEpZcnVnNEU3Q0wwKzVxakRzMHdtbVNrVjBo?=
 =?utf-8?B?Q2ZsalhEak5JUFFKWmF2SmdoMUtrbzRPbnBIdzlVSWhFeWNHRXQ5VUxFWXZz?=
 =?utf-8?B?ekxFQXFwWlIwSEtzV1pnUXc0Q0JwK2p3RjBmUW9jSWp5RS8yQ0pnb3N0SHJH?=
 =?utf-8?B?Sm5FTzNmMnpIV1pmSVZWMHNmdkdneDd4eWp2Yjdxdmk0Q2cwUVU5aDJwTEdZ?=
 =?utf-8?B?UlAxUkV4Rnd0dGhkQWVweU1JM2tRRmdLMUJrZWY5MFl5OE96aXd3VngzUVN3?=
 =?utf-8?B?M0t1MWFsMHZqeGdvdVZBbGNhYzl3ZEJ3bjlOdjZZZHFuYVZUQnFBZ3AvZXFo?=
 =?utf-8?B?d25MdytIWVVrVW52Q1JYSENuSVRORmtzKzI1cjdSWm1yUkZkQitGRngvWnp5?=
 =?utf-8?B?L3AyN0ovdnVramNUeWlwaitTamI0RW12UUFySTJoc0tkaERUa1V4NlMxNm5u?=
 =?utf-8?B?Z2JSSTh4QlN5U01FZnlhdWJ1SnhZamFuSDdTeGV1bDFTaU9kQzFzeTBnVW9w?=
 =?utf-8?B?Y25lM0xUUXZNNFJLTWg2SXk1SURVZmxmUlZDZ2lEL2V1RFVQSVhYbFhjSGM4?=
 =?utf-8?B?WXd0ZWhwcURBeTJpNDdXWXlCWlBBeHpqcllkcWRkeVZ0T0NYTWtaNVA5cUFn?=
 =?utf-8?B?a2tuNTRZclIwdGVSSUtWMUVHS0JpTkFUY3FJWlpybm1JbDhVaVdzMkZDSXN1?=
 =?utf-8?B?d0NldzRTQUxlUU03b0EwV2xQcXBpYVNrT1BOSEJnNk9RS3lNbXFMMzU1NXAz?=
 =?utf-8?B?QXd3REl6SlFqUGhWVEVUaFlyVEd1WTJGYzg1UFliZlBCOWh6QVl2VXMzdmVs?=
 =?utf-8?B?aE5OV21ncjlhTWRoU0VLclpqL1VkbXNBdU5NYXNRaDVFT3UyVWxXSFdvT2ZB?=
 =?utf-8?B?WlRtcFJwajRDajBvZWNETUZOYWsyckltallKbUlJT3dGK0pPWlJTdHN0Q1By?=
 =?utf-8?B?QksvdXYwKzRVWlBhY25uNVlEWlQwanBWaG5NMVdRMi9rODA5bG1wNWtlMFkv?=
 =?utf-8?B?N2p1Y1dqc25OSXhDOHRiQnJGRDZWZ2hzMG5JMVB4a01rL21SQlZtT3FIUHR3?=
 =?utf-8?B?T0VUYzdyRUZEdmFJM1M3dWNWNU5NZ1IvczVkZmRSdGpiSUJ4dmVwVDlaak5s?=
 =?utf-8?B?NzBaOG16VUh1ODcrZWw0V3p1MVhTUlIvSTNEVVFSYmF2ZXJFbVc1Yk1mSjQv?=
 =?utf-8?B?Ri95ZWY1WUUreVJDZmRGNGM1YTh0UjI0MmMwQ3FYTGUwMkdMeVRNRXJ1aFpT?=
 =?utf-8?B?L0ZJaWZXZDdtYkRsc2Fhb0ZEbkxXQmwrdHllc2xTQmlYdHo0REF6R1ZsSGdy?=
 =?utf-8?B?RUdxQXpKVkNtOSt1RHV0MkQrRFBudVI3a3BZTkMrREpRR2J1a1lLanNzUDVT?=
 =?utf-8?B?Ujd5TXRuOWZqUGMxRFJLYzVtWVVRNEFjMzhudmkrdXA5bkk2eVFNbHRab083?=
 =?utf-8?B?V3NnNkd5K1NpNjFFcEt4cW1sNU5EL09WWnZLMitXdGFKYWphR0NLVkg1dXoz?=
 =?utf-8?B?VGZJU1YrVWs1RGFaeFlFSDM1U0lqcitEN2xSQnpkSkkxOTRWdXdrQzJiSnNp?=
 =?utf-8?B?NU45TmR4OVpRWjZIc0E5LzVwL3pzcFBHalRzTk9xeXBDSlJYMWhFVTFEbExw?=
 =?utf-8?B?QzduQmp1bXd2VXRqdEFCb0krVDViVjhwclNhWG50cXZ0eXhiVS9qSm5NZkRY?=
 =?utf-8?B?aUpnU1lZZ0QyTFMyRDMxTm5xTzRVSDMya05sVUlham1mUnJlSGRNV1k2SU4y?=
 =?utf-8?B?UnpZQ2FNelRyTFNJeTRSeG1qSlMrSVRObk9TdHJmSkxiNDFDbXg0aFN6K2FT?=
 =?utf-8?B?UVZUNGNOM1JDV04vRVloa1JXeDhndmxVRUJtZUhqK251SGlwTEZmZGREcWxB?=
 =?utf-8?B?NzEzaUJSRkhCTEFFanNyc1RYNXkrQmZrQmZ4bkxkbTd1bW5tRWp0OGFYZmRH?=
 =?utf-8?B?Vi9CQjZWdURtNVh5SVQwVWJxOGF0NkQ4aVB2RzF1SkpJNUxPMEZMNDlmZlZY?=
 =?utf-8?B?ckQ5MXp2NXhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEpYMzJSVHdiSEJQWEc4Y0dqS2xOSlNucmxhNjBsc0VuRW5lK0ExdjMwajlE?=
 =?utf-8?B?Yzk5aWJ3Q2RqVW9WbWZydU1aTFhvN2F1YWNrU3BzWDlSSTVZZWtITE9rVkxM?=
 =?utf-8?B?MGVPSFhFNlhBM2RYcm8zK1Z1dmdqZ0FMbkQyQVVMaGU2ZEgwaU1XV3BlRENh?=
 =?utf-8?B?SktqTUpVcW1mZTZ2dGRiczZoQmZlRy9uY3krTDBsaW9oeXRpVTV0SEdZYU5T?=
 =?utf-8?B?WkQrNDRKTXBSWmI3TnpTM3BaMmJCaDYyZm1GOG1STXZvVGwzVUhQYnFqS0FX?=
 =?utf-8?B?elFXTll5UWFXZzZyNzNxbVBxVmdiNmxPTkdWOGRMYXM3cU1YZkcwc3NtS2dD?=
 =?utf-8?B?WDR0clFYTVFsR1lBc3dVOVpFVHRsVW01MWFiTjFCNElycS9iYXF5TzI5MHk5?=
 =?utf-8?B?UjU4eExqcDlpQm0vTU9yQTJyazhQUU5ZRmNxK3lYZXFhMG05RFkrUDgvM2Rk?=
 =?utf-8?B?cnUvUlZBY2VXVG85VER5bHA1UGJQU0JGQ2ozbnNYZEEvVXZNNWlJQzE1aTFU?=
 =?utf-8?B?YzJ5K1N4eHFOMzZWeFg1NkhVNE1hcDVpbVpHazI1ZlplSFNaS1lvQzN5RURv?=
 =?utf-8?B?Q1RmVE5uQTZxWHBubmN4UHhFbE1LVStnV3Q2RHMzaUVtQ3BlcnQ2V2drVnhV?=
 =?utf-8?B?Q3dKeEViMndKTkU0cEozUGhtUVZ4OHdHYkV0VFNETnM5KzZ0UkNGMFg0cnpJ?=
 =?utf-8?B?cFN5Q2tyaE94MFhHQlBnWFNFUDZQL0RJL2hhcU1jTGh4RThmODZxaXpRNUoy?=
 =?utf-8?B?R3IyR0VlQzZsTmZ1WE5ROFE1ZGhBY2VnTjBTL2RzVW5ERUR0bzFCLzNDejVi?=
 =?utf-8?B?bGVWVUdHT09uVzVRUmpiZFlja0VzY1ltY3l6OEovOE5VNVA3cnNJMTFWd1RT?=
 =?utf-8?B?VlpEbkYvbWtTYmYvZ0NSN3libURZTVBUUmZJSUdxbkJkVlJkY1pYTFM5NVFV?=
 =?utf-8?B?VzdUbkt1VjNqM3lhQTZQV2pRM2ZPRDJBZFI3bis1eGQwS3NBay9IQlFJd2Np?=
 =?utf-8?B?a0UweE1hRUYzaDhSTno2MUJUZVBZRmI2cThVSWxTTitPV2orZEgwMlVmR1d6?=
 =?utf-8?B?cmVHb2Y2VlZqUTByVWdld1BkTVBrc2JWMUFoQ3dzbnBGSy9kclFOVDdHQmdn?=
 =?utf-8?B?U0ZpbS8vcmp6b2wvKzkvSWUyNGVMdFVYVjlURW5ZcnJVVlR0a3RKR2pTdTZ0?=
 =?utf-8?B?QW1YOTZyM0hmMWpZMncwVThqYmdnZnBaMytrZU5nRmRNMmlVMndoL0w0Lzg0?=
 =?utf-8?B?ZW1qK3dkTVpUanVDa3YyL2ZnYXdQbHNrS2J5cEVTUy94Z2ZSek5kNmNCUXFQ?=
 =?utf-8?B?ejFEa2JjcndOWUNJejkyWVZIdUxuak9yWGJOZ2h1dDdQVGR4N0ZOSVRHd3pG?=
 =?utf-8?B?NWxSZ3J1VUVtNG1Hd1BPN3k1OE9ITG1HemdIV3k1K3YxcVN3RnY3YXFiVEdw?=
 =?utf-8?B?NDVrSkxTUlZrakJmNEZZdkxvYTBGRWV1THp6VzdHb2w1Vlh1TWpGVmY3Z21h?=
 =?utf-8?B?MmlBR05FZGVaVUpuN2ZkNTNwQ0JmcmcrOHZUd2dtRndWUHl1MGhRS3VVNXlM?=
 =?utf-8?B?Q1BKL1d6dUhVSzh0b2tzSWNiVFZKdGpzNFF3SkNYMU80emJXVHBuYm83SmVW?=
 =?utf-8?B?TDF3eVhBWWdFM2cyeC9aUSt5bjB5ejBrNi82bnFDdWwzeGFOOFBJbnZpcjRi?=
 =?utf-8?B?dUY3cGdOQ09MbExaSmttYXJIeWpaTWNodG54YloyUS9xTkdrOHJ0d1pScU10?=
 =?utf-8?B?d0JVV0ZZVWpjSW41MnM5ZzhoZlhCK250ZUxCY2dOaFJZTEJ0VkhCeTlBYjNE?=
 =?utf-8?B?dldBZ1ZRL0dSVUJabUtGOTBRbURiOURZUzhiZjhJN2w0eVZlcFRLcTVydndk?=
 =?utf-8?B?TzJSUUZ0OHBoWUIxdTFWYnJDMjR4Zk4wSE9sV2svVUEzalFVQS9WQ0FCY0Ro?=
 =?utf-8?B?dCsycVpzVTZHTlFlbkx2Vlgxd0FITzVoSFlCOUVRWm0weWJQeFV0cGtia2tK?=
 =?utf-8?B?MFVSbHJOeC9BYTJFNmt1M2trTTRMWXN5R1ZqYU9aR3RhcGwwVTdqOE5XcE5R?=
 =?utf-8?B?MWdWa2lhZ0JjbHBaRHFRQXdBZzhBejhBWnk2cjhKTWZpbWwzbnVTNHlFN2tl?=
 =?utf-8?B?bTlndFVWUlFlNHNWdGlBTCsyTHpzMGdxaGZUK3grZ1JRbTkzbmJVKzRyU3pS?=
 =?utf-8?Q?xLBldwxU+3k/etQ4q6lqlQI=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ae3dbc-5245-4b2d-ce43-08de20bc0777
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 00:48:28.4355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h6O4XE+GS2kY4Ctgp11qteoNoSL68dOtciBAp5iyS8juUPjwnFkqBu8E5QUgQwc2Xcub/kWmYrKA/6sxgC1o2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB5955
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX0y1E6rxJ198A
 jQMmG3BfCapT3JNeZxHKGoqG72/YShf8YS/P6Oj9v1Ll4eU7oWR4Io/1hYWyz9FcRvxJHxC5fRS
 znBJtEVk871hQcDlK/EUu35ujlmQfHbijB56l7I4Yl3Ah/DvVoXDkwYnfQ/IZNvDN78pQDGYlu2
 fZhU1IMqUw54g21RQDyX1lQBIQAHDwtz4rCQLmqwzHuQmOUolCq3thUMN67cyoXLyYp/iSdJCRB
 OCbJ9ncnywCbEU1NX4FdmVMbv2VGOQhRbBKPSJ5opgRUi8YwoCc/y/fBdCiUff2kw7G8ES6dqLa
 dFHLAjIUVMGRURB7MmiAc8l0i56mNrloK+kLcWJ8Ywlhvm0r+hWZGZJ8MaNZkUxLThqSq0MiSP7
 vUa2kswXFdJ3JZg8X3lHcYvGBnJ4Cg==
X-Proofpoint-ORIG-GUID: 6-QJGo0Aw34Ll0Hx_NGemjmrsMRKT8Sm
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=691287de cx=c_pps
 a=JPzmcyOoIuAgIyAaop9pOg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=edf1wS77AAAA:8
 a=hSkVLCK3AAAA:8 a=3HEcARKfAAAA:8 a=wLF32H0E1Tpp3JxhJpEA:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=fDn2Ip2BYFVysN9zRZLy:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-GUID: 6-QJGo0Aw34Ll0Hx_NGemjmrsMRKT8Sm
Content-Type: text/plain; charset="utf-8"
Content-ID: <A59F796AC4303F4E9A17B3FA39CFD6F4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2 1/2] hfs: Validate CNIDs in hfs_read_inode
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2511080099

On Tue, 2025-11-11 at 00:00 +0000, George Anthony Vernon wrote:
> On Tue, Nov 04, 2025 at 10:34:15PM +0000, Viacheslav Dubeyko wrote:
> > On Tue, 2025-11-04 at 01:47 +0000, George Anthony Vernon wrote:
> > > hfs_read_inode previously did not validate CNIDs read from disk, ther=
eby
> > > allowing inodes to be constructed with disallowed CNIDs and placed on
> > > the dirty list, eventually hitting a bug on writeback.
> > >=20
> > > Validate reserved CNIDs according to Apple technical note TN1150.
> >=20
> > The TN1150 technical note describes HFS+ file system and it needs to ta=
ke into
> > account the difference between HFS and HFS+. So, it is not completely c=
orrect
> > for the case of HFS to follow to the TN1150 technical note as it is.
>=20
> I've checked Inside Macintosh: Files Chapter 2 page 70 to make sure HFS
> is the same (CNIDs 1 - 5 are assigned, and all of 1-15 are reserved).
> I will add this to the commit message for V3.
>=20
> > >=20
> > > This issue was discussed at length on LKML previously, the discussion
> > > is linked below.
> > >=20
> > > Syzbot tested this patch on mainline and the bug did not replicate.
> > > This patch was regression tested by issuing various system calls on a
> > > mounted HFS filesystem and validating that file creation, deletion,
> > > reads and writes all work.
> > >=20
> > > Link: https://lore.kernel.org/all/427fcb57-8424-4e52-9f21-7041b2c4ae5=
b@   =20
> > > I-love.SAKURA.ne.jp/T/
> > > Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21=
b   =20
> > > Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > > Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> > > Signed-off-by: George Anthony Vernon <contact@gvernon.com>
> > > ---
> > >  fs/hfs/inode.c | 67 +++++++++++++++++++++++++++++++++++++++---------=
--
> > >  1 file changed, 53 insertions(+), 14 deletions(-)
> > >=20
> > > diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> > > index 9cd449913dc8..bc346693941d 100644
> > > --- a/fs/hfs/inode.c
> > > +++ b/fs/hfs/inode.c
> > > @@ -321,6 +321,38 @@ static int hfs_test_inode(struct inode *inode, v=
oid *data)
> > >  	}
> > >  }
> > > =20
> > > +/*
> > > + * is_valid_cnid
> > > + *
> > > + * Validate the CNID of a catalog record
> > > + */
> > > +static inline
> > > +bool is_valid_cnid(u32 cnid, u8 type)
> > > +{
> > > +	if (likely(cnid >=3D HFS_FIRSTUSER_CNID))
> > > +		return true;
> > > +
> > > +	switch (cnid) {
> > > +	case HFS_ROOT_CNID:
> > > +		return type =3D=3D HFS_CDR_DIR;
> > > +	case HFS_EXT_CNID:
> > > +	case HFS_CAT_CNID:
> > > +		return type =3D=3D HFS_CDR_FIL;
> > > +	case HFS_POR_CNID:
> > > +		/* No valid record with this CNID */
> > > +		break;
> > > +	case HFS_BAD_CNID:
> >=20
> > HFS is ancient file system that was needed to work with floppy disks. A=
nd bad
> > sectors management was regular task and responsibility of HFS for the c=
ase of
> > floppy disks (HDD was also not very reliable at that times). So, HFS im=
plements
> > the bad block management. It means that, potentially, Linux kernel coul=
d need to
> > mount a file system volume that created by ancient Mac OS.
> >=20
> > I don't think that it's correct management of HFS_BAD_CNID. We must to =
expect to
> > have such CNID for the case of HFS.
> >=20
>=20
> HFS_BAD_CNID is reserved for internal use of the filesystem
> implementation. Since we never intend to use it, there is no correct
> logical path that we should ever construct an inode with CNID 5. It does
> not correspond to a record that the user can open, as it is a special
> CNID used only for extent records used to mark blocks as allocated so
> they are not used, a behaviour which we do not implement in the Linux
> HFS or HFS+ drivers. Disallowing this CNID will not prevent correctly
> formed filesystems from being mounted. I also don't think that
> presenting an internal record-keeping structure to the VFS would make
> sense or would be consistent with other filesystems.
>=20

Yes, we don't want to use it on Linux kernel side. But, potentially, the fi=
le
for bad block management could or was been created/used on Mac OS side. And=
 if
anyone tries to mount the HFS volume with the bad block file, then we will
refuse to mount it on the Linux kernel side. This is my main worry here. Bu=
t it
is not very probable situation, by the way.

> > > +	case HFS_EXCH_CNID:
> > > +		/* Not implemented */
> > > +		break;
> > > +	default:
> > > +		/* Invalid reserved CNID */
> > > +		break;
> > > +	}
> > > +
> > > +	return false;
> > > +}
> > > +
> > >  /*
> > >   * hfs_read_inode
> > >   */
> > > @@ -350,6 +382,8 @@ static int hfs_read_inode(struct inode *inode, vo=
id *data)
> > >  	rec =3D idata->rec;
> > >  	switch (rec->type) {
> > >  	case HFS_CDR_FIL:
> > > +		if (!is_valid_cnid(rec->file.FlNum, HFS_CDR_FIL))
> > > +			goto make_bad_inode;
> > >  		if (!HFS_IS_RSRC(inode)) {
> > >  			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
> > >  					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
> > > @@ -371,6 +405,8 @@ static int hfs_read_inode(struct inode *inode, vo=
id *data)
> > >  		inode->i_mapping->a_ops =3D &hfs_aops;
> > >  		break;
> > >  	case HFS_CDR_DIR:
> > > +		if (!is_valid_cnid(rec->dir.DirID, HFS_CDR_DIR))
> > > +			goto make_bad_inode;
> > >  		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> > >  		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
> > >  		HFS_I(inode)->fs_blocks =3D 0;
> > > @@ -380,8 +416,12 @@ static int hfs_read_inode(struct inode *inode, v=
oid *data)
> > >  		inode->i_op =3D &hfs_dir_inode_operations;
> > >  		inode->i_fop =3D &hfs_dir_operations;
> > >  		break;
> > > +	make_bad_inode:
> > > +		pr_warn("rejected cnid %lu. Volume is probably corrupted, try perf=
orming fsck.\n", inode->i_ino);
> >=20
> > The "invalid cnid" could sound more relevant than "rejected cnid" for m=
y taste.
> >=20
> > The whole message is too long. What's about to have two messages here?
> >=20
> > pr_warn("invalid cnid %lu\n", inode->i_ino);
> > pr_warn("Volume is probably corrupted, try performing fsck.\n");
> >=20
> Good improvement!
> >=20
> > > +		fallthrough;
> > >  	default:
> > >  		make_bad_inode(inode);
> > > +		break;
> > >  	}
> > >  	return 0;
> > >  }
> > > @@ -441,20 +481,19 @@ int hfs_write_inode(struct inode *inode, struct=
 writeback_control *wbc)
> > >  	if (res)
> > >  		return res;
> > > =20
> > > -	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
> > > -		switch (inode->i_ino) {
> > > -		case HFS_ROOT_CNID:
> > > -			break;
> > > -		case HFS_EXT_CNID:
> > > -			hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
> > > -			return 0;
> > > -		case HFS_CAT_CNID:
> > > -			hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
> > > -			return 0;
> > > -		default:
> > > -			BUG();
> > > -			return -EIO;
> > > -		}
> > > +	if (!is_valid_cnid(inode->i_ino,
> > > +			   S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL))
> >=20
> > What's about to introduce static inline function or local variable for
> > S_ISDIR(inode->i_mode) ? HFS_CDR_DIR : HFS_CDR_FIL? I don't like this t=
wo line
> > implementation.
>=20
> Okay, I will rewrite this.
>=20
> >=20
> > > +		BUG();
> >=20
> > I am completely against of leaving BUG() here. Several fixes of syzbot =
issues
> > were the exchanging BUG() on returning error code. I don't want to inve=
stigate
> > the another syzbot issue that will involve this BUG() here. Let's retur=
n error
> > code here.
> >=20
> > Usually, it makes sense to have BUG() for debug mode and to return erro=
r code
> > for the case of release mode. But we don't have the debug mode for HFS =
code.
>=20
> I prefer BUG() because I think it is a serious bug that we should not
> allow for a bad inode to be written. I am willing to take responsibility
> for investigating further issues if they appear as a result of this. Of
> course, the final say on BUG() or -EIO is yours as the maintainer.
>=20
> >=20

The hfs_write_inode() will return error code and it is also bug case. But we
will not crash the kernel in such case. Why would you still like to crash t=
he
kernel? :)

I see your point that we should not be here because we must create the bad =
inode
in hfs_read_inode() for the case of corrupted Catalog File's records. Let me
sleep on it. :)

Thanks,
Slava.

