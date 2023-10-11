Return-Path: <linux-fsdevel+bounces-84-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB977C5875
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B141C20F1D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD38225CA;
	Wed, 11 Oct 2023 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xdm5WfVo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RzCJMBD5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B6219474;
	Wed, 11 Oct 2023 15:49:25 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC82AB0;
	Wed, 11 Oct 2023 08:49:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BFeR92026964;
	Wed, 11 Oct 2023 15:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=5niBd9r3/RYCTKzjTkCjWxYo3yOjuQ7zMjaahIoqBuY=;
 b=Xdm5WfVoL7k+Tt6F7CNhZWV6XsG4LOG22AIs7tSpP8ZGiGnYS8AGa07XMABjX/obWL1u
 HLyxmo3pi0SmbxN8P9JS71gBhhwv/jxN7Bxsu1c3P6p7AQs0LCqPdCvqmqhTOHlrkSt4
 wkOoHna7+/e+uBnranUIbg+AkH6RFtusA4QISnhIFcdtONGjrOSDKGB1zG+S/+QqaFdT
 msTKfB1y7+n5VORPagJ1RexbOIif0aQzHvEPCJBUzR5qPUydfBd/ojDdNCBfaP+9Mqav
 H/t2599NbIrUzaZ1K5WC+1pZx5zKJ96NuCwbKaHE4zYLKoW8rkMeRP8659msTqHNS+D9 HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvurduw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 15:48:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BF8elL035225;
	Wed, 11 Oct 2023 15:48:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwseh12m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 15:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lr9SITUDDndjlP2fIySF7G7vvjZU3tdFqfkPeLYnqJStB28VWbxbsTlLDs7uva39W8fAj3GOY0ao9c8waRHyvvBgdEVZF3jLffGqLXrOGzKrLiE0tcxsEacr9x9GfdLXDaWppM3Y/Is/gk87ZVUjrb2WecwCvMKuoUyiWGX4AfEKyY8mioBOXaYxWXPiHCq6Fo9hSBXeo2aoUGfP0a21i66j5DGMIp6KgHyD8moO/+Uw5Dv4ax/D6SSbV9PnGqqYdvirIta/KgcXUCv874v+oUQHVdCgcsXcKp+LSqhxmavECmjYyQ3AahOtsddHSuPuRWvQWOK/AIVvcFPqaPJlrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5niBd9r3/RYCTKzjTkCjWxYo3yOjuQ7zMjaahIoqBuY=;
 b=FYvm6ZEXA/Xi3rDAg3bjAfrA44fjPZbcadkrZr28UKvQHO+nfPBLtWVRMuH2LlSj0E6SbyWHJ9Y4sTDsm9fBBZjjp/gvQTgK6uFkdY/iGb5oX556fbmOxkKpYmXWJXQ3UtjaiNvtOXgBCUfDVmkcB8xlOuvpahVtytozkGFQ3e2/aibNiBZI/9h1CizlGGw0iRndlxBG3BjG0KKDIpJYvzFt+jJjznbxFgyRTTCH99PrI3bzvVwdSVqokB1IwrXdbcsFXvhpQwiOOxdfUlHJ3ksXolErCHIm6yK+pgcB9nZpWE3aJCDM3NPEE2jfxIxzTB1toYG2bevT+szEmvmNjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5niBd9r3/RYCTKzjTkCjWxYo3yOjuQ7zMjaahIoqBuY=;
 b=RzCJMBD5CdVsjsis84yc5Kbpe7zJzfM/G51aQAN9BlzbqlDx9tJd6J2CBXy/W0obyf/Nset/ve3NnKZgSLp6OHkEgtv1z3L2OHvpzu3p83qa28sLKJy6lNa8v78JdVLqLgUMnlTPuXUww5PsYgCgGZvvkewi8OzQ8rJ1ZI8T5kM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB7362.namprd10.prod.outlook.com (2603:10b6:8:f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 15:48:16 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 15:48:16 +0000
Date: Wed, 11 Oct 2023 11:48:12 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Subject: Re: [PATCH v4 09/10] maple_tree: Preserve the tree attributes when
 destroying maple tree
Message-ID: <20231011154812.d26o6iqxflbmd2n3@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, corbet@lwn.net,
	akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
	surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com, npiggin@gmail.com,
	peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
 <20231009090320.64565-10-zhangpeng.00@bytedance.com>
 <1632d0e6-2d52-43b1-8a01-056231c0819d@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1632d0e6-2d52-43b1-8a01-056231c0819d@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0214.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: b73d572f-3165-4cdb-cdad-08dbca717bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WXaMvXdN902PFo445alSbG7odpVWrUVy0kI3VrKAt/fiBCFk0ZtMTcEkTdeYbAu624l+F3ofrK2u+bAApeQrdZdjae9v/zJU2GG145lQKhWJ6+Lu4Yu22sWftwDT1YMv/L3sSv05Wr2XbzRMJGyR0vKZIURKnRaxnanLFa32ydeemcOA0Cvj48MmBbEMgnYensyXvPMhWOO1sh7AiOzF5Ntiu7vLzvRJ6vW/y8MHT7O1vs48XeC/0w25xXN7NW7wnCJZfB+Lp/tywwo3Zlu/Ug6AQLzI53rmGaNWO7kiZvlNyQkW94gUh1nUeyGUami/mkxxOpcnn6TM53ClVhkUxj96Ho0e7Z3tF0ubDbCZujOn7JE13tgl6mafYug3X2p/UcJ3Kp0fwXj1zwZ4EthyeIFLlvveLDZi35CN4BpYSDS2pQpE5zZxwUEdfJ2F5MGoIhhKpepgXzsIsKo02R7+qrldX7zcuGQw0xCxOrWlocEw2j2aCBf73+Ffd6DMSUnxxMl/8wgfndtDEU8VI9hdspehIPRstLsFyEifvPz1xRpYOx3dQyijzLus3ygDTZIH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66556008)(66946007)(66476007)(6916009)(316002)(8936002)(4326008)(8676002)(41300700001)(38100700002)(33716001)(5660300002)(7416002)(9686003)(6512007)(2906002)(6486002)(26005)(478600001)(6666004)(86362001)(83380400001)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MkJ6SjR1WjBsTXNQT2oyTmtWS1NNYzV0ZGhsWlYxcXZRc1k1alFEQ2pwUU9z?=
 =?utf-8?B?dEFGY2svcUlFak5tOWU4eTI2SFBsZXBjRElseEd5Q2g1MDNxKzJkUFJBaDdX?=
 =?utf-8?B?YlRVUXNWUjFjeEVqNVdWQXgrVjBkZE40VW9lZVo3SVd5OTNhTzZsdFY0b2h0?=
 =?utf-8?B?M1NuUWUzZHY5ZzliR2FGUzlHbEtLb2x0ZUhxeVIzYzl0TWMwOHFXT3puS3JO?=
 =?utf-8?B?T05RVEV1clB1eWh6cWw3SXVlRlNhbUpWZWpWTHBUajNyd2RzNjVUZWZpK3BI?=
 =?utf-8?B?b0s2dmNtNTltYm1VYUdOUmZSQWRTTmVvTDBjMFFWSkdMRWZYa3lEK2RhaUF6?=
 =?utf-8?B?eFh2TTRCb1hoQjFrWk9sZzFJVVJGV3RaelF6bWFhUmdvVWZZc08xc3Y1NkZI?=
 =?utf-8?B?VEF2NUNjVzdWRUU5NDBGODlnd040U2pZMVB5NlY1bVpWT0d4R1J1bHNjQ1NH?=
 =?utf-8?B?M0xXZ1hUeTRub1JoVzhXMG9hcmEvRk1JeFJLZEYzSUx3bGJjQVF3bWJBa29M?=
 =?utf-8?B?L3FuVnhnK2VjMlRxWitBMG5tK1JnRis1NHlldUl5cnhuU2FqUUlZR2pnRS9t?=
 =?utf-8?B?ZFdjcnFzWW9YMXVTU1luM1NVcm5tMm53c0hHTVNlSkZ2Z0hVNkFnRXVTeU9q?=
 =?utf-8?B?SzlGV0ZXQ015R0ZnV1Y3QXBBUlRoUVQzM3BVVE9yUEpzMkVaVFBIKzZEb3FE?=
 =?utf-8?B?NVdiN2JvdUJPZEoxckkvM0RIbjJZampVeUpHc2grWnVZWnRaU09JOHNWZ2g2?=
 =?utf-8?B?RzdsTmQ1Wk9CNUpRM09MTml4MzF4UkNHUVROaC95Y0REZ3J3VHYyOFYrcWRQ?=
 =?utf-8?B?VHJ4azNtWUJxZENZWCtmWE5wWElqTDJMWTF6ckxUSzFkNHo3YjZaS1lsbmtS?=
 =?utf-8?B?ZHZrSDVuTHhMek5ZYkI4cWxzUHhHdmxnd3RXSG13YU03Z0pWczdmNEIyRkFi?=
 =?utf-8?B?elhFaGx5aTdwU3hjaEtDb2xIdWdXaUIybXhKdnQzUDVUTFYvemtacy9RUHBF?=
 =?utf-8?B?b0hvWU5LOUQ3czh3MnFwUjhoZU5hTFYxNGpOeDJRNUF3YnZvT3BVemo3akZq?=
 =?utf-8?B?Q1F5czFQeHYwYlNweTJWeWNlNDZyRUZER2ZtMzdvWjJsQSs4a0paaHdMOEFM?=
 =?utf-8?B?MTdpYWMyZUxNQU9VU1FVZVZNQWFvVnhOOWszVnNKWk1rajVmc0lnRDV2MlZi?=
 =?utf-8?B?ZHY2Y28vb3lhUDJVa1NHV011NFN4Z3NOaFMvM2ZDN2ZyV0N0L1dkaWpMdWxK?=
 =?utf-8?B?SlBNYWRGTXh0ZitMMnMvZG81bHNOUy9QbWNaQUJuZkdjdkNXd0kvNGo1NnBk?=
 =?utf-8?B?R2tTWEpLWDRMeG1DRFFKdEZCemsvUVB6UjB5Q2lYOWVLWHZtSlRkWWZhd3hp?=
 =?utf-8?B?b3ZBMFRNa3JRMWMyR2tzTUgzalZKT2pyMzdlT2NLUDJ0U0k4Qlg3SEE4TnB1?=
 =?utf-8?B?U2RXa2x5N0FoY284MHJsbS9tdU1mbmhabUg4RjUxZHNmV3h3Wjh3S08zU1pu?=
 =?utf-8?B?ckhJVWFKWWFCUlNpZnI2U3Vwb2p1bDdmdjc5TkVxYzBXbW1YVkNKUnVpejl0?=
 =?utf-8?B?aGl1SjMvb0lrR0EvOVNlbmIwaGNyQVVLamZxaUpheFA3b2VsYlVwc3JaT0dV?=
 =?utf-8?B?eVU5QXUxVDZONzBzdXU0MS9lOEFqV0dzRGYwRGFBZC9QQktIbmQ3d1BzaFNz?=
 =?utf-8?B?RjUxNUk0SHZjZG5sNVpoaC9sY3BkSVMybHRTWDgvbE9RRkwxbkZqTkFnbHhE?=
 =?utf-8?B?TmVYV1ZMYzJxcHgzRmxGZCtNR2p1cXhHL1dFOEdRNmxRUkh3dk1IcFVMYjJ4?=
 =?utf-8?B?cFRSUkI1Z3lXL01uaUd6R2cxYTZXYm5pNERFZXhxOER0RnhnbW4weDcrbjJ0?=
 =?utf-8?B?TmhlM3JhNDVKelg4VXRMR292QWNiQVB5M212K3hSWkh5cklTVWNXaXF6dEFl?=
 =?utf-8?B?L0xPV3d1SjRyMTRLeW10L25xc2xzUUFsQVR2VEFPd0RIVG1DY2xaL1lrZ3ZS?=
 =?utf-8?B?VkdianZ4N3duUlRVeG1tUzM1NG5lZWwxYW9XQm5KTllmT1hvZjg2MUZmTlRH?=
 =?utf-8?B?MWJ1b0JsZUFpZEk3RWlwc2RIMENvb3U1VXgvcmJtandydElBQy8wZnFDZS9U?=
 =?utf-8?B?a0RYbzV2YW5XUkl0L3kyUWZMcURaQ045eTJJWW5wbzdSWkZhRmJNcDZ1V3NQ?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?NFlJS1o4VUJMcTd1K056YnlUbkt3MStNQTJRWEJmWE9MTkxVSWlqTzZjdmFV?=
 =?utf-8?B?YnZaOWkwTlM0anJBTEg3QlIvTktwN3VXdituMzQ5bnRyMGpYMFBlRDJYcEl2?=
 =?utf-8?B?TGI2N2N0d2hzaDlqbjZZYzFLTkFTQjBnRVN6ZzRzUUorMVVzUDVxczhxMi9y?=
 =?utf-8?B?aTN4UVllTEhBNDFpdzJ6S2JQckYxN0NkOHhkY1p5Zy9wZk9xaHU4SmRTS2NP?=
 =?utf-8?B?Rk5mZnBuL2lUL2tkYnhRRU5SU1AwcHNKTjY2MExJWHNBQXZoSk1RWnF3Y240?=
 =?utf-8?B?dkpEeXNjbjh3dHRPVmZmRE5ZSUVtU1krc1lSTkFkdUppZjN6emtRaUtxdWhi?=
 =?utf-8?B?Z1FrZ3VRR2VUbUpjRGoyWFU2SFdpNnRmTUQ0YWpjd1JBUzZndFNNak94WGt0?=
 =?utf-8?B?RjBjamY2N1B4eWd2R09OVmVvSERDSGU5ckhPZVBSaUFTWDVIZU9aUzM5enR3?=
 =?utf-8?B?bGZoV3hNK3JRbytpd2Y1Y1ArUjVjcXNEeDMwZytMNTVpeURxWkNLWkRyZGU4?=
 =?utf-8?B?OEI5dEdkQ0FRVkpYcHhBM0hDd2lsYnJnNyt4ckdsdGViR2c0Z3BheFlKNmRE?=
 =?utf-8?B?ODhHZlRJSmtGcVpJeXRxM0ExcUxoZEc1TzROaC9nd0VCRC9wZTE1OVZOVE5C?=
 =?utf-8?B?UUpwZWkxekFJOEVIeWZ2enFrd3BaVUd1eHBjcys1Y01Xd2J6SXNuT005R2VV?=
 =?utf-8?B?Z0tDb1lMUzJGS3JFUDhYbllKTVJ1ODl2UHgyTWhBZ2tRb0UyY0I1VHozRE1W?=
 =?utf-8?B?M2wzSjFtQzRWMjYvRENsN0RWdU1GMWJGTFNBRVU3NzZFZmdLSG9OMTZ2eUJh?=
 =?utf-8?B?RExKYVFKK3hkckp1cTlNVGZnQVYwYlVjK1VkMVN0eVZUbCtuaW9EM2JKVVk3?=
 =?utf-8?B?VVpTMnNvekNibXJFWDNGR2p2Ny9sYmVvaTlIT0R1VWQ2Yy9sRVlPY2g3Z3Ju?=
 =?utf-8?B?SFlSaFBZOXF6YkFRc3JwQlFYVmd6elRuSmlBelhOeEtPS0U0NFNDcjl2ZGsz?=
 =?utf-8?B?QVJDNXZmWjBiVTI2bjgxTDZDSEhNSDcxM2lWU1Fja1RWRmViOWhsRmNIdEpu?=
 =?utf-8?B?bzdrdjdDWUxYVDFnMlJsT3k0MVFKZDY3UFJKMGM4WUduSUJNbEJkaTZyUGR5?=
 =?utf-8?B?ZUIzS1hma1dpbUUrMlNXSkZkU1JyM2EwV0ptNm83SGxpSmdTR2lYVkpGRVJX?=
 =?utf-8?B?ZVFIdmZyY25uclpVRjNjOHFOVFhuQTBUS01VcnJQeU9iZ1g4ZmRsenE4aU1t?=
 =?utf-8?B?TWJFcnJnTWJPKyttaWlqQUFRR0hHMWZESjRocmsvMFNqMUo4cmVPbW9PR0hR?=
 =?utf-8?B?bys4Z2UrWDVkUXhlTVZlSlVYeCtHQkI5M3FaUTBoWEVrdFlpemE0a0h2N1dT?=
 =?utf-8?B?M3Vpbk5CQlVsUDRzOEV2ellsZTVFZ2htL00ycmJyYzRMT0U2c1VnL0FLcC9u?=
 =?utf-8?B?aytVS1MreWRIVnJpd3BLRTBwYkExcitiWmFyUTJKNzJ6c0VUTUxJMHFEVkdL?=
 =?utf-8?B?RE0rUTZHbmlJZ1MwK0U3bVQxb29EQ1VONmx0UlJwZzJ6Rm9JVmJFMFpXbjRG?=
 =?utf-8?Q?FyU1+xDovdbM95tSA38Nfd41U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73d572f-3165-4cdb-cdad-08dbca717bcd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:48:16.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qobfbTjKGzL0e1nL2+q69t40qJtfBadnMWLbQ8mBRK/uJI2If3dp2nrrTRk/b70+b1VnpmnXNoqmAC9odvInaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7362
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_10,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=972 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110139
X-Proofpoint-ORIG-GUID: ZpuHo3Ii_ITzPvyi5hiv_5lx-RxgKGO-
X-Proofpoint-GUID: ZpuHo3Ii_ITzPvyi5hiv_5lx-RxgKGO-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

* Peng Zhang <zhangpeng.00@bytedance.com> [231011 11:42]:
>=20
>=20
> =E5=9C=A8 2023/10/9 17:03, Peng Zhang =E5=86=99=E9=81=93:
> > When destroying maple tree, preserve its attributes and then turn it
> > into an empty tree. This allows it to be reused without needing to be
> > reinitialized.
> >=20
> > Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> > ---
> >   lib/maple_tree.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index d5544382ff15..1745242092fb 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -6775,7 +6775,7 @@ void __mt_destroy(struct maple_tree *mt)
> >   	if (xa_is_node(root))
> >   		mte_destroy_walk(root, mt);
> > -	mt->ma_flags =3D 0;
> > +	mt->ma_flags =3D mt_attr(mt)If I put everything into exit_mmap() for =
handling, this patch would
> not be necessary. But I think this patch is reasonable as it simply
> deletes all elements without requiring us to reinitialize the tree.
> What do you think?

Willy and I had debated if we should do what you have here a long time
ago.  There was an issue with the next exit_mmap() that would not have
arose with this change, which I was going to make before it was made
unnecessary due to other changes in the caller.

In the strict thinking of a destroy() call, I would expect the flags to
not be spared, but doing this allows for an easy way to clear out a tree
and resuse it as you have said.  I'm happy to keep this patch.


> >   }
> >   EXPORT_SYMBOL_GPL(__mt_destroy);

