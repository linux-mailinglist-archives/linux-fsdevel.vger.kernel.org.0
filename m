Return-Path: <linux-fsdevel+bounces-527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0007CC52B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 15:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14072819A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 13:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58798436B8;
	Tue, 17 Oct 2023 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t6pfRhaa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yCM+BqNe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD7A41234;
	Tue, 17 Oct 2023 13:51:12 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67095F0;
	Tue, 17 Oct 2023 06:51:10 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HCrsDL013931;
	Tue, 17 Oct 2023 13:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=53pW2iwa7e8WcmZMIUfghiyCLAnpY3O00zlpLL1qs5w=;
 b=t6pfRhaazh370gMtv/se4072VnzIwYFF1a7710UI7s2uVEqgWLSTcpehj6igcrdNIuye
 bfvDUwGJGDPGjvrs7W1KmL3EnwaJ7f0Bpr8/t7vX4uT8iMpjBpyLKol2nzrZvXnWvXD7
 VcDuC4zcGiyp0zkg4Wdse05DIbkBvBU6VA39Bhy70ERyQrUGPdzZh+k4Jhai33Nwb01r
 WUDJzwEJE7nXmEYIEsaNyV79tK4x1+2iMqdnm9LPqfFnuk8z9AQ70+Ranwl5oc0bHbHv
 xtAxA7/z/wnwmHN5Xk58QI41BjJE9PntIrsfT+gx4FUkocnd87Xxc725C+EskGpcDIt2 cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28n8we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 13:50:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HDgWFi015351;
	Tue, 17 Oct 2023 13:50:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trg1f2gbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 13:50:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baWz9LnckPFfBpeHIdpLor49YGuLc/jV2xUBW1rI/R2zBtS3HOE8+NjdMQLjVcmtnN8Vnoij6KPemrf+T+3Le3we2NDt5m/Gi6BawTxUUKtC7cV7PNbcGRXkZ74LA6ZutgRqfWmXarL0lE9ass/Ocz9n2xVGU6tvfB9w/jM0EAWgCJNZ7/LxoZIFGIOI42x+qG/bkjMK/vPfMAQEjjj0NQYaJW/24vLYnInm/DLbafTioOIS2JKOksDxCmQYkDyjU2xNxQZDSbRJ22GFV5LZctXjPXjnsfRbYXMty1E52bXYRcQ5qAwE4Pa+JGG5NujsMuGgzlLjJocSAYJ6ArbGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53pW2iwa7e8WcmZMIUfghiyCLAnpY3O00zlpLL1qs5w=;
 b=SpID80DtH2f7qEoAehwn7iC8PrSDUThfL0PBExqlT/spVhmXzk1SYuRbFT7y2rJc12RLvp9Pi/ryicqKWR5+p59Tdd1BsF6Dz6rI7UC91/ZGkV9wWJUHzUfzrpkhDQLhQ2ALjI6q55mwen9HAaHwGOUdt8d0lMP+4hQF3KIhgB6mFeXHxgzsyXKsW/xm6Y8MvaOFkNhIsOfmXjAg/mexHRNgXXRtAG8X+6IrftznCg/36/V0qxToetM2/XITVGiO8WZS2wghQxYD0imzKv2mIlG8NjE11pGopm5K95cGASFcqXprIOoLYSmhxeLXP+jBt8BvIC3/HNOAMNP+3U8spw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53pW2iwa7e8WcmZMIUfghiyCLAnpY3O00zlpLL1qs5w=;
 b=yCM+BqNejoNdCTCz/BgSUrOrCUg6bIIRCC5+ULgSoD3boWBz7pI80YThanl55ZBjQE3QWOgmmIFAb/rOugr2JRGqVGg9U4Z3gIJ3kxzfRQ3duDipfcRh76GdhlsrAGpxM2400Y1zOTt97yP8j6X0udpcvD8xKrEkXTWZliLInDs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB7403.namprd10.prod.outlook.com (2603:10b6:8:184::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 13:50:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 13:50:25 +0000
Date: Tue, 17 Oct 2023 09:50:20 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] fork: Use __mt_dup() to duplicate maple tree in
 dup_mmap()
Message-ID: <20231017135020.dqq3u6zwvnbrsgfo@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
	akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
	surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com, npiggin@gmail.com,
	peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
 <20231016032226.59199-11-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016032226.59199-11-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0038.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bb2e75d-1a04-42d6-0f88-08dbcf18037c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bAAEVstLGhCeHZGlc/3pn+AXxuf/PPTq15b6RJWMaZJCNkKOFqqA5meej2p+EPmiskvh5XOH5X3YzqQF7856UXIef6FVILFPR8ST9JJ/JDtlMvcJTQ8OUFki3Lz2qATFdjXj2//3AEpGqsaXE/2lmb0ee/U/bBVIvhjEx2mdjgq/8NS8kfjXfqDSW4jgdIVYvJiTltFULGQYwHjOjJERUznnmtls+WjgzFwEaB3jRJPR8Gj0PRuRCiA8eNLdWdApSwYqBYcN1bdrBphQrx2v8hWCDnuTOgYlNwoNCIrjzEWyDxdDBAGK6x0esfytIhFHfgZICatPllrz6fuDr67PqqHGoGAF4+l1aUNzt4pxUFpjhyIKPX59SKEWmLzDC7bmrq9ZQFmVInQMx0kxYZYux5sRMlY3ePh2mrYCHuShWqxH4mQGekMaKhlnGM51clzlghyP8pFDFWMSyldyRZw9k2T7GWzft13Wqt7pBkLepCCbIs4yvMxrBizHsqImCktob5WJCnUHlYmVthWbFPqxOJBn3PlfqGoM85yxWRFb05Q=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6666004)(1076003)(9686003)(6506007)(83380400001)(66946007)(2906002)(6486002)(8676002)(4326008)(478600001)(8936002)(5660300002)(7416002)(33716001)(966005)(66476007)(316002)(66556008)(6916009)(41300700001)(38100700002)(6512007)(86362001)(40140700001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tq+XTp2+797dClN3WCLI6NdjQq+sGfTKqu3Gbu+jHAz55j0JkEL4CDh/tUjb?=
 =?us-ascii?Q?e0mj0zMcp1UOH6r8zRc2Rwz3clacoRbFStnt+/omoPXovypuRKgIERaKXfyu?=
 =?us-ascii?Q?Isuy71M6zXyVIQ4CzBvgAUh+FcRg9u7WdaMgk98gu+ve1fxkyU6rT7PfKzIA?=
 =?us-ascii?Q?0VyXdWVyK2BmKzhQ9zCMNAN9eAfI/zIu6kJk1jWSnQT1kwF6/ccttueqpWVD?=
 =?us-ascii?Q?yNowLkWpmeJsuyZP/kDYgAn8+2/ouJnOa+srBdEwiABKRYjOgg8FbnzLZCvd?=
 =?us-ascii?Q?w8eMumPUqOA/EoT4mpPJuGIWeSqhm2KfsZbhtaAIdUUVR1F/h5GiZyZWxvlq?=
 =?us-ascii?Q?oXYK5IIw7HeYR6I4HFAjlYFLkALdY/IgREC4Ukn3rQEmJYbXkt6hbXAP6J4h?=
 =?us-ascii?Q?g6wZ3uZxkcDGgXSJ1aWp+GArYyoBI+qb5KlwB3roBPUeL7uUOuFfJ6NYuwMM?=
 =?us-ascii?Q?DeuIKJcph+iuki/LluDlxrxXKHPXRTT0v54iNk8RDqwxR+MXLz6Y0DoJLBUN?=
 =?us-ascii?Q?G01DZ9NpjjRBUiJtIyUIfRqYscUjIpwkeEZIEDT2fjhw3Sw3Rf6fTTM6Pwhl?=
 =?us-ascii?Q?sT9SWGwoUuHeJQXIZ27MVxOktbWxWEZf4XBAEGrqJdDk5rclxFPndiOsa8jP?=
 =?us-ascii?Q?TUM1DgFnF1mKfwCuuS/xUa+UG53IYW9WaNaUepK5DLf/k/yaljD6UjfKKY2h?=
 =?us-ascii?Q?OdkWA2dCuC09SS5YZieWJ8tJmm1kVz3oGR1hptBFLSnV7aK9k2MWkvXbBZJ3?=
 =?us-ascii?Q?Op2RLgs8UXPFfYb+TXOC7kPgDnfH3FtSX79w/8HnYI/cERTsRihKUuDtreFM?=
 =?us-ascii?Q?gEI7o98RIu7x76W6/ra3ZLkHCwj/QSMcXXZBvSoruh1rxn9BZ9YaOCOETJ91?=
 =?us-ascii?Q?c1aVYUPjKh2MF2R5ZncROkNGFlRweMlNQ8jvugCM/xujwSwv3b6nbW2PCmxN?=
 =?us-ascii?Q?gbnhhK/kV0i56Pe2/1PuC3OCc/PxND0xmsY0gkONdKkqVF/ginv3AwckYN8c?=
 =?us-ascii?Q?n0XIgtnBtNROKiiuPceLD62MHT122AcodYyAc9iBtUbSiAtzEpzY4GBfxTnp?=
 =?us-ascii?Q?Tgcuvblykizdb8Mhp67TS7HRdgAUDV+jf68qEXRwJOurGq0u7epzC4/Dyut1?=
 =?us-ascii?Q?ErTDmD66VS6KvMHMc+i3sMLFg6jjtwBgIjjz33+h66EPGIKqIhvqqP4uSCxa?=
 =?us-ascii?Q?eLM1hw+aEHwbSzqJ+bZMUiDm1cj+01jhQBFzUNGobQfOqr5mo+qX7HGwhHZ7?=
 =?us-ascii?Q?Jao2925Lt69iAaUbBb4n6TfBCC8KSrJj94hsdby3bAgCWGLIJdyxLcwqThmW?=
 =?us-ascii?Q?DWy5byTDorXZGQE5HgZ/Fc5B0IhaOYEqKOX+wWiSgrx0tfi4UQ5FQ2zVdawn?=
 =?us-ascii?Q?XF6oS9MgJKP0t5LUIY+RgjQgIie+r1UziyJIWgLKaaEJxGS7njPaE5r6Zhb2?=
 =?us-ascii?Q?67ZeTqW8DJWwTC4SEoKCbCi+Y/Qy8Bt2NgHkjU9qHpgQwJHaie7Vo94U1L6l?=
 =?us-ascii?Q?aKMEEfO3pgC7rHwjwHDFGgq0wFAUDtFQPQtYYFGrjGirAURWi24OrSJ/hcYQ?=
 =?us-ascii?Q?PFJNpicQ5NFHZIyCChfGQCXdFs9Lpc3oJ/iNdw8o?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?CjXc08yish8dbWNniVNEh1aeVtuMa6Ti2f7PdVrNqG8bbBxzVF8l+8wyERjl?=
 =?us-ascii?Q?WPkeLYP+mz3S/qey8Zc1H7+wgmmU5pA2NE5yVl2KCUcqm5nlSO9ViHbe0mvS?=
 =?us-ascii?Q?YL0IriPtwbMjkuH9HRFSSq2b+hac10WmI9F9oDfkwCsDj5MHjAEX2pVql/zM?=
 =?us-ascii?Q?sxxn7ARJyJM9rIx559yNjdoVS99LFZvsd1YB+sXEnXIwUhYlsBMDdZTxbvXC?=
 =?us-ascii?Q?AMFAYJ0xhCIsGOUOhtgWPPWt223zQvOjZxCujvu3A0jpM9S9dRM+iMIhSjV9?=
 =?us-ascii?Q?S2rW7/LEyFynWu3mjUv1ket4V1os8zJ2XUckQTp+GS6MTq8zQyywWs3ykAf8?=
 =?us-ascii?Q?jvp5SL8eqxZinYMZlB8GHyunceKkKjZoEdZtAOfs0ivWipzBeRUZ3rq4Skqp?=
 =?us-ascii?Q?y6uiAvc7dO0SjvE+9JthztHo2CJN1LgF/XyvdkBw+OlXnKOKVLqZh+qEZlHK?=
 =?us-ascii?Q?N5ZchV7ifiuTTuDETxsMfrO4dgPAdIyL/054bAK1HwisO2oMBqoHU+A9j1yp?=
 =?us-ascii?Q?eCVeLBSBp553ukqXakokKavZ9AfgTyhaLOp1/Mdg3enRf1Qo1GyWaAixeTH2?=
 =?us-ascii?Q?jXY6fhFqdu3eHsMQo2RqjiOFgP4nAQJr4q8soimYt9m52lSIcTKtkEIrqhOV?=
 =?us-ascii?Q?kI5EAUakk9xXeHcy35G4lcx9wwcb3LsbOVyyP2x0DjCgghac0unrNQQBDMx5?=
 =?us-ascii?Q?3JsfnjWAsPGY/vQ7m+h4nOinDxSaGYhYV1zjst5C+TA0kppNtAizlW/RJsVn?=
 =?us-ascii?Q?bN8Q/bcdLRfEEVHLfGsRnkXgCqRAP7fLLWegNG68OS3QuRyJ3B6t9Jh6bFiL?=
 =?us-ascii?Q?I4bkUEMdn5NDA9E1umWVMwDWkn+3igiZJeOMHBqW8ZtOVaheWiD5GSfuV1KX?=
 =?us-ascii?Q?5pWQK4fpybqwgMe1CSTwcgOwvg55ZlIp3d/8ozTTogEqt1l6t3XHNcOxJlx6?=
 =?us-ascii?Q?jpdJaNext2e+SDjg57AeIwaT9OM289zGeUod/CVXxjYkeeM0X28jA9hFPs2z?=
 =?us-ascii?Q?QMylyI4vFcLSGauJVl3eU3EhdlNZJCrCnnA6gGZVbknFuj9BIb0Dw6tNrC+6?=
 =?us-ascii?Q?3I3pixPqz5FdjA94kKTnaV1/du+AxK8/Z0TC0Wwgdsb3QqKHt/Cb9oXh7JTE?=
 =?us-ascii?Q?rTS2BryHJpRXmFxJQwatxnEyEg91nPIfLLokEC5KC0R38UHoiKDgrwM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb2e75d-1a04-42d6-0f88-08dbcf18037c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 13:50:24.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqmqhvzZYblZ5JmqJFUAb7rNiX/sJhv5wfAWBn+z9ZImDL1TvjL6YM6Begu+PgGRK6MkgEOcycQiPkVS5gqjfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7403
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_02,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170117
X-Proofpoint-ORIG-GUID: i_Fjr0SJbfH33wgmm2NCpvZhbqvo-4ip
X-Proofpoint-GUID: i_Fjr0SJbfH33wgmm2NCpvZhbqvo-4ip
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

* Peng Zhang <zhangpeng.00@bytedance.com> [231015 23:23]:
> In dup_mmap(), using __mt_dup() to duplicate the old maple tree and then
> directly replacing the entries of VMAs in the new maple tree can result
> in better performance. __mt_dup() uses DFS pre-order to duplicate the
> maple tree, so it is efficient.
> 
> The average time complexity of __mt_dup() is O(n), where n is the number
> of VMAs. The proof of the time complexity is provided in the commit log
> that introduces __mt_dup(). After duplicating the maple tree, each element
> is traversed and replaced (ignoring the cases of deletion, which are rare).
> Since it is only a replacement operation for each element, this process is
> also O(n).
> 
> Analyzing the exact time complexity of the previous algorithm is
> challenging because each insertion can involve appending to a node, pushing
> data to adjacent nodes, or even splitting nodes. The frequency of each
> action is difficult to calculate. The worst-case scenario for a single
> insertion is when the tree undergoes splitting at every level. If we
> consider each insertion as the worst-case scenario, we can determine that
> the upper bound of the time complexity is O(n*log(n)), although this is a
> loose upper bound. However, based on the test data, it appears that the
> actual time complexity is likely to be O(n).
> 
> As the entire maple tree is duplicated using __mt_dup(), if dup_mmap()
> fails, there will be a portion of VMAs that have not been duplicated in
> the maple tree. To handle this, we mark the failure point with
> XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered, stop
> releasing VMAs that have not been duplicated after this point.
> 
> There is a "spawn" in byte-unixbench[1], which can be used to test the
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
> [1] https://github.com/kdlucas/byte-unixbench/tree/master
> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  kernel/fork.c | 39 ++++++++++++++++++++++++++++-----------
>  mm/memory.c   |  7 ++++++-
>  mm/mmap.c     |  9 ++++++---
>  3 files changed, 40 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0ff2e0cd4109..0be15501e52e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -650,7 +650,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	int retval;
>  	unsigned long charge = 0;
>  	LIST_HEAD(uf);
> -	VMA_ITERATOR(old_vmi, oldmm, 0);
>  	VMA_ITERATOR(vmi, mm, 0);
>  
>  	uprobe_start_dup_mmap();
> @@ -678,16 +677,21 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		goto out;
>  	khugepaged_fork(mm, oldmm);
>  
> -	retval = vma_iter_bulk_alloc(&vmi, oldmm->map_count);
> -	if (retval)
> +	/* Use __mt_dup() to efficiently build an identical maple tree. */
> +	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
> +	if (unlikely(retval))
>  		goto out;
>  
>  	mt_clear_in_rcu(vmi.mas.tree);
> -	for_each_vma(old_vmi, mpnt) {
> +	for_each_vma(vmi, mpnt) {
>  		struct file *file;
>  
>  		vma_start_write(mpnt);
>  		if (mpnt->vm_flags & VM_DONTCOPY) {
> +			retval = mas_store_gfp(&vmi.mas, NULL, GFP_KERNEL);

vma_iter_clear_gfp() exists, but needs to be relocated from internal.h
to mm.h to be used here.

> +			if (retval)
> +				goto loop_out;
> +
>  			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
>  			continue;
>  		}
> @@ -749,9 +753,11 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		if (is_vm_hugetlb_page(tmp))
>  			hugetlb_dup_vma_private(tmp);
>  
> -		/* Link the vma into the MT */
> -		if (vma_iter_bulk_store(&vmi, tmp))
> -			goto fail_nomem_vmi_store;
> +		/*
> +		 * Link the vma into the MT. After using __mt_dup(), memory
> +		 * allocation is not necessary here, so it cannot fail.
> +		 */

Allocations didn't happen here with the bulk store either, and the
vma_iter_bulk_store() does a mas_store() - see include/linux/mm.h

The vma iterator is used when possible for type safety.

> +		mas_store(&vmi.mas, tmp);
>  
>  		mm->map_count++;
>  		if (!(tmp->vm_flags & VM_WIPEONFORK))
> @@ -760,15 +766,28 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		if (tmp->vm_ops && tmp->vm_ops->open)
>  			tmp->vm_ops->open(tmp);
>  
> -		if (retval)
> +		if (retval) {
> +			mpnt = vma_next(&vmi);
>  			goto loop_out;
> +		}
>  	}
>  	/* a new mm has just been created */
>  	retval = arch_dup_mmap(oldmm, mm);
>  loop_out:
>  	vma_iter_free(&vmi);
> -	if (!retval)
> +	if (!retval) {
>  		mt_set_in_rcu(vmi.mas.tree);
> +	} else if (mpnt) {
> +		/*
> +		 * The entire maple tree has already been duplicated. If the
> +		 * mmap duplication fails, mark the failure point with
> +		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
> +		 * stop releasing VMAs that have not been duplicated after this
> +		 * point.
> +		 */
> +		mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
> +		mas_store(&vmi.mas, XA_ZERO_ENTRY);

vma_iter_clear() exists but uses the preallocation call.  I really don't
want mas_ calls where unnecessary, but this seems like a special case.
We have a vma iterator here so it's messy.

> +	}
>  out:
>  	mmap_write_unlock(mm);
>  	flush_tlb_mm(oldmm);
> @@ -778,8 +797,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	uprobe_end_dup_mmap();
>  	return retval;
>  
> -fail_nomem_vmi_store:
> -	unlink_anon_vmas(tmp);
>  fail_nomem_anon_vma_fork:
>  	mpol_put(vma_policy(tmp));
>  fail_nomem_policy:
> diff --git a/mm/memory.c b/mm/memory.c
> index b320af6466cc..ea48bd4b1feb 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -374,6 +374,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		 * be 0.  This will underflow and is okay.
>  		 */
>  		next = mas_find(mas, ceiling - 1);
> +		if (unlikely(xa_is_zero(next)))
> +			next = NULL;
>  
>  		/*
>  		 * Hide vma from rmap and truncate_pagecache before freeing
> @@ -395,6 +397,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  			       && !is_vm_hugetlb_page(next)) {
>  				vma = next;
>  				next = mas_find(mas, ceiling - 1);
> +				if (unlikely(xa_is_zero(next)))
> +					next = NULL;
>  				if (mm_wr_locked)
>  					vma_start_write(vma);
>  				unlink_anon_vmas(vma);
> @@ -1743,7 +1747,8 @@ void unmap_vmas(struct mmu_gather *tlb, struct ma_state *mas,
>  		unmap_single_vma(tlb, vma, start, end, &details,
>  				 mm_wr_locked);
>  		hugetlb_zap_end(vma, &details);
> -	} while ((vma = mas_find(mas, tree_end - 1)) != NULL);
> +		vma = mas_find(mas, tree_end - 1);
> +	} while (vma && likely(!xa_is_zero(vma)));
>  	mmu_notifier_invalidate_range_end(&range);
>  }
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1855a2d84200..12ce17863e62 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3213,10 +3213,11 @@ void exit_mmap(struct mm_struct *mm)
>  	arch_exit_mmap(mm);
>  
>  	vma = mas_find(&mas, ULONG_MAX);
> -	if (!vma) {
> +	if (!vma || unlikely(xa_is_zero(vma))) {
>  		/* Can happen if dup_mmap() received an OOM */
>  		mmap_read_unlock(mm);
> -		return;
> +		mmap_write_lock(mm);
> +		goto destroy;
>  	}
>  
>  	lru_add_drain();
> @@ -3251,11 +3252,13 @@ void exit_mmap(struct mm_struct *mm)
>  		remove_vma(vma, true);
>  		count++;
>  		cond_resched();
> -	} while ((vma = mas_find(&mas, ULONG_MAX)) != NULL);
> +		vma = mas_find(&mas, ULONG_MAX);
> +	} while (vma && likely(!xa_is_zero(vma)));
>  
>  	BUG_ON(count != mm->map_count);
>  
>  	trace_exit_mmap(mm);
> +destroy:
>  	__mt_destroy(&mm->mm_mt);
>  	mmap_write_unlock(mm);
>  	vm_unacct_memory(nr_accounted);
> -- 
> 2.20.1
> 

