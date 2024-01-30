Return-Path: <linux-fsdevel+bounces-9478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1FD8419C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 03:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F5F1F22F1F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 02:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB6B37708;
	Tue, 30 Jan 2024 02:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gNOHvh95";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CBz9Le2R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABFC374F2;
	Tue, 30 Jan 2024 02:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706583535; cv=fail; b=TGr2j1ctibQMegF5s4cvSt+HvcG33MaIpy6W+NLP6rUqR456oJIVNKTxleQRC65TfEy1ziF5f05STuwPZUBf0H69PyBto8cAeQQr4Ss/WPm5YAZg9Htm7DeDxRJwpVcfxCpCZSCbsTGjeMR8QcgfJgb/UBiHr5TEGR6kQDld7s8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706583535; c=relaxed/simple;
	bh=iWVR94tXgsvhc67LaxwU6pjceLZglg0Lwy0yvr1qF4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VMFiA3m0/+cdrxBEEFb0bqFRgrM/Ph5HSlDgNAAoj18OVZg27KnJt5t3vOIwyHuSvOtljBqTkWWSXiuJAA09iY6d+bjx2wQDWkvhaeFPluXfrXPgg2UXe+Ju05AOjm7Bwf0fA9qtE5MZ6PL/tdcUAiG9nZq/hFTOyoJx06/PBU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gNOHvh95; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CBz9Le2R; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi4Rt021752;
	Tue, 30 Jan 2024 02:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=Z1RLdTTChRgTNiaEvr8D5e/7DRVIbZLKMpzwprc8FnY=;
 b=gNOHvh95u9iJZ8+SFln0hrLFsdrHeoPvmuOexgC0Ybi30FKzuMv/T8q1xpmQhAtPUNQ/
 VEFSQX6+DJcog/P7KDjKwPiuQX6JkAi/6xeKy8ueO5C3uXP9Yg/763P6OadqsspumSwr
 FQXIxpZZxwkYsvBKfJlt/dpnO2gJDcgDX07xxDmdy5fVt2R3tLfWjb8Ka5qN4unUmNda
 hEqIIjcLBd9gFhvS9WuceKapJkTjS2EtMX5y8seJXXIZBdrOY8DkL/7iaOLXajKDao/F
 bolvWPdpOwcjzNzs90MnHPblXi/0yfVc/ssGUSOIZILN2BnR42Lnqvt9eq2bI5gupIwv ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2dmcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:58:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U1XIeg031388;
	Tue, 30 Jan 2024 02:58:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96rpm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 02:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD3P9nZ8v9WxYHIpX0t9kJKmLPQXDJ6B3IviaToGL3x9fHXdlXNUkMAXf206X0/73kuJuzfsVFCj4Dmliqq0g30UyCsyaOab/myDQoJEkGlU1At4QQ8HUL5JHL5xML8qjyF2CxKIlLxHmXUIvxoF70JuLGV21vSlPlVKNdGSlzsV0Zv9I8yK/F5gz9ly9LhYcut9MxpBglPzvtpi7nTv014WpjPbF6qHhVrfgGJtqNJ+52r74zuO09QAiLRiaNdPVM/od2LE622E1D3DRq86xxALxRs6s1WR+lUQIkOarhDSts8tXSezWTuf59brfBgT0nw38PBnG0qzjs+n0sT1dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1RLdTTChRgTNiaEvr8D5e/7DRVIbZLKMpzwprc8FnY=;
 b=fZ4HnvL700welKf8J3lwuQy2o9+OnfnJyvRAPWauQp5PabTV+BkZIjF26jaNMBUhdmCpvF4jyCOvj/f47ZWMzVuxWQXB6U03KUw6vwzGjqLkRjC7UTiIuuAA40hDCJYG2LHTrbiuyK+tJNVrv5ZBf0/Y9M39gasGbQHPyUMPzhn1Wkj8+o+foQ46niEJOfgqKGH8A88EyNpDra3Zshm6yTKCpZoEfWo8GjfcGfM/Pi7HFKuGS5KP6F3e6XMaFjxSJKf1sSa61da5ierI8XaqvFkh32TdsnYkL6z2SWLAsspgsUEyaF52ieKnOOkvuxmi+YtJw+4SmFNtDMSR1CvXhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1RLdTTChRgTNiaEvr8D5e/7DRVIbZLKMpzwprc8FnY=;
 b=CBz9Le2Ru5ug0IlNr0Hnm50VX3AG/i6y2k+pUCf3xkuDDz0kHqg+Hxpxs6oqaVFEmgvNVlZ4e6wJmOxX/Bf07au5uuUpZ+w+zpv2ynIO27K2r0zk67sv0kkmsR00fIsSf7tNdfoUWN11fDEZDfvYc7EtDNdseIHt9p8t3aqqKb8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ2PR10MB7788.namprd10.prod.outlook.com (2603:10b6:a03:568::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 02:58:06 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 02:58:06 +0000
Date: Mon, 29 Jan 2024 21:58:03 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
        david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
        willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
        ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240130025803.2go3xekza5qubxgz@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com,
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com,
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com,
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-4-lokeshgidra@google.com>
 <20240129203626.uq5tdic4z5qua5qy@revolver>
 <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ2PR10MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dea0c18-ba21-4b0b-53df-08dc213f4848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CmW213zzbhiswKyDjWZg1D0mH5mrPfn5u6uE9FNWk4xXmdaMYU4rT8V9Cd+CT2XpyqyKiHSGHlZlPklgYtpvxnwV0+HinOjLxmFsOoznm55diFLE+2401i2+McIy7WE2PL+pb+utbbDgb/bmtIRSFvonXs9e5DjZTulSG9wf2j2mqKdC8s/vbESGSl+DbU7AZqLYLzkC+ObFcddrtcb/k85+miz2xI5Y2e8Z/Q3ZFrTlJfOIaHL/N1hK9bI7g6D+VZv7iN6q2hyus3JsZIMlSeHdml+7LbDRVwkUQ8zLie6+ZBSxaU5NbY32+6CGyBNSVdEQI4FvWzECac9jjiuKXAwePUxxo1q0KGEEPi8qDMN8ii4xY216PqIdIelkTBsZlAuriQEQPWx1GnoC2ouUlRiuOUm4/QmLJSaNdH0OzjsYmcIWS+28SZhFIlARgeRJpEd01foNC39x193kQWn5Z3zEU1xmsUBMMMHjljofmVrV1fjvHXwHDdavImcSn8vAzgOdOeS2PL7Yf3PlTIQd4/6sPc3l6pelzsVRJKUVR4+Q/kkuJ190ZQOX6CcxolxV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(33716001)(1076003)(9686003)(26005)(2906002)(38100700002)(5660300002)(8936002)(4326008)(8676002)(41300700001)(66556008)(6486002)(30864003)(7416002)(6666004)(6506007)(478600001)(6916009)(316002)(6512007)(66476007)(66946007)(53546011)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SDE1VDl0NWlFV1krQktWVVNxcVh0dmQwRkZ6VVJHV05BVTMvS1JmMmEreUgr?=
 =?utf-8?B?QVBKTFVZQU9tRkdzN0pwdGQrZFgveWJKNkRGcUFWbHBPVU4vWGZnc3p4TlNM?=
 =?utf-8?B?VURELzNXK0hKSnhOYWRJRFpxOERkMHFMK1RpZ3huTys4S2h2bVNBUHJlNVlD?=
 =?utf-8?B?aTF1T01xcEpnOFNSbGFPTDc5bzVLOFRDc28zdXg0ZEl0T3BvNkltcUhEVXE5?=
 =?utf-8?B?b0ZxSWQ1U2JnY3BHbWR1N2Nkd0EzSTJBVEIvRHE0MGFmYnJwaDZLcy9hdDda?=
 =?utf-8?B?RGVCM3VJRGVxWVUrWlN0ekZlcDF5QUdiRzZPYVF6bkppWUo1aVFNM1dNMDR6?=
 =?utf-8?B?Zm5qS2N4OWRmdURvZHFuaWhhVTQ2R1FQSnUxTWtHUUo5NXY2RVlLTEFzNUpa?=
 =?utf-8?B?QlBpMGg2RnpvRlh1RXVCNE9yZ2NvdjZ4cjllaFNqdTlPbHBRUEZFNFpmWlpR?=
 =?utf-8?B?U2RPb3hHNUFxcGc3SlBRK3lsQ1ljSUNJcXA4cm9HOHZneVVoZkZ1UEhST091?=
 =?utf-8?B?RDhVMW05L1IvWU96cDM1bXVxUTJ1cUhxeDdCTDhrUFJGSGd3OEIvWWx5Q3hq?=
 =?utf-8?B?MmdnVUV1QlVsS0FiTFZjUk9hRWhoNVZLN1BBZDNZeXd5dEJzZGVHZmRUczdz?=
 =?utf-8?B?Y1FsZFF4WmxRMXVVNlJTcndpVjZTV0FOOEQvNVVjSjB3QzJnVjc4RUh1clBR?=
 =?utf-8?B?a0ZtZDNEcXhyZ0xKQXk3RUhmaFU4Y3JUNnhaTDRoVWtValdyZzRuc3B4eWNq?=
 =?utf-8?B?M1Z6aEFPSGhOMDVLRHREcWEyTzZmTDdyWEE1KzJjYWtCanJnbDQxTTNodEhD?=
 =?utf-8?B?a3dXRlFrWHRLYyt1cURialZoQ0ltUWQxZWFBVG1nbFUwK0JsNC9QdXJRemFV?=
 =?utf-8?B?RWgzR2ppeEFiVGRBWk9OUzNmYkVrT21mb3FpTUpCbjd2ZGV0YmhFdzFHcjUz?=
 =?utf-8?B?NGE3N2dxa3l1MDEybDJQVnhTeEFaa0ZJbldNT3lDQnAybEVESkNiWlRoN2xY?=
 =?utf-8?B?NEhUSTdtTy9IQW9YNzdwc0w0OWFmUUp6djR0cXBDTUYxNXgxZStyZEpPTTNP?=
 =?utf-8?B?UWxWcXA0K2NIazNxUFBwUXdKcmg2M2ZOb2h0b0t4SVpyMHZ5Mm1rYnNzUFl6?=
 =?utf-8?B?UVFwNzNKVWtNV21SWVNsMHZOcHFCU1NJN09INTZoUUV3M2lyL1g2Mnh4ZjJP?=
 =?utf-8?B?RW5QeDN4dmpMaXFtZ3o2N3JTc0pMeFRlWFdMT2JsZHVOQy9EVmdhbitLTmVj?=
 =?utf-8?B?WktSVVlvcnRGdVlBVktBMzkxMjRkQ1d0SjU2UTd3RGpmSm9YOVFPemdCaTdT?=
 =?utf-8?B?a1QzTWtMMFk5T3YxVGg3eTFtZEZYcktlQjlpZFF1STM5aktJYTV2Z3Y3WXAz?=
 =?utf-8?B?ck4zVThXZUR3NTJMUWhXNFJEd0wrTVgzYlhZMUdYVEZWSnNhQlVPcFJOSHJt?=
 =?utf-8?B?R3dBbU5PRXpaZ1JaSG5XdWx4YXhKVEpYNGpaK3ZER1VRYWhGZ2Mwd1pmczQr?=
 =?utf-8?B?R3UyaUpGR2ttMm9nZjlJdmNLQnZJZ1Q1RStrSmorT3Q5QkdRcXczODlyYmp6?=
 =?utf-8?B?UEcwREM0cXpLMXNiazUvZkd6YVMxL3Z2WUZHK0lUZEI3QmF2aGNLbCsva0pi?=
 =?utf-8?B?Z0NGZjZLYjRhajhLZWZCYUNkb3o0REs3OUpZaTFReDBjOXVEV2hIeEpseXJy?=
 =?utf-8?B?R2ZMR3NhMWJ6K2R0VWdEaVl1NXdCcS80S2gzbkZRWjhwdHBOaUpWTldnaE9N?=
 =?utf-8?B?aXR1aUV1OVlITHE5Qk5VelNkcEg3MTA0Z0pySkx0MG85TU5zNHlaNFpndWNw?=
 =?utf-8?B?YXJ5RzJGQVdrTnZuQVBjeXZVZlZYK0NBTFFpOFZxOERXV1ViV0tabGk5MGkz?=
 =?utf-8?B?YWhBWjl1L2hkQkdJWTJwVkZSOTFOMXdzd0xzVkhIMVcvMjFWMGNtTENBY0ZN?=
 =?utf-8?B?bW4zenk3SGJqRm1rQTFUbVNBVzdYYVdJSWwzYkhNaGlMV3EvNmMvc2ZXVXBX?=
 =?utf-8?B?amVPampRdWZjTllVWW1VS2dla0F0NUdIYUZUSlpBN1poRmVsZ0ducU0yTlc3?=
 =?utf-8?B?THFvU0E0U0pLeVdCcXl0TEg5YmkrNG05Ylcwc3RieVMzbTVDME11bUlrMFVH?=
 =?utf-8?Q?KbgIsM11cd1O5/7nLpB+7YNDM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YeAIu2TSvcAPslLFNoSafNOBO+m/IoSl6yBr//DtEEKSmeRF+PD1iWfXWSkUmU1xsMnyDsOmIoNctH6fk4fhuGqnRSnrAy15Bfgb4LcweKjkgPljmwc/GBYEnsiGEI5kSjln5DU5PHxC+zsS4KXkr5IQ5dJ1IgwLQpO32ZydMWnbGF/1RH76HCQkVuLEADJ9AMv8iXKxA6jpXfOf2DSBWz3z3JeyYx1E9oVeDCTMoIV9ZV7AXpSJWRoWjJ/07i+irosofIwiXK2xb8QbjDy5olINfDLybTSiGzyFWT0aQi6pKVjDbDRBwwhNpUQ4bLlm/vT+hWDWLP7AiDecJGkhfOVOkwnf5y95sxnsKYVzUPurJg7N/ah1vCruZZHCCEZeFdZbF2l0ekVQQXUMcmPNtdSEddI7KbeXVVufR3rA4TN1RF1m4fgGI48fTjHl18zHvz6l2nWf9TG60nTljX8DkgjopHC8AiHaq1gughSkit0WkPsipf9opIIfIgPfi65idXtTCQfx4w7vjeBnIjx+BO1AvfC66k4khgZkUuYGslie4Ijk140yW3J1qHys1DXscGua0hDyIF6R+XW1CEKtRhV39C8JfR6lSWX68ZU6bBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dea0c18-ba21-4b0b-53df-08dc213f4848
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 02:58:06.0265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXOO79Y3+gdHpVFSEht5w8Nh7XR6djDY9byMLSGE0kj5+1HkgHTGJOi2Ta/Abn/EdDijphRnURGl+Cjo+5LppA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300020
X-Proofpoint-GUID: 2gjHSn5FnmSjL9gJ-CLiZCUH9eJNtLpC
X-Proofpoint-ORIG-GUID: 2gjHSn5FnmSjL9gJ-CLiZCUH9eJNtLpC

* Lokesh Gidra <lokeshgidra@google.com> [240129 19:28]:
> On Mon, Jan 29, 2024 at 12:53=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> >

...

>=20
> Thanks for informing. So vma_lookup() returns the vma for any address
> within [vma->vm_start, vma->vm_end)?

No.  It returns the vma that contains the address passed.  If there
isn't one, you will get NULL.  This is why the range check is not
needed.

find_vma() walks to the address passed and if it is NULL, it returns a
vma that has a higher start address than the one passed (or, rarely NULL
if it runs off the edge).

> > > If you want to search upwards from dst_start for a VMA then you shoul=
d
> > > move the range check below into this brace.
> > >
> > > > +     }
> > > > +
> > > >       /*
> > > >        * Make sure that the dst range is both valid and fully withi=
n a
> > > >        * single existing vma.
> > > >        */
> > > > -     struct vm_area_struct *dst_vma;
> > > > -
> > > > -     dst_vma =3D find_vma(dst_mm, dst_start);
> > > >       if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> > > > -             return NULL;
> > > > +             goto unpin;
> > > >
> > > >       /*
> > > >        * Check the vma is registered in uffd, this is required to
> > > > @@ -40,9 +59,13 @@ struct vm_area_struct *find_dst_vma(struct mm_st=
ruct *dst_mm,
> > > >        * time.
> > > >        */
> > > >       if (!dst_vma->vm_userfaultfd_ctx.ctx)
> > > > -             return NULL;
> > > > +             goto unpin;
> > > >
> > > >       return dst_vma;
> > > > +
> > > > +unpin:
> > > > +     unpin_vma(dst_mm, dst_vma, mmap_locked);
> > > > +     return NULL;
> > > >  }
> > > >
> > > >  /* Check if dst_addr is outside of file's size. Must be called wit=
h ptl held. */
> > > > @@ -350,7 +373,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm=
, unsigned long address)
> > > >  #ifdef CONFIG_HUGETLB_PAGE
> > > >  /*
> > > >   * mfill_atomic processing for HUGETLB vmas.  Note that this routi=
ne is
> > > > - * called with mmap_lock held, it will release mmap_lock before re=
turning.
> > > > + * called with either vma-lock or mmap_lock held, it will release =
the lock
> > > > + * before returning.
> > > >   */
> > > >  static __always_inline ssize_t mfill_atomic_hugetlb(
> > > >                                             struct userfaultfd_ctx =
*ctx,
> > > > @@ -358,7 +382,8 @@ static __always_inline ssize_t mfill_atomic_hug=
etlb(
> > > >                                             unsigned long dst_start=
,
> > > >                                             unsigned long src_start=
,
> > > >                                             unsigned long len,
> > > > -                                           uffd_flags_t flags)
> > > > +                                           uffd_flags_t flags,
> > > > +                                           bool *mmap_locked)
> > > >  {
> > > >       struct mm_struct *dst_mm =3D dst_vma->vm_mm;
> > > >       int vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > > @@ -380,7 +405,7 @@ static __always_inline ssize_t mfill_atomic_hug=
etlb(
> > > >        */
> > > >       if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
> > > >               up_read(&ctx->map_changing_lock);
> > > > -             mmap_read_unlock(dst_mm);
> > > > +             unpin_vma(dst_mm, dst_vma, mmap_locked);
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > @@ -404,12 +429,25 @@ static __always_inline ssize_t mfill_atomic_h=
ugetlb(
> > > >        */
> > > >       if (!dst_vma) {
> > > >               err =3D -ENOENT;
> > > > -             dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > -             if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
> > > > -                     goto out_unlock;
> > > > +             dst_vma =3D find_and_pin_dst_vma(dst_mm, dst_start,
> > > > +                                            len, mmap_locked);
> > > > +             if (!dst_vma)
> > > > +                     goto out;
> > > > +             if (!is_vm_hugetlb_page(dst_vma))
> > > > +                     goto out_unlock_vma;
> > > >
> > > >               err =3D -EINVAL;
> > > >               if (vma_hpagesize !=3D vma_kernel_pagesize(dst_vma))
> > > > +                     goto out_unlock_vma;
> > > > +
> > > > +             /*
> > > > +              * If memory mappings are changing because of non-coo=
perative
> > > > +              * operation (e.g. mremap) running in parallel, bail =
out and
> > > > +              * request the user to retry later
> > > > +              */
> > > > +             down_read(&ctx->map_changing_lock);
> > > > +             err =3D -EAGAIN;
> > > > +             if (atomic_read(&ctx->mmap_changing))
> > > >                       goto out_unlock;
> > > >
> > > >               vm_shared =3D dst_vma->vm_flags & VM_SHARED;
> > > > @@ -465,7 +503,7 @@ static __always_inline ssize_t mfill_atomic_hug=
etlb(
> > > >
> > > >               if (unlikely(err =3D=3D -ENOENT)) {
> > > >                       up_read(&ctx->map_changing_lock);
> > > > -                     mmap_read_unlock(dst_mm);
> > > > +                     unpin_vma(dst_mm, dst_vma, mmap_locked);
> > > >                       BUG_ON(!folio);
> > > >
> > > >                       err =3D copy_folio_from_user(folio,
> > > > @@ -474,17 +512,6 @@ static __always_inline ssize_t mfill_atomic_hu=
getlb(
> > > >                               err =3D -EFAULT;
> > > >                               goto out;
> > > >                       }
> > > > -                     mmap_read_lock(dst_mm);
> > > > -                     down_read(&ctx->map_changing_lock);
> > > > -                     /*
> > > > -                      * If memory mappings are changing because of=
 non-cooperative
> > > > -                      * operation (e.g. mremap) running in paralle=
l, bail out and
> > > > -                      * request the user to retry later
> > > > -                      */
> > > > -                     if (atomic_read(ctx->mmap_changing)) {
> > > > -                             err =3D -EAGAIN;
> > > > -                             break;
> > > > -                     }
> > >
> > > ... Okay, this is where things get confusing.
> > >
> > > How about this: Don't do this locking/boolean dance.
> > >
> > > Instead, do something like this:
> > > In mm/memory.c, below lock_vma_under_rcu(), but something like this
> > >
> > > struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > >         unsigned long addr))    /* or some better name.. */
> > > {
> > >         struct vm_area_struct *vma;
> > >
> > >         vma =3D lock_vma_under_rcu(mm, addr);
> > >
> > >         if (vma)
> > >                 return vma;
> > >
> > >         mmap_read_lock(mm);
> > >         vma =3D lookup_vma(mm, addr);
> > >         if (vma)
> > >                 vma_start_read(vma); /* Won't fail */
> >
> > Please don't assume vma_start_read() won't fail even when you have
> > mmap_read_lock(). See the comment in vma_start_read() about the
> > possibility of an overflow producing false negatives.
> >
> > >
> > >         mmap_read_unlock(mm);
> > >         return vma;
> > > }
> > >
> > > Now, we know we have a vma that's vma locked if there is a vma.  The =
vma
> > > won't go away - you have it locked.  The mmap lock is held for even
> > > less time for your worse case, and the code gets easier to follow.
>=20
> Your suggestion is definitely simpler and easier to follow, but due to
> the overflow situation that Suren pointed out, I would still need to
> keep the locking/boolean dance, no? IIUC, even if I were to return
> EAGAIN to the userspace, there is no guarantee that subsequent ioctls
> on the same vma will succeed due to the same overflow, until someone
> acquires and releases mmap_lock in write-mode.
> Also, sometimes it seems insufficient whether we managed to lock vma
> or not. For instance, lock_vma_under_rcu() checks if anon_vma (for
> anonymous vma) exists. If not then it bails out.
> So it seems to me that we have to provide some fall back in
> userfaultfd operations which executes with mmap_lock in read-mode.

Fair enough, what if we didn't use the sequence number and just locked
the vma directly?

/* This will wait on the vma lock, so once we return it's locked */
void vma_aquire_read_lock(struct vm_area_struct *vma)
{
	mmap_assert_locked(vma->vm_mm);
	down_read(&vma->vm_lock->lock);
}

struct vm_area_struct *lock_vma(struct mm_struct *mm,
        unsigned long addr))    /* or some better name.. */
{
        struct vm_area_struct *vma;

        vma =3D lock_vma_under_rcu(mm, addr);
        if (vma)
                return vma;

        mmap_read_lock(mm);
	/* mm sequence cannot change, no mm writers anyways.
	 * find_mergeable_anon_vma is only a concern in the page fault
	 * path
	 * start/end won't change under the mmap_lock
	 * vma won't become detached as we have the mmap_lock in read
	 * We are now sure no writes will change the VMA
	 * So let's make sure no other context is isolating the vma
	 */
        vma =3D lookup_vma(mm, addr);
        if (vma)
                vma_aquire_read_lock(vma);

        mmap_read_unlock(mm);
        return vma;
}

I'm betting that avoiding the mmap_lock most of the time is good, but
then holding it just to lock the vma will have extremely rare collisions
- and they will be short lived.

This would allow us to simplify your code.

> > >
> > > Once you are done with the vma do a vma_end_read(vma).  Don't forget =
to
> > > do this!
> > >
> > > Now the comment above such a function should state that the vma needs=
 to
> > > be vma_end_read(vma), or that could go undetected..  It might be wort=
h
> > > adding a unlock_vma() counterpart to vma_end_read(vma) even.
> >
> > Locking VMA while holding mmap_read_lock is an interesting usage
> > pattern I haven't seen yet. I think this should work quite well!
> >
> > >
> > >
> > > >
> > > >                       dst_vma =3D NULL;
> > > >                       goto retry;
> > > > @@ -505,7 +532,8 @@ static __always_inline ssize_t mfill_atomic_hug=
etlb(
> > > >
> > > >  out_unlock:
> > > >       up_read(&ctx->map_changing_lock);
> > > > -     mmap_read_unlock(dst_mm);
> > > > +out_unlock_vma:
> > > > +     unpin_vma(dst_mm, dst_vma, mmap_locked);
> > > >  out:
> > > >       if (folio)
> > > >               folio_put(folio);
> > > > @@ -521,7 +549,8 @@ extern ssize_t mfill_atomic_hugetlb(struct user=
faultfd_ctx *ctx,
> > > >                                   unsigned long dst_start,
> > > >                                   unsigned long src_start,
> > > >                                   unsigned long len,
> > > > -                                 uffd_flags_t flags);
> > > > +                                 uffd_flags_t flags,
> > > > +                                 bool *mmap_locked);
> > >
> > > Just a thought, tabbing in twice for each argument would make this mo=
re
> > > compact.
> > >
> > >
> > > >  #endif /* CONFIG_HUGETLB_PAGE */
> > > >
> > > >  static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
> > > > @@ -581,6 +610,7 @@ static __always_inline ssize_t mfill_atomic(str=
uct userfaultfd_ctx *ctx,
> > > >       unsigned long src_addr, dst_addr;
> > > >       long copied;
> > > >       struct folio *folio;
> > > > +     bool mmap_locked =3D false;
> > > >
> > > >       /*
> > > >        * Sanitize the command parameters:
> > > > @@ -597,7 +627,14 @@ static __always_inline ssize_t mfill_atomic(st=
ruct userfaultfd_ctx *ctx,
> > > >       copied =3D 0;
> > > >       folio =3D NULL;
> > > >  retry:
> > > > -     mmap_read_lock(dst_mm);
> > > > +     /*
> > > > +      * Make sure the vma is not shared, that the dst range is
> > > > +      * both valid and fully within a single existing vma.
> > > > +      */
> > > > +     err =3D -ENOENT;
> > > > +     dst_vma =3D find_and_pin_dst_vma(dst_mm, dst_start, len, &mma=
p_locked);
> > > > +     if (!dst_vma)
> > > > +             goto out;
> > > >
> > > >       /*
> > > >        * If memory mappings are changing because of non-cooperative
> > > > @@ -609,15 +646,6 @@ static __always_inline ssize_t mfill_atomic(st=
ruct userfaultfd_ctx *ctx,
> > > >       if (atomic_read(&ctx->mmap_changing))
> > > >               goto out_unlock;
> > > >
> > > > -     /*
> > > > -      * Make sure the vma is not shared, that the dst range is
> > > > -      * both valid and fully within a single existing vma.
> > > > -      */
> > > > -     err =3D -ENOENT;
> > > > -     dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > > -     if (!dst_vma)
> > > > -             goto out_unlock;
> > > > -
> > > >       err =3D -EINVAL;
> > > >       /*
> > > >        * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_=
SHARED but
> > > > @@ -638,8 +666,8 @@ static __always_inline ssize_t mfill_atomic(str=
uct userfaultfd_ctx *ctx,
> > > >        * If this is a HUGETLB vma, pass off to appropriate routine
> > > >        */
> > > >       if (is_vm_hugetlb_page(dst_vma))
> > > > -             return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
> > > > -                                          src_start, len, flags);
> > > > +             return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,=
 src_start
> > > > +                                          len, flags, &mmap_locked=
);
> > > >
> > > >       if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
> > > >               goto out_unlock;
> > > > @@ -699,7 +727,8 @@ static __always_inline ssize_t mfill_atomic(str=
uct userfaultfd_ctx *ctx,
> > > >                       void *kaddr;
> > > >
> > > >                       up_read(&ctx->map_changing_lock);
> > > > -                     mmap_read_unlock(dst_mm);
> > > > +                     unpin_vma(dst_mm, dst_vma, &mmap_locked);
> > > > +
> > > >                       BUG_ON(!folio);
> > > >
> > > >                       kaddr =3D kmap_local_folio(folio, 0);
> > > > @@ -730,7 +759,7 @@ static __always_inline ssize_t mfill_atomic(str=
uct userfaultfd_ctx *ctx,
> > > >
> > > >  out_unlock:
> > > >       up_read(&ctx->map_changing_lock);
> > > > -     mmap_read_unlock(dst_mm);
> > > > +     unpin_vma(dst_mm, dst_vma, &mmap_locked);
> > > >  out:
> > > >       if (folio)
> > > >               folio_put(folio);
> > > > @@ -1285,8 +1314,6 @@ static int validate_move_areas(struct userfau=
ltfd_ctx *ctx,
> > > >   * @len: length of the virtual memory range
> > > >   * @mode: flags from uffdio_move.mode
> > > >   *
> > > > - * Must be called with mmap_lock held for read.
> > > > - *
> > > >   * move_pages() remaps arbitrary anonymous pages atomically in zer=
o
> > > >   * copy. It only works on non shared anonymous pages because those=
 can
> > > >   * be relocated without generating non linear anon_vmas in the rma=
p
> > > > @@ -1353,15 +1380,16 @@ static int validate_move_areas(struct userf=
aultfd_ctx *ctx,
> > > >   * could be obtained. This is the only additional complexity added=
 to
> > > >   * the rmap code to provide this anonymous page remapping function=
ality.
> > > >   */
> > > > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *=
mm,
> > > > -                unsigned long dst_start, unsigned long src_start,
> > > > -                unsigned long len, __u64 mode)
> > > > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_=
start,
> > > > +                unsigned long src_start, unsigned long len, __u64 =
mode)
> > > >  {
> > > > +     struct mm_struct *mm =3D ctx->mm;
> > > >       struct vm_area_struct *src_vma, *dst_vma;
> > > >       unsigned long src_addr, dst_addr;
> > > >       pmd_t *src_pmd, *dst_pmd;
> > > >       long err =3D -EINVAL;
> > > >       ssize_t moved =3D 0;
> > > > +     bool mmap_locked =3D false;
> > > >
> > > >       /* Sanitize the command parameters. */
> > > >       if (WARN_ON_ONCE(src_start & ~PAGE_MASK) ||
> > > > @@ -1374,28 +1402,52 @@ ssize_t move_pages(struct userfaultfd_ctx *=
ctx, struct mm_struct *mm,
> > > >           WARN_ON_ONCE(dst_start + len <=3D dst_start))
> > > >               goto out;
> > >
> > > Ah, is this safe for rmap?  I think you need to leave this read lock.
> > >
> I didn't fully understand you here.

Sorry, I'm confused on how your locking scheme avoids rmap from trying
to use the VMA with the atomic increment part.

> > > >
> > > > +     dst_vma =3D NULL;
> > > > +     src_vma =3D lock_vma_under_rcu(mm, src_start);
> > > > +     if (src_vma) {
> > > > +             dst_vma =3D lock_vma_under_rcu(mm, dst_start);
> > > > +             if (!dst_vma)
> > > > +                     vma_end_read(src_vma);
> > > > +     }
> > > > +
> > > > +     /* If we failed to lock both VMAs, fall back to mmap_lock */
> > > > +     if (!dst_vma) {
> > > > +             mmap_read_lock(mm);
> > > > +             mmap_locked =3D true;
> > > > +             src_vma =3D find_vma(mm, src_start);
> > > > +             if (!src_vma)
> > > > +                     goto out_unlock_mmap;
> > > > +             dst_vma =3D find_vma(mm, dst_start);
> > >
> > > Again, there is a difference in how find_vma and lock_vam_under_rcu
> > > works.
>=20
> Sure, I'll use vma_lookup() instead of find_vma().

Be sure it fits with what you are doing, I'm not entire sure it's right
to switch.  If it is not right then I don't think you can use
lock_vma_under_rcu() - but we can work around that too.

> > >
> > > > +             if (!dst_vma)
> > > > +                     goto out_unlock_mmap;
> > > > +     }
> > > > +
> > > > +     /* Re-check after taking map_changing_lock */
> > > > +     down_read(&ctx->map_changing_lock);
> > > > +     if (likely(atomic_read(&ctx->mmap_changing))) {
> > > > +             err =3D -EAGAIN;
> > > > +             goto out_unlock;
> > > > +     }
> > > >       /*
> > > >        * Make sure the vma is not shared, that the src and dst rema=
p
> > > >        * ranges are both valid and fully within a single existing
> > > >        * vma.
> > > >        */
> > > > -     src_vma =3D find_vma(mm, src_start);
> > > > -     if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> > > > -             goto out;
> > > > +     if (src_vma->vm_flags & VM_SHARED)
> > > > +             goto out_unlock;
> > > >       if (src_start < src_vma->vm_start ||
> > > >           src_start + len > src_vma->vm_end)
> > > > -             goto out;
> > > > +             goto out_unlock;
> > > >
> > > > -     dst_vma =3D find_vma(mm, dst_start);
> > > > -     if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> > > > -             goto out;
> > > > +     if (dst_vma->vm_flags & VM_SHARED)
> > > > +             goto out_unlock;
> > > >       if (dst_start < dst_vma->vm_start ||
> > > >           dst_start + len > dst_vma->vm_end)
> > > > -             goto out;
> > > > +             goto out_unlock;
> > > >
> > > >       err =3D validate_move_areas(ctx, src_vma, dst_vma);
> > > >       if (err)
> > > > -             goto out;
> > > > +             goto out_unlock;
> > > >
> > > >       for (src_addr =3D src_start, dst_addr =3D dst_start;
> > > >            src_addr < src_start + len;) {
> > > > @@ -1512,6 +1564,15 @@ ssize_t move_pages(struct userfaultfd_ctx *c=
tx, struct mm_struct *mm,
> > > >               moved +=3D step_size;
> > > >       }
> > > >
> > > > +out_unlock:
> > > > +     up_read(&ctx->map_changing_lock);
> > > > +out_unlock_mmap:
> > > > +     if (mmap_locked)
> > > > +             mmap_read_unlock(mm);
> > > > +     else {
> > > > +             vma_end_read(dst_vma);
> > > > +             vma_end_read(src_vma);
> > > > +     }
> > > >  out:
> > > >       VM_WARN_ON(moved < 0);
> > > >       VM_WARN_ON(err > 0);
> > > > --
> > > > 2.43.0.429.g432eaa2c6b-goog
> > > >
> > > >

