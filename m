Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39E3C436EA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 02:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbhJVAID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 20:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231627AbhJVAIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634861145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N5JfCAsI+inccAUJ1Aaxw45z/l5KEHCFXJn6LAT6Uv8=;
        b=gs0ydNl57/JUkxjCBrVde3aRhLoLGKgKIlpA5bQR0vwuEWY2XtZUfORY76B2hF91kX5pVQ
        InFI9AemreBsL3a7DpR/Fg+euxJwKzUDcDik55mxGMJoNHkemeqPtfWYs8qVIWX1go5mq0
        WQ5/gdYXTh9WB0f+gs9p31IzPPVVaZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-2rnw5DspNCGnqLASt3ZXsg-1; Thu, 21 Oct 2021 20:05:39 -0400
X-MC-Unique: 2rnw5DspNCGnqLASt3ZXsg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E66806688;
        Fri, 22 Oct 2021 00:05:36 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EE0B819D9B;
        Fri, 22 Oct 2021 00:05:23 +0000 (UTC)
Date:   Fri, 22 Oct 2021 08:05:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YXIAPtvxW98lyM9r@T590>
References: <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7kFXlzRrvwzARP@bombadil.infradead.org>
 <YW7ygbLAwm2/LZFl@T590>
 <YW8eSq2B+5FtOLZb@bombadil.infradead.org>
 <YW9tqPunx5bssxIz@T590>
 <YXA6NMhwoiIMeHji@bombadil.infradead.org>
 <YXC2qcx/RlLwjrKx@T590>
 <YXGg95OcaR+5ktAZ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXGg95OcaR+5ktAZ@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 10:18:47AM -0700, Luis Chamberlain wrote:
> On Thu, Oct 21, 2021 at 08:39:05AM +0800, Ming Lei wrote:
> > On Wed, Oct 20, 2021 at 08:48:04AM -0700, Luis Chamberlain wrote:
> > > A second series of tests is hitting CTRL-C on either randonly and
> > > restarting testing once again randomly.
> > 
> > ltp/zram02.sh has cleanup handler via trap to clean everything(swapoff/umount/reset/
> > rmmod), ctrl-c will terminate current forground task and cause shell to run the
> > cleanup handler first, but further 'ctrl-c' will terminate the cleanup handler,
> > then the cleanup won't be done completely, such as zram disk is left as swap
> > device and zram can't be unloaded. The idea can be observed via the following
> > script:
> > 
> > 	#!/bin/bash
> > 	trap 'echo "enter trap"; sleep 20; echo "exit trap";' INT
> > 	sleep 30
> > 
> > After the above script is run foreground, when 1st ctrl-c is pressed, 'sleep 30'
> > is terminated, then the trap command is run, so you can see "enter trap"
> > dumped. Then if you pressed 2nd ctrl-c, 'sleep 20' is terminated immediately.
> > So 'swapoff' from zram02.sh's trap function can be terminated in this way.
> > 
> > zram disk being left as swap disk can be observed with your patch too
> > after terminating via multiple ctrl-c which has to be done this way because
> > the test is dead loop.
> > 
> > So it is hard to cleanup everything completely after multiple 'CTRL-C' is
> > involved, and it should be impossible. It needs violent multiple ctrl-c to
> > terminate the dealoop test.
> > 
> > So it isn't reasonable to expect that zram can be always unloaded successfully
> > after the test script is terminated via multiple ctrl-c.
> 
> For the life of me, I do not run into these issue with my patch. But
> with yours I had.
> 
> To be clear, I run zram02.sh on two terminals. Then to interrupt I just leave
> CTRL-C pressed to issue multiple terminations until the script is done
> on each terminal at a time, until I see both have completed.
> 
> I repeat the same test, noting always that when I start one one terminal
> the test is succeeding. And also when I cancel completely one script the
> test continue fine without issue.

As I explained wrt. shell's trap, this issue won't be avoided from
userspace because trap function can be terminated by ctrl-c too,
otherwise one shell script may not be terminated at all.

The unclean shutdown can be observed in single 'while true; do zram02.sh; done'
too on both your patches and mine.

Also it is insane to write write test in a deadloop, and people seldom
do that, not see such way in either blktests/xfstests.

I you limit completion time of this test in long enough time(one or
several hours) or big enough loops, I believe it can be done cleanly,
such as:

cnt=0
MAX=10000
while [ $cnt -lt $MAX ]; do
	PATH=$PATH:$PWD:$PWD/../../../lib/ ./zram02.sh;
done


Thanks,
Ming

