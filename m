Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817FF62C00D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 14:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiKPNuZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 08:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbiKPNuX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:50:23 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B15FBF7D;
        Wed, 16 Nov 2022 05:50:21 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C0E468AA6; Wed, 16 Nov 2022 14:50:17 +0100 (CET)
Date:   Wed, 16 Nov 2022 14:50:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Mingming Cao <cmm@us.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-mm@kvack.org
Subject: generic_writepages & jbd2 and ext4
Message-ID: <20221116135016.GA9713@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I've recently started looking into killing off the ->writepage method,
and as an initial subproject kill of external uses of generic_writepages.
One of the two remaining callers s in jbd2 and I'm a bit confused about
it.

jbd2_journal_submit_inode_data_buffers has two comments that explicitly
ask for ->writepages as that doesn't allocate data:

/*
 * write the filemap data using writepage() address_space_operations.
 * We don't do block allocation here even for delalloc. We don't
 * use writepages() because with delayed allocation we may be doing
 * block allocation in writepages().
 */

	/*
         * submit the inode data buffers. We use writepage
	 * instead of writepages. Because writepages can do
	 * block allocation with delalloc. We need to write
	 * only allocated blocks here.
	 */

and these look really stange to me.  ->writepage and ->writepages per
their document VM/VFS semantics don't different on what they allocate,
so this seems to reverse engineer ext4 internal behavior in some
way.  Either way looping over ->writepage just for that is rather
inefficient.  If jbd2 really wants a way to skip delalloc conversion
can we come up with a flag in struct writeback_control for that?

Is there anyone familiar enough with this code who would be willing
to give it a try?
