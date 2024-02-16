Return-Path: <linux-fsdevel+bounces-11898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B822A8588DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 23:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700C9282029
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 22:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7956148FF0;
	Fri, 16 Feb 2024 22:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TSERdHjp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AD9iKjE/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82918146904;
	Fri, 16 Feb 2024 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122958; cv=fail; b=LGtL8I8483EvqUVtIpfi/uhC5pq0xbj9bEq+FVmeQC3wKl1/7LgXAILhxf4kSZwTku6IglNaBKW/CXr1hJeMcGUdosL4sUxdAu9+Eji9V8yO+/qX9gECm9/HoaeargprQr+XGcjOSSy/zN5o4uC3egMoZUxvd0tJNUI5o3AO+NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122958; c=relaxed/simple;
	bh=cIJaD1+R9P0F5yXhNQaTbMgJV9BONgaOrTJLWGjKX2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eDCFYKHPja8b2VSoiT8D7zdGAEIT+fdjREbXoPYBmXOlXpKYzEsWfioreoDsyvVSRh9pEoOnLZP7TzIpFDi0hQdylTb+xa1D6y5soHpidx+x4e+9xJps907P6naSdVquT9sWNj+LH9mWcyrirAWF/gf66I0r1cRiAJGm8LZt3A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TSERdHjp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AD9iKjE/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKEUu7014707;
	Fri, 16 Feb 2024 22:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=cIJaD1+R9P0F5yXhNQaTbMgJV9BONgaOrTJLWGjKX2g=;
 b=TSERdHjpKK/KSnU+C8LV2jvqT06G/v30NUVeSroKMRWX6H2OL3uK4fSRL3X6cJnXgcQS
 pm2Bcirv3OHaUNAaCWda2I4dYgkdQTAHOxvxSAGa/2jbxbWvgRch9TqZH1SLjYS7jZIu
 G5z3/Z+elAFKUFrvMy1EkmtCyby47eKDFX3iC++TbIW4S1dl/euEj7yzVx2DgxQxliBu
 jdpUVjHwlUJnjLgxwG4QpUc+xeARUVnBvjbcSWCd9cTnuNHyKBl1ap2oKGchsfjZCJM3
 uv77+RJwpEuvpzlfuwiNnoxZ5SDbQzyGqCPdBNvc5HTt+eQzhdcJwegG9ljk7+eDf7C8 Rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92s7693r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 22:34:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41GKjWqY013876;
	Fri, 16 Feb 2024 22:34:59 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6apfs9sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 22:34:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YujU1n1ktxlSByBGtrJc8rDP5qfa0WwewbckLpB15bXqquBw+YAknnkN6nWPDJqGs1SHtHX9/gGX1nrmW0ua4+g/Gdi3a3xuC/lTQoi+JoUtW5hZY72h24dfgVcDlmxe05KgQqovUzsphxauswl56wdQ3wcTP48cFmobBynmmYbD99CK4m5nLOQI0Ce3o7PM/T2NF67B5KnYQS1PfZVx3A0OkY0amLYpjNkUimP99frryNzRjCMdFX3MpXi61eUBaTgbhH5d7dvnq2nbFLZGpfrjIjixFKPUu84ue0yEA/aTzGJ0O2sIdPerUmddYLhmcMR+JVfeowLUnHHEsMr8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIJaD1+R9P0F5yXhNQaTbMgJV9BONgaOrTJLWGjKX2g=;
 b=Pblh018GAGLhF0Iq8gjX/qwEogaSwVQ6zHXXddaPfloZgQZOHwal8M+ZaxRWLOKHv5k2lD3G2j6SalzACH93dL71hyP7d5XT4i6Ct794uFnc1gf6svnRuT3c/cxI85g4GUFQsXug+pMm64sYrt2BuVd8dvDVTzC2eJKbFt57FboIijZdDAqka88Qlc+WQKNARbbOHcpzu/C67OYgz9YoDqBErCmCsB8tkLSjHLkq75yMhOjTZv+608ExXNqHGIbz+u3ADMDgAr6uiHipIUAIoDcFlqUmRxUPma0QAUyWyxHcvagadHZMG1G0rhKowIHuGb949tL9rmIS00Hh32i8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIJaD1+R9P0F5yXhNQaTbMgJV9BONgaOrTJLWGjKX2g=;
 b=AD9iKjE/rJ79mlXKW96z/Rap4gSEpN08xrUuP8fWFUDdt9iaQCIYAFSFFx6411JGKVlUHfKKqDHJvunK2rS9fSVo2NQK7NIr294x8OD0HIfy+Gau+TN0st8ky+RJ0b+mfsB5d8cHFv/10/p08rigXjO3m9JJZq6nmA9KRjKfhq4=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by SJ2PR10MB7016.namprd10.prod.outlook.com (2603:10b6:a03:4cf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 16 Feb
 2024 22:34:55 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::9ade:bfad:c78e:e1f9%7]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 22:34:55 +0000
From: Eric Snowberg <eric.snowberg@oracle.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
        Chuck Lever III
	<chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, "neilb@suse.de"
	<neilb@suse.de>,
        "kolga@netapp.com" <kolga@netapp.com>, Dai Ngo
	<dai.ngo@oracle.com>,
        "tom@talpey.com" <tom@talpey.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org"
	<jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com"
	<dmitry.kasatkin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "stephen.smalley.work@gmail.com"
	<stephen.smalley.work@gmail.com>,
        "omosnace@redhat.com"
	<omosnace@redhat.com>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "mic@digikod.net" <mic@digikod.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "linux-integrity@vger.kernel.org"
	<linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "selinux@vger.kernel.org"
	<selinux@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v10 00/25] security: Move IMA and EVM to the LSM
 infrastructure
Thread-Topic: [PATCH v10 00/25] security: Move IMA and EVM to the LSM
 infrastructure
Thread-Index: AQHaX/o17zz0uZ0bUEuo4nwd69V4MLENkLgA
Date: Fri, 16 Feb 2024 22:34:55 +0000
Message-ID: <CF351A03-7B5C-4796-B597-535DF17CFD32@oracle.com>
References: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240215103113.2369171-1-roberto.sassu@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR10MB4150:EE_|SJ2PR10MB7016:EE_
x-ms-office365-filtering-correlation-id: a769e208-c31b-4b9c-d047-08dc2f3f800d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Y6BuVC2qS+jeWJ7omycQrzi1jh6bBj3Dd7KhxvuhBmb2NPL2gAe1GdvAr42qFuW/U0410XcoxObtyA1utn/IbFVjcUzXH4xTY+809fk2fsUYV+fs45GX6o9057NEaIOd4eiMXzR7Wiv8VgRS/6vNBT8CJln02yKOBiZ08WfkW9M4Y9l+1fBY3ER9+3WncjJapr5UniitGH836Jk1EMRwHfTMQNc+tygF3P+lkxaqlzLZOorI4vmbEYvmuRy9c3G8JHjEEP19drpAv74E8J2ez+FUFgLSbGUZcbxKDIfPPB46Tx9+S7gZdhbxuiWihMB7k0hOLl4Efkd1oa4brJkp3CauaRkiW0mZ4RuW9f6bE7Wi+rYGGjatH8oj3rpNQP3XFmaz6+V8QI97k+L3jAXlW7UD3SUhbch4quNaBUbBxESN67itqrn6BP+Zb8Cm+beedyboQBsXbC+KL5Qif7aGpNa/hZwNWb1mW7qDQC0rECEf3n5n7SWOCnfPl0oZcfatiIxClF6HHv76LB3LhYSR+t+toZLvA1q/PhvRmDReC96c8YkRf6epelZfez3FBujGLUD/Y6vWu4bEwUtcauICYnwRSY7i3gXhTBUc+BoOR27u0+A7D4U8sQWkhaXy+Xc+
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(44832011)(4744005)(5660300002)(7416002)(76116006)(6916009)(66946007)(4326008)(66556008)(66446008)(64756008)(66476007)(8936002)(8676002)(316002)(2906002)(38070700009)(33656002)(122000001)(86362001)(26005)(6512007)(36756003)(71200400001)(6486002)(54906003)(38100700002)(6506007)(41300700001)(2616005)(53546011)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?MkZGRzdyQW1oeENJMDdTNnUraG9laHFnNm5VNWhLNjVSYUlYZmZjMnhodmlH?=
 =?utf-8?B?WWZVbjNhUTJpcmY4TGFDd1J1T1RTbzRYRlljTWdkOHp6dTUwL09RKzBzYkdD?=
 =?utf-8?B?UlJpQ0diaU05YnljNUtkbW5NQzBDMnlPa1B2b1A5dXVVWk91Y3EwbFBZTVFK?=
 =?utf-8?B?Z0RsL3pTNW1zTVpOdWdacWRQYmZvVkZwVTVaZ24rNXBCTzRWek5rdnlsMW5q?=
 =?utf-8?B?TXFDVUFLakRocW1PendKZk02MkhsQTRKRS9vTmZZc1BFZEJiVklLVkdWSktt?=
 =?utf-8?B?N0o4NS8vckZrYkJSemhkaFp4N0NNQnVWUGpFQlpNMDBGOEg3SVJ1cHhLN1ZI?=
 =?utf-8?B?b1ZWeG85QWlpdzJyU3IvOHl4TXNKUXJxRThYOTRTNzNDU2dxUUhwTnRYODJr?=
 =?utf-8?B?NlVCVkRBQ0grQ2pEUEV4MXprWkVwbGgvVUdQcGJVYnJBWmhGOXFtaU1ubjFn?=
 =?utf-8?B?SVlIc2llZWk0bE1lNVRNcFRsYlloSHMvN0dQSXMvaTVSNDVrejdtVTZmaU0x?=
 =?utf-8?B?WTFUNi9FL2hHQVlRaTRieDE3OTFSNG5ibFMvK25yREdQYUNxZmNXR1psNXc5?=
 =?utf-8?B?citaajd3Ym1oVkl0OG1qZnh0Vzc0QlN3aCtMb1BxWFAwOStyY0k1dkNpdHo3?=
 =?utf-8?B?U3dkMXJlVGlmTDRWR2F0MTFaWG1kQzRlVFplQVY5VzczUGhCVlV0enFWR1pu?=
 =?utf-8?B?R0hFTlg1WVNuRVNwcFpIUGx2S3M2elpEd2dQQTRNc0lrWmh4UDg3SEJ4LzZJ?=
 =?utf-8?B?QXlRMFdPbUhMdXhQTE9oOFhmSEFQSlJrdVowSkxDRGhnTUFWUlFXa2hqQTdy?=
 =?utf-8?B?bDYyUEtzcExtK3JDMEEzWmJYSERkbW9JZkplSDFMdTZBV3MwRTNvYlVPRmdl?=
 =?utf-8?B?Z3gzQitRNGI5TjZzem53MjlMaGNnRkt2UjVSUVJ2VWREVlhYQXZvc2YwMHcy?=
 =?utf-8?B?UGd6TzNMWkxOLzM2bmp6S3JGVVlrK0ZRYzZucjlHSEJLd3BYM3ZtRXJxNUEx?=
 =?utf-8?B?RzBFQXVlQm9tRTdRY2s5RzFPdFNsYXRBRTlrd2plUlNjRUJxbGIyeTFtRmFo?=
 =?utf-8?B?U3I0eFFXUXMyaVdtZDU0VXp4emM5dFE4am1maGZueDJ0Z1c1NUFFNVhpUmww?=
 =?utf-8?B?VDdoL3oyaDliRHJZTGd6VU1ZNlhndEYzdkEwNDFCbllINVJuRyt6T0pSL1dY?=
 =?utf-8?B?MWF5U2VuRS8yUEcvRWdkblg3NERNY29qeGhvSldlOHZUZm55ZlllZkNUam5w?=
 =?utf-8?B?Q3hmeE9rVlBmZWpGcTFNWXA1cTNPTW9OVFI3U0Q4THd1a3RXcXJzMGVSalpS?=
 =?utf-8?B?NElHTGR5VWdDSHZkRW81NE1lSGoyN0dLYjhXSmFFNmk4MndnVmlxSzRqVTgr?=
 =?utf-8?B?MGxPV1lKc2NNTjV0eDJUVDZRNDBWQngrQ3FSTmU3aFp1RDc4R1oxM011Y2Fk?=
 =?utf-8?B?LzUxU3owNVNpaE1XSTl0cFdmdy80Zm9Bc1gvTWw4WkRaOUQ5cVdXVDUxREh0?=
 =?utf-8?B?TlFvZnhxQkJJUkYvL0huWE9SWkU4dFFtY2hzbWRlbk1WRWxlSm4xRExPU3Vt?=
 =?utf-8?B?Zi9nNGgvL2MwNEF4azA2U01MRS9DeXlvdDNpaENxYkNiUXZXbkl2elRxSUJk?=
 =?utf-8?B?U25yVEZJdWZ1U2FpMEJMdmFXdXdaOEdJdUtBSlNJRnZadlBHWHJGUkdqYmY2?=
 =?utf-8?B?cTdlUE4yQTF2OXFxWGpTQmNtY3hJbTVRbytXNmIwY3ZwaW1iRnZnQU4vWXNh?=
 =?utf-8?B?OFNYdzN0aXZkM2FmMHY5VER5QzNGSDhObGx6aXlodWwrTG0wNitrWEVDQ3RM?=
 =?utf-8?B?WThNamVpMU1OUWJqalMvOWR3RXVwdzg3NTdnUzM3aFltZFJtczE1TldYRTVq?=
 =?utf-8?B?VGF0RjBtQ1NyOGNsSUdJeHN2ZkR1Yklnc0FsSFQ0ZHFiMWhBcncyVHNIU3Nu?=
 =?utf-8?B?QmdmNzVzb0wrc3RPb1Q4MndhbytFMTFvYXNweFZXdFdSNlhGcFhwbDNkN3ZE?=
 =?utf-8?B?YkZqYXlrVVkwM0J4ZFZmSTdmTzFKcUp4bXdDZjVEQXNOV00ybjQzaG4zdUFT?=
 =?utf-8?B?bnBwNS9XUlB3UHdwbUlUOGlhaStZSnh0TDJiZXhCVEovSlU1REljSlZEbzcr?=
 =?utf-8?B?ZWpxRGlwcUJuU0NuaWQyT04vL1hsc2F4dFg4WCtHUGdNN2tUMXRiZEVzdytN?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA53A82EA4A8194197AAA8835E08ADE8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JC1/bcCRtYE2Cz5MoNck83/fLirH/VpOrKHKy8EeiCpiX4xdCYnaKGCSR2EbcQC7rlf0el9CiAHYkf6DKbJvBfZ6SSKvEEjUWGzaf559ItVmfkEiLMn1US/3RgpSDxpaEIFRzVBabyj7ybH9DGM4oUk7T6/ikH13sO2teptYW9WuSmzKCJVLUA6KZtFHPVU2GSvoR3GGDQQERr1LCwOlKZdjfpE4/TrN0m77QWYd3gH2KDfmD3xQOyhmI2Swpo40V/OuWeaEZbKVJAEi11eYzLrj1j+czhRK6s8EnjTGFJJUhBAs/Lmm8FT64B6+hgTkes5qaa1+v+zdN+EE+Bg5NPTs1rROjC19XwH4X3ZtrvMXeDgR66hBJp+8cQYqcnMTbuSU7JUOrBvO+I8KnSOMRbGRvFqhMLm9LjHNZsFxyXfXzqh9tgotvS7j7c4gJCfpHnboEsHcq2rNMldYVOcx8wAwyMXncN9DS8GQKBKwp3hmdqiEsppkg1qxDjv82khGIyTuRVfiQzfMLjc8tcPUrd09IXourTeVhwV5xtNAA6gJ6mPw3UKOxbPxoNdGBNB1EOphfbEPWjHzBco9bwHtei5nCsxR4BdXI/wefYZknG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a769e208-c31b-4b9c-d047-08dc2f3f800d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 22:34:55.7258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TN4Cc8+k93vqbNlK3ezbaWNMNqboqTeC1AEZeRrPSG8texoRmPWoG539LMTBhATZtViOzVvE5jHbWU8QLgp1klNfCqRQT4tAE/KLor9SFUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7016
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_22,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160178
X-Proofpoint-GUID: KeDUHV_WteXHfEUoTJI4tmc6j5vU_uiP
X-Proofpoint-ORIG-GUID: KeDUHV_WteXHfEUoTJI4tmc6j5vU_uiP

DQoNCj4gT24gRmViIDE1LCAyMDI0LCBhdCAzOjMw4oCvQU0sIFJvYmVydG8gU2Fzc3UgPHJvYmVy
dG8uc2Fzc3VAaHVhd2VpY2xvdWQuY29tPiB3cm90ZToNCj4gDQo+IEZyb206IFJvYmVydG8gU2Fz
c3UgPHJvYmVydG8uc2Fzc3VAaHVhd2VpLmNvbT4NCj4gDQo+IFRoZSBwYXRjaCBzZXQgYXBwbGll
cyBvbiB0b3Agb2YgbHNtL25leHQsIGNvbW1pdCA5NzI4MGZhMWVkOTQgKCJBdXRvbWF0ZWQNCj4g
bWVyZ2Ugb2YgJ2RldicgaW50byAnbmV4dCciKS4NCg0KSSBoYXZlIHRlc3RlZCB0aGUgaW1hIGFw
cHJhaXNhbCBwb3J0aW9uIGFuZCBoYXZlIG5vdCBvYnNlcnZlZCBhbnkgcmVncmVzc2lvbnMgd2l0
aA0KdGhpcyBzZXJpZXMuICBGb3IgdGhhdCBwYXJ0IG9mIHRoZSBjb2RlLCBpZiB5b3Ugd2FudCwg
ZmVlbCBmcmVlIHRvIGFkZDoNCg0KVGVzdGVkLWJ5OiBFcmljIFNub3diZXJnIDxlcmljLnNub3di
ZXJnQG9yYWNsZS5jb20+DQoNCg==

