Return-Path: <linux-fsdevel+bounces-33230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA99B5B85
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 06:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AFC1C20EE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 05:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735E61D0F74;
	Wed, 30 Oct 2024 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="riMv1qcJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA4F1CF7DE;
	Wed, 30 Oct 2024 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730267851; cv=fail; b=PTRxFtf3915w3OwxP5S6jIDS/7GfHauZ/3RRfIW+L8spTIS0OIQqSWa9On5VX1nr5lSLKD7s0uPKyd0rALHyFtTUq6DE1xi5xIPnnlsAoj6AJum0LfePw2Vq8mOQ+vJpmKfU8zqBmMWFoa3Gu4AQx8O+Sd1QGCw8OiGz2P4sGZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730267851; c=relaxed/simple;
	bh=mXi2RaTmsx8Gg4dQukUQ7psDHVdgH34dV3H3lcXxG7I=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=RqkiSO8g6vjpAHnQovxIHwOaONW9HWLcwXJfDu9fzBKmp7sZi3YNi8pRK3YcR57jCA0WhBDl/LDUmpEgxB3yNsm5CgPxXNbrA4o1O7xwZyQyrQCdVi+o2p2IqObL0uDz6mtkbQ+lf0nAmRiHyVd6fHvR1Br4lNLOuqThCmrwJfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=riMv1qcJ; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpuokDLG0VKJeEXE3MiuBSwWsKYwk4nM1TVQj9OWBcXFiU0m8ouXSOoIHZ2X83d37ccoBbSVhr1QPVTTPF54ugJw6sZsANLhWuE5UwhaJOu8R5dotoUCgNrgwFZIbSXtjqk6KUAc7Ary5VceqXtupWpW8YeSlmo0xMW6PLfrTvTGJcyxXS4f6eRA6Bg2kSpoOoiCxNYYXesSxF3VHZE6HmstqXeZ1QryPlM+8Tqoabhit8bmBEpAqLNyMnXpdq2Y7YkMy0AZy15f2OO5tRf/qYzC5ZHGzTILnlc1m8Mde+uu+C3j5cG0E8bTdXPJUH5aIqmi8c6vHizpidD61eVCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seoVHYzLrsCW+6bU9RbsrFMQ0zCQasTQubkEw4NFg8w=;
 b=J09n/Eyo9DNvHvutDpeP9xNh+CJrgorbwSz9ifyOCO2zT1Lx2UYAwNChw6BQi7x7PWb7eDQl8IUsLUuebBbI0WCJAY0mGpEXuYWCRp4WSkcKn0vfk9AWYxdBKaxa0xYuLym4hFVfa71boyh2u/0kNrlrlGOPj4ZYSUi0QfceyhwQV3gJ4KLrlsNmVee0JRm6KVhwin6ecBCgNt708Bqt6AQayhbUyQ/p1JxXMkYuuF4kfZkbibELnMaiJHFvs3KMUhHXHB+1CJOR0WUXKodzz1JJDaablzumStHCkfElaugyBv52mNddlS3Ba/6gZSZz2/4nPOx1BoD2gMtIK/X5hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seoVHYzLrsCW+6bU9RbsrFMQ0zCQasTQubkEw4NFg8w=;
 b=riMv1qcJuwAA+bNdS/oTcnF0Mej4FdyXX/H3/SFSwJHmUQcuyRZeucJVAlFgRsjfDghj1ZQAN8cekvHIeYfkfrIU+nmHKNmlMiwXNrkZ6QXMALTr53ipIIeMDRiU2cebIqLN8Ns+KzvShvrGe7HnOyPyfE9JV9FnNmVUQIzCO40IprhT6T+3q9F3iR/TMmKlH5eve5nKh1naazMIcOsmOvLtQglfqYwJyy+KgF4FE4990LZH8WfGRM2pF0LGW72yV2gChGhCd1rgu97W/C3CkjmyAoJbAZ0SZ9M+Gt+IXjCRf5bCYzC52J74Zy7pClhZ+OZXhYAx7tBKo8TE7WlHag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Wed, 30 Oct 2024 05:57:21 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%4]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 05:57:21 +0000
References: <cover.9f0e45d52f5cff58807831b6b867084d0b14b61c.1725941415.git-series.apopple@nvidia.com>
 <9f4ef8eaba4c80230904da893018ce615b5c24b2.1725941415.git-series.apopple@nvidia.com>
 <66f665d084aab_964f22948c@dwillia2-xfh.jf.intel.com.notmuch>
 <871q06c4z7.fsf@nvdebian.thelocal>
 <671addd27198f_10e5929472@dwillia2-xfh.jf.intel.com.notmuch>
 <87seskvqt2.fsf@nvdebian.thelocal>
 <671b1ff62c64d_10e5929465@dwillia2-xfh.jf.intel.com.notmuch>
 <87a5eon8v3.fsf@nvdebian.thelocal>
 <6720428aa1fcc_bc6a929439@dwillia2-xfh.jf.intel.com.notmuch>
User-agent: mu4e 1.10.8; emacs 29.4
From: Alistair Popple <apopple@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
 logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
 catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
 npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
 willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com
Subject: Re: [PATCH 10/12] fs/dax: Properly refcount fs dax pages
Date: Wed, 30 Oct 2024 16:57:09 +1100
In-reply-to: <6720428aa1fcc_bc6a929439@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <87zfmmp1z7.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: SY8P282CA0027.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:29b::25) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4f5d63-fee8-484e-3633-08dcf8a7b802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3pSkkE9WmgnebbFkEm4Jziap/vr8AJm0QeoQ1l9M9RupyI/Xm+5AQH819ty9?=
 =?us-ascii?Q?pJsFmmsNwVx9RLvpj4rfbsPh+ysMaLiwBd2qxVD64WSFyQlPlZ8UY7dJUoe1?=
 =?us-ascii?Q?bNj3JPCk888bvIYijzTasCnD6001odTjJ/xXtlAa6B451BGDhKImgZqBI1LL?=
 =?us-ascii?Q?PHAslwIDYZp7rKiiYi77rcM4Yevh/x48oN37gYBrjB7ew+bJImtf7AG/d1cO?=
 =?us-ascii?Q?sCXvO+ajztMY8Xv3j2vetDP8/5YHuy4rBhtMB88tMPvn30OgtliefngHu3K9?=
 =?us-ascii?Q?zja4c+sLGMqlG3qU8QcBtil1wqmt6WfmEa3ZaiO8HfNHGiDVBrFvI37+kLgu?=
 =?us-ascii?Q?jYz+eDo5Ib2lVnbyf1YbkBYyA1FDo77K7Z8wHSVMfJ9nJHSF4yC/YvBjDmjr?=
 =?us-ascii?Q?C+gGgR3KCjgSkLyeJuljpIvtVudjFywi8cQXTADeKGRPMMARDTPi0y2Z3T9g?=
 =?us-ascii?Q?lorM1omO/skJgQEIy9+dqtRhxzVMOXZkukdDoMmGsyJTZ4VZHRhAZzXqaJcc?=
 =?us-ascii?Q?5/6r45n1Ejh2RbLpqatV0e/dXXf1FxNIU7uzndEE9NvTjRWAeB2NCAsPWQ9R?=
 =?us-ascii?Q?SzSQpLO09ZSJzepE0zpd+FyZA/azYgBXgxylyKc/jKxXpKlCI66N/WWaVQtg?=
 =?us-ascii?Q?Z8PZtrNFr4FOicl+j5SzYd/P3lLZA/MoHS3j1HqN/87Qz9Xi4Su/irYUBkFt?=
 =?us-ascii?Q?uviEK5DTh19q8WRLV1W8sNN7PkZqkzJf3Hk/+lNxDprYaRuxTlED1aR0JIsE?=
 =?us-ascii?Q?iGSI0g3uMQdQSppOjEdWBPPKy7NW7G3oPKgj0aM81ICuvQJLYvx7cE3rOy5m?=
 =?us-ascii?Q?8SY6PqFbqtvwb0PQRLsxloYl3VyChtZgOTHGbTVV4rzdrN3UEpqls+sI+/Xz?=
 =?us-ascii?Q?jaQUEUTpI5wvZ85wEtdEMrHRSvfA0GuwDsUFA8pBT5iBWg6gidnZMctH1hEi?=
 =?us-ascii?Q?jXgQgGH818RkIK1BH7g2WZlh3AEDF7/bCsSqRgdT/bqSyJ5qxNfhJxE/bccl?=
 =?us-ascii?Q?EMH1Wk7XASed9z3al54Q5TPnINTspmzydiTbwXbA6yvamNCejB73odD7Spyw?=
 =?us-ascii?Q?lNT2ZZsqjIzYHdPs0Ovk21/tKqWuiRUAFr/FRDzNFMhwoFtkA7TqPMxd/qjt?=
 =?us-ascii?Q?dh5iTikecWByzqsjC6PQ+3DioK2JrpXeVHZEwGGdMkO9XO0IsA6/VCdHiuqI?=
 =?us-ascii?Q?QvPTKIIhpyeD8C/DUPaXVIXHWc/Rq1hygizQpI+S4ya7ZfcuJ/uPBkQk9yAw?=
 =?us-ascii?Q?wl7T/wM1ZmJ9HUbwzpAWR02kHsRObJ4HaCKlGfXOYRqul7zznhSYwgI46dEh?=
 =?us-ascii?Q?rNXMxl+gwh1CPe8DHMG6sTuY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3gfd6XYUTKqMTSVds+yQCxCs1h/waGqBMZMyKheHrkSbaUVWKijZB2wpnKv3?=
 =?us-ascii?Q?EmeEhQSApJxj8qjhzDgxRHKDNOPxMLlrz1nXce+4JPf5EXJOYIC0JUT0Os7/?=
 =?us-ascii?Q?EX6OW+vpM5M21U2h0tHDuvLa2LxWSFsPpZqynUHWVq9rZn5nB66ZSInvOjy2?=
 =?us-ascii?Q?FNmcax5NiVUy0gy0m0se+9SX/QCKQi+of7g10Gf+RbM5Xr3u5SkBj6gZbfGK?=
 =?us-ascii?Q?pWnMFFIK4CIVThe4eW/ZFEpzYDeyALayldmnGSr3f69Z59k/qwBMdiSaFc+x?=
 =?us-ascii?Q?biAt5ZPyBQcjgQrbwt8P8mar42AuWCQTiFN5kExvfsRCY2rRX1z+WpFI8wSy?=
 =?us-ascii?Q?kjHYrQh66SokxhD1woWnHyO+3aqMpdWpKZ+v861yHhY+G4dA+LxaLuWceSDV?=
 =?us-ascii?Q?trqrPy5MsNt6QohcHJmGJzTYcKAn9JzRfMaBFWe3kIcV8EiWiNbTRr1o41RX?=
 =?us-ascii?Q?e7WTqMLT+IrBkMMmbtf46GA7vFSm71mB+RhgBr4UF2mXL3+zjPCdOCHQPvH/?=
 =?us-ascii?Q?CZTrxsaHlurBBm0XZO8TxWY0mJQVVTQWE2JI+8jRa5Mzt6vxV4BZN7fVF2gA?=
 =?us-ascii?Q?k+8XKJx2dK/eIiEk1ZJZ3R32JnKAm5nlXsbRaibTC/bCWdOsT1n0patetQSv?=
 =?us-ascii?Q?5Cvid6qqqDR6c/a+3fiSRY/32GPFIGk2Nv6Nrc5FsjlLb3PvGBxCkIk78xVC?=
 =?us-ascii?Q?eTxw1BRnstQfZCvLhvfM1Hj1VDLupp5NT+7J9sMvUUef0XDeurCL49QZ/lVB?=
 =?us-ascii?Q?X0oyuTHigEpZu0PoN3GCssjiyVZ2Su02jyvIL4rwA7d/9hOkTYCbP4DnByrv?=
 =?us-ascii?Q?w87QFteQBtPMlh0+EDHw6ztomJHgo5KFafBji06t7CvUbiSpA9ucd1rvW/FW?=
 =?us-ascii?Q?lR8FsOUDI47TndpfrGzFc82LJCRTTB4sBfNfiD0RporO1C4gNLn3aLZNH4ri?=
 =?us-ascii?Q?NDwFJqrMkJ7/N9s1ToTB+c5M40QrFwsvuI/t/9O/OGinGD3Nmo5LyqJ+axq5?=
 =?us-ascii?Q?lTIncbKfQVY6s7QXDF/wMBitC4v57LF0p6A4afsUn1LP1/nb7OFUJo+1+bHE?=
 =?us-ascii?Q?fG81jwfjP16DMH1sHQCWoGz+eSL1JrgBpQn/1PiTFEE3vMazllmLdPG+H+/s?=
 =?us-ascii?Q?5Yei/igI048e1sjSsU4ASjpZxBvFt89NGlvTH4HB1d+SwVq5mscA9PZvQzGW?=
 =?us-ascii?Q?y8b5TfIaHkLlcNKs4nybxs2sULpF5/bwZUEcrrfCgAUzeZruyNGZd6e8LcNd?=
 =?us-ascii?Q?ChR0f29rXZtfeTlauToxCylYJ4KkzDvCx93Ouva+bLvxMCwfnDEDwuwho+HG?=
 =?us-ascii?Q?xLtaw0wpX8F08lAEsHYeoyYFOV8bxa6ToVnZQIet9B7JUuj35SdH4CQs+RjF?=
 =?us-ascii?Q?gAi/86D7+n+T0PhJrEeujCObiqfk370L9EwgNKzEEs0LMcDM2R+ZY3+8VHQW?=
 =?us-ascii?Q?sAE5iOFJ2C499J/nu2q1gdy4v2vLIHqRrkbOTb7jy5nYXkl7M/7eGghFJHWC?=
 =?us-ascii?Q?uyrQss3aYDHrGWPJRDOsa8GU5jICRd9vsLe4rpb/g6O19pccGPt2SHXbkKsV?=
 =?us-ascii?Q?m4kTQ5rbbKyHMmOA5gakRr4XiVAZ8nbdMwwvCrmQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4f5d63-fee8-484e-3633-08dcf8a7b802
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:57:21.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ErY3DDaOBqKHKa/awD/i1QRNjgfXhEi2rpUpl+sjLfAEah6ReENrlnND16SJV9Ws8iw5U1iTqOkq6p7D0wToMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386


Dan Williams <dan.j.williams@intel.com> writes:

> Alistair Popple wrote:
> [..]
>
>> >> > It follows that that the DMA-idle condition still needs to look for the
>> >> > case where the refcount is > 1 rather than 0 since refcount == 1 is the
>> >> > page-mapped-but-DMA-idle condition.
>> 
>> Because if the DAX page-cache holds a reference the refcount won't go to
>> zero until dax_delete_mapping_entry() is called. However this interface
>> seems really strange to me - filesystems call
>> dax_layout_busy_page()/dax_wait_page_idle() to make sure both user-space
>> and DMA[1] have finished with the page, but not the DAX code which still
>> has references in it's page-cache.
>
> First, I appreciate the clarification that I was mixing up "mapped"
> (elevated map count) with, for lack of a better term, "tracked" (mapping
> entry valid).
>
> So, to repeat back to you what I understand now, the proposal is to
> attempt to allow _count==0 as the DMA idle condition, but still have the
> final return of the block to the allocator (fs allocator) occur after
> dax_delete_mapping_entry().

Right, that is what I would like to achieve if possible. The outstanding
question I think is "should the DAX page-cache have a reference on the
page?". Or to use your terminology below "if a pfn is tracked should
pfn_to_page(pfn)->_refcount == 0 or 1?"

This version implements it as being zero because altering that requires
re-ordering all the existing filesystem and mm users of
dax_layout_busy_range() and dax_delete_mapping_entry(). Based on this
discussion though I'm beginning to think it probably should be one, but
I haven't been able to make that work yet.

>> Is there some reason for this? In order words why can't the interface to
>> the filesystem be something like calling dax_break_layouts() which
>> ensures everything, including core FS DAX code, has finished with the
>> page(s) in question? I don't see why that wouldn't work for at least
>> EXT4 and XFS (FUSE seemed a bit different but I haven't dug too deeply).
>> 
>> If we could do that dax_break_layouts() would essentially:
>> 1. unmap userspace via eg. unmap_mapping_pages() to drive the refcount
>>    down.
>
> Am I missing where unmap_mapping_pages() drops the _count? I can see
> where it drops _mapcount. I don't think that matters for the proposal,
> but that's my last gap in tracking the proposed refcount model.

It is suitably obtuse due to MMU_GATHER. unmap_mapping_pages() drops the
folio/page reference after flushing the TLB. Ie:

=> tlb_finish_mmu
    => tlb_flush_mmu
        => __tlb_batch_free_encoded_pages
            => free_pages_and_swap_cache
                => folios_put_refs

>> 2. delete the DAX page-cache entry to remove its refcount.
>> 3. wait for DMA to complete by waiting for the refcount to hit zero.
>> 
>> The problem with the filesystem truncate code at the moment is steps 2
>> and 3 are reversed so step 3 has to wait for a refcount of 1 as you
>> pointed out previously. But does that matter? Are there ever cases when
>> a filesystem needs to wait for the page to be idle but maintain it's DAX
>> page-cache entry?
>
> No, not that I can think of. The filesystem just cares that the page was
> seen as part of the file at some point and that it is holding locks to
> keep the block associated with that page allocated to the file until it
> can complete its operation.
>
> I think what we are talking about is a pfn-state not a page state. If
> the block-pfn-page lifecycle from allocation to free is deconstructed as:
>
>     block free
>     block allocated
>     pfn untracked
>     pfn tracked
>     page free
>     page busy
>     page free
>     pfn untracked
>     block free
>
> ...then I can indeed see cases where there is pfn metadata live even
> though the page is free.
>
> So I think I was playing victim to the current implementation that
> assumes that "pfn tracked" means the page is allocated and that
> pfn_to_folio(pfn)->mapping is valid and not NULL.
>
> All this to say I am at least on the same page as you that _count == 0
> can be used as the page free state even if the pfn tracking goes through
> delayed cleanup.

Great, and I like this terminology of pfn tracked, etc.

> However, if vmf_insert_XXX is increasing _count then, per my
> unmap_mapping_pages() question above, I think dax_wait_page_idle() needs
> to call try_to_unmap() to drop that _count, right?

At the moment filesystems open-code their own version of
XXXX_break_layouts() which typically calls dax_layout_busy_page()
followed by dax_wait_page_idle(). The former will call
unmap_mapping_range(), which for shared mappings I thought should be
sufficient to find and unmap all page table references (and therefore
folio/page _refcounts) based on the address space / index.

I think try_to_unmap() would only be neccessary if we only had the folio
and not the address space / index and therefore needed to find them from
the mm (not fs!) rmap.

> Similar observation for the memory_failure_dev_pagemap() path, I think
> that path only calls unmap_mapping_range() not try_to_unmap() and
> leaves _count elevated.

As noted above unmap_mapping_range() will drop the refcount whenever it
clears a pte/pmd mapping the folio and I think it should find all the
pte's mapping it.

> Lastly walking through the code again I think this fix is valid today:
>
> diff --git a/fs/dax.c b/fs/dax.c
> index fcbe62bde685..48f2c85690e1 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -660,7 +660,7 @@ struct page *dax_layout_busy_page_range(struct address_space *mapping,
>         pgoff_t end_idx;
>         XA_STATE(xas, &mapping->i_pages, start_idx);
>  
> -       if (!dax_mapping(mapping) || !mapping_mapped(mapping))
> +       if (!dax_mapping(mapping))
>                 return NULL;
>  
>         /* If end == LLONG_MAX, all pages from start to till end of file */
>
>
> ...because unmap_mapping_pages() will mark the mapping as unmapped even
> though there are "pfn tracked + page busy" entries to clean up.

Yep, I noticed this today when I was trying to figure out why my
re-ordering of the unmap/wait/untrack pfn wasn't working as expected. It
still isn't for some other reason, and I'm still figuring out if the
above is correct/valid, but it is on my list of things to look more
closely at.

> Appreciate you grappling this with me!

Not at all! And thank you as well ... I feel like this has helped me a
lot in getting a slightly better understanding of the problems. Also
unless you react violently to anything I've said here I think I have
enough material to post (and perhaps even explain!) the next version of
this series.

 - Alistair

