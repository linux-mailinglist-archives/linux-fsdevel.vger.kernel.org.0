Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAA0C4368E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhJURVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhJURVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:21:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0977C061764;
        Thu, 21 Oct 2021 10:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AD7baqDv7qcOXIpKfV7ERWwjC0Jt5iI28VcJ9GrCqks=; b=rZTla/b7wEl07NyABgcNxY4UWI
        6JYo0XaNvaYZ3UxR5KpgG/qNARinza7TjgaNGaBeO6CX8cPtGObHKiCHqQzQRzg3r0K5hun+hUiQB
        JBYk+83/2/jiTN5s0tLuOeMdhxRuCu/eFq5Uh74WlzeOFtcncBfRQlntYmi6Hjge9bFsOrBo5NfSo
        XWcjBM8locwogPOgmFNCI/tOpS93yC7LWUUkPEccW+0rf2d92TnZ83zCop52oeZpWZYchrbZY+1ue
        pIG/OXVZDujhVNGknKs5lBF2owxKIDNKvMZQ57PWscfx06l4OwXv8Hu0JGDOEJzOZsyB2ktlNSET7
        oVfNOJ5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdbiJ-008UQT-NH; Thu, 21 Oct 2021 17:18:47 +0000
Date:   Thu, 21 Oct 2021 10:18:47 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
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
Message-ID: <YXGg95OcaR+5ktAZ@bombadil.infradead.org>
References: <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7kFXlzRrvwzARP@bombadil.infradead.org>
 <YW7ygbLAwm2/LZFl@T590>
 <YW8eSq2B+5FtOLZb@bombadil.infradead.org>
 <YW9tqPunx5bssxIz@T590>
 <YXA6NMhwoiIMeHji@bombadil.infradead.org>
 <YXC2qcx/RlLwjrKx@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXC2qcx/RlLwjrKx@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 21, 2021 at 08:39:05AM +0800, Ming Lei wrote:
> On Wed, Oct 20, 2021 at 08:48:04AM -0700, Luis Chamberlain wrote:
> > A second series of tests is hitting CTRL-C on either randonly and
> > restarting testing once again randomly.
> 
> ltp/zram02.sh has cleanup handler via trap to clean everything(swapoff/umount/reset/
> rmmod), ctrl-c will terminate current forground task and cause shell to run the
> cleanup handler first, but further 'ctrl-c' will terminate the cleanup handler,
> then the cleanup won't be done completely, such as zram disk is left as swap
> device and zram can't be unloaded. The idea can be observed via the following
> script:
> 
> 	#!/bin/bash
> 	trap 'echo "enter trap"; sleep 20; echo "exit trap";' INT
> 	sleep 30
> 
> After the above script is run foreground, when 1st ctrl-c is pressed, 'sleep 30'
> is terminated, then the trap command is run, so you can see "enter trap"
> dumped. Then if you pressed 2nd ctrl-c, 'sleep 20' is terminated immediately.
> So 'swapoff' from zram02.sh's trap function can be terminated in this way.
> 
> zram disk being left as swap disk can be observed with your patch too
> after terminating via multiple ctrl-c which has to be done this way because
> the test is dead loop.
> 
> So it is hard to cleanup everything completely after multiple 'CTRL-C' is
> involved, and it should be impossible. It needs violent multiple ctrl-c to
> terminate the dealoop test.
> 
> So it isn't reasonable to expect that zram can be always unloaded successfully
> after the test script is terminated via multiple ctrl-c.

For the life of me, I do not run into these issue with my patch. But
with yours I had.

To be clear, I run zram02.sh on two terminals. Then to interrupt I just leave
CTRL-C pressed to issue multiple terminations until the script is done
on each terminal at a time, until I see both have completed.

I repeat the same test, noting always that when I start one one terminal
the test is succeeding. And also when I cancel completely one script the
test continue fine without issue.

> But zram can be unloaded after running swapoff manually, from driver
> viewpoint, nothing is wrong.

I had not run into that issue with my patch FWIW.

  Luis
