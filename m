Return-Path: <linux-fsdevel+bounces-1371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736CF7D9B64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271E72824F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 14:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625E43716A;
	Fri, 27 Oct 2023 14:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CYQeQKTB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d9OHJtTS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6D53B7;
	Fri, 27 Oct 2023 14:28:35 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8AC0;
	Fri, 27 Oct 2023 07:28:33 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDVcRv013407;
	Fri, 27 Oct 2023 14:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=tIlFYfabjIWrVi5yyvmlGLoySh4sBmBUs6zVhQ9jaHU=;
 b=CYQeQKTBrA+hJ0zrDhJ1SGDoHIfb7YzDOHjUcJ27KDYYvsPfL9SNIQ4O2ns9fZ1eD5j4
 Yf5W4edCfSO0BKWghEOGhrqNP9tGpkjF6QvgaZpmRX1zm9PA87+HwVlizBZuD+EcKkND
 Hi2pR5ODtTlHamsVs+9KuR8EZo+9RNHSqs0dLik1HYfRRplK2vSNj9Pn7ORDPbK/RnCQ
 vGPs2+KBKK3/+WLg6zlQKEHTQW5bY3YrBvjEQiEoBrnqi143nNpTCT5n+mYBcJOi64Sr
 1C+Ns0qu725+GCmd1+14UDpRpURTE5SpVXqtdyrYJGVwBq97DKfNzpisJNo8DnT9r+LP pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywuc9ps1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Oct 2023 14:27:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDPOPQ019872;
	Fri, 27 Oct 2023 14:27:25 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqk9tr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Oct 2023 14:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwaerxrMIjyTryGGEn1iA2TTixfVYcaKvCKPG7ajCB290nlRdSX1LE/MMnyNEkUgbk2xb2ugjE0DUW+EOy57BkhJsIZoRoKKoFTBd1U3vL4A45BvAyEaOMNB7YyLzBiz9i7k2dfIzxRSxwg2lAFKU+IWgq+KaUCBZhQ+T2SBIEOaq7rLY6T4Q2K3R0wB2oSG1XBa9K/AFRHaj1z3XUKvYs+Otn2KillM92xcfWzcsMY86CocNfmvuDFPTMhKyFeUpiUj0tI6bgSVI9NdWCxFCIbSJ4xMcHGrrAqraEqjw8N4QYwzUlqe65iA7ZwP+0+kZFNncFjIEqT/xov1z5weOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIlFYfabjIWrVi5yyvmlGLoySh4sBmBUs6zVhQ9jaHU=;
 b=asbgRwqrpYL/X6eT45Oat9ujgCL6kXdNnXzkYPVIm6JLg65RCunCDe1AG4Anc9uS5xQF3h6RBEp0pTIwYNSgP2QvnW0pZeO14svBuzyKTlj6LRkkVthuY927wnR8uBDcz2rr1CgDTHTli2ArzmQA0XE/Qy6HoeBvfqhJn6d+2A1DS/bgYvaA1UMTOQHiWHfn6PtfKH+OyHXzKghuKceu8h5d3n2iUETM1NsWHFJk/Kh6d9b1IJdEvIcdw/Va/qKJY7sX6dDxc70lL6GB60K8uYbOSwQsw75f1mxp+gAlE2QJQOogyHUtCGUVcdmSU0K/41DnD7OZSuaDC4dIMuGx6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIlFYfabjIWrVi5yyvmlGLoySh4sBmBUs6zVhQ9jaHU=;
 b=d9OHJtTS+cBzModw+zI7r+WIhJEHQLB/DvZ7hHcJCyf9FPuT/IFs4IWIvbqLGEsa5i5ciNen4nzALd0rz+vnCsYl0fr67ezS8SNasqHLIoQFNKeVSqDkXfiF3lnyN+wmJTWRCQnSb+yu4KTukl1U3AfjipRaLORL3enGoPSIfLE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4299.namprd10.prod.outlook.com (2603:10b6:5:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 14:27:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Fri, 27 Oct 2023
 14:27:23 +0000
Date: Fri, 27 Oct 2023 10:27:20 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] Introduce __mt_dup() to improve the performance
 of fork()
Message-ID: <20231027142720.vng5tny7xikiklen@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
	akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
	surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com, npiggin@gmail.com,
	peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027033845.90608-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0252.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::24) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a662e3-a8d3-4967-c142-08dbd6f8d60e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bxf72SzvrJx4Ly+3lFhnCptUwUuOG/+dTPYapOT5Y2hCU4hCisNZOEFi4LmcvaSgVi/PIOtzBUhuHck9DrpGasL1592/aNuV3l0RXhNCBUZf1iKul9LIkFbMe2+1lSzAZeVp++qa3mNbzoGKYRXV9gOh0H8dryWT9JkSvVmf99kHhyD5G7L9jJagqk/+V7wNr7+OMJLuwNHMoV3nIsQYx5kltUA9GO0L4emH75e2F1QaaYLG7OC/Eofjfpv4DjsEdvrooGiWVpNpSXtZilUPvz3dOmIPpUVQAQII9Ouz1bpzo6p21cOcht6/H5yIKqIaA1HHh0nfu3J2Q4TzLv9o3NYqM8yfAr2NxPIL2UupqO5I4Cy08E5nt8JdP7pSgHVBv4x0boMzUTrl2nJaz9i0aY15fBXPUuQ36kecmY3WkyWfwqHjHuWYwRnjloJcajyKV+7XHtTNr/6hDwqgta0/4EDHeuwhELZEgMYCx83OjSwQ8Lo0GJhBKBSnSxltYVk6acauHVQ1c+uYI0OKTEezDRTubjEKxtT2mFw1qM1YtAa4x7QFE0IXuW132d+/4HDWGiIqQTVGh5+sQbLOQokRZA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(316002)(41300700001)(2906002)(6506007)(5660300002)(7416002)(8936002)(6916009)(8676002)(4326008)(66556008)(478600001)(6486002)(966005)(33716001)(66946007)(66476007)(6512007)(9686003)(1076003)(26005)(83380400001)(86362001)(38100700002)(40140700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2IaRtMic08cLYH2JXt5liqA9XZmdlIUmhOvTdkvV15Nw2hs0iB+O3jfpA331?=
 =?us-ascii?Q?b+bSfMNAma26QeNIKtRXMsxgQXs8rdie8LlN9b2wsGgzjX7MYgNA6b28sjxg?=
 =?us-ascii?Q?pZYTRTFRBaOJxu9+68BfCfrEyY6j+UF855wPZGU7nnRtiD2ywLQ1S6jSzdJp?=
 =?us-ascii?Q?0O3ZhZ+DGv0dfFFARc4gKzVD3c5frvLg8ig3v6tvOHGXYTA9gT6Y39nB3Zcr?=
 =?us-ascii?Q?hek95aGY1liH/JCGvqoTpZcTqIAq7iBc6Y8k5IxwbxE702thH++Ai2vlfDtB?=
 =?us-ascii?Q?2bBoYcrP6oDL6DT9KnAcd+rgtuQtHnBs7qIRAmHpM2qGbessIgP35rsCPOrK?=
 =?us-ascii?Q?pDP9b6Ir36EcqIXCOXAMx3ffVQ2V44UV5uJbCaEyzhY0ZdZ9Bojz2DJzW8VQ?=
 =?us-ascii?Q?sQnwHqIn5//ZbXcx2Ynpk+OnUcbauigHFb8oXYabyg9yya9Lx3mnZMsdd5va?=
 =?us-ascii?Q?TkVRyEN5kkdb04iFcd3I51yXoc1oAbdphgaQEVWjEt338WoZvPSxByuR9grR?=
 =?us-ascii?Q?rHftVsghJPupjysoEOugTGD49BS7r0MuG6WckeNWOKrrou5MNGclZIA86vw0?=
 =?us-ascii?Q?EjkFzrFnPBP5WTpKX22ASAkavB/G6AsNp4pTrQ+jQ+EoEDSPvRqb1BdQ0z6f?=
 =?us-ascii?Q?F0+3NXjE5T7dTOmEovz6+AsmvajCiCqRmFMjvdLjk9g1O9iIsDSEc8C8LxIl?=
 =?us-ascii?Q?rvCaCrtOJdTak6vZgd+rKT9vv4hQGVGXDwxTyh0jAgWZFwWILCcrRuLKgkm6?=
 =?us-ascii?Q?Tos4+vaHqCVT9CaB9i/ynbS5jtgljcgC/N61debrxQ+Cdl2mxMQ9N8SuRCYQ?=
 =?us-ascii?Q?crAax+16isOZYBktFfKDJ8bouGAvmLwSj77eUEY5r2pYZrw2eElVv+tYyvl0?=
 =?us-ascii?Q?t6bEttUeLvfsQsVBy3qdeBTXUcHSzY+mRD+7+rVPxxWiGZNcC3rKEK2KsoZ3?=
 =?us-ascii?Q?vqTh5bAju/akW9nGEwV7gtgVUhlkO68bLZgJ9xHTGYd++xhbidFg9gd5d6KJ?=
 =?us-ascii?Q?TkP445WSEHnVoNDUZ75i69cqA5e5/0pBmySSMFm2PjQf5FmfvPxqC+4FWSnW?=
 =?us-ascii?Q?Mr01V5oGZc9mAFf5dMpVudwfBQx7I3bNgpyTedMJWJcA5mcv0jRpf3YpDND2?=
 =?us-ascii?Q?NgQfOTUms4vaZTnpGRgYBHT6rWeSpRC5nLOJS5lOY8GZS3W/5IKbLkFUgBlB?=
 =?us-ascii?Q?0ClP5Psx/D7mS509zZdlWdPtWoDqf8M05VcXZeOlWmwh0i8aQyglNM1OgJA3?=
 =?us-ascii?Q?v+k80tipEkVKdFjB1xz9/Akkjsjb6mNNtS+epiD1Ov3kQQzsWXE3S1Ip+vYk?=
 =?us-ascii?Q?ZOpiSyzZO1nD4ZKzmoePCf9Pcu/MvdRjWyusHw1jKE2NvFTBjvGepE5zlgon?=
 =?us-ascii?Q?9L+0CBS4x+52EbW8GZkyH0Eqh9sCZXA4S4frUsUjMoH6MA5ZDedrTaYDl2js?=
 =?us-ascii?Q?dMzObiHVgjbp3XU3aFAnPNSk1X7LiylBhtDhN7XmJgacIIdHFKLVkKmduff2?=
 =?us-ascii?Q?Lz/gny57cl+4YLZoedHv7mUrZ7QA/Hc1Q1ovZLi42R4grsp6lqJdjOev6qXG?=
 =?us-ascii?Q?cVjGmgZUnc5Ucxpe/jJt0jF1ghQzHkv+hZcwNQ7r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?77f1V5ZJME9o47mcrn5iEPRD5SZ/jWFahI4SuqcznyRYUHLkqDuA5V2RbTPq?=
 =?us-ascii?Q?vSF7Fx3iygk8Nq3HLQn7qfQVfRjundMzLa7qWyb2SYZpYYzfUCFceFvy4/qX?=
 =?us-ascii?Q?ODQD36HeC7fWP21bpjePPjjxanFPTJwxZYQwdDF8kiksPUlOVY49EFYNeny/?=
 =?us-ascii?Q?V1IEcWLrh9FZQ8mSmkve+qFVfRP2BV2mQme+ndFXfyB2HjZoyK0b0clDjUZx?=
 =?us-ascii?Q?yFTLVfb9w39ZR9UTHOJ1okIGtgJziJD0gBZTMWdz/16uME3zgsqCBCPkMr3P?=
 =?us-ascii?Q?h2/E22kjHXCH9N6AxFunSXklo8y7YT+WOilNBi58BlKtj23cMTR+Xly7atJg?=
 =?us-ascii?Q?LhFxFsMBsfnLFuIj8Nmd6s3XxnOeY6BnSuOUJklirn79rxnAD/uKCwDZgxLZ?=
 =?us-ascii?Q?ukPPlErIHjnFUNYQFrBrQ16bkQy9TmZzEMVNcAQckfQK7P4p0utbwWLqWqp4?=
 =?us-ascii?Q?QmZT7SkHjioxRrKlwY9Mt95YDHiwRZhvIhd6W0B6EzARyzgpwqupqdSID+na?=
 =?us-ascii?Q?bqclD6JrnNTcWoTypSkRktZb2mb4SrBN2plb+MxeO03JXERNn9oUGfK+KRn+?=
 =?us-ascii?Q?/OvRWDUf9r1wloCr/Hvy9u2RjcJ4ALMIGE+N5gNlAME8WMGzEgeuphnqW6hP?=
 =?us-ascii?Q?fEAWN4yjPrfsMDdrM0b62ZjP1klPjiQ/wa5IAZOTAJnlp6VlnZrb4R1sNKo9?=
 =?us-ascii?Q?0decsRvdozFL8qOs2SXYbZU88ehxmk6H3SIYjVRJguYUlBOmDzaXfiJAFwbA?=
 =?us-ascii?Q?Shz0XcG4rSndJ7K6UC+yTzn84ks3FxtD93i7wCYXqExVhyC9J+7oWWgC2Bvj?=
 =?us-ascii?Q?xE5rYexTW9/R5hlTgrb+EbJ8cyLh1468Vx/6nqNfBd9tH046hC4jJBPipmwg?=
 =?us-ascii?Q?b3LDIcXdswRqOpV8KXaByAz+O56WZpdcehZ0bsNUU8GrdX0MRsOyWjDkB66d?=
 =?us-ascii?Q?wFT1TTu6Gq2r2WA1nM9d7sBLx3PpW4FMPSFZZ2VfGQx+qcIWR9wkc6Gubzq1?=
 =?us-ascii?Q?cVsTuH1VljQk+5/ETzBv/uRJuIXfAoESPeDGRpMUuB2Fnd/i7wpqVtyGBkDF?=
 =?us-ascii?Q?W7NkyT2Ch+79YHWjjyEKc8DHNngUupvSeIREWb17vKNDi8+yFOueS8NnEXop?=
 =?us-ascii?Q?M03U9ugrLBQhH8TORySMJQ+eAR8HVmexzF6ShQuQdVCamENJg5PHY6Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a662e3-a8d3-4967-c142-08dbd6f8d60e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 14:27:23.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SQAqGnWIBVUIJMBA6Nl715t9ZXDwR1yM3I5gAOPvcqnxvpKY7TS7odVMr7lzNi4zmsTpIaGeGmkCMwyESQY3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_12,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270125
X-Proofpoint-ORIG-GUID: T8ds3Bu1vx1POn1hcI8i8Y572PutkBVt
X-Proofpoint-GUID: T8ds3Bu1vx1POn1hcI8i8Y572PutkBVt

* Peng Zhang <zhangpeng.00@bytedance.com> [231026 23:39]:
> Hi all,
> 
> This series introduces __mt_dup() to improve the performance of fork(). During
> the duplication process of mmap, all VMAs are traversed and inserted one by one
> into the new maple tree, causing the maple tree to be rebalanced multiple times.
> Balancing the maple tree is a costly operation. To duplicate VMAs more
> efficiently, mtree_dup() and __mt_dup() are introduced for the maple tree. They
> can efficiently duplicate a maple tree.
> 
> Here are some algorithmic details about {mtree,__mt}_dup(). We perform a DFS
> pre-order traversal of all nodes in the source maple tree. During this process,
> we fully copy the nodes from the source tree to the new tree. This involves
> memory allocation, and when encountering a new node, if it is a non-leaf node,
> all its child nodes are allocated at once.
> 
> This idea was originally from Liam R. Howlett's Maple Tree Work email, and I
> added some of my own ideas to implement it. Some previous discussions can be
> found in [1]. For a more detailed analysis of the algorithm, please refer to the
> logs for patch [3/10] and patch [10/10].
> 
> There is a "spawn" in byte-unixbench[2], which can be used to test the
> performance of fork(). I modified it slightly to make it work with
> different number of VMAs.
> 
> Below are the test results. The first row shows the number of VMAs.
> The second and third rows show the number of fork() calls per ten seconds,
> corresponding to next-20231006 and the this patchset, respectively. The
> test results were obtained with CPU binding to avoid scheduler load
> balancing that could cause unstable results. There are still some
> fluctuations in the test results, but at least they are better than the
> original performance.
> 
> 21     121   221    421    821    1621   3221   6421   12821  25621  51221
> 112100 76261 54227  34035  20195  11112  6017   3161   1606   802    393
> 114558 83067 65008  45824  28751  16072  8922   4747   2436   1233   599
> 2.19%  8.92% 19.88% 34.64% 42.37% 44.64% 48.28% 50.17% 51.68% 53.74% 52.42%
> 
> Thanks to Liam and Matthew for the review.
> 
> Changes since v6:
>  - Add Liam's 'Reviewed-by' tag to all patches except for patch [3/10].
>  - Modify the copyright statement according to Matthew's opinion.
> 
> [1] https://lore.kernel.org/lkml/463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com/
> [2] https://github.com/kdlucas/byte-unixbench/tree/master
> 
> v1: https://lore.kernel.org/lkml/20230726080916.17454-1-zhangpeng.00@bytedance.com/
> v2: https://lore.kernel.org/lkml/20230830125654.21257-1-zhangpeng.00@bytedance.com/
> v3: https://lore.kernel.org/lkml/20230925035617.84767-1-zhangpeng.00@bytedance.com/
> v4: https://lore.kernel.org/lkml/20231009090320.64565-1-zhangpeng.00@bytedance.com/
> v5: https://lore.kernel.org/lkml/20231016032226.59199-1-zhangpeng.00@bytedance.com/
> v6: https://lore.kernel.org/lkml/20231024083258.65750-1-zhangpeng.00@bytedance.com/
> 

Thanks, this looks good!

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> Peng Zhang (10):
>   maple_tree: Add mt_free_one() and mt_attr() helpers
>   maple_tree: Introduce {mtree,mas}_lock_nested()
>   maple_tree: Introduce interfaces __mt_dup() and mtree_dup()
>   radix tree test suite: Align kmem_cache_alloc_bulk() with kernel
>     behavior.
>   maple_tree: Add test for mtree_dup()
>   maple_tree: Update the documentation of maple tree
>   maple_tree: Skip other tests when BENCH is enabled
>   maple_tree: Update check_forking() and bench_forking()
>   maple_tree: Preserve the tree attributes when destroying maple tree
>   fork: Use __mt_dup() to duplicate maple tree in dup_mmap()
> 
>  Documentation/core-api/maple_tree.rst |   4 +
>  include/linux/maple_tree.h            |   7 +
>  include/linux/mm.h                    |  11 +
>  kernel/fork.c                         |  40 ++-
>  lib/maple_tree.c                      | 288 +++++++++++++++++++-
>  lib/test_maple_tree.c                 | 123 +++++----
>  mm/internal.h                         |  11 -
>  mm/memory.c                           |   7 +-
>  mm/mmap.c                             |   9 +-
>  tools/include/linux/rwsem.h           |   4 +
>  tools/include/linux/spinlock.h        |   1 +
>  tools/testing/radix-tree/linux.c      |  45 +++-
>  tools/testing/radix-tree/maple.c      | 363 ++++++++++++++++++++++++++
>  13 files changed, 811 insertions(+), 102 deletions(-)
> 
> -- 
> 2.20.1
> 

