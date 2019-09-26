Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B34BF84A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 19:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfIZR5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 13:57:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:47874 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728320AbfIZR5E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 13:57:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 708F6AD2C;
        Thu, 26 Sep 2019 17:57:02 +0000 (UTC)
Date:   Thu, 26 Sep 2019 19:57:00 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: copy_file_range() errno changes introduced in v5.3-rc1
Message-ID: <20190926175700.GA12619@x230>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20190926155608.GC23296@dell5510>
 <20190926160432.GC9916@magnolia>
 <20190926161906.GD23296@dell5510>
 <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir,

> > > > * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.

> Started to return EXDEV?? quite the opposite.
> But LTP tests where already adapted to that behavior AFAICT:
> 15cac7b46 syscalls/copy_file_range01: add cross-device test
I'm talking about copy_file_range02 (15cac7b46 changes copy_file_range01).

Anyway, the problem which I want to fix is a backward compatibility for v5.2 and
older to fix errors like this:

copy_file_range02.c:102: INFO: Test #7: overlaping range
copy_file_range02.c:134: FAIL: copy_file_range returned wrong value: 16
copy_file_range02.c:102: INFO: Test #8: block device
copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EINVAL, but got: EXDEV (18)
copy_file_range02.c:102: INFO: Test #9: char device
copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EINVAL, but got: EXDEV (18)
...
copy_file_range02.c:102: INFO: Test #11: max length lenght
copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EOVERFLOW, but got: EINVAL (22)
copy_file_range02.c:102: INFO: Test #12: max file size
copy_file_range02.c:128: FAIL: copy_file_range failed unexpectedly; expected EFBIG, but got: EINVAL (22)

LTP hasn't defined yet any policy about changing errnos,
as it's probably best to check whether change was intentional
(like your obvious fixes) or not.

> > > > * 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return -EPERM, -ETXTBSY, -EOVERFLOW.

> > > I'm not Amir, but by my recollection, yes, those are intentional. :)
> > Thanks for a quick confirmation.


> Which reminds me - I forgot to send the man pages patch out to maintainer:
> https://lore.kernel.org/linux-fsdevel/20190529174318.22424-15-amir73il@gmail.com/

> At least according to man page -EACCES is also possible.
Thanks for fixing man :).

Kind regards,
Petr
