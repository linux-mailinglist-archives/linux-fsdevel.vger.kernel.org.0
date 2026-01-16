Return-Path: <linux-fsdevel+bounces-74169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FCFD333FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A15330081A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBCE33A9EB;
	Fri, 16 Jan 2026 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="G2thMGsx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023084.outbound.protection.outlook.com [40.93.201.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF9C26E165;
	Fri, 16 Jan 2026 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768578002; cv=fail; b=LuW/94ULuBLjnCefa9NVxG0v+8HGAxBnQaGGPNLZDlCNbl7W18SYNdWH7SqQebYaMtwtaV7iqAN99P1yzN/AttMtSHihSzuuCy9m6bpU0a/XXIdIBmcWZWOzAk0Jizxjw0jSO5M1Uf3X/nR3v8E7RBElBxtxNDPg+rdwF9OYZyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768578002; c=relaxed/simple;
	bh=qDkLgNlEZhXXBvfDtp/i4X4AfpHUW8/B2FQ9F+TIanw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFDhdjKcq/8O+lb8eSeP5+u53+NRyyFncyzpcknjTeoClhAhV9vGs1ZkscIEaD2hc3aRMpSWVfc4oLZ02A/BTCxIqSgL2kuTSqebmLLQ/ZwAQwhMWPU+nfbWUjlR17d/vvmu9K81VY8ddlmY/TY+hyAhimgFs7wg1kptzT3S2xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=G2thMGsx; arc=fail smtp.client-ip=40.93.201.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSuPeQMq7vaC2jtH+2+w+3qlyFWrNZgoaR9u10EeVgQ1z20xr1JZxsqqyKuAeDoFdWRmfrvAB9nsCQMEt9WXEYenKxouRaAvhYwp+NidhzeIStW49LO1fR68ROdzKsUal76SIrxhbZSe9aDpvlKPYul3rvaQQpOFWwjLt4sF4MyEinIabxeVOeWJ3ku4fAgVBigVPTWWlhDqvurC+sJR9vHb4m6FGoN3m+rE+guq5X5gnBQjxf6cRpQ8uW6QHzuAJT+Z2hHUt3MRnpWfGrAy5U0uAiTC2TuduJARE+2/vLXZ7zVBHY9gNhbPHwNyOL7VzK//CU72eg5P05cYrQWR1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiSoafNGSVATY3nPsL3Qev5nElir3UwLjo7//gvlRjE=;
 b=PtFhq1eovL3Gg4McDOyMlpnXOpxVHh9UYNmXGSASAm7x2KxurXKUhWJPhp9A9Hor8wFXFMQ0vGOmGgTjWiZJqoIMQesgFN5IHqX9RABzM4Ozi8bJ/7ZB+X7V2waPJdvHmEtGQ2ICnqlhC1v3/E3p21tLmKHYXiXjZmlFKF/+OJTSu0rKyqOgiTlN7u+KVSgQMaAwdQl2sTXNd98MoB9HpT9WejM1Eie1T1o0VVfwOeXJeBPI9gZaVvgVl16OECd+Hw3aPge16zpZGAaHX8tBdrvCYhIQqJqpfqN1fn8i+3kcHsWZE0VSSmp4uQyGv5Z/d04rMrQIRbEBr4bm+IOLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiSoafNGSVATY3nPsL3Qev5nElir3UwLjo7//gvlRjE=;
 b=G2thMGsx9pejeyJ9wNZLBy0zPvOs0z1kbIyztpBq71KmgRFoPFZgRSRrENpf/FBu4YZVswT5iA//uO6XT8zHPn/7HGqDQ8HhNwTfD1mmqH7taN7i07LpdhLCnwJaS9R2cwafbAxY2ciBVgbeBeKK8RIUtDNN8H6ot6CfQoIoKm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 LV8PR13MB6841.namprd13.prod.outlook.com (2603:10b6:408:269::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 15:39:55 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 15:39:55 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 1/4] nfsd: Convert export flags to use BIT() macro
Date: Fri, 16 Jan 2026 10:39:52 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <22558AE3-3779-4671-8E2F-40A999385499@hammerspace.com>
In-Reply-To: <d548815e-bab2-4f1a-8c41-003aaf4f7c14@kernel.org>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <c8735411d66dd7db9c5abb2b5a1c4d9b98ea174a.1768573690.git.bcodding@hammerspace.com>
 <15993494-ddd8-4656-8815-2693ee3b7fb3@app.fastmail.com>
 <8F2645AA-9CB4-44D5-9121-8699216EF7CD@hammerspace.com>
 <d548815e-bab2-4f1a-8c41-003aaf4f7c14@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0264.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::29) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|LV8PR13MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ba0e3d-2d5c-4844-76f1-08de55157f1c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4f+MGf98t01cDJdOUM78mExwa9V1yeHLyKDt0CoODUntRQl4evprvos7pXk6?=
 =?us-ascii?Q?ZERDc0gwWV0JmwLf6n6B9RFPyrSGGJK2Vam23IfkULFIOey67VlXs6RZ/vDS?=
 =?us-ascii?Q?qVk5kkHTf4U30v7T3WpmdIRp3V0jbKnTCmDFGBipMW8bSkIAnSPXuLmuus0/?=
 =?us-ascii?Q?mp5OM1DGDaTo5A2o/EdbjRY4CEQLG/CRhKc4DkSHYyy/I4IpXkAd/Bii3vMa?=
 =?us-ascii?Q?Hrvjgb576nn+z8KJTuIcs5ZurEmHEGQK2SxdlqQfw+FPZXDerZi5+PV6AYxq?=
 =?us-ascii?Q?jEwyhZ/nPP3RdNI2iabY/bTk5b7NE1dqmVK5do/ot19H6+gV7nXrpiB8t0GG?=
 =?us-ascii?Q?z1U6WMUREZxdx+morgo2/hJOkNbOz8msC1NZPElIqgiVWmw5mtVpXuMnrxZS?=
 =?us-ascii?Q?N6LlBzVpVWcKWehpgXwhFtVBdzAd66r1mrUH0MWk+JEWbsBJkmvvclzSqSe+?=
 =?us-ascii?Q?BnDd0cKrR2kYO8iAIt6yUU76eU+F2krVHA1ccCCWfDlEDJ9Zd3+8zf+CyXVt?=
 =?us-ascii?Q?eMCY2yOGYjgJp+BXylbUVZaZ8L2LqflJkmQ3aImGU/MSyFiSawGOZA/mg8oY?=
 =?us-ascii?Q?yAP0OYUzi9XQki1tRkPEvVQdVOgWm8fCpb0UvJlWGrUVau2E3F+hPj72d2mz?=
 =?us-ascii?Q?8ULeSHsTcQfFQDqpO3l3iaXvrI0BZg/EBaCaMwbszQE0rE4yZZlEpC0SbQuY?=
 =?us-ascii?Q?8PSJQgTF/Ctn5391Fdpokw8QIlf1qlvOIxTbcaw8lZUaIxxvyORFY0EO8wIB?=
 =?us-ascii?Q?Y9dU1lk8mUlF7Nb7NipFhiCr4U8IeYG2gfbMB4+WCjdGFQgrsavO0GnZ/gOZ?=
 =?us-ascii?Q?WVp7VhI++Mp+4HSpVQQ+fq7uy/0zGyhwEnwYmFgsoiuo4A1uX2nmfc89+1vC?=
 =?us-ascii?Q?lpq+tvW2GRW/r84o+w0edIdH12kfsyEfp+S/RvB5FMhLbUxWlBYxUQKU30gT?=
 =?us-ascii?Q?Rl4wmgCXQiWNNwJgTDmQdcZN4YpouKVChgsOaBbF2jJohdc+qeDfKlS7HhcL?=
 =?us-ascii?Q?YQkmDCnMaigZMXa8/UPFCWBLRZF+USLQy1lVNWCR3X65YHGP1jJy0nPbY/XS?=
 =?us-ascii?Q?nq8YT/PisGYVfJ5nVXbC+4Hfnx8uMupr3EC7jiz1WZdp+cJUXppgZHpjYlbs?=
 =?us-ascii?Q?QPGc+c/Opi9Cf3mPaztEphvXsvgqwj59fTzbB4MtfLq0oprEZqdbMdLSPkC0?=
 =?us-ascii?Q?aV06HcLZvFGz8Vy1+b3E17rrHmTd1Ehx8PBkhPX2vJQa4ZThiuQgccCziHnK?=
 =?us-ascii?Q?jEbmYYOekD6/VjSjA8xQ+5m/rLDgsACIIyBBRWCfcNH71eDaWx30NTavdfF1?=
 =?us-ascii?Q?V8c4cGZOE+EJI0/Rst/QlaNucRInIc8kbXOgqtL/eRTvuFrpavBpUzhSLwD6?=
 =?us-ascii?Q?suFfyi7hA+CIF8pLkVINOBSG/qC+B2Jgfd0Cr5Y0E7xcHxT0Wl26jlHgu4yS?=
 =?us-ascii?Q?QgYFNhz1E0ogfakn0I3FCEF43bDeJnIIUk7LwBZY5tQVCLIHONGBoofA/p8g?=
 =?us-ascii?Q?PIqSBKpuR+f/ECL0s94LepUQTzWzfpK5dLOEHWlfQBUvYpWFcGPHwc+1l1FX?=
 =?us-ascii?Q?fILio8rcxwysDVd7W+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5IIPF+RSLiUZXP8s0WjVdowops76yVwAOGgJZFUODcxtecxbnK6ffBB7EC3g?=
 =?us-ascii?Q?oq4u29DOEAqyWX1hce+ZcBsQtW8MRIoIYqAIG2YNi1vEe7rSpsqQ2HLgpn3Z?=
 =?us-ascii?Q?U2umvTu8GDoXjqpoGnD8/nVYzn0nDF1Wjn41grU6eSJRhgO3gXh5Hd3yiMIh?=
 =?us-ascii?Q?QEw2xwIzpwfh3UzCvciytLD0tbz+xd6WOBKu7j9+BJxlAvsIYVFNUvmix+Yi?=
 =?us-ascii?Q?sLO3KirISLT545UYAa6HhDnwRGSGoKwasKEkfK3TudjxMhnMUzcLzE66/w1L?=
 =?us-ascii?Q?LCAx4CPmbuOxKZcGfgy6A9h1XPXZLNo7AgiZZJv521E3j1GcikZwz2hSJupJ?=
 =?us-ascii?Q?8uoX/QigH2g5SyzIZ69GT0gVQfCp14UZCEoAjtVrNUyfKg/qP+ShAywHqZp8?=
 =?us-ascii?Q?ks4So3XcZG/fKHQ4UGPV4Bx7OicLGCBfETvc+gjeEdjSEjGi9xSL3M2o7NGG?=
 =?us-ascii?Q?GmMZn6dFz1LyjH6bN4ptSIvirnNqYSSTdhygq02TmFoLwVv/WUWFJPRsxNvr?=
 =?us-ascii?Q?SSsLV08BN5vB7gWWtNfCMbZLFzAxTfQYxPbZumVKDfbx/CXRxJpEYo7IHSyg?=
 =?us-ascii?Q?B0wlQlbI8nd0NlUG1H8RsS7XzdpwonpvSbqdD3Fh9yMvnRi+Cp2dHnr37HJ9?=
 =?us-ascii?Q?IOUHOiwubvPWE4Vy6NZmflTz4cRXM0JTt4ajPvb91zyepXlKCBgxFP7jkRa+?=
 =?us-ascii?Q?D6yCAX0sSylG5I15zJYlBDHaMfWsggZEv+vTGUild4bHGPeijce/9ygEmMep?=
 =?us-ascii?Q?rhpNpo8Rf/JIjSzCvz9svGMPb4mR6LZ+eGAEqaZL8gWA8lqKFojfMsgY9XNS?=
 =?us-ascii?Q?iPawbrcTmisC2uKYgb5s6gYxDGQOA2yPUjalMhv/Dg8/aBPl31gHclUuryPl?=
 =?us-ascii?Q?u8B/2CQA5U3mK0wzgco2ChBt11PO6Fyqg+JpWp6WbHtkXkNeOiDuCUXwODEi?=
 =?us-ascii?Q?YAGjaF3M+xZY3TYwWrABZw/TpAT6WeN16Xqw1lJVpAXgrLpEYtnSregoPs+y?=
 =?us-ascii?Q?n9ZKIHFcdPRRYNncUe+DFSOScY3scfT2PjZVGLCODEBAFDpR2f5WRWaHvjbd?=
 =?us-ascii?Q?RDkNbAtla0vh/VHqCVI6HsiM0ecmJvIxtZ6YTClvVuGqj/ulNyz4gZwczbrg?=
 =?us-ascii?Q?jXDDMaIO1cY1d+kGZDpfIBYVGpfwtocwcbrb4fKTtBOmCcfmqXPvVKSNxasE?=
 =?us-ascii?Q?OhF9Jt3mfrZoQmwE2R0pkmOSZjjX0xMlC2HWVrWMiO2XgIBpyKFc4GlFhZqk?=
 =?us-ascii?Q?SSoUSE/VF+rY1VGszldsm7PsmxQ6Ai3mMQ9GcV/m8idpOPdRE6a9vKl96Zas?=
 =?us-ascii?Q?FOUW0iDxnhlHBIBkfBdUwxpaAtyNVnlIcNGb+y8RWY0SpJGUybBwtl01Obqq?=
 =?us-ascii?Q?EmfnGEQmNVOFFqniC0LIBJWBk/1o5qtXS2VgTB5tGl2o3zuJvBAy1mRhpVcP?=
 =?us-ascii?Q?O1DTr82G6TReAcSelEcllVuUDtqp4ylRZkVuVJZOFsuNi14QH8ty0odTDb27?=
 =?us-ascii?Q?9qB7CdiioK+yzBgwg0DXaUmGVCmNrOy5W+v2OiWerbDyOfXByr8o6cGTVhMw?=
 =?us-ascii?Q?8A/xjI7AxIOuHFCsjkZnmaw+6resx6EoGOsBnYp+2gnFU/u9etwzlU9IkDg4?=
 =?us-ascii?Q?BE5NW0BwbtO9V2ofpkPMv9IeoAs6DizswbZBGyiHS/7FWl52u1pga+kRJml8?=
 =?us-ascii?Q?a8gT6Oc1bbRzXBncxRphTk3JSfxacsfRAVfco5eQj3jn4gZWE3fWFkF5qTxu?=
 =?us-ascii?Q?ZZJ1eep0PGqi5gVbwiNJfMHIQTXFK28=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ba0e3d-2d5c-4844-76f1-08de55157f1c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:39:54.9513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uo8+6g2MGZUE70czzCGqVp/mNK9C/cG3GdZoAIqVL8x7FyavE+Of32oZMWcAq7melCoiGpirEivtoQ14/vhTaK/8oRtZOd5Yo2I7J4HjN20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6841

On 16 Jan 2026, at 10:38, Chuck Lever wrote:

> On 1/16/26 10:35 AM, Benjamin Coddington wrote:
>> On 16 Jan 2026, at 10:31, Chuck Lever wrote:
>>
>>> On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
>>>> Simplify these defines for consistency, readability, and clarity.
>>>>
>>>> Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
>>>> ---
>>>>  fs/nfsd/nfsctl.c                 |  2 +-
>>>>  include/uapi/linux/nfsd/export.h | 38 ++++++++++++++++----------------
>>>>  2 files changed, 20 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
>>>> index 30caefb2522f..8ccc65bb09fd 100644
>>>> --- a/fs/nfsd/nfsctl.c
>>>> +++ b/fs/nfsd/nfsctl.c
>>>> @@ -169,7 +169,7 @@ static const struct file_operations
>>>> exports_nfsd_operations = {
>>>>
>>>>  static int export_features_show(struct seq_file *m, void *v)
>>>>  {
>>>> -	seq_printf(m, "0x%x 0x%x\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
>>>> +	seq_printf(m, "0x%lx 0x%lx\n", NFSEXP_ALLFLAGS, NFSEXP_SECINFO_FLAGS);
>>>>  	return 0;
>>>>  }
>>>>
>>>> diff --git a/include/uapi/linux/nfsd/export.h
>>>> b/include/uapi/linux/nfsd/export.h
>>>> index a73ca3703abb..4e712bb02322 100644
>>>> --- a/include/uapi/linux/nfsd/export.h
>>>> +++ b/include/uapi/linux/nfsd/export.h
>>>> @@ -26,22 +26,22 @@
>>>>   * Please update the expflags[] array in fs/nfsd/export.c when adding
>>>>   * a new flag.
>>>>   */
>>>> -#define NFSEXP_READONLY		0x0001
>>>> -#define NFSEXP_INSECURE_PORT	0x0002
>>>> -#define NFSEXP_ROOTSQUASH	0x0004
>>>> -#define NFSEXP_ALLSQUASH	0x0008
>>>> -#define NFSEXP_ASYNC		0x0010
>>>> -#define NFSEXP_GATHERED_WRITES	0x0020
>>>> -#define NFSEXP_NOREADDIRPLUS    0x0040
>>>> -#define NFSEXP_SECURITY_LABEL	0x0080
>>>> -/* 0x100 currently unused */
>>>> -#define NFSEXP_NOHIDE		0x0200
>>>> -#define NFSEXP_NOSUBTREECHECK	0x0400
>>>> -#define	NFSEXP_NOAUTHNLM	0x0800		/* Don't authenticate NLM requests -
>>>> just trust */
>>>> -#define NFSEXP_MSNFS		0x1000	/* do silly things that MS clients
>>>> expect; no longer supported */
>>>> -#define NFSEXP_FSID		0x2000
>>>> -#define	NFSEXP_CROSSMOUNT	0x4000
>>>> -#define	NFSEXP_NOACL		0x8000	/* reserved for possible ACL related use
>>>> */
>>>> +#define NFSEXP_READONLY			BIT(0)
>>>> +#define NFSEXP_INSECURE_PORT	BIT(1)
>>>> +#define NFSEXP_ROOTSQUASH		BIT(2)
>>>> +#define NFSEXP_ALLSQUASH		BIT(3)
>>>> +#define NFSEXP_ASYNC			BIT(4)
>>>> +#define NFSEXP_GATHERED_WRITES	BIT(5)
>>>> +#define NFSEXP_NOREADDIRPLUS    BIT(6)
>>>> +#define NFSEXP_SECURITY_LABEL	BIT(7)
>>>> +/* BIT(8) currently unused */
>>>> +#define NFSEXP_NOHIDE			BIT(9)
>>>> +#define NFSEXP_NOSUBTREECHECK	BIT(10)
>>>> +#define NFSEXP_NOAUTHNLM		BIT(11)	/* Don't authenticate NLM requests -
>>>> just trust */
>>>> +#define NFSEXP_MSNFS			BIT(12)	/* do silly things that MS clients
>>>> expect; no longer supported */
>>>> +#define NFSEXP_FSID				BIT(13)
>>>> +#define NFSEXP_CROSSMOUNT		BIT(14)
>>>> +#define NFSEXP_NOACL			BIT(15)	/* reserved for possible ACL related
>>>> use */
>>>>  /*
>>>>   * The NFSEXP_V4ROOT flag causes the kernel to give access only to
>>>> NFSv4
>>>>   * clients, and only to the single directory that is the root of the
>>>> @@ -51,11 +51,11 @@
>>>>   * pseudofilesystem, which provides access only to paths leading to
>>>> each
>>>>   * exported filesystem.
>>>>   */
>>>> -#define	NFSEXP_V4ROOT		0x10000
>>>> -#define NFSEXP_PNFS		0x20000
>>>> +#define NFSEXP_V4ROOT			BIT(16)
>>>> +#define NFSEXP_PNFS				BIT(17)
>>>>
>>>>  /* All flags that we claim to support.  (Note we don't support NOACL.) */
>>>> -#define NFSEXP_ALLFLAGS		0x3FEFF
>>>> +#define NFSEXP_ALLFLAGS			BIT(18) - BIT(8) - 1
>>>>
>>>>  /* The flags that may vary depending on security flavor: */
>>>>  #define NFSEXP_SECINFO_FLAGS	(NFSEXP_READONLY | NFSEXP_ROOTSQUASH \
>>>> -- 
>>>> 2.50.1
>>>
>>> This might constitute a breaking user space API change. BIT() is
>>> a kernel convention. What defines BIT() for user space consumers
>>> of this header?
>>
>> Doh - good catch.  I can drop this, or maybe add:
>>
>> #ifndef BIT
>> #define BIT(n) (1UL << (n))
>> #endif
> I'm happy leaving these as hex constants.

Got it.  I'll drop this on the next version.

Ben

