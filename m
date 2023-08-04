Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2039F7709CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 22:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjHDUfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjHDUfW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:35:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703024C3B
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 13:35:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 374KYoJ9025333
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Aug 2023 16:34:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691181294; bh=eb93p14LbhHMq9VAU9FSt+DcSUdrlvW15TyYmjztiqQ=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=Cmbci/Vas57W7Gs1mmt04uOthaR1e+rzdGz6ITDOXZ7ar1BUIxuloHDQosTWOCKWI
         iB56bnyujn38Bh0Bp8Z9EdtMGK5JGqwP/Dc9817D37D5RzTjBcqX7HfyweGFQEIlNc
         BVs1/MrxyUeyzFJS766n80HD2+PFuYOP4G3VM8zfAxBDEfh2gwQRvXgsgqIMcMc0wN
         OtpY0Qeymqh8HbDn2ZQVvOacBb7LkX38rsikz68ioX6wllgIiRTX9csEEqK5ZCQd2m
         kHOKMhSYpzYpG5XePqQ01RloNzfxpmSlLpaGQE5i8Tm2KMJbuA8zWdXQJfaXrlAorq
         d89+IyylQf2+A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 594D415C04F1; Fri,  4 Aug 2023 16:34:50 -0400 (EDT)
Date:   Fri, 4 Aug 2023 16:34:50 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 09/12] ext4: drop s_umount over opening the log device
Message-ID: <20230804203450.GD903325@mit.edu>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-10-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:41:28PM +0200, Christoph Hellwig wrote:
> Just like get_tree_bdev needs to drop s_umount when opening the main
> device, we need to do the same for the ext4 log device to avoid a
> potential lock order reversal with s_unmount for the mark_dead path.
> 
> It might be preferable to just drop s_umount over ->fill_super entirely,
> but that will require a fairly massive audit first, so we'll do the easy
> version here first.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Theodore Ts'o <tytso@mit.edu>
