Return-Path: <linux-fsdevel+bounces-47027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93463A97DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164BB3BD642
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 04:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4226561B;
	Wed, 23 Apr 2025 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kw2Og9cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3B19CC3A;
	Wed, 23 Apr 2025 04:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745383116; cv=fail; b=lHBRcv2RscI3NVxNwxLXyU+eHwoLv+mDA8t5mgjn99LNp/jqsb8pImEjx6hLw/WyxfK8rXE6SMp21H3F3SN+cYFa4Yr6cpVwMfjZYpyP2F3iL5EN3XbbYjvxf0hVoCUP2tEYdYXSM5gIFzxWY1XuB9O43JOSMKmk6FAS9ybPu68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745383116; c=relaxed/simple;
	bh=2dnkUQjoUGkBOa+32+NpuzmXRyJVd4o1cvtAqpOiOtE=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=Egr3cMXQKw6ZPRMXSrzRhaz/7qwgPDhXlucbMqaO7vGx/R9SaYH4MyBYnn8o253zNVQDwYLF58A6hfJ5W3n6eIQARME0v5ESm/TKVL5bCNK4VRu5O0xfbrZsIeX85VTIKWOZE01wyuRXAUCvt7JQBZgnKUEb2IyXlvXyU8XVOjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kw2Og9cf; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ML3J89014707;
	Wed, 23 Apr 2025 04:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=2dnkUQjoUGkBOa+32+NpuzmXRyJVd4o1cvtAqpOiOtE=; b=kw2Og9cf
	yIZ36QGRKTaPilcQ/dXYk4gVz+QA6mkS+zeF/8X+rFnmNWszcRvLyepXebXzKG6/
	cJW/J2kY5kp2rWOvM8oKv1CwjK6gS+fqOUJfnVcaD3Y/H+DS7QpRkUkCGcLXiwyS
	NwdeFaJjRp10Afwx936LDTNEDdmlD/9rvQhnjbzDAbPEMz9GTnmInxxo1pb/7utN
	pbsUAKRELausOnmB4qouBnAO53ftMEQBTF9EE6fm11zauzJaaY9EeSIoKkR8Y3A+
	Se7hYH5VYFegWdxb7771Lqr1J4aB2Fo7/9VVqWqBSsaP3s1QLy7VnMsIAW7mtC5h
	IFlJXXpcLftUGg==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466jpe1frg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 04:38:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kny4Nu8eiYIDTidO2c6v8CoP+5B2fvD7d/cNgnu98rxeUG99boWGPkG+biXCtCDyJ0RI5b2GXm2BcjpQC0SwKG5dM8P7kNVDWKh6Pl96NFbhvqOWT0WO0kPVR/Ea7Nwq1c3JkNBeIxoreq4bGKvgYXesOLlq1aczbxTrIAZ8Uc8AFzQ0Qc4JLp/P9VXS7JJ831PNA2UNoj5qHS+m6hmJVBiPaDRboxzrrv+ei3o0mF57Ux49pTpuDhogfnsPzcF9phnydNFR4wAQcrJNZJXhACjYAGOl1e25KTe1E2sqMzXkgqa3BuKIfLOnyTEHN43PT4++PW0BLk2Z6x+mRwOEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dnkUQjoUGkBOa+32+NpuzmXRyJVd4o1cvtAqpOiOtE=;
 b=xJHKoCa+cFSru1AWTXlDiFgbcK+C+tgBf6+fH021oU/CcqKwmXy6AuaQK6aucvE1VaXjg+Ci3xOXxGJU4zEVktmRBQhnyBmI2LAqumDTOGsGE0LwAzte71lfaT4bhHemVRui6+rgZ8VEgg2Fh8sdk1aamU07IhsV/XHOdCb6XWnU7Z4/PL0ObxKJgdRvRjL/Z5qRGiKMIyr6nMoo9trjCjxIkRZiZ12yUy5f5nLhnAqTVZREaxQYcc9FBDq2zd1Sx8e2KSSbVj4JtxGAvrePdEwJZzLaLCVSC9vgjzh3H2ODrpwxnfkbcHidTM/ZDUJZJqWbQCMO8wiQu19u2WKDVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB6239.namprd15.prod.outlook.com (2603:10b6:610:164::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 23 Apr
 2025 04:38:14 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 04:38:14 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>
CC: "jack@suse.com" <jack@suse.com>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "sandeen@redhat.com" <sandeen@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "josef@toxicpanda.com"
	<josef@toxicpanda.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "willy@infradead.org"
	<willy@infradead.org>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfs{plus}: add deprecation warning
Thread-Index:
 AQHbrhWWXaRwwnXSdkukdsi2+kZKRrOl1QqAgACQ7wCAAC+YAIABBJgAgACRlICAAAEmAIAAOtSAgAhLaQCAAAO/AA==
Date: Wed, 23 Apr 2025 04:38:13 +0000
Message-ID: <e7f3a9e24e3c951d18a3697c9d9ca2721d9e3e08.camel@ibm.com>
References: <5e5403b1f1a7903c48244afba813bfb15890eac4.camel@ibm.com>
	 <20250423042448.2045361-1-frank.li@vivo.com>
In-Reply-To: <20250423042448.2045361-1-frank.li@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB6239:EE_
x-ms-office365-filtering-correlation-id: 52e3c73b-9b8d-4053-fce6-08dd8220a8e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OWJQTjZVY0tDUDB1eDdiL3d5bUhPVk9PaEhobWhYUGZnVGoyNk5jQU42Wnps?=
 =?utf-8?B?WFAzbm1lQU9RelNMU05uME9HbGF5MVd6MzNPckxqQmxOSjBkMkdKZzNXWTc5?=
 =?utf-8?B?Ykl1cGMrZ0ExN3FsL0FFaUlBUFoydzl3S3ZaNWFzUnJpcmtZUmZJdTFBQ25F?=
 =?utf-8?B?MlVxTW8xMzZ1dFNaWFhEZWcvcmR6WWhuM29ENnB4RnNzMGJGOHdjUlN0ekRF?=
 =?utf-8?B?UTBVYTdJUHowNHU3ZHpuTTcxajkxSTJwMUMvcGZlMmZVT292UUFqTXVObVFU?=
 =?utf-8?B?alhtdUozQ3Q1LzNMU0F3RzZ1MEZ6R0l0djNNdDZ4T1o5TEFvU1hQQUN6U3NR?=
 =?utf-8?B?Y1ZGTjhubXFBT2tUZStsUUVCdDh1YlVUR0o2Mi9UWEcwblJiOFVOZkkxdWpH?=
 =?utf-8?B?SzB4Vm9hR0oweDhUZ293bEFjbWdjZ1lFZ3Q5aENyZ1o4OTUyVE0vbTFtUzlr?=
 =?utf-8?B?Y3hNSVZlTHFER3NhM0hReWlMaU1WK0ZlTy9ibzZZQTZzVEJKTTE1bnBuemtn?=
 =?utf-8?B?cE9MYjZMYWVCUTRUekVnc1hiby9GNWVELzZQQmEwc1hHTDliQkxVZHd5azN2?=
 =?utf-8?B?cFEvYS9lYmV5eS9ZRFA4Z2xKcmJjVzhFUVpzN1NnK3Z0K0ZPc3BCQUZoNlFY?=
 =?utf-8?B?R1RON3pYQzlBbmhiM0R0bEV2dDI1K3NvU1h0L0IzNEdXVTJZc09SbkNaV251?=
 =?utf-8?B?Q0VXY1hCbmMxTjBmeFJaMWVOeXVlQUhZaTBHRzEveW0rM2xqaXNTaU5xN0Vy?=
 =?utf-8?B?Q3lNbWRKODI3M1UyMDRCN0xDaDg3ZGtlemVvODZuUTUzbTZneFE1eUk3dFhy?=
 =?utf-8?B?V0toOUkrNnczY1ZwS3dWQmRDMmZjbDVvTkxBUjd5ZFFVY01wRlZZTTNnVkl1?=
 =?utf-8?B?WVlvNHZZaWlLTmg5M0lBSzM5clVZTHAvQlJJTDBwQjNoN0paOGZZV2dTN3ZC?=
 =?utf-8?B?a3QvV2NUa29BSFA1czlMREc1OVQ3OHloRlV3Um4veFd6T2FMYnVOeWpQR1ln?=
 =?utf-8?B?M0FKQk81Wmd2eEprTGFaTWZKZ0s1bEtnTTNGNHNlYjNKTk1QeXNFeVlYWkNr?=
 =?utf-8?B?QWE2b1pySG9OcjU4dHYrNXc2WUlYSFhzWjA4NzZybkFBUlRleStQK29Fdng0?=
 =?utf-8?B?R0VBNDBIVUxBUnNYNUUyaXMwVGovalArQzdZY2REb2ZoZHBJMmJ4ZUF3WDZj?=
 =?utf-8?B?M0VCR2Jzc0N2VFI1dzMxLzhvUnZ3cEZvYWN1ZWNZaUFFL3FpVzJDdHhKbG41?=
 =?utf-8?B?d056K1pyUDVlRjdZeUw3MlgxVm9IUW0xTmNZWHUxQkNVQWJGeXRld1JRTXBz?=
 =?utf-8?B?QzU3UVB3dllLYzNGbUlVYmUwczBjODdOUkNrTTNzdTN1TlE1dmRVQ2JRK1pi?=
 =?utf-8?B?VkdocVJlMzdTdU9XMUZaNkFhOFdCaTd3U3NTVXh4VDJ3UkZROWN5ZWgwVy9z?=
 =?utf-8?B?WTREUkRobVE1TjU1UUM2bUlneW1jRGR2a1JpMStFM2wwU1dONEJrcHlzKzho?=
 =?utf-8?B?MUpzR2ZtSXd4L1piYkpBODVwZzVyeWZDVzRYN1hVNFNMdk9DUTEzTll4ZVd5?=
 =?utf-8?B?d21YTWI1NzhSSEd4dC9wcThneFJQK3BxM0pYazRiQmxqNE9SYWxwcXk4VzVN?=
 =?utf-8?B?M1NnTGZlVmdkV2xGLzJUMUpFWlNUOVc0RGZvQnZSVFR2djFocEpuUFJGMndP?=
 =?utf-8?B?eGtKcU9vTEs3MVBibUZlSWk4NFkydFBwbjNhQklvSlJFOWYyZHFtWjFoUFRI?=
 =?utf-8?B?Sm1qRDRtRHMzUFRMQWl5VTNQNnk1SUlpSzFKcTdaSklJUnZDMDhxM2wzK3Fj?=
 =?utf-8?B?a1dZSStLUDk4TXpLYW1PWnlTTzZwSHNXYW9UOEhLeFVvZHgvM1BOd25rV3la?=
 =?utf-8?B?b25OcjdUOFYwL2hWQnJDS2dlWTRuTEc0UitKVmNnbVdvZVBXN0RoWitCMkQz?=
 =?utf-8?B?V0ZFVjNHTHV2MmtBdWV1VnEvdzlJS1ZMbVorR2l6VTQwelhJSThhR281WDFz?=
 =?utf-8?B?RlRCanQwNlJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y1VBY0w2aUl1RFlOU0NxY29MNXFGRzh1OGVtZ1pmeGtwdU5jakpOclhUQ1py?=
 =?utf-8?B?RlVETlo1RVJ5NWUzT3dkWHV0VmZialppZEJuLzlvVC9GMTBLQjZDVjdKdmFF?=
 =?utf-8?B?NWNCRTI0cE1xZERlWHZJem9rUFh3MTNNbXhlWWl0VDA3cGZTa2Q3MEpIcDRM?=
 =?utf-8?B?MU9rZGppclJzcG1LYk9CV3Yxek53enowQlJNZU1hMG83RHBIOUc1TzdDN1RQ?=
 =?utf-8?B?Wm13OUpkMm52L1BVTWZ6SytSSVZMVTl2Z0RJSVBqUDBoU1MxcXZQV2JmeWZZ?=
 =?utf-8?B?b0pYR1RFRU5teURsZFlyZ01vR0w5a3JoL0YyR1Y0b215dHc4RkZHMGZxQVhy?=
 =?utf-8?B?RmFDaFl3SWwvSkJ1cHV1bTAvL2V2MHZNbTA2bG9IdFdQaXhwTWp2eUd1QXJY?=
 =?utf-8?B?QVh3bVMxQXJ0TkkvR2puN0lqdnE1T1JVN0tGQkNaM0Q5TktQdVFKTy80N0RF?=
 =?utf-8?B?K0NSUDI0SHJCd1pEeHR4Q0dxdFFEQW1sWFlub09hMHorTmx1T0lOclJ5ZHI1?=
 =?utf-8?B?dFE0dXJ4OTN0REtJSmlsU1JPOGt5SmdmdnUwdURUL2Y2QVl1bkpjVGxxdWk1?=
 =?utf-8?B?NFV4dWQrUEVHdDkwM0VSazlZdEpWc3pmUDVyMDJHR2k0cExaQ08yeVQ0V29R?=
 =?utf-8?B?YjdYTWYza2hzenRNR01SL2MrTkZ3NHdrSHp5Zjd3M2pKNHhYQU01ZjJ3U1BS?=
 =?utf-8?B?T2tOTmhycEhrRnhaMjZTQVQ1dGx0ZDFKTjZoVytzYTBPT3VSTmFRUm5KeTQ3?=
 =?utf-8?B?UitPdUZ5VlBQd2NnaW00S3RCNXRNQk52OWtsQ3lsMUhWWkdtQ20zb09PQ3Ny?=
 =?utf-8?B?MDMwSUk4cFNuZDdhZXhJZ1FhTWFFbzNRRXE1TDhuOEtIekYvdHZJN1c4dENR?=
 =?utf-8?B?NktVenhUUDRReXFWZ3NPbEgwOGY3MS9FZWdkV0tVZ0tHK2hlUTg3V2wrS3FQ?=
 =?utf-8?B?cytYTC9TMFB4eHp5NkhiWi9uRWUzbmV3N2Vmdk12YlVReHA2QUJ5dUcrbHl5?=
 =?utf-8?B?bkVyR1pYMmhBanFPREJlM0M1Y0FlOTloUWExVXk4OXR3OTRRWjFBelh6Yzkv?=
 =?utf-8?B?RVdZMUE1bVEyckZlVDZEVEJHUFk4bVpGcnhqSThwWG1Md245K2lpMlJZSndZ?=
 =?utf-8?B?azJOREV3b1FDbkFRNGZxVnBManhYRmVWaXYyZVcxVWhuUE5yZWlXTEtMbk44?=
 =?utf-8?B?bXByZG5paGFDWTZ6ai9pMXpoc1l5QkFOZHgwNWNERTV1aVJObElObUM5N3ZQ?=
 =?utf-8?B?ZkJSVDl5dU5JbTl4RjI2Ynd0Z0VsbnVKZnpHUlBoU3BSdnVPNWZsaUV4dVpp?=
 =?utf-8?B?cFJQN1RUVU8zTUVPa3VrSkYzT3RjM1NpQVVYWmIzSmVud1NEMXBuUnh5VHdX?=
 =?utf-8?B?UWZibFhTVW5vR2VjbDl2Q2NMUW1LWUlNbjdjci8vTWJYYVRsMlBoZVBHVWV5?=
 =?utf-8?B?UW9SQ09jZlpUU1g2aWtwNnk3dkxWUVF0RHd6K0o3elMwTGQzM3BLZTA2OHo1?=
 =?utf-8?B?VWt5TUNWdndDb1JyVWROTk5UWWszSld6UDUxY2lGS08xaXcvSmRoNk1DRTdi?=
 =?utf-8?B?M1p4cHpHUHJka2ZESkFzRE5VamQwdUNEK2htNnBnejNQMTJNdUUrWXFkTmZu?=
 =?utf-8?B?WDhvYVBVdTgvampjM3lZTXloUzFjMVl0MDFxU0ZzK0hCZkkxbTBab0pJb3JE?=
 =?utf-8?B?cnR6MlJpWTNyd0w4NjAxRCtOVTM2U0dIZXRNYUZXd1A2L1NKVXMvMDVsaCtO?=
 =?utf-8?B?UitTejdIZUhCTmFUYmVWSFZrWGJKcm1zWVZJUXV5TUMySG9RcDF3YmRLWEtP?=
 =?utf-8?B?TmxhakRoSGYyYzRTcEJ4SjM5VnN5YXFPWmQ2eHV0NmU3azhqUWE4SWdibEpF?=
 =?utf-8?B?dlBFc0tCK2w3ai9hMEhqaHF3bEFjdmkzdkpiMDdiaStyemFhRUF0Q293a2pz?=
 =?utf-8?B?c3BYWlB3K0gzcWJuUE5Ka1FGY2ZSWW82dGw0TDRUaHV1UEZaUDlZRTZQMmRv?=
 =?utf-8?B?c1dDSmRhMG0vT2paelI3Kys4N3Z3MHFwMEpFZmRVMkVXSGZCYmxjV2lNQ3RP?=
 =?utf-8?B?QTlQdkhZZXI3U2JJOVVuODd5bDN4aFlxUS9hNDBYQmFYWDNyTFljRmp0NWlY?=
 =?utf-8?B?ell6NERGNWowMUxoS1JSS28ybkk2bFNlRm9YdFJjMlJwZDdMVEJtQTlGY0tF?=
 =?utf-8?B?b3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EFF1F663032394EBCB2C135E6F9D547@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e3c73b-9b8d-4053-fce6-08dd8220a8e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 04:38:13.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvKt2wSClKFSfNz5zOXVgbsTK+vISjQV2UQ0M5zAlHwwndmjsWAoNEnVPPMG6/3uPntLkaZ0JnZTi+Lg73zMVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB6239
X-Proofpoint-ORIG-GUID: coqRKrvrvaK8m4GoKIzENHqbiIhsZIr0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAyOCBTYWx0ZWRfX8qrGzA8bMQpw qsVdnk/TJUrD3q6ufmkFcGij/MeZ8gCc2wQZUKynpBNIoVbOWzkW4cBq2ZCQVgmQnTlUgEI5rzs Vnh2p/olAvN4TLWS9aME3vnT8nIC2ncxMo6Mb6yr2JS4/oJ/mrhgoNB/QrMRbyJ2tUazjYrosiP
 FTasJ/xbBnWya2w8QZHjUDU7C9Y1i1Op3vKmzamf1ZdlYF7XbZc3ki8IeDM0NmRIwrrhuDJWxqk Ndyil2m/QwHfq2SMuyEG0e16kAyIBRtnRttq3lXvSL6zX2kZE5sWy4eGuVkXf3yoAKTuI4IKgCi 7wpc+bCXWoEYa6JIl/RewN/g85MC1rUVar04msaDyYNt+Gjmi1SMOGNo4krFLcjjr50kgDnzj2g
 9uYyuOl8xLppqutpqV1nnfVaMCJ1AKiuJjsSuUV+PHPn5CGsZLOlgHXtInNoU5UnwaX05p/m
X-Proofpoint-GUID: coqRKrvrvaK8m4GoKIzENHqbiIhsZIr0
X-Authority-Analysis: v=2.4 cv=IdWHWXqa c=1 sm=1 tr=0 ts=68086eb9 cx=c_pps a=1OKfMEbEQU8cdntNuaz5dg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=hWbqlqnSQaAxWDo7buIA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
Subject: RE: [PATCH] hfs{plus}: add deprecation warning
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_02,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=807
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230028

SGkgWWFuZ3RhbywNCg0KT24gVHVlLCAyMDI1LTA0LTIyIGF0IDIyOjI0IC0wNjAwLCBZYW5ndGFv
IExpIHdyb3RlOg0KPiBIaSBTbGF2YSBhbmQgQWRyaWFuLA0KPiANCj4gPiA+IFBsZWFzZSBsZXQg
bWUga25vdyBpZiB5b3UncmUgaW50ZXJlc3RlZCBpbiB3b3JraW5nIHRvZ2V0aGVyIG9uIHRoZSBI
RlMvSEZTKyBkcml2ZXIuDQo+ID4gPiANCj4gPiANCj4gPiBTb3VuZHMgZ29vZCEgWWVzLCBJIGFt
IGludGVyZXN0ZWQgaW4gd29ya2luZyB0b2dldGhlciBvbiB0aGUgSEZTL0hGUysgZHJpdmVyLiA6
KQ0KPiA+IEFuZCwgeWVzLCBJIGNhbiBjb25zaWRlciB0byBiZSB0aGUgbWFpbnRhaW5lciBvZiBI
RlMvSEZTKyBkcml2ZXIuIFdlIGNhbg0KPiA+IG1haW50YWluIHRoZSBIRlMvSEZTKyBkcml2ZXIg
dG9nZXRoZXIgYmVjYXVzZSB0d28gbWFpbnRhaW5lcnMgYXJlIGJldHRlciB0aGFuDQo+ID4gb25l
LiBFc3BlY2lhbGx5LCBpZiB0aGVyZSBpcyB0aGUgcHJhY3RpY2FsIG5lZWQgb2YgaGF2aW5nIEhG
Uy9IRlMrIGRyaXZlciBpbg0KPiA+IExpbnV4IGtlcm5lbC4NCj4gDQo+IERvIHlvdSBtaW5kIGlm
IHRoZXJlIGlzIG9uZSBtb3JlIHBlcnNvbj8NCj4gDQo+IEkgdXNlZCB0byBtYWludGFpbiBBbGx3
aW5uZXIgU29DIGNwdWZyZXEgYW5kIHRoZXJtYWwgZHJpdmVycyBhbmQgaGF2ZSBzb21lIHdvcmsg
ZXhwZXJpZW5jZQ0KPiBpbiB0aGUgRjJGUyBmaWxlIHN5c3RlbS4NCj4gDQo+IEkgaGF2ZSBhIE1h
Y0Jvb2sgbGFwdG9wIGFuZCBjYW4gaGVscCB2ZXJpZnkgYW5kIG1haW50YWluIHBhdGNoZXMgaWYg
bmVlZGVkLg0KPiANCg0KU291bmRzIGdvb2QhIEkgYmVsaWV2ZSB0aGF0IHRocmVlIHBlcnNvbnMg
Y291bGQgYmUgYmV0dGVyIGZvciBwYXRjaGVzDQp2ZXJpZmljYXRpb24gYW5kIGRpc2N1c3Npb25z
LiBJIGhhdmUgbm8gb2JqZWN0aW9ucy4gOikNCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

