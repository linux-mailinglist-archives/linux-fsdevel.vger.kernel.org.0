Return-Path: <linux-fsdevel+bounces-56035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBBB120BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219483B6A1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 15:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90E12BDC15;
	Fri, 25 Jul 2025 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dJxjij5H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6273B1A840A
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Jul 2025 15:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456926; cv=none; b=l3wbJtuzI2/UIDsLFEStULtNZyXvKbDT/+fI0aHGeF21z96r4QMWOl4s3dps5sNWgdWC82UIZw9WesdprfZ/ubnjYRZzJiFMHG1h7gV8DxNqVif1VJNw3xmQmZpWaeszx2uAioR8xa8g9KXFUFJ1p4Qv/0ZYL9rb480OLdUoBzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456926; c=relaxed/simple;
	bh=w6cqLDPAuWWOf3XDsgnT9TheMq0d2PeDxG8bPLIPHH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNLPy9b4LgUKypoZ4Ja/wAEDhkqeJvXWU4Ak4liXjVOvIi48X3dpmj00FqVQI/mTOjYQUpfufs/buOxd4ejUw/QqtRbU3j58fdUbNVxfneHg+HnGHuL0JltY90SJ7Dl4xe3ZPMOsMWkVv4ltoW50lYjYJig+syhfBELKmV+wCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dJxjij5H; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-116-187.bstnma.fios.verizon.net [173.48.116.187])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56PFJ19S022191
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Jul 2025 11:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1753456745; bh=wBKmwQYCteJSPB4Hw5iOzmxaBx11IomAX7t4BBIedJc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dJxjij5H3IZka8UrAhUdDHbTwYomsTNgMcfiGCaxIgsBWkgzaRf+1/kNCJAepJ7Yq
	 6W3VbkuAxbG5rY4xeDIvuM6HzdnOGNKb25Hq03osoQY5qfoiOg64BHyD5SVqegA4ut
	 S95N6Ozx9j8vphBGJmTYZUenYAT2qeVHWW3sgPQC7rrMm5ASWmtHWiZQ3uImpry4cz
	 1ivX7EVEUWh67Q+HXy2Jp5nrFw3hyZRJ/QeplXswFodxXoMpPwsx0mZrOZOKFuGACQ
	 zmMLq9Obit2reyRC8ZVCuP9zV4hU06DF8R5y6Z93VFbbkZls+JS6SDKAIjUlM0GQt9
	 WOwfi87BfJqpA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 774922E00D6; Fri, 25 Jul 2025 09:15:41 -0400 (EDT)
Date: Fri, 25 Jul 2025 09:15:41 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com, linux@roeck-us.net,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH] ext4: fix crash on test_mb_mark_used kunit tests
Message-ID: <20250725131541.GA184259@mit.edu>
References: <20250725021654.3188798-1-yi.zhang@huaweicloud.com>
 <av5necgeitkiormvqsh75kvgq3arjwxxqxpqievulgz2rvi3dg@75hdi2ubarmr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av5necgeitkiormvqsh75kvgq3arjwxxqxpqievulgz2rvi3dg@75hdi2ubarmr>

On Fri, Jul 25, 2025 at 01:06:18PM +0200, Jan Kara wrote:
> > This patch applies to the kernel that has only merged bbe11dd13a3f
> > ("ext4: fix largest free orders lists corruption on mb_optimize_scan
> > switch"), but not merged 458bfb991155 ("ext4: convert free groups order
> > lists to xarrays").
> 
> Hum, I think it would be best to just squash this into bbe11dd13a3f and
> then just rebase & squash the other unittest fixup to the final commit when
> we have to rebase anyway. Because otherwise backports to stable kernel will
> quickly become rather messy.

What I ended up doing was to add a squashed combination of these two
commits and dropped it in before the block allocation scalabiltity
with the following commit description:

    ext4: initialize superblock fields in the kballoc-test.c kunit tests
    
    Various changes in the "ext4: better scalability for ext4 block
    allocation" patch series have resulted in kunit test failures, most
    notably in the test_new_blocks_simple and the test_mb_mark_used tests.
    The root cause of these failures is that various in-memory ext4 data
    structures were not getting initialized, and while previous versions
    of the functions exercised by the unit tests didn't use these
    structure members, this was arguably a test bug.
    
    Since one of the patches in the block allocation scalability patches
    is a fix which is has a cc:stable tag, this commit also has a
    cc:stable tag.
    
    CC: stable@vger.kernel.org
    Link: https://lore.kernel.org/r/20250714130327.1830534-1-libaokun1@huawei.com
    Link: https://patch.msgid.link/20250725021550.3177573-1-yi.zhang@huaweicloud.com
    Link: https://patch.msgid.link/20250725021654.3188798-1-yi.zhang@huaweicloud.com
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Closes: https://lore.kernel.org/linux-ext4/b0635ad0-7ebf-4152-a69b-58e7e87d5085@roeck-us.net/
    Tested-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Then in the commit "ext4: convert free groups order lists to xarrays"
which removed list_head, I modified it to remove the linked list
initialization from mballoc-test.c, since that's the commit which
removed those structures.

In the future, we should try to make sure that when we modify data
structures to add or remove struct elements, that we also make sure
that kunit test should also be updated.  To that end, I've updated the
kbuild script[1] in xfstests-bld repo so that "kbuild --test" will run
the Kunit tests.  Hopefully reducing the friction for running tests
will encourage more kunit tests to be created and so they will kept
under regular maintenance.

[1] https://github.com/tytso/xfstests-bld/blob/master/kernel-build/kbuild

Cheers,

					- Ted

