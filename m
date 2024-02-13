Return-Path: <linux-fsdevel+bounces-11401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DF28536C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 18:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC36288A2F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACCC5FBB5;
	Tue, 13 Feb 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fy+g42hU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ohuN0a6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE55FDA1;
	Tue, 13 Feb 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844003; cv=fail; b=EGUuvohy52/9Gxd12K6iyGp5+e4Q5B/4eBJZ7ZdQrzUWWSGliyOqiN4wti8RvL5EN1Bkntr+Hdt0dxGbir34sClbzFt2CbHwkbCza24bXbdwX2Mwkcr7dYmzCrjR8KafWmF8S6o6Eoq51R5WyCJvB8C0vYxSJw4JrW9EWsrQ1xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844003; c=relaxed/simple;
	bh=FLbvu9wRskXCsG3mTpGcRSyoVtKx1FjdRb84haS83I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m1I4UrEBfZp+z365P/OpwQvOtT6cGrekw8H2LIHkcBaAiAJGuVPZ2mb9qXL0x4PjQkyCG1yFE8WWQvJliGjGMUTZzH0O14E/4WrGxkUVyhhXrz+2gxpY1X5Nx9Kho6CM7uNdZO5z9Kc5d//T0w1Jc3B2uKNs42gqSJU9NtqKdyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fy+g42hU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ohuN0a6m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DGO248026949;
	Tue, 13 Feb 2024 17:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-11-20;
 bh=uDEr5TOY0bjF037GdftEHdmEEImR7haKnc3kgPc58ic=;
 b=fy+g42hUlQm8/4/QscyjtlUDrlICuJwSA8sSsCiVA2DwUIokOf6jwJBG4MXT844a1rdD
 oxo8SosoCXIwz7j14YXEALXHu6t5mVpN3wDnFDy1FsrW/43B9cTYN2nICAddBNAtqezm
 dGkEH9JJvROQKqc4NLeJmfJMZXxnKNV504UzKh7ZwcEuq2kl/N+ZXkWYvxBH85C8AkWl
 4VKr7OZEROsv71D+QhoToCwTJvw55k1i7S+vbDV2C03Qv+Gyh99Eg7zp6XdhA5GoO0XX
 fwMyce+4dycF/L5Q755pxiF7bY4/y+r0iHdShAjPXUOL7zANJ572F3Qxxpgw7QBfGSW+ rQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8bmbgbbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 17:06:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DGgVfm000682;
	Tue, 13 Feb 2024 17:06:14 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7njjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 17:06:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T20hiG+BdWdbGf2wFkx2nB5oP2WuaAglJNPTXHDP1kvt+NvA1f5hFijYZkn8uueVp8BE0G7cPSN2YIsbeOST/MFWAPqJYNmv0c6evNfAkhVtvjxozMltgj70BdE4i3Bf4RE9w7NGkb8bEU6+tQmTx0RGhib5S+8Z4aH2UEQ39q0Dhk7eoDb5IbBrVxqnxt88Hng4xh54ckQPTGG4BW+I9BzHXnuRTooivDPq4ME63FqPiI6PyqouiNfGUKvjQO715jZ9j0/sbRIyO7/gaVxuKNBMFVVu6beDP/hNKXWmDyjnyuecR5rJh2rWw/hlhLeO3tg5P/tzGzdZ03qfbLX1Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDEr5TOY0bjF037GdftEHdmEEImR7haKnc3kgPc58ic=;
 b=REsQdSZzbVM787gqDkDUhparOOQmZfvpvWgchDBZAEJ16nHijIhvD6XFn7Vw9ReseQzD/5cZJNeCFamfRXgYZ0lSlbXf6Ylv7bzQ6TcST5zgV/vsJ2haGpRPRd9Z20R6H1p8xgldkCvqcSknN1g7zTxLPrTwrzKnmjtsjVmAKJRSNsPRGWIHMJU+hd5QBId+E5D4XcjDT1+FYtjiENn/Dh/q5hCdiEY+o6VzRz0flq3YDkzqAChnIItdKVZNGdl8yiHxpmXyisQBSC1ie4JbEtYvMoDetf0lpMmbry1Z1+IilUn9+aXnlPWoEqpyLruA/rw3x/iXtYrHaHRDN/UTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDEr5TOY0bjF037GdftEHdmEEImR7haKnc3kgPc58ic=;
 b=ohuN0a6mBqNj1jZOTJyr8QZ1uufAz5J7Gy/0PsxquG/B+xpa5FDnaYeU01qvhVlXWWfHa8XuUQ4EQ/xqizHUZHf3FdTjgi0CbFrr3LbdBFd9/H0wfq7KHD0ktUPQ0K56Yeww/IhruwHlhYsDl5pQfgXXr/3HsFuX1od152XNbJo=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7229.namprd10.prod.outlook.com (2603:10b6:208:400::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32; Tue, 13 Feb
 2024 17:06:12 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 17:06:12 +0000
Date: Tue, 13 Feb 2024 12:06:09 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240213170609.s3queephdyxzrz7j@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com>
 <20240213033307.zbhrpjigco7vl56z@revolver>
 <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: CH0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:610:32::6) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 44da5c60-7447-40a7-9d25-08dc2cb6148c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ftBJkJbD5XUdF78t4wZ7h+e4tYixHcOVd04+iDvmYqdkAYQFq/WJIHME8GFCSV4tcwh4p2fLQQZe98kNpZurfBwLp3L5gLI8GXZc8KNqfsQQPtz0NhCxRTWB4KO5nbvo4EHrc1e/o+CaYEaCclg7Ano9v++7faagrXSREVHelH/lHR7I/8hNV+cSub+T/zekaAz5eyAlOu+H9k3G0/S5vK/fGuWNieelJxedT70CoMIGSFEwc6QNsU5cs7rObaESUpTSpZ38jQSwzXsxEuauW6sIm4k4kQUCCuk2/SwMseI91kJ/6yY9YFEjn5zCNH0kE5FIORggD9sdEFdGq0OCu7/lUNNco7q069gity8iGUFLE8vGJ9scA/00pfDHBTtiUJzMFl9oXsgXqSy9pehUxKvP/TbKPgR9IdKED5miDqXExdFafNvyQCxGbvDEy6FKRBGHGlQGmc5ARzfGw21M0exX028gPqOUaP0wjgunMI4kKYA+fhDA0nuLiGrCVZSrT/49/uQQjkbsaFimLUkEITqRCBAoA1THhfTYEnaGPm/aD3+QKTRLXQkuGBMxSOTb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(7416002)(2906002)(66476007)(8936002)(66556008)(4326008)(8676002)(5660300002)(66946007)(86362001)(38100700002)(9686003)(478600001)(6666004)(53546011)(6486002)(6506007)(83380400001)(316002)(6512007)(41300700001)(1076003)(26005)(6916009)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2tmbk15WEJqSjBuM2xjcWxCWHlPTjNBN1pVNjNKbVdMaHVZZ0tNbGFqRnkx?=
 =?utf-8?B?L1lDTk9vRGNTNCs5TkxoUFlCZHpHaDVSWDU4N2RGUjc0RTZsSEhXZDlmZkU0?=
 =?utf-8?B?YUtEOXRnRXlKNUdTNWlFVS90T1lZaEdlSml3eDBLUHRIaHNjKzJLc0NBOEda?=
 =?utf-8?B?V1BadUIvYlFKaWVQcmJBd2RGbzdSZUo2MmpROUhDamhvWGlHVTYzd242enlF?=
 =?utf-8?B?QmRMYkI4OWZaSFFOaFU1ODdRMFpnWENtaTJTN2JHenNnbzlCNFZYSmYrT0Ux?=
 =?utf-8?B?ZkEwYi8xR2JuWTZYYnhLM21pK3hLYlZsSVJudk1VbGRoU3g5ZHV1a0luNHlW?=
 =?utf-8?B?c0hnNEhKNzBCYzAzaWtVVnVIOVVXNHM1RE1OVGtDeWNoWVJnczFWSzhXYnpa?=
 =?utf-8?B?c2pQR1J1aGtEaUFOMEc3VG1RUzdENzFqMElvYjNPZVB1OEJHNFQrai9GSlRG?=
 =?utf-8?B?SHdLOEE5WUNEVDUxSzMrUUJmU09UTkhKRE9FWSt1NzlxdDJmZEdJeDFnOHhG?=
 =?utf-8?B?SnJCTlJmVVIrSzc4Vk5zLy9VQ2xibmNlNTRRRlNXUW5wanJodzVUM240ZmdS?=
 =?utf-8?B?S3lxcGhkYWZXSFpCZUhVUmUrQjNibkszOEFsTTdHUERTbVBGQ1ZjeTNKWVJh?=
 =?utf-8?B?K0F5VmdDY2FmWVB4MlNvcHFBdW9jOE9yOVozaTBkbTVZR1o4MXpNaGtWcE5R?=
 =?utf-8?B?TWp4SFh1TExkNFVoU0F1Q1Btb0dtTHBmQUhwdFlCZEdscStXYXN0U2dNa1pN?=
 =?utf-8?B?VnpHWTdNVlBXdHE3TzRuMnJPdGdlSCs2RmhwQldWMTJhWU9HUW5QU1ptdlVw?=
 =?utf-8?B?bDVucW5MSGFjVktaUWQya1UxZFdST0IwWndwb0Vac01LL3FBWWFvUVNKMGg1?=
 =?utf-8?B?ZFcvUCtrSVZpVzhCVGtieGV0cVR6L2dPekRJdnh1aktoS2ViYW5iSkVSYXNU?=
 =?utf-8?B?RVJITmdlK2U4YjZJM2pTMlVFL2xVMTY1WXdyTkJzVTM1S054dWZHYk9BQTla?=
 =?utf-8?B?WjlkN0hDL0krRHFPbnFLZ25zQmptc3VSMkxBVUl3MjNkMjJLdTZDWUcyZG9n?=
 =?utf-8?B?c0tjNkFMM2JDeUNnRGZ3SkpQUUY5S2ptcDg2UjkwYUlSUGpmbkFGNmZ6ZUF1?=
 =?utf-8?B?ejhUdjloa2M5ZkRhYmJPM2E4bllsVGM0L3QvRGROSUtwMFF5Y0plS0UvQWk3?=
 =?utf-8?B?NDBQeVdBMGV2K29odlBIYUlyc1o1RDBOR3JrK0k5Wnd5WlhpS2QyN2ZjaUZV?=
 =?utf-8?B?Nkc1bHFndi9JWGZadURXdDk5QUQ4cS9yYUVCR0U3WEdKUXVCNytCazAzZXlE?=
 =?utf-8?B?SGNEZUlsWU1rRWsrNEVPWkZKNUlKMy8vZGlpVWlZb1dtMjZXekNtb0xWeUxU?=
 =?utf-8?B?dUVJQjdCRHFHcXJNREVVMStiNk0xeDYxLzFwTEtwMW9MSUZBUHhFL09SY0Nt?=
 =?utf-8?B?YmJ6bVBEU21TY0VNMHVTVHhaTGg3R3NnNGM0cDFjSm1KT0loRkhNTmpDdFdZ?=
 =?utf-8?B?a1lGZ09vaS9vaTd6T3dHTkkyN1hwRURYU1JsYTVPNnlSZjVWbUt4MTZZcGRo?=
 =?utf-8?B?NnhJWUZIOTdPb0xmSXljVjB1elZmNkZWRkR2RWVFY0NkWk15dFJVK013blBx?=
 =?utf-8?B?VklPOWRkZm91TTRPU2YzRUtrSDA4b3J6SjBKNDNUVTZkVktFdGMyMHJhbEVn?=
 =?utf-8?B?SEpLZzY4eE41VzJwdWlzQ2EwWjdlTWl2K0Nvb1hWTWRmS3dZaUVmT2swS1ZE?=
 =?utf-8?B?ZTFqZXZVZjZKcmxyczFSOE1BUDJHNVFlMmhjOGNvS25zTmpFUDZ5VzhGTmYz?=
 =?utf-8?B?YTAvdnBhOGNza2ZYQzFFK2V2QXNhR1IzeE1Cc3ZIUTd4V3pvVTVrSng3YU1k?=
 =?utf-8?B?YkpESndwazRhSlBWTWR6blRXelp6SmthWE4wVy96NzBIZzVZWmZhQmVYcitH?=
 =?utf-8?B?Y3NFRzBWeUR0UU42SU9WZGpTOWF5UmRIMHB4RFAxL0dCd2J2aGpJTmFaMGht?=
 =?utf-8?B?dmhQaC9SMmdBMFZScXF3VGZ4Ylo2bWFtZkdYTXM1NysxQ3ZCOFhsZ2FudTRn?=
 =?utf-8?B?T1B0R3BpV3RWa1V6MlFrRGQ0TGRxLzl1QjRwVjE4VzlJYzVwZCtkWEhEY1pp?=
 =?utf-8?B?VVIxMlFDV3lDVDZxaTRVc3NHTnE3a2FWWE9OKzFqb1Z5MmxDTEJiQ0R4eXh3?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	08k/7c3Y5DI1EbU5E192C2ZesHBC9lfd3sbToDK3KIIBF9/sXJ2863j0zwtkws4BV1wQlpNY/s6acVNoL8qlJn+6wKIvUJbaUeUCWq0oykhBrUyPOGVQwBQ8chgQ1vOjE+PeKmeVzvimLKGHwh5YFXkNk1fSYTRkl/VfgecHeTF4cpm7USS6N5PSRrJ4EHfe6fFGI85JAcrwXXEqZvMmRk9+DsS5GSLrpv7AVGSQggy6KU23IIieNwGQCRg23PNIzuybcmQn5z+Bj621X87GDfc52I8I9n69uY/I5PCTfxEb89VnZithzbtJsrH2mV0kZ8eb6WgCTi46E8SL2MYAPx883R0/EyK06nKmZLevMlkwCqxv/7Bnk0OqPD/Uk5Rlm1Jr0ZirTSZY7fj+jUymeoA8ljvwYU9DRKlUTrtsbs0KHGyFvFGqeuy3wjB8AKRyFsfQkYzGVdDdc2hXoClUUFiH6jjHuGWimZ344bgItBZkTs9gL20msVlkn/YY+TaTWZEb6HfQmD+MMbaXOx4iX0XrlfiQ8Y5SEHM1My4jt3N2ziAp9c/9Lw1/wHdObpjWzNoAhw1CDOU9joFRU68giezNL32QVkd2rYc5ZRvL6cw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44da5c60-7447-40a7-9d25-08dc2cb6148c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 17:06:12.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkIE9Ec53I3hPAT7svvfcuAMPBsPnvE5rCurMjf5H63vgN7hWJ0rhE0b2RUT4MJN8eyZpvCAp4hNwzMY1zUXZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7229
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=488 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130134
X-Proofpoint-ORIG-GUID: yUIHXhUrrqkk-YlnN-Fz_mglv7-QHmAP
X-Proofpoint-GUID: yUIHXhUrrqkk-YlnN-Fz_mglv7-QHmAP

* Lokesh Gidra <lokeshgidra@google.com> [240213 06:25]:
> On Mon, Feb 12, 2024 at 7:33=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> > > All userfaultfd operations, except write-protect, opportunistically u=
se
> > > per-vma locks to lock vmas. On failure, attempt again inside mmap_loc=
k
> > > critical section.
> > >
> > > Write-protect operation requires mmap_lock as it iterates over multip=
le
> > > vmas.
> > >
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > ---
> > >  fs/userfaultfd.c              |  13 +-
> > >  include/linux/userfaultfd_k.h |   5 +-
> > >  mm/userfaultfd.c              | 392 ++++++++++++++++++++++++++------=
--
> > >  3 files changed, 312 insertions(+), 98 deletions(-)
> > >
> > ...

I just remembered an issue with the mmap tree that exists today that you
needs to be accounted for in this change.

If you hit a NULL VMA, you need to fall back to the mmap_lock() scenario
today.

This is a necessity to avoid a race of removal/replacement of a VMA in
the mmap(MAP_FIXED) case.  In this case, we munmap() prior to mmap()'ing
an area - which means you could see a NULL when there never should have
been a null.

Although this would be exceedingly rare, you need to handle this case.

Sorry I missed this earlier,
Liam

