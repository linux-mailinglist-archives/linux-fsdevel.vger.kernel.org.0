Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA11DED453
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Nov 2019 20:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbfKCTQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Nov 2019 14:16:18 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52451 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727343AbfKCTQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Nov 2019 14:16:17 -0500
Received: from callcc.thunk.org (ip-12-2-52-196.nyc.us.northamericancoax.com [196.52.2.12])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xA3JG7rB015715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Nov 2019 14:16:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E374D420311; Sun,  3 Nov 2019 14:16:06 -0500 (EST)
Date:   Sun, 3 Nov 2019 14:16:06 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org
Subject: Re: [RFC 0/5] Ext4: Add support for blocksize < pagesize for
 dioread_nolock
Message-ID: <20191103191606.GB8037@mit.edu>
References: <20191016073711.4141-1-riteshh@linux.ibm.com>
 <20191023232614.GB1124@mit.edu>
 <20191029071925.60AABA405B@b06wcsmtp001.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029071925.60AABA405B@b06wcsmtp001.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:49:24PM +0530, Ritesh Harjani wrote:
> 
> So it looks like these failed tests does not seem to be because of this
> patch series. But these are broken in general for at least 1K blocksize.

Agreed, I failed to add them to the exclude list for diread_nolock_1k.  
Thanks for pointing that out!   

After looking through these patches, it looks good.  So, I've landed
this series on the ext4 git tree.

There are some potential conflicts with Matthew's DIO using imap patch
set.  I tried resolving them in the obvious way (see the tt/mb-dio
branch[1] on ext4.git), and unfortunately, there is a flaky test
failure with generic/270 --- 2 times out 30 runs of generic/270, the
file system is left inconsistent, with problems found in the block
allocation bitmap.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=tt/mb-dio

I've verified that generic/270 isn't a problem on -rc3, and it's not a
problem with just your patch series.  So, it's almost certain it's
because I screwed up the merge.  I applied each of Matthew's patch one
at a time, and conflict was in changes in ext4_end_io_dio, which is
dropped in Matthew's patch.  It wasn't obvious though where the
dioread-nolock-1k change should be applied in Matthew's patch series.
Could you take a look?  Thanks!!

> Also as an FYI, it seems generic/388 is also broken for blocksize <
> pagesize for both platforms. So I will be planning to look into these
> failures (generic/273 generic/388 generic/476) in parallel.

generic/388 is broken in a flaky fashion on all of the tests.  That's
a shutdown test, and it's a known issue, having to do with how we
forcibly shut down the journalling machinery not being quite right.
Since unclean power off and/or dropped fibre channel/iSCSI case is
handled correctly, this hasn't been high on the priority list to track
down and fix.

> Do you think we can work on these failing tests separately, since it does
> not look to be failing because of these patches and go ahead in
> reviewing this current patch series?

Oh, I agree, those failures are pre-existing test failures, and so it
shouldn't and doens't block this series.

Thanks for your work on this feature!

					- Ted
