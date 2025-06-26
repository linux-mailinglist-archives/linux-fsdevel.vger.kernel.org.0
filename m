Return-Path: <linux-fsdevel+bounces-53099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71596AEA211
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F6F3ACE56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFCD2F4338;
	Thu, 26 Jun 2025 14:57:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F12F432E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Jun 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949865; cv=none; b=abobgoaNlKa3f3PRbjGn8SRlIIwt8WRCL6+7SVWpWHtPVMHJHfTR5A5dFNP7gjEHlTUCED0GIkue3QPM6TOhUZVZcMsxutX3A8uY4Nckz2VrkT73eVkF3kQukwWK/wW9Kn4GZtIH4jlTVwSr6+lPpZQMYLVlvYWr4hz6eTXsrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949865; c=relaxed/simple;
	bh=ztsrZ2ghDkkt7vjAj7/2MBmD+lpdTjfpFkNsL0ZFcYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1FgxgMyOuHfTJmPozvfsJwa3RDWB7k6m7APFdSZrVQR95MXnTMkD7dGSigQwDFxc2SllibdIxB+WlLVdpTD/ndgmgP9EKytLRXzaIxmySjltdDwhBYiyJOTVW9kCZ96i3vRRR6fzrElrkJzch04P98RAgwc4A4EGEr7YghUGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-82-219.bstnma.fios.verizon.net [173.48.82.219])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 55QEumDf013726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 10:56:48 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id DD0352E00D5; Thu, 26 Jun 2025 10:56:47 -0400 (EDT)
Date: Thu, 26 Jun 2025 10:56:47 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "D, Suneeth" <Suneeth.D@amd.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH v2 8/8] ext4: enable large folio for regular file
Message-ID: <20250626145647.GA217371@mit.edu>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
 <20250512063319.3539411-9-yi.zhang@huaweicloud.com>
 <f59ef632-0d11-4ae7-bdad-d552fe1f1d78@amd.com>
 <94de227e-23c1-4089-b99c-e8fc0beae5da@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94de227e-23c1-4089-b99c-e8fc0beae5da@huaweicloud.com>

On Thu, Jun 26, 2025 at 09:26:41PM +0800, Zhang Yi wrote:
> 
> Thanks for the report, I will try to reproduce this performance regression on
> my machine and find out what caused this regression.

I took a quick look at this, and I *think* it's because lmbench is
measuring the latency of mmap read's --- I'm going to guess 4k random
page faults, but I'm not sure.  If that's the case, this may just be a
natural result of using large folios, and the tradeoff of optimizing
for large reads versus small page faults.

But if you could take a closer look, that would be great, thanks!

						- Ted

