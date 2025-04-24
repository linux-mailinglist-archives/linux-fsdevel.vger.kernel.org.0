Return-Path: <linux-fsdevel+bounces-47296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B73AA9B9BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020F81B87822
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306D728B50F;
	Thu, 24 Apr 2025 21:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="igE9pnYi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y4iLryNs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A203288C8F;
	Thu, 24 Apr 2025 21:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529362; cv=fail; b=pa9EQr0Uzc2Bg+dUXyMXzjSAX1CN104JjIHeyrWDHXkP/fl7kXFRGctakeLYCMnpyao4xd7h1s8dOhRDFgJlzoHZb9UXm6fcHnKHAIbkWn8+TowxzSAdaMd12wVj8T9flFVol1c8MWWXLgkkYpfN61TsNJEpCKm0MGDEdzgQcpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529362; c=relaxed/simple;
	bh=/yi7o3m2gCzu3ViZvSikp4N29oXl3n5xDg7+IqxRItE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sX9fRRQbhzgUibbsiS9iXgqieYGxkfq7Hsb6kRj3xxdei239jfW+AaXwtuZlkb+OwxIVuhq8WjKKQyKumIFNYnPrPR39whV0wBPQ3nEb0AYbCsLO+N8KYDHXJcWO+GtLv2mffF0AHWKq0MfMQ6xid1CGMI1JrW92HeQd3hhlfxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=igE9pnYi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y4iLryNs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OKv2rj013529;
	Thu, 24 Apr 2025 21:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BroK/C7XX9pjO0HOQ6onmq6GTx9AgXcSxQpVJbpzmMs=; b=
	igE9pnYiQDVqFjivY8BR8sdCJHBAl3Xd9yFulmlHVntFkqd3DZt891LSmy+97Iq0
	s0zi4gJxmaV8w5q+/xzlIfcviRL583cVxDvTVTpizhOhRVplCn4P+b+vakjK6/q3
	EU3VKn2pRjCrZNF0PiQvGwsZ5tnUL23P5xVZBaq8Wx/UaCIr7ct5DPzleM6SBwqG
	BLbTCB3F3D2fe5S6jYwDWpdIbTKYTHCkXgJlgdh8cSQfaZyZ+EkY+rdH5Gh304ix
	DZ4sKAKuFc5ReKt0HBRYZZ/zkI3wsy42vGEcL9DIHm6SVcr2+hV7Z7wBAVT8uj2O
	ue5ZgSzTEXsWRHdtZF6R4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467vsjr19g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OKDmsw014191;
	Thu, 24 Apr 2025 21:15:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxquc2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udtPvooC4tuip0Qoyb5rMOqPmzocl9VVLmL23ju5B1fYsuP8E4yoainNN+OlIKZMkeBpyQI5TEZlWigRjv401hXUKCdF+NiaxJ1T1watUp2SwEWgszSOEvHzou31PhCYY6ODSbzAdhTki7T78nnbINp2Lqwj2DUfzBw8Zh1ldNAFCaCo8foeUfG7E6x13/0BvrbwaGFxe4t0ksdIgMahNeYcd95ip2uZYdbutFNoKnqE/QMSsj0wtek7HfkEIG8z2gLM+Q669wAGtIcIe1SrZg6+eu/J26RlcmYutjQcdeavfa+8eXvL1Og+PuM8HVQ1ACoXstOFM5gUi4RFt97GGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BroK/C7XX9pjO0HOQ6onmq6GTx9AgXcSxQpVJbpzmMs=;
 b=r0GtwJCRLi/x1Zh9JztDcYataiDNXYMhJViDY5RWOhZzJLoTT5/6GmxP/nHdZk2yIFjz2P+k3ItPaIELjuRMjoQT3+n3Q+81AlRhcndXiEiR3RC0u/ZdIIlFkJFq9jQWFnUuLNJy/nrg5uCyjNm6cu6q5gU20YCXFxSJQn+82Ebzk48+b5M46oCeWczbBFNydniyPfu6u0SWmQgCSGaFr43aH3JGUw203cUnI7uSCB+pY1gJAlN0mfIIyJNP302ZgFo216aSDSh3CTNvP0x5F1XVhnCQkv4Xo7YxtbFV6DemKSV4bK4xJqDYHDK4Twjpu5cjJWEjQcyB22owIOjk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BroK/C7XX9pjO0HOQ6onmq6GTx9AgXcSxQpVJbpzmMs=;
 b=y4iLryNsg4glhTh1trypsD+3h6rZpkvn/MzH8JO/ffQTUoztPFXBWiBgYwVb4KG1pUXrpu8xwh27e6yOmndP7nRPKRU2071EsEqo/XAdhjekVE7YcCPeR3T+RmnwrgmZ7C9e1mLHh+H954SxXtbpR6v4PYyjtVa8DQAnHpNzjF8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB5109.namprd10.prod.outlook.com (2603:10b6:408:124::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 21:15:41 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 21:15:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mm: abstract initial stack setup to mm subsystem
Date: Thu, 24 Apr 2025 22:15:26 +0100
Message-ID: <e7b4c979ec056ddc3a8ef909d41cc45148d1056f.1745528282.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0279.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::14) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: d960741e-87f5-4cee-9112-08dd83752b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HLnE7yn6qwSres6pICi0cBBUcgksVMg1gf6/DxYLOl1WYEKhYWlnrFmH0t0a?=
 =?us-ascii?Q?3VMhFoX5+SHEpxjrcf6ed1+EvhEU7M6CyzJuagEI7w7u9Nz3PdHc55hNbxoD?=
 =?us-ascii?Q?D1+ErDEd/hHPS37m6tIBWEhN5uEKVm0xKx3sNmRT3ubsbGYpqcaZLTuaDdaT?=
 =?us-ascii?Q?n6Xx8dpH28Poy6XPqqA42Hzx8P2y0Uq503ka9Mz66sus5BE/dgwmMZy9SISm?=
 =?us-ascii?Q?xBf5bqdDWUrTx00l4PBSMgh1uh/Cvfn/U3IkDhBl7JFVGimGUmQE2aPHPmhV?=
 =?us-ascii?Q?aCXvIKQNM8KJ6NyGU4Lv0UuIIv1O8im+SN8L930NZFEwBOGCZond6Ru2TbpK?=
 =?us-ascii?Q?XAnSgZ/KY2VTeIukqL+oTA6PXmjNCnZXy0DlBOALYeQZiw/S7kauMKu2R68G?=
 =?us-ascii?Q?yNT2N+0U7fJscq/Az0EbgDYoo0urrWKj4OS+unwBjHHwSZ9m+V9DU237dOvF?=
 =?us-ascii?Q?qplU2WFVK/kZPE5zlsDQ0retQZE5AyHwt06TmmMCT+WUM2jI43JXHPJ18hcO?=
 =?us-ascii?Q?fVWS4VpZOh8pf2kpOOgtnINSamnYraYoBuuJz5OtQcUrlpUCdrTNQzbC2WMI?=
 =?us-ascii?Q?QnNfdNZ8LUxQzcb9h7Wtk/j+nQ+sTlZVB+nTFpKy9dxXCJek3btx6kvbDE4f?=
 =?us-ascii?Q?5k5ByMyOiRJ00CcXDEBE2DXkXzny25yu/+SpJL1eD67NWVQAOrjbD5eYDi9M?=
 =?us-ascii?Q?mZ/peD2Npm9mdY8/ekee1+7ZYKvbIZVIAjkvzawcksec2vVyu6o5PD2j78Fy?=
 =?us-ascii?Q?QL5n5DkoHZwpsCbykRtoznuZpFndxfVFHr5v6cqGzaPz+Zz3Cd6tZ8wXpgqL?=
 =?us-ascii?Q?fxtmDbMBHr9cASWBtTeibBgsnUDTkNt5tEy2lmUGtTzB1HLUcZfZ2WiYDv6U?=
 =?us-ascii?Q?HArwOQxwhVS/ep/5KCZ9HjQFfraZHzrde3TsJtxq9v96l73RB3DxFVjADBMf?=
 =?us-ascii?Q?jUru1l6VYZvwp347EF+lqYrrcOlxncklvq3JpQ8Xh9B7B2jEz+mz7DwDDksa?=
 =?us-ascii?Q?ZEbDRuC91uSJFIPU35h/yMTx+WlblmWttKgxfPJcdkFUDUuiFTi6sL25xlIt?=
 =?us-ascii?Q?A7+cQMZcwyO4b6kRv4vqRM7puYdwQgTTz7zk2jDtyv1hjJk8Y0YsMpvtD/Gp?=
 =?us-ascii?Q?AXpO+nOc8q47kAdlO928yGU/v/G3invVrahO+27NkqtO15wjxKMLCJ5s0XPb?=
 =?us-ascii?Q?7MVspdmon49tpFVhHJBgFj1ih+BfUkB/7kUArlucHRq/0+X4FNRIs4dV7JOK?=
 =?us-ascii?Q?xzsMT4yncKVHFoLkD3Zz109MugRPgtRNioSYMatlj02lfUwwVhSvoJCFmQYg?=
 =?us-ascii?Q?rb2kPgNb4wp9z0kghC1FLCdyTs4AGviC8FA9sKjjLe5NRGjVPduJfRXKk+AW?=
 =?us-ascii?Q?w0HJbmQX91UFI0X5EvKHtI0mVnNt+S1YN2/1fok3AQZQm3nVLSbWIKK6/XB8?=
 =?us-ascii?Q?5y2lD6DjclU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ezg7KNLvZ0B6sDSQhDw3oHnuJpYAtKvX9fsakvtIl3IcTBVGf0hvcJi8tVGl?=
 =?us-ascii?Q?u3IMrotlIe2MS6pPjEPeXXYeEWcnx7gv2Fy2IQZQ1pgjhR9CbwscCnhlf7Ua?=
 =?us-ascii?Q?b57vRzKN5PW+ZRIVRViC0euTzJDtTleEiDXGYUe6gGhjPjZ/eZZgyDYUO45u?=
 =?us-ascii?Q?UglrEuRaAgNMLz/SxBVgQ3J2PS1T5IJRpaEI54FYC0qCA3cG8Sed/TqyMaWX?=
 =?us-ascii?Q?S8rN0nT/OHkE177MsSu5rU6wRfjzMtRLqy1ulNlDRpqAQBKqL+DKMP5at9Am?=
 =?us-ascii?Q?MgBgcM/+rt6RTKtrT9TDQssU/AmID1DMIDl92XMpL6qABF1pECYUYLc8W60A?=
 =?us-ascii?Q?Q8iOyDH/h9DyeiLKMksbD/uS6RHevUPTK3JeOCqGTVbsyvmOHfEHgYHm0XjX?=
 =?us-ascii?Q?E+gC9DkPGrEoC2NVRfCmAbPJ+xNgH1+fChAy9CxplxxTgnQt6mt2vbSVgxIt?=
 =?us-ascii?Q?sB47+cdqn/LkqgqXSsf76cFhcqBkeXt3AizjH8Gvkuf2oELG1b8eUVQHptok?=
 =?us-ascii?Q?9kES1bZqETElv1CxV9iuVSGMRo8VtWaCLJlD1U259CagW0KAj1vnlG4QHAf6?=
 =?us-ascii?Q?Fcj+58NLSBMGO3n8VS07vREfFnyZB4Zk5yRq7HfA1NvtSrNViDpH/qE1feA8?=
 =?us-ascii?Q?0kCp9aNZtp+oauET1T+bsSZzMhOCXrDq3sSY/YTzLWsyigx1q7El3WRZpTcA?=
 =?us-ascii?Q?TLDpTGNfH6fRnkwELhqk1iZoVrzrmZydaVbrPHQIqFPqRQktbGIxZ/EPPIU+?=
 =?us-ascii?Q?X/vNbxP6p78NV9S58qmRcLcIZ7yE8AQjPtWBABJkbzkzbQx0R/damua4SDeP?=
 =?us-ascii?Q?LbxZAUC4S3P2nCX2rtf0j2/Yio8JGWIssATG5ThQSGVbK3WQcYE1R6dds6cx?=
 =?us-ascii?Q?XoDS99EoSA7IZdqos3HckcZNYxc6HX3WbiXRv+htNZuKz1K5rq5Lsx8w4Q9J?=
 =?us-ascii?Q?2+BSVJo2fUJ4ry9ZnHK338jXxmmTsDPlHwcbsGMdpZnm5Pe3bLpslUHAPyXY?=
 =?us-ascii?Q?SAi4JBVeIsTl6T7yEkcOyDCkduCdcQc7NfQqM71DwL6kADMby9Cq8gPHJwav?=
 =?us-ascii?Q?Hb8C1cRmvIpy9sQD790IsWRqt1d9XNnVX4rDkOKIcPr3AK61bjJb0se+polE?=
 =?us-ascii?Q?xQpP3Y76bC3BgMtdJ/9otdtyfHF7rgxf9gQmpl8tCQouYtlG6QhE81+eBH8Y?=
 =?us-ascii?Q?xG7Lp+NYteYYWuTjKhV5qiGx0ruOd7Q4y8ou0y5wxx9IoZ3mLLm0UFz7CCtr?=
 =?us-ascii?Q?VwT/+4nsEnPEg1Yx67+uKBM9m+2Dh6dscbRCE+f3JKJapwTyah0CpxY1IAL7?=
 =?us-ascii?Q?06/rNSTuuMS+440p+MzOFYM8O19SetMia6sMWNhunX80ny2HZ6G5IqJxlHWH?=
 =?us-ascii?Q?ZAppsebEXYf/HC31Iqq8KLwQ1dhCEv4Szsc2y7HFzk0pEx3JdE0DbLBBFtNo?=
 =?us-ascii?Q?GgXcqNJXA2zzy5ZCwRlikhH1XMlbAwWSexFTksI328fqD/Xsl1qyrMXEw1ht?=
 =?us-ascii?Q?Tjlfw1FggoXR/Z4t/ub6deDeSJQhc97u7CP2afu+NpHD8035Vz/nNTRDf/aw?=
 =?us-ascii?Q?gsOvRHOlk6Jv650MJaNJr+UFhKhJHhENpgz7CqkXJB7BEYVek+DAgT/FqItO?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hrKvr1P8zT0a+3XNmKvkpWErSCFiVnSotUuzdtFNsS9TtF6AYmzW4KCbCZc8bAAUm8zHtAqLRV2VMIVgO+a8VTWMOhk1SnPc+p6Vc7VsKWm0GTcUAAFYbcfQMl5TqFVUbp+/i4sJM5F99Haiag0bGq0/Yut4CTg0c4pNCLIBbR8KV3otdP/YjmfvZ9gYsDJpeFas9clAXGVhoTwB6tHURbeYlPVEXNLwFcS5yibsPb3Eh2Tx6lF/6EESwmINlbhcIKq7yvVQt2Ogmv1efgYAUZ1z1PHTo1MNRTnscUq7KfhyQIqrIuLcVZHH2+Vrwsn2wNPDukdvtz0orlSU/GgQP0t9+JYOSJEWm3Wi36SnmVnYBzx9AzYisjg5i4MHVm5hDSq/1wHWsJgv8SYOinsXgAgnJtJpn5lLxAmU7ayJbL01E5RN3AEZGX78NU1T/xOER/MIrjRgciMuOJXsS+ytW80BU3vax9hvW82nuzdj3pLMmx1pHcN512EmkcxEA4axQzdSTmoRplMSKstQfzQu1bBku+gw4Ynm3CNxsepX3YWqa76dQmZK4DJ+VqVNrhoeXa+/ePgf3brmfa+riUvJpeJOBR6Pkq+jm7njWt8VPIs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d960741e-87f5-4cee-9112-08dd83752b35
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 21:15:41.6468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W69SyXgpj2JKTvL0/w8fIwnORBZa7knWaU+P99tvqtl8+YhFiyLHKIGLsXIlPNgQl+PdCt8p6K4zqLp2U0o/kCvsvWnGkZXoFkOKY3F+PoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240149
X-Proofpoint-ORIG-GUID: -9YNGb4ipC7xdNPXPM5pBRmUXfYEeS2N
X-Proofpoint-GUID: -9YNGb4ipC7xdNPXPM5pBRmUXfYEeS2N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE0OSBTYWx0ZWRfX5jdlSn6TrPOp rzRrWMzStkmpnzuKES392B32LlwatQ3nx1dudcuia8nhZEV76/w6R2bBxvebc7fEMTDI7XyHHtN k1U3Twn7CzxaLyulrcA0XbB8dJGjeuwHKpgC62l3exbp44IN18/7n+Cqpb/1Cs1I2R3sbaOjX6j
 7aP4MdQmc1V8xzLTv0eYBtNPObAAsvPljNB3zGOKSQIZWjwTvH3D/r74gaBQJ8/z/TsANY4PsWd yWbF3nSWtr8PECDgBIs/IBVHlamdK2Wsaz0fiaT3BXanDzTEpu4yISHCGUA8TVMlpfa97qK0EyZ 4A2+RAiducFIsE8YGfDVEIuhjhiY20hyK7Ii64o1/rj6nEQb75NbLOKM0vd7TWw0MqXG3SUM95o 0dfHAO5W

There are peculiarities within the kernel where what is very clearly mm
code is performed elsewhere arbitrarily.

This violates separation of concerns and makes it harder to refactor code
to make changes to how fundamental initialisation and operation of mm logic
is performed.

One such case is the creation of the VMA containing the initial stack upon
execve()'ing a new process. This is currently performed in __bprm_mm_init()
in fs/exec.c.

Abstract this operation to create_init_stack_vma(). This allows us to limit
use of vma allocation and free code to fork and mm only.

We previously did the same for the step at which we relocate the initial
stack VMA downwards via relocate_vma_down(), now we move the initial VMA
establishment too.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/exec.c          | 51 +--------------------------------
 include/linux/mm.h |  2 ++
 mm/mmap.c          | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 50 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 8e4ea5f1e64c..ef34a68ef825 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -244,56 +244,7 @@ static void flush_arg_page(struct linux_binprm *bprm, unsigned long pos,
 
 static int __bprm_mm_init(struct linux_binprm *bprm)
 {
-	int err;
-	struct vm_area_struct *vma = NULL;
-	struct mm_struct *mm = bprm->mm;
-
-	bprm->vma = vma = vm_area_alloc(mm);
-	if (!vma)
-		return -ENOMEM;
-	vma_set_anonymous(vma);
-
-	if (mmap_write_lock_killable(mm)) {
-		err = -EINTR;
-		goto err_free;
-	}
-
-	/*
-	 * Need to be called with mmap write lock
-	 * held, to avoid race with ksmd.
-	 */
-	err = ksm_execve(mm);
-	if (err)
-		goto err_ksm;
-
-	/*
-	 * Place the stack at the largest stack address the architecture
-	 * supports. Later, we'll move this to an appropriate place. We don't
-	 * use STACK_TOP because that can depend on attributes which aren't
-	 * configured yet.
-	 */
-	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
-	vma->vm_end = STACK_TOP_MAX;
-	vma->vm_start = vma->vm_end - PAGE_SIZE;
-	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
-	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-
-	err = insert_vm_struct(mm, vma);
-	if (err)
-		goto err;
-
-	mm->stack_vm = mm->total_vm = 1;
-	mmap_write_unlock(mm);
-	bprm->p = vma->vm_end - sizeof(void *);
-	return 0;
-err:
-	ksm_exit(mm);
-err_ksm:
-	mmap_write_unlock(mm);
-err_free:
-	bprm->vma = NULL;
-	vm_area_free(vma);
-	return err;
+	return create_init_stack_vma(bprm->mm, &bprm->vma, &bprm->p);
 }
 
 static bool valid_arg_len(struct linux_binprm *bprm, long len)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9b701cfbef22..fa84e59a99bb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3223,6 +3223,8 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
+int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
+			  unsigned long *top_mem_p);
 int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
 				 unsigned long addr, bool write);
diff --git a/mm/mmap.c b/mm/mmap.c
index bd210aaf7ebd..1289c6381419 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1717,6 +1717,77 @@ static int __meminit init_reserve_notifier(void)
 }
 subsys_initcall(init_reserve_notifier);
 
+/*
+ * Establish the stack VMA in an execve'd process, located temporarily at the
+ * maximum stack address provided by the architecture.
+ *
+ * We later relocate this downwards in relocate_vma_down().
+ *
+ * This function is almost certainly NOT what you want for anything other than
+ * early executable initialisation.
+ *
+ * On success, returns 0 and sets *vmap to the stack VMA and *top_mem_p to the
+ * maximum addressable location in the stack (that is capable of storing a
+ * system word of data).
+ *
+ * on failure, returns an error code.
+ */
+int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
+			  unsigned long *top_mem_p)
+{
+	int err;
+	struct vm_area_struct *vma = vm_area_alloc(mm);
+
+	if (!vma)
+		return -ENOMEM;
+
+	vma_set_anonymous(vma);
+
+	if (mmap_write_lock_killable(mm)) {
+		err = -EINTR;
+		goto err_free;
+	}
+
+	/*
+	 * Need to be called with mmap write lock
+	 * held, to avoid race with ksmd.
+	 */
+	err = ksm_execve(mm);
+	if (err)
+		goto err_ksm;
+
+	/*
+	 * Place the stack at the largest stack address the architecture
+	 * supports. Later, we'll move this to an appropriate place. We don't
+	 * use STACK_TOP because that can depend on attributes which aren't
+	 * configured yet.
+	 */
+	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
+	vma->vm_end = STACK_TOP_MAX;
+	vma->vm_start = vma->vm_end - PAGE_SIZE;
+	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+
+	err = insert_vm_struct(mm, vma);
+	if (err)
+		goto err;
+
+	mm->stack_vm = mm->total_vm = 1;
+	mmap_write_unlock(mm);
+	*vmap = vma;
+	*top_mem_p = vma->vm_end - sizeof(void *);
+	return 0;
+
+err:
+	ksm_exit(mm);
+err_ksm:
+	mmap_write_unlock(mm);
+err_free:
+	*vmap = NULL;
+	vm_area_free(vma);
+	return err;
+}
+
 /*
  * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
  * this VMA and its relocated range, which will now reside at [vma->vm_start -
-- 
2.49.0


