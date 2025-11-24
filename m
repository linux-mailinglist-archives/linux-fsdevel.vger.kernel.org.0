Return-Path: <linux-fsdevel+bounces-69716-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF7AC827CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 22:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2508D3A22D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 21:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC6C32C931;
	Mon, 24 Nov 2025 21:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g2eOmBFl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF32727E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018741; cv=fail; b=qmzFx2OMWhlLFJ6ybz6Rj90zq4W4aDQ5xDoG1xjCXWrjbp+RTyNIkjkTRConORfntMOjdEX8tYum36v38v96GZnmRSqWY341eUJ8OP+tg8D9Uqkx79Upx4gx42Gyi+I2RA9dYUcpNx8JX0u/aQEaPsfmKot2cyw/NCe4ZQZJZQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018741; c=relaxed/simple;
	bh=5/tzONYcFknQe0/4QFeRgSgGmZDR2NQ1XWeNEFyM6yU=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=D/VekAZupxHd6w5261x02uS9j4yNs1gQ5ydNNwfbUTjTk7Y/OQ2CAtHoXKH/BQbhzgnTyEd0GWWeDbKXqWSZSwhscD/GgMy8Se+ntSAemmOSE3eD6QG7DBMFQxRRipbIsnJ8uZb6VMcNAHx1GBaRNPVbqPpLXhvjCgOmELuMQzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g2eOmBFl; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AOGdJcL029430
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 21:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=j1kPFai4aMrdH01iJjgofjPHstn0mTaYlix4PXmk8vw=; b=g2eOmBFl
	tiVZo8A5NXbTbIXoaGXlZmJe9YGu/IFRXuq9QDaJPCaXeGh2gJkKgwsqQDVGMtkU
	yHiAtv9ySaKTwJ8aT+B5dDkUkXTZ9SPNe7RMZtFNdRzkhPk9kKPHHhnZafHoaCD4
	GF6K0DII/vEUDbUlqxm7bbeIcbfwR3fs9ZIs1e8SMgw/Oez9YVvi7MuC5yC1URlI
	9jzNfh3lYHxTnPVvkTiMgV7b4nRFtg8c1+QrJO0v0v2FXFOw9vpXaCA3lj74Us+X
	Z8h1qrHcEcMRmerFcMuG4PkmfEqSY/seK8UNechM7DTjwGhp8ef89S+qvGOAvbV4
	YGA8oni1/nvs7A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kpstv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 21:12:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AOL8PCg023827
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 21:12:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kpstut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 21:12:15 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AOKrdFT028989;
	Mon, 24 Nov 2025 21:12:15 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kpstuq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Nov 2025 21:12:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8LzoKmg0K455bUMRZA4SuETH14UaWqL1Ct4DwYEl+qnLKsViHcOw1Uek1pku0pCKcBNdh5ZMAFUNhkCldK0bVf3I2NtwDWqf8/7Qzw8Y6nOxco7RexK4df+s/AzmE3HNFs9XmWNmWg3F90qVzAabh8mKZOAaeAxtlCYzfNa09cJDg2t623wXeF7bN2wmS1FewABakjDaZnw8z3p7igBWZyprer2PiAIqf1J1dAGKCWe7b9wJSL6WkDNMQtUjw5Lcoqj8CU9ujPLYtvngcaoznLg+Zt7GcVvPmMaGJDc4Oag9Jd34y6BYSCR/fEahJ44/vFjpVfDZJI5uED05EW75w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWLEQZic7pISd4RzmfyUW+kuuoNS63GlVyT/ApTkTgA=;
 b=B59m3tyi1ROecBIcw7hhbKOVGe5tUj0NwCfNrbPkyZfnKQBee+JwHivbL02tqw3ATcD/SMBYINZiZh0ZdJ6TP2uJlmdj7iEug8glkyrj9z1VwGAtd5qY0o6UWJaPNJUSGd5UcJ1Cr8zE71C4TLqFRTDc2ck1iCZL4iwtokNZr1TK+NXFQ+TKlKtSO2K0lBpBoLzzqHq2y2RNamU/pf38ClQjkw2GOOzISLgVQ71jDUrQ743GEN23O1wDew7mUFLDkG0HU6e0e+2HTtffobMTNZf3nOq4uYwNqsGCPtIgLjYfD0ZSFVx5782q/azUACw+FW3dDB8O0GO3YhIUMQgJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BLAPR15MB3940.namprd15.prod.outlook.com (2603:10b6:208:27c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 21:12:11 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9343.016; Mon, 24 Nov 2025
 21:12:11 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Patrick Donnelly <pdonnell@redhat.com>,
        Gregory Farnum <gfarnum@redhat.com>,
        Alex Markuze <amarkuze@redhat.com>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] ceph: fix kernel crash in ceph_open()
Thread-Index:
 AQHcWaV/RIaAnir5XkifXtXvNFHQibT6mqKAgAADQICAAAQCAIAA/JgAgABjqoCABjjgAIAAH60A
Date: Mon, 24 Nov 2025 21:12:11 +0000
Message-ID: <9534e58061c7832826bbd3500b9da9479e8a8244.camel@ibm.com>
References: <20251119193745.595930-2-slava@dubeyko.com>
	 <CAOi1vP-bjx9FsRq+PA1NQ8fx36xPTYMp0Li9WENmtLk=gh_Ydw@mail.gmail.com>
	 <fe7bd125c74a2df575c6c1f2d83de13afe629a7d.camel@ibm.com>
	 <CAJ4mKGZexNm--cKsT0sc0vmiAyWrA1a6FtmaGJ6WOsg8d_2R3w@mail.gmail.com>
	 <370dff22b63bae1296bf4a4c32a563ab3b4a1f34.camel@ibm.com>
	 <CAPgWtC58SL1=csiPa3fG7qR0sQCaUNaNDTwT1RdFTHD2BLFTZw@mail.gmail.com>
	 <183d8d78950c5f23685c091d3da30d8edca531df.camel@ibm.com>
	 <CAPgWtC7AvW994O38x4gA7LW9gX+hd1htzjnjJ8xn-tJgP2a8WA@mail.gmail.com>
In-Reply-To:
 <CAPgWtC7AvW994O38x4gA7LW9gX+hd1htzjnjJ8xn-tJgP2a8WA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BLAPR15MB3940:EE_
x-ms-office365-filtering-correlation-id: 36ff5e79-309a-4f86-2e82-08de2b9e2242
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MWg3MnN5dGVaZStFVmVYb1NnVUpXQnE2ajFLZkowSnhEUTA4dHVhcTJLRnUr?=
 =?utf-8?B?am9xNXlQSWRFcnM1Rkk2ek5TblRyNVo2WFd5SElqNmJqOGJrVmJUdkhVa3lS?=
 =?utf-8?B?UzFJcUxvM2wvOFpCTG5BNWtjcVdDOEhGTDNkdG9uenhBT3FRSWRjb1Y3ZURO?=
 =?utf-8?B?T2F2OEI2dk5hOGxNcDBaTmQ0ZWh1OWZKb2lwSVRKcXJhWmtWMzRPS0hiSzRy?=
 =?utf-8?B?NVIvNlhjM1h0MExWMml6bTdORXlIVG8zK0V4d2Y3eU1PVWZuRmpNNUh4aUdu?=
 =?utf-8?B?ejJoand5WmRDN2ZkempWbStUaWw4VmNGYXBhZStGQU9qUXhXUU1aNUdlRXRl?=
 =?utf-8?B?RUQ3N3c2Nit4M2g5ejg1bFNsM21GMU5DS2gvNUNtc3NLdHJuME5WMDJXcjhV?=
 =?utf-8?B?Q0ZqbitZWTJBY0owNmZRRlcwTFRhS0xDZTZFU29jUDU4L3lkZml0Z2RMTUkr?=
 =?utf-8?B?clVlU3dwZ3hQaTYyK2FkK0pONlpFYVNKNUJ3NXFYYXVPWnhvUXFxNUNOa0Rj?=
 =?utf-8?B?RjJzMnRURXQ4UDBRTWlBSGU4dTQvVWw1WjNvcVBGUlNFZ2lXN1Y5cTJGcDh4?=
 =?utf-8?B?VW42VnEzZU0wUVMxOUkzUW0wUnZJMFNna2hRaXBFLzJ0UUlBbEE0SVUvOEx0?=
 =?utf-8?B?am8rdy9sUFJoTElEejRldWRQTDY2UStLUUw4VE90MnA3eElibjVnd1M2a2R3?=
 =?utf-8?B?ZGJVSzRiVXEvcGxzaTk2cGxFUDZ5clBXYmV1RmtOY0lZQXVMZlFPemJsRlA0?=
 =?utf-8?B?Q09WYjNRZnZwTnhyQklFdmNLd3BHU1c2ZHJnM3FxNWMvaTBlR3QvS3dSbmFV?=
 =?utf-8?B?bkI3L0tTQ0ljMVRxMEptYWRTZWVIcFNZZHE1dWNSSlpZRTU4cFhwc0xVMU5n?=
 =?utf-8?B?dVVGb0ZxcnRrNmRnMG1HVENxRnlIVXVYRy9QTkpqSHlybFJocUJtU3E5Um9V?=
 =?utf-8?B?eVM1N0pwVk9oRmFvWE5rUHh2Y0xhTDRKQmZDTXF2SzhsL2x1WkJxSFJkaFRj?=
 =?utf-8?B?V2VEOUEyVytrQ1ZvejBNSkJ3a3lrdVo5a3BiSHlkYzIremRJWHdVTHdIVFZI?=
 =?utf-8?B?QmhHOGNLc0tVV1BJWXJsTSs4TFVoOUEzb3FBdC9wQ0liaXBZTUpFK2lXSXFt?=
 =?utf-8?B?V1pFV0N5RisyMGRRUFB1bnpUOEdWRzczWXhYWjB4ZlVJamlZNEh5UWE5NWZ0?=
 =?utf-8?B?eHFQcVpuc3o1ZEtnV0FFRDBMVEt4d1ExRkFpT0NYTjI5eHNBeWhlMU00Wjd3?=
 =?utf-8?B?eHBJcW85THA4eWI4NWpGZWJjQjB2OVRZK09tQWFzQlVXUkw3OU5aSThaUFFt?=
 =?utf-8?B?QUJraXlpZCtUOC9xOTdydUk0bnowUTRCb0s4OEhQOXA2UHQ5TzE1My84NGs4?=
 =?utf-8?B?UTA2TG5sVy94a1NjOUNxTlUweUZUMnFSTUVMY1FPN1FHNGJrYnNLbTFNampK?=
 =?utf-8?B?Y1VkemVrU0FsWlQ4OWZKMUQyQ1hHQTNIcUFWTmZDdUFSOFZURU5DaEdjdjkw?=
 =?utf-8?B?dktaQ1QyZWhHbGxwbjFNNFV0bkZqUG5lQS85TUZYUnU3LzZDTXlwNXEwNFNs?=
 =?utf-8?B?VjYvaEtBUXVkSkl5aUVmQmxZa2lWeDZKcGFORHVvL01rbFd6WDVmaUM0UzJW?=
 =?utf-8?B?MmZZWkN4bWFoNE4zYWtiQ2lyVkFST1M1UnNrdVRrdHpranRvcjhSWUpvUmV3?=
 =?utf-8?B?UWljTjZidDFFNDREeXRNdUgydEZMa3g1K0lQaDdmRUdBWmlGdUN6MmNadEdh?=
 =?utf-8?B?V2R3K2J3b01Nem1HRFpKUitLczlTblhCYUs5R0kxMCs4YzcyZXd2MFlzdXQ1?=
 =?utf-8?B?M0lab25CR2tBcC9UR2VXY1VOVzEvSGRIKzg5L1pqMmtBK1IxdUdzaHFEcWs5?=
 =?utf-8?B?NDk0NGRtbTNRdmFETGczNWZnbkdjMEJaa0V2WVhXTnVWR2NzL2pDYTJFVkdS?=
 =?utf-8?B?bmxGSDBJNnNKTi9QRzI1SmtCZkx2MGV4cVhaeHNmbUM1ZTVnQXdMQndmWG91?=
 =?utf-8?B?MElIRElBVzNnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OExMcmhnWFIzUWcvYmRMNXZ6MVJ3RFR1KzBvRzIzbW9scWg2UHJ5WFU4VktZ?=
 =?utf-8?B?RmZ6RCtxdktEZXdCZ3hLdVhsNmQrdEtFeWVvOWhBQWtWTmlaT01TMlhEUncv?=
 =?utf-8?B?VlhDdi9nUzEwMFVRV3NsOTBQUTlYbHJOMlorbDhUZHk5WWl2bnc3N3F5R2FL?=
 =?utf-8?B?Y2Z6T0Nhd283OVZyQStiM2NMY25PRWxOTTczVXpOSUZyRjdmVHhBTmU2WnpB?=
 =?utf-8?B?YjIvQWhCbjI1dDJCQjFUQzA2RGg1KzR6SG9jK29pV3Z2WVBaZmRubkxMZnQz?=
 =?utf-8?B?OVphWDN2dno3UVAzdFNacG1pYmNLMk85aHRzTFVMMzdsa2xtV2I1L0VGaXUr?=
 =?utf-8?B?NnU4bUowWHNUU0pUR1lNV0o3dkdWN2N3RXQvZCs5Y1YzU1ZmbU9zdzFKalVK?=
 =?utf-8?B?R2xBb2hBSlJvSlpmd2RsWTZDT0NNU3RTNEQwMUpkeDRuR2hWR2xQR0hZVUdt?=
 =?utf-8?B?VUFIOVB0L0UxcnBES09OM1ZzeFlldXpLTlNSdW9oS0RqaXFoTmhKbzVsRWx5?=
 =?utf-8?B?UktkbjNiRmdTSHJseFUveCtXejMrbTlYYndWa294TWZTN3I2WFdmSnVmSVRy?=
 =?utf-8?B?c1lOZ0poNE9YU1Jjc0hOVURPMVdQZFYwdzFqVThPclhEUGFEOEJkNmwwdkJo?=
 =?utf-8?B?cStpMTBmQVNEMGJqYkFsWXlQeXNENWJZaW1CVjJGb2tONkNWQ2krUkt3L294?=
 =?utf-8?B?WmpreFY2bE9TeFEvTS9ZeHc0eWJkT3YzWVQ3aXNOemJsL3lyUmRhNHlHZzA1?=
 =?utf-8?B?c0ZJRTczcFU5ZG5KOW5TbDFDUWs2RTVhc3czQ1AxOWlsSjFTejdVTlF4Tkh6?=
 =?utf-8?B?WFhacjBWb0Y0MHNtc3VPME0zeFU4aEI4YlBvTzBJY25rdkUrRkUyaGlMYnpK?=
 =?utf-8?B?TVc0NndSQlNyNnpGUThjVnpLZ1BsT1JZZ0pobVErSmZzZENTZ3kvandDNGls?=
 =?utf-8?B?M3BqaFpwR3pDVXN1L3grN0lkWUFsSVNNUFU5ank5RzU3aFZoUmRRMTN4dkNv?=
 =?utf-8?B?enR6Rk1hUjR4eHJJcG9KMnJwdmFUb2g3RGlnY1JqdDRwQ2hZbzFqYmRSYU14?=
 =?utf-8?B?NklkOHBQOVlmeFBOdUJkQlo1TFhUUnY4dWpFRUs1dENmVzhLMEVubmg2dDM3?=
 =?utf-8?B?ZTRWVXRaV2pnVFRuenVVY2tPOGxpU1p1cUk1Nzc5aVFQem03anZLdytkRHlU?=
 =?utf-8?B?ZkxVcldHOVhmNlZ0WWRYQ0JBdW0wTXRRZ3NzT1JFbmx3QWxxSyt4anQ3bFZZ?=
 =?utf-8?B?cC92Q1hKajNpUm9WQmFTVmgyNTd2Mi9RbjJkK0xyV3M4ckxJTG5SbnR0Ty9j?=
 =?utf-8?B?K05mY3IxM2dFbDdHMEJzMFd3dk5vK2dmeThJdHF0NkJFcW1jdkRPUkdkMFFY?=
 =?utf-8?B?VU5VVUdyeWFlM0EyVjNDTDFLK003S25uSGozVWZSUnVraXlBMkpqbjQyUjc1?=
 =?utf-8?B?TUlQNS9mVWk1YXRlUHZOejJmVTRJRXVnN0FRN1VOZ1lhS2pyaDZMOFBTRU1i?=
 =?utf-8?B?akxJanRSMFFHMERzZVlUYzMxd1g1M3QvWGk4TlR6UzU4eGlRZytLVUhaRXFo?=
 =?utf-8?B?azU3L2NVc0xIWnhXcDdBSTJTYkkrNWFYU29GbXhzUGZSLzg3d0Jsb2dqcTRW?=
 =?utf-8?B?M3A5U3ZPQTR1bVN3MEViZUx1V0ZUZmFBNTF2ck1rWUw2ajFSZzE4d3l2OHVr?=
 =?utf-8?B?a1BHbDBKbk5WUGZjMlpTMXQrU1dYSDJJdVlNbTZ0cURUWU1hdDBzT0paOWpu?=
 =?utf-8?B?UW81Y0ZFYytBVHZEN2ZpcjdQeE95TmQzanpybHNZb000bGhnTHdVd3JTLzR2?=
 =?utf-8?B?SWhiK1pVcys1YVY1VUZYRVFRVUFzWUVnTFc5SGpDY0xyYml0a2tpYXZJeDhl?=
 =?utf-8?B?WGYyWlBuL2Z5SkluTkpiTndZeEtHdGRPYmJMMTVXYUM5aG4ySTJiZEVwT2Jk?=
 =?utf-8?B?ajFkRGd5L0wyc25zOTVreTNJWVBuZWxrek5YS2VLZkJDd2NwbzQxM3BEQWlI?=
 =?utf-8?B?VTV4blZ0ajlpTUh1VlhKd0hjNjBaVjN0VjRpSGFXNU9OZmphQ0JNcGJ6bDhR?=
 =?utf-8?B?VXVabTMybUNkc1lhd25NQmpXWGVUZ2ZFT1NuS2ZqZkYxTlJZbXozaE1Bcmto?=
 =?utf-8?B?SEllT3FOVWtwcnQ4MHBJc1dkUDlhbjNKZUxNRXNXNHplNTcwU25kSmdDakdP?=
 =?utf-8?Q?eG4K+QhljWdEgQ6fj+4dDbg=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ff5e79-309a-4f86-2e82-08de2b9e2242
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2025 21:12:11.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHsUo+OGeDxvHihHbtsfkyiC7dQirXSrAAdOkeYiQiNHEY4KidSlcdiTNoC7guSFTcqPx4u9yQ9bKnysRLh4pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3940
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX0Dtr/FSjOFLO
 IyRfa75luDGeykJNgEjgrzQHHrhmFjb756qk3BGmL4dT4iHO5PdQhkOGEVFFjHya70esVIG12rL
 EqFr6N3zyl7UVln/wEwWz4FooFjyEA7dX1Qe6efDlhpwKpdM6v2njYpDEVOxLTqfNn6zGXoI/Qh
 2ohe5JJKI4jl8FySNtiWEKZKkEb47oiqB2duL4YOa2wnrTtYKRZybB0+rk1PXN5hXYAGIetXwlw
 LSQrzxOUg2GYeHIs+1focC8avQHZV+kCeJQK68SN9cVwda0TAMy3qp6I4acIpAyhJ3jEaVqS44F
 gamNggs0MbGo9oVxnkqObYoe4FP86rdaLJfQHLhmfis8D2n272sCQecuUSxJtDyLWF3TxXy7Y5c
 Y6tZH5m7k5lE+bOVXuYy1Tvhb6dT6A==
X-Proofpoint-ORIG-GUID: fognmEwbsfK16kl9IguF_CMhFkHUQB79
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=6924ca2f cx=c_pps
 a=IGlUesXJXvI2YQKUC5af4g==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8
 a=wCmvBT1CAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=OIUs6w6V8npOCYi9xQUA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-GUID: xM6OS2RPdZcexNVC3hODkz3midV2OE9q
Content-Type: text/plain; charset="utf-8"
Content-ID: <02595A85D9993A44B48E217A6BAA3D44@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_08,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=2 engine=8.19.0-2510240000
 definitions=main-2511220000

On Tue, 2025-11-25 at 00:48 +0530, Kotresh Hiremath Ravishankar wrote:
> On Fri, Nov 21, 2025 at 1:47=E2=80=AFAM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >=20
> > On Thu, 2025-11-20 at 19:50 +0530, Kotresh Hiremath Ravishankar wrote:
> > > Hi All,
> > >=20
> > > I think the patch is necessary and fixes the crash. There is no harm
> > > in taking this patch as it behaves like an old kernel with this
> > > particular scenario.
> > >=20
> > > When does the issue happen:
> > >    - The issue happens only when the old mount syntax is used where
> > > passing the file system name is optional in which case, it chooses the
> > > default mds namespace but doesn't get filled in the
> > > mdsc->fsc->mount_options->mds_namespace.
> > >    - Along with the above, the mount user should be non admin.
> > > Does it break the earlier fix ?
> > >    - Not fully!!! Though the open does succeed, the subsequent
> > > operation like write would get EPERM. I am not exactly able to
> > > recollect but this was discussed before writing the fix 22c73d52a6d0
> > > ("ceph: fix multifs mds auth caps issue"), it's guarded by another
> > > check before actual operation like write.
> > >=20
> > > I think there are a couple of options to fix this cleanly.
> > >  1. Use the default fsname when
> > > mdsc->fsc->mount_options->mds_namespace is NULL during comparison.
> > >  2. Mandate passing the fsname with old syntax ?
> > >=20
> >=20
> > Anyway, we should be ready operate correctly if fsname or/and auth-
> > > match.fs_name are NULL. And if we need to make the fix more cleanly, =
then we
> > can introduce another patch with nicer fix.
> >=20
> > I am not completely sure how default fsname can be applicable here. If I
> > understood the CephFS mount logic correctly, then fsname can be NULL du=
ring some
> > initial steps. But, finally, we will have the real fsname for compariso=
n. But I
> > don't know if it's right of assuming that fsname =3D=3D NULL is equal t=
o fsname =3D=3D
> > default_name.
>=20
> We are pretty sure fsname is NULL only if the old mount syntax is used
> without providing the
> fsname in the optional arg. I believe kclient knows the fsname that's
> mounted somewhere in this case ?
> I am not sure though. If so, it can be used. If not, then can we rely
> on what mds sends as part
> of the mdsmap?
>=20
> With this fix, did the tests run fine ?
>=20

The xfstests works fine with the fix. I don't see any issues with the it.

> Aren't you hitting this error
> https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mdsmap.c#L365 =
=20
> ?
>=20

I am not sure how this error can be triggered. I see this sequence:

Nov 24 12:51:10 ceph-0005 kernel: [   89.621635] ceph:          super.c:63 =
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] begin
Nov 24 12:51:10 ceph-0005 kernel: [   89.624691] ceph:          super.c:117=
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] done
Nov 24 12:51:10 ceph-0005 kernel: [   89.625349] ceph:          super.c:63 =
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] begin
Nov 24 12:51:10 ceph-0005 kernel: [   89.627776] ceph:          super.c:117=
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] done
Nov 24 12:51:10 ceph-0005 kernel: [   89.645611] ceph:          super.c:63 =
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] begin
Nov 24 12:51:10 ceph-0005 kernel: [   89.652534] ceph:          super.c:117=
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] done
Nov 24 12:51:10 ceph-0005 kernel: [   89.654695] ceph:          super.c:63 =
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] begin
Nov 24 12:51:10 ceph-0005 kernel: [   89.656220] ceph:          super.c:117=
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] done

Nov 24 12:51:10 ceph-0005 kernel: [   89.678877] ceph:           file.c:389=
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] 000000000e172927
10000000000.fffffffffffffffe file 00000000c51edc48 flags 65536 (32768)
Nov 24 12:51:10 ceph-0005 kernel: [   89.680523] ceph:     mds_client.c:283=
2 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] on 000000005248a4a0 41 built
10000000000 '/'
Nov 24 12:51:10 ceph-0005 kernel: [   89.681343] ceph:     mds_client.c:577=
9 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] tpath '/', mask 4, caller_uid=
 0,
caller_gid 0
Nov 24 12:51:10 ceph-0005 kernel: [   89.682296] ceph:     mds_client.c:566=
4 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] fsname check fs_name=3D(null)=
=20
match.fs_name=3Dcephfs
Nov 24 12:51:10 ceph-0005 kernel: [   89.683134] BUG: kernel NULL pointer
dereference, address: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.683603] #PF: supervisor read acces=
s in
kernel mode
Nov 24 12:51:10 ceph-0005 kernel: [   89.683969] #PF: error_code(0x0000) - =
not-
present page
Nov 24 12:51:10 ceph-0005 kernel: [   89.684311] PGD 0 P4D 0=20
Nov 24 12:51:10 ceph-0005 kernel: [   89.684496] Oops: Oops: 0000 [#2] SMP =
KASAN
NOPTI
Nov 24 12:51:10 ceph-0005 kernel: [   89.684843] CPU: 1 UID: 0 PID: 3406 Co=
mm:
xfs_io Tainted: G      D             6.18.0-rc6+ #64 PREEMPT(voluntary)=20
Nov 24 12:51:10 ceph-0005 kernel: [   89.685535] Tainted: [D]=3DDIE
Nov 24 12:51:10 ceph-0005 kernel: [   89.685738] Hardware name: QEMU Standa=
rd PC
(i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
Nov 24 12:51:10 ceph-0005 kernel: [   89.686351] RIP: 0010:strcmp+0x1c/0x40
Nov 24 12:51:10 ceph-0005 kernel: [   89.686578] Code: 90 90 90 90 90 90 90=
 90
90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 =
01 84
d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 c=
c cc
cc cc 31
Nov 24 12:51:10 ceph-0005 kernel: [   89.687550] RSP: 0018:ffff8881035c76e0
EFLAGS: 00010246
Nov 24 12:51:10 ceph-0005 kernel: [   89.687870] RAX: 0000000000000000 RBX:
ffff88810bc59600 RCX: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.688252] RDX: 0000000000000063 RSI:
0000000000000000 RDI: ffff888110739020
Nov 24 12:51:10 ceph-0005 kernel: [   89.688654] RBP: ffff8881035c77c8 R08:
0000000000000000 R09: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.689126] R10: 0000000000000000 R11:
0000000000000000 R12: dffffc0000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.689516] R13: ffff88811e104000 R14:
0000000000000000 R15: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.689918] FS:  000070f659aac840(0000)
GS:ffff88825f422000(0000) knlGS:0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.690338] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 24 12:51:10 ceph-0005 kernel: [   89.690659] CR2: 0000000000000000 CR3:
00000001a0ebe003 CR4: 0000000000772ef0
Nov 24 12:51:10 ceph-0005 kernel: [   89.691092] PKRU: 55555554
Nov 24 12:51:10 ceph-0005 kernel: [   89.691273] Call Trace:
Nov 24 12:51:10 ceph-0005 kernel: [   89.691433]  <TASK>
Nov 24 12:51:10 ceph-0005 kernel: [   89.691575]  ?
ceph_mds_check_access+0x348/0x1760
Nov 24 12:51:10 ceph-0005 kernel: [   89.691851]  ?
__kasan_check_write+0x14/0x30
Nov 24 12:51:10 ceph-0005 kernel: [   89.692089]  ? lockref_get+0xb1/0x170
Nov 24 12:51:10 ceph-0005 kernel: [   89.692320]  ceph_open+0x322/0xef0
Nov 24 12:51:10 ceph-0005 kernel: [   89.692557]  ? __pfx_ceph_open+0x10/0x=
10
Nov 24 12:51:10 ceph-0005 kernel: [   89.692801]  ?
__pfx_apparmor_file_open+0x10/0x10
Nov 24 12:51:10 ceph-0005 kernel: [   89.693078]  ?
__ceph_caps_issued_mask_metric+0xd6/0x180
Nov 24 12:51:10 ceph-0005 kernel: [   89.693405]  do_dentry_open+0x7bf/0x10=
e0
Nov 24 12:51:10 ceph-0005 kernel: [   89.693649]  ? __pfx_ceph_open+0x10/0x=
10
Nov 24 12:51:10 ceph-0005 kernel: [   89.693870]  vfs_open+0x6d/0x450
Nov 24 12:51:10 ceph-0005 kernel: [   89.694097]  ? may_open+0xec/0x370
Nov 24 12:51:10 ceph-0005 kernel: [   89.694283]  path_openat+0x2017/0x50a0
Nov 24 12:51:10 ceph-0005 kernel: [   89.694520]  ? __pfx_path_openat+0x10/=
0x10
Nov 24 12:51:10 ceph-0005 kernel: [   89.694918]  ?
__pfx_stack_trace_save+0x10/0x10
Nov 24 12:51:10 ceph-0005 kernel: [   89.695284]  ?
stack_depot_save_flags+0x28/0x8f0
Nov 24 12:51:10 ceph-0005 kernel: [   89.695572]  ? stack_depot_save+0xe/0x=
20
Nov 24 12:51:10 ceph-0005 kernel: [   89.695864]  do_filp_open+0x1b4/0x450
Nov 24 12:51:10 ceph-0005 kernel: [   89.696271]  ?
__pfx__raw_spin_lock_irqsave+0x10/0x10
Nov 24 12:51:10 ceph-0005 kernel: [   89.696712]  ? __pfx_do_filp_open+0x10=
/0x10
Nov 24 12:51:10 ceph-0005 kernel: [   89.697089]  ? __link_object+0x13d/0x2=
b0
Nov 24 12:51:10 ceph-0005 kernel: [   89.697426]  ?
__pfx__raw_spin_lock+0x10/0x10
Nov 24 12:51:10 ceph-0005 kernel: [   89.697801]  ?
__check_object_size+0x453/0x600
Nov 24 12:51:10 ceph-0005 kernel: [   89.698216]  ? _raw_spin_unlock+0xe/0x=
40
Nov 24 12:51:10 ceph-0005 kernel: [   89.698556]  do_sys_openat2+0xe6/0x180
Nov 24 12:51:10 ceph-0005 kernel: [   89.698905]  ?
__pfx_do_sys_openat2+0x10/0x10
Nov 24 12:51:10 ceph-0005 kernel: [   89.699280]  __x64_sys_openat+0x108/0x=
240
Nov 24 12:51:10 ceph-0005 kernel: [   89.699625]  ?
__pfx___x64_sys_openat+0x10/0x10
Nov 24 12:51:10 ceph-0005 kernel: [   89.700038]  x64_sys_call+0x134f/0x2350
Nov 24 12:51:10 ceph-0005 kernel: [   89.700371]  do_syscall_64+0x82/0xd50
Nov 24 12:51:10 ceph-0005 kernel: [   89.700684]  ? do_syscall_64+0xba/0xd50
Nov 24 12:51:10 ceph-0005 kernel: [   89.701030]  ?
irqentry_exit_to_user_mode+0x2e/0x2a0
Nov 24 12:51:10 ceph-0005 kernel: [   89.701409]  ? irqentry_exit+0x43/0x50
Nov 24 12:51:10 ceph-0005 kernel: [   89.701595]  ? exc_page_fault+0x95/0x1=
00
Nov 24 12:51:10 ceph-0005 kernel: [   89.701793]=20
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Nov 24 12:51:10 ceph-0005 kernel: [   89.702066] RIP: 0033:0x70f6599145ab
Nov 24 12:51:10 ceph-0005 kernel: [   89.702266] Code: 25 00 00 41 00 3d 00=
 00
41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff =
ff ff
b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 6=
4 48
2b 14 25
Nov 24 12:51:10 ceph-0005 kernel: [   89.703191] RSP: 002b:00007ffc93ebcfc0
EFLAGS: 00000246 ORIG_RAX: 0000000000000101
Nov 24 12:51:10 ceph-0005 kernel: [   89.703557] RAX: ffffffffffffffda RBX:
0000000000000002 RCX: 000070f6599145ab
Nov 24 12:51:10 ceph-0005 kernel: [   89.703940] RDX: 0000000000000000 RSI:
00007ffc93ebf786 RDI: 00000000ffffff9c
Nov 24 12:51:10 ceph-0005 kernel: [   89.704288] RBP: 00007ffc93ebf786 R08:
00007ffc93ebd270 R09: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.704624] R10: 0000000000000000 R11:
0000000000000246 R12: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.704986] R13: 00000000ffffffff R14:
0000000000000180 R15: 0000000000000001
Nov 24 12:51:10 ceph-0005 kernel: [   89.705329]  </TASK>
Nov 24 12:51:10 ceph-0005 kernel: [   89.705453] Modules linked in:
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_co=
re
pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec
kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_in=
tel
input_leds psmouse rapl vga16fb serio_raw vgastate floppy i2c_piix4 mac_hid
qemu_fw_cfg i2c_smbus bochs pata_acpi sch_fq_codel rbd msr parport_pc ppdev=
 lp
parport efi_pstore
Nov 24 12:51:10 ceph-0005 kernel: [   89.707505] CR2: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.707692] ---[ end trace 00000000000=
00000
]---
Nov 24 12:51:10 ceph-0005 kernel: [   89.707965] RIP: 0010:strcmp+0x1c/0x40
Nov 24 12:51:10 ceph-0005 kernel: [   89.708167] Code: 90 90 90 90 90 90 90=
 90
90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 =
01 84
d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 c=
c cc
cc cc 31
Nov 24 12:51:10 ceph-0005 kernel: [   89.709139] RSP: 0018:ffff8881b8faf600
EFLAGS: 00010246
Nov 24 12:51:10 ceph-0005 kernel: [   89.709394] RAX: 0000000000000000 RBX:
ffff88810bc59600 RCX: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.709760] RDX: 0000000000000063 RSI:
0000000000000000 RDI: ffff888110739020
Nov 24 12:51:10 ceph-0005 kernel: [   89.710125] RBP: ffff8881b8faf6e8 R08:
0000000000000000 R09: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.710513] R10: 0000000000000000 R11:
0000000000000000 R12: dffffc0000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.710874] R13: ffff88811e104000 R14:
0000000000000000 R15: 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.711244] FS:  000070f659aac840(0000)
GS:ffff88825f422000(0000) knlGS:0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.711687] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 24 12:51:10 ceph-0005 kernel: [   89.712009] CR2: 0000000000000000 CR3:
00000001a0ebe003 CR4: 0000000000772ef0
Nov 24 12:51:10 ceph-0005 kernel: [   89.712376] PKRU: 55555554

Nov 24 12:51:10 ceph-0005 kernel: [   89.807353] ceph:          super.c:414=
  :
ceph_parse_mount_param: fs_parse 'source' token 12
Nov 24 12:51:10 ceph-0005 kernel: [   89.807983] ceph:          super.c:342=
  :
'192.168.1.213:3300:/scratch'
Nov 24 12:51:10 ceph-0005 kernel: [   89.808750] ceph:          super.c:366=
  :
device name '192.168.1.213:3300'
Nov 24 12:51:10 ceph-0005 kernel: [   89.809361] ceph:          super.c:368=
  :
server path '/scratch'
Nov 24 12:51:10 ceph-0005 kernel: [   89.809813] ceph:          super.c:370=
  :
trying new device syntax
Nov 24 12:51:10 ceph-0005 kernel: [   89.809815] ceph:          super.c:280=
  :
separator '=3D' missing in source
Nov 24 12:51:10 ceph-0005 kernel: [   89.810219] ceph:          super.c:375=
  :
trying old device syntax
Nov 24 12:51:10 ceph-0005 kernel: [   89.810763] ceph:          super.c:129=
9 :
ceph_get_tree
Nov 24 12:51:10 ceph-0005 kernel: [   89.812515] ceph:          super.c:123=
6 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] 0000000003c37076
Nov 24 12:51:10 ceph-0005 kernel: [   89.813215] ceph:          super.c:123=
9 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] monitor(s)/mount options don't
match
Nov 24 12:51:10 ceph-0005 kernel: [   89.814018] ceph:          super.c:123=
6 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] 000000005e011a18
Nov 24 12:51:10 ceph-0005 kernel: [   89.814618] ceph:          super.c:123=
9 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] monitor(s)/mount options don't
match
Nov 24 12:51:10 ceph-0005 kernel: [   89.815493] ceph:          super.c:123=
6 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] 0000000003c37076
Nov 24 12:51:10 ceph-0005 kernel: [   89.816133] ceph:          super.c:123=
9 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175980] monitor(s)/mount options don't
match
Nov 24 12:51:10 ceph-0005 kernel: [   89.816830] ceph:          super.c:123=
6 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] 000000005e011a18
Nov 24 12:51:10 ceph-0005 kernel: [   89.817528] ceph:          super.c:123=
9 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175977] monitor(s)/mount options don't
match
Nov 24 12:51:10 ceph-0005 kernel: [   89.818320] ceph:          super.c:119=
9 :
[00000000-0000-0000-0000-000000000000 0] 00000000ce5cc894
Nov 24 12:51:10 ceph-0005 kernel: [   89.818919] ceph:          super.c:133=
5 :
get_sb using new client 000000006de70127
Nov 24 12:51:10 ceph-0005 kernel: [   89.819741] ceph:          super.c:114=
5 :
[00000000-0000-0000-0000-000000000000 0] mount start 000000006de70127
Nov 24 12:51:10 ceph-0005 kernel: [   89.826429] libceph: mon0
(2)192.168.1.213:3300 session established
Nov 24 12:51:10 ceph-0005 kernel: [   89.829158] ceph:     mds_client.c:619=
6 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] epoch 4346 len 1220
Nov 24 12:51:10 ceph-0005 kernel: [   89.829955] ceph:     mds_client.c:506=
0 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] new 4346 old 0
Nov 24 12:51:10 ceph-0005 kernel: [   89.831138] libceph: client175983 fsid
31977b06-8cdb-42a9-97ad-d6a7d59a42dd
Nov 24 12:51:10 ceph-0005 kernel: [   89.831780] ceph:          super.c:116=
8 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mount opening path 'scratch'
Nov 24 12:51:10 ceph-0005 kernel: [   89.832570] ceph:          super.c:105=
5 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] opening 'scratch'
Nov 24 12:51:10 ceph-0005 kernel: [   89.833170] ceph:     mds_client.c:379=
6 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] do_request on 000000004bf8d029
Nov 24 12:51:10 ceph-0005 kernel: [   89.833823] ceph:     mds_client.c:372=
4 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] submit_request on 000000004bf=
8d029
for inode 0000000000000000
Nov 24 12:51:10 ceph-0005 kernel: [   89.834644] ceph:     mds_client.c:118=
3 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] 000000004bf8d029 tid 1
Nov 24 12:51:10 ceph-0005 kernel: [   89.835278] ceph:     mds_client.c:143=
4 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] chose random mds0
Nov 24 12:51:10 ceph-0005 kernel: [   89.835886] ceph:     mds_client.c:984=
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] realloc to 1
Nov 24 12:51:10 ceph-0005 kernel: [   89.836390] ceph:     mds_client.c:997=
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0
Nov 24 12:51:10 ceph-0005 kernel: [   89.836969] ceph:     mds_client.c:350=
9 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0 session 00000000dd87f0dd
state new
Nov 24 12:51:10 ceph-0005 kernel: [   89.837584] ceph:     mds_client.c:167=
4 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] open_session to mds0 (up:acti=
ve)
Nov 24 12:51:10 ceph-0005 kernel: [   89.838388] ceph:     mds_client.c:374=
1 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] do_request waiting

Nov 24 12:51:10 ceph-0005 kernel: [   90.291635] ceph:     mds_client.c:421=
0 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] cap_auths_num 1
Nov 24 12:51:10 ceph-0005 kernel: [   90.292760] ceph:     mds_client.c:428=
1 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] uid -1, num_gids 0, path (nul=
l),
fs_name cephfs, root_squash 0, readable 1, writeable 1
Nov 24 12:51:10 ceph-0005 kernel: [   90.294531] ceph:     mds_client.c:431=
3 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0 open 00000000dd87f0dd st=
ate
opening seq 0
Nov 24 12:51:10 ceph-0005 kernel: [   90.296268] ceph:     mds_client.c:209=
0 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0 ttl now 4294815743, was
fresh, now stale
Nov 24 12:51:10 ceph-0005 kernel: [   90.297370] ceph:     mds_client.c:365=
3 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983]  wake request 000000004bf8d02=
9 tid
1
Nov 24 12:51:10 ceph-0005 kernel: [   90.298127] ceph:     mds_client.c:130=
6 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] using resend_mds mds0
Nov 24 12:51:10 ceph-0005 kernel: [   90.298734] ceph:     mds_client.c:350=
9 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mds0 session 00000000dd87f0dd
state open
Nov 24 12:51:11 ceph-0005 kernel: [   90.299523] ceph:     mds_client.c:334=
0 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] 000000004bf8d029 tid 1 getattr
(attempt 1)
Nov 24 12:51:11 ceph-0005 kernel: [   90.300184] ceph:     mds_client.c:292=
3 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983]  path scratch
Nov 24 12:51:11 ceph-0005 kernel: [   90.300769] ceph:     mds_client.c:340=
9 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983]  r_parent =3D 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.302465] ceph:     mds_client.c:386=
3 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] handle_reply 000000004bf8d029
Nov 24 12:51:11 ceph-0005 kernel: [   90.303109] ceph:     mds_client.c:120=
8 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] 000000004bf8d029 tid 1
Nov 24 12:51:11 ceph-0005 kernel: [   90.303661] ceph:     mds_client.c:391=
7 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] tid 1 result 0
Nov 24 12:51:11 ceph-0005 kernel: [   90.304326] ceph:     mds_client.c:375=
5 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] do_request waited, got 0
Nov 24 12:51:11 ceph-0005 kernel: [   90.305635] ceph:     mds_client.c:380=
2 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] do_request 000000004bf8d029 d=
one,
result 0
Nov 24 12:51:11 ceph-0005 kernel: [   90.307048] ceph:          super.c:107=
5 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] success
Nov 24 12:51:11 ceph-0005 kernel: [   90.308214] ceph:          super.c:108=
1 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] success, root dentry is
00000000c9e255e3
Nov 24 12:51:11 ceph-0005 kernel: [   90.309500] ceph:          super.c:118=
3 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] mount success
Nov 24 12:51:11 ceph-0005 kernel: [   90.310523] ceph:          super.c:134=
7 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] root 00000000c9e255e3 inode
000000000946916c ino 10000000001.fffffffffffffffe
Nov 24 12:51:11 ceph-0005 kernel: [   90.312737] ceph:          super.c:620=
  :
destroy_mount_options 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.319198] ceph:           file.c:389=
  :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] 000000000946916c
10000000001.fffffffffffffffe file 0000000006cb5fc2 flags 65536 (100352)
Nov 24 12:51:11 ceph-0005 kernel: [   90.322405] ceph:     mds_client.c:283=
2 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] on 00000000c9e255e3 38 built
10000000001 '/'
Nov 24 12:51:11 ceph-0005 kernel: [   90.324881] ceph:     mds_client.c:577=
9 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] tpath '/', mask 4, caller_uid=
 0,
caller_gid 0
Nov 24 12:51:11 ceph-0005 kernel: [   90.327514] ceph:     mds_client.c:566=
4 :
[31977b06-8cdb-42a9-97ad-d6a7d59a42dd 175983] fsname check fs_name=3D(null)=
=20
match.fs_name=3Dcephfs
Nov 24 12:51:11 ceph-0005 kernel: [   90.328688] BUG: kernel NULL pointer
dereference, address: 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.329218] #PF: supervisor read acces=
s in
kernel mode
Nov 24 12:51:11 ceph-0005 kernel: [   90.329547] #PF: error_code(0x0000) - =
not-
present page
Nov 24 12:51:11 ceph-0005 kernel: [   90.330308] PGD 0 P4D 0=20
Nov 24 12:51:11 ceph-0005 kernel: [   90.330505] Oops: Oops: 0000 [#3] SMP =
KASAN
NOPTI
Nov 24 12:51:11 ceph-0005 kernel: [   90.330776] CPU: 7 UID: 0 PID: 2530 Co=
mm:
check Tainted: G      D             6.18.0-rc6+ #64 PREEMPT(voluntary)=20
Nov 24 12:51:11 ceph-0005 kernel: [   90.331723] Tainted: [D]=3DDIE
Nov 24 12:51:11 ceph-0005 kernel: [   90.331956] Hardware name: QEMU Standa=
rd PC
(i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
Nov 24 12:51:11 ceph-0005 kernel: [   90.333363] RIP: 0010:strcmp+0x1c/0x40
Nov 24 12:51:11 ceph-0005 kernel: [   90.333614] Code: 90 90 90 90 90 90 90=
 90
90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 =
01 84
d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 c=
c cc
cc cc 31
Nov 24 12:51:11 ceph-0005 kernel: [   90.334929] RSP: 0018:ffff8881b5f8f6d0
EFLAGS: 00010246
Nov 24 12:51:11 ceph-0005 kernel: [   90.335267] RAX: 0000000000000000 RBX:
ffff88810bc59200 RCX: 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.335694] RDX: 0000000000000063 RSI:
0000000000000000 RDI: ffff8881107393c0
Nov 24 12:51:11 ceph-0005 kernel: [   90.336176] RBP: ffff8881b5f8f7b8 R08:
0000000000000000 R09: 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.336688] R10: 0000000000000000 R11:
0000000000000000 R12: dffffc0000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.337135] R13: ffff88811e218000 R14:
0000000000000000 R15: 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.337691] FS:  00007f6a1017c740(0000)
GS:ffff88825f722000(0000) knlGS:0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.338600] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 24 12:51:11 ceph-0005 kernel: [   90.339405] CR2: 0000000000000000 CR3:
000000010216e006 CR4: 0000000000772ef0
Nov 24 12:51:11 ceph-0005 kernel: [   90.339920] PKRU: 55555554
Nov 24 12:51:11 ceph-0005 kernel: [   90.340105] Call Trace:
Nov 24 12:51:11 ceph-0005 kernel: [   90.340276]  <TASK>
Nov 24 12:51:11 ceph-0005 kernel: [   90.340454]  ?
ceph_mds_check_access+0x348/0x1760
Nov 24 12:51:11 ceph-0005 kernel: [   90.340775]  ?
__kasan_check_write+0x14/0x30
Nov 24 12:51:11 ceph-0005 kernel: [   90.341447]  ? lockref_get+0xb1/0x170
Nov 24 12:51:11 ceph-0005 kernel: [   90.341729]  ceph_open+0x322/0xef0
Nov 24 12:51:11 ceph-0005 kernel: [   90.341962]  ?
__kasan_check_write+0x14/0x30
Nov 24 12:51:11 ceph-0005 kernel: [   90.342233]  ? __pfx_ceph_open+0x10/0x=
10
Nov 24 12:51:11 ceph-0005 kernel: [   90.342499]  ?
__pfx_apparmor_file_open+0x10/0x10
Nov 24 12:51:11 ceph-0005 kernel: [   90.342763]  do_dentry_open+0x7bf/0x10=
e0
Nov 24 12:51:11 ceph-0005 kernel: [   90.343646]  ? __pfx_ceph_open+0x10/0x=
10
Nov 24 12:51:11 ceph-0005 kernel: [   90.344196]  vfs_open+0x6d/0x450
Nov 24 12:51:11 ceph-0005 kernel: [   90.344409]  ? may_open+0xec/0x370
Nov 24 12:51:11 ceph-0005 kernel: [   90.344640]  path_openat+0x2017/0x50a0
Nov 24 12:51:11 ceph-0005 kernel: [   90.344895]  ? __pfx_path_openat+0x10/=
0x10
Nov 24 12:51:11 ceph-0005 kernel: [   90.345198]  ?
__pfx_stack_trace_save+0x10/0x10
Nov 24 12:51:11 ceph-0005 kernel: [   90.345566]  ?
__kasan_check_write+0x14/0x30
Nov 24 12:51:11 ceph-0005 kernel: [   90.345911]  ?
stack_depot_save_flags+0x28/0x8f0
Nov 24 12:51:11 ceph-0005 kernel: [   90.346289]  ? stack_depot_save+0xe/0x=
20
Nov 24 12:51:11 ceph-0005 kernel: [   90.346597]  do_filp_open+0x1b4/0x450
Nov 24 12:51:11 ceph-0005 kernel: [   90.346899]  ?
__pfx__raw_spin_lock_irqsave+0x10/0x10
Nov 24 12:51:11 ceph-0005 kernel: [   90.347276]  ? __pfx_do_filp_open+0x10=
/0x10
Nov 24 12:51:11 ceph-0005 kernel: [   90.347582]  ? __link_object+0x13d/0x2=
b0
Nov 24 12:51:11 ceph-0005 kernel: [   90.347880]  ?
__pfx__raw_spin_lock+0x10/0x10
Nov 24 12:51:11 ceph-0005 kernel: [   90.348140]  ?
__check_object_size+0x453/0x600
Nov 24 12:51:11 ceph-0005 kernel: [   90.348385]  ? _raw_spin_unlock+0xe/0x=
40
Nov 24 12:51:11 ceph-0005 kernel: [   90.348597]  do_sys_openat2+0xe6/0x180
Nov 24 12:51:11 ceph-0005 kernel: [   90.348804]  ?
__pfx_do_sys_openat2+0x10/0x10
Nov 24 12:51:11 ceph-0005 kernel: [   90.349047]  ?
__kasan_check_write+0x14/0x30
Nov 24 12:51:11 ceph-0005 kernel: [   90.349302]  ?
lock_vma_under_rcu+0x2e9/0x730
Nov 24 12:51:11 ceph-0005 kernel: [   90.349556]  __x64_sys_openat+0x108/0x=
240
Nov 24 12:51:11 ceph-0005 kernel: [   90.349772]  ?
__pfx___x64_sys_openat+0x10/0x10
Nov 24 12:51:11 ceph-0005 kernel: [   90.350023]  x64_sys_call+0x134f/0x2350
Nov 24 12:51:11 ceph-0005 kernel: [   90.350239]  do_syscall_64+0x82/0xd50
Nov 24 12:51:11 ceph-0005 kernel: [   90.350440]  ? __kasan_check_read+0x11=
/0x20
Nov 24 12:51:11 ceph-0005 kernel: [   90.350660]  ?
fpregs_assert_state_consistent+0x5c/0x100
Nov 24 12:51:11 ceph-0005 kernel: [   90.350968]  ?
irqentry_exit_to_user_mode+0x2e/0x2a0
Nov 24 12:51:11 ceph-0005 kernel: [   90.351240]  ? irqentry_exit+0x43/0x50
Nov 24 12:51:11 ceph-0005 kernel: [   90.351442]  ? exc_page_fault+0x95/0x1=
00
Nov 24 12:51:11 ceph-0005 kernel: [   90.351647]=20
entry_SYSCALL_64_after_hwframe+0x76/0x7e
Nov 24 12:51:11 ceph-0005 kernel: [   90.351933] RIP: 0033:0x7f6a0ff19a8c
Nov 24 12:51:11 ceph-0005 kernel: [   90.352129] Code: 24 18 31 c0 41 83 e2=
 40
75 44 89 f0 25 00 00 41 00 3d 00 00 41 00 74 36 44 89 c2 4c 89 ce bf 9c ff =
ff ff
b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 77 44 48 8b 54 24 18 64 48 2b 14 2=
5 28
00 00 00
Nov 24 12:51:11 ceph-0005 kernel: [   90.353095] RSP: 002b:00007ffe25b42190
EFLAGS: 00000287 ORIG_RAX: 0000000000000101
Nov 24 12:51:11 ceph-0005 kernel: [   90.353939] RAX: ffffffffffffffda RBX:
0000000000000001 RCX: 00007f6a0ff19a8c
Nov 24 12:51:11 ceph-0005 kernel: [   90.354382] RDX: 0000000000090800 RSI:
00005c7d3b043a90 RDI: 00000000ffffff9c
Nov 24 12:51:11 ceph-0005 kernel: [   90.354803] RBP: 00007ffe25b423f0 R08:
0000000000090800 R09: 00005c7d3b043a90
Nov 24 12:51:11 ceph-0005 kernel: [   90.355276] R10: 0000000000000000 R11:
0000000000000287 R12: 00005c7d3ad24354
Nov 24 12:51:11 ceph-0005 kernel: [   90.355686] R13: 00005c7d3b043a90 R14:
0000000000000000 R15: 00005c7d3ad24353
Nov 24 12:51:11 ceph-0005 kernel: [   90.356091]  </TASK>
Nov 24 12:51:11 ceph-0005 kernel: [   90.356231] Modules linked in:
intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_co=
re
pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec
kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_in=
tel
input_leds psmouse rapl vga16fb serio_raw vgastate floppy i2c_piix4 mac_hid
qemu_fw_cfg i2c_smbus bochs pata_acpi sch_fq_codel rbd msr parport_pc ppdev=
 lp
parport efi_pstore
Nov 24 12:51:11 ceph-0005 kernel: [   90.358735] CR2: 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.358972] ---[ end trace 00000000000=
00000
]---
Nov 24 12:51:11 ceph-0005 kernel: [   90.359341] RIP: 0010:strcmp+0x1c/0x40
Nov 24 12:51:11 ceph-0005 kernel: [   90.359581] Code: 90 90 90 90 90 90 90=
 90
90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 =
01 84
d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 c=
c cc
cc cc 31
Nov 24 12:51:11 ceph-0005 kernel: [   90.360687] RSP: 0018:ffff8881b8faf600
EFLAGS: 00010246
Nov 24 12:51:11 ceph-0005 kernel: [   90.361008] RAX: 0000000000000000 RBX:
ffff88810bc59600 RCX: 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.361488] RDX: 0000000000000063 RSI:
0000000000000000 RDI: ffff888110739020
Nov 24 12:51:11 ceph-0005 kernel: [   90.362074] RBP: ffff8881b8faf6e8 R08:
0000000000000000 R09: 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.362498] R10: 0000000000000000 R11:
0000000000000000 R12: dffffc0000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.362969] R13: ffff88811e104000 R14:
0000000000000000 R15: 0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.363442] FS:  00007f6a1017c740(0000)
GS:ffff88825f722000(0000) knlGS:0000000000000000
Nov 24 12:51:11 ceph-0005 kernel: [   90.363971] CS:  0010 DS: 0000 ES: 0000
CR0: 0000000080050033
Nov 24 12:51:11 ceph-0005 kernel: [   90.364338] CR2: 0000000000000000 CR3:
000000010216e006 CR4: 0000000000772ef0
Nov 24 12:51:11 ceph-0005 kernel: [   90.364738] PKRU: 55555554

So, the main sequence is:

ceph_open()
  -> ceph_mdsc_build_path()
  -> ceph_mds_check_access()
      -> ceph_mds_auth_match()
          -> crash happens

> >=20
> > And I am not sure that we can mandate anyone to use the old syntax. If =
there is
> > some other opportunity, then someone could use it. But, maybe, I am mis=
sing the
> > point. :) What do you mean by "Mandate passing the fsname with old synt=
ax"?
>=20
> In the old mount syntax, the fsname is passed as on optional argument
> using 'mds_namespace'.
> I was suggesting to mandate it if possible. But I guess it breaks
> backward compatibility.
>=20
> >=20
> >=20

We had a private discussion with Ilya. Yes, he also mentioned the breaking =
of
backward compatibility for the case of mandating passing the fsname with old
syntax. He believes that: "Use the default fsname when mdsc->fsc->mount_opt=
ions-
>mds_namespace is NULL during comparison seems like a sensible approach to =
me".

Thanks,
Slava.

> > >=20
> > >=20
> > >=20
> > > On Thu, Nov 20, 2025 at 4:47=E2=80=AFAM Viacheslav Dubeyko
> > > <Slava.Dubeyko@ibm.com> wrote:
> > > >=20
> > > > On Wed, 2025-11-19 at 15:02 -0800, Gregory Farnum wrote:
> > > > >=20
> > > > > That doesn=E2=80=99t sound right =E2=80=94 this is authentication=
 code. If the authorization is supplied for a namespace and we are mounting=
 without a namespace at all, isn=E2=80=99t that a jailbreak? So the NULL po=
inter should be accepted in one direction, but denied in the other?
> > > >=20
> > > > What is your particular suggestion? I am simply fixing the kernel c=
rash after
> > > > the 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"). We didn=
't have any
> > > > check before. Do you imply that 22c73d52a6d0 ("ceph: fix multifs md=
s auth caps
> > > > issue") fix is incorrect and we need to rework it somehow?
> > > >=20
> > > > If we will not have any fix, then 6.18 release will have broken Cep=
hFS kernel
> > > > client.
> > > >=20
> > > > Thanks,
> > > > Slava.
> > > >=20
> > > > >=20
> > > > > On Wed, Nov 19, 2025 at 2:54=E2=80=AFPM Viacheslav Dubeyko <Slava=
.Dubeyko@ibm.com> wrote:
> > > > > > On Wed, 2025-11-19 at 23:40 +0100, Ilya Dryomov wrote:
> > > > > > > On Wed, Nov 19, 2025 at 8:38=E2=80=AFPM Viacheslav Dubeyko <s=
lava@dubeyko.com> wrote:
> > > > > > > >=20
> > > > > > > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > > > >=20
> > > > > > > > The CephFS kernel client has regression starting from 6.18-=
rc1.
> > > > > > > >=20
> > > > > > > > sudo ./check -g quick
> > > > > > > > FSTYP         -- ceph
> > > > > > > > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP=
 PREEMPT_DYNAMIC Fri
> > > > > > > > Nov 14 11:26:14 PST 2025
> > > > > > > > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > > > > > > > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1=
.213:3300:/scratch
> > > > > > > > /mnt/cephfs/scratch
> > > > > > > >=20
> > > > > > > > Killed
> > > > > > > >=20
> > > > > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: m=
on0
> > > > > > > > (2)192.168.1.213:3300 session established
> > > > > > > > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: c=
lient167616
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kerne=
l NULL pointer
> > > > > > > > dereference, address: 0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: super=
visor read access in
> > > > > > > > kernel mode
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error=
_code(0x0000) - not-
> > > > > > > > present page
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops=
: 0000 [#1] SMP KASAN
> > > > > > > > NOPTI
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID=
: 0 PID: 3453 Comm:
> > > > > > > > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware n=
ame: QEMU Standard PC
> > > > > > > > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:=
strcmp+0x1c/0x40
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 9=
0 90 90 90 90 90 90
> > > > > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00=
 00 90 48 83 c0 01 84
> > > > > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 =
31 f6 31 ff c3 cc cc
> > > > > > > > cc cc 31
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:=
ffff8881536875c0
> > > > > > > > EFLAGS: 00010246
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 00000=
00000000000 RBX:
> > > > > > > > ffff888116003200 RCX: 0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 00000=
00000000063 RSI:
> > > > > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8=
881536876a8 R08:
> > > > > > > > 0000000000000000 R09: 0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 00000=
00000000000 R11:
> > > > > > > > 0000000000000000 R12: dffffc0000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8=
881061d0000 R14:
> > > > > > > > 0000000000000000 R15: 0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  00007=
4a85c082840(0000)
> > > > > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 =
DS: 0000 ES: 0000
> > > > > > > > CR0: 0000000080050033
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 00000=
00000000000 CR3:
> > > > > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 5555=
5554
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > > > > > > > ceph_mds_check_access+0x348/0x1760
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > > > > > > > __kasan_check_write+0x14/0x30
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref=
_get+0xb1/0x170
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > > > > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open=
+0x322/0xef0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_c=
eph_open+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > > > > > > > __pfx_apparmor_file_open+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > > > > > > > __ceph_caps_issued_mask_metric+0xd6/0x180
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry=
_open+0x7bf/0x10e0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_c=
eph_open+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+=
0x6d/0x450
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_ope=
n+0xec/0x370
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_open=
at+0x2017/0x50a0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_p=
ath_openat+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > > > > > > > __pfx_stack_trace_save+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > > > > > > > stack_depot_save_flags+0x28/0x8f0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_d=
epot_save+0xe/0x20
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_o=
pen+0x1b4/0x450
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > > > > > > > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_d=
o_filp_open+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_=
object+0x13d/0x2b0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > > > > > > > __pfx__raw_spin_lock+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > > > > > > > __check_object_size+0x453/0x600
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_sp=
in_unlock+0xe/0x40
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_op=
enat2+0xe6/0x180
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > > > > > > > __pfx_do_sys_openat2+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys=
_openat+0x108/0x240
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > > > > > > > __pfx___x64_sys_openat+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > > > > > > > __pfx___handle_mm_fault+0x10/0x10
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_c=
all+0x134f/0x2350
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscal=
l_64+0x82/0xd50
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > > > > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_sysc=
all_64+0xba/0xd50
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan=
_check_read+0x11/0x20
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > > > > > > > count_memcg_events+0x25b/0x400
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_=
mm_fault+0x38b/0x6a0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan=
_check_read+0x11/0x20
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > > > > > > > fpregs_assert_state_consistent+0x5c/0x100
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > > > > > > > irqentry_exit_to_user_mode+0x2e/0x2a0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentr=
y_exit+0x43/0x50
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_pag=
e_fault+0x95/0x100
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > > > > > > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:=
0x74a85bf145ab
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 0=
0 00 41 00 3d 00 00
> > > > > > > > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48=
 89 ee bf 9c ff ff ff
> > > > > > > > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 =
48 8b 54 24 28 64 48
> > > > > > > > 2b 14 25
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:=
00007ffc77d316d0
> > > > > > > > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: fffff=
fffffffffda RBX:
> > > > > > > > 0000000000000002 RCX: 000074a85bf145ab
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 00000=
00000000000 RSI:
> > > > > > > > 00007ffc77d32789 RDI: 00000000ffffff9c
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007=
ffc77d32789 R08:
> > > > > > > > 00007ffc77d31980 R09: 0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 00000=
00000000000 R11:
> > > > > > > > 0000000000000246 R12: 0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000=
000ffffffff R14:
> > > > > > > > 0000000000000180 R15: 0000000000000001
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules li=
nked in:
> > > > > > > > intel_rapl_msr intel_rapl_common intel_uncore_frequency_com=
mon intel_pmc_core
> > > > > > > > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telem=
etry intel_vsec
> > > > > > > > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmuln=
i_intel aesni_intel
> > > > > > > > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2=
c_smbus vgastate
> > > > > > > > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr =
parport_pc ppdev lp
> > > > > > > > parport efi_pstore
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 00000=
00000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end t=
race 0000000000000000
> > > > > > > > ]---
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:=
strcmp+0x1c/0x40
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 9=
0 90 90 90 90 90 90
> > > > > > > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00=
 00 90 48 83 c0 01 84
> > > > > > > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 =
31 f6 31 ff c3 cc cc
> > > > > > > > cc cc 31
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:=
ffff8881536875c0
> > > > > > > > EFLAGS: 00010246
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 00000=
00000000000 RBX:
> > > > > > > > ffff888116003200 RCX: 0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 00000=
00000000063 RSI:
> > > > > > > > 0000000000000000 RDI: ffff88810126c900
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8=
881536876a8 R08:
> > > > > > > > 0000000000000000 R09: 0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 00000=
00000000000 R11:
> > > > > > > > 0000000000000000 R12: dffffc0000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8=
881061d0000 R14:
> > > > > > > > 0000000000000000 R15: 0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  00007=
4a85c082840(0000)
> > > > > > > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 =
DS: 0000 ES: 0000
> > > > > > > > CR0: 0000000080050033
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 00000=
00000000000 CR3:
> > > > > > > > 0000000110ebd001 CR4: 0000000000772ef0
> > > > > > > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 5555=
5554
> > > > > > > >=20
> > > > > > > > We have issue here [1] if fs_name =3D=3D NULL:
> > > > > > > >=20
> > > > > > > > const char fs_name =3D mdsc->fsc->mount_options->mds_namesp=
ace;
> > > > > > > >      ...
> > > > > > > >      if (auth->match.fs_name && strcmp(auth->match.fs_name,=
 fs_name)) {
> > > > > > > >              / fsname mismatch, try next one */
> > > > > > > >              return 0;
> > > > > > > >      }
> > > > > > > >=20
> > > > > > > > The patch fixes the issue by introducing is_fsname_mismatch=
() method
> > > > > > > > that checks auth->match.fs_name and fs_name pointers validi=
ty, and
> > > > > > > > compares the file system names.
> > > > > > > >=20
> > > > > > > > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ce=
ph/mds_client.c#L5666 =20
> > > > > > > >=20
> > > > > > > > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue=
")
> > > > > > > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > > > > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > > > > > > > cc: Alex Markuze <amarkuze@redhat.com>
> > > > > > > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > > > > > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > > > > > > ---
> > > > > > > >   fs/ceph/mds_client.c | 20 +++++++++++++++++---
> > > > > > > >   1 file changed, 17 insertions(+), 3 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > > > > > index 1740047aef0f..19c75e206300 100644
> > > > > > > > --- a/fs/ceph/mds_client.c
> > > > > > > > +++ b/fs/ceph/mds_client.c
> > > > > > > > @@ -5647,6 +5647,22 @@ void send_flush_mdlog(struct ceph_md=
s_session *s)
> > > > > > > >          mutex_unlock(&s->s_mutex);
> > > > > > > >   }
> > > > > > > >=20
> > > > > > > > +static inline
> > > > > > > > +bool is_fsname_mismatch(struct ceph_client *cl,
> > > > > > > > +                       const char *fs_name1, const char *f=
s_name2)
> > > > > > > > +{
> > > > > > > > +       if (!fs_name1 || !fs_name2)
> > > > > > > > +               return false;
> > > > > > >=20
> > > > > > > Hi Slava,
> > > > > > >=20
> > > > > > > It looks like this would declare a match (return false for "m=
ismatch")
> > > > > > > in case ceph_mds_cap_auth is defined to require a particular =
fs_name but
> > > > > > > no mds_namespace was passed on mount.  Is that the desired be=
havior?
> > > > > > >=20
> > > > > >=20
> > > > > > Hi Ilya,
> > > > > >=20
> > > > > > Before 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue"), =
we had no such
> > > > > > check in the logic of ceph_mds_auth_match(). So, if auth->match=
.fs_name or
> > > > > > fs_name is NULL, then we cannot say that they match or not. It =
means that we
> > > > > > need to continue logic, this is why is_fsname_mismatch() return=
s false.
> > > > > > Otherwise, if we stop logic by returning true, then we have bun=
ch of xfstests
> > > > > > failures.
> > > > > >=20
> > > > > > Thanks,
> > > > > > Slava.
> > > > > >=20
> > > > > > > > +
> > > > > > > > +       doutc(cl, "fsname check fs_name1=3D%s fs_name2=3D%s=
\n",
> > > > > > > > +             fs_name1, fs_name2);
> > > > > > > > +
> > > > > > > > +       if (strcmp(fs_name1, fs_name2))
> > > > > > > > +               return true;
> > > > > > > > +
> > > > > > > > +       return false;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >   static int ceph_mds_auth_match(struct ceph_mds_client *md=
sc,
> > > > > > > >                                 struct ceph_mds_cap_auth *a=
uth,
> > > > > > > >                                 const struct cred *cred,
> > > > > > > > @@ -5661,9 +5677,7 @@ static int ceph_mds_auth_match(struct=
 ceph_mds_client *mdsc,
> > > > > > > >          u32 gid, tlen, len;
> > > > > > > >          int i, j;
> > > > > > > >=20
> > > > > > > > -       doutc(cl, "fsname check fs_name=3D%s  match.fs_name=
=3D%s\n",
> > > > > > > > -             fs_name, auth->match.fs_name ? auth->match.fs=
_name : "");
> > > > > > > > -       if (auth->match.fs_name && strcmp(auth->match.fs_na=
me, fs_name)) {
> > > > > > > > +       if (is_fsname_mismatch(cl, auth->match.fs_name, fs_=
name)) {
> > > > > > > >                  /* fsname mismatch, try next one */
> > > > > > > >                  return 0;
> > > > > > > >          }
> > > > > > > > --
> > > > > > > > 2.51.1
> > > > > > > >=20
> > > > > >=20
> > > >=20
> >=20

