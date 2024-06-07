Return-Path: <linux-fsdevel+bounces-21226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C690075D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 16:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026951F25395
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B581A2C25;
	Fri,  7 Jun 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KrzOKuQ7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EsnoJcgp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404031A2C12;
	Fri,  7 Jun 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717771280; cv=fail; b=J6jjqt725kInau87ikgKmDnIXWAtJoFxbQdiE1GPNqIUISZALQvtfTBO+MaDg28297DKViIg2RrTr/nKYv4Tq7kB77iP3FdE0m+bpYS2UqU4FLimbd/iPeAo3s47o0RgEg0MBd0+9NTskMBFaLlTZ/cBeEF/e6Jtr4BmZP46tD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717771280; c=relaxed/simple;
	bh=CM3QFVpTHCANbaFAtaNkYQP50HzdrHOy2mmRxhwuwMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kAuFe736YDIsVTWsg9InxSi8ww6XfnhRzfHsWH5HgNZBxVw/8gxtlxVySx8FiGIxeTgp2oMzaozfjbieg4Pgf9CW+iK1RLV8AJAklDVjFBHGP3cZq7d1dd9HkAv0U3kUWG3WNE3TDYnsjMIUdTVVarmq6GAVIjrojJytb3UL1bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KrzOKuQ7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EsnoJcgp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457Cuc9Z029339;
	Fri, 7 Jun 2024 14:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=Qir/hmV/MOqXkXUDAWAxnFo4+7xV2/kgkggPXtP3ALE=;
 b=KrzOKuQ7tPRO04GOxjhQBRZ5+pstqVRAgPiEOcyG3QM7qcDHTyg29qOWoFEK6kiOmz+9
 V25aZnSb8GgYE7a208ee9wn+epYwcPY3x2wW+kcsFnsyYKiT81ehQ+d48JqD2sT8q8Pe
 vvf9OCujPaS4kYWsn9bqy3DnjIgDYFOxvqkcB+qkbNj4LanR6S+H+4fYLqAci6Aa+D0q
 eB7Iw9lF6Hv7lCv8+acdfdrkcE7P9BaiaJ9/O3fUL4uOOMYaobD/0dZav9ssPXfNfu4M
 aEMGEcymRqwEkPWXQH2dC0U659+D4OBc/OyY1TCOb6594gEpjclcJN0zB21t1PMt4UNw AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbuswske-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457DFAb5023969;
	Fri, 7 Jun 2024 14:40:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr2ach0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 14:40:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDOPJV7iEoV3iuTCqY2XBMhQl+LZlYoIs4Of++pyktKuLlp91Qwok8Mzk6+VSUi8bUE5fBZ1cfWfwIdzGTYq+IVgXitPNGLTFgA/HCUZlqfDideAdqufIjvZghl361aXEtp+hucabTEbTej9rZSbCbaJfFJYfTpGDmbzIptTdkFzGfNug0gQN/9YKEAO/+soIJ0t/utuLhOzsCnb5+P/EJnOXWtUOu0PkPqCpaq4gmw0Z553Igv/06ZJzs+rLAkNHh2ntgMtv1yuzKcq1xMC9Tzp8OKdlpTn24ox0WMUbBABT5Ao7t5SFAYXvAfGxEhZuEJU86B7SZjTUTqvEenbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qir/hmV/MOqXkXUDAWAxnFo4+7xV2/kgkggPXtP3ALE=;
 b=SbUf3DJGZBVrun4dnXe1l1MsKPSff+dRTvgK/g93bbcyIDIivGklBG5D04wBWKxW+ZvnljPGFbKWv6feDRD7x5dteth3lTrsJtIwn6+bdIfJY8v0jrqHCmJwj5GvLa7JC9A9ZjmG6hdIoseM42GNuCy2PxgGAQadYCUthO7XFUlaT8X+oksLbKtHw+pGcQ83iuQwSJK7ImhBr9IQWSCrZxc9XX0M0nXw/MAlPcOOK4p9TE/mD/Db33eDSTSubeNJCWAqVJ3K4KH5ye0x57U5AwFNSR3WgoCXrhLzyFG0Hs+wvNo3MH2bgsikIJDpCYV+oFDBK69UPTujbuKHTkk3cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qir/hmV/MOqXkXUDAWAxnFo4+7xV2/kgkggPXtP3ALE=;
 b=EsnoJcgpiq1ajQZjBokNvoSs4aT7IvU7c1+LliNCTrGQSOOD6fs9xD75MMS/3pxyRdCXRXNXQOH9GgVXYH0AuTLzef/2mhQr6WZfmRBJtiLrUQWM1YsfTjbM0KSzB3+d+uFxKAm/nSFSYrrvUCFfBa/GuA3KE49mQwItFqQXjsU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4170.namprd10.prod.outlook.com (2603:10b6:5:213::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 14:40:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 14:40:46 +0000
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
Subject: [PATCH v4 18/22] iomap: Atomic write support
Date: Fri,  7 Jun 2024 14:39:15 +0000
Message-Id: <20240607143919.2622319-19-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240607143919.2622319-1-john.g.garry@oracle.com>
References: <20240607143919.2622319-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0481.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd78690-0945-4fe1-b081-08dc86ffd0c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?euoSEXzpv4TfS9S17+sYiItagtKDKA2nuY+tubJYeJjnH8FYU5Hiq3hsMnzG?=
 =?us-ascii?Q?6pxlnF4mUdqBsw8d5NrCzXYdhqiA1ujlpaAgo1dtphO22/pcWk5yxqeCcsY+?=
 =?us-ascii?Q?z8ENxiE3B+T8w6kvDesD6XaiDva/ZMOmhg5n5+ShwZ6/2u5HLJ2kXhok+g+0?=
 =?us-ascii?Q?ghFUWBcUjSGco3YtfMDbA6hrVQMkqDOHQN2iKnbLEs1CR1p30Q5cutR8Mxme?=
 =?us-ascii?Q?i3oEe6BSUh2dCcd5dhXwSwqp5fFootGqfbOtRAgg1YACE1dFOsPqDPf+uAso?=
 =?us-ascii?Q?5KkaWn7pBcbydofdEFrCEqNSXwf8cpER3q+QbZlVw3YPzVjvbaeUoWqCoEmg?=
 =?us-ascii?Q?njuns0R5BqxMyWGochv4ccRYjA1dS0W4N5/uOaYfR4GRHFWIQBHDt5XKBwdC?=
 =?us-ascii?Q?xRok9IMBirA+XEHJFsEjQclU7ts9oHtsmnse+duczw+J9g09HQlUWS4QEFmP?=
 =?us-ascii?Q?p39ep6TiwY5JYRRq4GtVib+VIhiVECpPFRTZgTY2aDIQZh/qR6tuqeFzWTvt?=
 =?us-ascii?Q?IFRAeVnLXGxj2UnQQ7EakXQozHIE8iXlZv8s9AfVXv/0QXoBE3ifaZoSjGHY?=
 =?us-ascii?Q?3Bz1M2elIpOsQUCTXwVqo9YwaNRX4iYtbKlPHwQXyPvOeyIKKiTCwUwTq/62?=
 =?us-ascii?Q?xX8+RJLiJWmPGp510XvRQebNT0GvFcobpHgBL7jR6T6HftIh0X1lPB/WSqJh?=
 =?us-ascii?Q?R1L91AiRrkGOhNtg7yeTbJnli8DyVATdGu08Q4fF2a217XliV+/q4tLzVlcP?=
 =?us-ascii?Q?FqUC+XqbMm3CX8l18tV7v9w5fsdAJXS6BokIFneOr6yUm5AEOxG7ryus/yi5?=
 =?us-ascii?Q?feyrZpvGIKBcZcwwd5phV/4MgPXevLwxpZ8kuc5+dr/2kCC1mmF8Xp5U0vr4?=
 =?us-ascii?Q?5wdsaiAwjbU0n9yLdID0KRGNjFIKl4fQRxLjAZDtzFqIV5cfn7GK4DcP/RlI?=
 =?us-ascii?Q?634yIQQthARtHE9ID1FRlTC9VerRekfFXmSf63bqMkEMo2427G8bgL6EC/DP?=
 =?us-ascii?Q?w65z6u0WE3J6qv4wakyv7G9UDq0256taVS6/1qvfctAC8cYZv+M870IYUPzb?=
 =?us-ascii?Q?Gw9E6oYpXSWQTvMV4egTOV4VrrQ4s2hLc3UxBIqsLcL3zFyq3mOvwWd58FCx?=
 =?us-ascii?Q?vi9Tm1F81M4oHF8sdbQengErbJsiCITjzsrC0n8datx3TSyObycgK0OODau2?=
 =?us-ascii?Q?jfJeOBZh2wwzsZufJ4JvFgC7QjLT2NPjpYtBHGE2OlYevSU6dqkU3C9RQDSX?=
 =?us-ascii?Q?efKk7S4fH3qu8U7jhKuuOFqwg5cQpwXqg6bOyWf3UAtipwBUNinI7Pucpe7l?=
 =?us-ascii?Q?WELndszjOs4sWB+DpDLymuFI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7Vak/2eOXLW/0U7B4Sm/wSlzrB5W0rD2pk/WggKg4kQARplT18fgdmIxUarP?=
 =?us-ascii?Q?7BetifT8jkdxQuttbmSSpz6+ub32SyGSCI60ei73uYiWCGJ4moz57NP7l01u?=
 =?us-ascii?Q?9k7aVG/EhsuCaYG6UCDWolsNcHR1tkHyYqcslvAyFjryDrp8S43HnkPtQVYf?=
 =?us-ascii?Q?9RGB57OiqweO+Ac5sQUWzAi7x9wuYVUvkcIJWttTacWRWRJenvh18ku1gpXo?=
 =?us-ascii?Q?XiC/t0YiV2Vlg6gOigo+n1Lsk7aoRAf8rfRwmqmxKQ4HkpCdq/HiBr3OmfRd?=
 =?us-ascii?Q?QWCo+mHwx+9CE+X3VsEa3teoDmPHExsFKqfedxLgu8P4mnR0Y5h7O8K2QsRV?=
 =?us-ascii?Q?ysOacBLX7EOPKUNStTjcCERidlygFqpdYoy2Zkd8pWIn1eowbhjLwbLfHaHe?=
 =?us-ascii?Q?XLMWnPg27lCWkdpJ+dAP5gEhCZXP4WzD3OqVt7EW4OBObPayh3G31O8Fi31n?=
 =?us-ascii?Q?AcxBm/9w/9wdo7MktsTsdSye2t1buT9tOU8ENevDIEoKGsnurChYRlZ51JUC?=
 =?us-ascii?Q?67W5p1Yk1wdlImXYhVEAXrZ+3UDwDbHKlhN38SMh27B0aPmU4YQRP1YFuYgZ?=
 =?us-ascii?Q?NLsU/bDtHkEnhT/y/o66jiK9PP7CI/r+fRfGaP/ZjOlKRF9ZLozuDBReDC/Y?=
 =?us-ascii?Q?3JY9p2CzmyQQDY4xO25Zs3SRkqz1BL467xtdbW7GwRvT5gJ5YDbCq6CuRvQ4?=
 =?us-ascii?Q?mF4yU6fLeX1U7UdTvG0OOhcmQBMXy6ujzL6omA7CeDL5sCR4Y5amv8MfTZe0?=
 =?us-ascii?Q?qEHk+MLfa8oc1yWyJwFTxi0tsveiZamKpM6JW1amPYqYfbB/z1ALeifuxuD1?=
 =?us-ascii?Q?6jwj5R4YtilA3dBDRJsDEtQMY2zAk4vLrTS6ye1gcze72HH/7ReKI2kcbfuS?=
 =?us-ascii?Q?rhfnCUdvttvkNaFSbBvr26aUVj9m6cyUTAGxaWIRDp4SP0T1D3QHA0p4LppZ?=
 =?us-ascii?Q?2vpCZZHzwF0ZnJvC3Iv726ufRu/p0EPv1+PKC4Ljd2Cp8LZVTQHctzvqwcVv?=
 =?us-ascii?Q?POgWLqaI/9DIzTty5Ak1HMP+wigiwzN3/+c97eK+vkO1LMp6JNFeMbYRQpK7?=
 =?us-ascii?Q?Upbl7EZCQFy6YYcIXJ58/WP/dhG7dDujQCBWMo/0MlVlqFnqMUebAoP8qw7X?=
 =?us-ascii?Q?gaTQorYvOlpEHaIEV09eRR5Xped+QspwlLZjNeE7sbaX7rIYic9nbis9gOON?=
 =?us-ascii?Q?oSes2T8c0I+76DcALjZU9XAEvhUMJDXZ7mbbVJG58A0Kys/4K05fYmIeSFn0?=
 =?us-ascii?Q?2g13kn3bFH2cxN8m4Xtyq2feq4WL8TGZ80I1e0bYYoA/E/nRNELYqsZhva3I?=
 =?us-ascii?Q?zKSU1FLYP8TgpsW7vgpZ4VpeVnIlIsqHpKpTVVylqnLSnIiC9t7aSf2EHd8q?=
 =?us-ascii?Q?4pKXWhhFpJSwcURdZCfiwVembNsbnm5vVVFg72AM/Qqo7q1zBAajJ1xckZKP?=
 =?us-ascii?Q?S4OGCC0YDOVtK5q4ygKfVMQrhiRUUm9/FIyy9ih9OAgbcw9CN3bbBLdsKMso?=
 =?us-ascii?Q?SthueX3DG3PKF1MqYEWnV+spkm6y0d9zCZcVBdsjIWdcTsrKqIpD3rLQy0g8?=
 =?us-ascii?Q?2yezatnNSvLe7vAr8Og/WmeuKCyMR1xRvyR2qxnVcUacgcHGIar+6c7WZpoI?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SU1UZeTaHWYAgp6txeaXYAcMrS9ebKHr37NSgmEuJ1j6h0t/WgoLD//+Wt0x+t45256FB/XVLctnOh105L4DqyT2lG2Z/haXLXG4sgmfxjDgcy6FJpl4DfTT1jXneg70fQJiKvqGxA8XDqptxowex2USF+zxXelXW67jn6J9WvCrTUDJpI+bew6k6ztkZ8BrAzp1J0QsOQLCHmnPc/iGDR0ksCQ+L+AcsLEd7+QtE3+gUAMyWeRb7kna+vMkQGFFUwZQ/NRR0lz+peY4ElCM7CVdJOW593UArY/LCVfzNr/kf1BpZmbEojVUG1/fJ+t70K5f3EsYK8ZusvLU/aVlonIq8z5UMlNAaXIhjBqb35eWugOjHWkvJu5oMP4ELdfTLDK5cLkS1lHiYdTvvXjYHpxyipRYLpRqG2l1mcr3yxYzQPMTtmW5n9SF30V4fJtfojKnRuYz5CSjo3JVbHsgmt1QqX8aQcJ3mWkOAUXgNPr9pyzn63n7EVZY3c4QSGR4yHhCn6c3HgStB/0XbzVq8PueOIlEobNIU3wt8RDHcBoCuAP6NwUC4ftXycnehFz7Oull0Ysozg+EDBbr1nK3GorWpZPLw+A+ZLo0fM9KJIU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd78690-0945-4fe1-b081-08dc86ffd0c3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 14:40:45.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7bbTj8ElVIAfpKiY3tJL0ICyAlvxx42VbG0Vx6cxBqc9lvMnrdPm0zvxcE+lkxHHCrtZBVdLdtFiqbB6FBW4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4170
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406070108
X-Proofpoint-ORIG-GUID: WUUrYdOivRRoz4WeGdtH58wSG-MUCCIp
X-Proofpoint-GUID: WUUrYdOivRRoz4WeGdtH58wSG-MUCCIp

Support atomic writes by producing a single BIO with REQ_ATOMIC flag set.

We rely on the FS to guarantee extent alignment, such that an atomic write
should never straddle two or more extents. The FS should also check for
validity of an atomic write length/alignment.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5be8d886ab4a..4f2a4569aaa7 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -256,7 +256,7 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua)
+		const struct iomap *iomap, bool use_fua, bool is_atomic)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -268,6 +268,8 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+	if (is_atomic)
+		opflags |= REQ_ATOMIC;
 
 	return opflags;
 }
@@ -275,6 +277,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		struct iomap_dio *dio)
 {
+	bool is_atomic = dio->iocb->ki_flags & IOCB_ATOMIC;
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	u64 io_block_size = iomap->io_block_size;
@@ -373,7 +376,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	 * can set up the page vector appropriately for a ZONE_APPEND
 	 * operation.
 	 */
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, is_atomic);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -406,6 +409,17 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
+		if (is_atomic && (n != orig_count)) {
+			/*
+			 * This bio should have covered the complete length,
+			 * which it doesn't, so error. We may need to zero out
+			 * the tail, similar to when bio_iov_iter_get_pages()
+			 * returns an error, above.
+			 */
+			ret = -EINVAL;
+			bio_put(bio);
+			goto zero_tail;
+		}
 		if (dio->flags & IOMAP_DIO_WRITE) {
 			task_io_account_write(n);
 		} else {
-- 
2.31.1


