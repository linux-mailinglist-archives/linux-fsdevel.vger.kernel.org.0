Return-Path: <linux-fsdevel+bounces-11415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C5A853A40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0BD929069C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E2E605BB;
	Tue, 13 Feb 2024 18:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="emYIgp1C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CTKDijEm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0DD29B;
	Tue, 13 Feb 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850173; cv=fail; b=u8fJM/Qagy9p4Mw82o3P13GgkUv9v90zNZvAmAUMe15r8aa77gLHZOUOnSPF3aK9tbuiFpvSqNeFnwnEb3S1YlLwoYkbHnjBuleOcH8YZVOyK98gZ2xjXTj8CYYeM5cGrPlxKd/3K5/jJXEFC2iNjx6TLJLGl8Gl+9R7VHHu9MI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850173; c=relaxed/simple;
	bh=KjY6CJ0QdpDiP5QM1aL2TpqnhSPGFjCYqOoRsczHebs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gfsr55aDytHaFW0xefM4H9gJeLdGlPyZUZGvCNvbnEx+s6PbWQp+/IyZ9DrqY+ejDBmy8W1MBSxb9H5fnQEI/nmovUDwYdHJwukRKKskvjD7GIpFcEaBNuiVtycQob/E3SYlTVLBI00LvVG56+Sl3v0ixa2/f/D/kWbHwO2/JwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=emYIgp1C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CTKDijEm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DIim5V017678;
	Tue, 13 Feb 2024 18:49:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=AQWpNb2eLH4xzhlxFCw4aqGskqjB5EFji3K/VbTftI4=;
 b=emYIgp1C6/F5rNtZ9P4MqJ93KwgZwNrTfhg8roBOGt+wDYIVu/JfubdbQbpU3zr37UNQ
 gxy831beVq5paQM/l5aWBt08vigjpVfQtor1lUmRhpsa+DqYZc8ZWVPBqRrdNrH9AlvX
 jr636uZy4xUGACBG33M6vAAiRlKfw41KhlBeET0gNq8Z7+zAP4OtCv3KnuTVXtFtyOyw
 red9BgzJZfx66nIoOdtTwveQXZDdZ5sQHBXtyN5LILiD+OIcY8VK2C7boSvxtCj20AW8
 eHmbOccwwQCAAArX++duxhhppFTC9wM5KVZHHt13xWFOLqI7P3OH7bvmnsLD5vQ1u+7v JQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8dyjg0c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 18:49:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DHs07p015276;
	Tue, 13 Feb 2024 18:49:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7suc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 18:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5Ozm2D8h15RQAaTlweIPokFomZ2OK42M7Sz8O1gq5lVu74772NpRJaK2lkyNX6ofStpy5uR78eZ5kkCmsKDr/SBCkWbyqzTezf78zfKfZkPUKan9ruEADYC2zqffu1bWSvXu99KkzjQlo9eFYfh4yOw3a5SmUsaKEZZwNWsFxlu7LCp5barSWC1qU2Bc1TiCGWv14kRnNZDNUbwAALnvQe6P7H3esa5BfLrO7xL125ExOKZwPPR7UgaeSLxe8v+jaQv3vDFVvl0+oUCEvHsCxRn51Syqroo8cGgb4LgHPqvCvvpq6/DocE65mapr4ScjEhj+AH3U/rL5W9mrtILUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQWpNb2eLH4xzhlxFCw4aqGskqjB5EFji3K/VbTftI4=;
 b=EARDXezQ5Wt5QqVAAONVQ454V5i4Ol287NbI9Pcny7we1SUdA0PURQ9PsUnhj8s1K/CflxLT0B7QeSRX5w5iaxOeXDCRsRMWVbw4svm2nGf+gGdEhWyU8mP77S+f7QjpayGgugp4W1mBNIkG6GWA5HqK+Nu3cQHEtvIl3s2liV9woWyQMck6Gwsuz8AA4Hamfiw0VcGxLfUEunE03ezw6pZqt6IUcUCC2Vl8oEX5JFUedCXM5ajB1AU9+3SorvJ4wbeu0NUMOTWmeInNUfqDddPk6SFfDIBMHy9fdNXTg4v20o+sGLeN4Ve+CDn4e09IkfYF2zTiXttQRz55X02VIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQWpNb2eLH4xzhlxFCw4aqGskqjB5EFji3K/VbTftI4=;
 b=CTKDijEm0KEfN7sywH1zvRp1xgb+Le7CKbLDFsge+9051gD3QGZg0J4ht1UTGK3aF8fUu9i6qpcuLOh+KIb7olR0gEHbDlCHT8ERXI1EPargigBJWM+l56kkCcO0pTnPZgLP031NhqfElWwKUQcgjlmQ7N6U4oVgdRJIYStMJzE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB6807.namprd10.prod.outlook.com (2603:10b6:208:429::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37; Tue, 13 Feb
 2024 18:49:07 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 18:49:07 +0000
Date: Tue, 13 Feb 2024 13:49:05 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240213184905.tp4i2ifbglfzlwi6@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com>
 <20240213033307.zbhrpjigco7vl56z@revolver>
 <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
 <20240213170609.s3queephdyxzrz7j@revolver>
 <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0003.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: db53f041-62d1-4b82-096c-08dc2cc4756c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ho5TZL26Ooys0A+gxR57lUbGYXjG7tChDb5uvC5BDFv0gI2ZP06hK7yKhob0KOh2J0qFx+iR9X9sRzg0KghaHHEQit8v0e+lUx3pqjrw2Ami/+MFGxDvzdTQTUof1hoHWKsP2qbd2uMTUOjbXSsT5G0EwLmP7Ql7Z7dObVGk2zXp/0nizcrzJDSL6s3tmohMUXY2kqedTa5F03iXLyGDneG0+yI0KQB6qlvBXA23/uySCKFeKkggchDIhL1nupMwt1yl5iErczqnCfwAYSqmsN+X3AQhfD/qW7mgJdgVWY3T1oeVOwckUHJSwHbw/WaBdSsKh7/72mY+HzUrB0tvJRNV/kpZqSdsIMowBGoaoyeUGOtLA/zUOuEBpqa4sKwbgF61o228Bhh/k4KdlpMLBnapV41svvWOkSozOjGqHiOPR5/IpXibCewNfYgXJyijTD0YUB+fI1cZ12CffC3bgpW5xjNgCYxK8+Vz48FgV8Ak5KH4YiYjR8b22rBJ/Vs7bvkqM9w6JVlh0x2eB4JGInkHHdZ9fIRkpMryEXNLyKytIgOd5eseANAxZYlif5PX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(6506007)(6512007)(66476007)(5660300002)(1076003)(53546011)(66556008)(83380400001)(26005)(66946007)(8676002)(4326008)(8936002)(6916009)(6486002)(9686003)(316002)(86362001)(38100700002)(478600001)(2906002)(33716001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUF2a3ZMSDRWUS9SVm1qcVhMejVlaFAxQnIydFBXc2JwdVExSVdqanhYSStn?=
 =?utf-8?B?Q1hQd0ZLb2hleERhWmJUcDJ5L21kZS9wanpFV2I1VHI5Ynl5ZThmaDAxRG9k?=
 =?utf-8?B?cGlYY0xJL05wTnlGMis0V1RCVVBzeUhNcy9HTFdndlhwR2xLakNXMklIaGlE?=
 =?utf-8?B?WjNuaEFKeUhrVGxaKzFjb2V6U04zZktyOXoxQzhWUjlMWS9qOE5ISVVpWXlt?=
 =?utf-8?B?eXVkSkdCUkxjVC9nSC9FWWIweFc5azc4U01udWpDVGpOc1pxQ3duTjJOV0JB?=
 =?utf-8?B?a20vS0FlVittSGNJNjVpY2ZrYzR6ZVROcWRCWldvZVpzL1hZTVUyaGJjTjFy?=
 =?utf-8?B?SUhSQzhGMWJ4bndHZHk5SFhocWt3RFBlbmJIWjRDanlMUllZcWkvb1o4OE1C?=
 =?utf-8?B?dEQveDVMMmRpSUJiWXRzaHpiMVFtd2R4SjNISlRVMnBzaEIrSEdkM0xiSjBX?=
 =?utf-8?B?TUZEdTZVVk16cEY4T1EzSVZPc0NWT0Z5MUFlQm52U2xFaEtEd0d3b1B2dGtm?=
 =?utf-8?B?RFJSMkt3aWpSWDRVNWFwdDFjZDQyN2ZaZHhpSVByUXR6cFp3S0xpaUZDWVUx?=
 =?utf-8?B?VmZRRTR0NXVDeXZBTm1wNCt1RDNLTFQrNFVPclpTWDQ4Z2p1TU5sdWw1Q0NV?=
 =?utf-8?B?bmYwdW4wTUNSU24wMkoxMW4xcksxUEt3bVplUmtZTThlL2N3ejRxL05QTUNt?=
 =?utf-8?B?ZHh5TXFwSEVMeHlKcjdVdHovc3pVMEdTQXcrMjkra0UwMWNkS0ZzdUNpaTdx?=
 =?utf-8?B?U1VHUzloMjR4ZWtWYXBNMnN2Z2F3UEFtU0dabTlTLzd0QkJxNk04YkRCU3Ar?=
 =?utf-8?B?MHlSOHUxa1NDRzQrWFh4eitkNjBMbkpqUXpkNWhieXc2dThhdStVa0VVK1Ex?=
 =?utf-8?B?RG0zb01wbzUyUkhYeWZaeHBJWEwxcW1wTkZXcnd3VVBVbUVNZG1TSXY5RmdG?=
 =?utf-8?B?a0pSN1NzNHBVWkg5bWtOcEpsamJwZlZMTGpDQ1l4aElvQlM5WklWQ2ZTYWt2?=
 =?utf-8?B?UEh2UWM0Nk1wZjNHQ3pyd0wwazhUcm90QkRLdVEySCtJZUZUTnpEUjRabklk?=
 =?utf-8?B?N2w4NXphSmlEQ1AwSWdsT1IzNnFjcEhFWWhRWUlQYmVFRTNkZENicmlRWnpO?=
 =?utf-8?B?cFdtampIOE1pWjBxY3cwcmRMbWpFalpiR21wUXpWUHRxQnhwZHYwNFZrMDNC?=
 =?utf-8?B?eW9hOW1lbmhaK3J1bUNNNWs0TE1WQXc2eEJhb2t6VVNWeXErZlJMYzVkL3VC?=
 =?utf-8?B?Y01FWUxpSFJwNmNrR2pPRzJHZlY4Z2ZsTmNqYTJKTzN4VE9SbnRrdm1zNjBB?=
 =?utf-8?B?a0hsdUFVSTJPd01RVGI2QkpMSXlGTUtSa3VEdkNXUnpuWnE3L21paElNOUla?=
 =?utf-8?B?alZjMENkaFFrbXIrOXVlWDNVV1Y5bGE0UjFEb2svSCt5Q2pYekJ2TXZNME1Y?=
 =?utf-8?B?WEk3MStyaUFSZ0M2WlczYTBkU3ZLUzBRZEdFNGNGT1o0U1pwK3FvOEErZ2F0?=
 =?utf-8?B?dkt3bzhiSndXSkNJWTM3b0V0a3BmYWFjenJxVm5sek5NQ1NRWk9WS3R2b1hC?=
 =?utf-8?B?R1ljZEpwdUdIUStKMkZHYlVyVjQyT0Nzc2NKRmJNTEU5c2VtNWFSdU9sc1VM?=
 =?utf-8?B?aDR5UkVzSktYNXVwdjJOVDlZTTNQN0FIOTVCQ0diTUV2YVZPeDRZVHNkbUdV?=
 =?utf-8?B?ZU4yZ3FLeFVScFFONDN6aUJXTy9pbE1zLzdBSUoyeUQ4NUVhTHpnN2hQQVJq?=
 =?utf-8?B?Yjd5ZXFHODA3OVBWYWhxamhXZG5Uejhpb2x6WHBRS3R5R09nZ2E5KzYyNGU5?=
 =?utf-8?B?WkZHV09yTkVyNmhVdldnbXVPcGZJMVNRNHhPQk1VL2tIdWhXZjRzMS9RaTlr?=
 =?utf-8?B?NXRRcE14WHZXRDUwZ1BsbGEwUk5CZUl0K3FxWU5FbjRRVGJPbzNnakFOaGdW?=
 =?utf-8?B?MDlXQmRETjQ0c3BGZ293eGxvdHNvOUthSGxLWmdteU9yNklnbjZiVlgyR1Jv?=
 =?utf-8?B?OGpNTnNiY1B3UFNUYlBNUiszL1VVb2JzM0t2NE5INDd0UWlxcG4vdEdrMjBx?=
 =?utf-8?B?d2JBV1dyRlZoMEYvMDUwUVFvamI5T2MzNDVhTTFsQ3cxam4rRk5nc3JYaW1R?=
 =?utf-8?Q?/FEH+PSR3XSFpLG+VabHuo6sH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mLp1PGHq6OJ/hSn+Y3k58sqDGFORJnCT/nx5v4MtCRP19RNBVS363uigxxM19m1mlWQS9JwAn9o7cCnrDX2Q/t3gc9joomygCEEzxo6SsAXagK7P9TtxbGGk96xnyy6oGXlnYAYvc3Kei2w6y+UHixEuERTHJVOgoy1bScehdFLe7y3Jx/nds0IrSaYdiwrGLhzvkKKv0F/LIjJZJpBtAYg7IvVC1oHl81ZoTQNjeJ7C5Q/6MectblyQRHWF2rwmeB8OmRjvWX8nx2Zt/emhmM+sE2Kq8LGOxM1ztLtzS2i54f1SQebpZufWGC58jYUi7xUceoGDl7mPgHtvpXSy3m+JlL+rWzUmXnCmmeL2z3Y9CplT57ZX/SyTgZqTEpXhMAtrjmtt3HJh3m4MZD395dzYwuRV+uFo+DnVJqUh1LTc4p/njNcPRk1EhqkW/1O6oQpIeACgZyq3daD9BnQJwp3mo449y4u4hNOoJqzXazNLfMeFzE4fHVTgiUMLx7ANKX7kejlVHNakU3qto3Gt+dZ8eCr+EOqNj7DgndxjAhaHkLWy+tP+h/UNSVw4XEeNt+UQaeCvzcvDlAlMnHui/p95diVY5fqVF9q7G+/qFOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db53f041-62d1-4b82-096c-08dc2cc4756c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 18:49:07.6288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weEo2Msz4R52i59dTkgl+ov8ksqeHemJYTcq1hqQeSVucnjSxOMFcD4TASO0Bc8im4YjTpgoUnJTXLggo5XF8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_11,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=870 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130149
X-Proofpoint-ORIG-GUID: rqmknZWtA-IwDzJP5aJu10G_RScE1Kxp
X-Proofpoint-GUID: rqmknZWtA-IwDzJP5aJu10G_RScE1Kxp

* Suren Baghdasaryan <surenb@google.com> [240213 13:25]:
> On Tue, Feb 13, 2024 at 10:14=E2=80=AFAM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
> >
> > On Tue, Feb 13, 2024 at 9:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett@o=
racle.com> wrote:
> > >
> > > * Lokesh Gidra <lokeshgidra@google.com> [240213 06:25]:
> > > > On Mon, Feb 12, 2024 at 7:33=E2=80=AFPM Liam R. Howlett <Liam.Howle=
tt@oracle.com> wrote:
> > > > >
> > > > > * Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> > > > > > All userfaultfd operations, except write-protect, opportunistic=
ally use
> > > > > > per-vma locks to lock vmas. On failure, attempt again inside mm=
ap_lock
> > > > > > critical section.
> > > > > >
> > > > > > Write-protect operation requires mmap_lock as it iterates over =
multiple
> > > > > > vmas.
> > > > > >
> > > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > > ---
> > > > > >  fs/userfaultfd.c              |  13 +-
> > > > > >  include/linux/userfaultfd_k.h |   5 +-
> > > > > >  mm/userfaultfd.c              | 392 ++++++++++++++++++++++++++=
--------
> > > > > >  3 files changed, 312 insertions(+), 98 deletions(-)
> > > > > >
> > > > > ...
> > >
> > > I just remembered an issue with the mmap tree that exists today that =
you
> > > needs to be accounted for in this change.
> > >
> > > If you hit a NULL VMA, you need to fall back to the mmap_lock() scena=
rio
> > > today.
> >
> > Unless I'm missing something, isn't that already handled in the patch?
> > We get the VMA outside mmap_lock critical section only via
> > lock_vma_under_rcu() (in lock_vma() and find_and_lock_vmas()) and in
> > both cases if we get NULL in return, we retry in mmap_lock critical
> > section with vma_lookup(). Wouldn't that suffice?
>=20
> I think that case is handled correctly by lock_vma().

Yeah, it looks good.  I had a bit of a panic as I forgot to check that
and I was thinking of a previous version.  I rechecked and v5 looks
good.

>=20
> Sorry for coming back a bit late. The overall patch looks quite good
> but the all these #ifdef CONFIG_PER_VMA_LOCK seem unnecessary to me.
> Why find_and_lock_vmas() and lock_mm_and_find_vmas() be called the
> same name (find_and_lock_vmas()) and in one case it would lock only
> the VMA and in the other case it takes mmap_lock? Similarly
> unlock_vma() would in one case unlock the VMA and in the other drop
> the mmap_lock? That would remove all these #ifdefs from the code.
> Maybe this was already discussed?

Yes, I don't think we should be locking the mm in lock_vma(), as it
makes things hard to follow.

We could use something like uffd_prepare(), uffd_complete() but I
thought of those names rather late in the cycle, but I've already caused
many iterations of this patch set and that clean up didn't seem as vital
as simplicity and clarity of the locking code.

Thanks,
Liam


