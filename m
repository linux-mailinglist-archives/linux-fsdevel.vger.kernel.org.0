Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C852E42C028
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Oct 2021 14:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbhJMMho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Oct 2021 08:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhJMMhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:37:43 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD63C061570;
        Wed, 13 Oct 2021 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eMEXfomHe+Tl3sMKtQnjNMhVYCC3yttKmNX8r/7xFTY=; b=m1S8aLcRwPu/lHVCZXsGpjbKZn
        H/jfFqw6Ddw2nkaWJYuacvjGIcAy7kv50lsFDQN6vDtgBIJrHd6+/VtI3GG5aVNAHmXdDuO+Iz3El
        ohcKBqtlsogvHJlTPuc1tSRRgHWCuSsaMLx+6yC2Zcy+/0LVuhvbSxlspq00XYjwi7pDsBNisKRC4
        moLCwrhlGdLLXir0ZkxLM7mbUx/xkceROdYWd4mm0/wMSglM7Q3nSL/Xi7obfULfcDshqoifqwwbo
        Cri00mYnzZ1IErZDEddZhiDIaSQZptCRed0NmaquBclvDm+IgdQaByRvQzNpQzu7nGvwXp3sZV1TU
        xvy1VHPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1madTn-00GayY-Os; Wed, 13 Oct 2021 12:35:31 +0000
Date:   Wed, 13 Oct 2021 05:35:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 09/12] sysfs: fix deadlock race with module removal
Message-ID: <YWbSk6p3bfXUPZ92@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-10-mcgrof@kernel.org>
 <YVwZwh7qDKfSM59h@T590>
 <YWSr2trabEJflzlj@bombadil.infradead.org>
 <YWTU3kTlJKONyFjZ@T590>
 <YWX7pAn0YMaJeJBA@bombadil.infradead.org>
 <YWYxN875B6rlmAjC@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWYxN875B6rlmAjC@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 09:07:03AM +0800, Ming Lei wrote:
> On Tue, Oct 12, 2021 at 02:18:28PM -0700, Luis Chamberlain wrote:
> > > Looks test_sysfs isn't in linus tree, where can I find it?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-sysfs-generic-deadlock-fix
> > 
> > To reproduce the deadlock revert the patch in this thread and then run
> > either of these two tests as root:
> > 
> > ./tools/testing/selftests/sysfs/sysfs.sh -w 0027
> > ./tools/testing/selftests/sysfs/sysfs.sh -w 0028
> > 
> > You will need to enable the test_sysfs driver.
> > > Can you share the code which waits for the sysfs / kernfs files to be
> > > stop being used?
> > 
> > How about a call trace of the two tasks which deadlock, here is one of
> > running test 0027:
> > 
> > kdevops login: [  363.875459] INFO: task sysfs.sh:1271 blocked for more
> > than 120 seconds.

<-- snip -->

> That doesn't show the deadlock is related with module_exit().

Not directly no.

> It is clearly one AA deadlock, what I meant was that it isn't related with
> module exit cause lock & device_del() isn't always done in module exit, so
> I doubt your fix with grabbing module refcnt is good or generic enough.

A device_del() *can* happen in other areas other than module exit sure,
but the issue is if a shared lock is used *before* device_del() and also
used on a sysfs op. Typically this can happen on module exit, and the
other common use case in my experience is on sysfs ops, such is the case
with the zram driver. Both cases are covered then by this fix.

If there are other areas, that is still driver specific, but of the
things we *can* generalize, definitely module exit is a common path.

> Except for your cooked test_sys module, how many real drivers do suffer the
> problem? What are they?

I only really seriously considered trying to generalize this after it
was hinted to me live patching was also affected, and so clearly
something generic was desirable.

There may be other drivers for sure, but a hunt for that with semantics
would require a bit complex coccinelle patch with iteration support.

> Why can't we fix the exact driver?

You can try, the way the lock is used in zram is correct, specially
after my other fix in this series which addresses another unrelated bug
with cpu hotplug multistate support. So we then can proceed to either
take the position to say: "Thou shalt not use a shared lock on module
exit and a sysfs op" and try to fix all places, or we generalize a fix
for this. A generic fix seems more desirable.

  Luis
