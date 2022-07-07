Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CC856ADC2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 23:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiGGVgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 17:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiGGVgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 17:36:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91942380;
        Thu,  7 Jul 2022 14:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ttm6gGP6SLsd/ERoDNA6enC+GfvJnC9kynUKCW0O0ns=; b=yG/OHYUxpGtlw44gkc5XopLGK7
        I6y30vKOkhOgcv+c8LaKNmQixg7SzUKOv8wSBBO+6LBT8YXJPQXcIR0qWJClh6qOzughOSEPsNMfy
        S8DJkDEk+QYlc/azK+k+pGgEtW9CrNp8CzMc1vh7pfA3wOIoQtKS6wSLiAAByTp2BbN5++4vl3VAC
        Zku/392MLRMD/b2b6Zeco5gTA+2lC0sHcilcbcxPhxpF/P1rFjeBgdu6UdzweR4E0XmzLUCeP2ogK
        RObaFJoTdvPJ1wAzXrh490Wnuns+OppbHZaPWd99DmY2EgLSK7UE7EuHzOSk9RlAx4688b2+ycQXa
        /fqLBcTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o9ZAn-000Lbq-4A; Thu, 07 Jul 2022 21:36:33 +0000
Date:   Thu, 7 Jul 2022 14:36:33 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Zorro Lang <zlang@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YsdR4XgXW+iE/m8h@bombadil.infradead.org>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519112450.zbje64mrh65pifnz@zlang-mailbox>
 <YoZbF90qS+LlSDfS@casper.infradead.org>
 <20220519154419.ziy4esm4tgikejvj@zlang-mailbox>
 <YoZq7/lr8hvcs9T3@casper.infradead.org>
 <YsB54p1vpBg4v2Xd@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsB54p1vpBg4v2Xd@mit.edu>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 02, 2022 at 01:01:22PM -0400, Theodore Ts'o wrote:
> Note: I recommend that you skip using the loop device xfstests
> strategy, which Luis likes to advocate.  For the perspective of
> *likely* regressions caused by the Folio patches, I claim they are
> going to cause you more pain than they are worth.  If there are some
> strange Folio/loop device interactions, they aren't likely going to be
> obvious/reproduceable failures that will cause pain to linux-next
> testers.  While it would be nice to find **all** possible bugs before
> patches go usptream to Linus, if it slows down your development
> velocity to near-standstill, it's not worth it.  We have to be
> realistic about things.

Regressions with the loopback block driver can creep up and we used to
be much worse, but we have gotten better at it. Certainly testing a
loopback driver can mean running into a regression with the loopback
driver. But some block driver must be used in the end.

> What about other file systems?  Well, first of all, xfstests only has
> support for the following file systems:
> 
> 	9p btrfs ceph cifs exfat ext2 ext4 f2fs gfs glusterfs jfs msdos
> 	nfs ocfs2 overlay pvfs2 reiserfs tmpfs ubifs udf vfat virtiofs xfs
> 
> {kvm,gce}-xfstests supports these 16 file systems:
> 
> 	9p btrfs exfat ext2 ext4 f2fs jfs msdos nfs overlay reiserfs
> 	tmpfs ubifs udf vfat xfs
> 
> kdevops has support for these file systems:
> 
> 	btrfs ext4 xfs

Thanks for this list Ted!

And so adding suport for a new filesystem in kdevops should be:

 * a kconfig symbol for the fs and then one per supported mkfs config
   option you want to support

 * a configuration file for it, this can be as elaborate to support
   different mkfs config options as we have for xfs [0] or one
   with just one or two mkfs config options [1]. The default
   is just shared information.

[0] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/fstests/templates/xfs/xfs.config
[1] https://github.com/linux-kdevops/kdevops/blob/master/playbooks/roles/fstests/templates/ext4/ext4.config

> There are more complex things you could do, such as running a baseline
> set of tests 500 times (as Luis suggests),

I advocate 100 and I suggest that is a nice goal for enterprise kernels.

I also personally advocate this confidence in a baseline for stable
kernels if *I* am going to backport changes.

> but I believe that for your
> use case, it's not a good use of your time.  You'd need to speed
> several weeks finding *all* the flaky tests up front, especially if
> you want to do this for a large set of file systems.  It's much more
> efficient to check if a suspetected test regression is really a flaky
> test result when you come across them.

Or you work with a test runner that has the list of known failures / flaky
failures for a target configuration like using loopbacks already. And
hence why I tend to attend to these for xfs, btrfs, and ext4 when I have
time. My goal has been to work towards a baseline of at least 100
successful runs without failure tracking upstream.

  Luis
