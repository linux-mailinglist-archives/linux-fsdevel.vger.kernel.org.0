Return-Path: <linux-fsdevel+bounces-44379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEFEA680B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 00:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8B84237F3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 23:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776C920E6ED;
	Tue, 18 Mar 2025 23:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUdtzA6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F4A207A0F;
	Tue, 18 Mar 2025 23:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742340460; cv=fail; b=eOmEdbedO63nE4DDKohW52bFaKQngSXXKp2enmzYId57Pn6f1Ccc8uWztAEJsuufZRdl1R1k7+Dxl1Cro+bM35xbLKkMPz4vqM3KyEMou6j4c2xFf+tbU+tgX3oEm7RR14DT0HH5aD/KjE0tQ+AFgHTAW46jT6LWL3YaqqVQwV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742340460; c=relaxed/simple;
	bh=UPRWnWT9px/nAXuWA9ofSrh3xTHXxZSc8fScWGSbbaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OxxNLnLIAvp1dknyFnmUFNYZwkBDo1F0DQmE9t2Fb7oUnfuDR7W7G+iGO8R8CnUIpeAjI0fndKbU3QWZmMxeZSgOJcvwwK9wBstxGPt1h9VlgCPX9vx7IKcOwLUzeqRbYwvBwtFRrxuebsq7YjTDiawmbNRI5N8nJOMyXCmfR+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oUdtzA6p; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsyOctzUlRH1DZ96TBdMG0CLiyTgdM0qqCwsing4OHxlvMb9xCHCvxGbSs1xANIC9iXFV3LsAD/2CGhFcIB4UoqA6gThwCtGPPYG4SFcXO2V8VLSJaY1Tc/gj2verM4QzBMWjABHrKeVnUwR1NTuN1NiqYBHJxqNsSNUKreaSoQnYBCYQGU4PZybzzFjOMwIrdz+6BDgc1Yr+iY5JUqx53AZzeKgh/JIPDSWBDwWW66cnZjgDy66sC5Zd2Lw1Vhy8rrsjrEz8/7g+30G7D8NphYnDxikEh9xK8NKUiIgzYlxjYEYMpVfneZnbvm3fCu5VqWvYQTO6lHxnqXxH7HVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsD/cNP7h1e8utnjLBLKS6ANzPTwpah93KDTAMzLMaA=;
 b=Pq5luflQlBlkRyL00Q3ePhQ3Z31eIKa5lIB9k8gGqFqYHNytl/AY+NKhxSLflyLO181UhEpBiW1AT1CsqzeQRAHMw8kZEdDl9x+NHSl7ib6JJhjMZwxAdEymPF9DZjps5yqK1hwdVVsfCRib7Y+UzabsX2Oqz/I169rsR4DKAxwYRVzyxxSKg9wK3FMmenWzkr518Juj9VWkMN0Fi5qhALJeDN8ffYiKSK24ah1H7WPgMryKvxKwPi+D9OzVUGnw5wJgFJM0iDgBxHUwIOfIsegRxk7qIftT4Sssrcthe58SyU+DxiZ61LWaWVy7gD0VLGfkq//wTPGQ4JcPvu59eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsD/cNP7h1e8utnjLBLKS6ANzPTwpah93KDTAMzLMaA=;
 b=oUdtzA6pM5x/qUWDXl5wctVTWMU52MG/6x2zSQN9pAsqOu1GDNoWs0QFpTEO/w9yDtlkTX8COzuzbQY2UPVGmfB+xRpeZGob9UhW10iMfijsn1qTFCfnJ8h85QBD4bbdems1ooZ5LMP1uA5NU3lDWQq0A/W5j3/mj9uSXpu7nLFI5ZGvGG9/f4rw1rg8nvcQz/0vwD4gs4QRc1ZovuRe0G9RqBY7PyuLZmbfXmEfC1swYN/KDFApUYXbeLc6bKcZih7ftofzXVVsHjenmPmxi17XCEu/E83zkN/ecGZhC/xoE3SzCIUZyNa3hA7SzPfPqaU3dcfaS+BKamBPAQgXYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 23:27:35 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 23:27:35 +0000
Date: Tue, 18 Mar 2025 20:27:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <ptyadav@amazon.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Hugh Dickins <hughd@google.com>, Alexander Graf <graf@amazon.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Woodhouse <dwmw2@infradead.org>,
	James Gowans <jgowans@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <tatashin@google.com>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Dave Hansen <dave.hansen@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [RFC PATCH 1/5] misc: introduce FDBox
Message-ID: <20250318232727.GF9311@nvidia.com>
References: <20250307005830.65293-1-ptyadav@amazon.de>
 <20250307005830.65293-2-ptyadav@amazon.de>
 <20250307-sachte-stolz-18d43ffea782@brauner>
 <mafs0ikokidqz.fsf@amazon.de>
 <20250309-unerwartet-alufolie-96aae4d20e38@brauner>
 <20250317165905.GN9311@nvidia.com>
 <20250318-toppen-elfmal-968565e93e69@brauner>
 <20250318145707.GX9311@nvidia.com>
 <mafs0a59i3ptk.fsf@amazon.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0a59i3ptk.fsf@amazon.de>
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ebdee6d-685d-41ad-be9c-08dd667476bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q53noda3R8aMYbfatufiGio4q/n3sUfoojImqRJrXQRVPfHtBA67wXQqEud8?=
 =?us-ascii?Q?cq9oTcGCKWvRLgQVKvGiUS12xdR/oJBKWoNOm2ScPW7Xg58hfW3G3ZPcYwHV?=
 =?us-ascii?Q?JpPhrjWFdlA77N5xEY94eJR+qGfDeemDoVxRjqgTwwXc8CGOM4NHXUVkea/w?=
 =?us-ascii?Q?gUDJ/GXg8w5ql2EGPS36/rAOMebSvOzwmCRatwWPgcO44EddqbYx+hYUFxNq?=
 =?us-ascii?Q?K6OF7npf+53F9lf4iK//6BRoYA7GFw3QZnv0RO8GB7nK4XSF95XHNcPty17/?=
 =?us-ascii?Q?1QIJK74Uvm2sKjmUno1MRDdQww/IYta95cK2ROL9KB7kWQM3/T55J5+SkqCm?=
 =?us-ascii?Q?uDFZMYTU0mWCdcGm21STw7Vf6IM/QgBGvuJ2l+LGZ66O7OC8WH+IcYUXzV4C?=
 =?us-ascii?Q?xr/VKyN+VmZ4DmuW30LVqu1jsvCPfVOtEQ65IER196T8dAT7PKD+E/vvboYs?=
 =?us-ascii?Q?wnJm2oQ/BvlmQqaOfjNuFl0jUHgU9tmKhcl/cFTcxwu3dz994SWUKk4CuezI?=
 =?us-ascii?Q?YVbG0TrGm09bZuswyYl+6YAI9r+OtipJVas1bEHcz9FLP22r+2PKwjZaWWG5?=
 =?us-ascii?Q?lZdgwiqu2fSFBJEeg9eVlVoE+FtJabRJZdIPoGLGcULoi66Sa81K4Ch4M6aH?=
 =?us-ascii?Q?xKG+Ras8fXnDmD7SnyAAa0YKwTvhxVodv0bGi+VwhaHJ8doE01azs6S5V19b?=
 =?us-ascii?Q?ude+pjCpXALUU0/PAeAScTCbL3Djei499pErhL2uUXQxDjRgtYZB9OTGsyeZ?=
 =?us-ascii?Q?kLfDOK6wXW0Cmpz5nfr1nYn7e5pvWGyrnpv2cpBvWJ4kTnwaqwjeFBV5MKZ0?=
 =?us-ascii?Q?RVcVXzrGw5YYfoFKDksYAoES38yrdPGWNO2g4t5iwkTOQsQlCMzkTDg2vmZV?=
 =?us-ascii?Q?q58stF2MgU3O1N0o0I4abRCrGqkUL9NFL/cylHlfggqOy31rJexnUuZH+uG8?=
 =?us-ascii?Q?fm1Kaso+gqhu2O+Q7U5aUppSwQbs1Hfxsk0DqPrIDZBDfPEzGk0UPy8CgGmR?=
 =?us-ascii?Q?pJpWIF0OvQ8I4A1VJxLsoPedgWWY7i2fzi+m/n3I2gutsH1DQnCc/3uT507O?=
 =?us-ascii?Q?iySQCRhfW+xqB/xj5sonUhdQWJ5WSeq9tATC3eofq8BkgU1WaM8Bvbc9TmqQ?=
 =?us-ascii?Q?bFXhQc6uHBrQvjK3KtsxBvF0S55iVhWKDxQ9ykAQlV5WxnBAVIrOXbshdsxy?=
 =?us-ascii?Q?6vRSZAMYYSP0glmcOOpaXlZ2n0ktLPHf4X7lftjDW7z2/Okitjzo8S0mR2bS?=
 =?us-ascii?Q?/sS73Ahmxc+lhgESUazQBBFlqZ7IrQ4nwH19a2Nvc1jkfLJ4ko5H7VhLZHWf?=
 =?us-ascii?Q?YxrF9xd47GuDvYXaOschALyd2Hh6A6U4eHOsTzHQdHeekHcEJYa8BqxePC0w?=
 =?us-ascii?Q?NIWyr5J3YPLvikT1sm7rGQx0aEJY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VyhMP1+HTJKiSJuyVdw0SPBycw/qFuk5ZgC2vNCSgRWVA3WfX6FyNu19Ti3Z?=
 =?us-ascii?Q?Zke7ZXC1ATnUbO8OvfoEL6X87216M3VVW0vFuQBFJj7oMv/RH2FmWe7uaDYm?=
 =?us-ascii?Q?bq8QVP4S4p2VNkgywiBO6Jek4GKgzbzXRJrM5sIuu7FRbJGgf/+MtTdYyCV4?=
 =?us-ascii?Q?H6SqAocWHwJcYM4OH98+5v52nAvbMhls29cNnSmpBRNkV8NEU9eGxuerIwpY?=
 =?us-ascii?Q?AaGvsueVZe1HTz20CBPau/eM6AzUXzS9Uv1ps+j/DoasIXvCwSgpD2rc3/S5?=
 =?us-ascii?Q?5dqhuhRksWaniOzq/fqEQocdaGxWutqbztz94Zk/VUP4bZgytddkTmzdAPP6?=
 =?us-ascii?Q?wpmOuKFQVQOrDxAbGCdp9+B4DVfGHQ+qKH5zJfurPVYRegxjUdwnl57k61t8?=
 =?us-ascii?Q?kIiWcX/4J+sEAFGFnDVmt63Bujv3oc7bOvW2JOUmc45n3qViVasDpmuHO2Pa?=
 =?us-ascii?Q?am7LTp6sko3K+wJnlzgWt2AsfinyNpsxnv2f9IOmu83K4V8XHQQPPjOPSdzX?=
 =?us-ascii?Q?DS3/7e6WuC0Pj9wYOaKf0skcdl9EUqV1ZhC4O0CeZiKuG2SuVDcg5eKTxhWD?=
 =?us-ascii?Q?NL9Zh53B0FQGD8udTXzFoE/r4VcI565rqKHZs71NS8Y5I9sGKzsYt9y/6jIZ?=
 =?us-ascii?Q?JtiA4WvBKgfEVItFr+PTUFwsaw4WxAsG5otuNg6yLuWLTZ4bTfC4MhnPALgA?=
 =?us-ascii?Q?2bc3X4oGB4UpRllpLiPKaKeW3hZ6htqJ9T+jJLHucFjNJYfm19MWQ7kg85D0?=
 =?us-ascii?Q?qZ+Biky3H79ZnN1Ci7KvRCWo1HIlZsdPlu94bB/E1kYXeao6o7lHCrNmmbb5?=
 =?us-ascii?Q?0CHoOmjy5kpK8/zb1E0UyfDaF2d6bGYBySpDWz0ab7bWMXm/Mv+rLnLmN3u2?=
 =?us-ascii?Q?ZZdO5ePgb8LLmfofbyqRPNy3SwWmUYA2w+2mEBPaJ1mAgjTR09gIC6yy30M3?=
 =?us-ascii?Q?bYXVnk62Rmwr5eM12ty0Ae4UtKnusjffvvIn233K4kP9yUv+A3Ld4hceW+5p?=
 =?us-ascii?Q?Tc26rRbPke6dwImG7uuN+wJYkfyd6bUAv81Ke1V3FxA8OyNGOmtjDYW+xWER?=
 =?us-ascii?Q?a2b/g38xevEDNCLaciaZWdWH2sOi5Wln3xvNxAgjrndzd9UCrZngIwlvvOcn?=
 =?us-ascii?Q?ZumQ7bwwMWWN6oOStvRCRCNBljUfQkb2zb7f8PeVvvdQwRvvoFy/l/Yc2Yri?=
 =?us-ascii?Q?Q7z7ix8ywlLOE3KegvAFS0hKRyrsEx0ZZgUx8wG3cQFN7GQYV7gh5brZDOYa?=
 =?us-ascii?Q?PTg1YRAVoC0YZwNpiBFzm+SvkjsV8/3WGqrUwMxyfVn13BOh6BMO5e/3LnQ5?=
 =?us-ascii?Q?Ca4vZlwpebJo35aiBlVLsei2ssOpsmGKwtXDDz7WLg6+hg7h3cIr5KRhy1Aq?=
 =?us-ascii?Q?o1WrNJP95ve+lcn8ZKNrv2DWCIBt8ZmC2WEkYGgOnw4/Sh6bP727kQ0Y6FAJ?=
 =?us-ascii?Q?tBqFOFreN+tZJ/OcC/wouzxU/BLxCRjzlSGxRXcnWWhHo0ST8bIIdOqziWbR?=
 =?us-ascii?Q?vAMY1Gk8tF2tNI96XqHpUuzTSn3pfmFnsafe0rgA9JNgc0sRVikCXVfFiqME?=
 =?us-ascii?Q?4HOTdymAtqVUNJmAoKc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebdee6d-685d-41ad-be9c-08dd667476bd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 23:27:35.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 83HNvW/1NSWvVj9wY+Yr4I0iyYpOahzLa7KDSFhiUJgKppUudCqxX6bsf7R61sXo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

On Tue, Mar 18, 2025 at 11:02:31PM +0000, Pratyush Yadav wrote:

> I suppose we can serialize all FDs when the box is sealed and get rid of
> the struct file. If kexec fails, userspace can unseal the box, and FDs
> will be deserialized into a new struct file. This way, the behaviour
> from userspace perspective also stays the same regardless of whether
> kexec went through or not. This also helps tie FDBox closer to KHO.

I don't think we can do a proper de-serialization without going
through kexec. The new stuff Mike is posting for preserving memory
will not work like that.

I think error recovery wil have to work by just restoring access to
the FD and it's driver state that was never actually destroyed.

> > It sure would be nice if the freezing process could be managed
> > generically somehow.
> >
> > One option for freezing would have the kernel enforce that userspace
> > has closed and idled the FD everywhere (eg check the struct file
> > refcount == 1). If userspace doesn't have access to the FD then it is
> > effectively frozen.
> 
> Yes, that is what I want to do in the next revision. FDBox itself will
> not close the file descriptors when you put a FD in the box. It will
> just grab a reference and let the userspace close the FD. Then when the
> box is sealed, the operation can be refused if refcount != 1.

I'm not sure about this sealed idea..

One of the design points here was to have different phases for the KHO
process and we want to shift alot of work to the earlier phases. Some
of that work should be putting things into the fdbox, freezing them,
and writing out the serialzation as that may be quite time consuming.

The same is true for the deserialize step where we don't want to bulk
deserialize but do it in an ordered way to minimize the critical
downtime.

So I'm not sure if a 'seal' operation that goes and bulk serializes
everything makes sense. I still haven't seen a state flow chart and a
proposal where all the different required steps would have to land to
get any certainty here.

At least in my head I imagined you'd open the KHO FD, put it in
serializing mode and then go through in the right order pushing all
the work and building the serializion data structure as you go.

At the very end you'd finalize the KHO serialization, which just
writes out a little bit more to the FDT and gives you back the FDT
blob for the kexec. It should be a very fast operation.

Jason

