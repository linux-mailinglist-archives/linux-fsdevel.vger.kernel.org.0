Return-Path: <linux-fsdevel+bounces-9555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52892842AE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 18:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EBF1C25A08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD7A12A145;
	Tue, 30 Jan 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KgyEglob";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YnK482Nl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0171292D2;
	Tue, 30 Jan 2024 17:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635746; cv=fail; b=gL/7Km4OkK7t5J521JooO9Bo0A5c9Fk3dS2gQbGEHGnbF7NEbPOjg5TWbcD79nV+81gMMFsR6zxczj3wTeKc3pL8PVFezvdHvBsMiUzkvzbOXJIc2YOYkVF6lStPJZdGssMmP64fTu09Wv41xUaXSh5EdOcvN51lEodh1ZnhGmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635746; c=relaxed/simple;
	bh=rgjSZwsGOw5exjYjpnQ5lrxPdlgYJLM6fW4RX6RDBcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nJyRnIgDhyqFmLqFD2mjKQmloEfHmeoiwUyhZPFJzuL3ao4kEQ8GJIsywTJpN7Nz1raAoNTSN3xbcpQVzKMG9IKG4oXjzC9WphY573mDNUcMX9Wsv2m7+Z5dAObjirQZwQHNt21DcYJyFOpcbzidlCMiW2BhQyJwpP119YVpYfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KgyEglob; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YnK482Nl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UHLB0P008046;
	Tue, 30 Jan 2024 17:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=bwyqRn+ceB8JKWn7DhSVinnG5TWKiNRPc/yjt0Az54U=;
 b=KgyEglobjCXCuz7CS3EG2p/ZhxEiqhcRwpGSYRGAdoNq/u4MmjByD2OM7lv6KMhaDv8h
 zWnBZvkFF0MPI1hg4IXfFK8jqhEi9fwHR1I7vNtckNpdjxvUsEAi2hSuSG/7xP6xhm0D
 rg6InYbZGGdwaDBZ+6Q9ZqQjJSlxwG/cikxNtlNyIWKA3WuCTJoRyzBOTcz49s3CPdub
 qlfW86Em9LJfLru+m/f/O4nOQ+Cof8ppmZixhbZvck6WkuWMqHLmfcv9m7mBBppy2NcO
 u20xvXnWNnl3qLrlC5D3vLa16kwAIvwoDzLkeUYWEZkWreYtgnCQm55O8BNA2AKeXB/l mg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcfjyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 17:28:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UGiH1O007770;
	Tue, 30 Jan 2024 17:28:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9e1881-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 17:28:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIuto5xUC6m7hiOKvtmpnP2BHfy3EZucsivBsCtu6JdY5/G3oi4uNDij8AeYKEhK82Xw7AClrfKEdWvq2z9Nqrn0hbydSpi06wvjk4SweZzm/vhqf4eO3i3BWY1QL7wS8IC6BgBHs2YKE4v6SQbwM+sIj9yDOh3WE6bb86Sl45d0VpKOSk425YAuccM04Gw1rZGB447JCpl1w8kBLVTcdYEN2WxdscijnQ2KTRBlvg3AnNfUe98wHOmrYAhrwtT7UEnn1K2xdxco2PGL364pzjSHPp/BaMXYEarC33E+oukxPiJR5RKYJu9LxJYJGN0qd/prrP/a1ylrjSVlpQx1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwyqRn+ceB8JKWn7DhSVinnG5TWKiNRPc/yjt0Az54U=;
 b=QlTM6galFJRYnyIS7t2vKwe2DN57rzbtFSAK6myEkQBfESvPLATpL3mKApLuhQ9muCjW8sl/qRUHA880geJLqn6J2xriMiHqHzkrGjBcT+nFvYKdhFWeZt+rZDKohYFwBQICCLfhhGhIVsKjwTbqkxCxQE5raZLS8d5JScict0HwGaD8PrO2hCAU/mTE+x1sAcRbj0gPTnvveE+NXXCFSxrRovpeQwgYWs04iNne3NwRyZY1ZhMq1UHh+kwxAYOZXBbUKjPJePYtnm1VtE7OxVNkn4syBsRRgs/7ot2os7ihRp6vjD0ayzdAHTks4dg7FafzCkE7DrU83nCuJJfh4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwyqRn+ceB8JKWn7DhSVinnG5TWKiNRPc/yjt0Az54U=;
 b=YnK482NlR4+hbUjHyE5FXuYatsq+TN7pJ3RTELQJPneWoe7NmkuFCs03Xdr9lQ6oDaeBYkfzpkpMlOR5gW+nD7+r8DuzbLRIp3InYcT1M+CrprtB2O1XE1WhCbZniviQ7T94dthxB4fJEjUk9oBXMY9STGi6zGzt8ZZ5WovBfN0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5323.namprd10.prod.outlook.com (2603:10b6:610:c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 17:28:33 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7249.017; Tue, 30 Jan 2024
 17:28:33 +0000
Date: Tue, 30 Jan 2024 12:28:31 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
        peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
        bgeffon@google.com, willy@infradead.org, jannh@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in
 userfaulfd_ctx
Message-ID: <20240130172831.hv5z7a7bhh4enoye@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com>
 <20240129210014.troxejbr3mzorcvx@revolver>
 <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
 <20240130034627.4aupq27mksswisqg@revolver>
 <Zbi5bZWI3JkktAMh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Zbi5bZWI3JkktAMh@kernel.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5323:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a97099-3c6d-48bc-0032-08dc21b8e200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0e6j2wwz2R8w0DLwn7PdA/w6Ik4gQeHkReCIjg1GD6To/Hz5DMmnbW7r7PpCqOKCVY/caCXT4a8ksEK42LWeV+hijLXK76J9TiOFOX3BllqzeSXZy1myn7V9S2BI+X+J4G0xmEOFfetoumSHyEHQ8KxjofRE5PVFBJTKLwJeBgxM6pAt7p04Ru/c9ANNBR4ka8phPB77jgoIc/FurQvgiDio++cNht8SBpKPNI/t+exqLouuAFhNKi6V75P2j1QOyPl8l9qbWn8Qzv4VqI9XNd+Yh+IjP8AB87Tacmif+Y4+y/zUjLN8hLggqN3+ftDtWv5uun/gmN6GmETBCPQETRdquvVaywBge8ZgBIUeHZSeMleIUjvNDF+7gQ0UZ/LPQ9rTELabiKh3dA5ZZtPqZQ1fkTNUf1xJyG9WGyPJxsJ+WQ3xB/M2DXi9Pb0YwjjgofGDBZYyP7/HA0B2ZVts+BAVpZDsMBeEhRatMXKfUMEz34szkx461O7xoE9/iSYnUSoGnwStVPbqrA3OXgvVRSpJMj/uenEn8jPwM0aORsZWTiJxZbBvFghokL1Diujg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(366004)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(6512007)(86362001)(6506007)(53546011)(1076003)(83380400001)(2906002)(38100700002)(8676002)(33716001)(478600001)(5660300002)(8936002)(4326008)(9686003)(41300700001)(66476007)(66946007)(7416002)(6486002)(6916009)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rmg2VTltUVk5bTJVMjB3TUd0YUxMUzl6cktPVG4rVmtrYnl1aHlXbVJQVFZL?=
 =?utf-8?B?TCt3OFh0cjVSOUdZdWNFZ1Y5K2FoS2M0anRuc1BoOFd1dmlNYmFiODRjWEJs?=
 =?utf-8?B?UmFSMWxjRFQ3SmF6bFVHNTdjMVJKUEw0NWJaczh5YXFCcm5LWE1MQ3JJbFpq?=
 =?utf-8?B?TzhDUmdJcnoxU3lZVlpzVmd6OEpDUjlLZUJCdjJEbHNRSFRnM2FKb2ZQVk1F?=
 =?utf-8?B?SWZ0dTdRd2RaUkcwZkU5RWVsdTladzI4ZjJsRDZkaDlOaG91QldSVm9mNXlx?=
 =?utf-8?B?MCt6MWUzMzA4eTZuQTJETHJlb1JOWFEvSXh1TStpK3NGU3hBY1Jxd2g0SURm?=
 =?utf-8?B?Ni9ScmlTZ3pyc2x5QkFrSWNpVFhOTUdmQzhVcjdYNUJoaUNML2hLbU0zR0k1?=
 =?utf-8?B?WE1Yc0dDNGFPc01RVWNmd2Q4bUJtR3FYUkczYlI2YzdnK0RIbW1nNG5weVV1?=
 =?utf-8?B?UVNMRzIxUEhEakRaVVpYS1JGRllnYi92WGpUazh3Y3hobit0NFBoalZlU2pR?=
 =?utf-8?B?TW1xNmRnbkgvRDBCNXBrWGJrTkR1OWhKMk5TdVpVemsyWEdtOGYxZEJEOVVj?=
 =?utf-8?B?cXhxRFdwOUREM3lRM3pNd200QS92azd6RTlOZUJnbmdHYjV3VmF1bDFMNE1y?=
 =?utf-8?B?TENJc3RsZk9hQWx5M21CNUcwK2VOL3lHRTRXeU5XRS9FODhnR0JQbG0rem1a?=
 =?utf-8?B?Z2J1M3RFRW9iS1hGS3ZTWlcyc3I2M0R0S2diM1hHQ2RseThNbGF0bytqQXJw?=
 =?utf-8?B?b0FOR2VjTFRpY1M2T2VIanErUC9NUlV2c1dadk5QaUNhY1o5RU9HQWkwdld3?=
 =?utf-8?B?L0ViN0gyV05kcFFzb1RCUjV4SmxoaEhRdENBYXU4TlNTbW11REREMzcrakNH?=
 =?utf-8?B?Lzg5MEl0VkU0M2lrMCtoODNpMHlDL3l6cHNaTHhES2E4eHdZeUpRTVZMb1ZH?=
 =?utf-8?B?UjQycHVuV083TVJBV0ZkbDNuN255SzVOOUpsVk51TVBUMlZuS3RKMW85K3Jo?=
 =?utf-8?B?TU9jNmt5YkNKVmhjRGNmeXhwME9SMStjRkFrdzNDRHFxNmxvblN2S1ZDbld2?=
 =?utf-8?B?R3M2T0NjNjBTZXRnSEYyb2VlQlRJKytUeEZLTUZTV2RiVDlrd1ZFeGtGdVFx?=
 =?utf-8?B?SHV5NWxqU1pVanhKdWhmZVViTjF1Ry8vNXZLQmEzVEJyT0R2aWlqaFgyQ3Z3?=
 =?utf-8?B?b2NwTit2SThhZkZaWW9zRzVRanBSSTh2ZEpqaXJYNUhrQnk1NGIzRzJZMmIy?=
 =?utf-8?B?MmNtOGl6UWlQL0JPaHpTckk3U1dneGpxVjljbE5pZFcyRk1ITXd4NEgzUkJN?=
 =?utf-8?B?Vjh1Rm1wYkY0TzQray9mNC9nMnVqc2V0OWhrZG9MYW1JOUlqdGV0b2hURmRj?=
 =?utf-8?B?L2hONC9sR0RBOTIrdFU4c2tadzFpN1N2cm1LWjQ1RGJmMldsbmNiampHV3JR?=
 =?utf-8?B?dVFobGp2Sm9Nb3poUnBYQzY2RTF4aUFBc2ZqV0FSTFlRSndGVmxvTlpuNFRM?=
 =?utf-8?B?UmdSK2l5QjVBbnJFdEtUWVVxUzVrVDE3VTVqQjc0cGEzeWJZYzVpNlZCM0dz?=
 =?utf-8?B?UFYwbEhWTWhSRCtZdHlUcC9yMXNpazFUYlhCMk9Yb0tZZ0xyYlBNZTNnbHNh?=
 =?utf-8?B?cldpcldyQ2tBYUNpWk5TZUc2bHk5Nm5aMTRrZ2E1ZkRYMUtFeXFZME8yTThD?=
 =?utf-8?B?SDNVb0F3MzRtQzl6SUlaczQ1elV1Y0xVUkNlNkxISlJ0aGdtWmNhakw0S2lC?=
 =?utf-8?B?L2tCNGR2VUtmbEx0RHBZL1JtQlN2WnE3M0d2YWZGdW50cVd1NVYyemRyL3Jw?=
 =?utf-8?B?Syt3WDduUEZZZ0Fwd0RVckpWbmN5Mzd3S1pMMEtCdjRYeDk2MDJUWjVYcVVU?=
 =?utf-8?B?V05rYlQ2ZGxSbmpqRi9KeEM3bVhOTmVDTlhVbjBTNTZVdkhaTEdZa3ZJTDdl?=
 =?utf-8?B?cng2eDJrQmlyU3BKdTBrb0l0MzJnTTc2aUMyb01zTlhFYnJhU05oQnlqd1c5?=
 =?utf-8?B?VW03dzNpMDlCNWh1Q3ppSFNuRWsvSUVGQTRNK0JnRmNLV2Z3RzlTWFdsOGRi?=
 =?utf-8?B?SG11OFlUeEkvTnpxMDJhUTk1c011dlRRbmhlTGVzekZaVVJOMjJjQk05Q3ls?=
 =?utf-8?Q?RGird6mtEiBBk8fyOVouHct8G?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jyFVLGUa3PiEa0p6BcxwhKa7wtgcN5G3WLMDIx8rl+p1dNCgPOaepZQwIrQ/AfY2j0Wj+RMA8kWmFQQKGoTUGv+Ccud3Jc3Nk7FPYO10BXL6IPScXRvOaj0jA/RsVs+wfvsf+0GywY6efcgYA321vgo6uykrlzqIJX52fSH1w7FLzFv8lDn65RTmYCYC4fZLLU32YLN8BQvS1vDLelbIOX5lrU5q4syrJr/fIJNhysxX4vFbVwgSO5aXt8HLWPn0UuDvM3fwVQ4QKsA8DVilT20mBbgGaqjYH+UyKcHdHFcBbeWQ/Fpm7i0Ujd1tgJwwDwi08VGFJdHRJrnQovX9KFpA0Xe5WTR7rhMNqXjiyArvyJ5lfvRhl3FzxbAJ9hXfNujtnfM4Qws4G1CVtK2R0e7aXDXwQZzbK+TYaLN9eoiXBbuvvRLx0kGVWM4LOS65f6CcVi9qjoVbTLRvOY4lZVTtSABJTSMI7YoXCcmz5KvBZlbHrWy2gDe+nbwTCndDgY/DdUaX2OznvrNAE83Npk7n8LwJIgv+Vezw78H6w/mVES9QjQSCE1uQPhK2f+NvN66sEgrG+sjwM6RXnd/B9td5vRrj6Mby6cTEZdn6fNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a97099-3c6d-48bc-0032-08dc21b8e200
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 17:28:33.0111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yf6XKC+stakBpO39fQsxTpnO+FjV+ezwWbkqe7cESDiYyGT2bmzUF3mZLFnAlfMWgj17ozVriKzwRmnj4qoVIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5323
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_08,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401300129
X-Proofpoint-ORIG-GUID: 0Ir1_BJjpSVYUKy8VQzGE58dWTTK6Gwz
X-Proofpoint-GUID: 0Ir1_BJjpSVYUKy8VQzGE58dWTTK6Gwz

* Mike Rapoport <rppt@kernel.org> [240130 03:55]:
> On Mon, Jan 29, 2024 at 10:46:27PM -0500, Liam R. Howlett wrote:
> > * Lokesh Gidra <lokeshgidra@google.com> [240129 17:35]:
> > > On Mon, Jan 29, 2024 at 1:00=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > > * Lokesh Gidra <lokeshgidra@google.com> [240129 14:35]:
> > > > > Increments and loads to mmap_changing are always in mmap_lock
> > > > > critical section.
> > > >
> > > > Read or write?
> > > >
> > > It's write-mode when incrementing (except in case of
> > > userfaultfd_remove() where it's done in read-mode) and loads are in
> > > mmap_lock (read-mode). I'll clarify this in the next version.
> > > >
> > > > > This ensures that if userspace requests event
> > > > > notification for non-cooperative operations (e.g. mremap), userfa=
ultfd
> > > > > operations don't occur concurrently.
> > > > >
> > > > > This can be achieved by using a separate read-write semaphore in
> > > > > userfaultfd_ctx such that increments are done in write-mode and l=
oads
> > > > > in read-mode, thereby eliminating the dependency on mmap_lock for=
 this
> > > > > purpose.
> > > > >
> > > > > This is a preparatory step before we replace mmap_lock usage with
> > > > > per-vma locks in fill/move ioctls.
> > > > >
> > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > ---
> > > > >  fs/userfaultfd.c              | 40 ++++++++++++----------
> > > > >  include/linux/userfaultfd_k.h | 31 ++++++++++--------
> > > > >  mm/userfaultfd.c              | 62 ++++++++++++++++++++---------=
------
> > > > >  3 files changed, 75 insertions(+), 58 deletions(-)
> > > > >
> > > > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > > > index 58331b83d648..c00a021bcce4 100644
> > > > > --- a/fs/userfaultfd.c
> > > > > +++ b/fs/userfaultfd.c
> > > > > @@ -685,12 +685,15 @@ int dup_userfaultfd(struct vm_area_struct *=
vma, struct list_head *fcs)
> > > > >               ctx->flags =3D octx->flags;
> > > > >               ctx->features =3D octx->features;
> > > > >               ctx->released =3D false;
> > > > > +             init_rwsem(&ctx->map_changing_lock);
> > > > >               atomic_set(&ctx->mmap_changing, 0);
> > > > >               ctx->mm =3D vma->vm_mm;
> > > > >               mmgrab(ctx->mm);
> > > > >
> > > > >               userfaultfd_ctx_get(octx);
> > > > > +             down_write(&octx->map_changing_lock);
> > > > >               atomic_inc(&octx->mmap_changing);
> > > > > +             up_write(&octx->map_changing_lock);
> >=20
> > On init, I don't think taking the lock is strictly necessary - unless
> > there is a way to access it before this increment?  Not that it would
> > cost much.
>=20
> It's fork, the lock is for the context of the parent process and there
> could be uffdio ops running in parallel on its VM.

Is this necessary then?  We are getting the octx from another mm but the
mm is locked for forking.  Why does it matter if there are readers of
the octx?

I assume, currently, there is no way the userfaultfd ctx can
be altered under mmap_lock held for writing. I would think it matters if
there are writers (which, I presume are blocked by the mmap_lock for
now?)  Shouldn't we hold the write lock for the entire dup process, I
mean, if we remove the userfaultfd from the mmap_lock, we cannot let the
structure being duplicated change half way through the dup process?

I must be missing something with where this is headed?

> =20
> > > > You could use the first bit of the atomic_inc as indication of a wr=
ite.
> > > > So if the mmap_changing is even, then there are no writers.  If it
> > > > didn't change and it's even then you know no modification has happe=
ned
> > > > (or it overflowed and hit the same number which would be rare, but
> > > > maybe okay?).
> > >=20
> > > This is already achievable, right? If mmap_changing is >0 then we kno=
w
> > > there are writers. The problem is that we want writers (like mremap
> > > operations) to block as long as there is a userfaultfd operation (als=
o
> > > reader of mmap_changing) going on. Please note that I'm inferring thi=
s
> > > from current implementation.
> > >=20
> > > AFAIU, mmap_changing isn't required for correctness, because all
> > > operations are happening under the right mode of mmap_lock. It's used
> > > to ensure that while a non-cooperative operations is happening, if th=
e
> > > user has asked it to be notified, then no other userfaultfd operation=
s
> > > should take place until the user gets the event notification.
> >=20
> > I think it is needed, mmap_changing is read before the mmap_lock is
> > taken, then compared after the mmap_lock is taken (both read mode) to
> > ensure nothing has changed.
>=20
> mmap_changing is required to ensure that no uffdio operation runs in
> parallel with operations that modify the memory map, like fork, mremap,
> munmap and some of madvise calls.=20
> And we do need the writers to block if there is an uffdio operation going
> on, so I think an rwsem is the right way to protect mmap_chaniging.
>=20
> > > > > @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_area_struct=
 *vma,
> > > > >               return true;
> > > > >
> > > > >       userfaultfd_ctx_get(ctx);
> > > > > +     down_write(&ctx->map_changing_lock);
> > > > >       atomic_inc(&ctx->mmap_changing);
> > > > > +     up_write(&ctx->map_changing_lock);
> > > > >       mmap_read_unlock(mm);
> > > > >
> > > > >       msg_init(&ewq.msg);
> >=20
> > If this happens in read mode, then why are you waiting for the readers
> > to leave?  Can't you just increment the atomic?  It's fine happening in
> > read mode today, so it should be fine with this new rwsem.
>=20
> It's been a while and the details are blurred now, but if I remember
> correctly, having this in read mode forced non-cooperative uffd monitor t=
o
> be single threaded. If a monitor runs, say uffdio_copy, and in parallel a
> thread in the monitored process does MADV_DONTNEED, the latter will wait
> for userfaultfd_remove notification to be processed in the monitor and dr=
op
> the VMA contents only afterwards. If a non-cooperative monitor would
> process notification in parallel with uffdio ops, MADV_DONTNEED could
> continue and race with uffdio_copy, so read mode wouldn't be enough.
>=20

Right now this function won't stop to wait for readers to exit the
critical section, but with this change there will be a pause (since the
down_write() will need to wait for the readers with the read lock).  So
this is adding a delay in this call path that isn't necessary (?) nor
existed before.  If you have non-cooperative uffd monitors, then you
will have to wait for them to finish to mark the uffd as being removed,
where as before it was a fire & forget, this is now a wait to tell.


> There was no much sense to make MADV_DONTNEED take mmap_lock in write mod=
e
> just for this, but now taking the rwsem in write mode here sounds
> reasonable.
> =20

I see why there was no need for a mmap_lock in write mode, but I think
taking the new rwsem in write mode is unnecessary.

Basically, I see this as a signal to new readers to abort, but we don't
need to wait for current readers to finish before this one increments
the atomic. =20

Unless I missed something, I don't think you want to take the write lock
here.

Thanks,
Liam

