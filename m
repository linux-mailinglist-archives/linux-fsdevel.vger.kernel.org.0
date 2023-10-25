Return-Path: <linux-fsdevel+bounces-1197-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8190B7D71BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 18:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53391C20B4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 16:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0BC30CF5;
	Wed, 25 Oct 2023 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N2+aAX+1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U1dsCbqU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2930CE3;
	Wed, 25 Oct 2023 16:29:07 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6829C;
	Wed, 25 Oct 2023 09:29:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwZr9006370;
	Wed, 25 Oct 2023 16:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=9FObjXpz2Nhr7RKqr38hDRA7fsxnZM/vDvmj6PcqecY=;
 b=N2+aAX+14XnNY1gMTnaODHBTeQHTJWR5E3giSLaiAi97euchKov6XJpaxtw2bLYd3BBB
 BSAnuhWn4uPAjMatepihufZlGXb7Io66L9oQ7kLpqjd+u330jI28bga2SgC9BLyUayT7
 5wxREZzjfDyd8qkq2bWRMfTzKyM/2bxDzpTUAnuNyy1ONBTtsl1qPkCeCpCQB9i43S9j
 8U1mJMdvWO5AK5Jmnxo7ClPUCquLOO3OFZouXpkJMRcw9BGXcUuLJq8nwWRVQN35Uu5c
 rq8HVhggHT4bftwQlEefw5MXsRt3odYJLl6s4iruU8OqaBLRZy+DIyZtiPGtbVLTEPbs bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv581r7q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Oct 2023 16:28:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PG07Ho031161;
	Wed, 25 Oct 2023 16:28:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53dd76p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Oct 2023 16:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPyhdL98mMafAuOcknOnqvx2MaVqwBbNhMrBu1O6msKnAVlxM4Ax388uC7KV8ErSsDW0ypezqdI+OLrpFytH6A01fZP0AEOOsI57RAIYAOGz0kwWQhIYKZVU422KKQwaurJlFZ49ucaXs5joSCnIJsnETBKuO/qY7MQkXxTWehgJMhljDOfrs2+z7X5AAiN80lxdfvWA0N0vvKmgfAuS1JLHBSQ+ELPjtXHUi2z/cXS8grviVytuE1UqiDI5cxjjZTKsuFceTYN1eXujgww3lPFhaoEYhEpHNRC+Tt5Qlbf5Tyz8fLbAdqrd0fKMl4aAXV3pgfchiJCafYxakAv0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FObjXpz2Nhr7RKqr38hDRA7fsxnZM/vDvmj6PcqecY=;
 b=ZHO8xPDjPk3N1DpGCKJFIkOr/ycYY4a6PUNjAG9BC+3lpt83tdN8q4Or80Re42XobvMtBzFHsxljS6mIFTUjWWLtAjuO3Bsupsy5g2elREIyD/qfvlWJCsiB2W4Snw6I4Bzw0lG32jl9vdIEh8t7c5Ti2lIO+fQ1PZFLnPUU5IiKw/xBwCahHZWWJjwc4GuwsoH18zfekJXSVFMJ/dboWpbySKEZmpCqoa4VdUBCeWsLHHJjiIdYGz0PP7HVZecIbxikCh5kDQG19Y7CVjdnnVLNWptOIwGBDvsNTGi0H2Ha1/HqHvmPkc81/NAYO5y7lA82BDd4iqbAULijfLx+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FObjXpz2Nhr7RKqr38hDRA7fsxnZM/vDvmj6PcqecY=;
 b=U1dsCbqUNBvZvrt9jMz9uFcKtHJqo3UGUfZepvEEQLe94fJAsupZYqyT1qlN+zXE2+FIx0XP0hYbza62fwIyYF51wAc7sCxA3H9ZmHVhtTD/vwcFUjGCsH1WSi8/xUGxkqq3/oVAR56QkVOyn9FDk/F1bM8RWrWTBfKZDDS90r4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4193.namprd10.prod.outlook.com (2603:10b6:a03:202::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 16:28:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 16:28:06 +0000
Date: Wed, 25 Oct 2023 12:28:03 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Matthew Wilcox <willy@infradead.org>, corbet@lwn.net,
        akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 03/10] maple_tree: Introduce interfaces __mt_dup() and
 mtree_dup()
Message-ID: <20231025162803.i66jc6u2hzfackfp@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Matthew Wilcox <willy@infradead.org>, corbet@lwn.net,
	akpm@linux-foundation.org, brauner@kernel.org, surenb@google.com,
	michael.christie@oracle.com, mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com, npiggin@gmail.com,
	peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
 <20231024083258.65750-4-zhangpeng.00@bytedance.com>
 <ZTfw1nw15wijNnCB@casper.infradead.org>
 <bf7d4005-d32c-42d9-a748-a7c421130be6@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bf7d4005-d32c-42d9-a748-a7c421130be6@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0014.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe7a91d-02e2-4830-6331-08dbd5775e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QjJ8XWY/WPz4pRGSAC32X7YItQlZRJvch15wmT+QOH/2PcMx846C2hHtjbSMMuQrtN0Xuo503oYKdWvZcnlUFt0hB+Rwd6mEb7eP1HurKIuPQRj8TLrusYURBJ8daR5MGUvGtTpSMsK6O++1DuHQE9C3IIgKzdFGNABZGCcKRZuLaDWKmylCFZ736POcB7N9iSjfkmnPriV1v/93wjksojyfSWqQySQ160UXsQKX59i2eQ7103FsErVgonXLWnAI/JZWWr8JiFgOPetFcaVvwrx3s9TcNNiEEjBajc8Bs3BuF6OdiYGS42C7VArsz/GINMHx/KewWW08fE4gjJiiIw2pkyvmhWQhdElU5oTAV/NS33q+afsK6kiPqikyIeErITcviznrhY8ckwObHwUJs20QKkTJOUyDaJSfwpHclB/x7rlo40jqh3UhbTU4YZl/pR3dBegYcRvTRwFXqV0jDXuP7Oen3rXB+1E3y0QznykNWYgPC4mUroDCDgL/2QW/SbNQmKopdh5ILryGtIp8FR4193aAF9rVy1kLPwgWNSwoPlAOO9gg/mWZRev6pPQa
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(8936002)(4326008)(8676002)(2906002)(7416002)(5660300002)(33716001)(83380400001)(9686003)(6666004)(6512007)(6506007)(1076003)(86362001)(38100700002)(26005)(478600001)(316002)(6486002)(66946007)(6916009)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aHBWMlJvNENISDUrbWR3VHpRS1F6WE9CSnFCMDA5YVdMV3I1d2JmeWJqRWto?=
 =?utf-8?B?VkpkYklQeWRJL2V0dStJdElTV2hMYXhOSWFOcGdHWnlWZ0VEWGJHRERsNENQ?=
 =?utf-8?B?enRFekpZcnU0V1ExcjJ5Uklkdk1pTmxuQURONzZHNXJZT1FXR1ptTzAwODVB?=
 =?utf-8?B?K21ZeVlhTXNKWVFZMURIckh3NkZqelJJTHlBRFVBZ1dCTmtYYk9sekpuNnlV?=
 =?utf-8?B?d1c0MndyRWQ5djkrT1Znd2RkS1diUnRNekdKcjl1MnBBOTVOYXdrK0R3Uy83?=
 =?utf-8?B?NFRyeTc3UDBnWWJEQ0MwMWlFcEUwSXhyUTRvc3VGbnQvMzZxRlR0T3ltSHN6?=
 =?utf-8?B?UVhBaHk3aFRsZWk2d08xS3dHdWRFV3RFZ0F3RHJxNEhFWVJjZk9mcVNnOVlJ?=
 =?utf-8?B?MHRzakdUK2ZMbnFKaUprTFFWL1QzbkpXZmRGRlRHQklnUElkWkFSTWFIcGta?=
 =?utf-8?B?OEZEdmpzTGpINUt5bVMwc3c1ajUwSlA0NWNFVE9HWDg2STFWWWJEY2R4cFBS?=
 =?utf-8?B?L055WXlOc3FXRWdIQm5PWFpVY1Ntby92Z01Hb1hXOG42emhBdUpwTm52SWJ6?=
 =?utf-8?B?N2QyQjFFOURQK3N2U0VmWmJlSTA0WXZYcXoyVFE3SGJPRWdwdWZ4U21DTUxm?=
 =?utf-8?B?djI3d2xYK2hJa3ZsVDZVZE5ucUhnYXYxcGRMc09pL0FXWklKblRTeEtITk40?=
 =?utf-8?B?YnlndDMxc0FOTGpvNmNvbWpGdmh2eFpaVGtmYURYMS92VEJoU2phV2FaTmZr?=
 =?utf-8?B?MVFXT002bU5yd01QUk5Kak5ObnlOMFFLcmcrb0NRZ3hvTnNHL0VjNlhLUmlp?=
 =?utf-8?B?WitlcUhIQ0xhek5JYjhLYmRMSnNTd1dvaEtnTnMvZUx2dWl2YkNncXNsVkVu?=
 =?utf-8?B?NEgvV09EUnpacDA0bkhnTlkxV3ZTMDFJVkdiUlRwRFpMa2VOZ2p0UDJrYWFt?=
 =?utf-8?B?TW9tdmEvcm5tNHBmNTZkaGhKb3ZQVUtsMlRlVEYzc2JiNDVCRmxWWUZTY1Fy?=
 =?utf-8?B?YWxXUW02MU1wc3BDK1JSaGdtc25tK1dZak40V3daZEJnRGNQTDBubW1RTmlV?=
 =?utf-8?B?d0lpaFBFbFZUK25zL205ZTcvZ1p0L3Q4TUdUaUhYUFFTb0dXRDVWYWJIMEUz?=
 =?utf-8?B?ZlFmeE1UeHVpekp3Y1BqMzF4Nm9YRWpiczlkcnFTdC9Yenl5N25Mbzd4Z1pa?=
 =?utf-8?B?OCtMQnNncWlQRUxWSGxZZWhqT2lySys2YzhiK3BLUVZoNUhhTE9wdWh6VTZJ?=
 =?utf-8?B?NG80OEtkL1EwUDU4TGdacG5yOVYweTY5by9uSVNzdk5DSDNkZUZPejJqckpn?=
 =?utf-8?B?azZwY1pzN2pLZUVBSDZHSTFtUXp0ZUUvcEoyWGlhYkVEaVgyd04zenZjWWdN?=
 =?utf-8?B?dG5FZGxUci9sZU1ZSmF4a2dqWFBsSEJzZUdiSDU1Uk5ZRUpDcENaRHpqNDZP?=
 =?utf-8?B?Z2tYdzNjaUtUR1VFa0NSYlF3R3VjdlVodXJHVWNWajVtSXJ6am5wc3E2NnM0?=
 =?utf-8?B?T1d4bHoyd2dLbFdoVFdkbm1ncDRLM2w3dFp0NXJOWEVWdG5IT1VCWklqN29M?=
 =?utf-8?B?cUtGck9kbDIzY1ZGQ2RKU3cwTWt5bGZaNER2L09MbzYzNWkwT0lwejRNbi9v?=
 =?utf-8?B?TTZwQnhwS2VmUm5yYmpVY1VMalY2M2dzb25yaWtDTXNiejlvQ0R0OUtneUx3?=
 =?utf-8?B?Z3JaZE1lTDM5YTVTcEVQSzhZVUhEeFZyK3pBRG14c29aSjdWVVpOQWhrb2Zz?=
 =?utf-8?B?ZDVzWS9FY2xVT09tTGtGWGFDMnlHUHFOT1hjc0w1eHVyNE5MNUtFcHR1aDd4?=
 =?utf-8?B?bzZ1cklPdzE2VjM5NTBaaGRqeDlWc0NKbkY5dkpMUHRJVkJkVkUzRDVoZHhU?=
 =?utf-8?B?Y05DTWxHQy9ZUmxxRS94eGU1aEJiWlpBSkQ2NnNrVERoUUp2cmNxZkFwK0E1?=
 =?utf-8?B?cmZSREpmaUpRZm43cHNZK0F6MXVQL1doa2xwV1V5RHdCVlRGSmNkazZGd2Ix?=
 =?utf-8?B?MFl2WGxSdEk0MEpZMEN4ZUpOY2tsa2JyZWltSjdyQ2Y2Qk11bW44NjFOdnlu?=
 =?utf-8?B?dkhqWHdPQVNFR1FvK0lVMGI1WHdzVFN0VEtLdVp4SnkxUXZkRzU2cjhqUlgw?=
 =?utf-8?Q?ly2phmz/bTgy9WgiI78z9gDUF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?b0JRL2xVVi94bmYxYUcwZjZvanRoNTZZcWIrMkUzY2tJSVMzVVFsdmVWaHJo?=
 =?utf-8?B?bkFGVEVWc3dLUFcvV20vRzYvOUxXaWdqNzlrWU1xdFlwWVhla1QxcDZvYVda?=
 =?utf-8?B?TVVkU3lsajFUb0QrRmZsQUhaMWlxcGpGQ002cXVuWkF2VG5SV05xejBpT24x?=
 =?utf-8?B?WmlYRUk1SUkzcE0zYWdxa1FTczNJSHEzZ1RmL01FV3JWdnIwTGpvZ1dHSkJL?=
 =?utf-8?B?akdhTkxPeThJWVRUeWhDSFlxcUZoZzloQ1VnN2s4eVRhMWZTeWtZWnZmdGhl?=
 =?utf-8?B?ZXBmaVZZRFI0VjF0WmJqZ29pYmxrTlJWRUdEbmFFa1UyWko2cG5LWFgrOEls?=
 =?utf-8?B?STUyaUtHL1VsaWIwSVBoem5McFdTYWs1VVJtYWExa2o1TE5ScjFsZnd5M2ph?=
 =?utf-8?B?M2ZRaVFNeDFJSUVBWHRna2N5Y25YVDJhTnVpNEorUXhzTUpsMUJRUXVxSm5t?=
 =?utf-8?B?MHVQeGRTWkxSQnJpeHpWM1EzT3NJR0lYamFNTEQ5UHJjMHdtMU9NVXlKN01R?=
 =?utf-8?B?TFhrMGorT1lSNnM5STFTdnBMMEErVy9YQWRiZndEZlRwSVhyNDBMUDAydCt0?=
 =?utf-8?B?SHpTVjFLMVY5OVQ4K3d1VDQxa2JxOGcxZ0FIbmNWTFVHbTJ1elk5QVJrODhT?=
 =?utf-8?B?YjdhRWk1YWEzU1pUc3BublBEU0NRNWhoMjFLa1JhZHQyVnRJYnJXcUZMNCtG?=
 =?utf-8?B?cmljSGN0TWl4WHFQdFAxQW1xbkJrditLZjMzVXlDRmRyVnFlV3h5OHRCR0tX?=
 =?utf-8?B?VEdIdVRVNjg1MWtVV2tSa2UrK3Ezelhhc1UrelpSelBMa1Qra0cwNTNFZXoy?=
 =?utf-8?B?aFBpRExJRGlGT0tWR1I2Q3RFaXhtRFRCdnNURktRcmlDZ2JHL2ZnMmRwcDJj?=
 =?utf-8?B?WStHQ3FrRVpDSVlRSlFmd2hRaEdJUnBvMUFCNkJPa0J0MllWbUtCQmFWVHVs?=
 =?utf-8?B?MDYyVFZLSzBjZkVQQmlHMVFUbDN6TGZyUFFRc3FHd29pckxjZlRhQlRsZDZJ?=
 =?utf-8?B?R2I1WG1yMUhrMTlhS2hBVTRhQVBGeWMxWUdXeURrTWcyT3Z6WUVoTGVWb012?=
 =?utf-8?B?eFZMeUg2dEM2V1BDOXJoQlQyalNQb09RK2ZTUm5hK0ZRTkVodFpGckNQNWRS?=
 =?utf-8?B?MGg4Z05LVFM5VnBtUmgydzVrSS9ZbU5sYm8yN1dObWtrT0N1M3NaazBZT2JT?=
 =?utf-8?B?WlpkNzRaRDI0aUx5TFBGUDRsUkdQTU5HOWtWK1dDZkhHakFhNWVMd3FCZDla?=
 =?utf-8?B?a3FVZUlTNEl5NzZ2VGozVUxlSlpUa3hndXZsUkJsR2ZWMFo3TzRpOUdkUnVR?=
 =?utf-8?B?c01BWXBSb1k3WkJWMWRsR0RXTWYyRENWS3ZqL2pQZmIzN21zQzlkcWxFTjhZ?=
 =?utf-8?B?QUQ4WXFPSXJhNDRpS0UrT3BNSTlQUWlSL2FCZzlqOHBuRDV3d0xkV2VaMEx4?=
 =?utf-8?B?T2F5b2xzMzB4dTNacERmeXQvN25BSmFZdWdKODlGUVRjdW5PL05VM296MmJu?=
 =?utf-8?B?by90MmNCSExnQmVKYmc2TXpXVmxadjZGQmlxTittY2M2QW9RVm9CUlExR25Y?=
 =?utf-8?Q?r1juq6RdSJFuw+ioHDXP+YFTY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe7a91d-02e2-4830-6331-08dbd5775e83
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:28:06.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOFos7HjQFU/OA7s+BhOm9P91/DvC6q1vRR4shd4WbgJefS1MZX2rdGYI+JflpV/hZIfpauYGs/+83JXnBZEOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_05,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=992 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250143
X-Proofpoint-GUID: AYKQFq4b7jR5aqUyfh_obqbUKEgsgnJj
X-Proofpoint-ORIG-GUID: AYKQFq4b7jR5aqUyfh_obqbUKEgsgnJj

* Peng Zhang <zhangpeng.00@bytedance.com> [231025 05:20]:
>=20
>=20
> =E5=9C=A8 2023/10/25 00:29, Matthew Wilcox =E5=86=99=E9=81=93:
> > On Tue, Oct 24, 2023 at 04:32:51PM +0800, Peng Zhang wrote:
> > > +++ b/lib/maple_tree.c
> > > @@ -4,6 +4,10 @@
> > >    * Copyright (c) 2018-2022 Oracle Corporation
> > >    * Authors: Liam R. Howlett <Liam.Howlett@oracle.com>
> > >    *	    Matthew Wilcox <willy@infradead.org>
> > > + *
> > > + * Implementation of algorithm for duplicating Maple Tree
> >=20
> > I thought you agreed that line made no sense, and you were just going t=
o
> > drop it?  just add your copyright, right under ours.
> I'm sorry, I misunderstood your meaning last time. I will make
> corrections in the next version. Are you saying that only the
> following two lines are needed? This still needs to be confirmed
> with Liam.

I'm good with the two lines below being added.  Thanks for confirming.
I will try to look through the rest of the patches before the end of the
week.

> >=20
> > > + * Copyright (c) 2023 ByteDance
> > > + * Author: Peng Zhang <zhangpeng.00@bytedance.com>
> >=20

