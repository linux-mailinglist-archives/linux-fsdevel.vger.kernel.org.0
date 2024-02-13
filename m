Return-Path: <linux-fsdevel+bounces-11372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B408532F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CADAB22811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34385788F;
	Tue, 13 Feb 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ImLOzmZx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WENwioKL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5594B5733B;
	Tue, 13 Feb 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834125; cv=fail; b=uQFV2+37iwE4SBi8KIFyh56KMlWFo1P9eM5ecGbKwEuIbRuW/CojMTL2+QmcGF3DmVJLuLPFm18nrcK5TcT59Ypx87emHpCjidiWFHPnCuE9NMcqOxBoAOlILYfvH5Aw7Qugf4/VRrfp8LG4cutyQ3BsvK47Nc1AdCHadZe65Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834125; c=relaxed/simple;
	bh=Cq0sqURX0xr3VKtg7etyWcj7mDiPQKfp9Wco5ro3+1g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tus5QE3yQdlUYTCA8nbrrJWi6PjyRDkjxB4+diFL5Buz09DSxFq0BT6XBB3aXmHNrRC5xy1Fq8G721IVjjKX/PRCaUIFwcZ2RtSdXsrKi/C18qInj6Rt8fWdTM+WPIeY4jj/wTQslRrOlg6KqfuEicAY5G8yrjFU1Ta/SppIvHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ImLOzmZx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WENwioKL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DEEGuk012628;
	Tue, 13 Feb 2024 14:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=43+5tIw4m/fXgWvJdsnyZuziNzYQH8bTmjAFk/rRS3g=;
 b=ImLOzmZxZTmT3HwUxGS6+dWfjpUuNBe3UE2FIMA5mC05lNVbpW8GSVeFatSrKpYZ3fBS
 Aa3/ZODHrclcl+0dTWcSS5aJ7oRzrSL6BZfGAirhSftEnWpHaeZbFyiIi9mm7FRIQdD1
 LkmKl4t0Z9QGdR+PbRkdUMoyeGSknIjTcX2AOKW/gyRu2al5ukdl1mHQA2/fIFUlcPK1
 rVU7Dm9qsC3u0eqyqHWklIBj2yF0iGjoD9CvpftKVwBDloSSFgJgvPi54jmSLsbaQLQA
 8VkZdjNq5rkV7QsgueZwEcDhcYm0Lotgum+CUJiWY8PYjcP8IW0JBvVBcMMGd4aFhNTF Yg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8a0q80k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 14:21:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DEFPLA031673;
	Tue, 13 Feb 2024 14:21:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7cpu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 14:21:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAClWFvvWQOGEMoOrCyG98KYLHWxIpfMc4KrZ3WNFseA55gsfKjSU+gvaUjHvLcyWgmaNO0KOzK9uOFXtdUxc6+zoxKQkItK1xOLlOEVdODj6KfCDQFQDFsFNaNRVviL6FGzhZ21eaCtpJJRFGndHptPBcR/3v08HDo/YmabiwXQkMRhaPRYD3JlsdfPGGNmT9tKtYz7QUcjGMayYxPKsMoSmIfzde3DbTagm3D67I/xcoHyn5mZH5h+spnJxBOFYR1pWA1Bc2+pP/UvjaTRk5HSK7VQ+F/Xd8u/Tnky//kybMdVqYOCa37LFWvuB7GGJZJqTN0gWew1rCdyvWM5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=43+5tIw4m/fXgWvJdsnyZuziNzYQH8bTmjAFk/rRS3g=;
 b=DnTg+ms4AbdYwBFFRSrw6HYJwd783DutTKIYfxQrK1yWIp7tCZWTIEcfkvTMXm0GT/rv8Id2yV+I+h+CTpiXgEzuvMuezscLGYI5f8z/bEhJNs9isj2IkiajOQAReaUTUff8PQrum/NTuU9NGKRzdOZOSZapyS1WJejHP2pjc+nAUyEwXhW8uRUmtwhRJavOBh4xb8MahW87JE9GDVGgIbRZJH3lqov5XCOeernGvyyxmnA2IISLyQVcSgu6MyCCKkyGH+MACK1IJULSO+cXz4ZAF7viDIo/E3gP3Nq4/h4OlTG4tY7XlFkXCuKiHyPY3Gc7uyxBGgUtWg/FEuP/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=43+5tIw4m/fXgWvJdsnyZuziNzYQH8bTmjAFk/rRS3g=;
 b=WENwioKLRtQxCUs4VXgJ4MjfTSBPMRXJf++bK9JWRKfLPm/D4EOCHzl8XwFLfBycQ3O1C7C0dmpvoBZyGcrTm2d2HSF0Q7F3/p6oVfBfcBZnm/pV+iSJZ1GbAvdc8pNirAWsvLGhAvL2xXQJRTEDG/D6tvpY/5UwCdf4i69JAo4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5056.namprd10.prod.outlook.com (2603:10b6:5:3aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 14:21:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Tue, 13 Feb 2024
 14:21:31 +0000
Message-ID: <0323ba69-dff9-4465-817e-2c349141b753@oracle.com>
Date: Tue, 13 Feb 2024 14:21:25 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] nvme: Support atomic writes
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Alan Adamson <alan.adamson@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-15-john.g.garry@oracle.com>
 <20240213064204.GB23305@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213064204.GB23305@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: c0473b7b-4d5e-4c43-90d2-08dc2c9f12e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G7O6Sw0v+cMcY0KiS12l/BSmsrCJugXti3Xtm1V96pfG7+vHkwxsapwh5OTDiMo8dgavdq8IJKOtkRnuxMWwj+cR0DX8WtNZ6RIdewoq8HPuQgJCMWkp1K/Q9pvTig4792+VY1fKAd5LyFS2aDs+T3tr9l9L58LzFZO9sKkv0rvLtkBe17lwK999Pk4eJwa7QUdTMydk0e60ROJfSrIR4McWdq24T87IyyirNpOpcLW/vG2bwodnfkUTGA3lg1yHKngC9vHjaDuDqIhibV9uDKv8312fHK4BiJKRV/Til+bjjoSZM1CLt/FNI+8GkHzGzOOF6o1zsdwuOqRM+9FYks4CpcLB0qWWT2iRG6GJL/MgZR1oN4TYu/LCPiIHXK+e7zv/D0zIqpuuO2Sb2dUIj1azO+Dqo0NtAEErcV2t4rOPYOOGnlpMBXm5tZNciKuhZh4/h6eHUHfsTLW9E90vEXTVcJAqcLoBGwXZuGoL7ygVbCEgq+m5EhIouNnsT/Dlt9i1A3wzEuO+ZmAoGFbzzEU4sfGOlkptbwahltm7x5+CsA6ov0qYsjguQY9vINht
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(2906002)(36756003)(66476007)(66946007)(66556008)(6916009)(8676002)(8936002)(4326008)(38100700002)(7416002)(5660300002)(2616005)(107886003)(86362001)(31696002)(41300700001)(83380400001)(26005)(6666004)(6512007)(316002)(36916002)(478600001)(6486002)(53546011)(6506007)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGZNV2VoWEVManNPL2g5RVV0T1ZPRnZQbFpPRnlQNmxiNDdPNjBtbUpiLzVY?=
 =?utf-8?B?UGVEbXJlVHE0akcxN0ZjRGliSGkxYUlQZTRhWEFHZE84OGQrOVJqSTkwelJE?=
 =?utf-8?B?SlcxYll0K0l0bURBWU5saW1abjhLU042Uk9JZ01Kb2llUk1ZQUpFazlSSTIy?=
 =?utf-8?B?YnBuSzlnMGl6UmhrNjkvWHgwT1RoZVNvVDZDVlloVE9uOFdJTHM1YUpQTmh3?=
 =?utf-8?B?M3hlRlRZWlNuTlZYd1UxSE8vclF3SEplQ1R4QkZiOG5RVXZwOWpBa0pQbXNR?=
 =?utf-8?B?SS9WVkxwQzNKM2RJMGZXTml6aS9Ob1dCTTB1S0RhdkRUOUVtZ0VLcm1xM2Fv?=
 =?utf-8?B?S2UwamxSNFJqY2prOVEyZWkxYVlEUFFDTkgwVStEeVVxS1U5QmQ5YUVVVjNN?=
 =?utf-8?B?WFZEdHVzamY1Mjdic0tSTFhwNTBWbHpYVEJXOVcrb005Rnl2dmxmZStTTXdo?=
 =?utf-8?B?c2NQVzY4RWM2cno2VUNNbG9JN0MxRVZ3NFM5MnJmZ0lrSGJCSVFSaWo3Tkta?=
 =?utf-8?B?VktSZ1B6WGViTGZiU3BqYy8zOE43bUc0TmN0Qmpsd0Z5b0FyODRlb2JrYW4z?=
 =?utf-8?B?MnJnWloweURjeE1rY3JqeHRKR2JBZWVWNWVUbXJpeXo2eVd6cFhtMkJZMDRN?=
 =?utf-8?B?Q3R1eWpyUkJOZXZTRzcrUnQ5Uy9rVGl1clBVZTBhYW5Kdzg4NktTU1R6YkhJ?=
 =?utf-8?B?aHJBZ0hNUFI1SGs2ZkI3OVN1ellYWGF4TlY4OENXRSs3RWErR3daS21lQkUw?=
 =?utf-8?B?VXJqSGZObEJKRWVJa05lNkFTN2ltSmhOT0RZTm0vZnRPTWl5VHlpTFJqeGxl?=
 =?utf-8?B?T2NSU2IzSWV6Y3ZVQjAvZUJudWE3YlU0eFNKNnFwc3BXeW4vYmxIUEU0Ykty?=
 =?utf-8?B?ajZNdExKbGdNWTNqV3hwZzlneWJIZ3NtYVFSbG5PcnJHRmxoZnZsVG0wOGRs?=
 =?utf-8?B?L0V3dldzbjNPK253WE9FYlRNTlY0Nm10ME1wWm9NbGJ3akxjRkNTeFJrMU1t?=
 =?utf-8?B?eXdLS04vbnJZKzYyRC9CU0I5NWVPOWEvNEM3dENvRGFpRXlZdzE0c3RGSlpk?=
 =?utf-8?B?QjlncmxXSW1JYllzVzUyS3JqZXJSNHIvUWt1ekJCbFRNZ1NJYkdMNHRJWnVo?=
 =?utf-8?B?UlgxVzNiT0ZkTmdYbnVjR2RBQ0Y0YUF4eXROb3JZMHVQTDhjVnd4emc2YW8w?=
 =?utf-8?B?OVdGQnJrR0ZIbHh2RVVKZGxrQlpFeHZMVXFiQTZlc1BhVUVydjNjM0l5VmdP?=
 =?utf-8?B?c1REVndIaTB0L09SbXlNYTc3RDU3UHorMDhhNTlCbTBWaTJtdnBsK3BYRUN1?=
 =?utf-8?B?YTN0RlZrVU1wWU8vUlhpM3NBdDdyMVViUmR3TTZMNTBxY1ZUcVNIdHRpakNs?=
 =?utf-8?B?UkVadE5VcnBESS9tVWh5NUk4cHVwTzVtd3liU2NRZkFrZHJIbjFsZFRPRTBv?=
 =?utf-8?B?NnNVYzFZcDF3REdERERpM0h1TkZpOENHdXZuOFpNT3RWcVBlTlNEdUdxVVVJ?=
 =?utf-8?B?Y1Z3SnhnWmhBMUFFYjMrVnBobTc5Sm5DODZNVkY2MGh1K2F3aVdidHh6YmZE?=
 =?utf-8?B?L3ZPb2RGWWFZRC9tRk9hQXRnM1dORGRCMVFZZHk4cDg1QzVYY09ZTTJraFNU?=
 =?utf-8?B?WEUwZUFRYm9VU2MyeXFIQW55dDZmWCtid0VkR1IwVDZPWHVuWnZQeC8wTE1D?=
 =?utf-8?B?Q0tLQk9hR2dpaXpZWkxDVUhxdThkWXlBWDFYYWc3dDNtcmpjbVM1M0JyM0gy?=
 =?utf-8?B?RWl0TWVjSUVZWWpuOEhDMjM5NEVsSUlwQXNzTzhkMmVaMGdTb3JvT1cvSlJF?=
 =?utf-8?B?Y2taWjVLKzRZZ1RPUzNsaFJTbTYwODN2Ync4RVc3cUZGVlQ4dVVjNnFSOUpi?=
 =?utf-8?B?a2Zxc21ReC9Bb01KWkZTLzFKM1J4dURuMmY1QWNlV29TbDZNdFh1T05CTkhs?=
 =?utf-8?B?ZlMzQWZ6WURwc1IzaHJkeHJrUjVqMEkxZndRY2NyWkNubU4vc2k1K0hHNHpz?=
 =?utf-8?B?QTF3VWlwaUtQSzFadzZYMTFZZkEwdC8yM013OS9jMUN1RWZWMklhWEJhL0p4?=
 =?utf-8?B?U1JCbFRDTHk5eTNPb3ByejN4T1ZObkhSTHdrRndBekJINTIrSGhLRGdOaXoz?=
 =?utf-8?Q?rWidiiMZyrFtlFGYhdeWqa0f6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Kkyvf260snuPNi3dP1hbhLbFfi7L+3LIU+bxEE59wtxgjU6qnhakT8i5suCQFB25s8aPLYA4oqxn1bRZuHCSI90vo2gqlucFSPOTUBQwJwThLFg6cPFIUQwqYsqUfh9nbSYcJYrTkR9Lvwt3I5GrinJd2Nu6YHWnK8u1z1zzDO1v1IQuO/Yf3JBL92bP80USs/cKmsLp3Mk1zsxzbtNnxuXDJ8AlENt7k+Y3MLqLeEtEMTuqP+h6pMBPB6gLBT8XXog47D3Ck8XAJd5EVgKtwNvyyC+K5kMV+PJCKHotqpUm/i7UR9RMmH1fcwWnRBrllytJYlW9x0E0JKa+ehMnbcvFWGUOkkIwin0TfptZlOawytf9GiXOXnL/S0i4DviCv5Cw302gSiuiVcJsyzn3gqB8QHAvE42me+RXSavQ8nGFJD/CYn0jha00pYU/GyRHH3+iP+g92vERxK0cZHlPcRp1bodjdqdJVCCiod7foEd7BkuwEVawv1uuOErLwc2wPB517NRsVrvJsLGgkn9OM+orrT8U0FM+k2AJeNsYfpvGqbLY2jNtlqIn7PVa3LSXbVbnQvtv/izDyDaCI6xVktR8PQkPxdgV7684kB2Prrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0473b7b-4d5e-4c43-90d2-08dc2c9f12e5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 14:21:31.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMyc3I3GOafgEakmR8H9ScgFMi1Ekmo2S49xVaTc3fDqOPg7VZIUz11GJi5onAbKs/evYZcx3njQeJnYpro5Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5056
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130114
X-Proofpoint-GUID: e-VTIqI1Zdj90cNt9v3GMVqMvhlGCmxv
X-Proofpoint-ORIG-GUID: e-VTIqI1Zdj90cNt9v3GMVqMvhlGCmxv

On 13/02/2024 06:42, Christoph Hellwig wrote:
> On Wed, Jan 24, 2024 at 11:38:40AM +0000, John Garry wrote:
>> From: Alan Adamson <alan.adamson@oracle.com>
>>
>> Support reading atomic write registers to fill in request_queue
>> properties.
>>
>> Use following method to calculate limits:
>> atomic_write_max_bytes = flp2(NAWUPF ?: AWUPF)
>> atomic_write_unit_min = logical_block_size
>> atomic_write_unit_max = flp2(NAWUPF ?: AWUPF)
>> atomic_write_boundary = NABSPF
> 
> Can you expand this to actually be a real commit log with full
> sentences, expanding the NVME field name acronyms and reference
> the relevant Sections and Figures in a specific version of the
> NVMe specification?

ok

> 
> Also some implementation comments:
> 
> NVMe has a particularly nasty NABO field in Identify Namespace, which
> offsets the boundary. We probably need to reject atomic writes or
> severly limit them if this field is set.

ok, and initially we'll just not support atomic writes for NABO != 0

> 
> Please also read through TP4098(a) and look at the MAM field.

It's not public, AFAIK.

And I don't think a feature which allows us to straddle boundaries is 
too interesting really.

>  As far
> as I can tell the patch as-is assumes it always is set to 1.
> 
>> +static void nvme_update_atomic_write_disk_info(struct gendisk *disk,
>> +		struct nvme_ctrl *ctrl, struct nvme_id_ns *id, u32 bs, u32 atomic_bs)
> 
> Please avoid the overly long line here.
> 
>> +		nvme_update_atomic_write_disk_info(disk, ctrl, id, bs, atomic_bs);
> 
> .. and here.

ok, but I think that this will get shorter anyway.

> 

Thanks,
John

