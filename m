Return-Path: <linux-fsdevel+bounces-56062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B6B128A9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 05:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB0AE1C268F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 03:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF231E51FE;
	Sat, 26 Jul 2025 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fEBgv/hf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937731E412A
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Jul 2025 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753499419; cv=none; b=bjHoru1WouaNakbEDpShHPDPduS6kQUkYIBxGg7vlV0h95UAA5wwkCtwK84ltJGf3sfjBEICcN4RuS07twgB6W12/xcCGB+1lv2klBpZdqmJ0kc8YuL+Khu0szC63Lpyrt//zfn9c84s68/wJr47KJI1WSZV09w1UfkQq1yYCp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753499419; c=relaxed/simple;
	bh=mAH8Yj6gzn9GcwjVv/hNDs89nxL93fomisgORjn0VKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLlVd8m0wUBtr4/6WvELJrppAquuRbAqvdM2F6iTKUmiPc9KwlOKnHTrkqESjO045mb0E2c2ozXWqnEPkO/7ZAHxAljoe5Q8PmbDe2EseX03GyE9xQSFfd1VpjAzT76fZNBUuoDD4mqBgIAL5YtxI77FIMnQYSStcElmtvtCcjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fEBgv/hf; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-187.bstnma.fios.verizon.net [173.48.116.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56Q39KIo000331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 23:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753499364; bh=YSr4qw00KAYudz4+C02hI1TeYU9XzzWkEqDLG4aNg/o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=fEBgv/hfDiz9k0zx4fEMSQqZ6sJld0+33wK3VMjWUjz7n1wYxFXnduydaF2EplDdo
	 0i9vug5O6crwlFPSYYuW+xPPTp/LTkKSFfvR2Fw2V7aGN0hBoJV2C3VdV7SuuPrCsf
	 Vj07oRl2gHsFqo9b/RpWayhRr4qkOLZnXMd3qru53LxOpp5mQy0WDUjZDHpPIoxlTn
	 hwGsgoFSDQa7skJ00/owq0lNe1741TY86TnV1BxCPgl8lRYxMbAupJLG4Sal91793L
	 6lsHOB/V0O7VGUA6+o/eGMXVV4HOfCgVzOG0XepwGk/g8tHwUfHLJt+dQKdckFE7ZZ
	 G6gB81760QUNA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id E441F2E00D6; Fri, 25 Jul 2025 23:09:19 -0400 (EDT)
Date: Fri, 25 Jul 2025 23:09:19 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux@roeck-us.net,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] ext4: fix crash on test_mb_mark_used kunit tests
Message-ID: <20250726030919.GA273706@mit.edu>
References: <20250725021654.3188798-1-yi.zhang@huaweicloud.com>
 <av5necgeitkiormvqsh75kvgq3arjwxxqxpqievulgz2rvi3dg@75hdi2ubarmr>
 <20250725131541.GA184259@mit.edu>
 <2f53f9a8-380a-4fe4-8407-03d5b4e78140@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f53f9a8-380a-4fe4-8407-03d5b4e78140@huaweicloud.com>

On Sat, Jul 26, 2025 at 09:42:37AM +0800, Zhang Yi wrote:
> > In the future, we should try to make sure that when we modify data
> > structures to add or remove struct elements, that we also make sure
> > that kunit test should also be updated.
> 
> Yes, currently in the Kunit tests, the initialization and maintenance
> of data structures are too fragmented and fragile, making it easy to
> overlook during modifications. In the future, I think we should provide
> some general interfaces to handle the initialization and
> deinitialization of those data structures.

Yes. I was thinking similar thoughts; perhap some of the structure
initialization should be refactored and put in mballoc.c instead of
mballoc-test.c.  Even if we have to have some #ifdef
CONFIG_EXT4_KUNIT_TESTS so that some of the test mocks are in same
place that the structure manipulation functions in a single file.

      	       		 	      		- Ted
						

