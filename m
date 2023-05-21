Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA0B670B156
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 00:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjEUWEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 18:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjEUWEt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 18:04:49 -0400
Received: from out-19.mta1.migadu.com (out-19.mta1.migadu.com [IPv6:2001:41d0:203:375::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CF7DD
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 May 2023 15:04:48 -0700 (PDT)
Date:   Sun, 21 May 2023 18:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684706684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M7SZ4icPM/G1fu0ULdKEsJem1DjVdc2mchXSlwG+/Tc=;
        b=pNlBxYp89TaGuI/Pja+cAFNusJ6CcLCYMLeXkpWHfk8wp2qS4mvN3aemgC6BSn2VE2PhUE
        4c7qqnVrgpCoGa7/WcHruX+2OboTSsJTjjG+89QTN7Pdm4pbm7qZXRNQvDq/XquaOAJOms
        epiuAFYuYMDP+Y5scpiuH3SIv0k3qhk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZGqVd9Vx5vjqlEh0@moria.home.lan>
References: <ZF6HHRDeUWLNtuL7@moria.home.lan>
 <20230513015752.GC3033@quark.localdomain>
 <ZGB1eevk/u2ssIBT@moria.home.lan>
 <20230514184325.GB9528@sol.localdomain>
 <ZGHFa4AprPSsEpeq@moria.home.lan>
 <20230515061346.GB15871@sol.localdomain>
 <ZGHOppBFcKEJkzCe@moria.home.lan>
 <20230515071343.GD15871@sol.localdomain>
 <ZGHesxEMsCfOewhy@moria.home.lan>
 <20230521213334.GA32557@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230521213334.GA32557@sol.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 21, 2023 at 02:33:34PM -0700, Eric Biggers wrote:
> FYI, I had a go with your test framework today, but I ran into too many problems
> to really bother with it.  In case you want to improve it, these are the
> problems I ran into (so far).  The command I was trying to run, after having run
> './root_image create' as root as the README says to do, was
> 'build-test-kernel run -I ~/src/ktest/tests/bcachefs/perf.ktest':

Thanks for giving it a shot...

> - Error due to ~/src/ktest/tests/bcachefs/bcachefs-tools not existing.  Worked
>   around by cloning the bcachefs-tools repo to this location.  (Note, it's not a
>   git submodule, so updating the git submodules didn't help.)

a require-git line was missing, fixed that...

> - Error due to "Root image not found".  Worked around by recursively chown'ing
>   /var/lib/ktest from root to my user.  (Note, the README says to run
>   'root_image create' as root, which results in root ownership.)

Not sure about this one - root ownership is supposed to be fine because
qemu opens the root image read only, we use qemu's block device
in-memory snapshot mode. Was it just not readable by your user?

> - Error due to "cannot set up guest memory 'pc.ram': Cannot allocate memory".
>   Worked around by editing tests/bcachefs/perf.ktest to change config-mem from
>   32G to 16G.  (I have 32G memory total on this computer.)
 
I think 32G is excessive for the tests that actually need to be in this
file, dropping that back to 16G.

> - Error due to "failed to open /dev/vfio/10: No such file or directory".
>   Enabling CONFIG_VFIO and CONFIG_VFIO_PCI in my host kernel didn't help.  It
>   seems the test is hardcoded to expect PCI passthrough to be set up with a
>   specific device.  I'd have expected it to just set up a standard virtual disk.

Some of the tests in that file do need a fast device, but the tests
we're interested in do not - I'll split that up.

I just pushed fixes for everything except the root_image issue if you
want to give it another go.

Cheers,
Kent
