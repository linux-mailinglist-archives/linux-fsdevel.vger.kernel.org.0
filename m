Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E56C524A41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 12:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352608AbiELKaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 06:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiELKaL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 06:30:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE95222C12;
        Thu, 12 May 2022 03:30:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20AFA21C53;
        Thu, 12 May 2022 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652351408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kr+qXZt/eYRnHVkFQUb89v0qriZD+fVIZO2dGDtN6mM=;
        b=QTFwnlbeTqCScIwcQTchLvRxxxQ7jV9o58HLRIATh5MGj7+nOUT86zcM10V7ChyQjxj2Zn
        XazUcEQQHBUJa4g4P6tUcAGUfh7cTA2ZFoS1z0InPMRmnX2j3TS5ttxLO/2Xu9OqPLDEX2
        14oPc5RZ7Xt9Fk3rmaf5LRdJ88TLCHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652351408;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kr+qXZt/eYRnHVkFQUb89v0qriZD+fVIZO2dGDtN6mM=;
        b=n8WgQymwPjK6lX9O5CaLtXN7zeAoRKPrfIMBh3UQ0HRQdmoV0jjdTs3AfFvWRZt/fDaQ5N
        xE/OaDtTBEJGy7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBEB013ABE;
        Thu, 12 May 2022 10:30:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EFzMNK/hfGITVAAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 12 May 2022 10:30:07 +0000
Date:   Thu, 12 May 2022 12:25:52 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: reduce memory allocation in the btrfs direct I/O path v2
Message-ID: <20220512102552.GR18596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220505201115.937837-1-hch@lst.de>
 <dcab2ed0-d48f-e987-47fa-2fd1fc2dba08@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcab2ed0-d48f-e987-47fa-2fd1fc2dba08@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 12, 2022 at 12:25:57PM +0530, Anand Jain wrote:
> On 5/6/22 01:41, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series adds two minor improvements to iomap that allow btrfs
> > to avoid a memory allocation per read/write system call and another
> > one per submitted bio.  I also have at last two other pending uses
> > for the iomap functionality later on, so they are not really btrfs
> > specific either.
> > 
> > Changes since v1:
> >   - pass the private data direct to iomap_dio_rw instead of through the
> >     iocb
> >   - better document the bio_set in iomap_dio_ops
> >   - split a patch into three
> >   - use kcalloc to allocate the checksums
> > 
> > Diffstat:
> >   fs/btrfs/btrfs_inode.h |   25 --------
> >   fs/btrfs/ctree.h       |    6 -
> >   fs/btrfs/file.c        |    6 -
> >   fs/btrfs/inode.c       |  152 +++++++++++++++++++++++--------------------------
> >   fs/erofs/data.c        |    2
> >   fs/ext4/file.c         |    4 -
> >   fs/f2fs/file.c         |    4 -
> >   fs/gfs2/file.c         |    4 -
> >   fs/iomap/direct-io.c   |   26 ++++++--
> >   fs/xfs/xfs_file.c      |    6 -
> >   fs/zonefs/super.c      |    4 -
> >   include/linux/iomap.h  |   16 ++++-
> >   12 files changed, 123 insertions(+), 132 deletions(-)
> 
> This patch got me curious a couple of days back while I was tracing
> a dio read performance issue on nvme. I am sharing the results as below.
> [1]. There is no performance difference. Thx.

Thanks for the results.
