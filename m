Return-Path: <linux-fsdevel+bounces-31883-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7E299C9CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0181C2289F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 12:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD2B19F43B;
	Mon, 14 Oct 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b="a42kvwFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from omr000.pc5.atmailcloud.com (omr000.pc5.atmailcloud.com [103.150.252.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F9E19D086;
	Mon, 14 Oct 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.150.252.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907956; cv=none; b=KH5GwYaFWDPO6EvofOmVTfXR1gGY2AAZo3C/4wrqdJ6dcK5fQ3c5ZiflXtfV2XR/NGV+tulGcQFAJJE/h1GgNRj9ijfNoTdja75/GcH3rNRgQSY6zFIhcyRuJPdwZ/LlqUbWjUc7jbOwGXabRWWgjvX8ElCKYFU0YzR5ELH85Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907956; c=relaxed/simple;
	bh=JZLBHV5vFgJKv+6jkMgKEJyH05oqWfyMdWfWaJ6792s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMhr7zK+BG1398cUJXGPnRUjpCMsPvCzfaakJjh32Y6ZCEK9lmgPMbuMQ9FPU2Y3fyMMzmzDruF3AKNRDRTjiNPjuQUqV9X58K+3qmESMx/H3NBqu3nGNcnuwBHrKMFqN6ct9uYZl9tKP7eHqmRSGQPUIPum6uLBew5YlXh8P6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au; spf=pass smtp.mailfrom=iinet.net.au; dkim=pass (2048-bit key) header.d=iinet.net.au header.i=@iinet.net.au header.b=a42kvwFP; arc=none smtp.client-ip=103.150.252.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iinet.net.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iinet.net.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iinet.net.au; s=202309; h=Content-Type:From:To:Subject:MIME-Version:Date:
	Message-ID; bh=7bzoUaGmGd5GJ8pEJdquUclvFKaCwupX43uBvA/GI+g=; b=a42kvwFP81OpuC
	SqIZ0ALxc+ySEPI6GBWLvLOxcJXjVdRy+WtQbXOlfRkbzj+kovllcRIXz4Xxw+IEVRSI0Z7hqYYa4
	yuaGlKx/PQ5fqipf4oMAqeWWP/iyFKnqMOViXBOgsSAyaciVVo7Kx+HOCTViEsLjAzsMZnQMlG41C
	2AdulAVLNfTESIeVKKQGwkEob2HmNC0XX0B10/uNZeVah/DRwI0Ld9eGyEW+uHmtV+yvw8nzC8n60
	hZlaS3DF+NaNyS7r7UXF8addHDFaAtUYm4GVxv7Q62+5fs4VKUdFVoyyzjy+9vzeKHkX5qhqNSmlp
	Zhc/kwfl/KLAq2DUWv2Q==;
Received: from CMR-TMC.i-0acf53ef05dcc86bb
	 by OMR.i-0dfa7ead5d297886b with esmtps
	(envelope-from <burn.alting@iinet.net.au>)
	id 1t0Jw4-000000004T2-3hw0;
	Mon, 14 Oct 2024 12:12:28 +0000
Received: from [121.45.199.178] (helo=[192.168.2.220])
	 by CMR-TMC.i-0acf53ef05dcc86bb with esmtpsa
	(envelope-from <burn.alting@iinet.net.au>)
	id 1t0Jw4-000000000KE-2GfL;
	Mon, 14 Oct 2024 12:12:28 +0000
Message-ID: <e0188174-a8ae-461b-b30a-bc7acd545a18@iinet.net.au>
Date: Mon, 14 Oct 2024 23:12:25 +1100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: Christoph Hellwig <hch@infradead.org>
Cc: audit@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net> <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net> <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net> <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net>
 <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
 <0e4e7a6d-09e0-480d-baa9-a2e7522a088a@iinet.net.au>
 <ZwzeGausiU0IDkFy@infradead.org>
Content-Language: en-US
From: Burn Alting <burn.alting@iinet.net.au>
In-Reply-To: <ZwzeGausiU0IDkFy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Atmail-Id: burn.alting@iinet.net.au
X-atmailcloud-spam-action: no action
X-Cm-Analysis: v=2.4 cv=E4bLp7dl c=1 sm=1 tr=0 ts=670d0aac a=ad8utJckiWseeaTPZMijYg==:117 a=ad8utJckiWseeaTPZMijYg==:17 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=x7bEGLp0ZPQA:10 a=jEJR_5qdvOA3Q1yG22IA:9 a=QEXdDO2ut3YA:10
X-Cm-Envelope: MS4xfFZ1mGb3gpeJ4QhT+lZ1HPnqxfoCLMTv+9F+DKGtZPHX3yX3sOtIBjJ1poCaXTW9Xr+qRhVSCHmFrP9c/dAKGLZGJBqnC1pTsV7HeNZnrs7ajIw096q7 nD+lZYwnYInsYl0Xx3vco6iZVrdHBzgFkbuoRQwaXyZk04nrE7jyjfCDQm60EMpk0I7eYpbysTAcSA==
X-atmailcloud-route: unknown



On 14/10/24 20:02, Christoph Hellwig wrote:
> On Mon, Oct 14, 2024 at 07:40:37PM +1100, Burn Alting wrote:
>> As someone who lives in the analytical user space of Linux audit,  I take it
>> that for large (say >200TB) file systems, the inode value reported in audit
>> PATH records is no longer forensically defensible and it's use as a
>> correlation item is of questionable value now?
> 
> What do you mean with forensically defensible?

If the auditd system only maintains a 32 bit variable for an inode 
value, when it emits an inode number, then how does one categorically 
state/defend that the inode value in the audit event is the actual one 
on the file system. The PATH record will offer one value (32 bits) but 
the returned inode value from a stat will return another (the actual 64 
bit value). Basically auditd would not be recording the correct value.

> 
> A 64-bit inode number is supposed to be unique.  Some file systems
> (most notably btrfs, but probably also various non-native file system)
> break and this, and get away with lots of userspace hacks papering
> over it.  If you are on a 32-bit system and not using the LFS APIs
> stat will fail with -EOVERFLOW.  Some file systems have options to
> never generate > 32bit inode numbers.  None of that is directly
> related to file system size, although at least for XFS file system
> size is one relevant variable, but 200TB is in no way relevant.

My reference to the filesystem size was a quick and dirty estimate of 
when one may see more than 2^32 inodes on a single filesystem. What I 
failed to state (my apologies) is that this presumed an xfs filesystem 
with default values when creating the file system. (A quick check on an 
single 240TB xfs filesystem advised more than 5000000000 inodes were 
available).

