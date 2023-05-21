Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EB570B0E0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 May 2023 23:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjEUVdi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 17:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjEUVdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 17:33:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B9ACA;
        Sun, 21 May 2023 14:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5A1A6133B;
        Sun, 21 May 2023 21:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC70C433D2;
        Sun, 21 May 2023 21:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684704816;
        bh=ImWTr7+FEz7G2UQwBZSuCeiA4GdQb8LvzHpdtatDkNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KO5gheQtibjJybbzamwH89UnyFKfq7zeKADXvoSFgiCqxbSPU6/lkOYsX+fiKkeTi
         LgQfBghYJA+ploSYPsr6NOcf0MR+cw1jXNJZsr3nNRwX3c7yieSMjWAAMjTWpKFsCL
         cye65LB4fT0Hb2hF917VKqPVQKeNc70onO3Grmqrr34lYdMNZEQyCrOonOutj2/Udz
         c2twa3EUXfs2ciG+vcf4YLg+2vVVCtTE1ECWCwAd3RUmmI6d1zk3PGeGsWwcCMnYy3
         /aufTNKVNvXXa9OnRvLUrcPbkeHudYZ3pU0aK6Cd7sGro/2Kv1MEk/BHm9VUfz4FJB
         fx8o2Zgd3TmAw==
Date:   Sun, 21 May 2023 14:33:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230521213334.GA32557@sol.localdomain>
References: <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan>
 <20230513015752.GC3033@quark.localdomain>
 <ZGB1eevk/u2ssIBT@moria.home.lan>
 <20230514184325.GB9528@sol.localdomain>
 <ZGHFa4AprPSsEpeq@moria.home.lan>
 <20230515061346.GB15871@sol.localdomain>
 <ZGHOppBFcKEJkzCe@moria.home.lan>
 <20230515071343.GD15871@sol.localdomain>
 <ZGHesxEMsCfOewhy@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGHesxEMsCfOewhy@moria.home.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 15, 2023 at 03:26:43AM -0400, Kent Overstreet wrote:
> On Mon, May 15, 2023 at 12:13:43AM -0700, Eric Biggers wrote:
> > Sure, given that this is an optimization problem with a very small scope
> > (decoding 6 fields from a bitstream), I was hoping for something easier and
> > faster to iterate on than setting up a full kernel + bcachefs test environment
> > and reverse engineering 500 lines of shell script.  But sure, I can look into
> > that when I have a chance.
> 
> If you were actually wanting to help, that repository is the tool I use
> for kernel development and testing - it's got documentation.
> 
> It builds a kernel, boots a VM and runs a test in about 15 seconds, no
> need for lifting that code out to userspace.
> 

FYI, I had a go with your test framework today, but I ran into too many problems
to really bother with it.  In case you want to improve it, these are the
problems I ran into (so far).  The command I was trying to run, after having run
'./root_image create' as root as the README says to do, was
'build-test-kernel run -I ~/src/ktest/tests/bcachefs/perf.ktest':

- Error due to ~/src/ktest/tests/bcachefs/bcachefs-tools not existing.  Worked
  around by cloning the bcachefs-tools repo to this location.  (Note, it's not a
  git submodule, so updating the git submodules didn't help.)

- Error due to "Root image not found".  Worked around by recursively chown'ing
  /var/lib/ktest from root to my user.  (Note, the README says to run
  'root_image create' as root, which results in root ownership.)

- Error due to "cannot set up guest memory 'pc.ram': Cannot allocate memory".
  Worked around by editing tests/bcachefs/perf.ktest to change config-mem from
  32G to 16G.  (I have 32G memory total on this computer.)

- Error due to "failed to open /dev/vfio/10: No such file or directory".
  Enabling CONFIG_VFIO and CONFIG_VFIO_PCI in my host kernel didn't help.  It
  seems the test is hardcoded to expect PCI passthrough to be set up with a
  specific device.  I'd have expected it to just set up a standard virtual disk.
