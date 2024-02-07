Return-Path: <linux-fsdevel+bounces-10609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76884CC6F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 15:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529662882AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EDE7C095;
	Wed,  7 Feb 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q9uX0SzI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UMBPduUJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA197D3FD;
	Wed,  7 Feb 2024 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315236; cv=fail; b=Khmf2vULHGglNZISCiVLd65U16q5bKH2EdDRfXlm+NfSZpCOF4R0BWG/Emo72iwT5INyXDPb8X3jkhke5Skotrlyivu88EIlZMGJCq6yj6PswQclwWDdvEq6I4jLhSUzUzKynUBixK6+gQmlndjkM+OxinUAN152NgpvYxamUmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315236; c=relaxed/simple;
	bh=co2aikjS2qPJ7u3ZC6hgUMFafmi1uGsEny+LACbzaj0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZBmfvU5tLB0EfjlItRirdWjUCjcE/JAOAnLk7mpR6CcQ2cAVgZNU/FaZ1WDO1Qiymi+y9BzBTo+FeV7TZgz3S5y8PhFfR/if6acoU4K/wEQBjgr9yLGzyT+0KkSWBAAmcXV97QTV6seVDTS5tyFXlD+jXVT3GAplq7e/6i1uvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q9uX0SzI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UMBPduUJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 417DWYMp023056;
	Wed, 7 Feb 2024 14:13:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TgcIdDTY9KiNMXuBG4TK8XhrI4ePCJX0nyK3/uJIE3c=;
 b=Q9uX0SzIW7VM5SsaWu9MGJvs+zjuu10cR9Ey2u12uhTL7KDYEIWbng+mbL/IcOzxARON
 lWF+t6d/aPj8NG4P0DWEvKfx7rRUmeD/2kNXCtJg9lbtjZkpmO6aE1CYq6+ekHL2Qadt
 h7QNVz/k4WDBxxhtikHJVn1GL4Oi6tQwzpH3h6izLAwdwVtT+XsOz1pszMdXPh/5wIm6
 2NyGkb534nDlX5pxOjrbgpV4HGQK/uE/iJh4pjoMD8XR95F4WYEnSHBvTCzbYMe8TxbD
 YPkq9P1m9+ZTCuFRUbAekNCXU5asJx13vNIskkI1+msfUsMeUu8C8pZdhkbqKEAav0Vb wQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c32svgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 14:13:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 417D15XR007087;
	Wed, 7 Feb 2024 14:13:33 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx9b5mw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Feb 2024 14:13:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TovQcEyU9xjUEKv/F1azv8P6lW2Qlmko5Zo5O/v6Dbi9di6f1VSLa69gfls52B6/b0nULlTF33KABmc3pxAsHhacbz1sEWMn4Q+INyzB7fFn5NDtRbcp8svGiCi9A8RyaYVVITFNVoDBqwGSGvzvrTpK/aPdzRiRfDCPuvubJZjnYq8DIkt11DvImSDPkYvbugnm0uDNm0TgRh+AVwt42F5KBIuj7+10CIB6XVsEEXJOgyvRLBNBzxWBPF/a2nU+qMwGe9h/mtWG8J10ss0IUHW7O7J1z1FA/ky+JLSEKBgwmWoGHj1PxsGxSje8X6pYyGwvJGkGB1nMKb33BxNrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgcIdDTY9KiNMXuBG4TK8XhrI4ePCJX0nyK3/uJIE3c=;
 b=HEchAzAGaQQa22IRH3Pr/6SubkzS5ewWfztFSClpLjewq/lwiOHoGDtQUgtZmyIcLS7xD/rNbtpojdrwK/xv5fcfuPvFH/LlDaJlUXNvx4pqmObyzP/sW+j96LvD0dMXMGt311FW95ke87cbS+mb2yFzwrYmprpSlUvrnkvyAvuQEaz4ZQIfdLY7WzLO2kTkuQuBoSk9vzaZPMrBJ1wnWqWcqMilpUcGb6OhxoPf74pXmuYtwD0yFeUsLXlTjtrTNrUh4qUsPz7zkDAD6sMG2H07p+uVrQZgFIrLXBA0nbnhOSrtlYUcSl1q8Lh/uNFyNUwCj8OnvhYwaRe13HFSsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgcIdDTY9KiNMXuBG4TK8XhrI4ePCJX0nyK3/uJIE3c=;
 b=UMBPduUJtau2tnE++3DWJ7dgvdtIyr5QxL/6BlprNjbCcjCRmWt4yX9hSpvU6ZlvbF4KEBKRTIwd6kZ7HJeY3RpfnlmRAbVUXqbzUidIHcnr/xWb9ycx9a90bOHgN9KPGqNP/u7WnPxcmy8mEGnnOSmxq3wTnkjymDrIsROABlA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB5561.namprd10.prod.outlook.com (2603:10b6:510:f0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 14:13:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 14:13:28 +0000
Message-ID: <a20b3c07-605e-44c2-b562-e98269d37558@oracle.com>
Date: Wed, 7 Feb 2024 14:13:23 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        chandan.babu@oracle.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
 <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
 <ZcGIPlNCkL6EDx3Z@dread.disaster.area>
 <434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com>
 <ZcLJgVu9A3MsWBI0@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZcLJgVu9A3MsWBI0@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0355.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfb280a-4ac5-4506-8d72-08dc27e6f48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	46tcZk6ncMBiYVIoH2a+xhSIa/YX0wy9jfJLbnuP4AFU5x/UlEFT21SFoNJjGsf9XQETTaGifD6T4GpNzmhIMtsb7euGcniA/eIpIGn9W4NsFj1ftFazk+Jf5AId1nF1uDVBnoA27KUSBbsuCgGMQA4cw/OisZZeJX/5WruTPIVqejoCWh8E2Thmx/QRMLN34QWc5PQGIlWIoJiROoDD1j7B7GNEekgX/nte7+6ag1O5XEGYIlUJw58yyK381p0NJib8lPo9XKc4BDciXfG1lGu9sAxD8tJMagtSGyHC0wp7AtZ5sPKZqGLUtr3gAgbwYvPgifjTa3mbmtbKNK+RJul8i5ZDOPXJaKkF6aUQXTAcBfLV4Tlxg+S1zpCHj1LBZXDeCgbYej+wCoug4otZ043NZp5uS4oEEP3JuLmlo5/XmcfGtcmh6BLwYhSpSqU1XaQl3C4q8HNHb44Q1v3QW9uR4uXrJlMSmnOre32B689I53o+br9EK32Xdz6EntXuMxUJ2N4mVLPEXcAiaxGhlMC1rlUfgu6enHe0oOye96uWaeU/lxp5gFMQFhaDdgZkx50+itzktYwuoxNvSSSQuGCkY6TYgTVnk7fggGx6djTCjwx4+FJOH4gpdCIO6kkHVvi4fE5MD/c17x5WfRK5Og==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(376002)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66899024)(41300700001)(31696002)(83380400001)(8936002)(478600001)(966005)(66556008)(6916009)(6486002)(66476007)(36756003)(6506007)(53546011)(66946007)(6512007)(6666004)(8676002)(316002)(4326008)(36916002)(38100700002)(26005)(86362001)(2616005)(5660300002)(7416002)(30864003)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cm9nNCtjaTNxaXhKajFPeE1lRGs5ZWFnT285TkpvenhSYkxoNGVZbEMvNm5C?=
 =?utf-8?B?VzFhZnZNMWppSjlCQS9ySytENFdaZmdJVno4WFNCaCtzTW5QVzlhZ0h6TUMw?=
 =?utf-8?B?MEJ3YWpTem9rTy9RU1pOVUIzL2huaXdRMTVENGg1OU1VeW42Nk9uY1B2YXQw?=
 =?utf-8?B?K3JTeXJrYkdZNHlQeEo1VkNnZldhNGU0eDdQeldma2pyYVIzWFkvdzdoZjQv?=
 =?utf-8?B?bEdYR1MvMlJSQVNxTWthSlZYVVZySkI0OW9UYms3SkJBNllvNGgxdDg3aEYv?=
 =?utf-8?B?VlRIT3l4ZjYvUW5lUHV2NU93MDZWV0FzRXIxV1J1UFcwUFlRRXNvYmtUOWxT?=
 =?utf-8?B?NDlZTHBXSkZSNDkrT1FJSXlCQXR2Y3RUcDBZa0gxMjc4dk5OT0R5d0U5TzZz?=
 =?utf-8?B?ZFJSOVV2WStYU2NoN1NmT1BiendIV0xhL2RCZFVEVitNV0RhU2lvZFE5bWcx?=
 =?utf-8?B?cGtKR3MrWUJ6dGd4VERCWFJVTWFqMGNNVDFrZXhQTndTWXF0VGw1SVdiRXA3?=
 =?utf-8?B?N3NPSlZVNG1zUkhTOEMzVW5wSzQ5dnQ4M0NGamh0SmIvdFczL1pwYURqWUI5?=
 =?utf-8?B?M1Z2VksybE5GRXhIZEt6UnVYc1hBYVUvdW1OaktMdGFER1VmUUNFQ1BFRzlz?=
 =?utf-8?B?aEI1MHAxNGM4SzdUbkJYcjcrZjRXNEhoQnVucUJtN29EWGRDUlozQ1NqUGM3?=
 =?utf-8?B?TjB5djhUbDVydTUxdUdsenYwamorL2M3Mzcwc09PNGM1dENSR3BzcFRQZ0Q3?=
 =?utf-8?B?cSszN0g3eG1xbGM4TnUwQUtoSmw1NjU1Rk5FWmx1UXhKRGJ0STN0WWtVUGtB?=
 =?utf-8?B?UHZvMXdvRzRtZjgwY2Z6ckpyYjR6Q0dEOVBmNUVJSHZzbmFCRGYxYjZHVlh4?=
 =?utf-8?B?S0YzOEwrQVJ5WnNoUVkyekFyNEhSY2dWWmhEUmNWaldXWjZwYURWNkNaSXJr?=
 =?utf-8?B?cjMxZWVCU2ZUS0FtbEtrZWt4Q3ZpdGVxSHh5T05ycW93eTVjZ2VhcVo1V0xR?=
 =?utf-8?B?Um5pV1dBdGtEUmdaOFo4S1p5bURwZlhQZGIxRWRXeDg1emdNVWdMWGsybnhh?=
 =?utf-8?B?UTBLRzl4WDhQN0lkbnFtUUxGQmNhRURSWGtpSEpoTUJoenVyTnh3eXhuSVh4?=
 =?utf-8?B?VUU5YUNET2UrTm12M3dIWG9CZnhkWmZjcGxSRXJxNHY4TXpXbnhxL2tiVDFl?=
 =?utf-8?B?RnBWUEtYYnRFYTBlRXN2UmRPOHc2ZXQwWWVTUUo2dzJqMmJZejFTam9wcFp1?=
 =?utf-8?B?bnZlb0N5blVJVENrQnlHSVAyRXVNdzhTM1NqUXhLcnI4ckxUcEl3QVl4S1Fo?=
 =?utf-8?B?TzVTWS9TMVNTL01URStPMlBVS29tbmtvMTBxMTdXMnpHOS9PQUJLZHpLK1NK?=
 =?utf-8?B?VDBndjFCWVdiRzBvak80MThOVlVBaXhEdDdnK0VCRlJ6QkgwNi9Vd2VRVXVn?=
 =?utf-8?B?OHQvU3huWXdTeWY0VUJETHcvdkdqc0c0QzVTR0RLOVdwRTZkclEwOGQ0dkxF?=
 =?utf-8?B?WlloMzJmdWpraEFVelphK3FUUFFSY2FOOHZqRUdRN0ZjdlhrYytHL2RsYkJx?=
 =?utf-8?B?c0pRSkdTdG1VVlRwRnkyUnRNeTF3czJsV09VTnMrRkd2NFZqS2JVTEJoRWQz?=
 =?utf-8?B?cGZDNmRVdWl4SUpkdjNLRG9XSFhTUmd1WElCRFVGREk3VGw2VDdtbmEzRUlU?=
 =?utf-8?B?N1l2dmtjbmNtY1Frc2VDVEUra1FYZnErVGpTeENjYlZhNzhKa3V0dlFMbExJ?=
 =?utf-8?B?dFVYZ2l3NDQvMFl0dytOUW9QZ3BQRWloWnhzbVUvWWhnOE1GZXVsdXVzaWlC?=
 =?utf-8?B?WEZWdjU2VVhyOEVTK0NsQWp1MnA0Qjh3MTZNOG5FQ045dGNDb2hmWFBRbk5q?=
 =?utf-8?B?cnZlbFYzRWNvaklkL1JUdFczUGFWTWh3RnIzYThKK2dubkgyait0aUtGcnhr?=
 =?utf-8?B?ZlJtMEIzaVFPWUhlZGRtbUVwaEk2VkxiOUhRWkM3OFVibWVFdkx3K2swL1Jh?=
 =?utf-8?B?TmFvT3ZKTE0xZDRjUnJUTUZpZ2wxM01oQkdZVEpva2huSDhCVi9GMVRuOWFN?=
 =?utf-8?B?Z0ZuekpETEJPdkdmVWVLRVFVTUU1QkpPNzlRWk5kaUpxSERJckNDRlFvU0dk?=
 =?utf-8?Q?532ldkWuagNsBW74BKSVD6J0m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	FcTkdfyEQv8Ud1sit4ofiNmtATfdGnHz4TJn/3idDUa6Uqr6xSvgeL+bjcu+hm+kck39KPJMBJK5hToUTz3Tb5Ai1aWprJ85ifFdyUJkMp9YVlLExKdbO20Ik97So4ilNgw2fhCgpY+NAUr9PIuaZLnfTqJNeH0JzA3LrKf9N6QjpIrF/VMQTXeiQgutnak/3B4WYxldF3NuUCtSMjVUst0HD/KfHB19I8deVV7wfACCx08B4cTRli4naVFtemjNy5oKJyI4jz7iBNhBVQXD65dBwHxvcF4PBvqMvxT/QwWjwPzWuzhOSRTrlKzhJsp4LeszPXuL1iWFzdmbMnfs5jY1JINqZQ4m4nxIE33lFgN6vu8iGjffz4tUyKSRLwcXtUBmSb4G/3lTiakggmiM5I52DWl/oQ8IqMm9qjHY24/ERiTnOet8Id9UwKt6cPLi5LTh/TV1kGJHzIwJS+BqnNaPE1b//6/XBRxRyZhvy8x0hkvrc7644TLvdNtIn8hT7KqgMydGHzrPgoYNb7PFirKaYV/Ylnp+nVIfU+3gG7rJyMIze9s2HoQCrKuyyZc333OPe76Ep0hBQrA9WVD2lmEtOMPnqTbB1OUR7ApRzIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfb280a-4ac5-4506-8d72-08dc27e6f48f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 14:13:28.1012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XaOHvgUxM4OFaSvI1P3UWhXNRluL+prSB9n1fauQeXpIekm+aZgFSsyW8ROM2UewILeOmSMXzeN3a8zbWEL+Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-07_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402070106
X-Proofpoint-GUID: ctfWYJLnJmP4zXOjZ7Q2VbkBwFao-4jb
X-Proofpoint-ORIG-GUID: ctfWYJLnJmP4zXOjZ7Q2VbkBwFao-4jb

On 07/02/2024 00:06, Dave Chinner wrote:
>>> We really, really don't want to be doing this during allocation
>>> unless we can avoid it. If the filesystem block size is 64kB, we
>>> could be allocating up to 96GB per extent, and that becomes an
>>> uninterruptable write stream inside a transaction context that holds
>>> inode metadata locked.
>> Where does that 96GB figure come from?
> My inability to do math. The actual number is 128GB.
> 
> Max extent size = XFS_MAX_BMBT_EXTLEN * fs block size.
> 	        = 2^21  * fs block size.
> 
> So for a 4kB block size filesystem, that's 8GB max extent length,
> and that's the most we will allocate in a single transaction (i.e.
> one new BMBT record).
> 
> For 64kB block size, we can get 128GB of space allocated in a single
> transaction.

atomic write unit max theoretical upper limit is 
rounddown_power_of_2(2^32 - 1) = 2GB

So this would be what is expected to be the largest extent size 
requested for atomic writes. I am not saying that 2GB is small, but 
certainly much smaller than 128GB.

> 
>>>>> Why do we want to write zeroes to the disk if we're allocating space
>>>>> even if we're not sending an atomic write?
>>>>>
>>>>> (This might want an explanation for why we're doing this at all -- it's
>>>>> to avoid unwritten extent conversion, which defeats hardware untorn
>>>>> writes.)
>>>> It's to handle the scenario where we have a partially written extent, and
>>>> then try to issue an atomic write which covers the complete extent.
>>> When/how would that ever happen with the forcealign bits being set
>>> preventing unaligned allocation and writes?
>> Consider this scenario:
>>
>> # mkfs.xfs -r rtdev=/dev/sdb,extsize=64K -d rtinherit=1 /dev/sda
>> # mount /dev/sda mnt -o rtdev=/dev/sdb
>> # touch  mnt/file
>> # /test-pwritev2 -a -d -l 4096 -p 0 /root/mnt/file # direct IO, atomic
>> write, 4096B at pos 0
> Please don't write one-off custom test programs to issue IO - please
> use and enhance xfs_io so the test cases can then be put straight
> into fstests without adding yet another "do some minor IO variant"
> test program. This also means you don't need a random assortment of
> other tools.
> 
> i.e.
> 
> # xfs_io -dc "pwrite -VA 0 4096" /root/mnt/file
> 
> Should do an RWF_ATOMIC IO, and
> 
> # xfs_io -dc "pwrite -VAD 0 4096" /root/mnt/file
> 
> should do an RWF_ATOMIC|RWF_DSYNC IO...
> 
> 
>> # filefrag -v mnt/file
> xfs_io -c "fiemap" mnt/file

Fine, but I like using something generic for accessing block devices and 
also other FSes. I didn't think that xfs_io can do that.

Anyway, we can look to add atomic write support to xfs_io and any other 
xfs-progs

> 
>> Filesystem type is: 58465342
>> File size of mnt/file is 4096 (1 block of 4096 bytes)
>>    ext:     logical_offset:        physical_offset: length:   expected:
>> flags:
>>      0:        0..       0:         24..        24:      1:
>> last,eof
>> mnt/file: 1 extent found
>> # /test-pwritev2 -a -d -l 16384 -p 0 /root/mnt/file
>> wrote -1 bytes at pos 0 write_size=16384
>> #
> Whole test as one repeatable command:
> 
> # xfs_io -d -c "truncate 0" -c "chattr +r" \
> 	-c "pwrite -VAD 0 4096" \
> 	-c "fiemap" \
> 	-c "pwrite -VAD 0 16384" \
> 	/mnt/root/file
>> For the 2nd write, which would cover a 16KB extent, the iomap code will iter
>> twice and produce 2x BIOs, which we don't want - that's why it errors there.
> Yes, but I think that's a feature.  You've optimised the filesystem
> layout for IO that is 64kB sized and aligned IO, but your test case
> is mixing 4kB and 16KB IO. The filesystem should be telling you that
> you're doing something that is sub-optimal for it's configuration,
> and refusing to do weird overlapping sub-rtextsize atomic IO is a
> pretty good sign that you've got something wrong.

Then we really end up with a strange behavior for the user. I mean, the 
user may ask - "why did this 16KB atomic write pass and this one fail? 
I'm following all the rules", and then "No one said not to mix write 
sizes or not mix atomic and non-atomic writes, so should be ok. Indeed, 
that earlier 4K write for the same region passed".

Playing devil's advocate here, at least this behavior should be documented.

> 
> The whole reason for rtextsize existing is to optimise the rtextent
> allocation to the typical minimum IO size done to that volume. If
> all your IO is sub-rtextsize size and alignment, then all that has
> been done is forcing the entire rt device IO into a corner it was
> never really intended nor optimised for.

Sure, but just because we are optimized for a certain IO write size 
should not mean that other writes are disallowed or quite problematic.

> 
> Why should we jump through crazy hoops to try to make filesystems
> optimised for large IOs with mismatched, overlapping small atomic
> writes?

As mentioned, typically the atomic writes will be the same size, but we 
may have other writes of smaller size.

> 
>> With the change in this patch, instead we have something like this after the
>> first write:
>>
>> # /test-pwritev2 -a -d -l 4096 -p 0 /root/mnt/file
>> wrote 4096 bytes at pos 0 write_size=4096
>> # filefrag -v mnt/file
>> Filesystem type is: 58465342
>> File size of mnt/file is 4096 (1 block of 4096 bytes)
>>    ext:     logical_offset:        physical_offset: length:   expected:
>> flags:
>>      0:        0..       3:         24..        27:      4:
>> last,eof
>> mnt/file: 1 extent found
>> #
>>
>> So the 16KB extent is in written state and the 2nd 16KB write would iter
>> once, producing a single BIO.
> Sure, I know how it works. My point is that it's a terrible way to
> go about allowing that second atomic write to succeed.
I think 'terrible' is a bit too strong a word here. Indeed, you suggest 
to manually zero the file to solve this problem, below, while this code 
change does the same thing automatically.

BTW, there was a request for behavior like in this patch. Please see 
this discussion on the ext4 atomic writes port:

https://lore.kernel.org/linux-ext4/ZXhb0tKFvAge%2FGWf@infradead.org/

So we should have some solution where the kernel automatically takes 
care of this unwritten extent issue.

> 
>>>> In this
>>>> scenario, the iomap code will issue 2x IOs, which is unacceptable. So we
>>>> ensure that the extent is completely written whenever we allocate it. At
>>>> least that is my idea.
>>> So return an unaligned extent, and then the IOMAP_ATOMIC checks you
>>> add below say "no" and then the application has to do things the
>>> slow, safe way....
>> We have been porting atomic write support to some database apps and they
>> (database developers) have had to do something like manually zero the
>> complete file to get around this issue, but that's not a good user
>> experience.
> Better the application zeros the file when it is being initialised
> and doesn't have performance constraints rather than forcing the
> filesystem to do it in the IO fast path when IO performance and
> latency actually matters to the application.

Can't we do both? I mean, the well-informed user can still pre-zero the 
file just to ensure we aren't doing this zero'ing with the extent 
allocation.

> 
> There are production databases that already do this manual zero
> initialisation to avoid unwritten extent conversion overhead during
> runtime operation. That's because they want FUA writes to work, and
> that gives 25% better IO performance over the same O_DSYNC writes
> doing allocation and/or unwritten extent conversion after
> fallocate() which requires journal flushes with O_DSYNC writes.
> 
> Using atomic writes is no different.

Sure, and as I said, they can do both. The user is already wise enough 
to zero the file for other performance reasons (like FUA writes).

> 
>> Note that in their case the first 4KB write is non-atomic, but that does not
>> change things. They do these 4KB writes in some DB setup phase.

JFYI, these 4K writes were in some compressed mode in the DB setup 
phase, hence the smaller size.

> And therein lies the problem.
> 
> If you are doing sub-rtextent IO at all, then you are forcing the
> filesystem down the path of explicitly using unwritten extents and
> requiring O_DSYNC direct IO to do journal flushes in IO completion
> context and then performance just goes down hill from them.
> 
> The requirement for unwritten extents to track sub-rtextsize written
> regions is what you're trying to work around with XFS_BMAPI_ZERO so
> that atomic writes will always see "atomic write aligned" allocated
> regions.
> 
> Do you see the problem here? You've explicitly told the filesystem
> that allocation is aligned to 64kB chunks, then because the
> filesystem block size is 4kB, it's allowed to track unwritten
> regions at 4kB boundaries. Then you do 4kB aligned file IO, which
> then changes unwritten extents at 4kB boundaries. Then you do a
> overlapping 16kB IO that*requires*  16kB allocation alignment, and
> things go BOOM.
> 
> Yes, they should go BOOM.
> 
> This is a horrible configuration - it is incomaptible with 16kB
> aligned and sized atomic IO. 

Just because the DB may do 16KB atomic writes most of the time should 
not disallow it from any other form of writes.

Indeed at 
https://lore.kernel.org/linux-nvme/ZSR4jeSKlppLWjQy@dread.disaster.area/ 
you wrote "Not every IO to every file needs to be atomic." (sorry for 
quoting you)

So the user can do other regular writes, but you say that they should be 
always writing full extents. This just may not suit some DBs.

> Allocation is aligned to 64kB, written
> region tracking is aligned to 4kB, and there's nothing to tell the
> filesystem that it should be maintaining 16kB "written alignment" so
> that 16kB atomic writes can always be issued atomically.
> 
> i.e. if we are going to do 16kB aligned atomic IO, then all the
> allocation and unwritten tracking needs to be done in 16kB aligned
> chunks, not 4kB. That means a 4KB write into an unwritten region or
> a hole actually needs to zero the rest of the 16KB range it sits
> within.
> 
> The direct IO code can do this, but it needs extension of the
> unaligned IO serialisation in XFS (the alignment checks in
> xfs_file_dio_write()) and the the sub-block zeroing in
> iomap_dio_bio_iter() (the need_zeroing padding has to span the fs
> allocation size, not the fsblock size) to do this safely.
> 
> Regardless of how we do it, all IO concurrency on this file is shot
> if we have sub-rtextent sized IOs being done. That is true even with
> this patch set - XFS_BMAPI_ZERO is done whilst holding the
> XFS_ILOCK_EXCL, and so no other DIO can map extents whilst the
> zeroing is being done.
> 
> IOWs, anything to do with sub-rtextent IO really has to be treated
> like sub-fsblock DIO - i.e. exclusive inode access until the
> sub-rtextent zeroing has been completed.

I do understand that this is not perfect that we may have mixed block 
sizes being written, but I don't think that we should disallow it and 
throw an error.

I would actually think that the worst thing is that the user does not 
know this restriction.

> 
>>>>> I think we should support IOCB_ATOMIC when the mapping is unwritten --
>>>>> the data will land on disk in an untorn fashion, the unwritten extent
>>>>> conversion on IO completion is itself atomic, and callers still have to
>>>>> set O_DSYNC to persist anything.
>>>> But does this work for the scenario above?
>>> Probably not, but if we want the mapping to return a single
>>> contiguous extent mapping that spans both unwritten and written
>>> states, then we should directly code that behaviour for atomic
>>> IO and not try to hack around it via XFS_BMAPI_ZERO.
>>>
>>> Unwritten extent conversion will already do the right thing in that
>>> it will only convert unwritten regions to written in the larger
>>> range that is passed to it, but if there are multiple regions that
>>> need conversion then the conversion won't be atomic.
>> We would need something atomic.
>>
>>>>> Then we can avoid the cost of
>>>>> BMAPI_ZERO, because double-writes aren't free.
>>>> About double-writes not being free, I thought that this was acceptable to
>>>> just have this write zero when initially allocating the extent as it should
>>>> not add too much overhead in practice, i.e. it's one off.
>>> The whole point about atomic writes is they are a performance
>>> optimisation. If the cost of enabling atomic writes is that we
>>> double the amount of IO we are doing, then we've lost more
>>> performance than we gained by using atomic writes. That doesn't
>>> seem desirable....
>> But the zero'ing is a one off per extent allocation, right? I would expect
>> just an initial overhead when the database is being created/extended.
> So why can't the application do that manually like others already do
> to enable FUA optimisations for O_DSYNC writes?

Is this even officially documented as advice or a suggestion for users?

> 
> FWIW, we probably should look to extend fallocate() to allow
> userspace to say "write real zeroes, not fake ones" so the
> filesystem can call blkdev_issue_zeroout() after preallocation to
> offload the zeroing to the hardware and then clear the unwritten
> bits on the preallocated range...

ack

> 
>>>>>>     	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
>>>>>>     			rblocks, force, &tp);
>>>>>>     	if (error)
>>>>>> @@ -812,6 +815,44 @@ xfs_direct_write_iomap_begin(
>>>>>>     	if (error)
>>>>>>     		goto out_unlock;
>>>>>> +	if (flags & IOMAP_ATOMIC) {
>>>>>> +		xfs_filblks_t unit_min_fsb, unit_max_fsb;
>>>>>> +		unsigned int unit_min, unit_max;
>>>>>> +
>>>>>> +		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
>>>>>> +		unit_min_fsb = XFS_B_TO_FSBT(mp, unit_min);
>>>>>> +		unit_max_fsb = XFS_B_TO_FSBT(mp, unit_max);
>>>>>> +
>>>>>> +		if (!imap_spans_range(&imap, offset_fsb, end_fsb)) {
>>>>>> +			error = -EINVAL;
>>>>>> +			goto out_unlock;
>>>>>> +		}
>>>>>> +
>>>>>> +		if ((offset & mp->m_blockmask) ||
>>>>>> +		    (length & mp->m_blockmask)) {
>>>>>> +			error = -EINVAL;
>>>>>> +			goto out_unlock;
>>>>>> +		}
>>> That belongs in the iomap DIO setup code, not here. It's also only
>>> checking the data offset/length is filesystem block aligned, not
>>> atomic IO aligned, too.
>> hmmm... I'm not sure about that. Initially XFS will only support writes
>> whose size is a multiple of FS block size, and this is what we are checking
>> here, even if it is not obvious.
> Which means, initially, iomap only supposed writes that are a
> multiple of filesystem block size. regardless, this should be
> checked in the submission path, not in the extent mapping callback.
> 
> FWIW, we've already established above that iomap needs to handle
> rtextsize chunks rather than fs block size for correct zeroing
> behaviour for atomic writes, so this probably just needs to go away.

Fine, I think that all this can be moved to iomap core / removed.

> 
>> The idea is that we can first ensure size is a multiple of FS blocksize, and
>> then can use br_blockcount directly, below.
> Yes, and we can do all these checks on the iomap that we return to
> the iomap layer. All this is doing is running the checks on the XFS
> imap before it is formatted into the iomap iomap and returned to the
> iomap layer. These checks can be done on the returned iomap in the
> iomap layer if IOMAP_ATOMIC is set....
> 
>> However, the core iomap code does not know FS atomic write min and max per
>> inode, so we need some checks here.
> So maybe we should pass them down to iomap in the iocb when
> IOCB_ATOMIC is set, or reject the IO at the filesytem layer when
> checking atomic IO alignment before we pass the IO to the iomap
> layer...

Yes, I think that something like this is possible.

As for using kiocb, it's quite a small structure, so I can't imagine 
that it would be welcome to add all this atomic write stuff.

So we could add extra awu min and max args to iomao_dio_rw(), and these 
could be filled in by the calling FS. But that function already has 
enough args.

Alternatively we could add an iomap_ops method to look up awu min and 
max for the inode.

Thanks,
John


