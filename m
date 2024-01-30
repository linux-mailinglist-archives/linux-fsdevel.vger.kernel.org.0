Return-Path: <linux-fsdevel+bounces-9482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B106F841AAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 04:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF66287B1D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 03:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C353376ED;
	Tue, 30 Jan 2024 03:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UIplCYhQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CxhyvJfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775837157;
	Tue, 30 Jan 2024 03:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586420; cv=fail; b=V3fM7P8ZBTRUVyRHlrlukufvY9dW41JDrOuaOUIpgyWrCVkyxt9jCFY2Fii/HBJh+R/91DTjQXLhWde8//7d2Xba6MBkLLgGdRZu8qUDTC1PH+ZGGa07cDvSwqT0g5w+97+2d+d0YhLzCBtjTWWAIRcIoVLlvefawh8sTWbQ7nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586420; c=relaxed/simple;
	bh=qKv0qWKZMI0y5YjIOm+vNrOVzt04LbsOxjLupdE0P3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VjmH80khloYSW335tr3GR9eLeR+zGV/1HH+8dbLBFv/StyV+t/bvIHshHvZaiScHcoqgpcZ0zuzRHCByh9uefEXrSJTnfzKVKG3GZjYHEXyK+Qp45g/VXU34+kbrP3uqwvP5MyGcyjz9q1Ook0bQ/LVYYsKZsYKBIHQXezj7Kzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UIplCYhQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CxhyvJfr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJi0IW016634;
	Tue, 30 Jan 2024 03:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=FVKRH1bYmd1vthirLQAOpnlOP710fZnpX8MNpGV6j6I=;
 b=UIplCYhQKvWIMUmoGncN+xXd8z83Ico/GX4WOEsOxjQMyNoMl0/E5BpOR7FkRO0vhRmu
 KrhTlDe11mKmVbTF7aMy0u3U+BzuLqRslqrYuYlTKId2uB7XW+ccq/sE2mYmaJN+RfGS
 Yj5bZme7EuAQPGH8VRHIzisOiQOP9+gfPSBFv2ZEPkun6kJofHE+6J51Cei8bQiAd5y9
 Bp0hHS9GJ9Fe7DKFij1CZzSnu4saAANWd6MxMoo2uosRi2FtmuooCKR8ElX2rd2k3PiP
 2ac+pIWdtTQJel3zmqlz2Sh0DUImKjgjKfpWN/9K+iND9wjZXG89oFjpxuAJ/OdkCjfh yg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseudh4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 03:46:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40U20Pxt014474;
	Tue, 30 Jan 2024 03:46:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr96ht1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 03:46:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQxWghuSCPwq4I675QdHKEUzV0DBWejJLB/19nJYHJ97Ap5lYYQMEyIeadctDBC32ldjVcNknlTig5wiKLnzlPey8DUmxzDqm72Ifu7cri+hkgV8E0zoCuY9qaA+44u1k649Ycyg0WZrle+TlI3ZDZIwUgYDK8z9jgeyY/PgtpTrnrSTbURkVa3z7Ke021aodDLZHgiWTU6MSMgNxOcypZWBsoxOOUA1LVjvaPd/5yJI01MBJZ0d+j1eL7tfczI4Hn4EttnlwsN02ZEEK+4Gd78K8R9HuWlt37U5HBNn9TZJ55D6RDTDvpaB+neeJsf5ZO71MFRJgAbwWBKlRQQfkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVKRH1bYmd1vthirLQAOpnlOP710fZnpX8MNpGV6j6I=;
 b=KxyJF5kMVbLIyZYSJSlh6BY81uRbBUhwA9JXcFYPNeHrROzrdzt3ntDUiKJc2IeHruDGi6U+KAmnXWVoDA6gmwe0orxmXLyNXhutYjuUxae5uRtA6DbdYbh98X+PaBBdTIeNb7sN0RV97DQu3Pz/xSkEachx4o0mmm9dahfBQ9fuoHaygDWghw32PbPI+dYgmsiM8O9yx3tx9zWUmhOBzt6/CwPFX59kIkL7ma2s034fzI1nTY4BsF7HhVWQneVHd+BQTOgFANQi4gGCP502ifQjkkL5Vmh4+CdB3t6B4a9l5Mc6qOWWW0MheUxoqtUUJBewErWMItMHzLFccLS3+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FVKRH1bYmd1vthirLQAOpnlOP710fZnpX8MNpGV6j6I=;
 b=CxhyvJfrjsFhkk1Zt75nHfmDoClREnCCS6hxaCCgRr1aZc62RPn104EP4nIcUWHYyoiVnqRxLE5oAxHi2kfC0wgOzIx9Y9CXnS/NthH4KItwW9M1EtCG49PDlTUW7QilEqHHyeiHym8IgL8x69qNzaZOXRybatYLzGIiaB6wpHQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BLAPR10MB4947.namprd10.prod.outlook.com (2603:10b6:208:326::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 03:46:30 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 03:46:30 +0000
Date: Mon, 29 Jan 2024 22:46:27 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in
 userfaulfd_ctx
Message-ID: <20240130034627.4aupq27mksswisqg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com>
 <20240129210014.troxejbr3mzorcvx@revolver>
 <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT2PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BLAPR10MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f449012-f730-407c-7e01-08dc21460b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aZyTzVKwgEwE+KYs5Wew4Vk1Zz6PLhP33AUXP1UkRtAV/12MhVJa06WeLQVFp6c4yqQl9if3ziHCnouWg5jMhrA+o71ty1YPQbXJ0TiXOyKz+GUtA7Fq0lcB7i4wXPOW3mwR6wYSLEi2Ojhq50HcW4bSZUOrXk/2DWkI2LH7/ap4bhNypYmQeV3WWskCtpm7CC5Ap8Ue68qGbTdIPWQeqpWUkJZAwyNaL4eQuAw8YCae24HAuewawlPOG+yLCnXaK4B8jfbxfKPd9kFbMAsyYKoU83x7u05Orcj6IOfNBkdDpSxeejKZOSn0k7AVCk9xJ84ez5sdnicWbDpyUprlbESJHcknTSvwrHdsxyU5ltB92XXCbpMQVSxfCJgu8cWHDDOay5uTrd/tZLFknaVZ9/pfUpwp3j2Wee+1s2EGLxRlBwepXQ6em6i+eEsAaSGzIqvrnhxq7DMjuYH21PCgQSTMrBoOUxssyqEGMXulknTz46oOQ850gS2aSuBZpD6RW7L9MuFyOKcRx4+oQoy0RBYB+p1Qgmn/2EyAEEJGC3ieMY0Uacr5/LBC0DNS0sQ4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(2906002)(6512007)(6506007)(5660300002)(9686003)(53546011)(7416002)(316002)(6916009)(66946007)(4326008)(8676002)(1076003)(26005)(66476007)(66556008)(6486002)(8936002)(38100700002)(478600001)(86362001)(33716001)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWZBTjZlaTlXd0N2M2VrS1NPRG5DZytwcnprMTZxdDNCWWY1dzZReVNNYnk0?=
 =?utf-8?B?UlQ5U3hnN1pLV1BSVlhJQm5BVmdEKzE1S1lpYlp1UDllaTExRXZaUkdEV1ls?=
 =?utf-8?B?TjdtSUpKUVpwblJJM0tyQzNDRUVJekJoZ3h6STU4NFRQaXQxZEdwNWpIT3VQ?=
 =?utf-8?B?R3JvRXh5S0U5RkRzTEtnTHFCc3JvNm9naGhxN0hQcE5hQWwxNE5kVC9mbzRV?=
 =?utf-8?B?ZU1SaXdCK3R6WGNTZ1FmbXhiRzU3aUEyQWZlR0thZ3FpdWdvd21kekVFYkFC?=
 =?utf-8?B?Q1lNbGFQTnNuMngzLzFZTnZwRThNcnMveWVHaFVQNWJ6S1M2Zk13R1ZtYjl5?=
 =?utf-8?B?R0Fwa0dFQS8zSnVtRll6TEk0cFRTSDhqVzhSUXhoanhlUUYxbFdFQkpyTGJJ?=
 =?utf-8?B?VzlIdkY5aUtsTHpSWjNSQVJWTjVMRWQzd2tmeGpUelZ4SnFuQk1sUWFJL2VU?=
 =?utf-8?B?YlBDMWF4RjRBdFJVVmxPSHIxMDhnME9yVWdYOERKVjV0YWhRM3dxVWIyZkl3?=
 =?utf-8?B?blViVzJJWkRhNUZJT0pnYUdGUG04anEzdUsya0UrdFpJdVVjTHJqTTNwbmhm?=
 =?utf-8?B?S2NOeEl4ZlZuQUVQN3phdHlwaDRObU14VEhIR2ZyK1o2QlFNbTg2MjVBSkRL?=
 =?utf-8?B?U25wRGlHZGdYR3BnK0IwNGxraWpaMVY4Y1VTVGlaQVl6OFF2eTlHVm8yZERS?=
 =?utf-8?B?aEZLMkdjb2htTUZpaUtlNzd6dkcwL05ma1pCL2F1WURxWnQxVHRyYUdnYXpZ?=
 =?utf-8?B?YnMwc0tFbzgreWlQdTROT1B5Q1lOMDNwdW1GMm93VmpENW5Fd2FycnB3RzNU?=
 =?utf-8?B?M2ZSYmxzeTlhSkxWemlIanVSMmRyNHhlazZaSU9zeldZRkQwNFpOS0plUTcz?=
 =?utf-8?B?dHhjN0VoYkFVK2xyeU9vR3ZlUXphRFk3cGNXdG9JNi9WQ3BTTFA5NmVuNHgz?=
 =?utf-8?B?ZCtqbDdibHdJTk5wU1ZQOC9hSkxIUVdtNEFpWUErOXdVZEtyaXI2OURPM1lm?=
 =?utf-8?B?dlFkSFZyR0ZGRUdFbHBxdExJVHozQ3c1bVZVUGVwcmdTZGFkMWJubG5rZVYr?=
 =?utf-8?B?TGtuZmcyUmE3V0pHTmx6d0t1OW1Qc3Z2NXBwbkIxVXdpTHpSUnRDQVE3eUxO?=
 =?utf-8?B?OFhNWE5HWVUycGRYT0l4cFUwbFNLMGljYUZzTDN1REdoQlFTSW11OWE5TUpR?=
 =?utf-8?B?TGd3VVJnV0JoWSs0WDQ1bFdLaEV2RDVsczZnZm9HaW1uL2U0MS8rTjhLd3lO?=
 =?utf-8?B?NWI0WDhpQ24yUkQwQlRDeUFZRkg5MytMWGZjMkt2QzRTdlA1VTkzSlBjaEds?=
 =?utf-8?B?TTFJdmZHR1FlNkhRL3ZsR21wNXNDclZMYXZmUmdtYUJLRDQ5SVh5QnFnbXRH?=
 =?utf-8?B?SWdPNUxTblByYlduU2lzcWlYQ0lFZDdWNzF4QkVDSHBTcXV0aWllaTdNVk14?=
 =?utf-8?B?V2lqam02MkNpZlM4aGFQTThhOEtuU09JOTIyeUJEVVk4UEtEY1E4djV1Q2o4?=
 =?utf-8?B?MlI2bWIxYW9Oa09ieTllUnV5YUd1YXQ2NWxacFpPY3lBTlEyeGRHNFpZSzFr?=
 =?utf-8?B?NkZ1NEYva1VPNktsci9oRU8yMmFPTWhySFZSZUR0T1JaY0MvTDN6TEtFOElD?=
 =?utf-8?B?bXBzK3BoejJ0QjZpajB2RGpPRjd5ZU0rR2NoTWVDVXRINkdjaitQRDJOdFNN?=
 =?utf-8?B?OEg2SXVDdDEyMjV2UisvZ0VEdEV1eFJKUTRkNHlHemhTRXliWTdDMkc3Nzd3?=
 =?utf-8?B?MTdOT2JYQmh1TzVhTWhscm5xeTV3eWRXL2hwREpvWDJVWVBpWU1XOWE4NlFm?=
 =?utf-8?B?YjdLaFNjcE0xd0lkZFVGUEY2cnYvMXZYTkFIVHBjdmRPZTJJbDJCTjZTRXE4?=
 =?utf-8?B?L0NVWGxnVmEzY3hSell0TENZaXR5eGl6VDNCUlVHQldwcGFzSGdzbkRLREcx?=
 =?utf-8?B?Y2p1TURpcllpUnBoaGFmRXhjWlR3bStiWkd2eU1peDFuZElpRlFEMm13eVFG?=
 =?utf-8?B?NEZMbnFrM3NZOG9qUFRhVjlEd1FHc3dJaU5sNjIxdlRLTU90N3RQZE94ZytD?=
 =?utf-8?B?OEI5clgrS0ZUb0xKWjdQSkNuem5Gb0s3bWhabDFidlBCYzZ1VmRueTU0ZVNY?=
 =?utf-8?Q?CDBOpUi503SWGOhelmwzT9/nd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	h2UIbSnlnD7XGre2Xw9fksQhnalzaNpJR0QeC9IGsIK6vhZFO60q7WYDxeTUJpTwNbVxH8MXy3QNpsLVFQOamRjqiac4sLrL7jExRMLeBM23/qVQ+mh8s7Hsi7VtOiNrmEJF95vKlPSxFXfgt7kFkdIwv768JipuKFhxLWu563L/goVTTnb5O3JnvLJujB+27eZ5cRTJmnlBwy8OzeK9TbF6NjKJxJ8piPlSV83LG11xSgDQu6aehDeSZ1ryMg0qd+tNcTmBRdp37yJ0F33Y0Q6semzqoWJutee0ggg4I//vVNHAekInE67b4ZrzrFKkr1G1VIyHueuo8wzPevaISYgGxBGs00lRzT4MmNnWmlZyid+EZoox0jLZOjWU8TFStN4QRIcVvd/X/jPvI2dICYGqx8pMOAdmfV5+HT0vYVph0/h4+EzseIrnZDMEMJyuQq8To++iAX+Cg2UsEWF1hKquPWBGsd+JaF5F7i/88Agbwi/SPLqddXiP3sWiu697wSDGVNVAm18UnK3fDeGGR7wdNhp2p19JYe8e8jtcyKiY4SGO6E4YsTwsge8aaN92GoYbdR07VLYroT8HU3zc80u/fdyJ7bSEon527VCBwtk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f449012-f730-407c-7e01-08dc21460b37
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:46:30.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6GwaYxV3Ndt6J9luxdUY7Jl6CNiPWAs9g6bCrCBXOsM1n06+/1dceMpsBk5JNYUihBYRZ10V0R8Xr6k2I2XMdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300024
X-Proofpoint-ORIG-GUID: ldWyDb6ZIBxMYu-fmm8zedDxCHuAyKeQ
X-Proofpoint-GUID: ldWyDb6ZIBxMYu-fmm8zedDxCHuAyKeQ

* Lokesh Gidra <lokeshgidra@google.com> [240129 17:35]:
> On Mon, Jan 29, 2024 at 1:00=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240129 14:35]:
> > > Increments and loads to mmap_changing are always in mmap_lock
> > > critical section.
> >
> > Read or write?
> >
> It's write-mode when incrementing (except in case of
> userfaultfd_remove() where it's done in read-mode) and loads are in
> mmap_lock (read-mode). I'll clarify this in the next version.
> >
> > > This ensures that if userspace requests event
> > > notification for non-cooperative operations (e.g. mremap), userfaultf=
d
> > > operations don't occur concurrently.
> > >
> > > This can be achieved by using a separate read-write semaphore in
> > > userfaultfd_ctx such that increments are done in write-mode and loads
> > > in read-mode, thereby eliminating the dependency on mmap_lock for thi=
s
> > > purpose.
> > >
> > > This is a preparatory step before we replace mmap_lock usage with
> > > per-vma locks in fill/move ioctls.
> > >
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > >  fs/userfaultfd.c              | 40 ++++++++++++----------
> > >  include/linux/userfaultfd_k.h | 31 ++++++++++--------
> > >  mm/userfaultfd.c              | 62 ++++++++++++++++++++-------------=
--
> > >  3 files changed, 75 insertions(+), 58 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index 58331b83d648..c00a021bcce4 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -685,12 +685,15 @@ int dup_userfaultfd(struct vm_area_struct *vma,=
 struct list_head *fcs)
> > >               ctx->flags =3D octx->flags;
> > >               ctx->features =3D octx->features;
> > >               ctx->released =3D false;
> > > +             init_rwsem(&ctx->map_changing_lock);
> > >               atomic_set(&ctx->mmap_changing, 0);
> > >               ctx->mm =3D vma->vm_mm;
> > >               mmgrab(ctx->mm);
> > >
> > >               userfaultfd_ctx_get(octx);
> > > +             down_write(&octx->map_changing_lock);
> > >               atomic_inc(&octx->mmap_changing);
> > > +             up_write(&octx->map_changing_lock);

On init, I don't think taking the lock is strictly necessary - unless
there is a way to access it before this increment?  Not that it would
cost much.

> >
> > This can potentially hold up your writer as the readers execute.  I
> > think this will change your priority (ie: priority inversion)?
>=20
> Priority inversion, if any, is already happening due to mmap_lock, no?
> Also, I thought rw_semaphore implementation is fair, so the writer
> will eventually get the lock right? Please correct me if I'm wrong.

You are correct.  Any writer will stop any new readers, but readers
currently in the section must finish before the writer.

>=20
> At this patch: there can't be any readers as they need to acquire
> mmap_lock in read-mode first. While writers, at the point of
> incrementing mmap_changing, already hold mmap_lock in write-mode.
>=20
> With per-vma locks, the same synchronization that mmap_lock achieved
> around mmap_changing, will be achieved by ctx->map_changing_lock.

The inversion I was thinking was that the writer cannot complete the
write until the reader is done failing because the atomic_inc has
happened..?  I see the writer as a priority since readers cannot
complete within the write, but I read it wrong.  I think the readers are
fine if the happen before, during, or after a write.  The work is thrown
out if the reader happens during the transition between those states,
which is detected through the atomic.  This makes sense now.

> >
> > You could use the first bit of the atomic_inc as indication of a write.
> > So if the mmap_changing is even, then there are no writers.  If it
> > didn't change and it's even then you know no modification has happened
> > (or it overflowed and hit the same number which would be rare, but
> > maybe okay?).
>=20
> This is already achievable, right? If mmap_changing is >0 then we know
> there are writers. The problem is that we want writers (like mremap
> operations) to block as long as there is a userfaultfd operation (also
> reader of mmap_changing) going on. Please note that I'm inferring this
> from current implementation.
>=20
> AFAIU, mmap_changing isn't required for correctness, because all
> operations are happening under the right mode of mmap_lock. It's used
> to ensure that while a non-cooperative operations is happening, if the
> user has asked it to be notified, then no other userfaultfd operations
> should take place until the user gets the event notification.

I think it is needed, mmap_changing is read before the mmap_lock is
taken, then compared after the mmap_lock is taken (both read mode) to
ensure nothing has changed.

...

> > > @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_struct *vm=
a,
> > >               return true;
> > >
> > >       userfaultfd_ctx_get(ctx);
> > > +     down_write(&ctx->map_changing_lock);
> > >       atomic_inc(&ctx->mmap_changing);
> > > +     up_write(&ctx->map_changing_lock);
> > >       mmap_read_unlock(mm);
> > >
> > >       msg_init(&ewq.msg);

If this happens in read mode, then why are you waiting for the readers
to leave?  Can't you just increment the atomic?  It's fine happening in
read mode today, so it should be fine with this new rwsem.

Thanks,
Liam

...

