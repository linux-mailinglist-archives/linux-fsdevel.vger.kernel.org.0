Return-Path: <linux-fsdevel+bounces-1263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFD07D8825
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 20:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239E0B21321
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B613AC00;
	Thu, 26 Oct 2023 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="0yoKBTP6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xVThmtMu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EEA1A5B9;
	Thu, 26 Oct 2023 18:19:59 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C01A192;
	Thu, 26 Oct 2023 11:19:58 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39QIFEDR031833;
	Thu, 26 Oct 2023 18:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=qY/dL0KHPv2bqjEnNnTlsETmemuksFmrB4JH4cKh2MY=;
 b=0yoKBTP6SeTwE3PoOpamCl/qurzBdscnlR1Uc+Y7NzQ93Fd4jPfNgP3D/sXbq+pjzisa
 uXbWHpoHonBDd1rFAq7XJ12gaWqmZ0aoPb2C1gsr2KZcp2qF1KcUaByyDAijMJvS+8tR
 uLyriwqCUX9NWpT2zJWOkfi1dqTwvwTHgSPFmJV2haf+PavNntczc2Wot58nLwgRNXIP
 6bpvcsrrU4GkvoPfh/fV4oM1ri2QzGBPh8Qlt0JOuwy6zEjt4+OWFUi5gFJ7kCV8sqDn
 wBVrNz54yTTHGB0/n0OCgpd0JKYz8czsfL2han7fQrYqr3NZrt1YBCBQ5Cfa0OUc3sUC qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv6pd3svw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Oct 2023 18:19:01 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39QHmRAT014058;
	Thu, 26 Oct 2023 18:18:49 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tvbfnvvux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Oct 2023 18:18:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUjbBLE99otA6qVRD6emPjr/Ol2sSELVisO/9u8bMItMsa2jgqmmUgWnK5c1+m1MZfSpom9tecSaNNqZH+el/iqQmRtTPtPYwCRnwruIC8pw3KVXVB+bHwVkLZlqi6GyyQW+NwEowr4NxsE+j0iWMbZAvM6urzJGJCrKD4hC+L+STDnqmJ5a/NMSUcAfD/2EYyC171AAkl6kpLcmkb0SdcW8T1VincuQZ8gsWINmFJCBVto0+Tcg3SJ5Wv+OP4bM9GJEGaLVVUwIIEjrThlUfpyAet3VtW+hxjJlH4bU7Edn50a1l1NRWyvnk3NYcuhEldnovZx3N5YJxZTnaPObjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY/dL0KHPv2bqjEnNnTlsETmemuksFmrB4JH4cKh2MY=;
 b=QDDRNCrqDV9aBeCV0befTG/QnSnGjxYS0qvlyt5J5iWncnLi0O3erAs3M0AxQirAgLwxHfk6RUCYxFfb1h5BFXb22ifl1hzLiAAw6UPFItIpMvPGpjZbENKGpNXjWQ+iHmK3LrmhB3zf8GAjIvHRCiyNBdFz1cMIc3bm+gRmZ1avFKT7poDG2IJGM08bANfCr/n3vMUhTNg5gopk5dzDpawJXYmKDKnKzIma2s2XZ73rAT7CJzMmNfA11AwWHsam/Y2GUsAVRObKCMXG9Flw+anGfOmywnIoFeQFjUvQ7AmBpxl82t5OAAsuseJLXYYp3aHQW6mxYWb38tKPLuAlOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY/dL0KHPv2bqjEnNnTlsETmemuksFmrB4JH4cKh2MY=;
 b=xVThmtMuX9kLzthWFmbKWXFx7Vb+dBpFNIPShHZktbHpEgkvy6T81bFXxBQORhPmKteVQQVdYIhCTKoN42ecjoZWA+DkG9BEI9gSYOLPi4lOx+IH9LovACkbomul2I0vHIvc4YgLVxansk2gPWXleaOeVtXWnSQkJYdlp2DSYFA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 18:18:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 18:18:46 +0000
Date: Thu, 26 Oct 2023 14:18:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: corbet@lwn.net, akpm@linux-foundation.org, willy@infradead.org,
        brauner@kernel.org, surenb@google.com, michael.christie@oracle.com,
        mjguzik@gmail.com, mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 00/10] Introduce __mt_dup() to improve the performance
 of fork()
Message-ID: <20231026181843.amjq27uffssn2nf2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>, corbet@lwn.net,
	akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
	surenb@google.com, michael.christie@oracle.com, mjguzik@gmail.com,
	mathieu.desnoyers@efficios.com, npiggin@gmail.com,
	peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com,
	maple-tree@lists.infradead.org, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024083258.65750-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0086.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::34) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ba20b3-0513-4259-ebd5-08dbd64ffe45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ojELAgfvLqR9yv+NKns8hF67N9Ojekjqy24iTgCbkIyyEZtJ2W29EbA2mHMzbH9igE6GhcHf4YhrgZi1IXG+QkIS4r9JsAk1t2uP4zsvG7Eg+xHtgcmOgqNZV3+lyumtckE65Nw8BsHnwaiaFu27lw0GUYOfrV2qHVrF/3hse+8yYsfd7LNAYpZRxX61/KV2RPV0c6G2y2PUBcqFiFRcolBqzaP7xlyNyOzuoUDaILBKuVu+csCtw/SP/ee+Qw21gZo/q8XtplIyM6/+MglUL+51JMwIeFiZW62uzpZ7RVHYwMfLPRggE2U6kdpmSa5mZAedLkP52d6Apc6PfVMTSNzPgl1PyakU6mqVB03X55tMAcy4FJgBm+lcD/+p0KORqPkMP/Bblb4wNxCOQ/o3vkRiEHDW+X6mcmC7U2rSyTKXOjisv4bDRBujTbcbJ4uSE5DXQ9DHq7xu0OkAxFUz1xsU2gxDdNIO6TBnhrsMqjIfxiwoqzT73Ra9uPYKnNBXZ1P7zlLvFAPYR+gILE8QwpaJQQ7dhPk9/W1Zph5W+Orjnvrs9arrobQNXAI0Xv38THs7Y5m7FoSTUjNcdw5cFw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(396003)(376002)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6506007)(83380400001)(40140700001)(6666004)(9686003)(5660300002)(26005)(1076003)(2906002)(6512007)(7416002)(316002)(966005)(41300700001)(478600001)(6916009)(8676002)(66946007)(66556008)(66476007)(8936002)(4326008)(38100700002)(86362001)(33716001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?D1ggP/luzuM7CSV1d2o2jeWWi6OsBXtMqjyVKBrMHPz+oWiz0BLdrK3k0nnZ?=
 =?us-ascii?Q?D1B8Baa+IFbsNF3ges6/Xb7D7b6uxlWOvrs0x2Zu08NzbHlW9PMgt6evJcoU?=
 =?us-ascii?Q?IwBfWG0gqabahglIcmCWvSsRhQUpiwBJx/BThh/aeN53UoqPErT2Am9Twf5F?=
 =?us-ascii?Q?h0L43nCGm2lm8NeS6r2L3GYJK7Qg7pVSVLi3TZOSccPwfL73F7qbXK+woU9V?=
 =?us-ascii?Q?RLCJRpEbcIT7ysbbXupvqTwlPH0JfJSvbcw6OSJNWkX5OfOjVemNKznEYJ4x?=
 =?us-ascii?Q?h6He2eptY8pPYpy4Qju6vyQKsb5whVwmHdzDy0p2hNpR6bYKp4AdZ4Mz+nCw?=
 =?us-ascii?Q?wRmM7CFGqbFbRJxAb1EUBJ0Vte5QqWBeMGzMB+sTshiWNV9N8lq4yg7bb1Gi?=
 =?us-ascii?Q?iwaGsr6Uv2pvlbbOEJuTUq/LPO6uwUQOYWzuEnQ2ubAjzfmXtEUcELZMOA6U?=
 =?us-ascii?Q?tde3L5GaiEEphKD2Ft+WkkfH0+86U+ZcOHUlU1JZnO1+UytCCes2q5fUzuw+?=
 =?us-ascii?Q?6SjAoWrG8irkZifdjok/9k2XZJGCNxNmTcIQoeiTUAWslz7Xgbe/9OslibN6?=
 =?us-ascii?Q?R6u03G3NJREPA5LxzYiow9pSyr1WfaC1sbaGKT1SEhYcbccSL0p9za/KKQA6?=
 =?us-ascii?Q?i2te6rcSNWs3Tk98ooJbkSREDfoLyUZvv6c+QpNwq/Xbvj0uxbKEDls19YLA?=
 =?us-ascii?Q?uUs16pPnN/YSVmohNWF8AQUdgx1Z8X3FF1x7GnEKC0b3FjZnNgxdy5981Iyb?=
 =?us-ascii?Q?c8jfxy3P5+ay/zp7xdczY+MMsy9nIDo1OIQNEatba1IHfv1lbEL+Dh4Ywoc5?=
 =?us-ascii?Q?zzwHCcTSZX6I6tC57lEA7diW/awYse3Njev2L19nWO4ZG2Jk/TXzf0Q7vQ2q?=
 =?us-ascii?Q?B2pINsMBKTH9s2ofWHrTzWyuH2UpblZNqHIHmy/1uedt7DmRvwUc3cqS6Rsh?=
 =?us-ascii?Q?a1TyVwKEFA1Z13AQ8eZmSWNt/NRTZx1s/6IP01FNZA6YHV9EYAZmO7CvwgPh?=
 =?us-ascii?Q?CcdB1dQnZIoDbJaKmi4g/pdtVFxXg2UV5BPsIzjD6uKxoihdL8DFLrcKCYt/?=
 =?us-ascii?Q?HaJLCYYR3yQQwQtaWgIsYxnH3axYtGj2gdiJK+U9AtYh7Gsi4Vd6jJISD88V?=
 =?us-ascii?Q?sLITtnPnFIlaFRaKL/mMJ79Dglga+JcjQmAe5s6Mxo6Y0YJPA/Lein3nf3sX?=
 =?us-ascii?Q?NvCtj5HbhjEnnhcW0NjSOKFs4dUuCsvb37MikjNkc27Lm7Vm5X38isq0KS7z?=
 =?us-ascii?Q?QHK2YuIPoh1dWKvogwjRmGvwDmTGqNQUZG/a+gE/V+OGF2tpyHjCWtX5bN4m?=
 =?us-ascii?Q?NchG0LGZyg7K1DOKFPDlG9akR/idz9AjuYPWVMnHbqsC9YVuSD6R0MoAzm5b?=
 =?us-ascii?Q?pUXbnyvDPmch3WSP1TBAEo93XybSQBvY7J0v/DGUicwUG9ebzDqcj0nUaaxk?=
 =?us-ascii?Q?DP4xK2zVpjmn8GCncaO4A57333RMJ5J9zoUkXA1jEY/dQ5xZB+aCW9aWepkp?=
 =?us-ascii?Q?jQMBAfKN9S4tdFHeVNn8v8524mZLgVq2YJVAfZWZH97Ny+R2pKzI/ofU+rLH?=
 =?us-ascii?Q?I6qxqPCEZQu5HdGGQM0eZQ9kDqJ/VFOg+oaQeleb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?+Uzd7IrQNgaY5eR9imxRiJ4uSSFP9PUY3PK92oG+u7iyYpOfOfbDARIh5Ft0?=
 =?us-ascii?Q?WMppHBfL9w87Cwrmx/Eg28tpwDWQA/ou8B+qihC3fNhYssZlB7A/OuAzrn/B?=
 =?us-ascii?Q?zPWoueASOcWDRNK+kJpXIRcmrg0CUbJwNyESldUkJ8XDiVKi7KtoeB2e2viG?=
 =?us-ascii?Q?v75mttjusELOVii7kVp2TBnwAlpLgfwKo8M74+VjCgTF0D4Smv/e3Q+e8wwN?=
 =?us-ascii?Q?/QZswGZEOTyVOR3gEwtwbtIn5ImdNdsctdA7hE2tabWZ/D1Dzc+/ey+nKVhq?=
 =?us-ascii?Q?7RwGWRaEdQjrqK1EubmMFIe/1k4rlpRLwyUoccDRcgeBJW2cvoVVd7pCALUh?=
 =?us-ascii?Q?zLqnkT0lF5jqk3IZvruxbHbHVw9EOF+bU83OrUX2sBLBtM1BNj0iqBDDycq6?=
 =?us-ascii?Q?r9N61uTQCO9rCsY9IMPjzY+qjxs5/xyLFwZxQwvV5S68Ueps7tdiY5eZsy3d?=
 =?us-ascii?Q?R3cF+3JgtcJ1kufLFxHMPWvy/WObNN/AhnIj5/+iV4sG5OmIyduzAkRUZs2R?=
 =?us-ascii?Q?ac0KTObcv9vGlKVuWrekRu7k3+osrVEysFPwEZMjYOl8ECE9OSLcf14yV+4B?=
 =?us-ascii?Q?BQEe+7HVoKmr7LEjUdiv5yhpanjFCdmA5zBWZ0KOjCycWP20DhdAsjz5Rfl8?=
 =?us-ascii?Q?zqEr67zOEPI2h9+M2Xf0kPXQQOiV1mf1z8ZHyDrVBX59dPVLqdUUPVSbbXZR?=
 =?us-ascii?Q?8HI+6WMwsjD7hrti9D1QZoCnjIIQLA0099MB7/szaxWnAhHHVCvv3LWw9sfP?=
 =?us-ascii?Q?WMPmyBn9BusZtt5z+eo9h71IB6Hlyeh3IN8x7xvCHyozW7UgF5Vv+wSmpP2k?=
 =?us-ascii?Q?2Xy7g151CAgD6/Roe5D+t5M2ZX2cbGbAmwXRfHyIQZF2DBeTisaJlHbAiDob?=
 =?us-ascii?Q?Gv12tyn+sS8n+c1cguii/bRbM7V5zalwv9t8TFCxbQwnFM76P6DtDSbvV2jn?=
 =?us-ascii?Q?os+tpIycyFFjvQUHyhzpcQ2jvI6ctcYMYiO/L9xg7YC03W+g04GMlhZznOd4?=
 =?us-ascii?Q?LyWN2I0ST0sVXNJIz/m23R758+1NOgZmUFk3ejhLhlOn9n1M3qE+8wrzWzun?=
 =?us-ascii?Q?qirqg217gjochDGNi5GpbUvtqW1a1/p9g4R/H+Iq4kCECd+HD/pfsPvefZS5?=
 =?us-ascii?Q?fLoWZ07Febj7WR/M6bpTKKOkkyQIk9FlwNOayowBpFYhKMfJOU7ZrK0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ba20b3-0513-4259-ebd5-08dbd64ffe45
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 18:18:46.2776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ORMNitHoYhYSJJu7OG42pTCGhvt+3fx3B+BpBwhWpaLimaGaqZu3HSmkGUuFxMyLrXGujRZwuXFsZCC1gIGLzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_16,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310260159
X-Proofpoint-GUID: QQEASqHONejCKdxy-Z75fu2bjpsM49Pf
X-Proofpoint-ORIG-GUID: QQEASqHONejCKdxy-Z75fu2bjpsM49Pf

* Peng Zhang <zhangpeng.00@bytedance.com> [231024 04:33]:
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

Besides the one comment by Matthew, this series looks good.

> 
> Changes since v5:
>  - Correct the copyright statement.
>  - Add Suggested-by tag in patch [3/10] and [10/10], this work was originally
>    proposed by Liam R. Howlett.
>  - Some cleanup and comment corrections for patch [3/10].
>  - Use vma_iter* series interfaces as much as possible in [10/10].
> 
> [1] https://lore.kernel.org/lkml/463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com/
> [2] https://github.com/kdlucas/byte-unixbench/tree/master
> 
> v1: https://lore.kernel.org/lkml/20230726080916.17454-1-zhangpeng.00@bytedance.com/
> v2: https://lore.kernel.org/lkml/20230830125654.21257-1-zhangpeng.00@bytedance.com/
> v3: https://lore.kernel.org/lkml/20230925035617.84767-1-zhangpeng.00@bytedance.com/
> v4: https://lore.kernel.org/lkml/20231009090320.64565-1-zhangpeng.00@bytedance.com/
> v5: https://lore.kernel.org/lkml/20231016032226.59199-1-zhangpeng.00@bytedance.com/
> 
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

Besides 03/10, please add:
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Thanks for all the work on this,
Liam

