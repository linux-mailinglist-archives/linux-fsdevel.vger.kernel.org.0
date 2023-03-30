Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C66CF7E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 02:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjC3ACQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 20:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjC3ACM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 20:02:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97161A1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A6ux99swJqRiP9fOU3d2dZ1/X8782Gxm2MbdMlsr7UQ=; b=XUudP/PksU/1U4REfHGvfxwKnI
        7ifq9UAhJQHBOyXd9KQKYdCZSpYA9DtTnosJTW87NAqicvfN7FSg06Wp6Kl+N2WWFW7gBWIBTEHlf
        muYXXtGIpOw3lTn6d25/RRHPFGF6eFtXyqopp1/h6KWR3OqZ05rpChyXV1zCm+izzFXur4mZYjfqY
        e1+WjlI6b8VIeOogtt+WrnSmIv/wAwF4yNGHmKlVYOS6mCCBYNhtJ/AOGZGuzYY1XUQ6jphaoYl14
        PENfAE2TOxtym4oGa8olmPJkDHPOpla5sGKOC9KaNQMEdkgvqhDPiIb3DKFaGi4ryno1G4C9RBQIH
        DJV5P4cg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1phfjx-002761-1I;
        Thu, 30 Mar 2023 00:02:05 +0000
Date:   Wed, 29 Mar 2023 17:02:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org
Subject: Re: [RFCv1][WIP] ext2: Move direct-io to use iomap
Message-ID: <ZCTRfRVK7XdbovJK@infradead.org>
References: <87ttz889ns.fsf@doe.com>
 <eae9d2125de1887f55186668937df7475b0a33f4.1678977084.git.ritesh.list@gmail.com>
 <20230320175139.l5oqbwuae4schgcu@quack3>
 <87zg85pa5i.fsf@doe.com>
 <20230323113030.ryne2oq27b6cx6xz@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323113030.ryne2oq27b6cx6xz@quack3>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 23, 2023 at 12:30:30PM +0100, Jan Kara wrote:
> > 
> > One way which hch is suggesting is to use __iomap_dio_rw() -> unlock
> > inode -> call generic_write_sync(). I haven't yet worked on this part.
> 
> So I see two problems with what Christoph suggests:
> 
> a) It is unfortunate API design to require trivial (and low maintenance)
>    filesystem to do these relatively complex locking games. But this can
>    be solved by providing appropriate wrapper for them I guess.

Well, the problem is that this "trivial" file systems have a pretty
broken locking scheme for fsync.

The legacy dio code gets around this by unlocking i_rwsem inside of
__blockdev_direct_IO.  Which force a particular and somewhat odd
locking scheme on the callers, and severly limits it what it can do.

> > Are you suggesting to rip of inode_lock from __generic_file_fsync()?
> > Won't it have a much larger implications?
> 
> Yes and yes :). But inode writeback already happens from other paths
> without inode_lock so there's hardly any surprise there.
> sync_mapping_buffers() is impossible to "customize" by filesystems and the
> generic code is fine without inode_lock. So I have hard time imagining how
> any filesystem would really depend on inode_lock in this path (famous last
> words ;)).

Not holding the inode lock in ->fsync would solve all of this indeed.
