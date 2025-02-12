Return-Path: <linux-fsdevel+bounces-41607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98FA32E23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 19:05:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B549D188ABDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3625D538;
	Wed, 12 Feb 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aS38Zwnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FE209663;
	Wed, 12 Feb 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383545; cv=fail; b=OyjuNmhBVpi1aXgiYtN4W0ca4KkqmXaOaRx6XzTp1/3JcbEg1uH/e2NtFlJgOX9HutbEG1ps8boXdkRZNskQ80ZzKS6PjNiFsrtgAzK8olc2R70dEPHgwWleBGllz/CTxEVNpUD4ujSsCes5fdBBieevW5OFiqXgE1M+salo9gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383545; c=relaxed/simple;
	bh=ZeYRN0NkebSfLUiRHFq7LUY6U8oPHsG/Beo92Asuv1o=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=eTb+4YncV8KO5drjl7VYM2haNMIAGEI+rGbIiQ9sOnHTe9JS8Ho+seIyxx9T0cnZijfLXlFXo1WewwFR2hWMBW5rLSed1L9wFNISuzMP4MpDvEsC2BJyRyYecdKQD6zuygW7QfdTQYZXxg0yd5rwGivM9of4BMDcU77YFP5EfhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aS38Zwnm; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFcAOf029032;
	Wed, 12 Feb 2025 18:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ZeYRN0NkebSfLUiRHFq7LUY6U8oPHsG/Beo92Asuv1o=; b=aS38Zwnm
	1Ov6FNwY/ldhC2uDvz+2l8r0tbeR7YPlKPvIHR2j3w0oUy/cb6Ox3Vvwk0yklpPs
	RhUT18WeWFk2yf8NiO9FlHc/ajQGbnmM9G6ViCMhOEq8EjcIgmMOIYpU4iJijwEi
	ua0ve08mEbGw24BRiOCLUPkNrpcfaq0G92aCdaAeVmXIscZ5ynWbPiKLc/m8TPoY
	De0Jt6nyY9Haj3RgkQfu68S/TFNOAru4NqESUZTtohSjsfp3ulnm0jSyzAQ1ftw/
	tWoYQYpuKbvzw/aIrg71SWuAB5oQ5ngxXzfmc+Nm6iO1aKRNAm6ylG493NzwZ0YP
	W/Z2DPoOmp84lA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rqbpbe27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 18:05:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51CHtI4E030235;
	Wed, 12 Feb 2025 18:05:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rqbpbe24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 18:05:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgzFo/LYgKnWPriVIRk9by5QlqZs1iZbH46CQk5gLj8v82gb551apTD2WnAWGcJVhkrtv5nqpQ5g8OVy26FZVtzZ1BmzvTkAJUp7zD/9EbXJDTeGYZiYAXLGGNWoDaoQjNqBG+iTdEETC2oZ4gQ5p7H/x2JMdXsdWh/2DLKLPN/0moW92zxQ2zVCcEVw9KFJsMCLEhxWly8RWDCiS5I01tHZB8GSqr7iNiZ2cNSujOw3qKJyC7SAu+C3MtY9iJaI1xHwXW2/FzMRkUkXlCKYHULmeF1XX2eQW6dy6aRbwq1HF97PoTd/2Lz73YbGkmUgppUETj2EzyIg+LDSz/p6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeYRN0NkebSfLUiRHFq7LUY6U8oPHsG/Beo92Asuv1o=;
 b=RpRva0PPXcN9f3zr9LBmtKgEGdrkD7ZWZ3OpWXRJ+lhlvpVCE5345VG/rkNsHexq2vZwhrsOIQlpGScy7xeE3gfE4eWLsul0okTFI7HktA7FAkOkaEFB0cdnDANAKaBzl+yW/CU2uenYsgHxwwv92RqDlFyRobDJeMdm5R1JAWjvsuuO13oB1z8RwZiWZLJIV46+G27cs6cWyTco5CY5wHzc4aNPUOylfb3VJFxps1uAgaU3prUKC5+761/4IOGRFaYRXxBM+hoA4A/fo5Me7poTkjEHp5P9q+QumAOPhqasYPdIZ80cbnbXA2nDVx0DF4IAzccajGSU/RlU/JLJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Wed, 12 Feb
 2025 18:05:36 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 18:05:36 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        David Howells
	<dhowells@redhat.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Patrick Donnelly <pdonnell@redhat.com>,
        Alex
 Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
Thread-Topic: [EXTERNAL] [RFC PATCH 0/4] ceph: fix generic/421 test failure
Thread-Index: AQHbd2FinymQ5bpg1EKNuh8DVLO+obNEAqqA
Date: Wed, 12 Feb 2025 18:05:36 +0000
Message-ID: <2d3e11bb23b1709359a6b457d91662a24e483ba8.camel@ibm.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
In-Reply-To: <20250205000249.123054-1-slava@dubeyko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA1PR15MB4644:EE_
x-ms-office365-filtering-correlation-id: c0b67b0a-953f-47f8-3afb-08dd4b8fd9e2
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RThvTk9qT2dsejZWdVdmNFhjYU1CdEV4T0tYTnd4RlB3RjZqMGRoK0hmK2Y5?=
 =?utf-8?B?d0VTcldCWnlXSVBiTy9SWGJXeUFwYnlwczVMYVJZMzJKN2RlZ0dobkdobVkx?=
 =?utf-8?B?MlllV0JoOGVxMGVnWWErdlREeFlsdERFTVZSNGw5WExKajRWYzVUTDFEMmdP?=
 =?utf-8?B?R1BwTi9Sb0Qyb3FGbklDK1V5TWRZWG5jdWFNTXFmT3RQTzZHU1RINnB1RGF5?=
 =?utf-8?B?azJXbzJzdFM5MUtLa1NXQlRLRzQ4ejBuQWtUd3pmd0w3NEo4aDU5cXRQcm1m?=
 =?utf-8?B?NEVzS0FWUGk1cGRXSkdFc0lMK1Z4d1JyZDJ5NGVtY0wxTERvQ0crSFRuV3dm?=
 =?utf-8?B?cnZkWHkrRFhxZlc2RE93UUQzcWl0ZkhnVGN4ZVh0VWhhalVhVXljSTNBOHZN?=
 =?utf-8?B?eHVYZEdieitFVExacEV4dnB6TzYyMXZNbks4TUMrV2hocWsyY3RVcUpVZXpa?=
 =?utf-8?B?UUhqUUVSSDhmVWVpUmJaVkJENE9xSW5TN3JjSTVvZGNlTldWUXNYb01nRU96?=
 =?utf-8?B?MlRsRHNsVDhUbHd6WEVmS0tvVEZaQU96aVlrd2h4d3dHdXgyY3RudjJFdHVK?=
 =?utf-8?B?Q0ZJMXltTTdTMjg2ZmllU0ZBSUl4MGVjKy9EektlREFIblErU3JrdEUveS8y?=
 =?utf-8?B?Tm5sM0tqbTh4RTlKUHcrbkdkcnM3OGE0SWRucWRpZHpqeXlZMkVSQk1pK1I3?=
 =?utf-8?B?U0lHT1J5bUNtTXhGejlzWTVVbU5zdTNFa2ZMem1kWVJJdlBWRkFWYU1wY3Fz?=
 =?utf-8?B?eUovV2hoOVRsRFU5L3JoL2xzYUR4Ym5YVVV0RTdvVENwcDExNHFiTjBXU0ty?=
 =?utf-8?B?bWJtVHVkNDRjenRFVEgzbUgyMVJqTGx4SGk3ZkdrZFZadzBTWm1BNUhlbWho?=
 =?utf-8?B?UEtMbHF6R3J5Z1BOakNPYWFUMyt1dEZrVGhuTGNzeWFlUDIrY09LNUduVTh2?=
 =?utf-8?B?UlRmYWR4MmRWcjQvajcxY2tTelJSMytCc2lkWDRPVEx6Y1NWQUpaalBQTUZR?=
 =?utf-8?B?K3JSN3JOSmVTeG5EKzJzVFdhcjhHTDFEUlhTUmtYdEwwNDc5VWMxN2JLWUc5?=
 =?utf-8?B?L0xuMmtsMnlYTVpPTmZmcTU1UU9iTm1laGRXNTdXQmZ3bmdYcklITHFaRlZ5?=
 =?utf-8?B?NjlJUngzQW81RGJGZ1c3aHRpTmVuekh0bm8rOEhKWFRhWDBCQktrdjBBQnN6?=
 =?utf-8?B?UmMrclUwLzdXZkJld0pMZTlIRlhRd3Qrd3BkcDVVQ3pzNE1SRkRDaW1xYjVl?=
 =?utf-8?B?ckprcE9aYUFuZTd1ek1naDdVQkpRa1VobTcvVEhaVFRXby93SHpWWDBqUkZs?=
 =?utf-8?B?OGtyNG5kdjd4U0VESWtNL1pueXFpY2pSVDMvMGg5SlhaRzNQME9rTjl6R3h2?=
 =?utf-8?B?SlNpNngrQ0x2RUFKeUwxeDZackg3WTk5UnVLdnh5Y24rTXd4dHgvQll6VU1O?=
 =?utf-8?B?SkhGSGNWd2dnRGRmQWRMOWpvZTh0QlJmTUVoR2VzanM5V1p1bGdWU2x4Q25S?=
 =?utf-8?B?NEduaDM1QjhlZjdkTG4ySUczTStSa3pnZENjUUZoYkw2N3dJcjc2djlqY3Fv?=
 =?utf-8?B?eU5Lb2kxWExRdlNlWHR3elgvbWh6YnQ3V3gvWTYwWFJJQWxpWnc5ZWRqbVZx?=
 =?utf-8?B?Wmw1SjB2ZFRsS3hEbC9EL0pxUjFZcWxacXRhSnRGMlRvdkI5RHB3cUVOUWJr?=
 =?utf-8?B?UFNiVkdOeCt4cHNFUm44cDkxZGovdVZqQm82MUZ1QnRkMkpFSW5XVkJWa1FC?=
 =?utf-8?B?VXlMSFF3bXJNcmZYNlNIZWVEeVNnaE1odTJpd25kUEVJc1RFemYxRHdsYytV?=
 =?utf-8?B?SzFSUTU2cXdUc21NN1FJa1IzeXo1c1l0dDh6RHhSUjdHb0JHV0ZhRWlIa0VI?=
 =?utf-8?B?N09oSm9WdXlOU1loODJZZWg0R0VNdmxwQjBlam9TMjM4RWxzL3RrWnkzTHdw?=
 =?utf-8?Q?Ia3OmVG0aNJlmMueSS0MSpnVCPN++uWr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TklLcGRpQzRrMk9rWnkyYjBPNTNsWW81VXV5bktVS2lpOXFYbDUvREtRaDZX?=
 =?utf-8?B?aklZVGRtYklDdW5pMTRTaDZ5ai94STArNVY1Vld4OWdlVkp4RVZOQXpjZW5Y?=
 =?utf-8?B?eXVIQ3lxYkhwYWtGVk1Dd0t2REIvVUpjTElvZFpHMUhOc2NzK2hPTDB4RWtM?=
 =?utf-8?B?ODhZTWFHYjlGeW40S3ZuV0ViMWx4aUlSN3lyalBmby9PSWpFT3M0SGN4MWcz?=
 =?utf-8?B?bzU1UTRTUEMrUFZvOGFFVmJQQ1VrRTZybktlM2tkU25XVDZtRWxCQmhoQ0No?=
 =?utf-8?B?UXoweFp5YkRoN0wzWXdHVjhKVWlick15WnNqMi9OWm5sempXOFkrbHdzWkpR?=
 =?utf-8?B?WVhwWjVEMHNYTFU1c1cwRnhPcHlVVVpxNnVJak1UaHl4enpPaUJlTjhoamtO?=
 =?utf-8?B?S3gzVGxEVEd2SjdaMHN4NlN5N3NmV010dEN3ZWpTcFZBNlJrL0NjVTM4VEJ2?=
 =?utf-8?B?TXBkcW9tWTIyZ3JIYXo2UXlTSXdib1R3YlBIVHQwWU1LbktyVnA0ck94eGZk?=
 =?utf-8?B?dWtKYXJ2bzc1dVNPY3VWYjcydUdteWdENy9vNjV0dkRLUU5XVFVUUzl1aEZG?=
 =?utf-8?B?ZzZWcEZxUFl4NE92WGh4Tlc4VWJDbXU5MVRtMnBuaXg1Y3U0RzN2N1N0TmVU?=
 =?utf-8?B?aUFEeFNRL21teXA0YVNIbkJmQWNKYmlqc0dkRkpBQmZzdW8zTElGa1c5cGJ3?=
 =?utf-8?B?bjI2NmVjT3BqMC93YTdkNGd3ZUgrT1dOV3V5dCtZYUpVekRoNzRzMGoxNENm?=
 =?utf-8?B?WjJhZ0hTbzlaV0d0RW16U0RDY1huMmlQK08wYnc0R3R2dytTT1FqZ09qMDB1?=
 =?utf-8?B?QXJvK1lVRWhXYWJJZXN1dlJhQ2tEbUxsVE9qSjFsOS9GQzBheXVRU1BmTnd4?=
 =?utf-8?B?NEV5ZU5tdWx0TEdyL0ZDL3d1NkZtL0cvdGtXSXRTV1g2bWRjRFRxZmYvMXRN?=
 =?utf-8?B?R215NDAxcFZqUVJCa1Fva3RidVNyYTFPbWNDUlltaE9jQ3VxalROMmZvZ0pk?=
 =?utf-8?B?d2Y1cEp0c01NL2VBWUw5QWo1U3hzYnE0RFhja0ppWUlqTUpGOTRsRG5MZ3Vw?=
 =?utf-8?B?dFBUa3hxMUtCTVZidnlwakQ1b3AydFBQNnh6djMrbG5GY0ZrUHp4d0V3clJD?=
 =?utf-8?B?WENDeEJORWI3RnNNNjBFczI4NktNRFVMdXBnaEJJQlVTZWtqWktjem1BNDZB?=
 =?utf-8?B?ZDZUTDdGVU4wY1hkWDd3QWowWnVONW9oVDJPMnkxNHZ5bGM0aXR4dTQ1S0Nz?=
 =?utf-8?B?aFNPL0NIYkJ2V25HNTlOTXZVWTlNRXN2OGE3RytFZnRIQm1KdWlENEF4TG1D?=
 =?utf-8?B?ak82ZEZiZk8zcGsyS0lRMkxjWGtFK3dKMFRyRjNFcXo5TUJGUVBUbWRtb3Z0?=
 =?utf-8?B?MTFWeE9BeFg3YkZiblBWdWRYMTRvWkdFR2N4OXo3Nm8vZWtyQnc5QlhSU1lC?=
 =?utf-8?B?TkFaaERQRG5JNlZrOXE1Ty80ZnVib0p4RE1Ka1B5STg3Z1VkL1J5M2lZQ1Y5?=
 =?utf-8?B?aWgxOWI3aGgyL3B2R3ZLQXNkSTVVdzVWVzd6U3lGd2NsKzVFSE42d2RhNlhi?=
 =?utf-8?B?MnY5eTBITUtuYmx1amhrRVdwNUtVRWszUmJQbzI5MEUxREVYL0dSbFd2bnJZ?=
 =?utf-8?B?cUd3TzNkL3A3K2dzNjZkeVRJdFkzZG95VWEzZk10cTB1WHVteW5EazVRSnlM?=
 =?utf-8?B?emdmNmNOaGF4eng4VnNBY1dyMjZhUkFPVVh1a1FKSllGSFJkY0c1cStPUjhF?=
 =?utf-8?B?UEduTitBMkt4Nk9iTlZSdm9ORWFXZTQvZHc1WCtiQUprS0U4ZEFKcEF3aVZG?=
 =?utf-8?B?S0QyVGdhNUxxcTducFhmWWZkcXNkd1RqckhmV01VYXlieXZZUElOdUZ6c1cx?=
 =?utf-8?B?d0VoUXB5eVZ2MG4xRmZhNWVyV0JEc2sxMGpKMi9MUEJkK0dMQUZYMUNISE1p?=
 =?utf-8?B?aHRUWUNHcERmSnBlcm81clJUVFZzUHJMVG91UU1GSUhSVGZ4MnZwN1hweEtM?=
 =?utf-8?B?RWpLSHlRb2FWUjRVekxxT2k3YjV5aEFzeUZWcWhPTUdoOHBoZnFCd05Sc3B2?=
 =?utf-8?B?M0ZhVkhtNzlhZWIzdDBGeG80by84d0JpMVkrU1lhNlFHb2VyZWdKcTJOUGZj?=
 =?utf-8?B?SUNYZFFDTG9zT3RrTTk0WjdlMGp1TCs2VnVwRUdQbUxDSWwzcW9NWnJBcjNk?=
 =?utf-8?Q?bBKbiT61sRI7Jaw9y5LQjFw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <42C3AD0588A7FD4C86C402C17991DBF8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b67b0a-953f-47f8-3afb-08dd4b8fd9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 18:05:36.3868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHTsLoT59O3ypqpPmYj5+NXg1t7N+7uQNqX8yforhjMEgbjpPkHlHacZ05eGA6tcwIIDxrj5bbz5bOqH3eeGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-Proofpoint-GUID: h1Vfi_5cqrtZCJQTAhN4tGD36uYls5k9
X-Proofpoint-ORIG-GUID: sHch0JR28rTCyTg_OypIojkWkw3zbXT5
Subject: Re:  [RFC PATCH 0/4] ceph: fix generic/421 test failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120130

SGkgRGF2aWQsDQoNCkhhdmUgeW91IHRyaWVkIHRoZSBmaXg/IERvZXMgaXQgZml4IHRoZSAgaXNz
dWUgb24geW91ciBzaWRlPw0KDQpUaGFua3MsDQpTbGF2YS4NCg0KT24gVHVlLCAyMDI1LTAyLTA0
IGF0IDE2OjAyIC0wODAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3JvdGU6DQo+IEZyb206IFZpYWNo
ZXNsYXYgRHViZXlrbyA8U2xhdmEuRHViZXlrb0BpYm0uY29tPg0KPiANCj4gVGhlIGdlbmVyaWMv
NDIxIGZhaWxzIHRvIGZpbmlzaCBiZWNhdXNlIG9mIHRoZSBpc3N1ZToNCj4gDQo+IEphbiAzIDE0
OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjkuODk0Njc4XSBJTkZPOiB0YXNr
IGt3b3JrZXIvdTQ4OjA6MTEgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMiBzZWNvbmRzLg0KPiBK
YW4gMyAxNDoyNToyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgMzY5Ljg5NTQwM10gTm90
IHRhaW50ZWQgNi4xMy4wLXJjNSsgIzENCj4gSmFuIDMgMTQ6MjU6MjcgY2VwaC10ZXN0aW5nLTAw
MDEga2VybmVsOiBbIDM2OS44OTU4NjddICJlY2hvIDAgPiAvcHJvYy9zeXMva2VybmVsL2h1bmdf
dGFza190aW1lb3V0X3NlY3MiIGRpc2FibGVzIHRoaXMgbWVzc2FnZS4NCj4gSmFuIDMgMTQ6MjU6
MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbIDM2OS44OTY2MzNdIHRhc2s6a3dvcmtlci91
NDg6MCBzdGF0ZTpEIHN0YWNrOjAgcGlkOjExIHRnaWQ6MTEgcHBpZDoyIGZsYWdzOjB4MDAwMDQw
MDANCj4gSmFuIDMgMTQ6MjU6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbIDM2OS44OTY2
NDFdIFdvcmtxdWV1ZTogd3JpdGViYWNrIHdiX3dvcmtmbiAoZmx1c2gtY2VwaC0yNCkNCj4gSmFu
IDMgMTQ6MjU6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbIDM2OS44OTc2MTRdIENhbGwg
VHJhY2U6DQo+IEphbiAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjku
ODk3NjIwXSA8VEFTSz4NCj4gSmFuIDMgMTQ6MjU6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVs
OiBbIDM2OS44OTc2MjldIF9fc2NoZWR1bGUrMHg0NDMvMHgxNmIwDQo+IEphbiAzIDE0OjI1OjI3
IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjkuODk3NjM3XSBzY2hlZHVsZSsweDJiLzB4
MTQwDQo+IEphbiAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjkuODk3
NjQwXSBpb19zY2hlZHVsZSsweDRjLzB4ODANCj4gSmFuIDMgMTQ6MjU6MjcgY2VwaC10ZXN0aW5n
LTAwMDEga2VybmVsOiBbIDM2OS44OTc2NDNdIGZvbGlvX3dhaXRfYml0X2NvbW1vbisweDExYi8w
eDMxMA0KPiBKYW4gMyAxNDoyNToyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgMzY5Ljg5
NzY0Nl0gPyBfcmF3X3NwaW5fdW5sb2NrX2lycSsweGUvMHg1MA0KPiBKYW4gMyAxNDoyNToyNyBj
ZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6IFsgMzY5Ljg5NzY1Ml0gPyBfX3BmeF93YWtlX3BhZ2Vf
ZnVuY3Rpb24rMHgxMC8weDEwDQo+IEphbiAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtl
cm5lbDogWyAzNjkuODk3NjU1XSBfX2ZvbGlvX2xvY2srMHgxNy8weDMwDQo+IEphbiAzIDE0OjI1
OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjkuODk3NjU4XSBjZXBoX3dyaXRlcGFn
ZXNfc3RhcnQrMHhjYTkvMHgxZmIwDQo+IEphbiAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAx
IGtlcm5lbDogWyAzNjkuODk3NjYzXSA/IGZzbm90aWZ5X3JlbW92ZV9xdWV1ZWRfZXZlbnQrMHgy
Zi8weDQwDQo+IEphbiAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjku
ODk3NjY4XSBkb193cml0ZXBhZ2VzKzB4ZDIvMHgyNDANCj4gSmFuIDMgMTQ6MjU6MjcgY2VwaC10
ZXN0aW5nLTAwMDEga2VybmVsOiBbIDM2OS44OTc2NzJdIF9fd3JpdGViYWNrX3NpbmdsZV9pbm9k
ZSsweDQ0LzB4MzUwDQo+IEphbiAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDog
WyAzNjkuODk3Njc1XSB3cml0ZWJhY2tfc2JfaW5vZGVzKzB4MjVjLzB4NTUwDQo+IEphbiAzIDE0
OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjkuODk3NjgwXSB3Yl93cml0ZWJh
Y2srMHg4OS8weDMxMA0KPiBKYW4gMyAxNDoyNToyNyBjZXBoLXRlc3RpbmctMDAwMSBrZXJuZWw6
IFsgMzY5Ljg5NzY4M10gPyBmaW5pc2hfdGFza19zd2l0Y2guaXNyYS4wKzB4OTcvMHgzMTANCj4g
SmFuIDMgMTQ6MjU6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbIDM2OS44OTc2ODddIHdi
X3dvcmtmbisweGI1LzB4NDEwDQo+IEphbiAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtl
cm5lbDogWyAzNjkuODk3Njg5XSBwcm9jZXNzX29uZV93b3JrKzB4MTg4LzB4M2QwDQo+IEphbiAz
IDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjkuODk3NjkyXSB3b3JrZXJf
dGhyZWFkKzB4MmI1LzB4M2MwDQo+IEphbiAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtl
cm5lbDogWyAzNjkuODk3Njk0XSA/IF9fcGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQo+IEph
biAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjkuODk3Njk2XSBrdGhy
ZWFkKzB4ZTEvMHgxMjANCj4gSmFuIDMgMTQ6MjU6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVs
OiBbIDM2OS44OTc2OTldID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gSmFuIDMgMTQ6MjU6
MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbIDM2OS44OTc3MDFdIHJldF9mcm9tX2Zvcmsr
MHg0My8weDcwDQo+IEphbiAzIDE0OjI1OjI3IGNlcGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAz
NjkuODk3NzA1XSA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+IEphbiAzIDE0OjI1OjI3IGNl
cGgtdGVzdGluZy0wMDAxIGtlcm5lbDogWyAzNjkuODk3NzA3XSByZXRfZnJvbV9mb3JrX2FzbSsw
eDFhLzB4MzANCj4gSmFuIDMgMTQ6MjU6MjcgY2VwaC10ZXN0aW5nLTAwMDEga2VybmVsOiBbIDM2
OS44OTc3MTFdIDwvVEFTSz4NCj4gDQo+IFRoZXJlIGFyZSBzZXZlcmFsIGlzc3VlcyBoZXJlOg0K
PiAoMSkgY2VwaF9raWxsX3NiKCkgZG9lc24ndCB3YWl0IGVuZGluZyBvZiBmbHVzaGluZw0KPiBh
bGwgZGlydHkgZm9saW9zL3BhZ2VzIGJlY2F1c2Ugb2YgcmFjeSBuYXR1cmUgb2YNCj4gbWRzYy0+
c3RvcHBpbmdfYmxvY2tlcnMuIEFzIGEgcmVzdWx0LCBtZHNjLT5zdG9wcGluZw0KPiBiZWNvbWVz
IENFUEhfTURTQ19TVE9QUElOR19GTFVTSEVEIHRvbyBlYXJseS4NCj4gKDIpIFRoZSBjZXBoX2lu
Y19vc2Rfc3RvcHBpbmdfYmxvY2tlcihmc2MtPm1kc2MpIGZhaWxzDQo+IHRvIGluY3JlbWVudCBt
ZHNjLT5zdG9wcGluZ19ibG9ja2Vycy4gRmluYWxseSwNCj4gYWxyZWFkeSBsb2NrZWQgZm9saW9z
L3BhZ2VzIGFyZSBuZXZlciBiZWVuIHVubG9ja2VkDQo+IGFuZCB0aGUgbG9naWMgdHJpZXMgdG8g
bG9jayB0aGUgc2FtZSBwYWdlIHNlY29uZCB0aW1lLg0KPiAoMykgVGhlIGZvbGlvX2JhdGNoIHdp
dGggZm91bmQgZGlydHkgcGFnZXMgYnkNCj4gZmlsZW1hcF9nZXRfZm9saW9zX3RhZygpIGlzIG5v
dCBwcm9jZXNzZWQgcHJvcGVybHkuDQo+IEFuZCB0aGlzIGlzIHdoeSBzb21lIG51bWJlciBvZiBk
aXJ0eSBwYWdlcyBzaW1wbHkgbmV2ZXINCj4gcHJvY2Vzc2VkIGFuZCB3ZSBoYXZlIGRpcnR5IGZv
bGlvcy9wYWdlcyBhZnRlciB1bm1vdW50DQo+IGFueXdheS4NCj4gDQo+IFRoaXMgcGF0Y2hzZXQg
aXMgcmVmYWN0b3JpbmcgdGhlIGNlcGhfd3JpdGVwYWdlc19zdGFydCgpDQo+IG1ldGhvZCBhbmQg
aXQgZml4ZXMgdGhlIGlzc3VlcyBieSBtZWFucyBvZjoNCj4gKDEpIGludHJvZHVjaW5nIGRpcnR5
X2ZvbGlvcyBjb3VudGVyIGFuZCBmbHVzaF9lbmRfd3ENCj4gd2FpdGluZyBxdWV1ZSBpbiBzdHJ1
Y3QgY2VwaF9tZHNfY2xpZW50Ow0KPiAoMikgY2VwaF9kaXJ0eV9mb2xpbygpIGluY3JlbWVudHMg
dGhlIGRpcnR5X2ZvbGlvcw0KPiBjb3VudGVyOw0KPiAoMykgd3JpdGVwYWdlc19maW5pc2goKSBk
ZWNyZW1lbnRzIHRoZSBkaXJ0eV9mb2xpb3MNCj4gY291bnRlciBhbmQgd2FrZSB1cCBhbGwgd2Fp
dGVycyBvbiB0aGUgcXVldWUNCj4gaWYgZGlydHlfZm9saW9zIGNvdW50ZXIgaXMgZXF1YWwgb3Ig
bGVzc2VyIHRoYW4gemVybzsNCj4gKDQpIGFkZGluZyBpbiBjZXBoX2tpbGxfc2IoKSBtZXRob2Qg
dGhlIGxvZ2ljIG9mDQo+IGNoZWNraW5nIHRoZSB2YWx1ZSBvZiBkaXJ0eV9mb2xpb3MgY291bnRl
ciBhbmQNCj4gd2FpdGluZyBpZiBpdCBpcyBiaWdnZXIgdGhhbiB6ZXJvOw0KPiAoNSkgYWRkaW5n
IGNlcGhfaW5jX29zZF9zdG9wcGluZ19ibG9ja2VyKCkgY2FsbCBpbiB0aGUNCj4gYmVnaW5uaW5n
IG9mIHRoZSBjZXBoX3dyaXRlcGFnZXNfc3RhcnQoKSBhbmQNCj4gY2VwaF9kZWNfb3NkX3N0b3Bw
aW5nX2Jsb2NrZXIoKSBhdCB0aGUgZW5kIG9mDQo+IHRoZSBjZXBoX3dyaXRlcGFnZXNfc3RhcnQo
KSB3aXRoIHRoZSBnb2FsIHRvIHJlc29sdmUNCj4gdGhlIHJhY3kgbmF0dXJlIG9mIG1kc2MtPnN0
b3BwaW5nX2Jsb2NrZXJzLg0KPiANCj4gc3VkbyAuL2NoZWNrIGdlbmVyaWMvNDIxDQo+IEZTVFlQ
ICAgICAgICAgLS0gY2VwaA0KPiBQTEFURk9STSAgICAgIC0tIExpbnV4L3g4Nl82NCBjZXBoLXRl
c3RpbmctMDAwMSA2LjEzLjArICMxMzcgU01QIFBSRUVNUFRfRFlOQU1JQyBNb24gRmViICAzIDIw
OjMwOjA4IFVUQyAyMDI1DQo+IE1LRlNfT1BUSU9OUyAgLS0gMTI3LjAuMC4xOjQwNTUxOi9zY3Jh
dGNoDQo+IE1PVU5UX09QVElPTlMgLS0gLW8gbmFtZT1mcyxzZWNyZXQ9PHNlY3JldD4sbXNfbW9k
ZT1jcmMsbm93c3luYyxjb3B5ZnJvbSAxMjcuMC4wLjE6NDA1NTE6L3NjcmF0Y2ggL21udC9zY3Jh
dGNoDQo+IA0KPiBnZW5lcmljLzQyMSA3cyAuLi4gIDRzDQo+IFJhbjogZ2VuZXJpYy80MjENCj4g
UGFzc2VkIGFsbCAxIHRlc3RzDQo+IA0KPiBWaWFjaGVzbGF2IER1YmV5a28gKDQpOg0KPiAgIGNl
cGg6IGV4dGVuZCBjZXBoX3dyaXRlYmFja19jdGwgZm9yIGNlcGhfd3JpdGVwYWdlc19zdGFydCgp
DQo+ICAgICByZWZhY3RvcmluZw0KPiAgIGNlcGg6IGludHJvZHVjZSBjZXBoX3Byb2Nlc3NfZm9s
aW9fYmF0Y2goKSBtZXRob2QNCj4gICBjZXBoOiBpbnRyb2R1Y2UgY2VwaF9zdWJtaXRfd3JpdGUo
KSBtZXRob2QNCj4gICBjZXBoOiBmaXggZ2VuZXJpYy80MjEgdGVzdCBmYWlsdXJlDQo+IA0KPiAg
ZnMvY2VwaC9hZGRyLmMgICAgICAgfCAxMTEwICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0tLS0tLQ0KPiAgZnMvY2VwaC9tZHNfY2xpZW50LmMgfCAgICAyICsNCj4gIGZzL2Nl
cGgvbWRzX2NsaWVudC5oIHwgICAgMyArDQo+ICBmcy9jZXBoL3N1cGVyLmMgICAgICB8ICAgMTEg
Kw0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA3NDYgaW5zZXJ0aW9ucygrKSwgMzgwIGRlbGV0aW9ucygt
KQ0KPiANCg0KLS0gDQpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4N
Cg==

