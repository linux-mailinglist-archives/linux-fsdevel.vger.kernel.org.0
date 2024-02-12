Return-Path: <linux-fsdevel+bounces-11108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE94851211
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D601C21835
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CA939877;
	Mon, 12 Feb 2024 11:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ewpBMyjL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zcYiCl7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA438DDB;
	Mon, 12 Feb 2024 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736897; cv=fail; b=km5aX27eAn8TpufRFtBIi7szL5jwPDeaaFX+m6aiAFV/VcKcedImRvw70I2hKW1OeQdqQUZXLQbGdWVzkbSGgMHQ92kMQpTb0orT4MXzZTIYZDk96g5V8SMbsD9tUmCbmxq4pAfmznra++oaDfA0sZAsrrNqNGsgJ5w4TEa6G4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736897; c=relaxed/simple;
	bh=wFqlk9iT9SrRhypRExpDDi1z96FC0d4cpWu39HVFWwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nKtdGKmOVH3WOJlYLNKzbsyOx6Kdm+7eG4NLOx0Vg4zGgAQ8k+IBbAkuVPdYNdVSG1xylfJV5qtQXI6HXq5/ZFnp569hfdPn3k7e5PMeXIO8jOEjz1NoGrzW7oc7Oze+rR30fmcqyDsAhLkUBp12sbJU/R6xj7oevAp5XJBkmxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ewpBMyjL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zcYiCl7t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CAqvCe012041;
	Mon, 12 Feb 2024 11:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SRNO2OJ//TGEa7nSKSiYL59Nx3AzPcG8JX3Ki7Y1Qmc=;
 b=ewpBMyjLVdl6B+nnPXKHJ9c1+DJqGmaK7vDSmz6Vr7b1RXiOe6suRkUynVqxj7YfaMwu
 YFSTS0fJFi5eb7YSHN5YLW15N8vPVprqav0dGeHrUxRuRqfNzTUEBaMqA3er280OV+Ef
 jxFYi2atpZX8pRQvnX58UT4okfH0ZVUt1tdYiXHqN7mxC3DzsNqZ2XHfPiWFVPKG2S5I
 Npmcfbae+YRpiLweXsWpZN+BfAmD/Xgqh0VYnboQCLKQokWVM5y5LN0CxXvysoNt0pAJ
 A9oqRsuJ7aZNyPKlYFJFuXGUyRnL4b4Gqr/BmxyrBtCXa4FRgjcm8/fklmTw9n4ZuPXg OQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w7hy8g1ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 11:20:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41C9d3jk013875;
	Mon, 12 Feb 2024 11:20:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w6ap88ak2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 11:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3kdIhicV+PpWv4QHbvNRLEtwmXOSNJRnAjr8V//tlP6v0EUvzyjlZ4vTdFI14EavQAKf9tqSj6TZ/1BVmQtIt/T5W/E/12QJoqUxvAMfXPb+C6Q7Eml32mcHEkjYEbgd3p7jovwHbG5eOQG5qviyybpB6aBds1PgghSWcpNT3hdXwL3fHhQ6gjS2+g9Dc6SHykCUB/+M/S1rsKHsfksg83CaIG5znkNifPJ3QysSPlU1PbUtP28QFC7b+Q6GJM3Wro1EP208P//9lh42NiGNtGqTOLUMDjK4hGgAfmmcowlEJWI2+DL988gJRv/ZouakJq9CjET2+k9fqUgYb8jVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRNO2OJ//TGEa7nSKSiYL59Nx3AzPcG8JX3Ki7Y1Qmc=;
 b=Y4fTe7I8Dlr6/PEe71bucrkgYdlHc1shvyKIitxR5wn44sDOxQ6WFA8c/2g+aBbH81Y5loLCD7R0Uv0O/ShApowncHFUA5eP0gLG6JtOmQaK/M+pXq5ofIlWeAei52IXrpiG7+5E63DfqaceQvKpx78+i8y2vYjKhdS7czmSAmDclC8RWy9+QiuLEmOMOKIqhKMFhqd/KzvSYwNQ1IZWyg3pJmHcfzAc45QZUmh115bNV7KjzGGGonuS0i+VrXYDwIViZXPu3wVQO+qIRMz48RmEvewFTJTPZAGogyUZWyC50/4kVUh09Y2lEBR45Sb9vknuwJMAGQ2h0Z55e/dt/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRNO2OJ//TGEa7nSKSiYL59Nx3AzPcG8JX3Ki7Y1Qmc=;
 b=zcYiCl7tS0Jsg2xjEk4csDhvk/qOBVUpbAqDgSNNtLq+3JYZmFM49vweispWUCxAJxw3fA+92ZM6/ncjpZ0Ckq9FWT2fOAD3ktKZ6RP8vIbbQvgI+a0n6G1v2f5Q187sajN0bcQbEV7YyjnCL45wevVxt+R6tsJo/hBh2St9u64=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB7507.namprd10.prod.outlook.com (2603:10b6:8:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Mon, 12 Feb
 2024 11:20:54 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 11:20:54 +0000
Message-ID: <484a449b-5c7e-4766-97d3-36b01c78687c@oracle.com>
Date: Mon, 12 Feb 2024 11:20:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/15] block: Add checks to merging of atomic writes
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-10-john.g.garry@oracle.com>
 <20240212105444.43262-1-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240212105444.43262-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0P190CA0003.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f748fbf-3078-4161-a909-08dc2bbcad30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jaN9zA0yCAJMVzDqM8uT+4KyVLc4IPlTnWg43ukNHS1AfFNtBOKHA5x8xPq2gEfCkwX9BVb8sHkNICGdY/eeJofafZ6Z5tagnMeDA1GLNxO4km25s2yf+S+s7TCPNCYuFnQbw91zYrRy/mA5z/XrelrNywKzC2c92YPw8ViKXy3vvxM9f0/iXg//PqPzuBUwwA1REZAN/PL2pT/z2HAuFqtN7pIGviUCIq3lTQEX7Bje+Yv8Y7GzT3QqC1woqDZt4707z7GVa/k8M15G6RlSm1G67K1oihuD0C2/l4v2HeSZSHYAVSOahWmCtruVXCOUp9rZBKW+v7/e/Ym1CzcF0xpCaiWTxKAoTmpRyLKT23m/1ONQjbo5mgEX8W8JAX9w9TX6s+Wl4Fhuhs7rIZao8qCC5zlxmjHmymF0jFAOPG1izh4IBtkM3ok7a05ELDfls9WXDOr+NE9X2JDDG9JxPC28RAZgaJkiSjcG4l+Ta9t3wX29c/cFLIvLpzzuHBJaWFUvKqTBlHTjXb7kgtUURl30hUV3zpltoA0gve7EEVb+PUv3KRZgxLineJhFp5oQ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(376002)(396003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(36916002)(2616005)(41300700001)(6486002)(6506007)(6512007)(478600001)(2906002)(7416002)(5660300002)(66476007)(66556008)(8676002)(8936002)(4326008)(6916009)(66946007)(6666004)(316002)(26005)(83380400001)(36756003)(31696002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UDRGa0Q3UmRGY216dUNyYVkzTG1LSUhxeEdhUDEyM2FWbnAxeUUrRWRmUUFo?=
 =?utf-8?B?ZTltUUJTT09taG14djlpaUxvTUVvU3hZWUo0V2swelpVNGRUL3ViZVFyU2Qr?=
 =?utf-8?B?MDQ2azR6ZGNON3ZWZ2EzcmxEU0xESE1KZ0FEUGRWUzJ4NUsvOGg3WFg5UDRy?=
 =?utf-8?B?ajJkR28xaVpOd244Zkc3SUNReEUvVGh4SUZCQ0d0NGhjRnVDNExlNnpBdlNn?=
 =?utf-8?B?MENsb3ByTmRTZXdRVzdnd1VjVW9VN0w0UEoyeUlMeVFmWW5xQldTaC96aFU2?=
 =?utf-8?B?SmtCNzdrQU5OeVBQR2hhR1BwQUpvaWlGMThWTSttYkgwNE5iQVVpR2Jsd0c3?=
 =?utf-8?B?ZWJWU2E5VnJsb3pYdEJwYzlaMzM0V3ZtSmdqZm1BYnppT05wcEU0czhMWGZE?=
 =?utf-8?B?T29SMmJISnNVQWRaOXA1ZnE2SXNuNnRnc016bG1QTTRlRWFVNlJ6V3E5RzBr?=
 =?utf-8?B?cUxZdVFGZzBDMGZHbTJIMmFTS1NmanhHZUxUSVRTZUR1TnFhM2VzNnhhLzVS?=
 =?utf-8?B?VTRlZjBKUFNWT3VzdGtzZnpvelF6V1JmbDR0NGJsRDhBck41VkM0Z0ZvaUVq?=
 =?utf-8?B?S1R5M0hpTmc1M3FTVjZKMXRKOVhVT1k1cVdMNnJUY21mV1kxbzZ2MjFDcHIr?=
 =?utf-8?B?Y2QraUlUa0M0RDF6dUJBdXgxSk1reGk5SktKb1V4MFhwbkJyWVV5QkVGb3dZ?=
 =?utf-8?B?NzlObnpwY01BVzRFbkRZR0FCRmNMKzNDN0NFTURtSEJXcmFvRnBadFY4YmdM?=
 =?utf-8?B?Y1pseWFYclQyWDBBbVVSaWc3K3NTTE9KVVRXUkJTU0YzMWhYbHZBRkVNcmRR?=
 =?utf-8?B?NEF0U3p3ek9yU3ZHbTFLUy85Umd0Vm1wZklBT2lvbUVyT1FoeUZPOGcydlAv?=
 =?utf-8?B?NWV0YWZycFNwMzFjeXRnelorTS9rcTJUZVhNR0MvT1lyZkNHSVdDZWNVTXA0?=
 =?utf-8?B?Y2p0V0pkZXpvaVdrY01ReCtBdUgzbzIvWnJzeVlwbnJSTC9VZmZndW1IY2Z4?=
 =?utf-8?B?N3RwZEpVMnd6NTdSOUJrQkV2Q2dXOExJSmNIazk3aEZkeWNhYTVERzh2NnJa?=
 =?utf-8?B?L3JsZGZwQ2dXenhuajM0NE1yN0h0YVdvRzUva2FNNU0zVktmNm0rSllSN2Zn?=
 =?utf-8?B?VmtrOXQ0NXB2M0tIV3RmMUZHVlU1eG5hdy9pSHlCVzE3N3ZSUCtXYk16cTVp?=
 =?utf-8?B?cWhrQVdKL1phUzY1M25WUFlVL2lXMldTVnl5ZDlQSFRub0RmQ1laRHk4UVdZ?=
 =?utf-8?B?Smh5VjdRdEF4MW1hVmZUejRyYmNQNk5oZGFZUE03UTFZRllQYzM5ZnZUWXBZ?=
 =?utf-8?B?YzVvejJONjBBMEJIMytOR2U4ZVBXcnNNanY0SW9yaUEzVjZMZEtZUldSU0FY?=
 =?utf-8?B?bGlLWDZPRHJsRXB4UktTOTNOZ1FjUUNUNk9TRk1mY0Y5c3NxNVQza1J5ZFFa?=
 =?utf-8?B?cHQ0OXpVeGk4dFZyTXBGM3p5dS9CRDZmQiswYXZISmZOQWVtQUZVSkdvbnJk?=
 =?utf-8?B?K084ZlF6TWFJNVlBKzkxT21nN1ZwalcxRi8vZVVScWVoUE9maUdDdjBpVVhh?=
 =?utf-8?B?SHpQcSsvemJaOGhhRC9WZFQrKzRJMXZZZFB2dzFPOVZrRmpCVFlwSzhIRVZC?=
 =?utf-8?B?M3BYKzE0WDFwY0FSTnM3VTNDeUJhWnovYmpFOXlwLzI2ejEvSm1qM29yUUJl?=
 =?utf-8?B?bUxrb09lYzRxUzczZFc0bFNyTFMrMGdubjkweldGaStsVnA3dHNCUzdJeXVY?=
 =?utf-8?B?S2Jwd1NoWS9PbEVUR2ZoWjR0N1B2M2diSFNUYktVditlbGh3QTFjYnFSZVpo?=
 =?utf-8?B?aitNQWFxb1RDU3dWQUxiK2RWcktMMjg1RVlBUkpodE5zcW5PclRGRldXTUJt?=
 =?utf-8?B?N1ROTmphejN5R2VIeDZtdDh6MEQveHdna1Mzak1lWWtvSXhoejQ0cTRVNFB3?=
 =?utf-8?B?OGR0ZUJITjEvbEJZQklDYitudjhZRW1nbmxOcHRuQW52ZkM2dTVjbWo4OUli?=
 =?utf-8?B?TnpkUVlQYk5TL2F6N3FDZzRzdVNUR0t6bHhOTGpTdFlmNzZneVJMZ1paV3ln?=
 =?utf-8?B?UDdyT3dqMmZjTitpbEtpbmFrazlwaVlGd1JvZ2taMDdQQlN1QkY3VEloUUxG?=
 =?utf-8?Q?Ul0b920AFLvIOp9lqPGstDkT2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pxNIdxz+4e0G2UyKMEQmCRL5rCffvEtCONfzxS/5kf5LFVuPYLB+99KbMV20tmh/3gA0Z8Z+KBGW/sro2eySPjA9xUaPJ3mI5KN2t4ZWK/wtGSIa4uKQL2k/u+tiH3HTq284JqfQ3CDHFhWD7cXAUYVK7ufYnImf6FcSCwclnq4IJS+Mlne99EEN5H9lPc4M8dRB0PgZWLasHmZGrntRUv7jwpIAaVsg3a+bveOPMuhIzWitZYUZc8SnWGFX1SexZnbYJBGuj++tQXE8lN4y48cOGlCEAJcaNuRANB8dPYVljFGFhcGuKYplVAxz1Q/zJMz0rdwAyOytPfa9YgG7Kn7rAx/chppmJkmloLxAr0wE9lq6TCw3hqsiqG3mQhCKST/84CymMdExrP2gL1xuJlHmSb0vFJhLztM9RcRr0CtUWb1bvDFF2+2z6GfVo4JhdBv2Fvyr+08R9MZqyx4jPneUyYvLznLlF97wYZio8GdgCewVCO70oRtLd32vzRGQ87i3MFB/yhpTW5GvCO+c40QfC05oJL4Cc7WkjWrcCc3zCPIKFx5p73Ul8OBHYR2tpIBhPU+nIv6fSeX05AlcrujGMmAPNRO01S50SfAGBIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f748fbf-3078-4161-a909-08dc2bbcad30
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 11:20:54.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCphpynEgvbfd63LQDlMtwHsPF7sFaq9AkTKH1xa9btMv7WRFWssl8sY1OiFRlzZlojnYlLlvJFpM6cB6gBiog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_08,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120085
X-Proofpoint-ORIG-GUID: 0H9Hyh20uUmUz3lWzU-QixGs8nnEe87i
X-Proofpoint-GUID: 0H9Hyh20uUmUz3lWzU-QixGs8nnEe87i


>> +
> 
>> +	imask = ~mask;
> 
>> +
> 
>> +	/* Top bits are different, so crossed a boundary */
> 
>> +	if ((start & imask) != (end & imask))
> 
>> +		return true;
> 
>> +
> 
>> +	return false;
> 
>> +}
> 
>> +
> 

I'm not sure what is going on with your mail client here.

> 
> 
> Shall we ensure here that we don't cross max limit of atomic write supported by
> 
> device? It seems that if the boundary size is not advertized by the device
> 
> (in fact, I have one NVMe drive which has boundary size zero i.e. nabo/nabspf/
> 
> nawupf are all zero but awupf is non-zero) then we (unconditionally) allow
> 
> merging. However it may be possible that post merging the total size of the
> 
> request may exceed the atomic-write-unit-max-size supported by the device and
> 
> if that happens then most probably we would be able to catch it very late in
> 
> the driver code (if the device is NVMe).
> 
> 
> 
> So is it a good idea to validate here whether we could potentially exceed
> 
> the atomic-write-max-unit-size supported by device before we allow merging?

Note that we have atomic_write_max_bytes and atomic_write_max_unit_size, 
and they are not always the same thing.

> 
> In case we exceed the atomic-write-max-unit-size post merge then don't allow
> 
> merging?

We check this elsewhere. I just expanded the normal check for max 
request size to cover atomic writes.

Normally we check that a merged request would not exceed max_sectors 
value, and this max_sectors value can be got from 
blk_queue_get_max_sectors().

So if you check a function like ll_back_merge_fn(), we have a merging 
size check:

	if (blk_rq_sectors(req) + bio_sectors(bio) >
	    blk_rq_get_max_sectors(req, blk_rq_pos(req))) {
		req_set_nomerge(req->q, req);
		return 0;
	}

And here the blk_rq_get_max_sectors() -> blk_queue_get_max_sectors() 
call now also supports atomic writes (see patch #7):

@@ -167,7 +167,16 @@ static inline unsigned get_max_io_size(struct bio *bio,
  {
...

+	if (bio->bi_opf & REQ_ATOMIC)
+		max_sectors = lim->atomic_write_max_sectors;
+	else
+		max_sectors = lim->max_sectors;

Note that we do not allow merging of atomic and non-atomic writes.

Thanks,
John

