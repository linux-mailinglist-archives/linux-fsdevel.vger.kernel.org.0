Return-Path: <linux-fsdevel+bounces-11370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE58532B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 15:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1A21F27751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F035786C;
	Tue, 13 Feb 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nMntoFeh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JxW7B0Aw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0CA56770;
	Tue, 13 Feb 2024 14:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833382; cv=fail; b=DdFLDovWqHs15/hRujMjKk1ujDbHkM3ZZrRyRcXe9beviTUJoSHK1Kt24Mq4tTlXmzSzHcKCTZKrMpLJAJYrQAhfi2D9aF6ExYNqQSvOseXkrRbEM+elBtAJNxev3hOhvypkEY29NUlLCw2YurRyC5tkPZMJiFLVFM6x/cKCgag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833382; c=relaxed/simple;
	bh=//6DhNmNXbYX3/JL/3n9zUx+hZRw5en5TJjk5aPnktE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qfU4OQRXDShmP4Hxmowfcu9VHBWQxWg6vWwXTkFdRErIWcTvyWjJcG3kWuhlTxP9pdic7jfJhXyAY7wEdHxzWIGsmYV5Th29iQk86SCMo3NthHrtx+WgmqXa3cGFpsi0bWHBXqr3LpD1dpnCrgvy8xFxKP5rzTe/iCxEQbVwNXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nMntoFeh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JxW7B0Aw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DDmnDj014119;
	Tue, 13 Feb 2024 14:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=5fRa+O+Iyufr3AUbxXs96Yw2X43lvGjR6RaHORj+MYE=;
 b=nMntoFehMGzxwJ1uHHfrWJ0Wcy0tonDJJ/ETb8bRRcSEFfRN3kEmStc5YTQQp0P0Hv/7
 yrr6XDQ/9VlfCdr5YZdHlW0UE/9IWD0ppNDURdDFo5mjKSEIr6/YoMLEwKrCD8oE0Y1q
 rY6yQD3eALnIMwDHxbW6PF/0aJimKwu/+tC6Hert3T4s8R2HOKQ6Zhi2RGNQv29FneDA
 DcYQhV22zlmvuac+hcuJeBYCXS675X0o/fXOUm2hierGFkEFpA9tZlCOcxdFfzfG9ALc
 ej70UEnc6Krw+jrvMzuX6E+oZrgGqjRAW9d62c63qazjgEGfLj6OCv7H5o6LA3Ltk9Nv vQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w89brg31c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 14:08:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41DE7BPq000755;
	Tue, 13 Feb 2024 14:08:15 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk7cqvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 14:08:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ2VMiwyX37jczxT7FWN1Nny8D1i21yVeC2MP7wIzaHknlsNjiYOuyL6VcMMVhEOfWrlT31N7DBuYbv5g+FXZDgD+gIS7+gYkTGfGvXq3LYiRn/HkVJbg/kwp2JGW2Ov/kpg3IAvusSYaX3qfqEnlAAtW4X5X1n/Jom0PJlEczYAWpqJTxumOyM6y9sKIGTZVwVHfeHbRt36d/vTAHZ138l964H+qP708D04MPUmoZvATQMSY/6W5uv4RIR5268Fw+SXa4eHnjxyfTZRmT5UVtlrSSWmEocs9idfn1ez1ULYbw+Se7tFsgt0KFNTsRYp1PFej/h4EHfFSUI8gmHUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5fRa+O+Iyufr3AUbxXs96Yw2X43lvGjR6RaHORj+MYE=;
 b=kMGwryZe/enVStbFJ8UNgo89HIGaANJeTtYIaC59nRWSdeN3Q/MDvFvQfHuqMS4pkv1yDzCE+ieJpcItwy0YMW1GlPzEe879o1ELDUtS49cCCxvU2lVi2842KuHAGAA0mXZdWQu68yrAv3F+P1mfUw9nD8UP6rCvKEZs+VzxXP7ZXVAZCDso2URxO0C6Ms0Jj6kyYvOh0I3Nq8XPqI8KNV6b+ZeRx0WEd8KmdIUBemqxx4un+eGNCIq1cT4DuwagTp2Ag1x6j0rW12gwBdZTSM4/KEs7UTpLBisChW/VPCB20toTS7/DbVsbaDj9MdG6e75EvK0iLHlxo19BH66ohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fRa+O+Iyufr3AUbxXs96Yw2X43lvGjR6RaHORj+MYE=;
 b=JxW7B0Aw/E0Eirq2KG7TPAlJP2DUF2XfDkw6DYRhfip6QqfsvTpPltk8aRma1JwpuOEc+0S1CC290to48prLIsZcHJ8UVhzVorjBrRYhvw4dndbs/guY+Y6yhWXJot/XKwE0Uxc3F4xoeakZS8FbmAsY1CGBHLrFXkfhMXcJIZ8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4485.namprd10.prod.outlook.com (2603:10b6:510:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 13 Feb
 2024 14:08:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Tue, 13 Feb 2024
 14:08:12 +0000
Message-ID: <385ff2e5-ad79-456a-9632-9581c0d26d9a@oracle.com>
Date: Tue, 13 Feb 2024 14:07:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Content-Language: en-US
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
 <20240124113841.31824-16-john.g.garry@oracle.com>
 <20240213064241.GC23305@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240213064241.GC23305@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4485:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f500d2d-fdc7-47d3-0ee2-08dc2c9d36ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jvszXZrzgBLmdXw+o5++r5kr0szKH4Surn8XrJVk2oooBm9J/Smjj7xFcDesDA5hap+15vAFzF+HmQ5YE0foF+vhVxUHod3uHBWTZ05V0XLhDq7gC3ygXOzCnfZSe6Q69TN6MJgxTES9RdA0StpLPfsNnwZwgDFXOZhc1x0NWtfmUwC/+WIKZd8e8ddozc6etOlD3fdTheVoXLSicURzwyqqeiFLQgPt08/GcJ4hIeoEHf4FcOUynSUQP6ZjMiCZ/1u/6iSs8LX34cpBJlUNTJwrR7cEMvXuZkxjl5NXN3Uq6qFty6mrl3NMxunBUBA8dFSrln52cMagPJQlYQ6rIZ5aw4scCBaLtl1w5VSINnyvhgQBgoksDdUxzYT2Tmqp8CDpgWCNBQ1ZEG6mtahcW5g6ad44lkjuYTgxs8xCFoHVgTlb0nuhArrJvLLwBihvdjAm/jFw9s5XCNzynYkkTed8jFJW2E/L3NgbXj2i8QcktnXZVVT+K14QpcO19GjuzZwIWOg2Nm7GFe17BQGIDiq/k6wnLXri1kYeX21LAJqu2YdKLchHCbbzv63A15ME
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(36756003)(31686004)(316002)(6666004)(86362001)(36916002)(31696002)(8676002)(6916009)(4326008)(8936002)(6506007)(478600001)(5660300002)(6486002)(2906002)(6512007)(7416002)(4744005)(53546011)(38100700002)(107886003)(66946007)(66476007)(66556008)(26005)(2616005)(83380400001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?clRBWmZNbEQrei83Q3JUdWIyWXpDVzdNdzhmd296ZW1CMkFRRnc2UnlBT3VL?=
 =?utf-8?B?QkFEdlAwZjUwUEMxSjI2VDg1R01Pd2xPcjF2MGhaTm9GRXN3RkZRdzVnWlhr?=
 =?utf-8?B?YzhQZzN0YjZHMkRzTWNaL0piVTJQY0JMNVArSWFpcHduYy9BdlYwcURUMWxa?=
 =?utf-8?B?QWxLMkdNU21JNGFtbFlucU0zS2s0YUJuMG9IVXowZ3Btc0c2WXA0bFVIeVhR?=
 =?utf-8?B?amZ3RkdlTWwyZWd1eGxWbmdib0RGazIzeWJIN2ZzQWROZUI1dERLMHpuMDFy?=
 =?utf-8?B?a3FZdWZsVmNKNFJHckZZL0hnc3lDQkY0RTJyckhQL2pTSjhqblNqWWozVnor?=
 =?utf-8?B?UDhtVks1OWFSeXFpSmMxbFpITXJyVHROWVpNcExUa0orZS92T0JTMU4vZWRF?=
 =?utf-8?B?a2hwRDZSZkk2SC81Z3BhL1grbUZZWDJLSmE3dlM4bG50ak9NaTRSOTBubHpa?=
 =?utf-8?B?WUFocFowQVF4U2tGSzJBK3hIM1hOWVZNbE8vQnZhSzVXa2pBaVBZNWpidzhQ?=
 =?utf-8?B?a3pObzdRWUVaQVhyUU9ienorVlg0WE83VXpvbEJRU1ZFNHZkZE1kL1FWQ3Zi?=
 =?utf-8?B?cnd2OCtYcE96N1FyRVhVenUzZjhlWXRKb3QyeStQc0U3d0RDTzdXRWRPRmM3?=
 =?utf-8?B?Z3NDUE5aSXZNTVljVnBDaURNYytOcjVLNURBNFBkb3FCdW83TFFCVTcxOXM4?=
 =?utf-8?B?MTk0enZkbEJBenNwellvOTgxYnhtNnM1cklEL2tFblI0OVI5Tk5wOENzZGdY?=
 =?utf-8?B?TlpxQndEck1LWHF1S1lIc0t1ajlROVJlT3dJVy9LNE5ERXViNFVsSWxRYzd2?=
 =?utf-8?B?WUk3M0w4cHgycVMyVmN0R3BlS1pqZUYvSGJZL0NmMzNENzU4WGNSWVVHTUtK?=
 =?utf-8?B?eDBXZXV4eUxJcW9aTldGSTdGRTdRanpTWjJqV1FKbEhiSkYxMldqbEk0a0R4?=
 =?utf-8?B?emNnQXYybU9ReUQrdzdkdHA3MDNEOFppS1NmWE11VUdrNG5nVm82NzhiRHNN?=
 =?utf-8?B?RmRqcUhSa0pXVGZ5OU1wdEovUVpNSDZzR05tbWFQeWNIRDZJczV2dGRsOU02?=
 =?utf-8?B?T1pWMGRBOS81cVEwYlNkeStQRkhBMnc1NDIyRmRtZ0R3ZURGWmVjaEQvblRy?=
 =?utf-8?B?T25zVG83Y2tGZlphSEkzV1oyQjhxa1IzTGR1WnpEL1Fpckh3VkplVWpRMkhZ?=
 =?utf-8?B?MFpmYXpxU2dlcTB6SmVUdHM0ejFJcWtCM05UOG15WUpXcVRaMndpNkN1RW9z?=
 =?utf-8?B?RlZJNXJjTzNobTZBTURYWmVKbTVtTlhEZGpMRHQ0YWJnM1BidnJ5b3Q1Q2Jp?=
 =?utf-8?B?L2p0VENGUk5UcWhrYUhSdk9ubUlVb1dDWE5ySmNHQzJxQTZIV04rSGV2YzE3?=
 =?utf-8?B?SzFrSGYvYmRackxQR1dvNFFxQ1ZaczhHR0lhME9OdTJUZVBrOWRxVmZzVEp0?=
 =?utf-8?B?N0h0RTRHKzNZVFBPTEs4a1NqaENQYkd6UXA1ZUFLNUVzTlg5Y2NxOUd1ZnlK?=
 =?utf-8?B?Q21vSHRjck1mT2JpTTFLUUhHV3ZwNlJ0N3RWK1ZjZWEzaTF6R2VQNTFhK1hm?=
 =?utf-8?B?M1NTMFJESGRFN0E0b0JWTy9TSmJvSVZrQXJCOFVCaFlmbTY5QitSYnNxYXNr?=
 =?utf-8?B?N1ArR3llY2dTSXljOU5tRG9vZXYxczJLUjlRTURIVDBheVhaZ0pzcFVyRmxa?=
 =?utf-8?B?V1lRcmJOMTlnUlZVVVZidEVhaC96NWhsOHpmMmJwZnV0U1doQ0xXb2dvWjRa?=
 =?utf-8?B?OHUvR1FHWWNZUktqY2pIM3VrbHd3ODN5T3NYSlRnOW9lMW9GelJ5R0FRcXdD?=
 =?utf-8?B?OHVITlNwU24rd05vL3Uxcmo2U0ZkQ2t0ZGtXN0o5U0xLcnRNdHlIWHVFZjlR?=
 =?utf-8?B?dkpGMWdiUjNaL0dEVUQ4QS9MSTVTTUhCWTVROVVSd3B4cTl3Y2FoamNQQ1dl?=
 =?utf-8?B?V2haanM1Z2NCa2RwOWhmdmpndzl0NVJRZHlQQitRMVUyOEZpSy92bTlJeit4?=
 =?utf-8?B?UlRqVmg5TXZDbmhPbW9DckRLREwrNzRsT09KbTN3UDBQemtTY1loOTNhMFZv?=
 =?utf-8?B?K1htRVV2OXBtdkRBd2dvaUgxNTBORjlYTUlwUldwbGhLRC9jRDBtTGZERjcy?=
 =?utf-8?Q?84N+6jFiXn4H8oQTi/3zDdl/j?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eB8fqlNfV/cdHyHieKNqMxKBYDQSL18D2ttudTBVVSVkXkyUZfePzI/8fzcULex7do8C7IrwV28moF2tpaVlNzH7FxNVw48+vmGVBWRfh5AlfCdBHP1FPGb/Yjf7jFIcfAlYDxh88ySWaQHDJw3fs460zqQuD3Y7bqNPgDRp9mp1rPupTAeHl+hbuNqNncusn3zuNgEOKjk7sluANzJLoRkO7hEZG38/FLIo8ydp1ShIJJYuyq0t5eHAWueoFFNjXlW8JqBz0NSp4jbDayCu/6zS1B0SOI9nm28IVdXJQ2uhxx6chWKyBNhMLjSWev0xaVf0awlf+G3ZomhT9d5TDYQN7PEmt3+rLFo3KHglDpc2zjZt+yLvKKxgbn8jla0xXTnT3H36P3fqo1eSRsXcEfchxxfqGAqis1ICxot1B0PQZbR96GWY9sISMPcMbJnJsqZcRAqsG+UYPuqLsrrUvZpRstt3ArDmraqEHlhT0JfsYPu5Ued4AubF/lHt9IXhGCIkj3Ms3P0cIXdA6Rt44SeGrOkSdnTjBDAoh/TLomBmx+LPeUXzPyJvanszafsyhizRKhXhVqSF/dhOgKRGN4oHUXiR3/JjX5McQc+H6Ms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f500d2d-fdc7-47d3-0ee2-08dc2c9d36ff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 14:08:12.7506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVOaqcZeaNHV6kN78oJNWZ18X7IbbRX0voDjEdmKdU8TLcG4ssDcLW7HywFhsO1ZPVko0oA0YtnLIkIIp7SUOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_08,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=732 phishscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402130112
X-Proofpoint-ORIG-GUID: g84YTYG9LBSUF4-dPcUGP_HsXWRONxlE
X-Proofpoint-GUID: g84YTYG9LBSUF4-dPcUGP_HsXWRONxlE

On 13/02/2024 06:42, Christoph Hellwig wrote:
> If we don't end up doing the checks in the block layer:
> 
>> +	/*
>> +	 * Ensure that nothing has been sent which cannot be executed
>> +	 * atomically.
>> +	 */
>> +	if (req->cmd_flags & REQ_ATOMIC) {
>> +		struct nvme_ns_head *head = ns->head;
>> +		u32 boundary_bytes = head->atomic_boundary;
> 
> ... please split the checks into a helper. 

ok

> And merge them into the
> previous patch.

Fine, if you prefer that.

> 


