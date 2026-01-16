Return-Path: <linux-fsdevel+bounces-74240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16940D386F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 21:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 304B1307128D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751F53A0E9A;
	Fri, 16 Jan 2026 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="FmALowP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021097.outbound.protection.outlook.com [52.101.52.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B26E34CFA8;
	Fri, 16 Jan 2026 20:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594273; cv=fail; b=INt+fx37wjDppGt05W5ADvrpP8GXTCPNTOgfq/0lFhgnwreraTcftFW53QOhuAyr/jXg30M05uf8KnB9tKnVac17t2N1QAa4AcFpL7YyikoczZ6JJBBdrCRkIRJfeUsAJyGhy8dEA+B4hBT/SsWB9LQvi2LsEAojSTrTzcqtRaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594273; c=relaxed/simple;
	bh=anVnV7ehREvyrNafQ6JhUBNRYX+D8IKwk91x7csz2yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ti4QaTn2FIaJyWjw/UEsuznyohULZN0otEER6lmTtb6iFMdJb/J+y02UbD0+KKfOgqy0LsHc1o5grhOsARsL43cYX3VtDeoih3KCRcD0oe7TrfPxVFmw/jttBXYU3bA1Fl/5CjvMyB3h8SdewsxJTxeXov8SImSw9kWH2hcSVQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=FmALowP0; arc=fail smtp.client-ip=52.101.52.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNtj56flietw9HgcKzl4g2gWpdRlujmoPkqsyhcBmvoWyrAJbu95EPfGRDCG9CHQIl6UZ0kxeaVvUgwe4oM2O7IdS32z6RAdOhYIuJeEEFuz4WZhuSG6XXAzvb2nffjcWgAt+1di8kLjgDo2nrGDaor+md1gf7Wk7rFdnsoi7N1mWFMo43LCCYmpgMX9/eU7HkMEmQEyz6mcTIgB2Uh537vF9EZGeTxtFW0PxBQasly1ahus14UVgE5jmjBCKMPA5AuKql04Exv8QshrEkfvh4kex3pRYkhtXzf+IBA0nFISIkIpJ1yRjZuYKZFT9tmYxGSHP5F9LTsd+C5HxEG6mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVNJWU8cQklpfp8ndrj+haZed8EWwYL69TS44WyJDXM=;
 b=AONcpEzdNuoZn8T5xlkgQwlrxyST7wI3L8fAnmvMaj4eIhRVMbwgc1/tvYmCXrRyR1X2lH5UHarc0qTqZ+6PSGN118bFcqqzCPSy2uC9NkVe4lbZbYu4J1RP98df2xGLTb1F/3WO9MtCXue/QD57HgZVKC3oi35V415/T4kE8a4K4IpEiraOmQjCc9FQPXMou7rt0xKNkZgAlw9lDaBa9YXyB6gZy9Z2M7BUuTUnbjUMZY5c71bhkX4+kWO1boYFC982Luxo5B1NSYnmf1jHsl+BbsG+Vm8MsNlxkM2DY9HwHRgvQ0slqOe20bUrE+3b1tABWJbHFLkFq4umn/cwdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVNJWU8cQklpfp8ndrj+haZed8EWwYL69TS44WyJDXM=;
 b=FmALowP0AhjMCP8T2RLXzWfHSRGMqlX1/g0q8GWQiaA+BkX+/dMHn9yuZ+xGveXvqgTixgYEIRMAVHGVmfYc5VjCFrmakEufom7KrLnhLhlkhtptGd46PBFdeyNH1+DkBjITnexUthMgG27NMLONcyRGQi1JfckFR/GRzn9Jh4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
Received: from DM8PR13MB5239.namprd13.prod.outlook.com (2603:10b6:5:314::5) by
 BY1PR13MB6937.namprd13.prod.outlook.com (2603:10b6:a03:5a7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Fri, 16 Jan 2026 20:11:08 +0000
Received: from DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3]) by DM8PR13MB5239.namprd13.prod.outlook.com
 ([fe80::fa6e:7b5:d1ec:92f3%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 20:11:07 +0000
From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
Date: Fri, 16 Jan 2026 15:11:02 -0500
X-Mailer: MailMate (2.0r6272)
Message-ID: <1D003BD7-1102-4355-961A-7564E5368567@hammerspace.com>
In-Reply-To: <683798bf-b7f3-4418-99ce-b15b0788c960@kernel.org>
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <f8e2d466-7280-4a21-ad71-21bf1e546300@app.fastmail.com>
 <C69B1F13-7248-4CAF-977C-5F0236B0923A@hammerspace.com>
 <683798bf-b7f3-4418-99ce-b15b0788c960@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To DM8PR13MB5239.namprd13.prod.outlook.com
 (2603:10b6:5:314::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR13MB5239:EE_|BY1PR13MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: fda57d98-7f1f-45ce-74d2-08de553b6277
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CY8428xOsIvCLIhG9UFmN6RjtCXJEgXTrngIMEpumguDK8vd5L5JmFb6p3kz?=
 =?us-ascii?Q?8soHzoKxcr7N1b+qUPryRQlZTH6HmMoD0Usfaamyiib+wKsGFzgkSurPe2t4?=
 =?us-ascii?Q?YCkYJEhJGm8snLmX7UDi0mOrT4IijHyBblH6OZKymE/ZrLgo4HH7sdwD/03S?=
 =?us-ascii?Q?MatmIh+WzY6vASRXJM+mhywe2Ka9yGVUbh/CxXmB867aK18PAy5nrHG6i6Ud?=
 =?us-ascii?Q?jFipPtS8LAmr49Xus5kxN72qG+UCpwawy3q4WTOvOl3j8Q3EpQ5TqtZOI4AW?=
 =?us-ascii?Q?TKcaJXKTfQRc/Zcsi9EBQoKGtlF07y7bg/uFEaQpTYya002DBX4QeoRR+P/G?=
 =?us-ascii?Q?0qQv7oPb6BghMEz6zWeRS+KXd1PfsBTbeq+0fTsJPsUSvxyXN4m2SiiRC5Cb?=
 =?us-ascii?Q?NwzU9F2Mb5/Efz11QDuDp51KgCfOFOinq3LerF4A1kzEiSpVjO11vM+NQjKf?=
 =?us-ascii?Q?+25soOaovhL9oXDCIjmIQss8YMwuAQt03hv6H7anLp7X9GwlPUsZ5oa0NSJK?=
 =?us-ascii?Q?Ih0J7SGtp7amlKO0aDRyuO1KehlrOP9PxBMpO4hOKeRakjOUac1xLE7X9Wan?=
 =?us-ascii?Q?AxNbMr3Wgn1IeBeHOnp/B3rhPXvkwgxG8TGERNcra8Ls6LXBh1KqiL2RikCC?=
 =?us-ascii?Q?6eSY55MEUegVTRhsqLZuNeYaU52z1XvghOBFFhXulFjN7aiLLdkgbAqRHEPS?=
 =?us-ascii?Q?3al/NtVeIyRpj5S7Ag5N4UUDpk3YOFYpvGhzmSqW9uYi1MbKSIVx6pvEa+2e?=
 =?us-ascii?Q?zYiSh/JYw95FGalfY1UgTNcTI2LzQCJeJEKjRBK5iL861GkTRGSFTnHBZOu/?=
 =?us-ascii?Q?XeyeoxfMJo+p4fJOV1cVTcEsuSNsDOMeWwLDwpYagQrDnQwvEAQ/EWXPM9AS?=
 =?us-ascii?Q?TOtXfLa/Jc4TRgrUA77Iq3mZWlpxLVESKAbZO5+AoQ+rHQqmAJyYjRFUvIZE?=
 =?us-ascii?Q?6q5LKsxII02az4kY5tQoUZ3WKwuZNRlOrGYJGdu+LIRifjFc48G2Lcig1k7q?=
 =?us-ascii?Q?DkURxFFlz870lVTn5r9O1dsDXnLHt/1rnIT9VUHN3tn6CxpNHDINyeMCAonQ?=
 =?us-ascii?Q?ombQWJCEhsznH0buHxokdouNR/Z8+ZG+A7LAT1GKmtmMffej59BSNIMOX1di?=
 =?us-ascii?Q?W0D1zwA9Y0mLcIeQY+vamXSQBvfcQN4d/tVEJVgULBbKhUzVlG3WnMYGhmai?=
 =?us-ascii?Q?6rAUJs2RVg4DVD/1ktBPDGVXFtrA1p5CqxDXaRs1c6fyMML/AaLaL7POUhDz?=
 =?us-ascii?Q?qsmsCMvYvpk3rhqYUfG7j9dyfOU325gvO9bmf9GWs9LHXoCkA7JFylj1ZjVC?=
 =?us-ascii?Q?CjrQjiwhyA+E0DpLm+dKZgLChX2/jBAM8weVdask7AOJOdWf1gAftmHKQ/95?=
 =?us-ascii?Q?KPDzA8IbuTbbTCJpUlLLY542jOAwu6mNmYU9L261m/rquK+w0qBgITEix+vH?=
 =?us-ascii?Q?uTqID8t3I8cyKEYyKU26ZLzHzRYWcE9SjRGRGAqrMk1Vynk3V1bk81F1mMkG?=
 =?us-ascii?Q?d2Zs+QQTMlqN7dnBP+rfMggS2NI+KfOh3iVbuUwz8Ien/nZSH/CH7K7QHJcP?=
 =?us-ascii?Q?vIHvqdhfyeXR2NrqzB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5239.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wTK8hJbSNQ29DpwsaT3ZYx0HSLCmvSOmi6uuQ+15GdBkfF+95Gly5idWuXWu?=
 =?us-ascii?Q?hzJFbNOaHe/37+j4+D5/5yibxYtR5OruyLjP+Oh63gG658Gdyf2ereXTJkDg?=
 =?us-ascii?Q?Lg4333Z7PV2FDKkh00IvPslXUuPm2xoaogzI8apC2O08jD88CgqlxH+Z2rV1?=
 =?us-ascii?Q?bxKwH7C8qCotPm3XYErffNQffYFgfPMn8trrEqYf8g8pTgml9bP6ByoCIi+n?=
 =?us-ascii?Q?a7Xl8H06PN/C6lk1RYZSSXi4cPKrlhmPUrimYzAlqJHRvLdky237GLSotvD8?=
 =?us-ascii?Q?q3rADkes9x38nU7SBl8fldwIBbhOU64P7ar8R20FD13PkHvAQEzxCijn/TME?=
 =?us-ascii?Q?PebgTnWhzUCBo/HFQSWu0OSe6yRuqbXi1OAcdk/el2o8vpVpoS2YDwkKBoKP?=
 =?us-ascii?Q?dQi6IAYOnSX52OUFZt8q2uezDpHGHnLxUNIL6I7n1qPz2T/pxKIz8Ld96kPd?=
 =?us-ascii?Q?SVTTmbcCI8l9iIOWxuw2oCiyUGrVPPUtrzqVlaFTgXvPXtXgoeVIaVUnq6wI?=
 =?us-ascii?Q?dnSZ+iWnyI/vBDOsy+mKfEzOT4pxhTX48SOWSUwnoP3fKz9rfDwrwT+zsU8W?=
 =?us-ascii?Q?UBc4aClM1IJGn+3c6xStlNBqVD9QFoHNf9DdOciY3vtmrkZjhLBW4i6WnxBI?=
 =?us-ascii?Q?qZSqyGAelr78Z3AiNFpoaxOo/Rbjk4CnZHwai785UKnqEuekFnI7vlrUvBFS?=
 =?us-ascii?Q?48RRW1Kt9iUdFQPODjt0pj7XFEUw21UsLkCAC+pwm2bO2S/OvxFCdivkwA8h?=
 =?us-ascii?Q?carBLAkmit5hFoPLX7u+MVEA6t6Hvt9IPeFaFr4LizeAGqwHODDZsWTL/4a9?=
 =?us-ascii?Q?gsUILq4gUb1gQGVE2UMf3/PhusLW90/Ab/9Km3MJ+wVS3bemaZQS1ib8jIVW?=
 =?us-ascii?Q?kZ8RcHtjOAxrrLpKCg89Xt5fbNfBNXZWmZvZcTbjtw2OTiFvOQn3lOMQKk2D?=
 =?us-ascii?Q?gcNSZyjWoE3xpWJ8KCRTLDPNwwMsCdtrvstjp4uUXnWIP14M8V2QJ2g16bX2?=
 =?us-ascii?Q?pLNuxKBixwRF5tdd63Xz6hAEI8lGSia5m+BAxzobPyHHyOyxoBIKBLC0DgfT?=
 =?us-ascii?Q?94pwS5u+4Q2/7nshAjMfUBf6b/ql8VCHVsJ//Gf3o7oIf2c15zIRtWcgtofO?=
 =?us-ascii?Q?lUMRuhG1y4OEP3vFtp4QonNidO66wzE5+ukcyde7pMvD7oSDX/S9Bdgx6iY1?=
 =?us-ascii?Q?LqzB21QgWGcBR3uY3PKD66Oi8Y8L+OfI6acSJGjDftebxJZ0tT7ycWh3CP7x?=
 =?us-ascii?Q?/Y/sLmSfg/Iv7hBabN3k+YsAzYCBa8x9dp7NcGOp0DWE4tKy5hYGdHO70bfY?=
 =?us-ascii?Q?xvQnbyfjGU4FsnOg73LvodiAp1KS/TJEYb0po45cZiQr5qM3ooQ0UbDzF+fF?=
 =?us-ascii?Q?X83r/y7dac6WNBvkTRfsUjuLFl9GY1Nyl1D6oDCY6z6NL+buMOegloSXYNcg?=
 =?us-ascii?Q?8CvEqusACqU8jbbOgQanf/6YWfblEGldJX5b3zLr5FakdVHUDfq7TTcTg/AJ?=
 =?us-ascii?Q?27kuDNyEkmw5bLVEFDJfEJvRrscU23uwNRU0i/TITxdmjrT6BbEUq6sHrcC2?=
 =?us-ascii?Q?NY8Fa4qNYHqEA16a7k+/YUiRlx85X6bGeTREMB2qTEUTQ6azI3RSrFbINFNJ?=
 =?us-ascii?Q?OpCJuOl8PMaVF3lHHnpr+kfaQXE4twS+nQZH3YC6YJEM7krJInFJry59e7LV?=
 =?us-ascii?Q?4Ent2O7n6FjnmOvckoMYWTXtH1myZnBbVCUyrf2bcmZhXNf14OCeNAq/T+kl?=
 =?us-ascii?Q?3a4NgNipAtRBbiW3AQvgEIVJFSMjTO0=3D?=
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda57d98-7f1f-45ce-74d2-08de553b6277
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5239.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 20:11:07.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bpFIxfrcefQTk0ocVwyYi+RlQCBcXJjMIaVgKN4n7Rlfz+PZrhtHUwxvs8zNXwvIBzUn/Ia4Y3ty4/4G6DJER13bqJe0Xu5i2PF2K3kyuE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6937

On 16 Jan 2026, at 14:43, Chuck Lever wrote:

> On 1/16/26 12:17 PM, Benjamin Coddington wrote:
>> On 16 Jan 2026, at 11:56, Chuck Lever wrote:
>>
>>> On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
>>>> The following series enables the linux NFS server to add a Message
>>>> Authentication Code (MAC) to the filehandles it gives to clients.  This
>>>> provides additional protection to the exported filesystem against filehandle
>>>> guessing attacks.
>>>>
>>>> Filesystems generate their own filehandles through the export_operation
>>>> "encode_fh" and a filehandle provides sufficient access to open a file
>>>> without needing to perform a lookup.  An NFS client holding a valid
>>>> filehandle can remotely open and read the contents of the file referred to
>>>> by the filehandle.
>>>
>>> "open, read, or modify the contents of the file"
>>>
>>> Btw, referring to "open" here is a little confusing, since NFSv3 does
>>> not have an on-the-wire OPEN operation. I'm not sure how to clarify.
>>>
>>>
>>>> In order to acquire a filehandle, you must perform lookup operations on the
>>>> parent directory(ies), and the permissions on those directories may
>>>> prohibit you from walking into them to find the files within.  This would
>>>> normally be considered sufficient protection on a local filesystem to
>>>> prohibit users from accessing those files, however when the filesystem is
>>>> exported via NFS those files can still be accessed by guessing the correct,
>>>> valid filehandles.
>>>
>>> Instead: "an exported file can be accessed whenever the NFS server is
>>> presented with the correct filehandle, which can be guessed or acquired
>>> by means other than LOOKUP."
>>>
>>>
>>>> Filehandles are easy to guess because they are well-formed.  The
>>>> open_by_handle_at(2) man page contains an example C program
>>>> (t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
>>>> an example filehandle from a fairly modern XFS:
>>>>
>>>> # ./t_name_to_handle_at /exports/foo
>>>> 57
>>>> 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
>>>>
>>>>           ^---------  filehandle  ----------^
>>>>           ^------- inode -------^ ^-- gen --^
>>>>
>>>> This filehandle consists of a 64-bit inode number and 32-bit generation
>>>> number.  Because the handle is well-formed, its easy to fabricate
>>>> filehandles that match other files within the same filesystem.  You can
>>>> simply insert inode numbers and iterate on the generation number.
>>>> Eventually you'll be able to access the file using open_by_handle_at(2).
>>>> For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
>>>> protects against guessing attacks by unprivileged users.
>>>>
>>>> In contrast to a local user using open_by_handle(2), the NFS server must
>>>> permissively allow remote clients to open by filehandle without being able
>>>> to check or trust the remote caller's access.
>
> Btw, "allow ... clients to open by filehandle" is another confusion.
>
> NFSv4 OPEN does do access checking and authorization.
>
> Again, it's NFS READ and WRITE that are not blocked.

Ok - I will try to be more precise next time.. something like:
.. the NFS server allows operations against the file ..

>
> NFSv3 READ and WRITE do an intrinsic open.
>
> NFSv4 READ and WRITE permit the use of a special stateid so that an OPEN
> isn't necessary to do the I/O (IIRC).
>
>
>>>> Therefore additional
>>>> protection against this attack is needed for NFS case.  We propose to sign
>>>> filehandles by appending an 8-byte MAC which is the siphash of the
>>>> filehandle from a key set from the nfs-utilities.  NFS server can then
>>>> ensure that guessing a valid filehandle+MAC is practically impossible
>>>> without knowledge of the MAC's key.  The NFS server performs optional
>>>> signing by possessing a key set from userspace and having the "sign_fh"
>>>> export option.
>>>
>>> OK, I guess this is where I got the idea this would be an export option.
>>>
>>> But I'm unconvinced that this provides any real security. There are
>>> other ways of obtaining a filehandle besides guessing, and nothing
>>> here suggests that guessing is the premier attack methodology.
>>
>> Help me understand you - you're unconvinced that having the server sign
>> filehandles and verify filehandles prevents clients from fabricating valid
>> ones?
>
> The rationale provided here doesn't convince me that fabrication is the
> biggest threat and will give us the biggest bang for our buck if it is
> mitigated.

Ahh - ok.  I'm not trying to be convincing that its the biggest threat.  For
us, its a threat that doesn't have any counter measure yet.  For snooping
filehandles, we can guard against that with transport encryption (two
options there).  We're assuming that network security is a solved problem.

> In order to carry out this attack, the attacker has to have access to
> the filehandles on an NFS client to examine them.

Maybe - you can also fab them up from reading code or do it in the lab.
Maybe I should stop saying "after looking, easy to fab", and instead say
"easy to fab".

> She has to have access to a valid client IP address to send NFS requests
> from. Maybe you can bridge the gap by explaining how a /non-root/ user on
> an NFS client might leverage FH fabrication to gain access to another
> user's files. I think only the root user has this ability.

Let's not assume we have a perfect linux client.  We don't know what the
client implementation allows, or what bugs might be present there, or if
that implementation has been compromised in some way.  Whatever the client
is, we assume it might be able to send guessed filehandles because the
client implementation is out of the server's control and scope of trust.

That said, let's say we /do/ have a linux client - there's no reason to say
it can't be the root user there where root is squashed to that client, but
the root user can still use the path_to_filehandle_at() interfaces (as root
after all) to discover some filehandles and try to open by handle.

> I've also tried to convince myself that cryptographic FH validation
> could mitigate misdirected WRITEs or READs. An attacker could replace
> the FH in a valid NFS request, for example, or a client might send
> garbage in an FH. I'm not sure those are real problems, though.

For what we're trying to fix, those aren't in scope.  This work really isn't
interested in protecting against modifications on the wire or intercepting
other client's traffic on the wire and using that information.

> I am keeping in mind that everything here is using AUTH_SYS anyway, so
> maybe I'm just an old man yelling at a cloud. Nothing here is blocking
> yet, but I want the feature to provide meaningful value (as I think you
> do).
>
> Thank you for bearing with me.

Of course, I very much appreciate the improvements only these iterations can
produce.  Thanks very much, Chuck.

Ben

