Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB219D205
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 10:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390512AbgDCIT6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 04:19:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390505AbgDCIT5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585901996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BZ+Xgs03guAOyReZNCF6ZrrqdxLw5dFuzU2P8g5iCuY=;
        b=dQOEoaJa4aZkIX0EcaVQf1Q5ph92upCJTiGqIct52PdiGGiiT4OH+Z4kOjHPwUWofS2sri
        o+P8dO0WOB7BJpUeJM/ChgV8dctqqQ5Bh4kUYvLBoJN+C8YO/iCRQVSNHE8dZ6S3bgp6z8
        /DKKAP5A5bytd6MNuMVgzfw6+tjavPA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-kbyr9x7vPNKH_44OGorzBA-1; Fri, 03 Apr 2020 04:19:46 -0400
X-MC-Unique: kbyr9x7vPNKH_44OGorzBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BC49DB62;
        Fri,  3 Apr 2020 08:19:44 +0000 (UTC)
Received: from ming.t460p (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E44715C3FA;
        Fri,  3 Apr 2020 08:19:34 +0000 (UTC)
Date:   Fri, 3 Apr 2020 16:19:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, nstange@suse.de, mhocko@suse.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [RFC 0/3] block: address blktrace use-after-free
Message-ID: <20200403081929.GC6887@ming.t460p>
References: <20200402000002.7442-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402000002.7442-1-mcgrof@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 01, 2020 at 11:59:59PM +0000, Luis Chamberlain wrote:
> Upstream kernel.org korg#205713 contends that there is a UAF in
> the core debugfs debugfs_remove() function, and has gone through
> pushing for a CVE for this, CVE-2019-19770.
> 
> If correct then parent dentries are not positive, and this would
> have implications far beyond this bug report. Thankfully, upon review
> with Nicolai, he wasn't buying it. His suspicions that this was just
> a blktrace issue were spot on, and this patch series demonstrates
> that, provides a reproducer, and provides a solution to the issue.
> 
> We there would like to contend CVE-2019-19770 as invalid. The
> implications suggested are not correct, and this issue is only
> triggerable with root, by shooting yourself on the foot by misuing
> blktrace.
> 
> If you want this on a git tree, you can get it from linux-next
> 20200401-blktrace-fix-uaf branch [2].
> 
> Wider review, testing, and rants are appreciated.
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=205713
> [1] https://nvd.nist.gov/vuln/detail/CVE-2019-19770
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20200401-blktrace-fix-uaf
> 
> Luis Chamberlain (3):
>   block: move main block debugfs initialization to its own file
>   blktrace: fix debugfs use after free
>   block: avoid deferral of blk_release_queue() work
> 
>  block/Makefile               |  1 +
>  block/blk-core.c             |  9 +--------
>  block/blk-debugfs.c          | 27 +++++++++++++++++++++++++++
>  block/blk-mq-debugfs.c       |  5 -----
>  block/blk-sysfs.c            | 21 ++++++++-------------
>  block/blk.h                  | 17 +++++++++++++++++
>  include/linux/blktrace_api.h |  1 -
>  kernel/trace/blktrace.c      | 19 ++++++++-----------
>  8 files changed, 62 insertions(+), 38 deletions(-)
>  create mode 100644 block/blk-debugfs.c

BTW, Yu Kuai posted one patch for this issue, looks that approach
is simpler:

https://lore.kernel.org/linux-block/20200324132315.22133-1-yukuai3@huawei.com/


Thanks,
Ming

