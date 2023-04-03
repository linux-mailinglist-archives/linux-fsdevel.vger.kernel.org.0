Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D4E6D47C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 16:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbjDCOXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 10:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbjDCOW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:22:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38C32CAF0;
        Mon,  3 Apr 2023 07:22:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86BEC21DCA;
        Mon,  3 Apr 2023 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680531761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R46s3dzmAWjax7iXZKikFYCLr1xSbo6uFhX0zzjg4pU=;
        b=XViU3+ETjmX+Zv1i3Q4VVTn7Ny+KHI+pcGRnoPPT3r61aXIzJBxPYzNkNl9++TJ9aBjV6M
        pj5xzmCEcljzJ3VrWr7zg8WDaJErfGUilAp+755lKhp6uAWpsjuSCcyiyy9snmSveJO8Pa
        dYp4hCNxKq+rm1Sy8iI/zHvhEXqBk/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680531761;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R46s3dzmAWjax7iXZKikFYCLr1xSbo6uFhX0zzjg4pU=;
        b=U1FjLpLfehFJEz9putWhis2w9XqHu0U3h3oaiL98jCSHliu31HtoSv01Qgpvds/nc1S0hp
        frS9z8ZPoJjwAoCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 773A813416;
        Mon,  3 Apr 2023 14:22:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nFUjHTHhKmRzFQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 03 Apr 2023 14:22:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EF44AA0723; Mon,  3 Apr 2023 16:22:40 +0200 (CEST)
Date:   Mon, 3 Apr 2023 16:22:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        devel@lists.orangefs.org, reiserfs-devel@vger.kernel.org,
        Evgeniy Dushistov <dushistov@mail.ru>
Subject: Re: RFC: Filesystem metadata in HIGHMEM
Message-ID: <20230403142240.ftkywr3vn3r73yva@quack3>
References: <ZBCJ11qT8AWGA9y8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBCJ11qT8AWGA9y8@casper.infradead.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 14-03-23 14:51:03, Matthew Wilcox wrote:
> TLDR: I think we should rip out support for fs metadata in highmem
> 
> We want to support filesystems on devices with LBA size > PAGE_SIZE.
> That's subtly different and slightly harder than fsblk size > PAGE_SIZE.
> We can use large folios to read the blocks into, but reading/writing
> the data in those folios is harder if it's in highmem.  The kmap family
> of functions can only map a single page at a time (and changing that
> is hard).  We could vmap, but that's slow and can't be used from atomic
> context.  Working a single page at a time can be tricky (eg consider an
> ext2 directory entry that spans a page boundary).
> 
> Many filesystems do not support having their metadata in highmem.
> ext4 doesn't.  xfs doesn't.  f2fs doesn't.  afs, ceph, ext2, hfs,
> minix, nfs, nilfs2, ntfs, ntfs3, ocfs2, orangefs, qnx6, reiserfs, sysv
> and ufs do.
> 
> Originally, ext2 directories in the page cache were done by Al Viro
> in 2001.  At that time, the important use-case was machines with tens of
> gigabytes of highmem and ~800MB of lowmem.  Since then, the x86 systems
> have gone to 64-bit and the only real uses for highmem are cheap systems
> with ~8GB of memory total and 2-4GB of lowmem.  These systems really
> don't need to keep directories in highmem; using highmem for file &
> anon memory is enough to keep the system in balance.
> 
> So let's just rip out the ability to keep directories (and other fs
> metadata) in highmem.  Many filesystems already don't support this,
> and it makes supporting LBA size > PAGE_SIZE hard.
> 
> I'll turn this into an LSFMM topic if we don't reach resolution on the
> mailing list, but I'm optimistic that everybody will just agree with
> me ;-)

FWIW I won't object for the local filesystems I know about ;). But you
mention some networking filesystems above like NFS, AFS, orangefs - how are
they related to the LBA size problem you mention and what exactly you want
to get rid of there? FWIW I can imagine some 32-bit system (possibly
diskless) that uses NFS and that would benefit in caching stuff in
highmem...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
