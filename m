Return-Path: <linux-fsdevel+bounces-46924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBA4A9695B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43133BBEA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112A627E1A7;
	Tue, 22 Apr 2025 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KhkYnfTn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hThuRHRh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9661A317D;
	Tue, 22 Apr 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324921; cv=fail; b=eipQzGHBH43DgL35z7scaGwMGl/LjCbRvcWjDCTLSoLFkaNAqJaLGS99WRu4RHe9bBeu5OFwwfZvx8kGID2Kt4XDA/56A0oxmIqd+vj3hHYxmsRvymYMJa8tYwE9Hc4P0B4u2uAR7IFUGRrqpRXZ+hAcoOImzjKX3bl7mcwh3bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324921; c=relaxed/simple;
	bh=wRMdFJTC39btpvRvCDgp2rBntBueb5imtkX1eMxsslQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YHS2PdDD1yObZzUtIUvbc3HXdTXPkWfj4BNQ+wm64wmNLvNJb5+UfHwdMrFumlQj/WgFy8uV9wfoM9CtWHXx+Db0GxLu36hq1mZkGDXBROWYHTZpunE0n1Mv7DsdhQJTX6Ap/Pg38op/Vxqqemq5Ra7K6XksP+3rZwhM++N6G2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KhkYnfTn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hThuRHRh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3TIs008474;
	Tue, 22 Apr 2025 12:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=kxdMJoQeqCXOrDgy
	D9sYy5TKqmgLN4thVjIqDOOpX2s=; b=KhkYnfTnVjvXXO4VpOXhg0NH/inXh3zm
	326kEjLMGXAQOQTxCmjjCOi9hPnIap6unq+tTbHMhCX/llMqqRKfItS4yxMz+h1I
	eEUgevs12UD2JeadPnsF8TJCubMV4GeSriGUI261VqRA564je+euJXrbqZ/1LfoA
	GpD0vR7JPU3sY0gTwaFcEkIvWECoJiKRw0BCMFbXplfS/aSehDleYKvQSB1t7IWD
	fyLFXWsA8RGotGM3voKVJJT6mue2gOZLt9BMB3j817ZYIIWCxGYJ5F3+4FRMh+Hg
	uCVqCzlIYyueokxk6Kk0RZIPtJmM7DnxaoYnsmSpHASaYNCj451s9Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4642e0cddu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBkiqD033431;
	Tue, 22 Apr 2025 12:28:24 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010004.outbound.protection.outlook.com [40.93.10.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABch4ZhiDDOMa0FT7VD1vYEZuqJoRb++ed4oHHg5iNV65WA7KCV2fg6g7MWS4pn4xc5VKHYyOI90xzNfrXt0alSE58lk6+1ol2bNBrKlIzc6b5102Y0lrIhV361IcKPNwcmhb7vnnn37NOZc+FlWaKT38UmeRJz8FboJ2kdvzOjZmcxcLXy7Gkekcuqb1YomoIr0P5rVoBsCFL7GZ39FZjJT0m7UoQ+VIbZ0gkEnwips8B8IVVAFuXfF4clbIglQXTu55ahzYWp3kcgtHrCu8/l+IycOEkgCVZNFe2og7q+GYYYNCkP5gf8w9lMZx9ddDTmwew81GpUUCC1bb77VeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxdMJoQeqCXOrDgyD9sYy5TKqmgLN4thVjIqDOOpX2s=;
 b=RqYO0F9RAEaSbjCu6cDzzaAqsbUYJ0uic0ELlV4Uyo6V/T4lwWpVS5ffA+4URrqgv5mgB8ShGJ9Nug+nhEOTPrJ6PWeJ1U354Y4jK4+6/KHxM2cluJ5Mubhi+VWuA36AG3SgDsUaMMeROyO2s0Sm4RZWIqeYahc2BiapOo4Ftstyp6r9KcWu4iM1HaaPlOpPsPiKfRUB4o5n3ADJB56U/IhOeGIAViyeWTt6/QXPHsTbGfSAOOL3n2PqeMaq78xiTptFGWiQDcT5YTFGPN/jjhBjCkrvv1TMYqqkpyavty3VdJFF3Cb4DJOU3e2E9XBhCdxoURH96TxHNpyQDk6eeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxdMJoQeqCXOrDgyD9sYy5TKqmgLN4thVjIqDOOpX2s=;
 b=hThuRHRh+TqzRXUcWTHG+Sqzpj1DKEyVZ+aldZkywW8Q36OV9O8ClD3+a+mai+AZ3h3+27D3f9GlLm8PF3jXct0ACPj7xlk6GAs5VZsw1k7TM6POrInAmVE4kU74c8RLOjtc0CZcxCNevqYq7BUYaIkJAxdMP3tTu3W98e0Gd/c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7394.namprd10.prod.outlook.com (2603:10b6:610:149::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 12:28:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:21 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 00/15] large atomic writes for xfs
Date: Tue, 22 Apr 2025 12:27:24 +0000
Message-Id: <20250422122739.2230121-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:208:239::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7394:EE_
X-MS-Office365-Filtering-Correlation-Id: 136fc29c-3990-402f-84f4-08dd81992b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yOyuMQRE/5ZH0MDVjjuAOUKL4Pj+lzlYPLn/YUeeFL0vJWdaHVl54TZtNluZ?=
 =?us-ascii?Q?n/9nDGorMfhk56daP3xM5KML4dcZPCpUnXwL/7tJroh8fGmZdMq81+c2W1xx?=
 =?us-ascii?Q?CuHnnW2LALoouNqxYd2xkNnQhav2hH5TNkaZrVMCMGPMyIwmohhP7Pimdlzz?=
 =?us-ascii?Q?wf6URU4qYsTeENjf0XzWpGtkYiyA27lfSSNCGDFXKSsRbzbwI8swZr7iPxxT?=
 =?us-ascii?Q?KsQQn3kt4cmqJjIOZpLAweYeYwTYamqFs6LRStG1hSZSb05D1IvECTUX4JC7?=
 =?us-ascii?Q?2XlMcYxUlwKMXWO9yTTR08Xzv/OWU/aFeyCC+HsAt0k/SoYv9d6yWbwKiNRV?=
 =?us-ascii?Q?VXYuXqXVBioUA2oQJeZH7/PjwMYOVPYnj/SDduF1W3X08Ecb7EzJ40fJelTh?=
 =?us-ascii?Q?sOHQwo65ilFQj5TKgZsl4cK3tucT7XUjBsg2xV0WiGazDygCHN+o+1EOuHl8?=
 =?us-ascii?Q?7oCBDw5WM27aWddxlOgjpQFungjbZB3ZFAoxMvkN0SyVqyTMc7weROsVRJeQ?=
 =?us-ascii?Q?Lk/ZuRyY19rc51Ui/5mCl3/zse9Xsjz2dEWrGLErWnOE1iQ61CxHNg0IA9hQ?=
 =?us-ascii?Q?Asr8ITYU735VYXPW0+lrJ+yuEdztue1fEcOYEdsNjvTB1W5TWoao3HY4wRs5?=
 =?us-ascii?Q?LX1hah6WGz/aPPlYTegUUOChyVwXiojUPYTfoMOcH3yTj3Jsqb2AQxIQjKqm?=
 =?us-ascii?Q?4l1aQLDN/AskvbEJdDpSFHUBIKy/ak5T/tOaylhrjs21BOPPo0jZb1dVxWCs?=
 =?us-ascii?Q?FC5OCa2AjgKT7ydt/hOrI8Q+c9+pYmsonSYK7FFn+oQCYV4gJpJwNBfAvnfG?=
 =?us-ascii?Q?XEIFZgXWsQBoPFgWp9MdTq41o+Vwg/APUgi+YpVv7J20yge+hSOlWgk04RvZ?=
 =?us-ascii?Q?MRlg5c0ui3wXowdL3J0ta3jgm2+nYjYWwjYwBSu+SmUi0i7Ji8VgKHEEWhZn?=
 =?us-ascii?Q?t5QcAEKWzZAA0xU6uShA3WdlxBMeK1ImFAtSSOHCRbfHeco2ToLFgJcR/Goa?=
 =?us-ascii?Q?mAiIbDIxZlMghDdbcJ6dk3wGHlNwHp+HvORAQ7zGdNkLa4orSMYqB+U1sU+P?=
 =?us-ascii?Q?FqvkEw9bVNUCMiUxeSshubrfszkfxkxNTgFSitqfCQbUhlztVK5za06W1wmC?=
 =?us-ascii?Q?k5bz8SpjarU49qSETa5A/yfWr3QjGRH8mqdISaBSJmilCwcuiZVdKNdD9wTf?=
 =?us-ascii?Q?f7vajdMEAeUGi89BiVdQKKBsuUFWGZZ3H+AxfctJTLXa16PfbQJ1ik2y68WB?=
 =?us-ascii?Q?o9HK8dpNPyXx3lksWTwP4QsIzYba+Y63BD3myoRm3WE9sEL87urZpu2qB2cb?=
 =?us-ascii?Q?F2UGGhl6lW8rdB2gGyUDhZ5glWgCsJIx4vgU7RZG7h8ziQRo00DtsMlWoRT7?=
 =?us-ascii?Q?XB7WG2Fdw1A5/uBTkGtlSxODQ8+Eys0DUVVpfEkrIaF+g+5MX1IAN8NQBozk?=
 =?us-ascii?Q?z6jch/NK/FY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U4CednY0dyYFL0f5yd88xgaLvq0Xde18tczWn57E1b6WSEoXu9I3a03RyZs4?=
 =?us-ascii?Q?eib5RfhB+2PCWsY3/nTZ445Rw2SrQ4BHzW3kEtPV65tSrn3rQXYghFXxm/MV?=
 =?us-ascii?Q?AFUwJXLG+gvx76Xk/xMioGPYh+0g3oEfhcP9nGo3JLIBdM/4K/7R3xm9ubJO?=
 =?us-ascii?Q?JMs37/0pX+INPACVK2XuhvuwrHUyO4RcVj/oF5VJhhunS4DaWie4ywfZ6CHZ?=
 =?us-ascii?Q?mlF83eg5d3rKX3NVGOeQI8sLKQ45c3Elw4/fzg8Ns5t6OHeXpAfG9oa7bbnd?=
 =?us-ascii?Q?JEiZQrLwlL/vl5f7ohVvQQYsk11FGokLmN00F8m5xJEq39LF2ClmmSm/1dvr?=
 =?us-ascii?Q?LdljjGbsYn80DTE4KCrm0ZLPmh2fRib5BdJegAI7XyzeLVhBf9T7eJWNrE4J?=
 =?us-ascii?Q?I3Wb+H/AMLmDNU1wTibg8+fLN1RHYLEWoNiyXEW6ozct9usRxCFvD0yFVOga?=
 =?us-ascii?Q?tNdISDwoLi8XO+4a1H4hYtUP9GPo0lZ1qAR7VcfymAlKpKSDvwrD19jientP?=
 =?us-ascii?Q?tRz3m/heg5Opq2JkQLASEYByTD2rsvM6M9QhoMoG+fCq9nDaqynCcEn2Acdn?=
 =?us-ascii?Q?Ah3hxhZ8D9mm+HhzjE2JykJor5zZEk08uXWdQqGvKWO72C1h12JuHk4uUyCw?=
 =?us-ascii?Q?cq6kM/kdPXpypdaxas/jbRedoleTFZHTW1odCWUE9lfEEVsY1TF0SPU5m1Cv?=
 =?us-ascii?Q?B6CaOkXWw68/u6cv9tvVbsUz3AnPluIVPxgfOUKggZOZsoJKjRWhsPE0Jt8P?=
 =?us-ascii?Q?o0qOhhX88EXK4QtK9itfxe9zWM9Jt3n1uUuhcr5iD7MLbbeSZ1cMKo1aFncj?=
 =?us-ascii?Q?cPeSbmEYYbuCqN8o39X4zxkNKQed1cvXE3cCG73j3qTqc+aYJ+YIt2XvfsKM?=
 =?us-ascii?Q?jbMTvjk0tIVbeB1FFH5V7Uc/+6GT/kJG0SMMcTA+UT8h0JZDeeIl/CzxNHiM?=
 =?us-ascii?Q?zZzRQZIQ/f6B1jhVDPn3za5oB2RtdHO3HKU9KHKimiW09wU2tauNa/m7Adof?=
 =?us-ascii?Q?cFxtE9B8oAvaR9A6BP4XXEuYXnmGoa4XFyCR6uim7MmCRd22/k+ukbF/oSke?=
 =?us-ascii?Q?B9KDKR7mIKf1cRzL23kNcwwFuAvYHUasRZ4V9KkcGKXHHaP5btwZt91599BB?=
 =?us-ascii?Q?QJNsBx/xleaYGY7QJcH8rc0QCXGpsvjvpLQkjpZo2xfB2ybFWEfdmyabillc?=
 =?us-ascii?Q?Op6Xh7AL1Tho0CK4vdqLvgItqHUYWaflHjPicNIUELJRMdARRrsnXCPCy+Zu?=
 =?us-ascii?Q?2QZJQkHSNeI+y5helqE7gjfUnpDK9sw7k9RzO8XP/OL2oCat1QAUVybIH56L?=
 =?us-ascii?Q?mxG76JbR3J0ZabWdy9F/BqYjAGgfai99j2bq+HMSoZk9VZClTrKIKTXgd+if?=
 =?us-ascii?Q?7rOnYxKyrC7SkZ9nCBgI/bXFtOV0mBcQr1ueQWVWCi/h43SvbMK7ku9RuVLz?=
 =?us-ascii?Q?tA6p58NjvExGq9iCXXwWdMONL3f2VZta8L4dv+lmryz9efa/oR2onNlnCZO8?=
 =?us-ascii?Q?k/oAmB+0904CDlRJnPIN+uj8uW5KK0oRnXjT3mxjUYj3jJmEXNCUNl879YyM?=
 =?us-ascii?Q?HyQZbMRlIxZTLcsSfYTzFyDjaVWTly3NDIW6r1ZwJ61calbRxONxZWQOjW/Y?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sWyX+uWw+WkmKIdhzg7DCiOy+oafrC9WPcHjYtuiKnyywPLA94+zQsMaaUSWPJZKDA2Rtukdmciv0/NMvY3Z4ZsCcMxgM5G6OUEhOQ474C/T9USs/7P5adE0yodvuRLU3qzdjLm1ToScghLZS8Fti1D9OgMj4lTcZzil7qqyTfrjQqZ1bdp4z3FUj/IMh8GEMxwjQiAeVZIwmf2cxgNaIrCx6Wf74C2QFQ/HgPViYx615Vyrz+H/d14OTDMD1ePHWw0F80UCLpXUEt4jPAeodiowkgVPPmwUva2KvVUauVN8Wg8TdNI3vOQHR5uNoyJWwGWNkExK/Q9wRsAnDjCG7jBwF6DHXODd3DbnIqzg7dCdOqQdBa2As6MlaJv7JTqfvTypEgLC3Jmfikjss0PpBVRXv4oz7yO4fWFnb2np5yIhpH829gSPhRPvmRClOwNEFzheXHGtsf8Nx3cVCo8R/K1ToSC7BvUAR/rcqlcy087a7vId7BRTuj8bM5smv6oW6Xf9LU54NWH1Yp5aMdpsJd43JVzKCq1vg6y0KYrjsLnHuofzYTFKTrbNPQFtwlpLNq0rwrVA2w8MtCWXZRo/i6PW7rARbvTmhR2feI02H0g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136fc29c-3990-402f-84f4-08dd81992b71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:21.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CLQMONavPyKs+VtEvVX0Q2MhYeqJW+TZnLc4iF7vBzaXdMp7OstfE3tTRNowsPGoiwD9V0m7ylZIkXA9aq8Gzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-GUID: Qwpl9lr4G0n9QElNW-6O88j0Tmw8TdMT
X-Proofpoint-ORIG-GUID: Qwpl9lr4G0n9QElNW-6O88j0Tmw8TdMT

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a
software-based method.

The software-based method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For xfs, this support is based on reflink CoW support.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Catherine is currently working on further xfstests for this feature,
which we hope to share soon.

Based on c7b67ddc3c99 (tag: xfs-fixes-6.15-rc3, xfs/xfs-6.15-fixes,
xfs/next-rc, xfs/for-next) xfs: document zoned rt specifics in
admin-guide

[0] https://lore.kernel.org/linux-xfs/20250310183946.932054-1-john.g.garry@oracle.com/

Differences to v7:
- Add patch for mp hw awu max and min
- Fixed for awu max mount option (Darrick)

Differences to v6:
- log item sizes updates (Darrick)
- rtvol support (Darrick)
- mount option for atomic writes (Darrick)
- Add RB tags from Darrick and Christoph (Thanks!)

Differences to v5:
- Add statx unit_max_opt (Christoph, me)
- Add xfs_atomic_write_cow_iomap_begin() (Christoph)
- drop old mechanical changes
- limit atomic write max according to CoW-based atomic write max (Christoph)
- Add xfs_compute_atomic_write_unit_max()
- this contains changes for limiting awu max according to max
  transaction log items (Darrick)
- use -ENOPROTOOPT for fallback (Christoph)
- rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomicwrite()
- rework varoious code comments (Christoph)
- limit CoW-based atomic write to log size and add helpers (Darrick)
- drop IOMAP_DIO_FORCE_WAIT usage in xfs_file_dio_write_atomic()
- Add RB tags from Christoph (thanks!)

Darrick J. Wong (3):
  xfs: add helpers to compute log item overhead
  xfs: add helpers to compute transaction reservation for finishing
    intent items
  xfs: allow sysadmins to specify a maximum atomic write limit at mount
    time

John Garry (12):
  fs: add atomic write unit max opt to statx
  xfs: rename xfs_inode_can_atomicwrite() ->
    xfs_inode_can_hw_atomicwrite()
  xfs: ignore HW which cannot atomic write a single block
  xfs: allow block allocator to take an alignment hint
  xfs: refactor xfs_reflink_end_cow_extent()
  xfs: refine atomic write size check in xfs_file_write_iter()
  xfs: add xfs_atomic_write_cow_iomap_begin()
  xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
  xfs: commit CoW-based atomic writes atomically
  xfs: add xfs_file_dio_write_atomic()
  xfs: add xfs_compute_atomic_write_unit_max()
  xfs: update atomic write limits

 Documentation/admin-guide/xfs.rst |  11 +
 block/bdev.c                      |   3 +-
 fs/ext4/inode.c                   |   2 +-
 fs/stat.c                         |   6 +-
 fs/xfs/libxfs/xfs_bmap.c          |   5 +
 fs/xfs/libxfs/xfs_bmap.h          |   6 +-
 fs/xfs/libxfs/xfs_trans_resv.c    | 332 +++++++++++++++++++++++++++---
 fs/xfs/libxfs/xfs_trans_resv.h    |  23 +++
 fs/xfs/xfs_bmap_item.c            |  10 +
 fs/xfs/xfs_bmap_item.h            |   3 +
 fs/xfs/xfs_buf_item.c             |  19 ++
 fs/xfs/xfs_buf_item.h             |   3 +
 fs/xfs/xfs_extfree_item.c         |  10 +
 fs/xfs/xfs_extfree_item.h         |   3 +
 fs/xfs/xfs_file.c                 |  87 +++++++-
 fs/xfs/xfs_inode.h                |  19 +-
 fs/xfs/xfs_iomap.c                | 191 ++++++++++++++++-
 fs/xfs/xfs_iomap.h                |   1 +
 fs/xfs/xfs_iops.c                 |  76 ++++++-
 fs/xfs/xfs_iops.h                 |   3 +
 fs/xfs/xfs_log_cil.c              |   4 +-
 fs/xfs/xfs_log_priv.h             |  13 ++
 fs/xfs/xfs_mount.c                | 162 +++++++++++++++
 fs/xfs/xfs_mount.h                |  16 ++
 fs/xfs/xfs_refcount_item.c        |  10 +
 fs/xfs/xfs_refcount_item.h        |   3 +
 fs/xfs/xfs_reflink.c              | 146 ++++++++++---
 fs/xfs/xfs_reflink.h              |   6 +
 fs/xfs/xfs_rmap_item.c            |  10 +
 fs/xfs/xfs_rmap_item.h            |   3 +
 fs/xfs/xfs_super.c                |  58 +++++-
 fs/xfs/xfs_trace.h                | 115 +++++++++++
 include/linux/fs.h                |   3 +-
 include/linux/stat.h              |   1 +
 include/uapi/linux/stat.h         |   8 +-
 35 files changed, 1272 insertions(+), 99 deletions(-)

-- 
2.31.1


