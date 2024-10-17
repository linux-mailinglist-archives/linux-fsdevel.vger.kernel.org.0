Return-Path: <linux-fsdevel+bounces-32268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E72F9A2F43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68346B234C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C6E229128;
	Thu, 17 Oct 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SWnbWMSs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SCZJKgKX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF11229110;
	Thu, 17 Oct 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199209; cv=fail; b=iWDYK98h8dbvqCfCZSLLfvbyIcT225wmf56UHAfTbRFJLR9fUwaF/wgdkg+aKf8SMiOVp54NOT5Yf1LapwUGjmBLXmvum7qxWE6nY4ispaTPIQvz1v5JNIAi5c9YWletvONKMp6qkmIP5eFL8SzYuRKgsb3/xeikY2bROrrnVfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199209; c=relaxed/simple;
	bh=3w/o0TwxWEag9v9fIAdmlhVrx510+wdTmfrQQLCNC2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pcfJZ+dvTE7QsLH6acttV6fpLXvv2PtuqPVMXjYNykSrwFeNYDdUt0QlFGtlf95lw61Fb5yX4MSGiRhr18Leo+Js3AH6VM5mkqRuz8DHP0nQLE/XkO1sCkmxIbpJJYXwUszVCyo8A1SPtkjsWC+JoQuLv5emGrnxOfxkvyfKDTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SWnbWMSs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SCZJKgKX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKtmDX006167;
	Thu, 17 Oct 2024 21:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ac0PbsmCn7O3aCDPTuPoVcMPxODIiHle2QXQIdUX6f0=; b=
	SWnbWMSs2ZwkfxQn4jyryVUUrnKPmcSD358AR9f5FJbeOLuBCGGf9CeGnRUKBLsK
	UguKfOZ8xLgMXf7GFl97lOZUVMhejbfPAy+RRIYiUoST3kOTZImmQE9OqvNcoeYp
	g9WRjKhzdEA6zHp5eC5Fk4E19m+MaF24F+YF4DboUXXJ6BjCVMJA/L9U2V85t09F
	BeIT3AYo+r2UD8gmPLsXzFc6SjrvhlEMn3Owik4aRc2mh5uZ9mne7nJKBgbz869a
	Gr/ZPSTh/vFiMy1iaqHSay0SxqrgzGvxufRXQkSy6MrnZharX9Ejjfbf1hSKCWk4
	ORQxT3/g5VoAPywF9HFjZQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1aq7k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HK0rrV026193;
	Thu, 17 Oct 2024 21:06:26 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjasv6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 21:06:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksAj1cwYk2b+rMBMIlnN+uRAZci9qwFEHBEOa3NSV9WcPScMqIzXJCToE7V28MLgqlRonA/sNHcScQN4oaYBNfhnY9jsJ+75QIUQXRJSm3WG7njyWVA8MvErsJi1O6w9GiABfGCjs4jsxM8sFh1oZoVSmMko8g2UGbxhD7r/VqKTFOLTU6O8Nx3kTK2uw2o6ggjBo9uJ3iszkBQSiRgQoKGiNuhdvY2Ng+i0sca7KMRfBhC6TFOUFxoHhWJkABFfV/hxYbmNy0KiVaG26AfejZTwr2WNlwCm1oPP4IzExGgPlx9svCivAJwI1RKaLHQkMNUeOswaXe6/mMCEQsxzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac0PbsmCn7O3aCDPTuPoVcMPxODIiHle2QXQIdUX6f0=;
 b=Q5bNdY1CnelNB4DYL/kKfn6juqCeAOWESKTXZXfO+AMyYV+1aBfO7OWZBKKb3NQVaBteDzARTfwc1mHUnbA0sLHrv08Z8l59Tp4CILp8AX4QL9s64Gha5/U4UyWz7Ooy6YgEVmGZJMvPqrXRTuppmZGSUsDR7nIdOwTeK9X73F9k4kjG8NiwFA/UDJBnxEHc/6+IgWG8oR32IRWFqYb4kcHzeMkedFCerrYlS7dNP7UctVArexXdI9OuUGYgTSnmS2jLTRmeP184bXI1wiP9yF85dKYrS0Te5nwGPBU3vAPLMnnpc4pO9s73Ps3HtVkYtqqocm5lPfLFYNXtT+CyWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac0PbsmCn7O3aCDPTuPoVcMPxODIiHle2QXQIdUX6f0=;
 b=SCZJKgKXfn6Y+KA5StzugSf5VcLgZH5R2Lw6Vr/dj8fGjp6ciyg9XbkLiNPzoz4uXvEfvYJu7+XuOphQQkLaFCC44KHNVyQNAIKDqtJ9iBVSzfn/eEqQkHz9VxhJK457GiUoCs/oXuLjl3o8VVigydRIrst3fS3p6vDQ6umnH68=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6752.namprd10.prod.outlook.com (2603:10b6:8:13a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 21:06:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 21:06:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v4 4/4] selftests: pidfd: add tests for PIDFD_SELF_*
Date: Thu, 17 Oct 2024 22:05:52 +0100
Message-ID: <b9851fa9f87d22f352f960b847d99459ef7d74a1.1729198898.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6752:EE_
X-MS-Office365-Filtering-Correlation-Id: 8406f4da-2a84-4817-f030-08dceeef8e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3Sm9xHUjBt0S0kL0Aq6GzYagGV2NFo/AJAmkRBQr/aJ9cS+7vUYysFPv6H5h?=
 =?us-ascii?Q?6Z1B+t1Fwag5z14BIT8uPCmUcdhAXH6iC+dn4SD5ZlL1n1tunxznrOStBY1c?=
 =?us-ascii?Q?6cjrD86vhAgwGxn+u5c/ATxAq0ukNAlhY/mC4Fnu+fNBThhrMtN16fpUc7fH?=
 =?us-ascii?Q?Hj/FGIwdBxjiv1fOKLDYFzoIwtdj75o0jfjMV49UtqDxqrvdCxvvi6YvpiaZ?=
 =?us-ascii?Q?pNQukwX+Oq9aLIxWd4bu9ShD5Y+PYP3GTaJNpuBLF1/5NZecXEHcWnlxm29S?=
 =?us-ascii?Q?t97T2rVjZyNkatF+whiNKb4pUA0TwOuOzDwhPKfxoapGx7hxN1Hp5dgjUEuL?=
 =?us-ascii?Q?L5y5C7FPt3dFWQ9BwHDNFJMcEj+QFTZroWUgBsveqIfDfZuHv7fyH7izBtAu?=
 =?us-ascii?Q?xmvo/3xf2myGtjFCp1M+kXdojmkhYk4HY5d5S2QjnDvcISw2N4dRI5U/zrV7?=
 =?us-ascii?Q?NJt1J1XiKiomBLkgq2k7UAJ2LPiKzuLodCB5JT+pheT4I0VvXO7Uok7P8ZTC?=
 =?us-ascii?Q?7ofor6Wo2fdJ35DfoOfQvtW5FOudjn7CegQsvARwCIHMz3BwOQ5tpzzQPwth?=
 =?us-ascii?Q?xXcs1jxmk+jMpNfqH2ufOAi6fiXJ3zNVnYYJgLxAmpVtgtXReBIKKrLKRGY6?=
 =?us-ascii?Q?sNqUaHPSe8dbKBlh81jOIwXxkI/FGm0FMI5ocdd6y9HcYctHA2p63YMPXiQL?=
 =?us-ascii?Q?YwM4DQtZn1hRucyQu3pY5nUD8Y/OUg5Dn1w90u7CORoGPYU7RTx8y+jZQUR7?=
 =?us-ascii?Q?zpE4zuRIy7TiWlsJLHcJ9nUCEEJ5caeDgNYm+p5kkKclNz6PeU7J1EbMVwfe?=
 =?us-ascii?Q?HAdaBS1PjtL1ulshW+xkJ4HUvlxNiH0x87fYyEaLB2IwPdc7eWPT9Hk2okq7?=
 =?us-ascii?Q?iBLCH854OZ+oQNiuRADaQAOmBWJKUpJTAwMdMgdoSfsDCktYwWu0jTNYiygT?=
 =?us-ascii?Q?Hvy0a+/fML2ZogPg2IzbJm5zeLm+bJdohgQNT+j1x9UkGl9cWg08mNUp4TL+?=
 =?us-ascii?Q?EgTFAYmboXUgLS+pccnjGN6j3yaLM3cZqRmMk+ubE/wnpmRDnC8y8+BVTdTu?=
 =?us-ascii?Q?2XjzFkYFJloZagM+2Ezn84AhcoFudbLR/+lG+ZCTFKzxnhWz4pOqrrB6tjxu?=
 =?us-ascii?Q?EkbbvrwEj2ymJeCcwWT0Rp05BIzNvYkUJCH836SX7f83NA++NU0x5zydOnHR?=
 =?us-ascii?Q?+UO1/6/JcpPTMH0Gt5908NvZCEpfHRyaU7LsbsG1Xwiz+OnayAV6e/2Ochfr?=
 =?us-ascii?Q?rWs3tFQw5GertQLO1rJDsCTkkcXhb+rzB9sLS83G3dgSOv5NQ11zq2X2C8s9?=
 =?us-ascii?Q?Wzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?95/I8gP5rafzRPbJMiANvEHgDJMjZiJb5UpWbdHj+bRV3H9bZ7bIIJ6MNzj7?=
 =?us-ascii?Q?Avt7Qcie/etnq304rd8kcyRQOK5uY8fvU8Oo4fd0zBAgOSMZUz8oI2fGTdXn?=
 =?us-ascii?Q?rNxkAJXU0CT9HEH+iMaLs6pVltYDaHh3ela/6uRp2Lp24dCXRmTTuUHrD61o?=
 =?us-ascii?Q?tjxA5IOYNnd5YdGCEDUy0A6/YRaLRnTAMilj32uSBYnmcxLvQt0yOHAk0ivR?=
 =?us-ascii?Q?AuZUOE+7U/UC5dRr7OcaGkY3n/Dzx0FYGHzeKYv6xlIM4C/LAqONoiwcQTa1?=
 =?us-ascii?Q?0+LnnbsW7hnij/LI1dufTBLEtPPl69SW5JZaP8iHYgg4TzyNIkhcdzCTTv/x?=
 =?us-ascii?Q?khfwQisaX2koPkHIFdRqZgkJaxbPYkkfQ8vsOsGUgWBUt0oLMBr8OaqpbNtN?=
 =?us-ascii?Q?nbeTLb5NXMoV0DzhJeBhusH0IVHLLhxgJVGvCvf9ZbFUHsH6Qdnzh9g8rz6W?=
 =?us-ascii?Q?Kki1dOro5/1/XiaVNGOts50qMGEuD683nUSAhSmyO5MBxAX0BDBHJilkPXKn?=
 =?us-ascii?Q?viSvy7hbYbzn2DhK9nBNcWjYaFDodS26+i8GIDV9YS9QfWqjUCa0Ip4MCe9O?=
 =?us-ascii?Q?wGNA8+SLAVRvzADi7sQZgKpSiByUMIlY8oVham0lEOTggaGSF9O3YcrJ34sG?=
 =?us-ascii?Q?l/8xoVYo8e+SzxhVf4h/gZ3HQXEHVP+RUE7jU+Bb+2KpZI94aXx4n87uEYm9?=
 =?us-ascii?Q?UW4a5Fyseux6fU5wETTHpKCjvmby3Mhf54ncxt7oTLAIJufcYf3ZL1YggRYj?=
 =?us-ascii?Q?cJRFTz+YA6syWY9fcUxbP1eUbWvrtnIHRzBibwOCSqEh/aF/K6Ns7VQfMwTY?=
 =?us-ascii?Q?SWYiAZs6V9VrUdiUtEYDNbqpi3Xs5k2OLXg0m+rEsOCbaf3UGHoWcaS/0HQi?=
 =?us-ascii?Q?Xw1NRxGCU/jFpAfHx9yAOtUv7iBNJtJ9+pxj73nEs3IV3ERNQ0Qg7Xkv8rM9?=
 =?us-ascii?Q?QaFm9e0GqdbD+n13yMr8GWYWvYBGyocTTJOsxaJNf4i5+ivWJkyfl9iEyp+r?=
 =?us-ascii?Q?J2zToPToNW/QkKD5ges9GjrkDsAYqj6FGCdt4EvFNRBZg2hA99Wdb+a/QHz3?=
 =?us-ascii?Q?Vqe14pBRrXwizyAOxplbaJfIOTf4WWRO7M1zXjKSsPZObvBRUz7ZGp7vahMT?=
 =?us-ascii?Q?Rsx8IGPFZBu4OcCPmtiaEks6g0eoEzEmex8CW9YfnXo4yYdIZsN+Cl+jls1Z?=
 =?us-ascii?Q?z1svwCIDy7VYuB5nqJ9wYzsn14yagU8T/wKWqgIhQXv22Qa3NGmafzlRKxga?=
 =?us-ascii?Q?odUfY3cpYiwAQO4U9bTeFiqXj9x58xQQRN8KZQtro8VpjzZSn2bVyoM+8Vyw?=
 =?us-ascii?Q?YR40ezHU00ZlaPugy893jQM7a9/bMj8jXuAePknodXnptIVAAmEgGDqmcRwo?=
 =?us-ascii?Q?T/f4xXghhCZHwQd59SCVrVZwfflSQWTdHGDyo4OmbFqM0Um0nAIRIS3GtotD?=
 =?us-ascii?Q?fL5Uc0tDEPD74UGGPQvEOeEDn3s9NilvI9OO5CNnW9JhpZ6ynltzyWCUfria?=
 =?us-ascii?Q?1evRlxoOrxw2/oC+0CYTejoSo0Teyx1pTzmqXLmLWjkmjrjXnBhhkZEAznrV?=
 =?us-ascii?Q?Ii/kfiL2vg2lZMlTz3U8XM1SdOz+m9N1iKa/W9y5YtuvzZD8xMXDqnKxiTXd?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pVSLNO2n1a5BUAqubQuenNR4iPVeM2ZjT9mJY6cn5xeuaEtKP6ijK5E5u/uzqUftFzD8Zo+tk1bYvalzYlrflFb/PRffqFAmlBnOzVHJj8ry/xKQy4HhH47J8H0r55ImU/HlzDS0PXDHiwTTgyvkUW7U/6tM4XXigH2VThn2D1Wa3O+4qNX0DwWrrgFzpwbONb0NKGuYprSgxIC259avMejnW0e2WW0YFbQeYWj2MJxC6CGAQXRJAqY1wwH1IM25gCGDDNlF9p3sBDE/s4rxtOFwANlqqbPkqm8KJ3PoXfTGuP8aZcuPL1mCi1rUAGKUqD+LpuOXMeF2bFrBOh0TbnVKGfz1o1wiFcx93KuEpwjP6TE4KN0bss5aFutM3ONNF+wTCf+mpzvYAg1SmijYAOpwZURowifO4Tucc2WfizTGz4lxj4CLA4QX97a+RG+o4YXjSSPWb9OC5bki1dEdHbhjvQ7P6mlZGjgRpkXAk0I3YjDOZZ94EfSlvYQE5yKDOVejgsOMgZnzMDD5z9us86zqVPyRtNcGMmSXs7dJmyExcDrC5HKgqjt7pFxtwU/poD73jfAGuzCw1r0xslZQTe8b9iUGnzcJkDSZBlUohW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8406f4da-2a84-4817-f030-08dceeef8e12
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 21:06:22.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4ScXAueYQvbAc88mI2aZPMdhzH0eZY0QybYN5IIC1ByYzW416I/h3F0YsZ8uAT3NNKXD8V+1pF6LXPJNNr9Vue9ugijNbRopfmjzRgD5AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170142
X-Proofpoint-GUID: hCyz67Y1eTLH-atH14GHW8BZbfemB7yz
X-Proofpoint-ORIG-GUID: hCyz67Y1eTLH-atH14GHW8BZbfemB7yz

Add tests to assert that PIDFD_SELF_* correctly refers to the current
thread and process.

This is only practically meaningful to pidfd_send_signal() and
pidfd_getfd(), but also explicitly test that we disallow this feature for
setns() where it would make no sense.

We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.

We defer testing of mm-specific functionality which uses pidfd, namely
process_madvise() and process_mrelease() to mm testing (though note the
latter can not be sensibly tested as it would require the testing process
to be dying).

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/pidfd/pidfd.h         |   2 +
 .../selftests/pidfd/pidfd_getfd_test.c        | 141 ++++++++++++++++++
 .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
 tools/testing/selftests/pidfd/pidfd_test.c    |  76 ++++++++--
 4 files changed, 218 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 88d6830ee004..cbe1a2be3cec 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,6 +16,8 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#include <linux/pidfd.h>
+
 #include "../kselftest.h"
 
 #ifndef P_PIDFD
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index cd51d547b751..48d224b13c01 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -6,6 +6,7 @@
 #include <limits.h>
 #include <linux/types.h>
 #include <poll.h>
+#include <pthread.h>
 #include <sched.h>
 #include <signal.h>
 #include <stdio.h>
@@ -15,6 +16,7 @@
 #include <sys/prctl.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 #include <linux/kcmp.h>
 
@@ -114,6 +116,94 @@ static int child(int sk)
 	return ret;
 }
 
+static int __pidfd_self_thread_worker(unsigned long page_size)
+{
+	int memfd;
+	int newfd;
+	char *ptr;
+	int err = 0;
+
+	/*
+	 * Unshare our FDs so we have our own set. This means
+	 * PIDFD_SELF_THREAD_GROUP will fal.
+	 */
+	if (unshare(CLONE_FILES) < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	/* Truncate, map in and write to our memfd. */
+	memfd = sys_memfd_create("test_self_child", 0);
+	if (memfd < 0) {
+		err = -errno;
+		goto exit;
+	}
+
+	if (ftruncate(memfd, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+	ptr[0] = 'y';
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	/* Get a thread-local duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD, memfd, 0);
+	if (newfd < 0) {
+		err = -errno;
+		goto exit_close_memfd;
+	}
+
+	if (memfd == newfd) {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	/* Map in new fd and make sure that the data is as expected. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	if (ptr == MAP_FAILED) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+	if (ptr[0] != 'y') {
+		err = -EINVAL;
+		goto exit_close_fds;
+	}
+
+	if (munmap(ptr, page_size)) {
+		err = -errno;
+		goto exit_close_fds;
+	}
+
+exit_close_fds:
+	close(newfd);
+exit_close_memfd:
+	close(memfd);
+exit:
+	return err;
+}
+
+static void *pidfd_self_thread_worker(void *arg)
+{
+	unsigned long page_size = (unsigned long)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = __pidfd_self_thread_worker(page_size);
+	return (void *)(intptr_t)ret;
+}
+
 FIXTURE(child)
 {
 	/*
@@ -264,6 +354,57 @@ TEST_F(child, no_strange_EBADF)
 	EXPECT_EQ(errno, ESRCH);
 }
 
+TEST(pidfd_self)
+{
+	int memfd = sys_memfd_create("test_self", 0);
+	unsigned long page_size = sysconf(_SC_PAGESIZE);
+	int newfd;
+	char *ptr;
+	pthread_t thread;
+	void *res;
+	int err;
+
+	ASSERT_GE(memfd, 0);
+	ASSERT_EQ(ftruncate(memfd, page_size), 0);
+
+	/*
+	 * Map so we can assert that the duplicated fd references the same
+	 * memory.
+	 */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, memfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ptr[0] = 'x';
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Now get a duplicate of our memfd. */
+	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD_GROUP, memfd, 0);
+	ASSERT_GE(newfd, 0);
+	ASSERT_NE(memfd, newfd);
+
+	/* Now map duplicate fd and make sure it references the same memory. */
+	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED, newfd, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	ASSERT_EQ(ptr[0], 'x');
+	ASSERT_EQ(munmap(ptr, page_size), 0);
+
+	/* Cleanup. */
+	close(memfd);
+	close(newfd);
+
+	/*
+	 * Fire up the thread and assert that we can lookup the thread-specific
+	 * PIDFD_SELF_THREAD (also aliased by PIDFD_SELF).
+	 */
+	ASSERT_EQ(pthread_create(&thread, NULL, pidfd_self_thread_worker,
+				 (void *)page_size), 0);
+	ASSERT_EQ(pthread_join(thread, &res), 0);
+	err = (int)(intptr_t)res;
+
+	ASSERT_EQ(err, 0);
+}
+
 #if __NR_pidfd_getfd == -1
 int main(void)
 {
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 7c2a4349170a..bbd39dc5ceb7 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -752,4 +752,15 @@ TEST(setns_einval)
 	close(fd);
 }
 
+TEST(setns_pidfd_self_disallowed)
+{
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+
+	errno = 0;
+
+	ASSERT_EQ(setns(PIDFD_SELF_THREAD_GROUP, 0), -1);
+	EXPECT_EQ(errno, EBADF);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 9faa686f90e4..440447cf89ba 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -42,12 +42,41 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static int signal_received;
+static pthread_t signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
 {
 	if (sig == SIGUSR1)
-		signal_received = 1;
+		signal_received = pthread_self();
+}
+
+static int send_signal(int pidfd)
+{
+	int ret = 0;
+
+	if (sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0) < 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (signal_received != pthread_self()) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+exit:
+	signal_received = 0;
+	return ret;
+}
+
+static void *send_signal_worker(void *arg)
+{
+	int pidfd = (int)(intptr_t)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = send_signal(pidfd);
+	return (void *)(intptr_t)ret;
 }
 
 /*
@@ -56,8 +85,11 @@ static void set_signal_received_on_sigusr1(int sig)
  */
 static int test_pidfd_send_signal_simple_success(void)
 {
-	int pidfd, ret;
+	int pidfd;
 	const char *test_name = "pidfd_send_signal send SIGUSR1";
+	pthread_t thread;
+	void *thread_res;
+	int err;
 
 	if (!have_pidfd_send_signal) {
 		ksft_test_result_skip(
@@ -66,25 +98,45 @@ static int test_pidfd_send_signal_simple_success(void)
 		return 0;
 	}
 
+	signal(SIGUSR1, set_signal_received_on_sigusr1);
+
+	/* Try sending a signal to ourselves via /proc/self. */
 	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
 	if (pidfd < 0)
 		ksft_exit_fail_msg(
 			"%s test: Failed to open process file descriptor\n",
 			test_name);
+	err = send_signal(pidfd);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on sending pidfd signal\n",
+			test_name, err);
+	close(pidfd);
 
-	signal(SIGUSR1, set_signal_received_on_sigusr1);
+	/* Now try the same thing only using PIDFD_SELF_THREAD_GROUP. */
+	err = send_signal(PIDFD_SELF_THREAD_GROUP);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD_GROUP signal\n",
+			test_name, err);
 
-	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
-	close(pidfd);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s test: Failed to send signal\n",
+	/*
+	 * Now try the same thing in a thread and assert thread ID is equal to
+	 * worker thread ID.
+	 */
+	if (pthread_create(&thread, NULL, send_signal_worker,
+			   (void *)(intptr_t)PIDFD_SELF_THREAD))
+		ksft_exit_fail_msg("%s test: Failed to create thread\n",
 				   test_name);
-
-	if (signal_received != 1)
-		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
+	if (pthread_join(thread, &thread_res))
+		ksft_exit_fail_msg("%s test: Failed to join thread\n",
 				   test_name);
+	err = (int)(intptr_t)thread_res;
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD signal\n",
+			test_name, err);
 
-	signal_received = 0;
 	ksft_test_result_pass("%s test: Sent signal\n", test_name);
 	return 0;
 }
-- 
2.46.2


