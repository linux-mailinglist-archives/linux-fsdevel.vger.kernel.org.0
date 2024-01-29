Return-Path: <linux-fsdevel+bounces-9341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBC78401D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 10:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871AA283419
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 09:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D99E55E4B;
	Mon, 29 Jan 2024 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g9rnv5PS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zMsLMJEz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A5255C3D;
	Mon, 29 Jan 2024 09:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521051; cv=fail; b=EMq1RRMQcf0lY9CQsKpMcRpXjzPtRjb4gRN06bvBiuftc/G1FvAtYfvRjPbCTv5tMdqGKU1/qTbTRXG9+q20lsh6kmSAVOGmJ5g9yYxdcfQyXX/WkwlYvZcubEl5AYJoSv0PaCeDAFZ3M8YtN3NFviZ+RA8vEu2MKd+izzBi2pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521051; c=relaxed/simple;
	bh=993hIRrKsS/AR0pcagskYuSe+XtODiPk6xSfnyLLrCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PcdOhM/6JJ02XV2pS469ur0DTUgrxDwvzz4AQsP9Kdk7niYbh0oLnpP0myctEHqQsvBhTkZjFVX45oxIYQkzsPql+AkFz/8loLBVXcBWyGxRONL0CwLpWlZJf2hQI4XgXq4X8wM1FSlJxZ0Awe7u4vZIfU5qPsoHf1F68CLXygk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g9rnv5PS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zMsLMJEz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T6xixU019835;
	Mon, 29 Jan 2024 09:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=28MvRJEWne/uE5xZmi5jYDRUS2cghEXT2AKxPMLv9f4=;
 b=g9rnv5PSv2yCIMypFGG3trwk+bWmobA1rTfhqxPu8vCrTShRF8A2lKgZCMfF0W6xbfmE
 E+AgRXOHnhQ0n+YH0n0T97VQdOnaG7gq4XUI2MRCfZ3Yr8s9QV5FYLFwkpfdEPkPtVzP
 +6g8iGVx0BGpe4E470yirmr9uYFR/LNlQKCzuvE4p41aUXhl2wCjMEJln1dgv9jy2F/W
 nxEN8xmGR+oYs7lUu+k1djPMMN4bVgdvlN8VH3N6WrUULt9CE5UaItqIMr/zQVJLlVC/
 hkg5mSC2OpSfBai61pzJClShvP1HGIUta1JZMkSgfJF+zaW3ImtgJw6PAY3NO1G4sj63 zA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuu8g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 09:36:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40T8v1Te031562;
	Mon, 29 Jan 2024 09:36:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr95mbg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 09:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHPkM4YL+6NInPHk89Oj4Qlrw1HUIU2HDXQ9BnR4GLCobKCiYQRzob/c1z60eg/h17UCL5hX4O0edSSTO5F36pLaFyyInO8D9BEJI9iRG6RzhQcIhaG5c739LJ6MeRAmLG2fzoCh8g6fDHZf+5S7WiFj7SeX9aRvUBJoFP1V4uEl/GLKW6g3RPXntUER54ZNa+u/LBMEGw6jTIQpZScok0J9A9/5AyHUnAkUghTP+kbHodjSPQR7DYuOGJPqdiJJX58/F7E6Ltnnil4INmyun3DJ17ON14rVveT3BgthFcnTWvujB0zx9dGODvUHPXfbU6J3R8ORokQ24CkzpRr7XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28MvRJEWne/uE5xZmi5jYDRUS2cghEXT2AKxPMLv9f4=;
 b=d6p2M4rkWxmA8eTy8JWMk9ECGyCofR0zel51YmNXPIqbceYg8ix8IIDTsr6n2eXnKsZyzWwpcl49p8/5P5YFOs0f1qntEcwcHdxIR3Nq/cwS21fJnjgnA/cRpUsbL1qxgY7sTg5/oe9HeTvMOVMMHBWqqsNO/jG3VPwPV31nYXXGLNqc9mvwN+/iGwDXzv2PBx58A5EAdvaEvD4pgP7Tx5sJGn4IYmseYMvoFoQ843/cImSINQLbJFvndqEsNoSX/B+4vO8fV6RfwRfDwN5QEh8VhSahUkPjH2gRejM04Tq/Uvoh4pgyPB/Oo7DBVwFiZm2be4B2e+FCjgZTj5IYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28MvRJEWne/uE5xZmi5jYDRUS2cghEXT2AKxPMLv9f4=;
 b=zMsLMJEzUnkTUH+847ZjYo+wSA84NxBtqHTcj8gI0VwYEXihx/wAmkrzpujEtZXSNbX8IF6yh4QMwfihFaWxPqlb062mK0dZTz724UJ6P8llvONvtzoFsXDqAZY5g718HzrbD2AlFva2Gu5CtFVUDMvKaiJODLIYnkf87hz+tCQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6822.namprd10.prod.outlook.com (2603:10b6:8:11d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 09:36:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 09:36:42 +0000
Message-ID: <ca58facd-db6b-42b2-ace3-595817c81ca9@oracle.com>
Date: Mon, 29 Jan 2024 09:36:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/15] nvme: Ensure atomic writes will be executed
 atomically
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, martin.petersen@oracle.com
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, sagi@grimberg.me,
        jejb@linux.ibm.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Alan Adamson <alan.adamson@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-16-john.g.garry@oracle.com>
 <ZbGwv4uFdJyfKtk5@kbusch-mbp.dhcp.thefacebook.com>
 <dbb3ad13-7524-4861-8006-b2ea426fbacd@oracle.com>
 <20240129062035.GB19796@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240129062035.GB19796@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU6P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:540::27) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6822:EE_
X-MS-Office365-Filtering-Correlation-Id: 553dec13-ea2d-427f-d533-08dc20adcd17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ne2pQmpHBbVDFVVhMftDCo+a4zzYHoyx7Poi0z2WpQ2Qh7INQUuZrPVZsqvafK4hNdLnejVDTDl3eJHZNzxNI1Xy83eFyPwGpobhkNGuNYzOmZWgpy4lydU3Qi0U5SHw8dzvelrNdOIiqZEujYaNauRMUKDds7RRGS1B/SfxEe05pcC8A1ysMG3EANniASazzBpp10jla/c67gsLF+8AnUh0VsWi+fEVpMssYLZaGcqsDc9lkNZIcEm6Bm7CFD2gdm2BGHlNESgw1HXOkPfugThxRe4vCEUH7DZD1kdKrbho11Q1XKMBRBHzPMfGJBsCIZEIiBmfVnnBe/wrhdh69xem+az3UQIGA7h0WRn4bkjCm2MIHE+/eUT9WWM2lfdJhEh6gOsLX9+3lzz8sLVn/tN0D0Uzjkjkxz+j5Til9d8sob+qBHpRg+V/tHQYSvXt9ACMYVmvtBNxAJ1JsoUqLcKBF28cHfZK1J4fXa9lT1dx6C7sajAKi8csHZvcdf6wZOU926Iz5XFX8vc7XmCyF5il56zkSI3NBtOQAQ8N/5FV97gTx2YgFcXdQLW8eFneKZlx34mJxtz9/hcRmmkq80rYx3+KtR/F6R9mP/vQSKF4ly2/jz27/6FQ4P8T2qgxQ2n8PzyUNlSPI4JaRcwA3Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(38100700002)(83380400001)(107886003)(26005)(2616005)(6512007)(478600001)(6506007)(53546011)(36916002)(6666004)(6486002)(966005)(316002)(31696002)(54906003)(6636002)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(7416002)(2906002)(5660300002)(36756003)(31686004)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUY5ZFl0eDgxMUFucjBvekxPbm9XaXhreGxyMlNwV3QwVlMrYlBqaTI1UWph?=
 =?utf-8?B?NFdYWEllTy9qOGZjVmlsWVhHMFhBbStWQml4R1NrQ2dCQm4zcUFiSytPOEtJ?=
 =?utf-8?B?ZlI0OU5BVE0zZnRNOFZaZGMyTjFTdHJkeng3SVE3c2I2dmVzUmltUHQ5cnB3?=
 =?utf-8?B?M3E3b2dIUTk1YWRXV0lnRDk4TDhCdG1xN252cmJ1QStnbDk3RG5tUEhoV010?=
 =?utf-8?B?emN2RXg3ZTg5K1k5QVh1Zyt6YVpnTmhCTzhXWjZnMDNuTUpkUVllS0xIdStQ?=
 =?utf-8?B?eHI1K3JCWG53Nm9MeSswRzNJcEU3MXZsU0NjOVVNMWZCYmhTUGk4RER5aERR?=
 =?utf-8?B?QTNaUzY5bXpEUm1FQkh0UzhjU3dFRDcwY21IcTFlNkJHbSsxZjY3aGt0bkFG?=
 =?utf-8?B?Kys3eDgwcWF3cEtOd3V1dVlCeGErN2h4Znh6TENSdDh4cGlLVlRjVlFDMGg0?=
 =?utf-8?B?bWxHcTExRFBlNWVubWxkMHVtS0YzNDNMaVFsVTRCYkkwRlN6QkJHSC9GaWdJ?=
 =?utf-8?B?dElRNzlhOUg1SHNjUldDaTZvUUZVWkdFQzBreHg4QU9BMjJUL3dyZ0NweFRH?=
 =?utf-8?B?dmx5YlZEcitxSnlReTZnR1VFZWY3TEtiVjBjRUVoeHcrNWp2cnNZdUp6Ly9O?=
 =?utf-8?B?MDZDTEhnd1Z6OGMvaGxyRzlLRUlLSHpnYVM4WWdRNElSdkhMVzdXTG9MWVI4?=
 =?utf-8?B?T2JXVXFGVkc2Sk84RlM3VS9wL01BS3pqZE1HRkJJRjNjT2JHUFVBT3krcFJy?=
 =?utf-8?B?UHl2MWp6RUhNZCtTc2xXMm94RmpacmNzWWs0Rk5hNDh0MEx2ekpZZk54NWRL?=
 =?utf-8?B?Z2RZTGQ3UXNxbHhrSnpmQkZTdUc1b1krdExZWjVIMTYxT0MrVjRGRzJBdnVi?=
 =?utf-8?B?S2x1NnNwWlFNbmVNMVRobXlkUDZhbWo0aVdaZm5abit6V0o4aEl1UUgxa1VD?=
 =?utf-8?B?b2F4Skt2dFFWd00xNldyTy80Wjc0TFVCMXMyaDZWbjlaWGhkYVdHc2U1M2Uz?=
 =?utf-8?B?M1Y2TjQxUUY2VGhKQjlRaWd1bmwrOHdWMDB1Q0wvVjhoTzlQcDQ1RmZweTFF?=
 =?utf-8?B?MjFGR0k0bzZ6bWlvQXpIc0JOMWRGREtBbCtBS3NrR3VOWDd6WVVlSFB3UGpD?=
 =?utf-8?B?TEVXaDZQZ2c3LzhZWjVaK0hkeXFNaW5GRW1VM0IwektkU0ZRNzVBOUxyL0Rz?=
 =?utf-8?B?SXk0azBFcndTQUprbkx2bldpUWh0TFpZWEtmUGkwRHo5MXIwVXZjOEhGVHBo?=
 =?utf-8?B?YktkK3JEeVlVeXRJQnlHZ3NGSWpJOUdJRnBWdmNjU3dZd1dGTGQySWYxeU45?=
 =?utf-8?B?Q05ZVjRDeXdZemFSUkRXdDZ3Rm1XL3hmalZ5S2R6ODJaYjBHK3ROOG1tbnpK?=
 =?utf-8?B?REh2Qzc2NHZRb2lnT01TN253Y3pzelNOV29zcDhMY3NJV1orVU9KZkJmVU5q?=
 =?utf-8?B?Z2VsUXk1V0tIb1MxUnNEa3FEUW4ydUVYdk9veGFZbHJuaWs0TVZwZkUyaldw?=
 =?utf-8?B?UGVpVjJIUmNaV0Y1anRNSEVoeG5XQTRxejBRcmZEL1N0M1E1OW85VU5HUHBY?=
 =?utf-8?B?RVdER3ZqZ3V3TlBDUytCRkRPcGEwdHlFb1VOdWR1WWR5cEcrTG5wYjNScm1i?=
 =?utf-8?B?V2FrWWZvTUhrQ0FlaHA3TVBjZnJqeUg4QTFHYURYV3hxanVXL2REN1pCMTF6?=
 =?utf-8?B?ak4zSGZNOC9rZnhKOHk4bVJjRVBGQXFQTnFwWWFPWnRtOWRreW05NTNTMWpa?=
 =?utf-8?B?QjUra2ZHRlNGcTRGR0syZmM4aTUxVVdkY3ljM08xUEFmMVFvbVYxUnhhK2NH?=
 =?utf-8?B?eFpYNHJ3NEdkQkFQbGl3WnBDMWZTdEM2Rk9rUFlqcUZNSStLNFpmM3ZxQzZB?=
 =?utf-8?B?Uk51MkFRYzYxREh2UURVeVptRlZsRklQbkQyTHI4RHhaZmpZbno3TW8rWDJW?=
 =?utf-8?B?NUxZdExuU0krZWVQL3ZmYTZBaUJpV0xwK3hkMmxESGdRenRHZCtzRHl3dlo3?=
 =?utf-8?B?azZjTVh6K1hjQktTS2tBUGxzS3RNSkN5b2l2N1BTMHlQcUJxK0dPMUw3Q2xy?=
 =?utf-8?B?UnJxR1JKQWhGZTYyVS9KdEZkc0ZBckxOSjlnNy9rVmV4Zk1sMyt4dGVWL3lO?=
 =?utf-8?B?U1Z1a0ZHSHFOUkcraTNac2cxR2tQTVpDQllDSDVWQnpmQldxWGVOVFkwV1E3?=
 =?utf-8?B?WlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pTJoR00RVmRhXVn3Sa5B9kEqXGVzrYLoKu4QwKhr0IGTmSEzXreyFofMVTIX4T97ABEaWS9ANU3t7Mm65O0Mvh0CpO5a7xMIlV8vtIFd0LSgMi98ym0a5Ub2e7rl8ZqEvuWBqgaOpy7Sva0uEz+471SeXzyzLKzXM8F8YztFgAQnhXm9Hp4wMX1nxZHOZBa+jYTmM/mcBA6KjZcMtUt9TBTNmbrf75AW7kX0EK/q0J2GXL/ME4pBdSMkkQjP2ytJPl+Tfl+BPyb0BtBs48GaPCBC8+I7OS6jel3SawnN4/vOv9Ch+y/8kToIOdehyHimrY/BnAJdJRboaXEL0ldsQngjhhh7JpKR8j3/7zVVvifisncJRtKHP4IjEcrtByqDuA6TL4ksJkhE5qCAnCbrfc9cmB6dl2bh0T3p37uYmg9CaYXx1obsFjeR5z51HzFgna1h/dFX3tiOkyOAhlAyQuwWQQJ8IRm95gSCW5t3dZT364y5IsK3XoXFJ2lNyCYmVVnPZ4aGQhM7H4lFk+tB++HH97JXwBrJRUo1j0V4hSBJdn1F1KEkj5b/xozJnVIjcCgOimZZ7C4vrqhNoECVoWn3aYNsW/K6hLzMVvkyaKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553dec13-ea2d-427f-d533-08dc20adcd17
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 09:36:42.4250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L9ZpKp7RAThhXtQBAvfdTQfKw08Nga2wjlh1JWp8LZzOv+wBj18S2NWWihxCjnbQnJifJNp1dTbRzek2UHdlyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_05,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290068
X-Proofpoint-ORIG-GUID: g6MveXtASMGshKV6IROfZwNw4LsV-d29
X-Proofpoint-GUID: g6MveXtASMGshKV6IROfZwNw4LsV-d29

On 29/01/2024 06:20, Christoph Hellwig wrote:
> On Thu, Jan 25, 2024 at 11:28:22AM +0000, John Garry wrote:
>> We have limits checks in XFS iomap and fops.c, but we would also want to
>> ensure that the the block layer is not doing anything it shouldn't be doing
>> after submit_bio_noacct(), like merging atomic write BIOs which straddle a
>> boundary or exceed atomic_max (if there were any merging).
>>
>> The SCSI standard already has provision for error'ing an atomic write
>> command which exceeds the target atomic write capabilities, while NVMe
>> doesn't.
> 
> Can you get Oracle to propose this for NVMe?  It always helps if these
> suggestions come from a large buyer of NVMe equipment.

I'll let Martin comment on that.

> 
>> BTW, Christoph did mention that he would like to see this:
>> https://lore.kernel.org/linux-nvme/20231109153603.GA2188@lst.de/
> 
> I can probably live with a sufficiently low-level block layer check.

That would probably be in blk_mq_dispatch_rq_list() for block drivers 
with .queue_rq set, but I would need to check for a good place for 
->queue_rqs . I can't imagine that we just want to inefficiently iter 
all rqs at the ->queue_rqs call point.

However considering the nature of this change, it is not a good sign 
that we/I need to check... I'd be more inclined to leave as is.

Thanks,
John


