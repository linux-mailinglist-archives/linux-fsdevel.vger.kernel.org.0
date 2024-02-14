Return-Path: <linux-fsdevel+bounces-11543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A684885485B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 12:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 589D228CCA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17451BC4C;
	Wed, 14 Feb 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VoKZqegJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XvyqG6Rn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11911B801;
	Wed, 14 Feb 2024 11:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910187; cv=fail; b=FRxu7POqYqyEUX/mtXz/ATqS8HcQDRwQR4AKrKfcczdII0hu7pY5lasRcj+T06Fb02qvyyYOhVZk9t5bZENe+t2wcQHpN2nKEMnuBtJ3be/3LahrOSBqH7GwqGY/AkijB48AQYK670RUIpEKSEfiXjycsasgnYwLjpPHZRMbqYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910187; c=relaxed/simple;
	bh=5BRTRqbL3IBqlh+QrRCyJw6tvs8gcVYIe1hBn+fC4Sc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TzoB8WpdoZaDVRtXRKxxjrigihtu64vvX15XgQMtbtZp+roWDiu+KTFsEoh5Ragvx1jo7a41DTnrVONM+Zm4XBayAKpSq2hymH8x/gWSsCTVb8DtUfdoKs59t8lPAzguyYYTRP9ND21TSXcwbCKi7Tic+/LUWK3Yvw0kI4lebTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VoKZqegJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XvyqG6Rn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E9YIAR001393;
	Wed, 14 Feb 2024 11:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=489f0GvvL+46pGv/Wl/nGO+vUS5fGcDRs0+LHc8LuH8=;
 b=VoKZqegJTCBhs6cd5SDL5Wte+O+CoZT5kG4VIZKO4Tszvl/PZlgczl88sLEjIaHYSQM7
 b7ZOlidUbrljJMoZSR7vhV7E/cLhrBmX+mi3ZjRpkS+scNG5OCZWeSiYZumMOz46uJQM
 m356TMwb/gWc/2cQJFhYqXABJoPzjj0dDG1S/arFX/rDLcb2HFv7dUYn8uMLpLR3zscs
 GLUe/TLtpzwjqF5eMAiqk0QXTb64CoshWiXkh1iI2d6ZMpk0VNId1eVlkR303ex9Tevb
 LQJRxT7g1Os/nio3G6+4YHdQYw+89XOYLlSIZ5t3OwnEnqejcVZh6lNsULs+G+3CfBEk cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8u0pg8x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 11:29:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41EBRdkH000604;
	Wed, 14 Feb 2024 11:29:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8u12k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 11:29:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFZ82ZvpCn1+8bhdTXGRkWa/QeJ8D8u7iTbv324gVqMjPZeGxw7ohq91gUOhLrsgFB01DxkNrVUMalaV5/FnW1F7coM3CRnwY0xllZDmTKonrYo5j1ylFT2td6rOlM6QEBH8/msrYHF8TCURO6Vtq1y6RFmBEel+FFjqidD4LptY60nhNOkJ2x/7bBcODbrtYyqm12n3aidHEqsXBc052KlxRBrkFOE1a6wVD1ya3x4M3BaDnrXzrgtjZzPubi+hJpaAaKkmc4s+lCLl2L+5gLLSXe8NFUxvKe6sCoNCokQjk0A3DCWCpvVmt5SCgt3HoL2e8YqdMgVn4UUilXHShg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=489f0GvvL+46pGv/Wl/nGO+vUS5fGcDRs0+LHc8LuH8=;
 b=Eq21KVMJm7xKZmALXty6s6UqesA7zYRM8j9xU1G78zmOMOp/aJCQHNWBHOdm8qF3SO0MpiEh/QT1am4sChIa71cbgY5/TjxKlVB33v5qWviJXfxOkUZRgnM6RGqrVxgOI/xS0uZ6oWqliZ2TRFy0c2S0iS8H8zY6z6noPnPdhQYg89+cY/XUgAuH6767ZOmtpv0MXxVqOxqrt1PuJvQGaSlvIKjA7/L4X+bu7hyT7HANAjZIp7QzOLqWNqcAiZbNN6z0V+uyiAGoKtwD7ZYJDT0S2sB0xVrsoZzG2+VUSY1ewlfgE3cD9dfSCNZvfuVwabJpYPNhIu85vM9Zi+gvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=489f0GvvL+46pGv/Wl/nGO+vUS5fGcDRs0+LHc8LuH8=;
 b=XvyqG6RnrJGlSknOCHNESUO79BIUY7wwmQbNbO7EhEONaUnGNv9FOFyNsOYTdgRD60hT23AwACODfO/IvEYYjgSPeIU/2O/lJSkWSjrFJY3dZmupLw9POvB12PrUU0YDQXpk+0e1G1zHbWycExYTmDJCs1SR9Wx+sRXl8hIud5Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5394.namprd10.prod.outlook.com (2603:10b6:5:35d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Wed, 14 Feb
 2024 11:29:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 11:29:15 +0000
Message-ID: <445a05e7-f912-4fb8-b66e-204a05a1524f@oracle.com>
Date: Wed, 14 Feb 2024 11:29:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] block: Add fops atomic write support
Content-Language: en-US
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-11-john.g.garry@oracle.com>
 <20240213093619.106770-1-nilay@linux.ibm.com>
 <9ffc3102-2936-4f83-b69d-bbf64793b9ca@oracle.com>
 <e99cf4ef-40ec-4e66-956f-c9e2aebb4621@linux.ibm.com>
 <30909525-73e4-42cb-a695-672b8e5a6235@oracle.com>
 <c130133f-7c4c-4875-a850-1a8ac9ad4845@linux.ibm.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c130133f-7c4c-4875-a850-1a8ac9ad4845@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0643.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5394:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e187191-c51e-42e5-c989-08dc2d502c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XYnLglbYiHKgoOXBcDiWSxJ9EdjgGNEGOaEt4qG71EoRX+PABua/JmUPTJJWmUY4FrMvW82ZqLlB6IKr/GS0U8bx27DKh2wqe0e4P1ubnZeHWRyTSx4F6xCIJTaEovFGP1L61mYcPFLdnrQNB6Zq0CBq9YJa6oEJ4Pgf9aROZC3OIG0ApPplqGsovd7B2VBRO0sqlcK0JXlLfpXbb7YAmRnQ09xK0mxWh45y9ewntqwnuNLp8Ot76sgK/7sgwNr2noPec8wfzdfqbEe1A63pPp5sxoUXc9cztOoyj3dPUAvfM0g+zhh3BSdZ0nkNSRMhilvjlP/a7X80MhKpGoO60LtL4ib1lVHV87hBQvP8ZkYJQUEVSXgCIvPlbrbPA75QN5wu1psYpkX1WEryBlS+pgGewwku92cYpoaaJ0TS0OCQW7J21BO4ZHHSndlk64gCXAoNBLW9DwuHE+rbmcGgLQsR11fbzaddr/WwFp/Zz/sQ1KbZ/WI6jLRgbBxz2xArORCnCTuLxAsgcMEtydxCJJW8QT1tdV/JwQHnmZWZscc1x6Hynm5++z88eX1/m4oL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(8936002)(8676002)(7416002)(5660300002)(4326008)(66899024)(83380400001)(2616005)(38100700002)(26005)(36756003)(86362001)(31696002)(6916009)(66476007)(316002)(66946007)(66556008)(53546011)(36916002)(6506007)(6512007)(6486002)(478600001)(31686004)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0JiRnZUSFZqcHplbXBoaGJqU2ZneUxoYzB4aVB5NG44cWh6ZHQ3eFVvRXh1?=
 =?utf-8?B?NHBTTEs1T2N5SDNpOEN2UmMxR0RKS0locUIrdHY5UER4QXhtTXFsNTlQc0s4?=
 =?utf-8?B?bUF2czVPK1lzVk5LVVV6cW1tT3JuamZlWS9Oc3VBMS9BSWQ4REVpRjk2OFps?=
 =?utf-8?B?MkZJU3huK0xuZEtDakdtVEVkbENxcjhYMzMrRjV5emUzamV5UXFScHEzOW5F?=
 =?utf-8?B?bkpWWHcyaGpPSHlwMnVqMndmNVcreEF5UmxucGh3WGRDS1pwY0VxYUhEaUUx?=
 =?utf-8?B?NndITEsybDNDazk1T24xU1pCOVJ5KzVDVVJsQjUvN0plVzN5RzdxVmxlekhm?=
 =?utf-8?B?dFBTWXl4WlVpSFJFanBDZEJSaU9xbEJFeXY2Z0dzTjB3bUpMVStnSkpxbEh3?=
 =?utf-8?B?cXY3Y3hrZ045aldrWnAybEp6bmptOVhJLzN1K3pkdDFMQm1idmF2Ums4ZDF6?=
 =?utf-8?B?M2dDak50UW5mYnhVOXU3YWF4amNPMCtxQ0lMTHI0NUN5dkd0YzQxNHNlRk5o?=
 =?utf-8?B?V3h6ZFJYZmhvNjhNY3Vka2tBMFl2Rmd5QnZxNUp4dmR5MWVDVVc3VXpOS2Jr?=
 =?utf-8?B?dHFQQVpWTE1pWDJ6cG80UFJSbU02VERFM3JsQWorbGl2RFJJT1lITVZraVB2?=
 =?utf-8?B?eTBWaGVjNkFscVJldjFEcTVmak5MSDRKUmx0WHVSYmIxVkhuRi95RHFPWXVl?=
 =?utf-8?B?R1RldFkrOTFwVnhrRzJPeU1pNjYvdjRobGdiUmF3TnBNYVJ1eU5SUUMyc2sw?=
 =?utf-8?B?cU9KODhoZGZ3UENTQ0Q3YnVwdG5SV2F3TkRTdG5VQkxHWGpkUUo0cnRDN0xw?=
 =?utf-8?B?SE1henI0V3AxSUhUUm5wVTlHQVR6b3VoSXQzN0Z5TXVzVklIOVBPSmh6b3VW?=
 =?utf-8?B?NlBISVNpdTE2Z3pYS2U0SVFKN0RTNmFXVkRuUGVwWFRWcmlsaHRjbFY1YWYv?=
 =?utf-8?B?RUlhU2kxSW1hcDRsK1hZRnRKWEY3THFXamp3UmRnVjlMVVR2Z295WG02eENi?=
 =?utf-8?B?TWlEd2dOaStIckxSSTlYcUg2Zm9NV3Uxd3pZK0tVNFlPbmsvY3ZqbmNaU3Ir?=
 =?utf-8?B?cXd3d0oxdE0wZWVKQmNpdFJxVWlnZ3JIbktjcUJKV3pQMDBqb2FEKzJXT2s2?=
 =?utf-8?B?aUloKzlhcExDU29YTldOTE1idUk0cDFXQ1ZTNkt2YWE3NDg1YkFFeEVtSEVJ?=
 =?utf-8?B?cTlLUm5pN1E1LzAxQVYwVUFraERsWStjV3lUbk91WEpjK05GNmZueExrR3lH?=
 =?utf-8?B?VGxTUXZHY2owSS9Nb0tpM2JCem1PQjF3MnBjR21nd3hURlFDZncxRjY4dEl1?=
 =?utf-8?B?czJOS2RmUzE2NVczSGdVYXB6S29lQm9yRzM4LzVuMXJJRHBGN080cUt3eXpY?=
 =?utf-8?B?Rm9HTkZwaTFKZ25IMnJFV1FLcU5WU2tsS2ZLMWZjYjBrZE5MTHBnUTRkOTVQ?=
 =?utf-8?B?SU1ldGg1V0YydjJkeW56Q25wM1paUkdNUisyZFBNN3JLbG9aWWtOSHh4YmxY?=
 =?utf-8?B?dm81Nm5Vckc0WmRGSE5ET0dSR1VrbUJQOXhIeFhpSEJZRDM3N241ekxlYkFt?=
 =?utf-8?B?RUVCekNiVjFXeXN3T0xpcVZFclZhQWErL2ljWFBObFdLZDZ0d0pqOFg0RExh?=
 =?utf-8?B?T0hjOWZkbEdWME5uWkk5RkNlSmtSTlZtbnNmOG0zSi9XSG9GWll4T1lKWWZs?=
 =?utf-8?B?VURlN0trcmprclR3N3kxc25ORFEwSVNtdWl4WHkzTzBZYTArblk0WkFWRm1T?=
 =?utf-8?B?WlNrUTlLd1lwZGhuMWxLSXRNK1FkQUkyQURHZXVHNkRETWJ4cHExUzRuZHAx?=
 =?utf-8?B?TXdqQUZDZ1JjcVFiVmNUak9WU3A3VXp1SlNxS2NydGtrd2dMSnBUdGh3c1gw?=
 =?utf-8?B?Q0M0ejVJZHlEOW9YbExlSXJHNmgzRHF2QkI1NXVhVXR6bXl5MnR5LytzSUox?=
 =?utf-8?B?a0RjTHBmelNxc0pBNVk4dHRNSTNIc1ZLc3BZcVJqdVdib2NNa0pMaXVEdFN6?=
 =?utf-8?B?cUV2SGFjYlgrdFlZQXd5SWhCcWdhZUVJbkc0cFk1T1cxamwzdkgwa1pSYmht?=
 =?utf-8?B?V09wbzl2ZUQyU2phdkgrT0pLMGIybGpacGVmUnFNcjMxVnM4NHd4MEdldUda?=
 =?utf-8?B?N0J4UmtyQUkwMHFTdm90ZklILy9YOTZiN09lclpIUFpoeUZjbzY3cHNWeENx?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	R5VchmCLJNx5cTQcuSGQFO4An7wxIIJk85cJ0K2tFyVHuqzSpF1nLY21NgXLH+WO7l5fSQEpq23EprpkD0zFHisdauJxpQ6HYtdsWoAtppIH+CmhmxUOjc8ZPpQXS4ASk8aYhhoYVHRm2v2zF2oodhyUtQMk/0GRqT0kbJ0/9P4KCdsY2WxKP+rH5lDya1yO3Ymgs1Uu9L8kzF8gGsBVIHF69lQj9tHxBGiXh9huY+sEsWXTH4Q1GBEMuk7QjjmnCLGAXlizcywbie9p9Zjkrf3dg3/125XHAcy04ncD1uE0vAo9ljMtSI8tMLW9HLfrMaw/FdBGQ9d+OnhQZVVFnrZkeRTxugWWXG+up7GP6WnvgjVFYXelGQiYPW/n3X8blko4PTRSjKPysW8HwZpAIuK8jbc9P8Zj8pFxjBhEd91p6KkesEp5HmUQj1A2LCDZMRZG68W03wew6RFfihvYnl6kdd1TsPGKRf2Gol/vEQXuIXvw/rv7R8MHhA7fQX8uRexZ0tshq1f/McbAXs3yeASULYDwIvsXwqYnI3z7DaH69yntQifUmnweIu6HLaJjqUkNgBeSJ5qwjqXeraPb09rDZPQvOBASqp809BSF3YA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e187191-c51e-42e5-c989-08dc2d502c85
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 11:29:14.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFeOyFGqrBHduDdXex8XVppInEfg1O5zCS0YA3yuB5yQV6j9o4jjLRp7w+WUe+qN08vkCt+L7iIMzp5TE1Mo/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140090
X-Proofpoint-GUID: hd9d17jBr9QvzqGjQxmOrZMPBVRhRKG-
X-Proofpoint-ORIG-GUID: hd9d17jBr9QvzqGjQxmOrZMPBVRhRKG-

On 14/02/2024 09:38, Nilay Shroff wrote:
> 
> 
> On 2/13/24 17:22, John Garry wrote:
>> On 13/02/2024 11:08, Nilay Shroff wrote:
>>>> It's relied that atomic_write_unit_max is <= atomic_write_boundary and both are a power-of-2. Please see the NVMe patch, which this is checked. Indeed, it would not make sense if atomic_write_unit_max > atomic_write_boundary (when non-zero).
>>>>
>>>> So if the write is naturally aligned and its size is <= atomic_write_unit_max, then it cannot be straddling a boundary.
>>> Ok fine but in case the device doesn't support namespace atomic boundary size (i.e. NABSPF is zero) then still do we need
>>> to restrict IO which crosses the atomic boundary?
>>
>> Is there a boundary if NABSPF is zero?
> If NABSPF is zero then there's no boundary and so we may not need to worry about IO crossing boundary.
> 
> Even though, the atomic boundary is not defined, this function doesn't allow atomic write crossing atomic_write_unit_max_bytes.
> For instance, if AWUPF is 63 and an IO starts atomic write from logical block #32 and the number of logical blocks to be written

When you say "IO", you need to be clearer. Do you mean a write from 
userspace or a merged atomic write?

If userspace issues an atomic write which is 64 blocks at offset 32, 
then it will be rejected.

It will be rejected as it is not naturally aligned, e.g. a 64 block 
writes can only be at offset 0, 64, 128,

> in this IO equals to #64 then it's not allowed.
>  However if this same IO starts from logical block #0 then it's allowed.
> So my point here's that can this restriction be avoided when atomic boundary is zero (or not defined)?

We want a consistent set of rules for userspace to follow, whether the 
atomic boundary is zero or non-zero.

Currently the atomic boundary only comes into play for merging writes, 
i.e. we cannot merge a write in which the resultant IO straddles a boundary.

> 
> Also, it seems that the restriction implemented for atomic write to succeed are very strict. For example, atomic-write can't
> succeed if an IO starts from logical block #8 and the number of logical blocks to be written in this IO equals to #16.
> In this particular case, IO is well within atomic-boundary (if it's defined) and atomic-size-limit, so why do we NOT want to
> allow it? Is it intentional? I think, the spec doesn't mention about such limitation.

According to the NVMe spec, this is ok. However we don't want the user 
to have to deal with things like NVMe boundaries. Indeed, for FSes, we 
do not have a direct linear map from FS blocks to physical blocks, so it 
would be impossible for the user to know about a boundary condition in 
this context.

We are trying to formulate rules which work for the somewhat orthogonal 
HW features of both SCSI and NVMe for both block devices and FSes, while 
also dealing with alignment concerns of extent-based FSes, like XFS.

> 
>>
>>>
>>> I am quoting this from NVMe spec (Command Set Specification, revision 1.0a, Section 2.1.4.3) :
>>> "To ensure backwards compatibility, the values reported for AWUN, AWUPF, and ACWU shall be set such that
>>> they  are  supported  even  if  a  write  crosses  an  atomic  boundary.  If  a  controller  does  not
>>> guarantee atomicity across atomic boundaries, the controller shall set AWUN, AWUPF, and ACWU to 0h (1 LBA)."
>>
>> How about respond to the NVMe patch in this series, asking this question?
>>
> Yes I will send this query to the NVMe patch in this series.

Thanks,
John


