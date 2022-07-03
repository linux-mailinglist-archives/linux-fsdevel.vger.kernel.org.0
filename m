Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E475E56488E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiGCQay (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiGCQax (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 12:30:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DC35FB1;
        Sun,  3 Jul 2022 09:30:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 263GUG1U006323
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Jul 2022 12:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656865823; bh=uKC0mfydFMX4nUGBHuT9jkHWP7ClJOQjzQ31vgmMI5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ovcz2irxhBKksjbFBj4coBed2FkyJqDL5tkts1iix6B+4/yL/g8C9U5LwjN631HSa
         aMA2tibyXYr5MEVfNxBWpEPRH9wW7Xi0Ae4JasXNq3OhGwzBJv0JkgN/9tQ4Js0fvn
         zrWezqpIT0c9tr5wEO6XeolPAYbo0ybOMplXHi/VZX9vbTJyhLGy6X8Tf1nyJvgXSY
         InsEIKp9piRbk8bkV+fXdSDsj6GpzSPfscaaGBK+R8XmLroIzmtYcshgXZ+svbfnTq
         pzrRuAzvSmJCrzmz/iVNJydcJhkv8BxhyytpZxmz9Jb0YZ3vuezcLpdzaG4EeLsXOr
         rbmJVJnL0K74A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 62C5215C3E94; Sun,  3 Jul 2022 12:30:16 -0400 (EDT)
Date:   Sun, 3 Jul 2022 12:30:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YsHEGElna2Ae2V83@mit.edu>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
 <YsGWb8nPUySuhos/@mit.edu>
 <CAOQ4uxhEaVjk6rEnsnjWOKs+dygioXk-9h-WJjBzkJfe8U9eMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhEaVjk6rEnsnjWOKs+dygioXk-9h-WJjBzkJfe8U9eMQ@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 03, 2022 at 05:22:17PM +0300, Amir Goldstein wrote:
> 
> To be clear, when I wrote deterministic, what I meant was deterministic
> results empirically, in the same sense that Bart meant - a test should
> always pass.

Well all of the tests in the auto group pass at 100% of the time for
the ext4/4k and xfs/4k groups.  (Well, at least if use the HDD and SSD
as the storage device.  If you are using eMMC flash, or Luis's loop
device config, there would be more failures.)

But if we're talking about btrfs/4k, f2fs/4k, xfs/realtime,
xfs/realtime_28k/logdev, ext4/bigalloc, etc. there would be a *lot* of
tests that would need to be removed from the auto group.

So what "non-determinsitic tests" should we remove from the auto
group?  For what file systems, file system configs, and storage
devices?  What would you propose?

Remember, Matthew wants something that he can use to test "dozens" of
file systems that he's touching for the folio patches.  If we have to
remove all of the tests that fail if you are using nfs, vfat, hfs,
msdos, etc., then the auto group would be pretty anemic.  Let's not do
that.

If you want a "always pass" group, we could do that, but let's not
call that the "auto" group, please.

						- Ted
