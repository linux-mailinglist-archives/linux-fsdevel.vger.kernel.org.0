Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862FB770ED2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 10:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjHEIgY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 04:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHEIgW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:36:22 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56803A9B;
        Sat,  5 Aug 2023 01:36:21 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 981B468AA6; Sat,  5 Aug 2023 10:36:17 +0200 (CEST)
Date:   Sat, 5 Aug 2023 10:36:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/12] fs: use the super_block as holder when mounting
 file systems
Message-ID: <20230805083617.GB29780@lst.de>
References: <20230802154131.2221419-1-hch@lst.de> <20230802154131.2221419-7-hch@lst.de> <20230803115131.w6hbhjvvkqnv4qbq@quack3> <20230803133330.dstks7aogjogqdd5@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803133330.dstks7aogjogqdd5@quack3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 03, 2023 at 03:33:30PM +0200, Jan Kara wrote:
> As a side note, after this patch we can also remove bdev->bd_super and
> transition the two real users (mark_buffer_write_io_error() and two places
> in ocfs2) to use bd_holder. Ext4 also uses bd_super but there it is really
> pointless as we have the superblock directly available in that function
> anyway.

I actually have a series to kill bd_super, but it uses b_assoc_map
as the replacement, as nothing in buffer.c should poke into the holder
and the buffer_head codes uses b_assoc_map a lot anyway.  Let me rebase
it and send it out.
