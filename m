Return-Path: <linux-fsdevel+bounces-71581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1839CC9845
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 21:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 971BE3010FE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 20:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA61430B536;
	Wed, 17 Dec 2025 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c5UcGpv6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22725221F06
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766004271; cv=fail; b=jkggTJctL24RNQLyr1TS0aCzQlvJFZ4suOoPhZHJ0kBtQuUr65IxJtLtnZ/dzO92PQhahyfxSSFbb1vTE7xuT6NR0qWZNGLMUwSYdk1ebYp0vyiOwMwXsesAr8BHUBrJcKcOsFQ8ThsDHX5nAvCa1AFMF0GnSzge8zlP7lADMC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766004271; c=relaxed/simple;
	bh=PFaBJvdINq04iJqN1ZtzkQgnYSJbKVBFVs3OXSRdq3k=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=X0/ZlczC52NsCFwCB0QCNUmXEkOF3SbguTC/+IQik/NPtVAie7wYtFSmuEL94O5Jt5maWiiKeYUBGRpQ/9uekF3ghrNKhKO062fV8/Cr178278d2/1I25N4INdHY2P+DtwO30uYrsdd/Qqrgd/GbJc1YdUkziTlBfu+fF8Vv1Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c5UcGpv6; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHK18IR006284
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 20:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=N8EVyFyIESpFZ/+LRnY7YhzktAXJgALXTY6FCmxlxEk=; b=c5UcGpv6
	26clL0pgceurNhZwBpfGfFhyQrjfQf23/wpD4KjwTlf1L9Tt7NADq/9hn8k1NjOf
	62S0tAvnfE1mBOXJ8MN5aRP5QWP4c9iJTQgPCiNpPwF/+W+JDqmNTc3JRQVHXrr0
	TJp7z/JtfgUfeYYlBgMIWfJDYbgCC2grjgKbm1bAKjjBYKI3DanSuE2u5EozS8H6
	hej9D5lRXh+VfjXKGXhyHObQUMGtOa2XCnWbISWzlSuVUmT284bqdJcxQxrAqJ1A
	179+47TybCzwj5HC6dk8hEd+WfoGmycKA8Ta8p6i/1d2CvA75KMO27sk5hgjzyFu
	A4NJxzW9EpdEDg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm6f8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 20:44:28 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BHKhpIJ002827
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 20:44:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm6f8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 20:44:26 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BHKeqnp029775;
	Wed, 17 Dec 2025 20:44:26 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjm6f8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 20:44:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwsIHFj/ngTXGa8CWPjeCf6HkEoVNNv3Ljwn4+YViEOARle9ZXEa5YjCgNb73EEIGoTkB3MDg//DPtjeYXx3kGI061OUVEqO8GYDE2Pk2fRElAaUHmNEZw81kLrukF0hPJVA4PX51vA5JAbKOq4a+MB9xJt+XHqwKCso6mRiSpYrExc5WwEPeF2nlgUTXarOc7+DgcqzCFYjfdcZyI5G3ybsCh2Q85QNq++prMGdvhF2QWyiFpsUtedR0mOlhN/mUqGEfjH/oSkvHssx4jEhcHJd7tWc5mjq4hDp40fVYd/Jf1v12qkbihI4zB0i0pj5P+ELrS9g6rt0yoRrcthotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhw7hUzV6JqWXEYWaei6bPgDofVAV+D7aCncOUp/y2I=;
 b=IClbvWu3mFOhAuv/wLWw1ok3MiakP5NZlu9uUf/JWzTKWWbxoJrVaFluKEqoyrkBei3Lu4Mgy5A5n3nV4KrseISulSWjBV7KXY7mWUyXPrCYlPM3YsExftfytKsLZv/mjpjYwAScBlkgXtEuHSB9aehuluwuKBo4iAS2ZS0/CBVZ50NYEKrhKE1XeHCD83s3YIARB8T4JtzzatvxbZ8MlG+mvxn84yhOsAbvCAh3vcniAvGhm3cNuO8nSmnItLDhYsKZrufPAeyCknP1yj7jJOqAiYb8QXePw3oVDhu5xmxlNvMTyG5y2RRZJs/RRXnL7hNW/wZ/046Gxncbh/GEBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH5PR15MB6945.namprd15.prod.outlook.com (2603:10b6:610:2f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 20:44:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 20:44:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "slava@dubeyko.com" <slava@dubeyko.com>,
        Patrick Donnelly
	<pdonnell@redhat.com>
CC: Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>,
        Viacheslav Dubeyko
	<vdubeyko@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Alex Markuze
	<amarkuze@redhat.com>,
        Kotresh Hiremath Ravishankar <khiremat@redhat.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
Thread-Index: AQHcb5TpmMeL+RYIakuRlVP/l+uM0bUmTK4A
Date: Wed, 17 Dec 2025 20:44:23 +0000
Message-ID: <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com>
References: <20251215215301.10433-2-slava@dubeyko.com>
	 <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
In-Reply-To:
 <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH5PR15MB6945:EE_
x-ms-office365-filtering-correlation-id: 592a7aeb-0785-44e2-bf5e-08de3dad0fc0
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dm15elVqUk1ldjRsckUzaFNvSzFVVHZOYy9aTHhrU0dHWExJVzFjR21ZbDdV?=
 =?utf-8?B?NzhLSzY1dy9CYUhHUjZmRWFqRVVzNDNWTVhDSXVTV2g5YWtrTUxRYjFaSHRY?=
 =?utf-8?B?dWxzai9yY013ajZqZ2t6TjR1NW9hTGVkemF0ZCsrRytvNlFvUS9MNjA0dXpi?=
 =?utf-8?B?bCtJdk5EdFJUM3ovak5yelJmeTJhZklydGNMWlVMQ0pnZUU5aUhUd0U5QktH?=
 =?utf-8?B?Yzc3cStkVEs1NVZyZGg4NmMxSUQxTC9zdjNnUTRaaFJvUEhTNnRFOVFEa0FS?=
 =?utf-8?B?d2dFbnMxRkZKNTVoUERBUFBsVStrRXJOTDRrakZ3bVZ6WGUvRGEwYUVuU000?=
 =?utf-8?B?TW8wUFdwYWMvUVhEKzcrYzZSYll3czNsblhiSzBFMktMTFhGREZWaGdoWWtw?=
 =?utf-8?B?cWp6TEt1WC9nUjFvYlB3UFQzenNIKzVjTGV5aXhkazdMdjV5ajB3NTBvdjhW?=
 =?utf-8?B?eHhOQk1Ua0FhRG90YVFsZWJGRVhtQnFvZW5XUVY5clZrYURSMHJ0NnhGVzUw?=
 =?utf-8?B?SUdIYUFadmdicW0ycmlZVGxlaWlWRGkrQWhqanZaaEVvRmIzS0FhNFJGVXBP?=
 =?utf-8?B?RE1PYU1jV3VHK1p2bldOb2lxQjJEMlFIQ0FmUWZ4Ui9lUk9HK0ZreTNaRWRr?=
 =?utf-8?B?S0NSeHBHMGRUK2kxZ0syT3lUc2N0TUx6Uk4vVytBQ1AzbFk0Qng4RVAxdUdR?=
 =?utf-8?B?dXVUN3dyaDFqbm93YlVOUTVLSXFEL0lsMGJGaitNM0tlSGlyNGtvRm9xWVZS?=
 =?utf-8?B?YUZUQk5BZFh2Y2FJeC9lYlFlam9YY1ZLZVZvTkZ1RURydkQrUGdtN1NqNlN3?=
 =?utf-8?B?TkkwcHNzV1ZjeVArc0Ztd3NJSFBHU3UxRkpMeTZkblEwWkNwdWQrZlNPTTcy?=
 =?utf-8?B?Q0NDOVE5R1EvWkRQN0ZpMldHbDM3YzVYY1p2K1AwT2luTmxyTTYyb1pFRnRZ?=
 =?utf-8?B?cmpUVDhQWVdkNVZWbXFxQVpYZmEydVp5cHg2TDRTdDZGMi8wSFpGVjF2OFBF?=
 =?utf-8?B?QU43R3JvYWFHYkF1cEVBTXZ4NE1hc09ZUlp3azNycFhzbWd1K005RlFaSkhy?=
 =?utf-8?B?NFJOY0RDbng5TUhpcmxmWDgvTjNXRXMzTGVzMWJTSG90MXNCc3ByT3VucWxj?=
 =?utf-8?B?bExRZ0s4LzFPdlUxVUZDQ0dGSk5rWWx5eURLZEFmQy9qbDJyZW1ZQWFPVkhM?=
 =?utf-8?B?UDBESVJSaCtBZmtONHhqVFJXcGd1a25Ma0tsV29PUEltL3RPVzB1THpaZUlQ?=
 =?utf-8?B?YzhiUG40eUVHeGNsbExwTGR4cUlicVhwUFQ3Ni9TU3dsNzlOWFVRakpuT3pQ?=
 =?utf-8?B?dkNJNVY0cXRRWTl4Tk1MRUdHS2xOcE91RDBVNHUxTVN6RC83eWQwZjFhZ280?=
 =?utf-8?B?OXhSVmFjVHZpUjdXdlovZVk1VE9DMmljdkVWTDVaUEJTRjZPSkJJRkF1NCt1?=
 =?utf-8?B?bTNRZVpPSDUrcFdtVzM2djYzMStRSU1BTWtKQVhhSHM3dXpneXo2THltcUpC?=
 =?utf-8?B?eStRUU9JOVhQZnd4bVNJWUpUb2MwYzVMUWl0NzRsamhSbkJTZ2R0NHFnYkxF?=
 =?utf-8?B?TnNLOTZGT3FKU1VXZk5lZzZ6azNCRHVEem5jNnM2c2Q3aFc3NmkvSy9zSWNl?=
 =?utf-8?B?OS9mVGpFZ3RFVGtML1RhYjVPQjl0N1NkZlJkSDlPZ3JxTVdCbTc5c0JVOGxy?=
 =?utf-8?B?ZkxNWk5LOWk3Q0xuSm45Y0d5ZU13d25YdWFmems3QTBuWEF3SGR3aThLeVVT?=
 =?utf-8?B?UUNBZUFpcEw5SXRZZFJ1KzkyUWl3TXJLb1lrWkg3dWRvR0V0WEgyR1hHd2NL?=
 =?utf-8?B?ZVJod0VpOTNBL3k2eXJZMFh5Wk1BaWQ3MjJvd3BtT2orQm5rYUdjYi83WlRF?=
 =?utf-8?B?M0dDZzc2NXFPdGZleFNKU2t3U291L0RJTDRNT3E4bU1lZ1B1OVd2UzZFRUpw?=
 =?utf-8?B?cXcvSEVrbWxpWURxc0hGSWd2SnRYMXowbE9Db1ZsZmhzR2VOVW5wWThLVlRT?=
 =?utf-8?B?eE91QlgxZit3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFlvbXlBcmg1U201YjRXbmQ2ajgxTFhSTGFJaXZ2bkVtb1BBOTZUakp5T0xC?=
 =?utf-8?B?ZDlrUys2M1ZsNW1lV0VkbVBSNUpuZ0x2aFNVSEZ1YWxPODBRMUM0MlFGeUlF?=
 =?utf-8?B?ZXZtUXpwZ1lVMjlqZVg4RW1RcTIrNGRpRURXMUk1RTZ5UGFTNWgrR1cyYzha?=
 =?utf-8?B?UlRvUEJkcWQ2Y0U3MDQxd1V4MWZ2ZGJ6bnBFQy9VMjludFk1TjFDL1FpbitE?=
 =?utf-8?B?aXR0anJ3cEgvc2QvYS9EVUhoU3A0eHRTQUN3bDJDRmJ4WkdWNmJ3a0hTdlB0?=
 =?utf-8?B?SnJvMnJDVC9mc28yZTVGREo2ckcxbnBtS0UrdHRYSXBKak1EMGxGMmtLZjAz?=
 =?utf-8?B?dVlHb3FSWk8wZ0ozRFhwZnlETXJhMkRXYlFkMzcvZEVYdzR0UXhSQXYzRG01?=
 =?utf-8?B?TU9SM0lrU3crM2RQR2M4aUZSVGpNUkZsWUhvRzNOQzVMVHlSTWxMcFlsalpx?=
 =?utf-8?B?cVpvLzRHVERKL2k2cm9LK2NRc2FXQkpud3VUbmxCM2h3UkhtS2N0L2xRVFBh?=
 =?utf-8?B?MnZ6Q1ZtVnJqbDdNSExoamRaLzJUMDFvZHk3eDI3VkFHcm5VWGVGNjRVMVdW?=
 =?utf-8?B?dk1TcExtdm9RdmsrYm1SS213ZjNNNDJPbVdzb3MrSmZKWFlnc2Ztd0lXTjhy?=
 =?utf-8?B?U3BhSWZKZjJJWjczQS9qNVNhYUhrL1FiazExL1I2L0twSENGL1VuZ2VPV0NT?=
 =?utf-8?B?ZDIrVHE2YVViQTh1dkIzMHVseVJNN0x0WUg0M01QVWNJaStEaEVpYUtramMz?=
 =?utf-8?B?dGh0ekoyejhiWi9Va1lBRDdpY2VVaGsxTWQxZndkeEJWcWhOM0UweU5qa3FT?=
 =?utf-8?B?dWdVdkd1dmRCQzhBcTVobW02YTVHaEJ0aVJQM0xDNlA1dS93SVVOc3BuTkNm?=
 =?utf-8?B?VW9SelRSM0t1bjNFeEp4S0IxM0Nzd0dIOG5VYmNjNlk4K0ZJaVNib1VZZ1Q1?=
 =?utf-8?B?d3hHQXhsY3hWbXhrRG42d0xNNk53cmVTRUUyRldCcHZQMUJZTUZGMGF0K0l4?=
 =?utf-8?B?bWVObDZWOEk1WGlSWllDWG1aMWJxZkprVHBlekt1Y2xQOGtrT3lNMmxUdlNX?=
 =?utf-8?B?ZHJhM2R3aUF0L2l3LzFJK25SNFF4UWtnei9UWmhvZUw5YlNXZVBqNG1SbW5J?=
 =?utf-8?B?T2hOWHlWNE9LQnlxaExvZGdKQytSeUJyQjNOaVB2STB0VzNYUENpS3NWNzFD?=
 =?utf-8?B?dTZTR3FQUjFTUkR3bnZqcVV3eVRrcU1jZ1huSVlvTGZpK3hyWkI4OWpGRVJa?=
 =?utf-8?B?anFWRzR0NXdqRmVRZkg3N21qeW1MYW1BTTRJRTVRZWNMclBYY0VJdFNiMW9M?=
 =?utf-8?B?UEpuYm9wdTRLblVETVlLT05VOHIwRzdJeHNQZVh4RmExSUN4ZlVWd2Z4Wk5q?=
 =?utf-8?B?Rm5nalFPTkpRYkkra1pWdlRwNU9jSW1pRlZiYkVtcldhb29YT3ovQml2V0w0?=
 =?utf-8?B?NWozald6eEhRdDR3T1R1Q0hsdWdqbkcwWGY5ZlRMcStOMU45eGdEMXNwcHZP?=
 =?utf-8?B?TzcyVHR5UXQ5bkNieHAxeW0vUWp6dStMbEN2dmRibFJEQU9jVTl1ZWlBR05q?=
 =?utf-8?B?NFBqV3BwNE1FUDN0V2E2ZEs5Y2h5TE1tZ21qdXkyMjhMQnRTY2VRMUdQS0Zy?=
 =?utf-8?B?VG1QQTJoR0J1Z1lJSXhickwxZ0QwUCtBblNYV2l4dXE0ME55V0h5NkRMN0Fk?=
 =?utf-8?B?elFrY0kxTk4raGxWMzZndFZmQXYxYVVDblhIRHp4YnZRcFVLL1pBc29STC9y?=
 =?utf-8?B?eUVqc3FDVGFaZ01acXB1VUJWeDBoblFUYUtXWEZOSldYWG1kY0h6N2Ricm9D?=
 =?utf-8?B?R3lETlZnZXV4RG1DZldKOVRXc3NhSnRiVTFRRVMrcTdsOE5ma1JmY21Za2pD?=
 =?utf-8?B?SjVhK0ZCdUlpYmNoWkVhWnM3SjJueW9WMlRBcTJ5T0dyQ1ZPSG9RbVdOV1A1?=
 =?utf-8?B?Wlo2QUhMM1crSmxOdytpM1hOQm4zZy9lUHZqWHVXRzVmKzQ3U1BjeGlhVTh6?=
 =?utf-8?B?MDVNQk1WeG1idDhCWk1aQTZEaWg4T1RDSEVPL2Uyc2d2UktKeVF5THh4YTA3?=
 =?utf-8?B?aEc1Q2xLT1padWdnVzFCTzNDK3lSb2tyTHFwenAwSHlDNFl4RDBGK2tlcExW?=
 =?utf-8?B?Q2xYNFBrQjBGYmxwbTBMWXJoSStaZUJuWTBvMFI3b1B1dFZzdEZrQnROamVj?=
 =?utf-8?Q?mh6nQrNkB71p33rFK6aDkR8=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592a7aeb-0785-44e2-bf5e-08de3dad0fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2025 20:44:23.5908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2TSfxmzgJpA7v7s0E2LIkZgj8Fh7zocniz00yJhJUCM8UK8ObyjYQs668tGyD3OmUzuQ02+xCP8oU2tX3pLxOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR15MB6945
X-Proofpoint-ORIG-GUID: c0mnyyH8JbJNNPKuYjtXmRLByX79h8BW
X-Proofpoint-GUID: qBJF6legeU4oy7GFv5dFMXloeNTkCCx5
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=6943162a cx=c_pps
 a=e24IK3jsPB00aLvKg+wNHQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=wCmvBT1CAAAA:8
 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=iFqxAe6I31xMUzAcu24A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX2lNAW0M7nyJl
 bje4ZNwXJbkc61ELRP5pxkMN4zjViedkGZaXpxHJUOvYg6eGt5N2etbCdqUJx3rxLahT+L/KOnU
 iNL01EYAkcdGpNzSDPd4FolP7WJxp2UFEzE2o3llp3Fx4Y5Hq/Mpigddc3juVK/fHsI5bJoWHQH
 XtVsC9ok7mX3QA6rz+4CqL39v9adW7n5tV8ka5KUXYOQEiu6KzHQSfVKNWga2gELiFM1yt3W9e0
 Tdud7szOJAQqpt0rbYoXj6jpqy6KU4cOX+vi5lVwUnyECkbWNbBJLpCB0MTp2eiYaNR+aD0f31R
 MDOTtwvw14F9FrpzSWiRNErWoaFEF9tt+JZcVztEfOBszpiZF97felPVFrVZWEt6nVVqIxG9cP3
 7Ab3+1w76Q7DtUB7k239YFfsTEO0fQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDE2D55BE9038E4C8BC85EBFBE9474A0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_03,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=2 engine=8.19.0-2510240000 definitions=main-2512130009

On Wed, 2025-12-17 at 15:36 -0500, Patrick Donnelly wrote:
> Hi Slava,
>=20
> A few things:
>=20
> * CEPH_NAMESPACE_WIDCARD -> CEPH_NAMESPACE_WILDCARD ?

Yeah, sure :) My bad.

> * The comment "name for "old" CephFS file systems," appears twice.
> Probably only necessary in the header.

Makes sense.

> * You also need to update ceph_mds_auth_match to call
> namespace_equals.
>=20

Do you mean this code [1]?

>  Suggest documenting (in the man page) that
> mds_namespace mntopt can be "*" now.
>=20

Agreed. Which man page do you mean? Because 'man mount' contains no info ab=
out
Ceph. And it is my worry that we have nothing there. We should do something
about it. Do I miss something here?

Thanks,
Slava.

[1] https://elixir.bootlin.com/linux/v6.18-rc6/source/fs/ceph/mds_client.c#=
L5666

> Patrick
>=20
> On Mon, Dec 15, 2025 at 4:53=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko=
.com> wrote:
> >=20
> > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >=20
> > The CephFS kernel client has regression starting from 6.18-rc1.
> >=20
> > sudo ./check -g quick
> > FSTYP         -- ceph
> > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYN=
AMIC Fri
> > Nov 14 11:26:14 PST 2025
> > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/s=
cratch
> > /mnt/cephfs/scratch
> >=20
> > Killed
> >=20
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > (2)192.168.1.213:3300 session established
> > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL point=
er
> > dereference, address: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read a=
ccess in
> > kernel mode
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000=
) - not-
> > present page
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] =
SMP KASAN
> > NOPTI
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 345=
3 Comm:
> > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU St=
andard PC
> > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > ceph_mds_check_access+0x348/0x1760
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > __kasan_check_write+0x14/0x30
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x=
170
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > __pfx_apparmor_file_open+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > __ceph_caps_issued_mask_metric+0xd6/0x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/=
0x10e0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x1=
0/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x=
50a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0=
x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > __pfx_stack_trace_save+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > stack_depot_save_flags+0x28/0x8f0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0x=
e/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x=
450
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+=
0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d=
/0x2b0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > __pfx__raw_spin_lock+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > __check_object_size+0x453/0x600
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0x=
e/0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0=
x180
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > __pfx_do_sys_openat2+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x10=
8/0x240
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > __pfx___x64_sys_openat+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > __pfx___handle_mm_fault+0x10/0x10
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0=
x2350
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0x=
d50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/=
0xd50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > count_memcg_events+0x25b/0x400
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x3=
8b/0x6a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+=
0x11/0x20
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > fpregs_assert_state_consistent+0x5c/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > irqentry_exit_to_user_mode+0x2e/0x2a0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/=
0x50
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95=
/0x100
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145=
ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3=
d 00 00
> > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c=
 ff ff ff
> > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 =
28 64 48
> > 2b 14 25
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d3=
16d0
> > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda =
RBX:
> > 0000000000000002 RCX: 000074a85bf145ab
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 =
RSI:
> > 00007ffc77d32789 RDI: 00000000ffffff9c
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 =
R08:
> > 00007ffc77d31980 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 =
R11:
> > 0000000000000246 R12: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff =
R14:
> > 0000000000000180 R15: 0000000000000001
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pm=
c_core
> > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_v=
sec
> > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesn=
i_intel
> > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgas=
tate
> > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc p=
pdev lp
> > parport efi_pstore
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000=
000000000
> > ]---
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/=
0x40
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 9=
0 90 90
> > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83=
 c0 01 84
> > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff =
c3 cc cc
> > cc cc 31
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff88815368=
75c0
> > EFLAGS: 00010246
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 =
RBX:
> > ffff888116003200 RCX: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 =
RSI:
> > 0000000000000000 RDI: ffff88810126c900
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 =
R08:
> > 0000000000000000 R09: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 =
R11:
> > 0000000000000000 R12: dffffc0000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 =
R14:
> > 0000000000000000 R15: 0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(=
0000)
> > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES:=
 0000
> > CR0: 0000000080050033
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 =
CR3:
> > 0000000110ebd001 CR4: 0000000000772ef0
> > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> >=20
> > We have issue here [1] if fs_name =3D=3D NULL:
> >=20
> > const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> >     ...
> >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
> >             / fsname mismatch, try next one */
> >             return 0;
> >     }
> >=20
> > v2
> > Patrick Donnelly suggested that: In summary, we should definitely start
> > decoding `fs_name` from the MDSMap and do strict authorizations checks
> > against it. Note that the `--mds_namespace` should only be used for
> > selecting the file system to mount and nothing else. It's possible
> > no mds_namespace is specified but the kernel will mount the only
> > file system that exists which may have name "foo".
> >=20
> > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > the goal of supporting the suggested concept. Now struct ceph_mdsmap
> > contains m_fs_name field that receives copy of extracted FS name
> > by ceph_extract_encoded_string(). For the case of "old" CephFS file sys=
tems,
> > it is used "cephfs" name. Also, namespace_equals() method has been
> > reworked with the goal of proper names comparison.
> >=20
> > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_clien=
t.c#L5666 =20
> >=20
> > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > cc: Alex Markuze <amarkuze@redhat.com>
> > cc: Ilya Dryomov <idryomov@gmail.com>
> > cc: Patrick Donnelly <pdonnell@redhat.com>
> > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > ---
> >  fs/ceph/mds_client.c         |  2 +-
> >  fs/ceph/mdsmap.c             | 26 ++++++++++++++++++++------
> >  fs/ceph/mdsmap.h             |  1 +
> >  fs/ceph/super.h              | 19 ++++++++++++++++---
> >  include/linux/ceph/ceph_fs.h |  6 ++++++
> >  5 files changed, 44 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 7e4eab824dae..1c02f97c5b52 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_cl=
ient *mdsc,
> >         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
> >         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
> >         struct ceph_client *cl =3D mdsc->fsc->client;
> > -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> > +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
> >         const char *spath =3D mdsc->fsc->mount_options->server_path;
> >         bool gid_matched =3D false;
> >         u32 gid, tlen, len;
> > diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> > index 2c7b151a7c95..b54a226510f1 100644
> > --- a/fs/ceph/mdsmap.c
> > +++ b/fs/ceph/mdsmap.c
> > @@ -353,22 +353,35 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct cep=
h_mds_client *mdsc, void **p,
> >                 __decode_and_drop_type(p, end, u8, bad_ext);
> >         }
> >         if (mdsmap_ev >=3D 8) {
> > -               u32 fsname_len;
> > +               size_t fsname_len;
> > +
> >                 /* enabled */
> >                 ceph_decode_8_safe(p, end, m->m_enabled, bad_ext);
> > +
> >                 /* fs_name */
> > -               ceph_decode_32_safe(p, end, fsname_len, bad_ext);
> > +               m->m_fs_name =3D ceph_extract_encoded_string(p, end,
> > +                                                          &fsname_len,
> > +                                                          GFP_NOFS);
> > +               if (IS_ERR(m->m_fs_name)) {
> > +                       m->m_fs_name =3D NULL;
> > +                       goto nomem;
> > +               }
> >=20
> >                 /* validate fsname against mds_namespace */
> > -               if (!namespace_equals(mdsc->fsc->mount_options, *p,
> > +               if (!namespace_equals(mdsc->fsc->mount_options, m->m_fs=
_name,
> >                                       fsname_len)) {
> >                         pr_warn_client(cl, "fsname %*pE doesn't match m=
ds_namespace %s\n",
> > -                                      (int)fsname_len, (char *)*p,
> > +                                      (int)fsname_len, m->m_fs_name,
> >                                        mdsc->fsc->mount_options->mds_na=
mespace);
> >                         goto bad;
> >                 }
> > -               /* skip fsname after validation */
> > -               ceph_decode_skip_n(p, end, fsname_len, bad);
> > +       } else {
> > +               m->m_enabled =3D false;
> > +               /*
> > +                * name for "old" CephFS file systems,
> > +                * see ceph.git e2b151d009640114b2565c901d6f41f6cd5ec652
> > +                */
> > +               m->m_fs_name =3D kstrdup(CEPH_OLD_FS_NAME, GFP_NOFS);
> >         }
> >         /* damaged */
> >         if (mdsmap_ev >=3D 9) {
> > @@ -430,6 +443,7 @@ void ceph_mdsmap_destroy(struct ceph_mdsmap *m)
> >                 kfree(m->m_info);
> >         }
> >         kfree(m->m_data_pg_pools);
> > +       kfree(m->m_fs_name);
> >         kfree(m);
> >  }
> >=20
> > diff --git a/fs/ceph/mdsmap.h b/fs/ceph/mdsmap.h
> > index 1f2171dd01bf..d48d07c3516d 100644
> > --- a/fs/ceph/mdsmap.h
> > +++ b/fs/ceph/mdsmap.h
> > @@ -45,6 +45,7 @@ struct ceph_mdsmap {
> >         bool m_enabled;
> >         bool m_damaged;
> >         int m_num_laggy;
> > +       char *m_fs_name;
> >  };
> >=20
> >  static inline struct ceph_entity_addr *
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index a1f781c46b41..c53bec40ea69 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -104,6 +104,8 @@ struct ceph_mount_options {
> >         struct fscrypt_dummy_policy dummy_enc_policy;
> >  };
> >=20
> > +#define CEPH_NAMESPACE_WIDCARD         "*"
> > +
> >  /*
> >   * Check if the mds namespace in ceph_mount_options matches
> >   * the passed in namespace string. First time match (when
> > @@ -113,9 +115,20 @@ struct ceph_mount_options {
> >  static inline int namespace_equals(struct ceph_mount_options *fsopt,
> >                                    const char *namespace, size_t len)
> >  {
> > -       return !(fsopt->mds_namespace &&
> > -                (strlen(fsopt->mds_namespace) !=3D len ||
> > -                 strncmp(fsopt->mds_namespace, namespace, len)));
> > +       if (!fsopt->mds_namespace && !namespace)
> > +               return true;
> > +
> > +       if (!fsopt->mds_namespace)
> > +               return true;
> > +
> > +       if (strcmp(fsopt->mds_namespace, CEPH_NAMESPACE_WIDCARD) =3D=3D=
 0)
> > +               return true;
> > +
> > +       if (!namespace)
> > +               return false;
> > +
> > +       return !(strlen(fsopt->mds_namespace) !=3D len ||
> > +                 strncmp(fsopt->mds_namespace, namespace, len));
> >  }
> >=20
> >  /* mount state */
> > diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
> > index c7f2c63b3bc3..08e5dbe15ca4 100644
> > --- a/include/linux/ceph/ceph_fs.h
> > +++ b/include/linux/ceph/ceph_fs.h
> > @@ -31,6 +31,12 @@
> >  #define CEPH_INO_CEPH   2            /* hidden .ceph dir */
> >  #define CEPH_INO_GLOBAL_SNAPREALM  3 /* global dummy snaprealm */
> >=20
> > +/*
> > + * name for "old" CephFS file systems,
> > + * see ceph.git e2b151d009640114b2565c901d6f41f6cd5ec652
> > + */
> > +#define CEPH_OLD_FS_NAME       "cephfs"
> > +
> >  /* arbitrary limit on max # of monitors (cluster of 3 is typical) */
> >  #define CEPH_MAX_MON   31
> >=20
> > --
> > 2.52.0
> >=20
>=20

--=20
Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

