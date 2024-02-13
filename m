Return-Path: <linux-fsdevel+bounces-11421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2A8853AE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A142B1C245F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A465605D0;
	Tue, 13 Feb 2024 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WS47MfkF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RINtyAE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1655FB8F;
	Tue, 13 Feb 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852490; cv=fail; b=M9pz4O86ojfOD4DJuRCsXJTshO/EkGIKW12jn1ZRooEpgSy0ei9cYI4sEfxKNj0x6fzEP6xQUfeCU9wnvrdM1i1pvTBQLh9SNH4W6Fs14CQoKUPvMPcIvrnURbZEoKNMALNNev+36zSjZ9TkQKbdSwlVOlk30qwM1dauJp4ofCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852490; c=relaxed/simple;
	bh=WWiATnFIEbjB9SmcjrGnm7PlS3gc7pm+/DQF/Ghvvro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K5CmmaYAeyHFC3j3uCS+VL4DwipCuassu2bq1fuocNLN/3VA1/WAVBVXrZWZeU7dzxkh01remrc1fAnawdN/Zjfi7OEM7RKXD6TUkx4nae07w7ewTIkdyUOpC6FupRyfJ9fgSZfV5nOs7LQbF8xcy3YJuB4ockP8yr4Jx45mYDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WS47MfkF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RINtyAE+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DIj3Ej018242;
	Tue, 13 Feb 2024 19:27:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=tMY3gD0k8n+aCx1Cl5OK074ewx8RLwBaGuHknxDnD3s=;
 b=WS47MfkFnrsYbTJQqAxbNwGaSlHq/wO+xrmGwH0xBQUgLH2r57Nz19CZJ1NQZn7zdaXC
 gzMAmOZcZ7AYxV2Zm7OlKnQMjAbudpzLdBI9mD1+VvSvsCgPm1qwsJTlmQFtA8LChuh2
 +zjii2+GvTheSE92pzBvGIiJXyKiyhOAenJIECIwFgAyfviUKI1EDOxH7nUfCY0oR+U0
 HNmaYzhBmYKpVsR0UwQPzA6DKiMWZNklKHceZDQxksbzY6uQHHRnZ0ZLiFCwql0e0x2U
 1l9KNuKNMjgHPjdL0iB0/VyT89ccOzKDSGZ2t9A8E0jiykkeQG9piSypMCShWmeUtnL/ Zw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8dyjg2tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 19:27:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DI2Bgx014975;
	Tue, 13 Feb 2024 19:27:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7js5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 19:27:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmhSAhj4BaX/U7qExkJsBWfH139nxIX2+IN7hNOsaqAMA/46uDjqfJQe/ZTLwLIQVf5RwAqJIH0WPNj+YYKHKYltOoIv4QVpVtoJ/cKMzuHeGA/eo7Ij7RIch9l38TFMVjJdng20c44Z5uztkknCrGnpVTRGo6PMvLxyAIY7Tk5qHm1v3CxM3yizaCiCjqLc5U49XtxWgXN0NfS+iAUUB9/iINSFdkBqyT9A2nWcb4T5ekBcfhTwVHa8bhmMJ+Ltadf4FA3bJ/7/t/SAPOc5AvWu10/WtIrv0zNSL49KfoShlVIAuFrWOl3yVKLxDczex3/NAZTcyxJODj5si4sq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMY3gD0k8n+aCx1Cl5OK074ewx8RLwBaGuHknxDnD3s=;
 b=arwZV7NukYW/4Y+XFXGz9A2tamHfEBEYDX5t3d4617rIngOHa6QuexxsfkBzGHa103dhqqXeMA9vDzNUGwnocP2zVmzIfTneNjq7ehDtisE2qnpGxXFeXT5DdpP2FSpMPdkhgJKdiiuaziRHOW8AAL/frdq0kuTP70Z9cbDWVioy09JmZEzlxNN96hqA+Wa1kprk31o0t0h7vHQbuRPJMbK5X6IymKjmtLYmahXhB1qU62cvkn1UES+6hwrOu6H3HlCY2nOiswyWgcBY0VTaLkiPtJfZUSN0bXMtKwd2fC8om4EM92gL4/6CdKm7Y+8K8zFCu3cItYY4BhHc9YPZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMY3gD0k8n+aCx1Cl5OK074ewx8RLwBaGuHknxDnD3s=;
 b=RINtyAE+JyjVoDUn+ZKhmmRNG0CPZh1XFl1JRJcgFz3Dik5BcjA/BGrb44O7oHu7wbtSyNdVJlcMGb+XAiqaPQWRU+qxYOrSSBTChLzUO97wtgzakMskcivMrJhHFWphwoDT4le0Hi8mHidlIphL8Lx+UIzPTISeYj2maevZ54A=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4175.namprd10.prod.outlook.com (2603:10b6:208:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 19:27:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 19:27:46 +0000
Date: Tue, 13 Feb 2024 14:27:44 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240213192744.5fqwrlqz5bbvqtf5@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
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
 <20240213184905.tp4i2ifbglfzlwi6@revolver>
 <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
 <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::31) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4175:EE_
X-MS-Office365-Filtering-Correlation-Id: a72ba033-22d2-4afd-b223-08dc2cc9db93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QWToiLWl0k/l9GPLp+OzCm0WuyAGQDsqkcEPrDQVKI9mdUrNShWYNctfEkWVOVSSCipVoJO9cKiaHOZ7beCdJAu6d6WAKlWrsOKGtCCxIlRmTyxrbFphbwrq/k+sv/MzFVsMBoMsOWh36W4abv9bFyzrFoXYYOpn6MoJoNw3oDPIWqg+efx/2m6CcWHylnZsaZ0UI44/eWHCQZoPZ/I6pXTuBAFhvMT4mcPDQXQRgbBjVofXItS5Hez6sJkue3UdKBzxsEOAMIcEKpU2Rl9VlYvrmsg+q4coL4fG/QYYdCZBqd/qqkjzHFt4l8K2oAQW+xe+LnBSwWdzjZSRgYwCv9gLq8q+l9iK+quccvQ0IamboaHWKefVH+HVz6Zb6IX7yMG6OIFIA7o1C/xW8OGh7Q3VaLrMxpnbtuS3C0cjs7OnKEcRHz/979fYborqf+mpbFHU167a0Ity1vJjSkVpgK66Ekg70IoMuKfVuutE3qkvzxHYM5jIAbwDBmMlFKg+HnXIzHBM7RunTUiWB89rqwxMtdrRQI1Y+mJYbctLLInfrjsw8JNz5AVJOzuwWHd8
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(8936002)(8676002)(5660300002)(7416002)(66556008)(66476007)(66946007)(2906002)(6916009)(4326008)(83380400001)(86362001)(38100700002)(316002)(478600001)(9686003)(6506007)(6512007)(6486002)(26005)(1076003)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PRsCaAHpV/LHO/simF8wfFLwqEsGkqdQSLyqkfx+gH9S8snKzdfD5Im9dP5+?=
 =?us-ascii?Q?iINS+nCWz3WHMkI3NQHxFO+bue5YsPh891qDiZwDpY6wtqzucxhIb5WjGauL?=
 =?us-ascii?Q?LkSIXmVyEg4GSeXnN2LRQM833HxMGVGZUIGul0frPFBx525+FcWQIQA3NAoe?=
 =?us-ascii?Q?dPATQ1OLVmHi/qpRjRFE8sj27sq+b62ybuRWQi+qHa3sqeLtAGmb3FXce0aE?=
 =?us-ascii?Q?QMW0OqNL69fqpw36Fd8f39jNVPtCIKpRnc2xhfZBhAlkaaKDgRspSg/OxDRP?=
 =?us-ascii?Q?Oh51lScthjOb4+IJ5oc2/oFzAqtVij1kfCMssiCsICfNphmTrepXPXlBKgnA?=
 =?us-ascii?Q?FOX056pYBMsOxCR/5TNrOdxDF54pan8857MPQIG5ce4p5N7Uk+oDaOD90i+p?=
 =?us-ascii?Q?L9si1PA7LD+fQsWllNn75KLqU4goYh2LgHaXYxjyKoCW9Q76w44mekrIc1Lx?=
 =?us-ascii?Q?6TSoIVgeLWFR0BgyUMj69JV70YG0M+ekfW3kR3rwpqV0EZtPWM/H23i+P0rG?=
 =?us-ascii?Q?pkF717TXzLmwweP95WAj67r+ZF64rqbJWAZ7CrLpKHjQdj74yA+V+qoABRhF?=
 =?us-ascii?Q?z1rfPo8v7Ary4r8BWMdJb3dZAggM1e4XdKbxmKPI2thLymiqmC759qTGrm7i?=
 =?us-ascii?Q?l66u7eqxycRCZVYbjgez2Y8sYFvdMYcAxslFIh+hJHhicdLw6UCvjsjR+ny2?=
 =?us-ascii?Q?h8Q3TLRdheTXhJ87fAN4jUBLNQGqh2kd62ZI7xG/slfw5xpU7O34Q5nXIblr?=
 =?us-ascii?Q?ms4q/1Ca/GDoz/0q+3pVOHPn2EhaDCmrpfh1ohzjn76o9PZ2tgZoEWgST56V?=
 =?us-ascii?Q?rO2biU8qh6NQkm0YkoRnuy54nMPglyd9RG/ehFI8HK8/WMB8fNpwdY5iIiW3?=
 =?us-ascii?Q?byAFlJ+TTShErbl2VQgp/emavMVBXygKO9YslbcgxTEYvRQBami8wTvIjUs5?=
 =?us-ascii?Q?Akei35HGdT7fCVqgOisBgWoU2aBHMutv3ov89lPj9ZwYMLkTnHK7R0o3nDmv?=
 =?us-ascii?Q?MmVwAwCRUunqV+4oiF6oee25zjH7GkRPWCdH0EBcRnAqC42VxRLlvOr0Md0f?=
 =?us-ascii?Q?gDSITJSqFNYIi5mNbyufb25cy5BhDVUTLxRJyEqj12R+ZrQR1nOEnVldgehq?=
 =?us-ascii?Q?jiBaLigL4NxR3rLVloU7RgBAIk5IM4xwZfUbNIpNva2EDoKKvja4PplxazEg?=
 =?us-ascii?Q?kvkNJP9mTCHnWnLzylyZybeATriMvjXfvUEtpOg1t5Zn2FXxnTWU/QSqgL4k?=
 =?us-ascii?Q?9ao2VVDuYQ4j9jTGkoo5tvOhwr2wlwgnNRi0OX8tXuK17ruDyy6/GNTUIm/v?=
 =?us-ascii?Q?jEpIxvRYgSR56XoyZDdpyexca+T+FrkynGB2rGBeRwUXh/IqfrJqO6MDIbWT?=
 =?us-ascii?Q?KBbCNRRfzy5kpaRkIBSLxKuEJ0ax4IuZoZQwhF6tw9QWBRtA43pfauUpBdIo?=
 =?us-ascii?Q?q5F1GeZi6iAmd8ENnKPYcGzMjya39yovNfBpUJPNpZIXIQy/GxGHUWvmdIzB?=
 =?us-ascii?Q?MlGyje5R8MDF5a7inZ1NTvhYpw4t+1WOCQlpoUWH1jqLzuD/i+ok/TfCVfU6?=
 =?us-ascii?Q?/3F7SEOm0/mMYOo1isIP1UYhI8ztd/K7nE2V3GXh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nojlftzeWQ+lVrg7emIIymxgt43OEtiTv9IzihPjCMjLIwawarRj5fvJm2S6UqDyoHdzuFLLqsBJu4SSD8oLs0P5Z5RfyrWG2MY3WLHt9VT/qx5HvoxCG11Z+k2CKBaQ89iPPCL8W83HMnfng9+4LytLGT/fq3hcyEdRfGY5O58j9VfNXIeEOJOznuzVFRl1V7+xzKBSvFVvFImmVzjncPDV7y4isINOAhinFuw8A5usqOaKxMPx/U7WPPM2WO1D+0ah6JiRQ39/Dw0hhFbRHr5iWMNFMv1Gl20+/rXydYoHV1bYhgKA06vgJMyngozfbeyeZmQI1Yieq2+iD64+wW4xsiiltQZgdr3K/uZkn0KNr7gBcpywcrMnCUFjK9MedJjk3AaNnTon34E97HSBnclJLCmiJe4XyQT1hCLlt0Ue665jf1mkYxsf6zYm+EhJmBeUzwpUvCMiUjm1i1h2nz4kNfhkyQe59R9XzZ2J3NkrhtJ1yS1YMK0HIfsK64jfwXraTjxam83NQTrmj+emG8KRM/cVWgGUILF6hEfR/Rb/r7/z8rdGW5vwGcE33tMZQhQ0PLz50Y6jIuBjFg4njumVTXOnK8Nwp2mFEgdPAkE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72ba033-22d2-4afd-b223-08dc2cc9db93
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 19:27:46.4809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6erKPuNeS/qays0kpOPV9MFtoSEwzRXtwcvrrj5HTMsxI09UXMoEJx6mgnnT09PxmvE+L4bvxdBJY0kaDMIQfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4175
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_12,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=588 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130154
X-Proofpoint-ORIG-GUID: hU8lx9lr3KrU-wFsEH6MM9O3W3xuOMLq
X-Proofpoint-GUID: hU8lx9lr3KrU-wFsEH6MM9O3W3xuOMLq

* Lokesh Gidra <lokeshgidra@google.com> [240213 14:18]:
...

> > > We could use something like uffd_prepare(), uffd_complete() but I
> > > thought of those names rather late in the cycle, but I've already caused
> > > many iterations of this patch set and that clean up didn't seem as vital
> > > as simplicity and clarity of the locking code.
> 
> I anyway have to send another version to fix the error handling that
> you reported earlier. I can take care of this in that version.
> 
> mfill_atomic...() functions (annoyingly) have to sometimes unlock and
> relock. Using prepare/complete in that context seems incompatible.
> 
> >
> > Maybe lock_vma_for_uffd()/unlock_vma_for_uffd()? Whatever name is
> > better I'm fine with it but all these #ifdef's sprinkled around don't
> > contribute to the readability.
> 
> I'll wait for an agreement on this because I too don't like using so
> many ifdef's either.
> 
> Since these functions are supposed to have prototype depending on
> mfill/move, how about the following names:
> 
> uffd_lock_mfill_vma()/uffd_unlock_mfill_vma()
> uffd_lock_move_vmas()/uffd_unlock_move_vmas()
> 
> Of course, I'm open to other suggestions as well.
> 

I'm happy with those if you remove the vma/vmas from the name.

