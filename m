Return-Path: <linux-fsdevel+bounces-21215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C9990070D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F094328B3C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0C919AD75;
	Fri,  7 Jun 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GJI80XYX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JcuCS6OX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04929199234;
	Fri,  7 Jun 2024 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771243; cv=fail; b=hKt4ywnWvzpi8qjSkN/OqwN5rp2s3oGx1ln+BejAfWJo3i3kiPHNxIb1s14Qxw7lgYJY1Vg9hmzqAEqJDq/3hczRBzjzsv19naDVnDhP9n4/vWPJOKarDoRjl8YPm3bfykfNt/5ubbY7Gtklbq6Swh0uJ407SLQynDICGSR4guU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771243; c=relaxed/simple;
	bh=R5IY8Ul7LJaRUZEYmRTbd8wBnFo8TiDpaRa/agaexN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KXFdA+uloULAqqm5cezkJNSs2UyVngxAKxx8D/U7lfobzRFrkQRnclCH+tT1YwaNBOSDq6JOND1YLRQu5vg/tI6xjGfmEBTRITRq0lmEJvvKa7Yo0KySMUo5Lq/4R8zY0/ISNGRbBxW30Hdq2e5FsX99SJ/Hib5rENEVpsAxilE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GJI80XYX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JcuCS6OX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CupYN021557;
	Fri, 7 Jun 2024 14:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=MjUuXW56GSzvXIpVrRAGoX61qTZTfovOQxGNmcfXok0=;
 b=GJI80XYXQPw1448EN/YSi8zWYzAwo92HUOcuObcS9Q9n8aYkxRIX1VlfmI1U+bxhsAAm
 2ogcJqyKQycNfqAVjbXtoMVH4sS5g3bCW94T3/EBOgZgkpcVeDcNTEzytbwM7M0FvUHq
 8cchE8BI1ylwsh4y1SlGaKwhrqBJiKyPJHHsG/M/TL4gwkgHXKwbZP8sh55NsEnlAdTB
 zNgdII3CxBsxC9Wk/g4lsHzhKggxNstxXYiENtOLycBOZwfSerha5abLAqYBzk4Zo0P1
 cDT9ylbtXxUODiuKG0/8LGrYWpkec5UEWcG6U9mCzQrBh24TJXePvJJvb/eL67n/NGmV uA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhdufd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DJpO8025103;
	Fri, 7 Jun 2024 14:40:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtd2yy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AexUuTpjVWoE4OpHhpEWr5CmnDiJXC1wrpJG/VkNNLJxHDjhYlWnj01uuSboQ3NHuKgLwb/vrSPEqW53A4QKHFc0dDGwnZBnXj+CH4HYHd30WAe/eMmolbu8nxrQRxlPbojUd4SDPOZ2rFwqB3kRed19gTtSJdFt6J855Dw8yXZiNIXUOXPWxVbC+Ltk/xwoo3CN4RYW50zXjl70SDEEtFP4cNqx1vPa5hE1GpsXhK3+c/VAum5VV+1HMszLjfNUHn6R54PPNGfEwgtIPYnOw9llPJkvI9Ok7hz/VxRfr0iwQOV4FKn3+YLFLfNzzNPer+FrbymzD0dzBAWwXjs2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjUuXW56GSzvXIpVrRAGoX61qTZTfovOQxGNmcfXok0=;
 b=eajWAhroXNl1PVrD1ceI3CriXXmvYcKMKak2YS4B0RPPCUaXbbyujCY1d7SxtHQf5NMAAD0Ay824Nkm/0KIw3wA7o/5gI8p8ZIoz8RQWH1HW/FaR6lOo6CMEyLEdp6VSUf1TNCPFzY4txZmTklfZ9nP4JzU4/N728PzcWAp/TsuMibPkF6XJWKwvHtjjhjXNcgZVsfb+NkQRIojkQhHuW2ITj7fl8bGh9H2yFmFktW7F5SOZT0qWELo0UtZ5JTFImuUmFZ9Tq1ACyWiqQZuT40XhUDmkaw6ZiHekMIL2RWM3n+RppD0ZaUP4Jv2Joxhgb84H4yYsY372XpEqgGGBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjUuXW56GSzvXIpVrRAGoX61qTZTfovOQxGNmcfXok0=;
 b=JcuCS6OXBEP7IfoIZNcEsxSfvhHmIMLGgKoaDRKrBUJRZuoMr/Vhn9aZQiqfqPNqHWbfE/CUBpEoW5AxLao+DoYLWC7lXpr5ExbIaZfhsz2e9UnbxiwySF655e7kQJ2IvEqBSA8z9YJprYkRDOPHxjx8A7DG5VuA4dy10QYWWYw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BY5PR10MB4226.namprd10.prod.outlook.com (2603:10b6:a03:210::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:40:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, tytso@mit.edu, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, djwong@kernel.org,
        jack@suse.com, chandan.babu@oracle.com, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com,
        ritesh.list@gmail.com, mcgrof@kernel.org,
        mikulas@artax.karlin.mff.cuni.cz, agruenba@redhat.com,
        miklos@szeredi.hu, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 05/22] xfs: always tail align maxlen allocations
Date: Fri,  7 Jun 2024 14:39:02 +0000
Message-Id: <20240607143919.2622319-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BY5PR10MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e267ef2-d4ec-4599-bf87-08dc86ffb916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7gPw/p7nhS/AJrlSRRZdKeDCEDPo91S+aw5O6ruDcK5kA6dt9K8bQx0fMbM1?=
 =?us-ascii?Q?wEjX5zyJaP+kMVpmDW2KM04c0RNui5Vq9yTS06ngPpYKnpyuCoO5jW9foFtW?=
 =?us-ascii?Q?Vg7AfZmO25YJtR25vuTR4ws8DpblqI8ESy9lMOnkPYQy5S51WGqzyK9uCmbO?=
 =?us-ascii?Q?HM69aut3gD7UdRh+7k11thpRPn+II+A5PaHIhJThEoOF+uRyKsawzQ5x1wNg?=
 =?us-ascii?Q?Qysi6B7MfMzfgmxDycxw3FJwAr+Xd8gQfT6UP3CI4hMlddF1/OPHoyesaCOG?=
 =?us-ascii?Q?mDhlEWAghiyctFqxcNAKPIUwvzuzdUCVrrxPk9AXgRfp2GZPjF8ZT20adR1y?=
 =?us-ascii?Q?vqSQSKrsaDdyjFr8czNyDjoTbclOOna5rsjLkcoZMZKGI2WAHLmVA6HYh7i7?=
 =?us-ascii?Q?r2U5bNmus8tlee+UGaL1soY5gpel8OKM59MW0FjWPGISqlvdNneTyO0mnZ7l?=
 =?us-ascii?Q?UMiv44URg8QW8mzCt7f0wDR4rbSBau7xrnjoI5NhujoJanjCGKRWe/IkPoux?=
 =?us-ascii?Q?CqahPLwhX5VhU8keSD5xDGW9gKPcNnAce5lepr2ivi0I09PpL4jrc1b6doqK?=
 =?us-ascii?Q?YrSiKvaq0LU9n2O2EbeNnCTEKLPfut/63wRbzcDx3tMXOghqnLEuxWzApaje?=
 =?us-ascii?Q?TvUOdqsN+y4x5kk/U7DeTZT/tXR+xZPoxcUbZaYKhIPMdCExRelylgfVrH6q?=
 =?us-ascii?Q?Qfxngy70/5aZTJOsMtSU61gwP8c0jN98QxF4CKbgD9/XVFf+L0oLE0IC3cwa?=
 =?us-ascii?Q?4xuff9wyHTvBRaD4WMrlyV+DKtJbef/wYo8z33HY66q6ygTqTi64pfquyblh?=
 =?us-ascii?Q?ZPXrFYOLVGWl7w801/JEcnqPY8Be3lHrHX2Sw8ijAtv2IKV+VK5a8U+AElbH?=
 =?us-ascii?Q?VPBvCONc+pidbatXmhgp7Z5i7x0lp76Bi75yy2NT/nqE5aEQrxT+ENShKd2e?=
 =?us-ascii?Q?g18o6Ik6QB7DNNo1o1/wkv2Je9KtZKpRMkWBsIXRNJlTBkBoT3zwstVwqKUz?=
 =?us-ascii?Q?A5lD/0+/kEMAFVt4dGlYV5OxK42/Et8QeJ8OHEhnqNUjmo9bVkUvoWRmMjXb?=
 =?us-ascii?Q?C1R5eN22bkUKM/fZufCY06ZSFFgTKj6f4qFjD7XCH0psh012gL7lrRcRqg9D?=
 =?us-ascii?Q?biIvJqRsl89O3iU91TIYPMy4gMD8s6MNl1YTIxU3zBjdUx10Jyaeh6hBYNEQ?=
 =?us-ascii?Q?kH8d/ccAx8YR1VfPgdz+Cr3gCv5Q6Gf4pTMUWPWjwUix3QXEdgMlmmVgSMwh?=
 =?us-ascii?Q?wKnAl4FYiqzKvGk4ELx5H+b5zckAr79U4DUZxhNzQCuf5BEGM2O2X47ayTL2?=
 =?us-ascii?Q?EhFsRniRpFN3n37eIsvmjp3a?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sNDl+vPX6XZDTYtv1UWg0CcZu17ngIQ7vlHCDHaKOa16HwGFNVkut5+iArtP?=
 =?us-ascii?Q?ZSvoEYTgzayMWMAt/ONQvX1YKEQi97BlLdlnR7rny8ToDwSqx3RwNCoqbE6i?=
 =?us-ascii?Q?pVvzdWsOpfOyqPYKnEgGihyDgcje2BZjgozB53oj8iQH9derg3ySxI+IhXdc?=
 =?us-ascii?Q?HHW5TaLWzsONwQvC2xrDxsj7ezx2gJJTN4HRNfYRLcy7lB3BVMjRSD7Djyjm?=
 =?us-ascii?Q?T17As/VLBGHI9ogLabZRIuBopaS2qi6QR7U3KCe2x5lgcAJMPdfgrabs9rFE?=
 =?us-ascii?Q?jrManRHIFKoHdrpeas1LcJGs6tA6+EfrjhS3sUm/2dohYgNoiMzXURht8aMw?=
 =?us-ascii?Q?7wTb5TYeJie5Jr5Fqxqxy80/qDze2cFFYoYllyV/RLWV15dfSiTGooHrNMX3?=
 =?us-ascii?Q?GA7fKcsdhBsCc8XE9UOGZe7gcD1SGXbbGnMX1BDUATNY2Mb2r0Wvbc/fOJv1?=
 =?us-ascii?Q?8EZCj+QUG5h3rVTHKsonyqoHaEATuMYh45ulKOcAKLhazvFN7MhRy4nOjFlJ?=
 =?us-ascii?Q?JxKwb/NLaKNHEh4JIxhUdhWKak5w9au/AzGbo3yZyLoWFn50YEgyPq8+gyfi?=
 =?us-ascii?Q?pLaMjJ90H0rdhIrd7KZxqtQUaKPBUkQqcTFoB2C1tL9yNZWxhfoAAPWMK2sp?=
 =?us-ascii?Q?yy/UgHuNrxKQk9f9tZcYBbfdWDJv9Zh+JuE6S/AFRXcxomhaiFgH4LpB5hpR?=
 =?us-ascii?Q?wS1YWqMqr3iPy30TYZ955kcCj3f27ldNQ50CxG7ozkH5nbYypVyHfR/cyvr3?=
 =?us-ascii?Q?F858K5FveRGaTlkK3LXokLBrGGm8GjB+1KMPmrNl8ZWeqNcl617R/9sazsqv?=
 =?us-ascii?Q?R5Jn8BgdRDf9tzgus675lkjSILGIcrErJdWZiCr/S+tqA2ENtMbNfUOxMoGj?=
 =?us-ascii?Q?16neEOGcc/8xATxDeeXuKBcflCCIa3FffkOXtazgLfnpZ7S5tIwOk8xMtPoP?=
 =?us-ascii?Q?opbBmXEFfLK4RgRW2xWIg/pTbQ35C2nPpS/bYbfcQYqBOPX2IBmPP0fBP3Mb?=
 =?us-ascii?Q?+7JlzMYooXTtEecl0uy36ioUXEpjD6Igz1wcEr0trP++Jc8QYtdXVxw1A4BF?=
 =?us-ascii?Q?0wNUCkCrN091Kp54ZiM/kKxbw9OEIigBOg9UN36v1es1+e3A+vsCyb/wwlRB?=
 =?us-ascii?Q?VKYKouK8Ui82wRcPhuAMI2BIPsaue7xReaBCNbt/LOoyuxEoDZfSGFifGMYy?=
 =?us-ascii?Q?AQE89dLrCZeEoLv/ZbzoWdonzpKqNQfMQRoLRNDBgJA+vrE2dmHLaeXcA9eF?=
 =?us-ascii?Q?M2WcR7GC8l4xkbM5U8KNVNfk3Yb/jSy16PDPWjK3KbgellWDubpXO7qgahPE?=
 =?us-ascii?Q?53WGfyCrZp5t3yEishZKP9H8OpPuDGSnjbFOsoYoS6LEQTMgXwiynZSLzN7f?=
 =?us-ascii?Q?MoXqcpxDOpSyblTINM9PAc1oOWyyU7i4Kd9urs3TGZOVp53Kubhm9PfVR/OQ?=
 =?us-ascii?Q?g8j3J6tf5HhhPVKMTgtcAhVvOAejJWvn8+dX7Pba/1hjgWo60bIsvtPZW5my?=
 =?us-ascii?Q?q1JBXEDa4EYbraaR3zO9WeCskWS/6UFzoeXUJ4/nidj8V6Lul2LumaSEphMN?=
 =?us-ascii?Q?eC0MT4+fWQjMFaaQdxsvDDaJ1Mc+I8iNZ/Vn9SO3Vq+R/Yh7IPJ57dFBShW9?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eeSb/VQ0AtPZ+sxlSepiz17Cqv0LePUbY4PklVByiWoFnq/y9IrMnCfA4Ue96rhsEQe1B/Wf4fuPvl2cpsgBwfRUri/Pxctz4HfLA4jgvhfy/dxtZ2wp3N+UJz8NJMtdDwIFRcG99XVFADBOlEx+aglR8vg5MCnwdtm3MVd88PGUeuSC8aoJmu5klnFEjeVSE3VM6j63KLA3dc5zo9haTvIOjIc08ZKbgCjiIXC/AsNnS45gcYcN4p7Mic5vUakvsDXuSD78b4qzQyeypBdMQYYicui/LM2Lw+GjkxPadDXdLlTwAfFPIHZnCNk4C2fZMlBfWJoTKjzdgj771r+gJA9essJ7snua6+/WAhmKClxPTAAEGWxo8nH5l7PPQ/8LhKhZnVjGwHyLdFUGZlCxp0S0sbrFv1GicWh/gNPi0tmNcty08h6hodnq5KqHToi9xc+cdLK5VvtuBjfZUc76dezNlmta2gJSSfEEtkCE1s4XMUC0BQvmTqHFxO66ci1NIgPKb3pEUQh87nF3jb4G5GRRLZ0lf5zsiBD7cb+Vkj68c6XRsYwmjHMhBZzP6uciD9lcZ8tRx9inO4k7PzQ2F9dfm0qB3Gi98ZXe3FShTB0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e267ef2-d4ec-4599-bf87-08dc86ffb916
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:06.1373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeMTpAjaKD6Boe7Nf8WDRrfHWkmCb6DUdxXRbq1TyhjRSoWTK8WupikBwsbZIBd6AE78ilRDtlqA3BXPm+35sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-GUID: ov_tdcW2raaN95C4BzHe_pJUsBASs6T5
X-Proofpoint-ORIG-GUID: ov_tdcW2raaN95C4BzHe_pJUsBASs6T5

From: Dave Chinner <dchinner@redhat.com>

When we do a large allocation, the core free space allocation code
assumes that args->maxlen is aligned to args->prod/args->mod. hence
if we get a maximum sized extent allocated, it does not do tail
alignment of the extent.

However, this assumes that nothing modifies args->maxlen between the
original allocation context setup and trimming the selected free
space extent to size. This assumption has recently been found to be
invalid - xfs_alloc_space_available() modifies args->maxlen in low
space situations - and there may be more situations we haven't yet
found like this.

Force aligned allocation introduces the requirement that extents are
correctly tail aligned, resulting in this occasional latent
alignment failure to e reclassified from an unimportant curiousity
to a must-fix bug.

Removing the assumption about args->maxlen allocations always being
tail aligned is trivial, and should not impact anything because
args->maxlen for inodes with extent size hints configured are
already aligned. Hence all this change does it avoid weird corner
cases that would have resulted in unaligned extent sizes by always
trimming the extent down to an aligned size.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 5855a21d4864..32f72217c126 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -432,20 +432,18 @@ xfs_alloc_compute_diff(
  * Fix up the length, based on mod and prod.
  * len should be k * prod + mod for some k.
  * If len is too small it is returned unchanged.
- * If len hits maxlen it is left alone.
  */
-STATIC void
+static void
 xfs_alloc_fix_len(
-	xfs_alloc_arg_t	*args)		/* allocation argument structure */
+	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t	k;
-	xfs_extlen_t	rlen;
+	xfs_extlen_t		k;
+	xfs_extlen_t		rlen = args->len;
 
 	ASSERT(args->mod < args->prod);
-	rlen = args->len;
 	ASSERT(rlen >= args->minlen);
 	ASSERT(rlen <= args->maxlen);
-	if (args->prod <= 1 || rlen < args->mod || rlen == args->maxlen ||
+	if (args->prod <= 1 || rlen < args->mod ||
 	    (args->mod == 0 && rlen < args->prod))
 		return;
 	k = rlen % args->prod;
-- 
2.31.1


