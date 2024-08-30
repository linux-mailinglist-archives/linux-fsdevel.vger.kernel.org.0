Return-Path: <linux-fsdevel+bounces-28054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E135B966474
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 16:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164E2B236BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 14:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D71B3B0C;
	Fri, 30 Aug 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="foSeissq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JrhdxUfO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A51917E2;
	Fri, 30 Aug 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029320; cv=fail; b=e9og8uP+A60Dha+50cP2pZ1t0ZYbejNVTx6SVV5GixHwnVkuKznrd9h6jPQ5kjC0VR5u98cIHeMIAOHQF9/HMvQWyXxK4/2ZJ3zYkAdoGVrvru26xvN1a8mDT6aioD8Nyy8AE8RGEp0FPNIDVjszvJNChAbUhmzKG1lrqd5A76U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029320; c=relaxed/simple;
	bh=b1g62mVS2/FGkgQR+47cjCTon/pUum18+EUs4L6c+DI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=b2WX38Xp+M0gybYU7jJeq/VKIToCL3J3LoPZSzBFGpH69pyQOOvWxO15/LUKwy4Lb2Da9voubKxuhYLnIHACY9fphX5HGjkBEIfQOPbT8H9NEFxYoRe0eqVui7xFjK3VfidtU2/NRmgBbVNIdXttjyg+M+hvV2WYCdSDuaMVk24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=foSeissq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JrhdxUfO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UE0U5F018868;
	Fri, 30 Aug 2024 14:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=b1g62mVS2/FGkgQR+47cjCTon/pUum18+EUs4L6c+
	DI=; b=foSeissqfGTgg4nBlvrr3FQDwA2Sv4wIDP4PIKHUEB75Kt9oj50VyF23n
	ppvATjPoAtQwkFwVHyjWkFq14IpTmXvv4P+g+5S+7NFWWWY5YRhA9KUS3BKX8Ca/
	sOxZ2ny92Xp1VHhSsAHRMZ0CyG+xzAADRtS2N3Eun1tp9HsEtXEOZuIILmKWHRbL
	Huk0ELTmGoo5/cV2MPHBj4/tVikxYSI/LLHS2G2a/EYQ0QorS5Id35yy8FEO2YXX
	MjmEWUTiyX4Hvov43v11oH5qD2Rw1oGm9V0WEEft3+s+pxsiDc1RLF4yAQT4bAwO
	2IOXJ017ItSVS6qtzcK3zUgVtj1dw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugxxby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 14:48:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UDnREL034765;
	Fri, 30 Aug 2024 14:48:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sxg7xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 14:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzXBlp4tk+ET5olM5sDIz2ZIlWrby9h1uWGKklvv/Mppoc/N6JlnN7qRJs0/rumAvYRHcBerQlUM49vsM6UWmczu5BUnFyqv+gMc6k5tKeEJamQgrtMBgmmPMrpjXgY6zIUFS4d5pKhk/dcgdHWkj9dwrvuWLY/e7mEgs0VbLqfZSkHjJ+h2i5GNOjYZeOdDYZZS8LV4/ljPJIwYBFWSQCm1H21cpKx/NOG+UruiWfyscurTMnjF9Ux/dPXkqpGWNSp+sZQkPvgGsBcmPgnaEQ2K+n0E6cLgLh9OSjRsxumJaXrBQ4D4p/x59//5YTT3fwAg3lSA2H9zh3YgzqoK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1g62mVS2/FGkgQR+47cjCTon/pUum18+EUs4L6c+DI=;
 b=Wo/jY+4q6CK1Q9T4RAtFkMrU8Ibj7wo3o2Fl6BZcjXtvk9NJ1FsUiKYxu+BvgunxwU9RopG2z/REPOTai+yMZRIhwQPXyH6fMIwKl+WOl9w4WRS6ioz8HjLZ35IPoQ8l1VonaO7bUL5i/k8nfNyY9nNiu5aXKQ290hpLGtyGLG5874RFrBVMj7cyaDakbpMrS/RTF3ZnWOmFXfxheHN8TNze5HzpqAPedYnb2YyVjr9+rm2NPnjEmuDnGllE7KALQgr0CrLbFyWJ8/iBWwHvgEcMcYYQoKFn/EgoVbPbNmVe2haEbPqxdhcxifERZz9K9pVoAbJgnW54MIYtc6cyKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1g62mVS2/FGkgQR+47cjCTon/pUum18+EUs4L6c+DI=;
 b=JrhdxUfOVfTB7guRE/bBv6zqLo4aFUui9asCMo2DOjCAFOGHUq2AygWsCxKCQwVT8Y5RObIzrLO8twTcwU3wdHn61JqTVD567mjC9s3DklqXinDXYwu8YzpF3WoNCg4GwepC6lLKDjhtcX7SnwzUZw2l2j9GGE9EpOE0LSOKM9A=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA3PR10MB8115.namprd10.prod.outlook.com (2603:10b6:208:506::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 14:48:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Fri, 30 Aug 2024
 14:48:19 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo
	<dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Trond Myklebust
	<trondmy@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Olga Kornievskaia
	<okorniev@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet
	<corbet@lwn.net>, Tom Haynes <loghyr@gmail.com>,
        Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List
	<linux-nfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 08/13] nfs_common: make nfs4.h include generated
 nfs4_1.h
Thread-Topic: [PATCH v3 08/13] nfs_common: make nfs4.h include generated
 nfs4_1.h
Thread-Index: AQHa+hcn/cl+v2A+90ShF1r0jeNPj7I+V+uAgAA15ACAAVVDAA==
Date: Fri, 30 Aug 2024 14:48:19 +0000
Message-ID: <62C8CA0E-6013-487D-A3F0-C6069B854BCB@oracle.com>
References: <20240829-delstid-v3-0-271c60806c5d@kernel.org>
 <20240829-delstid-v3-8-271c60806c5d@kernel.org>
 <ZtCQLVAaotGRxLN2@tissot.1015granger.net>
 <14302177e5fd485a9f72879e7c5366ffc31f4e1d.camel@kernel.org>
In-Reply-To: <14302177e5fd485a9f72879e7c5366ffc31f4e1d.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA3PR10MB8115:EE_
x-ms-office365-filtering-correlation-id: 3d89e5e2-dcb3-4bee-223e-08dcc902c9fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VnNhdDJuSUJNQW8yU2VZMllZVlNBWUsyRVZxd2xxNUFnckJ0emM3cjVVKzhj?=
 =?utf-8?B?VUdmdDdmSE85OHJEQTFYUVpCUUtGdCt5U2I5R2g0K1VQZnM1YVZnZEk4UmtL?=
 =?utf-8?B?T2haT0ZZVkRxK3pyZVdYcnBoV3E2d2V5VE94cFE2cWRWcXJiaEFVTTQxRGw1?=
 =?utf-8?B?ZzRqVlkvR2tzNVpsSHg5Y24ybjhkQUNLM3hJQjBZb1RsWmEzU0NnekZvVit2?=
 =?utf-8?B?YXNRcU5VU1Z1R2NKbnJrcDlaY01qTzRSZDZRZEU0WW9Td1lyWXBmamJuZTZ5?=
 =?utf-8?B?cEQrOUlGd1pnbnA4dVU3clVvbzRyUzJMZmpSbEQ0Ny83NkovdGc3QVpUUDhk?=
 =?utf-8?B?R1JMYWEzL1lCWTNYU0lwUEdzRmZ6WThEQmZCVjBQT3p5ZlVRWWpoSWYvZjJn?=
 =?utf-8?B?OFA4b0V2eFRwNTlSNFdVbTIrR2h2am9IOGxGdk5FYXBaMGNYMUZvbUhHc3lI?=
 =?utf-8?B?TWprS2tmZjJFQ2VTemhkYUxPN0NObjBuWjJRMUpKSXN0c2hIK0xpdytSUDQr?=
 =?utf-8?B?L2FtcVNJOFdRTG1YVEZvZURtOWUrVzkxS3ViUmNjaE1SYkhUMUFIZHEyVUFC?=
 =?utf-8?B?UEhCcnIzd2tLR2J4dUwwUnBOVUw5TEJWVHN6WUd1NFROU21xUXZScmNSSjEr?=
 =?utf-8?B?UXFzMERtMi9jVUxkaU5NYnBXcTlyT3NSWnh3ekVIYlZLUERKaXZ5SnB3SVBC?=
 =?utf-8?B?NE02TjRNKzBYQk55OUNZUmFxK1VlYnhJWDQwQzFqaEc4Qnh3MW5RSS9qMzlo?=
 =?utf-8?B?dlg0Z0oxZzdZZ2ZvT3ZJcGpuY3IwS3NxTDl4bS9Ic3hicUw2NkdJbmZnZlR5?=
 =?utf-8?B?ZklpeUFwT1Uzd09TWUhKWEtYTnlRTm1rYjlWNWtXL3JGNHptYzVEWnZJMDcv?=
 =?utf-8?B?RWpwdTNmZWZNckdsYzc1ZlZyT2dLdEpMUkRBdjRLenA5enJlRFFLZlZFRFNG?=
 =?utf-8?B?Uk1CdDFaZ2JKcnVxbmFvbHlRTWxJVitlZ0gwQldYSHQva2lSekgzV3ZiMUZX?=
 =?utf-8?B?cWpzTUhGNDJrOWIvVDM5MVAvWFdINVJ1c1JPU0dEVGVteFF6V1lUdmNwcTdR?=
 =?utf-8?B?V1o3N2xUNXpiY1dwNU5paGJjV1RDWHNxY1VjSElMTkw4V3JEaHJlWVVvZktF?=
 =?utf-8?B?eG9nWXp0OXoxODVhVysxa2hMY1ltMlljWHdKYTgxYW9CZmkxS1c2QXAyM05O?=
 =?utf-8?B?dUdmUXhnQ3Fzd1AxNDAvM09VYjdUc3NaSjlpUm5XWDU2dkFXY0RldlRGU2pQ?=
 =?utf-8?B?MTRsTjhMYjBGME1XUWVGN2h2dUlJWGpTL1ZVQUs4Qi9VcHJlWE5UcjczbHNp?=
 =?utf-8?B?VkpkZWRaOWMzQXdwWTgxOHNjcjk3Z0hxY1V6Y3kyWHlibWY0QTlBRDRnWGhZ?=
 =?utf-8?B?eVhLVlBoMjJNbExkY2EyekJrOWRrR3RVSGlXd0IxeEpvdHgwRklNVWFqYXpQ?=
 =?utf-8?B?OHEyQ2NkcU5QSEUwUUY5WWpYRG94RDY0bTJMWGZkUDM5VVp4ZE1zSmFKdmYz?=
 =?utf-8?B?ZGM4bFl0bG11bkdqS0pYTUgrWnNpNDVsR2RXV3JJeUVpbi9RUzJZVmJYUWdT?=
 =?utf-8?B?dWRJL3BVejhrNngyMHc4QXpPdWR4L1pqWDJwMkt2RFc0aEZlTVN0dkhtOW52?=
 =?utf-8?B?WVY3NmE3NXF2cGd4dEtwc1V5T1QvZHNqa2RwL2FBNlpBaHFsd3UzbDc3eXJv?=
 =?utf-8?B?ekZwMmtuUzY0dDhVcVdadHBLMVJwbWlOUmFGcU9QNUdXT3ZNZGhucjlqR2JP?=
 =?utf-8?B?NHllVmt2aXBLVUgvWHdpZ2lVSW5WY2xPaEh3czdWaDZpai9NUU5LMWgxcXpW?=
 =?utf-8?B?S3grZ0kwTk5hU2NCcU9Vb2xEekxWYzIvYVJMa2dJaHJWMDlmVzlqL1F0cEdY?=
 =?utf-8?B?a05MSjh4eUVsTHFhdUNJZTRpM2lXajFRdUxCRHVOa2Rocmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UStnUWwxejlMd0c3SWw1eDVteHFEL1pFd0xCT011VlJRYk53MmhKeUp6QU54?=
 =?utf-8?B?RVlSNTFaQjFWdDJnM0FKMFNZSW9Tek5hM0RyV3dXOHJBVXhiNC9DUm9IQ2pl?=
 =?utf-8?B?ZUtSZnNKZWZYY053ekdBbzhNbkdTbVNFaXFyS1doTzY2OTFHS0tDMCtaSmF2?=
 =?utf-8?B?VlQwYzhSaURqR1ZHb0FZenJXK1Z3U2NDN3FLdFQzUXhDYVhnSlRIY0NTNDhF?=
 =?utf-8?B?SGFNMis1MmF2RlhWNmJ3ZERVd1A5RDJoRzQ5VlRSU3VPeHlaZW5iVGxUQTVs?=
 =?utf-8?B?R25rRng2dEdndTRrd01RS3hjSnFDeEU5dGMreEFxejNCZEdTVHpNRHFHRjNv?=
 =?utf-8?B?cDBMcFNSTmZ0ZUtLTkdlVmwrZnllY1dQNkN5bzFqTHkybDFwOUtGTHB6bjhk?=
 =?utf-8?B?UFIrVm1UcmpQbFkwd09GU083azFocHp5MThRTW9HKzBYVWN1a2RuTXF5Z08w?=
 =?utf-8?B?M2dsTzduSzMranl5RTFueUc0aW9KeEc4YUx6S1hGSDNiNW52RmQxaVlwb0hy?=
 =?utf-8?B?MkF6NUhUWEM5ZXhvZ3RnK3pkOVRxc3puUG5kOElvd3kvNlVnWlM5L1hCbkRC?=
 =?utf-8?B?alNZU3E2ZTJHSEwyQlR4aHBmSWk4QjBYWHhxeU5OMitKZVpuL0xIaG1kSXRy?=
 =?utf-8?B?Z0JncDZmWjZqRGV1b3VWMFM1Tk9Kbi9NdXJDMm1ibmZFZmdWVDA1ZlIwWXJS?=
 =?utf-8?B?RDBJMHkxNUpJU2NWL3lLZ3c3RHQwU251Yk1lU3ZmSXRVL1h1ZmNKWGdTOVEv?=
 =?utf-8?B?TWZ0WnIvT3B5WGJpRnl0TG9YNVdPcVBnN09SNEpkdkNZNkZaQ2lSSk9FQUxC?=
 =?utf-8?B?SGFHWHRTM2tTaktPZXNXTmJMUllSOUdwcFBCTE9xejIxUk5JM2pSQTBMd3RU?=
 =?utf-8?B?Q25VOERMNGFrWS9rWHh6V3dkdjJXTmhxQTNWUmFXVWtGdGMzbkZCc2g1KytW?=
 =?utf-8?B?R3NQR1ZvWlBVaDQ3ckNRWFhVQWxQVGFiUXYwV1kvTjMwZ3BuMEpuVHhTR3Rz?=
 =?utf-8?B?RGdRR3pQeXg4WXN5SGlwWWF5dml3bHVDSzZVdm9NYXd2VUR3VVQ4YlFHNExq?=
 =?utf-8?B?cVNHN2hFSUVXakwySXVuSVNXcDhHQjNWMXhJSytpME8xZ2lkRi9xK1FuQ0oz?=
 =?utf-8?B?MXlVajNUS1ZqYlIxWGo3S1ZXTFNyRnN0aVJqcmp4R0lEWGppWkJZdm1MYzIv?=
 =?utf-8?B?d3VXSkYwWnVTMmJnaHdaZHNEQjJwN0tvYmFRcDU3UWROdzJtU0xYRlJpSnhR?=
 =?utf-8?B?MmJIZ0dOTSswblI3WXlxY2RlNk4wM091N09NRU5yQmhzbGlRNXRseWt2NTVr?=
 =?utf-8?B?WTN6MEZ5d0xMbGJmYzZIWjExQUpUVnY5VDRvWVVtUzVZbzhHYUhuTkxacHFh?=
 =?utf-8?B?eGRyemV2Q00xVGc3T2pIU2lmVkRXZHkvSldWMnJxV3VuS3JYNnZGcWN3ZWoy?=
 =?utf-8?B?WUVjSlZCUTJWTEhtS1NkWVdYSCtzRmQ5ejl2T1RFdW45YXFFMjBZV2p2K2Ez?=
 =?utf-8?B?dXNWUFI0a2d1c0lVSHlXYmJDWG9PV252eXlYRHJLVERtVkNrcVBjN0pIWUx3?=
 =?utf-8?B?SHF0bUZBWG5xdnBGbFpVZ2ZJbFJ2Umd3UlhzTWhaMnhyWWVmUVNvTHhKTlpH?=
 =?utf-8?B?VThlSE1lbGJRQm5DVGZkY2tLOWxRWVVoOUwveHc2LzAxL2lIRGNtRUZTOGRE?=
 =?utf-8?B?NU5CVGpEWFZkMlh5UzBBWEdaUmROL1p6YzF0TG9NSW9OcDJydk5WdHFKYmFO?=
 =?utf-8?B?bitnbWpSL2tqVUl3QlBwRFNXNFc0cDNoYWlwYXZ3NGMvQytqNkdLWmRkT21O?=
 =?utf-8?B?ekcxcG9OTkRpMnhwT01PV01LdGlYaGJBdkExeHZWdDBaV0dNbjFJSC8zb0pG?=
 =?utf-8?B?em16UFFUanBmakhUeS9ES0hNbnVJQzV6clg4SU11enowZW1SaE9KTHRGS1dj?=
 =?utf-8?B?cXIvWURlSUs5am1IY2c3VTFOSW1pMW9jZEVmYmVRU2luL1FJeHpUazdHUFZK?=
 =?utf-8?B?RWNFUEJ3WXNwaXVzbnRwclJuckpONDM3QnlvZ29oa0NrNFJPa1ZLMTJtTk81?=
 =?utf-8?B?TFBnTU9aT0xFYURTRmJ4UjlDNXZybU04WDc0ODdpWHRtb2tqemVwWll4eEVn?=
 =?utf-8?B?d2FHbWUrRmNTN2R0S3M0dXprTzVPTHhGdWliY0VYUFZpc002TmhvUVJXcVhk?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC9721EC36A5DB45967E353B0A5439E6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HFogWAfFfpAu2vFDa5OfyV+qQdWz2Hjs0KWLiaHW4ruF+i9Ic0qFSNta2a0mQBZPi8sL6drxMtMrd9/AEd/VMOYzoBT4sWP9iJSx6o9v4uW1DNHIKCt7EptPNLkN99GbuYN/4zU7Ubi29DojTHrEZJ6M44R+JtOzj09DFYRBPWiwcChQaQAnPBDE0hMFgL4P5Z+b0c+CqdnCzp9mX8kam8+iOAxYxoOnwZf+8HmnRih0GLV9Zpp4OFjmeaZT5mwWKLP6eQHJ5siCODE4dkkgY04enMYqg9E1z9mLTTkRlrKU8J/1VKdTU0lmWwAHYQgc0nwNwDnX2R66A7nj3r7e7dYZtrtY68wudOY334qIyYwgljtNJ/WxwV5rWj/Re8NceTs7CX8pX+ZyWKzphSC7w8nyjr6vw1ud3FawTa8AAV26jkTTIWDAJKrlUUEnuyHSucM/r+MQuJQCFmOXmAfer0Ge7QbjOYEA/FnU0zbesRmOWmvbiJHimedkNOkv1MCIO0UWoLMStIszOO5IXwzh935eqfBZmLtxJKaOOCuHKwdhsNuHLRuaQVfxsnZ2YTCDS5FoaT7Ox0q9OGZ+LSFo6Kw2/YZEQ/ZwmVgWFYtMVk4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d89e5e2-dcb3-4bee-223e-08dcc902c9fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2024 14:48:19.5557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J0lFe6eluuU5PzjD8YOvYX4Nvae/nv+kA+Z647VoefNiej9Jydb4rzFt8KdxW7kx36AzHWD6W5xn6NBtATdfiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_09,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300112
X-Proofpoint-GUID: iHWscw8XGypqPQdPHtRMgCmuOMB6fviN
X-Proofpoint-ORIG-GUID: iHWscw8XGypqPQdPHtRMgCmuOMB6fviN

DQoNCj4gT24gQXVnIDI5LCAyMDI0LCBhdCAyOjI24oCvUE0sIEplZmYgTGF5dG9uIDxqbGF5dG9u
QGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gVGh1LCAyMDI0LTA4LTI5IGF0IDExOjEzIC0w
NDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4+IE9uIFRodSwgQXVnIDI5LCAyMDI0IGF0IDA5OjI2
OjQ2QU0gLTA0MDAsIEplZmYgTGF5dG9uIHdyb3RlOg0KPj4+IA0KPj4+IGluZGV4IDY4MzNkMGFk
MzVhOC4uMDBlODAzNzgxYzg3IDEwMDY0NA0KPj4+IC0tLSBhL2ZzL25mc2QvbmZzNHhkcl9nZW4u
Yw0KPj4+ICsrKyBiL2ZzL25mc2QvbmZzNHhkcl9nZW4uYw0KPj4+IEBAIC0yLDcgKzIsNyBAQA0K
Pj4+IC8vIEdlbmVyYXRlZCBieSB4ZHJnZW4uIE1hbnVhbCBlZGl0cyB3aWxsIGJlIGxvc3QuDQo+
Pj4gLy8gWERSIHNwZWNpZmljYXRpb24gbW9kaWZpY2F0aW9uIHRpbWU6IFdlZCBBdWcgMjggMDk6
NTc6MjggMjAyNA0KPj4+IA0KPj4+IC0jaW5jbHVkZSAibmZzNHhkcl9nZW4uaCINCj4+PiArI2lu
Y2x1ZGUgPGxpbnV4L3N1bnJwYy94ZHJnZW4vbmZzNF8xLmg+DQo+PiANCj4+IFBsZWFzZSBkb24n
dCBoYW5kLWVkaXQgdGhlc2UgZmlsZXMuIFRoYXQgbWFrZXMgaXQgaW1wb3NzaWJsZSB0byBqdXN0
DQo+PiBydW4gdGhlIHhkcmdlbiB0b29sIGFuZCBnZXQgYSBuZXcgdmVyc2lvbiwgd2hpY2ggaXMg
dGhlIHJlYWwgZ29hbC4NCj4+IA0KPj4gSWYgeW91IG5lZWQgZGlmZmVyZW50IGdlbmVyYXRlZCBj
b250ZW50LCBjaGFuZ2UgdGhlIHRvb2wgdG8gZ2VuZXJhdGUNCj4+IHdoYXQgeW91IG5lZWQgKG9y
IGZlZWwgZnJlZSB0byBhc2sgbWUgdG8gZ2V0IG91dCBteSB3aGl0dGxpbmcNCj4+IGtuaWZlKS4N
Cj4gDQo+IE5vIHByb2JsZW0uIFRoaXMgcGFydCBpcyBhIFEmRCBoYWNrIGpvYiB0byBnZXQgZXZl
cnl0aGluZyB3b3JraW5nIHdpdGgNCj4gbWluaW1hbCBjaGFuZ2VzLiBDaGFuZ2luZyB0aGUgdG9v
bCB0byBnZW5lcmF0ZSB0aGUgcmlnaHQgdGhpbmcgd291bGQgYmUNCj4gYSBiZXR0ZXIgbG9uZy10
ZXJtIHNvbHV0aW9uIChvbmNlIHdlIHNldHRsZSBvbiB3aGVyZSB0aGVzZSBmaWxlcyB3aWxsDQo+
IGdvLCBldGMuKQ0KDQpPSywgdGhhdCBtYWtlcyBzZW5zZS4NCg0KR29pbmcgZm9yd2FyZCBJIHdp
bGwgd2F0Y2ggZm9yIHN1Y2ggUSZEIGVkaXRzIGluIHRoZSBnZW5lcmF0ZWQNCmZpbGVzIGFuZCB0
cnkgdG8gYWRkcmVzcyB0aG9zZSBpbiB4ZHJnZW4uIEkgd291bGQgbGlrZSB0byBhdm9pZA0KYWN0
dWFsbHkgL2NvbW1pdHRpbmcvIHN1Y2ggZWRpdHMsIHRob3VnaCwgYmVjYXVzZSBJTU8gd2UgYXJl
DQpwcmV0dHkgYWN0aXZlIGhlcmUgcmlnaHQgbm93IGFuZCBjYW4gZ2V0IHRoZSAibG9uZyB0ZXJt
IiBmaXgNCmRvbmUgcXVpY2tseS4NCg0KTWVhbndoaWxlLCBJJ3ZlIHVwZGF0ZWQgdGhlIHhkcmdl
biBwYXRjaGVzIGluIG5mc2QtbmV4dCB0bw0KYWRkcmVzcyBtYW55IChvciBtYXliZSBhbGwpIG9m
IHlvdXIgcmVxdWVzdHMgZnJvbSB5ZXN0ZXJkYXkuDQoNClRoZSBoZWFkZXIgZmlsZSBpcyBub3cg
c3BsaXQgYmV0d2Vlbg0KDQogIGluY2x1ZGUvbGludXgvc3VucnBjL3hkcmdlbi9uZnM0LmggKHBy
b3RvY29sIGRlZmluaXRpb25zKQ0KDQphbmQNCg0KICBmcy9uZnNkL25mczR4ZHJfZ2VuLmggKGZ1
bmN0aW9uIGRlY2xhcmF0aW9ucykNCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

