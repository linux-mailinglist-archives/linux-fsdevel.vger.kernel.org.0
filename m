Return-Path: <linux-fsdevel+bounces-48199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9217AABE94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C204A1C2669F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A0627B513;
	Tue,  6 May 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pnSt68Cw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ko7l4Wo2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175827AC38;
	Tue,  6 May 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522349; cv=fail; b=Zv20sgynzuq8pwxoqS+cBJs5yfHvm8BLbQjjMQ3RzuiQ/B/Hmgmnxgrr/WYRswiVHmBviZfo685kYTVnWfPUJ0G10zQ2c8PhWrIDrlDezN/d+TQaJkG1y6EO0YbpvK0HeZT8IcHUdK+IBOmTzOXXiwtZ2liFS6mHNz0TQbh7nPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522349; c=relaxed/simple;
	bh=9VFmvw8VF1chdP8OjAH5HxqGEv1269P9oeW+EWcQoRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRvAv6/jmaiM0n66D6OE5HlBiumpjBim5JvaSs/zfnksVNs0ejLX5C/0xUn6HyYXEb+AlKH9ccqkm9c0mk6vMDnQRXwC3eJ3aWY3AcpvRZCOau84mli5zZUdU5IS3Y3mOlFribHA7gwI0EFi1ZYHKkkTkbwuG0MZB1hczDx4mtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pnSt68Cw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ko7l4Wo2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5468gAFP014822;
	Tue, 6 May 2025 09:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j9xxB5gxSLG2TwhErVZly1cUqbdL0R17BVPJ3uUQ5Ys=; b=
	pnSt68CwYxe4yAuEp/nyG3x7psogksnfpvytaAfSmBtIfhn0AA20ASiUMEC2hrdH
	8u4EgbdCgifl47eaZYTYHpK1MgHRJpoZtY8C/8ZzgO+yNxQIarOcMaODQs1kQT8m
	OUPdeOdZwRULPmM3990o19A5QCo1bZcAVwNglMNWb55JmuJWkUO/F8OIHJfG2t/n
	Tl7aTYx6RphEy7kr/LKuVvHwodscSNggAH/TUiEYCjwIrJfAWCtK2CGCGApXcVQj
	JEytAQB9IB1bN1dYjwHDO2ziqb/KFa6ZdBIaN+Vxr0E0MQ+VS/3CQ7TZE2AJ8N7E
	c5NMe02l8f+gcwrW+hF1kQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ff520180-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5467UB9J011303;
	Tue, 6 May 2025 09:05:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kf0buy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 May 2025 09:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rpp4kI9kfYWq8EyLb3D9xj02ZHAt95sZ6hcdI6eeaDITdFsHkQyO582RrCYPRnslJYNvMPSXEmZCCcg9WL1PvDCfpOQ7z3nY9na+vNauptfpqD0fhEb81BWoZzEB3EkwXBGI91Ia8X/spbtPwa9SLDXboK+LtULiC3LgtKvFAiQCbtpZA3YRb1s5hfa61MjAS1wdwlpqkqIUp26Xu8XOJyk1jPs6AYd1PertNIyX2kdzoFqOMpQkxUi7CkG1rI4hitu37E+IRQJ2P0wEP/s2CoFZmCP84vGowJ8awOBav2pzWe4rwdVD+8mVMDkD0hOLXiU0O2X7SC4H6jC+6p5CcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9xxB5gxSLG2TwhErVZly1cUqbdL0R17BVPJ3uUQ5Ys=;
 b=zGE+rGbDrwlxoNuSeaqs3+JG7jgGxP+pcTztB6uL/mW5sp8le7uaMQDgtULuMY6ubcJdR9gQ1QWITcIzgOuXGuODc+E/szfT4ieEBN3SJIs8BeWlLGr4rZU4O8wOmoEPf34CZn1B1dqRVCoFBPTC4YyrEjWTc5CWkO1xUwwCzpDMSQ1qhmKDYixuVQapiwYxzt2VAMTLhmdEwc70GAw52FV3Fy31oxpKWFmq3NlO+nN0atXZ0Eava6EFCnLs8JQOKaLPayLfM70IljvGjoapYX8A5D3WFmOoNadEGoJgzq/Tzj7/+R2lU/dFYk/19iTcTK0VV1HJAF+LAd+5MKJ1fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9xxB5gxSLG2TwhErVZly1cUqbdL0R17BVPJ3uUQ5Ys=;
 b=Ko7l4Wo22l9D2GyPUJ/iYS8dtWCXQy3UDAvxmZLJ278+Ds0ksibvQs+kG54aWzvR+RWAuaLYvlM2w6y7TPcTFLmbLiQo5RWep7dQumKjfolvVOpp+qvuM3Xw4uwOwEMNLiJyl7zc+m0NwzKqQgdcSuK85qVlvn1TI9KP/0PDPeQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 09:05:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:05:26 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v12 12/17] xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
Date: Tue,  6 May 2025 09:04:22 +0000
Message-Id: <20250506090427.2549456-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250506090427.2549456-1-john.g.garry@oracle.com>
References: <20250506090427.2549456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a87519d-47e8-421a-8901-08dd8c7d2486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3XgozE9Y6dj5+EYL8vtvUDQTdydX38PNnboPRDBClKNtweWEp0/l9bor4Xg?=
 =?us-ascii?Q?eUqV6+As5EQWSuVRrK0cFDm+2F+xP/jjFfTOuOoaMwRWu5XBXj4WLvvG8s1T?=
 =?us-ascii?Q?5omSmpGJQM5tYJEZj67MQYQpPxz39Wsu+5ldXeXhGDe9EuKxOxPUnCLNHMMc?=
 =?us-ascii?Q?XAQslQl+4I34Bgo06AkMVkbUxKrTO+YQklYNweyPT2c7cScTaGwAdwuHv75D?=
 =?us-ascii?Q?JqwvXDRTziJRbg+AHMFut2/caMkklP1lJxGN/8If+u50onQFDkgG0vqE4td0?=
 =?us-ascii?Q?KBToK0wqwO44kU0xffk7rwuEFcKSBP+eb4f1YJ8JoCCFmNbb2vIatnkZB31l?=
 =?us-ascii?Q?6Z0zsuDzHgzDvzOpajuedLtsjJd6AM5trrs5oc8xXrfEbxJn3UROiSIWQ1j5?=
 =?us-ascii?Q?LXz4grWiNXe2IHepUFYCtAe9LSP4F7yJjD9dmJxXPIgqRCYzFa1Ndk3LVWih?=
 =?us-ascii?Q?aBWqj9gDItUR4szvWtaeZCvYitmjyw/rlfesmGsIIYTKXJ/lvSZyyls94wgd?=
 =?us-ascii?Q?AjIsN+nGa30UZOMMtjBVdTvz3RGva4eYo/7EcPlqXDZ6QlKK/0vpoJJCYqDe?=
 =?us-ascii?Q?HERkU+H6Z/XMF9u1sfK/wNQHPYQtsUZ7Xgauh06zK3vj95DVvUKVP/Cdj0hR?=
 =?us-ascii?Q?+gHuXLyFg7IKK7NIfUCImbmel0fAFc2Pg1QKGfP3bAGUJiqswj9YrgtaRoI8?=
 =?us-ascii?Q?lfhdf5arj+fty8bIlYkiCIPULvFzdMaEbBqDl5DdvHlvECMxgCLnNJnRPqhZ?=
 =?us-ascii?Q?i6Zml8f6Johk+e3PRZce70RYYvYGpXAIo0dX2ygC6LST7Mlv40WikDiDJAuX?=
 =?us-ascii?Q?KWh39N20hDCUR2nX+hf0Z62+E17/U4uUdDJDRi/L9Xa3N0K1/wOu8Y8Rufz2?=
 =?us-ascii?Q?7bI1FQ22YwUnSHMAw7dOScucCKKRaKDi97QjB69X0K4DhrDKkQvPyehZ+hYr?=
 =?us-ascii?Q?jgxLnxOrYPTFKDlbsiPNL/bmKFVi90vh27zrl6Sr+mmSL+Iws+f7pmTVYD1B?=
 =?us-ascii?Q?hlnEt5HjB4+LypWkR2F87PJdkL/tSh2rkAlZbgenokVLQXY8d+8PESEKCzGu?=
 =?us-ascii?Q?ZLtvy4+EDCzlcLC0HKHZUdx1tHL5s+G82XtO5AxLgcMlHsig+t7sUaORgjae?=
 =?us-ascii?Q?o9fy4dPG2TTNBGAk2JwHzgA2hcngmpKZAp6vkrv1NsZURtuE10QlxyYVM9xi?=
 =?us-ascii?Q?MGe3/mi27qMweJcZhoe+fkhZSaHwdhcwHAb+SogrC7Egk5v9AWPmB4v+sGhQ?=
 =?us-ascii?Q?jq234S8qufarfOZdjBtgzPx1wDkZqVeoU3jlaMEWRd15gUfPq6HM2AiX4g1H?=
 =?us-ascii?Q?3SU2qb8PAxCw9bUvNF326v+pN8k4rDaKrJMWZrEUGgcJ2SEwwG8bIsXokPXf?=
 =?us-ascii?Q?13Hq1aPhugseX9MsOo/xCXq4dUkOuAlM+oNqIHEmgFv+VkpXh5d+hg9BGEC8?=
 =?us-ascii?Q?YDqKeb9fI3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pSDzMchjeEQvvpGkMxLpeL4/0BL94FY5gDKf36xNR0hJFjeZW97SelIbqbrS?=
 =?us-ascii?Q?LbQvJJeAZJLrVtTSjDX2ETkxhE322hokp/YRbY+ngl3jIO0RRsBkGnI8vO9+?=
 =?us-ascii?Q?/90waRwz8wQEkxwsOBBS+8NeN4KGdREpm/+t7r41DOQ4cN8NSdAxv2iwVNzL?=
 =?us-ascii?Q?snEDcDWcNej7HRT0JhmaKgTyvLx/HJwDJrV6E9L+ttpICKp12g1QDTQfZFM4?=
 =?us-ascii?Q?pUGVIP8aPb+MPwx/rYrotQ21Kcpcely2XiJIgwRysan9KisnrmALYdKyTf8v?=
 =?us-ascii?Q?QoflBzITDFIeUhEIYW1nZldckPkF3LmGf6lGxUowlxUTUlh28T3crWB6kR+g?=
 =?us-ascii?Q?qXd3I969i8DtBqAARXIWi8CJhdvUa/Hf+aSDqbBoMLc9sDNcWsqNsxbkPI9k?=
 =?us-ascii?Q?gBdtQd0JL+K2ldfMgaDDUc3WD5cazk7yuRtjN5GuTZ+qeiHNMf34XcmSqN3l?=
 =?us-ascii?Q?8Hu7krq2StCy4L1HFfvup8riG6Oc5YGtSjdETErCTl3y3XrJpNDqYcdqceSA?=
 =?us-ascii?Q?cSKmZ6GRhJ4JNyqjkeTpER8dnNZdisoNnU3j0tE7XsfP68Ij/O8FuZKa3uFf?=
 =?us-ascii?Q?sP3rZ6WV6aomqWqI6Iivvu2eEwf+K6P+hohehJFyZvR7/iJQlIGrOjNOpJLn?=
 =?us-ascii?Q?WNk6TB4Cygv69XR+sO5aLOTnqhUffFHuGDAwCpuKFcAePZ7LhlbDwUhpXvOA?=
 =?us-ascii?Q?9RGKfHxWUIZl2a1E2Vq6etdffZ4aMsN4ihbLKqA8VzSzdZ1UryBAm9LFHoOh?=
 =?us-ascii?Q?FARIfFNEXAlHxqQQktbSwr1IrRnXapa9wqKP8hJqz/jZDN5yb6EoAyycL+t+?=
 =?us-ascii?Q?ngaBKivBfUknr0BWQUzQqLn9GCx0qjJAKb2v0OjMdh2s3ABqS+0baHCxkmqu?=
 =?us-ascii?Q?IR+PizuA2Izs7QSRnpmBYXUUHFB3TZksIyXvQZ8i4QTUaxKnBOcDDze4Rhgq?=
 =?us-ascii?Q?llepSOvkbCipKp6X48BWMmued7JtxN/IAx+thQXwnX4r9sBorZJlD7ZZfK3Q?=
 =?us-ascii?Q?IqxkA81VD1BtqRXu4nwItodC2Cn7CHUX/0RjH2Escafs92XXM99wjs4qKzF7?=
 =?us-ascii?Q?kHUjZCXXR0BYO0mRcRGPdtMK2Ze8lNjRsuJ3ecQ+lsheKAGhL6YVZx1xJGy2?=
 =?us-ascii?Q?C508uG0OTcclBnSGY2TzaF64Lybmc7zGbgF9/qABKzK9FvWP+Sx1RfK07M5X?=
 =?us-ascii?Q?5UMBpZ7uPmPw+q6yVe4FCDYS0VenBTO3rW45x9o8unK9BZcv4iMnu4nzvH0o?=
 =?us-ascii?Q?/O6EEkEQgQgoQpeyeqZG8N5BPyBsBf2JF2s/taD9t0BT9xO8VAnXNlUUAp5W?=
 =?us-ascii?Q?+yqjPxm0etyWl1dYfWpMj8dSFTDPTxj8RumM+iNuEFV2lk86TyvfYtKP7Hd2?=
 =?us-ascii?Q?vQVIVoX4w4HfPeSC4muKo6WrZj/dQ9zoXY27wJf5UNOARE42perzw7dBG7KQ?=
 =?us-ascii?Q?cacW1GYY2s1B1QZAE5Em4SWKBwtP1C0mhtxif0FM7BUR3GqLE8i+BC1Yxiyh?=
 =?us-ascii?Q?ZjAUYuogsBAmSerA91lY5vqGZK5z3E/hZ/9j0k9wSL8Ej7wjqbdDgnI3oVT1?=
 =?us-ascii?Q?OpegriQBG47qHaLf4ffWoy0eZrhBd/2Z7zF1wCY2rYbV0U/0DZm8oVnqrjXx?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nDrkWD/vTb2w6N82ICd6bkh6Geb4lERzyNCS54qb2UTMDgbZZPPzeC5bju9FbBP4S7r/aEawADilSXF6TuN9/tGlvaKaIqNBQ4NdvzDKZ7I2NPkJ88eezGINFgpT8gFib1p9rwEyTtArTOEwgDthgelGz8hazMAbBfmTm/tVTYo1tJ9xUFzsJI3LoAzbWSg52fqGvlW3dlbMV7SG4lnJ5EVtO7ss3O2gW8XoV8pK6aw+aNstGQDdsMUmkpImTYEtJX7WaJb4JuSErfON9zzSSJzWHTFYWI62M6JCK5vEUNPw/R3L7FeuQRiiT93y4hvbYMUk5rWpdI19olHah4o6suYzd6PVSe2Ta3TtE7HA+azCuJoW7H4Ct52k6LLyMKNDxHP+HR4V8LGgLrmSHnfYFmkdMokmKYnJRPc9aTzQd8/aAA5ZjjCcQ90RFA9qEnm2nhhRsS9EprNYp5en1z43WjUkVKAgdWynkM9vgY7EyPH5dyDmXFya/YWHF2CmK4G1ZNtc35KGQnuixdd4EgJ9B9YdVJftduq9fK2Ptg2fns2UMVxjzjCMvT2gL98rXD2+trS6ar0qpFYh8+KRN88m6xeM9HH7jdcQ9NgP8eHELuc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a87519d-47e8-421a-8901-08dd8c7d2486
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:05:26.9418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D/y3JKbA5BAEhuwkHRtpHIRvzqdVgGBy8iup7rOOr/x+IJS+jsMkXH8ByiyKnu6pPpp8vUV+QRaQd5a5NU2VIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_04,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505060086
X-Authority-Analysis: v=2.4 cv=etvfzppX c=1 sm=1 tr=0 ts=6819d0de b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7Xr6i1Xs6TsDAXCDpIQA:9 cc=ntf awl=host:14638
X-Proofpoint-ORIG-GUID: XRqP03FrPM7j6EsfHFzvnz8R-TGJzVUd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA4NSBTYWx0ZWRfX/j+R/S0RHX9+ z/fwtp8Ql1rSr7hxTGq5IC1I8NfR3bf9ds78+gVKFK2PdRtnrSw8hjGBLRGl3L8OuHep/gcOeV7 mBOeV3dSvLZTC+NBjPomMu66s/1gMKG0JwwJ5qvEAtuKCAu4Z1bN/EnTmxPXUOE+UBez2bFjAXe
 8JAYq9xrGRE5rErL5OC+jO7cZ63j34EjFyR1PIuj27BXXncogPRxhSyLWD4yvqVSUbU4i0nk70T eEghtniuu394oyq71Sfiq3TZTMW3UJc0441p+HX/T00SgcK40T9jBcEgkBY0+8MjdqT2WSLk2mv OEVRVVHgvTVA0rAZIxy9u/RYVZOZK/X8U/JY4ZG+uh9A7eeo90ZiDyrgiL5i74FUrNXSGq6HTyg
 fSa7eJp9SnSQn3lFxwcP1oID+HphW14wzL7CtO++oLJUBDE43XlBy4IcQlfKLM1ua9YNX2sv
X-Proofpoint-GUID: XRqP03FrPM7j6EsfHFzvnz8R-TGJzVUd

For when large atomic writes (> 1x FS block) are supported, there will be
various occasions when HW offload may not be possible.

Such instances include:
- unaligned extent mapping wrt write length
- extent mappings which do not cover the full write, e.g. the write spans
  sparse or mixed-mapping extents
- the write length is greater than HW offload can support
- no hardware support at all

In those cases, we need to fallback to the CoW-based atomic write mode. For
this, report special code -ENOPROTOOPT to inform the caller that HW
offload-based method is not possible.

In addition to the occasions mentioned, if the write covers an unallocated
range, we again judge that we need to rely on the CoW-based method when we
would need to allocate anything more than 1x block. This is because if we
allocate less blocks that is required for the write, then again HW
offload-based method would not be possible. So we are taking a pessimistic
approach to writes covering unallocated space.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: various cleanups]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 62 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 166fba2ff1ef..ff05e6b1b0bb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -798,6 +798,38 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+xfs_bmap_hw_atomic_write_possible(
+	struct xfs_inode	*ip,
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	xfs_fsize_t		len = XFS_FSB_TO_B(mp, end_fsb - offset_fsb);
+
+	/*
+	 * atomic writes are required to be naturally aligned for disk blocks,
+	 * which ensures that we adhere to block layer rules that we won't
+	 * straddle any boundary or violate write alignment requirement.
+	 */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/*
+	 * Spanning multiple extents would mean that multiple BIOs would be
+	 * issued, and so would lose atomicity required for REQ_ATOMIC-based
+	 * atomics.
+	 */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	/*
+	 * The ->iomap_begin caller should ensure this, but check anyway.
+	 */
+	return len <= xfs_inode_buftarg(ip)->bt_bdev_awu_max;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -812,9 +844,11 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_fileoff_t		orig_end_fsb = end_fsb;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
@@ -875,13 +909,37 @@ xfs_direct_write_iomap_begin(
 				(flags & IOMAP_DIRECT) || IS_DAX(inode));
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if ((flags & IOMAP_ATOMIC) &&
+			    !xfs_bmap_hw_atomic_write_possible(ip, &cmap,
+					offset_fsb, end_fsb)) {
+				error = -ENOPROTOOPT;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (flags & IOMAP_ATOMIC) {
+		error = -ENOPROTOOPT;
+		/*
+		 * If we allocate less than what is required for the write
+		 * then we may end up with multiple extents, which means that
+		 * REQ_ATOMIC-based cannot be used, so avoid this possibility.
+		 */
+		if (needs_alloc && orig_end_fsb - offset_fsb > 1)
+			goto out_unlock;
+
+		if (!xfs_bmap_hw_atomic_write_possible(ip, &imap, offset_fsb,
+				orig_end_fsb))
+			goto out_unlock;
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
-- 
2.31.1


