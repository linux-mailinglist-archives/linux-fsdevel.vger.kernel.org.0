Return-Path: <linux-fsdevel+bounces-54670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B8CB0219E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C3C3B5C49
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE632EF2B9;
	Fri, 11 Jul 2025 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="aLC3jUKz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0292D17A2EB;
	Fri, 11 Jul 2025 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752250980; cv=fail; b=iTXlmGxBUCe4ASmKikcVzwzLv6Tg+DA7yTPKvmKOa3UMR04uG4sHUjSaB2fURQpF38bZ02neBJOJyxvp9nX+Jas0E1z5sdqk+b2X/CSQjzVpy5Nl6hF4O+GQE4o9DsP+THsZz3dRo+3mWGJ7NL3s+t0UKw+F8b9TdSxtNaB18fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752250980; c=relaxed/simple;
	bh=7ySVcH3Ok8JjqSfymB7Drb96vQ33KvoIkEBfnLoGtpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dsOiJhDHOR8a86X/QpV+TuGlUIzhA0uPdCPwu/8BlgU6YVZvAR8ZNOOBJfuMgZ27KNplZFEtulGkN+xUV+so5cgQf4F/x2cW5QZ3MVTHwhkGOd78NMY9t/gNPX/rbylI9BRccPEPTF78T1jM5AimpbwV1nbs9QNUjeftnNz88ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=aLC3jUKz; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BG9gDl028323;
	Fri, 11 Jul 2025 09:22:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2025-q2; bh=7ySVcH3Ok8JjqSfymB7Drb96vQ33KvoIkEBfnLoGtpw=; b=
	aLC3jUKzv1VjZm091UxawidqUzHtvXunJIsvfrFV7mmL0hvYFr2KT2R/XHXql4zZ
	jeDinAmrcaR2JIwHPeZWOSSJjZHwLgJRcDzZhlK0eMeVyz0NSI+x6kpDD/eEHI3f
	PIJ6pRG5tIFjw93128gkvJO1kTN25WQZGxCsQxyDx5KVvCsXz5ktdApfOzki0lDY
	CpGPv41nWyqpNjGAzPCXVyFWgsuYSiwTG97kLRnuNKDLMSxdCk4CdezB0xx1pnPz
	S0tVrbn2aDbW2gKUpuqAUXtx3eIF9+q4I51xZ18U1XdlwguxANWhD6WNtGWLugD2
	C2u+2SKci1G+i6lYxVD/oQ==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47tx54349b-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 09:22:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKLtnqxByWynnPb2OeC5yBCIJZ8jRW48bGzE/Py12XQP3a+qNgUIFJgjkbI0BY0dKh0j0jzbz5SugwZuC6Hbb8/HG3G4gi7Wo130mRJmbzB+8tLXOAvbmHiu1eQYPft+zj5EEpg71MR/BkXL2rb8VzjRqUUJD07+G3jE9ViWVj2wvT1U+mxgoqaCBHxv2L9OynxhgzIG5aL18hUbmfyQxI4iepsyqoRsWW6ANzZ1VN8B5lSKCTB7jCEfItuBu57XCJIneCgGouV94+UhGH0HR6bPf8HmZd66mZBPXyP5wdfXW9ZvbEyLcdgo/SHL9VQK4011uT5+Kgmlmpq6vcdKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ySVcH3Ok8JjqSfymB7Drb96vQ33KvoIkEBfnLoGtpw=;
 b=JGH4DmWe4r0mrFhZSMyx4gsWIIGhf1CCSqzWMcpqzVayevi9piTpXIyfvm75EuDriqh+cHjOYbbQZNgH9+8oA+60xnQy1mMx0q+96kseYKTwluOb9O+j3TYdOGZjGYYdlxLZMUO/QPzLH1crxundyqYq/JFJY9XRvfkWNw/DZ2C4/hgBPaEvjkRPiKfOCEQFsM2EMVzf/M6Ekyt9YVxxUkFL54Tvd2JRBrS3f5JslKUTYAWoq4lDLPLxmHxMProJufpKQdvU0cu4/dDYBrOhgk+Ps3tRlq17IC2xPcaRGsncqTEe6OpsUT4BxurOWH22wG4+21XC96xzV3xJ86D4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4597.namprd15.prod.outlook.com (2603:10b6:a03:37a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Fri, 11 Jul
 2025 16:22:52 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 16:22:52 +0000
From: Song Liu <songliubraving@meta.com>
To: Christian Brauner <brauner@kernel.org>
CC: Paul Moore <paul@paul-moore.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Song
 Liu <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "apparmor@lists.ubuntu.com"
	<apparmor@lists.ubuntu.com>,
        "selinux@vger.kernel.org"
	<selinux@vger.kernel.org>,
        "tomoyo-users_en@lists.sourceforge.net"
	<tomoyo-users_en@lists.sourceforge.net>,
        "tomoyo-users_ja@lists.sourceforge.net"
	<tomoyo-users_ja@lists.sourceforge.net>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org"
	<kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>,
        "repnop@google.com"
	<repnop@google.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "mic@digikod.net"
	<mic@digikod.net>,
        "gnoack@google.com" <gnoack@google.com>,
        "m@maowtm.org"
	<m@maowtm.org>,
        "john.johansen@canonical.com" <john.johansen@canonical.com>,
        "john@apparmor.net" <john@apparmor.net>,
        "stephen.smalley.work@gmail.com"
	<stephen.smalley.work@gmail.com>,
        "omosnace@redhat.com"
	<omosnace@redhat.com>,
        "takedakn@nttdata.co.jp" <takedakn@nttdata.co.jp>,
        "penguin-kernel@i-love.sakura.ne.jp" <penguin-kernel@i-love.sakura.ne.jp>,
        "enlightened@chromium.org" <enlightened@chromium.org>
Subject: Re: [RFC] vfs: security: Parse dev_name before calling
 security_sb_mount
Thread-Topic: [RFC] vfs: security: Parse dev_name before calling
 security_sb_mount
Thread-Index:
 AQHb8FzEhXwik4wHVUiG4oVmXX3W0LQpln0AgABShACAAB3hAIABOQAAgABXkYCAARZZAIAAcYcA
Date: Fri, 11 Jul 2025 16:22:52 +0000
Message-ID: <4EE690E2-4276-41E6-9D8C-FBF7E90B9EB3@meta.com>
References: <20250708230504.3994335-1-song@kernel.org>
 <20250709102410.GU1880847@ZenIV>
 <CAHC9VhSS1O+Cp7UJoJnWNbv-Towia72DitOPH0zmKCa4PBttkw@mail.gmail.com>
 <1959367A-15AB-4332-B1BC-7BBCCA646636@meta.com>
 <20250710-roden-hosen-ba7f215706bb@brauner>
 <5EB3EFBC-69BA-49CC-B416-D4A7398A2B47@meta.com>
 <20250711-pfirsich-worum-c408f9a14b13@brauner>
In-Reply-To: <20250711-pfirsich-worum-c408f9a14b13@brauner>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ0PR15MB4597:EE_
x-ms-office365-filtering-correlation-id: 0ce0fdee-63ad-446f-7769-08ddc0972f9f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWxtY0EwOVNLQ0duYS9GbGZLclBXQTA1QUdUQlRTUTFlSlhGVVhaeVZlK1pl?=
 =?utf-8?B?N1gxWkpiQkhzVlkrdHlsMUtVUjRCNU5BRXFJNlhVcEFiS0tQbHJzTVkyTDlT?=
 =?utf-8?B?QXBYSmxPYTVBbk9Ua1ArMVI4NGRaSzNTMmMrOXNrQWt0YmFVQTI3SlIwaWto?=
 =?utf-8?B?UHZlQzNmVGVuSHNtN1Z5cUsyMjJqNXhFU05nRlFxalpZNHNobkEzNkZSYXZ0?=
 =?utf-8?B?aVZSOXpRM2hFb2hiUHNiZTNXejNVNFc5RlJLRDlFcnROejNTWmZKeks3ZUZn?=
 =?utf-8?B?SlVKTThCSDRxdjRhbG5lRlFSNHlYR2FoakVlcTkzcmRlWW9JaWt4aUtPbGRV?=
 =?utf-8?B?d1RYeTZ2ZXUrRTJYc2paSGh0N09ndzVKcVk1cWcvc1ByTitxNlJLalVQYzNC?=
 =?utf-8?B?OTI3MkhncDlFeTVlT01pYllHQStiUzdiajRtRWFVb2JnMWpoclo2UVVYKzZI?=
 =?utf-8?B?MmRMTEMwVyswOUNvbmJYL05waWhiMFE3eXdwT2hRNlZRTnFIdGtsbjFONjda?=
 =?utf-8?B?QWtub050WklLbFE0MXZBK1NxTlBmbDRobG5pMHBiOENqNXpNWFRubUsxclg4?=
 =?utf-8?B?MTlaeVVSR2FvY3FRZTBrN3Mxc3pESkFCeEd3MHFycmRXWW1pVUxKWVFhcGlz?=
 =?utf-8?B?T1RpajlyMmNnV0ptMlFYdjhMU2ltQW4ybjNhZExaRDZoVzJZM1dLRHZoRWho?=
 =?utf-8?B?d1REdjRKSUdrNGhZU3pDQmpSS1F3NW1JZkZ5TG00NkwxREFxcUlWcDVna3dN?=
 =?utf-8?B?dlhyU1dJK1YvZkNJa1dnQlBvSHZHYkNVcmRncVBpYkNpU0Z2eVNsQ0VTUXli?=
 =?utf-8?B?UmxkbEdFNFJwQk5YazNRN1Z2T3ZpclJIOENSeUJCMHI1eDVnRDhwZjh3K0Rq?=
 =?utf-8?B?Y3JsTXZXTmV5eERSZEEzb3dIVmYxL2pZRXFwalBZaXpUM2U4Vkpxa0tFZUpR?=
 =?utf-8?B?ZUJqZzFRRU5VTjQ0dWM3MDFNTk04YTcvSGdPNEV6S2lhSmpBMDBSYXBWMXU3?=
 =?utf-8?B?Njhka1k3ZWpRMit4TDg0SE9TQksvbnVJdmRkV0MxOW9SRnBPa2toVlZQL0RN?=
 =?utf-8?B?a04rSHFwN1BWcldkM1BvN3U4SStJcmFWUjVONTJtaFdZRWFhRG9Wck43bnVw?=
 =?utf-8?B?amRGZ3MxL3NRQ2tKWE5OQzBHMmJBckw0NE1sbjk5NkRaWjZ6MEJaclBQUWM4?=
 =?utf-8?B?UHpQalNreHZvM1FzeTZYSzc1OFhQN2NhWFliYlowdGFBWWxRVnlXeEh0SFpa?=
 =?utf-8?B?dkE1YXUvS3lMbmZTaHVpT256VlhXMExXeGdmdWd1VTZObFJjQ2pVL2VRUXh0?=
 =?utf-8?B?dHUzZ3NxbVRnWE9NeWtxRmFWUWJRZUFLejlZdG9LRXd4ZHRMaEJ4STl6T3NL?=
 =?utf-8?B?SzQvemlQU2M0ZGMxTlNuQjR6cW1mMFprcUFQN3Z1OU1PcmZhdUtUSTU1dHF0?=
 =?utf-8?B?S1I2eXdWa2VoeE92bExrdXViZ3dNN1I2ZEI0dEFOOGpSTzF0aDhkTlVDd1Ni?=
 =?utf-8?B?TURpWDRma0ZBa1Vwa21YZGtZZVVNNU1PSExLNmpjQVI4OUJwR1pTS25vN2hG?=
 =?utf-8?B?Mk82eVlmQzVHbk1Ld0Zhd3NXZEZLeFJPNHRLRnU1Q1h4RUUzV0N1Um01OWU0?=
 =?utf-8?B?bEViWlIzeDBlU1JPNDMxU25iV3lnZU1SS3hvNTR1OXd3Z29LaUtyTjM3TWQv?=
 =?utf-8?B?bDh6RCtCbytvc0xiZEFxT3E2c1lWOTBKam1PTEFQN3JCVEFOS0M4d3M1ZTh5?=
 =?utf-8?B?d3VmZEUzU3ZjZHhvV3dOSEVyOFVCNFl6RE1lWWJuY2xRZktJeGJ6d056QlF4?=
 =?utf-8?B?aFV6Zy9XL3c4T2w2RldWNForVU9lNWpYMnlhaFRPNG82Uld0MFRSdU5lWnJP?=
 =?utf-8?B?UXFjTnZHR0tHUm9TVjJ0eWhBNkJqTWZqS1A3OVJvLzVxa09oVVlkd2lSQVdI?=
 =?utf-8?B?QlR5QU16Vm0zUU85KzlhQmE5YlBCOFJOQlFIeENweEV6UjUyQ1l3S0taMFJB?=
 =?utf-8?Q?0a+q/NRSEc2MRML16vjcOoFz/4e9XQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mm1hdGlvZjcvQU1BNWYrVzljK3hYMnRiWHc0SFhkelFNTEdwMlBadkJ2T3I3?=
 =?utf-8?B?d3N0bThxTFJrNlR4anBpM0F0Y2tLbnp3MzgvQXZaTXoxMFc5OGZUYWk0NTFh?=
 =?utf-8?B?aHJqaG1hcEhHQjFCS3RET0JYNkZPd1I2MHpjbkZEMkRSbXp2cldUS2FGL0F2?=
 =?utf-8?B?b3hBbmFpekFRajhnMGFBbVBheDZuM0YxWkpXYWR0T3UyVzFzVUcxREtyWk9m?=
 =?utf-8?B?TlRHU2JUcVp2ZjRkV051MmVVbEJ6QXFlbW1JNXJvbkQ4RzJPOFYrOVVUNU13?=
 =?utf-8?B?QkNrSnlxVzlrNmlXQkJYQm5uU0hocTh2SDlWMVJYK3RFU1dJQWJ0T2g3dDVP?=
 =?utf-8?B?Z1dGS1NyaFBSSlFmMDl5T1ZwWFVGS0lZSzlLd0dPakh5WUllT2lGR1hrS3cv?=
 =?utf-8?B?eVBEVmprZXh4eGNUMkJzeUo4WFdmYUJOVFpXTzZvN1RqcFZBVTNnMlNOVFVu?=
 =?utf-8?B?a1ViUkkzcDI4TDhGenlNS3BIcHZobXNucTJJQjlPYWhSelcrT0JlbVZEdTVi?=
 =?utf-8?B?RU0vaWtLdjVKUW45dUhoY3F2RGhKSU5PNTlzRThkQ3JKZ0gwYzUyU25DZXVr?=
 =?utf-8?B?bjVZMURCMGhjUTlVUEhoM3FjWnp3b09wNGRRR1V5VmJ0cUFlMkZxUlUwakV1?=
 =?utf-8?B?VHM0REwzVmZvYlpIMkVic1huMU9rRHUvQnVvUTBYWHgyNXZKbTNHOCtEcGxK?=
 =?utf-8?B?SFlVYTVUU01TbWhYNjJzeXVtaXhXWlFkeldHeXcxOE01OFJlVEpZa3R5Rmtk?=
 =?utf-8?B?c25ncUZtZmFPdlpwUE1tRmlWTjhlNmdVcnJGOC84NWVEd3BObVlVWU1iS0J0?=
 =?utf-8?B?MHFGWmxKQ05PaHAwQzZnVnBLMXdJdDhzeU4zQ0tUcjlrT2tsc0U0L3dwZDJB?=
 =?utf-8?B?Y01KRHhtQjRWWFNBMHJlMGczS29YU3FSU1FqMnJXU3ZPWGFMWXIvYk9pUHJh?=
 =?utf-8?B?eUR3ZWxXRDQ0bEpDZ1dVamZ4SENPN1FVbjlQbk9JR0FvOERQUE1uWjRXYm1u?=
 =?utf-8?B?RURUUEY1cGJzZmgxZDdsak12UTVJMXVJVkd5Z1dxZlpEeTVOdjZPelVqQWYv?=
 =?utf-8?B?VUdwUDFWY3lKVlNjNk1SWDc5d1BPV2R1K3E5MlNYaDZPRmhwQkNwZTVQRC80?=
 =?utf-8?B?YkpCNkNONEh3RENSa2UwRkV6czBPVlBQQ1Z5ZloxSm1HSkh2NllIczJRTStk?=
 =?utf-8?B?Q0l4WkhuU2l4UmF2Rjg2RmtPYllMemJlY05DOUdTb1hTaDFrSkVhQ3hDQWVa?=
 =?utf-8?B?ckdMUWNvdzNpVThaVm5Jd1FsanNsVU1xWXBrTkk5blIvWmJpT1FtWEp5K3ZI?=
 =?utf-8?B?UjhYbmFDTjdhTklCR3dnQTJrRU52WHU1U0J5V3VXUkI0b1lXWXlaNFJFMG0x?=
 =?utf-8?B?c2RCakhOSTE0SndXaU1QWUEyTVBTMmozSS9JM1pncXBsb0RUQnB3cHlHMWtl?=
 =?utf-8?B?ZFpNODJ2VDhyMXJGTFc2ckM0eU9EeXRSU3FzdnRiQUpUTzdPZ0h0OEt2MVZh?=
 =?utf-8?B?TFBHd3NzMjA5SDc5MGIwcHJ2Z0hNNXg3NjYrSHVpK0JWclJrYnplc1FBYlBW?=
 =?utf-8?B?UFp2RDd1bGJQRVQvL3kzTDFBL1p1VVZVZFhGdWVsWXBGSnJ1WnhaeGcxSzNn?=
 =?utf-8?B?MHNWcDJRN05TUkhRL3Z1SVh6ZStMZTJnODFYK0FoTCtlRGFTUnZOZUJydlV2?=
 =?utf-8?B?VnpqS0JQOEx0bnlxRmZwVVRWa3JHMlc1NHpnU0lZQmNQaGFWdU5vVVBWZ1pp?=
 =?utf-8?B?M2pScjJIVkwyL1c1ZGpnNXZRSmhwb2JZcGlwenNVNEFVNk1Oek1ZaGNLV0Vk?=
 =?utf-8?B?V08rbFJ6K2l6ekUxV2FuVUdrS053R3pGcDNqRWNFQkQwWWRERWhXWjF1N2tu?=
 =?utf-8?B?R0UydUNnTWFROUwwV0dkcEh3SS9hTndwNDZ4RS9vcVI2RHpSa2hCd2daUWRt?=
 =?utf-8?B?dHZNY0o2U3c2M3N2Y1R2SWoxRUxNai9XUHVVcWFkRnd1V042VlpQMkVsWFI3?=
 =?utf-8?B?R2ROa1c1aHJZc2l2bVM0dGVoWFVRUTRWVTBBSDhBcEVicXkybk43Rk5YMTVM?=
 =?utf-8?B?bXlISDNqa0JBc0ptbUxUNmkycFRQTHdlOFI5RmNieDZyaXJZTUhhK3VZc2lS?=
 =?utf-8?B?OTNTZ1RYWDc3c1lyZEpLK1dXZEVjOEZkaW50R2tDQUZIOUZHeFgxamJZUnBC?=
 =?utf-8?B?V2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1540123BE4F2F47BE7C3997F6310597@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce0fdee-63ad-446f-7769-08ddc0972f9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 16:22:52.7702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WM4JyHuLSR38rWpCDfb5hCjgVI2RTmZoja5ThfDg2xozf5aZj26JGK/0Z/+kbXtlp9sqV/qVgIVt3FajDRfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4597
X-Proofpoint-GUID: lN7dDhWeQN9Kg2Kl7YEU6fMH5Rx6ojLV
X-Authority-Analysis: v=2.4 cv=dtjbC0g4 c=1 sm=1 tr=0 ts=68713a61 cx=c_pps a=kF3hYY070rs11f8A5riTzg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=TFEyOsj_hRZhdM4k0ToA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lN7dDhWeQN9Kg2Kl7YEU6fMH5Rx6ojLV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExOSBTYWx0ZWRfX2e3o0yF6o5BN n7XWq6FFRQjV77OED6b7V6rVJbYLFRImkqz4XmqhuA7oPeBlF5oCZ502BPraG2gdxpe7c2b34AU wNJ0n/rkhvVcIKyNTN99xcpjqCueyGdCq/UqznIWfr8hYfBG+Fvthqfi/RRXaZe62wCzumZcVKG
 h0vEOdP433FVDHcmvvvTkR8qskIKq0nydUiAD96DrEzQKPBDiLnBGpA6g1TC4OJp/FDKKi8VSlG 9Dv6WfqiJSIneS8/79HdeYYuhW8F3KKDk3kfai9TXV48+4XWlTJUgcmsvumeRESbAN9yTKFdoRW djElBWYfkIoQX9HbwLVpcs3IuqeQ63CEl30cRRTrIgzNEmFS+lL8oJ0lpOTBXTCTfi+C/z5V/i+
 Vr9lQP+8a/NVBrMTPfIMtnkwFqywddiQPfqqNAQJgL+NRsVxg0slpCGGtZ/hK6K0Gpd6a1KZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01

DQoNCj4gT24gSnVsIDExLCAyMDI1LCBhdCAyOjM24oCvQU0sIENocmlzdGlhbiBCcmF1bmVyIDxi
cmF1bmVyQGtlcm5lbC5vcmc+IHdyb3RlOg0KDQpbLi4uXQ0KDQo+Pj4gDQo+PiBUbyBtYWtlIHN1
cmUgSSB1bmRlcnN0YW5kIHRoZSBjb21tZW50LiBCeSDigJxuZXcgbW91bnQgYXBp4oCdLCBkbyB5
b3UgbWVhbiANCj4+IHRoZSBjb2RlIHBhdGggdW5kZXIgZG9fbmV3X21vdW50KCk/DQo+IA0KPiBm
c29wZW4oKQ0KPiBmc2NvbmZpZygpDQo+IGZzbW91bnQoKQ0KPiBvcGVuX3RyZWUoKQ0KPiBvcGVu
X3RyZWVfYXR0cigpDQo+IG1vdmVfbW91bnQoKQ0KPiBzdGF0bW91bnQoKQ0KPiBsaXN0bW91bnQo
KQ0KPiANCj4gSSB0aGluayB0aGF0J3MgYWxsLg0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0
aW9uIGFuZCBwb2ludGVyIQ0KDQo+IA0KPj4gDQo+Pj4gTXkgcmVjb21tZW5kYXRpb24gaXMgbWFr
ZSBhIGxpc3Qgb2YgYWxsIHRoZSBjdXJyZW50bHkgc3VwcG9ydGVkDQo+Pj4gc2VjdXJpdHlfKigp
IGhvb2tzIGluIHRoZSBtb3VudCBjb2RlIChJIGNlcnRhaW5seSBkb24ndCBoYXZlIHRoZW0gaW4g
bXkNCj4+PiBoZWFkKS4gRmlndXJlIG91dCB3aGF0IGVhY2ggb2YgdGhlbSBhbGxvdyB0byBtZWRp
YXRlIGVmZmVjdGl2ZWx5IGFuZCBob3cNCj4+PiB0aGUgY2FsbGNoYWlucyBhcmUgcmVsYXRlZC4N
Cj4+PiANCj4+PiBUaGVuIG1ha2UgYSBwcm9wb3NhbCBob3cgdG8gcmVwbGFjZSB0aGVtIHdpdGgg
c29tZXRoaW5nIHRoYXQgYSkgZG9lc24ndA0KPj4+IGNhdXNlIHJlZ3Jlc3Npb25zIHdoaWNoIGlz
IHByb2JhYmx5IHNvbWV0aGluZyB0aGF0IHRoZSBMU01zIGNhcmUgYWJvdXQNCj4+PiBhbmQgYikg
dGhhdCBjb3ZlcnMgdGhlIG5ldyBtb3VudCBBUEkgc3VmZmljaWVudGx5IHRvIGJlIHByb3Blcmx5
DQo+Pj4gbWVkaWF0ZWQuDQo+Pj4gDQo+Pj4gSSdsbCBoYXBwaWx5IHJldmlldyBwcm9wb3NhbHMu
IEZ3aXcsIEknbSBwcmV0dHkgc3VyZSB0aGF0IHRoaXMgaXMNCj4+PiBzb21ldGhpbmcgdGhhdCBN
aWNrYWVsIGlzIGludGVyZXN0ZWQgaW4gYXMgd2VsbC4NCj4+IA0KPj4gU28gd2Ugd2lsbCBjb25z
aWRlciBhIHByb3BlciByZWRlc2lnbiBvZiBMU00gaG9va3MgZm9yIG1vdW50IHN5c2NhbGxzLCAN
Cj4+IGJ1dCB3ZSBkbyBub3Qgd2FudCBpbmNyZW1lbnRhbCBpbXByb3ZlbWVudHMgbGlrZSB0aGlz
IG9uZS4gRG8gSSBnZXQgDQo+PiB0aGUgZGlyZWN0aW9uIHJpZ2h0Pw0KPiANCj4gSWYgaW5jcmVt
ZW50YWwgaXMgd29ya2FibGUgdGhlbiBJIHRoaW5rIHNvIHllcy4gQnV0IGl0IHdvdWxkIGJlIGdy
ZWF0IHRvDQo+IGdldCBhIGNvbnNpc3RlbnQgcGljdHVyZSBvZiB3aGF0IHBlb3BsZSB3YW50L25l
ZWQuDQoNCkluIHNob3J0IHRlcm0sIHdlIHdvdWxkIGxpa2UgYSB3YXkgdG8gZ2V0IHN0cnVjdCBw
YXRoIG9mIGRldl9uYW1lIGZvciAgDQpiaW5kIG1vdW50LiBBRkFJQ1QsIHRoZXJlIGFyZSBhIGZl
dyBvcHRpb25zOg0KDQoxLiBJbnRyb2R1Y2UgYnBmX2tlcm5fcGF0aCBrZnVuYy4NCjIuIEFkZCBu
ZXcgaG9vayhzKSwgc3VjaCBhcyBbMV0uDQozLiBTb21ldGhpbmcgbGlrZSB0aGlzIHBhdGNoLg0K
DQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtc2VjdXJpdHktbW9kdWxlLzIwMjUw
MTEwMDIxMDA4LjI3MDQyNDYtMS1lbmxpZ2h0ZW5lZEBjaHJvbWl1bS5vcmcvDQoNCkRvIHlvdSB0
aGluayB3ZSBjYW4gc2hpcCBvbmUgb2YgdGhlbT8gDQoNClRoYW5rcywNClNvbmcNCg0K

