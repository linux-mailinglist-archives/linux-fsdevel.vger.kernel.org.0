Return-Path: <linux-fsdevel+bounces-11126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5B68517D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 16:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 734AF1C20D9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7D53CF46;
	Mon, 12 Feb 2024 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ihNrt5Bu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qJjJpGnP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542333C087;
	Mon, 12 Feb 2024 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707751260; cv=fail; b=i/bBLq3lFEfl8a6eKwM7KWM/kTdl39ngLqGWZuggqi0ouz61lto3vXYMs2QSMLcdRDo5sFTjELXtcar0Yua9SVK9ijcLLWwjxLMXAsHSRRN4L6xMRgHfP7a126u1yZYfJQuYBiBaZcQqsIBs9TGuWqGyLZT2CGjYo9ngiNzMFDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707751260; c=relaxed/simple;
	bh=50i/WZvLJ5TrOQ8SGBnDjXFoyWAoeM3rHC/EWnTVtUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YU0T25tWCGAlPeY/cASkGxsHd/6phUBooNXJ7UBoXu/pQmiM8FSI6TW0pY0BKEbhEQiHVOXXJvK9vivMoD9MSdpjEomdQ6YGb7R1OjGlPfSYdJlZIl3lVf0+fr/fJ7v4pxDJAaaXk4QtmHTnya3XjfoGVg7OY4+TeQssY33Pm20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ihNrt5Bu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qJjJpGnP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CFAS3I016768;
	Mon, 12 Feb 2024 15:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=iSZcYIA+ICij99YcMN3ksduYDeM2QWndvqBSZNjV5/g=;
 b=ihNrt5BuESOFgS7gPA+GhTQ/XOdMXMHe/MRWr/dDFNGBtGoY7qfBTiQAuTdsu+p/QGI4
 OVcLNAL8B6EV3JhfZalQ/T+shzZGXoHb/VqHTCw3K9q+rE4xxyK+iE/BqUoNXQ2o+EDd
 QCANGaaEBsMQyrP7V+7osZW9LoI5q1lF62fDFLaNB2yDOV0xVHiFbKN2h/K5D1FpX8C9
 URPsF4UTo+PzVWcs7DlpmuO2GlHHTdBddqW++ZodY0bPl06Gap6akrq0/9XXltKaCXBq
 MUs+3ozYbamxwlSkXoTbXyXNUM7qqXGpI+Ti0au7dCU9crhZ09eJZBWDcnhoXI0BzJJx bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7nqy81h3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 15:20:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41CF2vT9024673;
	Mon, 12 Feb 2024 15:20:04 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykc5fuy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 15:20:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8/4wUOMs9xkAd0ZEje5NdI+apJrQf/nWyJCLRgEOBqrjGMEyq3iF1F4OwWx5UQuHrUyxl1GCkU96YJGZ3A2dai2zjVb23fuSe+TwkX//E5f7bCp9RnAPMGJYmJsPSr8VkT68nSv5BuUKAaG7C2EULKkU+EyThGxkFnXUl1Q7wvKknyA1cwcNhmh4fMQALCe9XhkolePoMfZf1rGrtCO5EMIpu99GqcPXBmH7+xHXFeGPJOIUkiYIVeiOknAUmcltns55EE7J00eyQzqaD0tdOTMMihxojWKp0J4QhT1HyGD3kmzaDb/PymnSKJ9YvchIdMPZtU1GYb35jkbTIwHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSZcYIA+ICij99YcMN3ksduYDeM2QWndvqBSZNjV5/g=;
 b=WJbacKhaBdnS0uapsENG6ir6rC3zT3R6NhpwzDmkL8zC4z8gNBvR3ArP5g1x2lfAOPgDC3oJlA0Zru50VZB/kUhH02IjljeLuivuIv+1ToGnchW+XZIntqJtkxOU/ggVdQUj0/NWewsIT2aYYqYYP9wiyHgo4crLHL4HhSoygqUEzjO7zOiLQvxXDO1uBXjceUwBDHo7JTqHwh2fh5lOzcpLNxca8gqzVDCKsUpN1mzIzWP0ppJA5HoOHlcV3feTpa48qtPDK5AMK3D0UaMm+y2t43PgDcvOCm/ZEzQ20FCPNOuytWmG1wChsqZPbwbN9nI+UN5ZCMsNB5tqnmwt2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSZcYIA+ICij99YcMN3ksduYDeM2QWndvqBSZNjV5/g=;
 b=qJjJpGnPwmXl8cCQjVDL6KdR5RYsRRDhjdS7LapPdYd20NOKpMOVoYZOG9qc5vjwbUqT70JgX3qXSC6yQRuLuwElQfEcU8vzwBwxgSfCVAThZdbck+6xkqzT85BoF61Oe5ukVt6Qk0ssXoEH7Zdp0JcQpAfPtU+TJNf4zM/Ad/k=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Mon, 12 Feb
 2024 15:20:02 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 15:20:02 +0000
Date: Mon, 12 Feb 2024 10:19:59 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v4 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240212151959.vnpqzvpvztabxpiv@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240208212204.2043140-1-lokeshgidra@google.com>
 <20240208212204.2043140-4-lokeshgidra@google.com>
 <20240209030654.lxh4krmxmiuszhab@revolver>
 <CA+EESO4Ar8o3HMPF_b9KGbH2ytk1gNSJo0ucNAdMDX_OhgTe=A@mail.gmail.com>
 <20240209190605.7gokzhg7afy7ibyf@revolver>
 <CA+EESO7uR4azkf-V=E4XWTCaDL7xxNwNxcdnRi4hKaJQWxyxcA@mail.gmail.com>
 <20240209193110.ltfdc6nolpoa2ccv@revolver>
 <CA+EESO4mbS_zB6AutaGZz1Jdx1uLFy5JqhyjnDHND4tY=3bn7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO4mbS_zB6AutaGZz1Jdx1uLFy5JqhyjnDHND4tY=3bn7Q@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: CH0PR04CA0097.namprd04.prod.outlook.com
 (2603:10b6:610:75::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 7798c8ed-e688-4b59-ff4c-08dc2bde157d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YyuhO1ByXRgy77T0K9cKHFBb1bpYTO/aFxL3QQl1UpTtb5y7JwDTt6kPDWlOR9Eg64mYD2aoXCs6jaw3NN2PW7b8W7kmUyL4q34BXk2FRNGE2Dgrz4GO8X2Z7FzR9C14ZKyYioW/OYWAjyJIScaA9v13XZp0JLvNuYkupJ3TlUGpbuGFz7m/SWcSlQaYJSL+SLAffEbSSFWGZFoq3sgsnL3R4htu1lP8Lv2l4Tu3m+EgbE6nHifqUSRSATJsDFePii4IQpoTp7wvJ9zzwrpBpjKVbjb/U8rXzEAFOPjPti+Mvea1WA17nHxygqK8wbXZsGZJfUN+E44V6s1UgTVvysLEVBHccJ7opvaEi5eNnoTLgmyHi6PyQXKbm+BLBMWHbtkW+S8ekWDn3L1Kj/IwMigokJ0QOKi7EfJVNzvvcDx1lH7+Icv8fUSJrhmpeWY1W7b17LZZVGGEjoswBWfH2MXWqCWmxy7ySBjDF4C5oEmIHBn35E9KB+z2LpqIRi+/pP4PmWCizSMvm2iYNTCw4F0tgVavwsyXqvE5sxzkPfZMAC/hYe5KvbeED296RpDN
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(33716001)(6486002)(6512007)(9686003)(3716004)(2906002)(6506007)(5660300002)(7416002)(86362001)(1076003)(38100700002)(478600001)(53546011)(6666004)(316002)(83380400001)(6916009)(4326008)(66476007)(66556008)(8676002)(8936002)(41300700001)(26005)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d2x5bEZkdzgrSHErZEY0Z2RlZjNqRjEvekhGSjNrdmY5djc4dDkwb1pNbHQ4?=
 =?utf-8?B?SjdkVUNpaDZrL21nbDJSNVFySkZ0aFhBNTdCaTZXeEJMMHRINmh4d2xXakZ6?=
 =?utf-8?B?c1ZyR2NTbHRtNFVhR295SmdSTnBpNTB3NDNlckVuM0pNRDd1bHZqR1dTR29Z?=
 =?utf-8?B?RkVmSkZjZHBoL2crVEtBd1MybXNBODJxaUI3RWw4R0UzU3F5azY1L2RJV2sy?=
 =?utf-8?B?K20vMVdEeTlzcEhjbENQVStOTnEwM2pWaDlPU2MyWUVDbWNmUEtyb0E4dExn?=
 =?utf-8?B?ei9DY1NBZXhCQzlyS3NlbHRjUnlmN3JTNWYvWFF4U0hpeG0rZ1dORE9hOU9I?=
 =?utf-8?B?U3NVZGN5bG0veU5yTWM1YVpvWkt1QnN3Q1YzYTBYRWRzbElHSWlzWEg4ZmJ4?=
 =?utf-8?B?ZUtPaWZhd1ZicTVIZVRDWUNPWVU5dHVvOXR5OXhOb3VIc3ZuUkI0TzBKNzhS?=
 =?utf-8?B?V2VMRnE3aFpaVnBXUUZvTFpxR2hwazFPUHRXNEMrMzFHTCtQWk9ZVENpbmIx?=
 =?utf-8?B?Z2ZqVEU5MmY2d3hKaWxlek5ldVlNWVVzdE5kTWEra280eUhUbnNqQUplOXA1?=
 =?utf-8?B?Z2lmN2x6cmZweHhhaFlRTUx5d1dVbWFBcTJDWm05ekUyWDh6Vmk3YVJ4b0ZW?=
 =?utf-8?B?anpTVTU5WERLTUpZSkdjb2NZSUdqczErNm5yU1ljQ1JXcWsydzlYLzQyNXIy?=
 =?utf-8?B?STBkenN0YkdTd1U1NEtmeExITTlJYU5SK1FTY0h2T3loWWFrcjJucmMyVTJT?=
 =?utf-8?B?c2I5aXRqK0pMZHpSV1pmclJXbUJLcGpoTk5jQzBFWlEwQUFmRGFFVzBZMkov?=
 =?utf-8?B?SjZMU202N0cwMTdKSmltd2RGTyt1aW41TlR3Q0hZZ3JvL3pHQW1NUnR5T0ds?=
 =?utf-8?B?MzJabTIvdmdDM1pQbFpLWndkdXhBa2d3aHVtU2lCdjZydTNiV0lJaEkzMFNt?=
 =?utf-8?B?bHBXeHdDemN2MHhaMFpoRWxaNGF0cUVIWk9xRmJ4YUtPN0dUak5kbk44YTRL?=
 =?utf-8?B?dDJWVWVueTlTZnM2bXluMjBIUDZydnZDV2JldnlqQ1BiczlITW9wb0g4N204?=
 =?utf-8?B?WS9XWERrUXYyTVEzZzVhUThTTU5vZ2FWNzgrQ0tBVStNTzEwWTZQdG90aytJ?=
 =?utf-8?B?M0ZFRWZaTGJsNHhDdlFKcXdrZVZpSlI4RC95QTBlbm53MUdtMHJReklIcU05?=
 =?utf-8?B?cjFWTmlQT3ArTHhFQXUyblVmalk5Tmt3NmNqRWFjaDZtNGE0K3NjMWF5UTFp?=
 =?utf-8?B?ZFYyYmRLU1lhM05YUUxrd2RvUFh1R0RSajMvMEJJOE5wQ3E5K0M5QmRQa0RN?=
 =?utf-8?B?NWpIOS9BMHpzWHp0YWpreCthNkhvRWtpMS9MeGtQVUNTT3RqUE92bVVYN0Rq?=
 =?utf-8?B?dkF2ZDE3cHNmZDVHeUlZclE5Y3phMW4wNVpwU3RhbndsL2xvamRnbmVoNStz?=
 =?utf-8?B?bTlkTG1kK2VQQk5MSXVCVFpXOGFLV2JQTmRLY3Z1M1B4M2dpZE1aN1pKK2ZF?=
 =?utf-8?B?YXlxbE9pUnpZK0pKSnpGQk9yMmZXNDNoNXV1U0JIMXFzbmIrdjg0T2JnakVl?=
 =?utf-8?B?Z2thTzVXbDZIUWxEaWFGNVE1eXZqbThmcGRmTytqcW40STllUWF0VXd3RTdP?=
 =?utf-8?B?YWxQbTArdkJhYkNDWFA3TjJjdk5DU3d0b0ZNcWFxRUxHdE44T2wyZW9lLzhZ?=
 =?utf-8?B?b0puYVZpdlkyQ3M2V3BqK0FtbDNaelI0dnI0N004OXBidFQ1VVR2S1B5SFVR?=
 =?utf-8?B?akFCUE1OYVp4NkVTblNFZWtZTkV2a2M1WXNDaW9Md3Y2YnVlbDVPNWo3dWVH?=
 =?utf-8?B?K1BNcldJV0FXWllidnNPZTFNcDdwd1hSZG5MSkx4WXUzZU1vZ043RzNxTnF3?=
 =?utf-8?B?cFBCbGJZVmFDaE44V2xHdktKV213S2MxRHdCZHdyMmdnSHdNUG5sOXVNdFRy?=
 =?utf-8?B?WURTZXpRcTZuSzFRYkdQT1k1bWl6aVh0OTIzZW9ROU5kRFNaREkyUzgzd0cw?=
 =?utf-8?B?a01aMU9HTHQzRHZZYTVjMzljRDlpQVJJNVkyRmlWQVg2TDZldXVZSEwyUWNN?=
 =?utf-8?B?UWQ3L21keXhJdVhHSFVvT1hKMVl1Ym1ZQTg2VUlrclNEWTBYUGV3VG0yMUpn?=
 =?utf-8?B?b2hyY1pPN2ZUK1YraGRoK2dZSUFhZDdTZEhhM3lsVFZ1WmxSRUdjWU1VRHF0?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3FJRCSPOGOOq7E0uhlhqBtBdXNveyJ4SFJBy/C75g/VHJoItNlMzz8R33ipeMD4ZK5vXylyAK0wp83TptgrxB15Z5SKirG7X8wbgUIamBrsFFCZfkDMZvAaO/8mQmwuIAHPKsamph4l/9vI/d/1Q3Kw/tDqPgu9CgFuoLu19tSyhIPPnlSWelvVHCtU6iSARdeF66x/MFmxREi9EnOOeGH72hGeIDHvjm/KkJH3CiKoOMvRhjoWStfozyAn+FsOS8dT1EV4RnGZpxIqtEK6diL/ERsuRQwtT7IZvAok4E7MkaM/pdniMcMHEWnTmfYjaDK4HEfCfdq8Mohqc5eFHq4brH34lDCM2fSymDbXRR8tWy/KTVSOFgfFOyi1NTl+bB9u30AgM/xQSlnuEGsQolWvq9QTT/KD6X12WkGCI98g0YMXdFPl+RyNWJSIxg3Njr6deoZhCX+ipyAHSSgY4yScxYMC49G09QXvpFCA5l5SNWJ/KY6FjXFOyP+h9NNtVkZOyKip4r2tCAsmuniS7MKU3YvF1WSpmZIvRuXFGfZg/xlSDk+fuOobRoRRFZndc5snwZRq7wrJWjU8hs1vc9JJoCYPhAbM6Pw27YYAyjmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7798c8ed-e688-4b59-ff4c-08dc2bde157d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 15:20:02.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2leYuSC0FVpDf1OkEdZHGuH/pfXILmRybkHxDub5GuNDCnYWv82gVQ351Rzq3DdsAKbci0/Kk1hmX5E4fk/U4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_12,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120116
X-Proofpoint-GUID: kyyaKQjJHgqehKbZz9r6FLhxQXP0hbbz
X-Proofpoint-ORIG-GUID: kyyaKQjJHgqehKbZz9r6FLhxQXP0hbbz

* Lokesh Gidra <lokeshgidra@google.com> [240209 15:59]:
> On Fri, Feb 9, 2024 at 11:31=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
...

> > > > > > > +static struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > > > > > +                                    unsigned long address,
> > > > > > > +                                    bool prepare_anon)
> > > > > > > +{
> > > > > > > +     struct vm_area_struct *vma;
> > > > > > > +
> > > > > > > +     vma =3D lock_vma_under_rcu(mm, address);
> > > > > > > +     if (vma) {
> > > > > > > +             /*
> > > > > > > +              * lock_vma_under_rcu() only checks anon_vma fo=
r private
> > > > > > > +              * anonymous mappings. But we need to ensure it=
 is assigned in
> > > > > > > +              * private file-backed vmas as well.
> > > > > > > +              */
> > > > > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED=
) &&
> > > > > > > +                 !vma->anon_vma)
> > > > > > > +                     vma_end_read(vma);
> > > > > > > +             else
> > > > > > > +                     return vma;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     mmap_read_lock(mm);
> > > > > > > +     vma =3D vma_lookup(mm, address);
> > > > > > > +     if (vma) {
> > > > > > > +             if (prepare_anon && !(vma->vm_flags & VM_SHARED=
) &&
> > > > > > > +                 anon_vma_prepare(vma)) {
> > > > > > > +                     vma =3D ERR_PTR(-ENOMEM);
> > > > > > > +             } else {
> > > > > > > +                     /*
> > > > > > > +                      * We cannot use vma_start_read() as it=
 may fail due to
> > > > > > > +                      * false locked (see comment in vma_sta=
rt_read()). We
> > > > > > > +                      * can avoid that by directly locking v=
m_lock under
> > > > > > > +                      * mmap_lock, which guarantees that nob=
ody can lock the
> > > > > > > +                      * vma for write (vma_start_write()) un=
der us.
> > > > > > > +                      */
> > > > > > > +                     down_read(&vma->vm_lock->lock);
> > > > > > > +             }
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     mmap_read_unlock(mm);
> > > > > > > +     return vma;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void unlock_vma(struct vm_area_struct *vma)
> > > > > > > +{
> > > > > > > +     vma_end_read(vma);
> > > > > > > +}
> > > > > > > +
...

>=20
> The current implementation has a deadlock problem:
>=20
> thread 1
>                                      thread 2
>=20
> vma_start_read(dst_vma)
>=20
>=20
>                                          mmap_write_lock()
>=20
>                                          vma_start_write(src_vma)
> vma_start_read(src_vma) fails
> mmap_read_lock() blocks
>=20
>=20
>                                         vma_start_write(dst_vma)
> blocks
>=20
>=20
> I think the solution is to implement it this way:
>=20
> long find_and_lock_vmas(...)
> {
>               dst_vma =3D lock_vma(mm, dst_start, true);
>               if (IS_ERR(dst_vma))
>                           return PTR_ERR(vma);
>=20
>               src_vma =3D lock_vma_under_rcu(mm, src_start);
>               if (!src_vma) {
>                             long err;
>                             if (mmap_read_trylock(mm)) {
>                                             src_vma =3D vma_lookup(mm, sr=
c_start);
>                                             if (src_vma) {
>=20
> down_read(&src_vma->vm_lock->lock);
>                                                         err =3D 0;
>                                             } else {
>                                                        err =3D -ENOENT;
>                                             }
>                                             mmap_read_unlock(mm);
>                                } else {
>                                            vma_end_read(dst_vma);
>                                            err =3D lock_mm_and_find_vmas(=
...);
>                                            if (!err) {

Right now lock_mm_and_find_vmas() doesn't use the per-vma locking, so
you'd have to lock those here too.  I'm sure you realise that, but this
is very convoluted.

>                                                          mmap_read_unlock=
(mm);
>                                            }
>                                 }
>                                 return err;

On contention you will now abort vs block.

>               }
>               return 0;
> }
>=20
> Of course this would need defining lock_mm_and_find_vmas() regardless
> of CONFIG_PER_VMA_LOCK. I can also remove the prepare_anon condition
> in lock_vma().

You are adding a lot of complexity for a relatively rare case, which is
probably not worth optimising.

I think you'd be better served by something like :

if (likely(src_vma))
	return 0;

/* Undo any locking */
vma_end_read(dst_vma);

/* Fall back to locking both in mmap_lock critical section */
mmap_read_lock();
/*
 * probably worth creating an inline function for a single vma
 * find/populate that can be used in lock_vma() that does the anon vma
 * population?
 */
dst_vm =3D lock_vma_populate_anon();
...

src_vma =3D lock_vma_under_rcu(mm, src_start);
...


mmap_read_unlock();
return 0;

src_failed:
	vma_end_read(dst_vma);
dst_failed:
mmap_read_unlock();
return err;

Thanks,
Liam

...


