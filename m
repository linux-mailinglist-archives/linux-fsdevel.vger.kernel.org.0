Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0414691D54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 11:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjBJKyW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 05:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjBJKyR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:54:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E3C3757E;
        Fri, 10 Feb 2023 02:54:16 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 03F6967420;
        Fri, 10 Feb 2023 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676026455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qd6hI//mXrSje7KDJTNwEI85+thpTgK/G3BL+ZFCWbs=;
        b=Zqabz1HaHQVUoOIoseWWANEs+FKK/VZy9pUuPg2oUsL0sv8/3d1eb6I4Lf9ro8NzMc1WFq
        0l94AmTWWi3vD+XSZNQALO4YuSaVCZk4GUpk5PA3+PPFkzFpnAaZARgcnPcZgX98m2/Fbl
        gazc+VmS2NAFXgNtj2Uir9vyYz3ex7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676026455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qd6hI//mXrSje7KDJTNwEI85+thpTgK/G3BL+ZFCWbs=;
        b=Z6lP7/fqHBmxR1Pci8Tz+uMVl1pQCRUOn2xngg/7G1sN+nHVslHxmtA9NwCRuxEQ+n/e4D
        f5QQ17inYS2EQWBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E921C1325E;
        Fri, 10 Feb 2023 10:54:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r6XgOFYi5mPqVwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 10 Feb 2023 10:54:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 60349A06D8; Fri, 10 Feb 2023 11:54:12 +0100 (CET)
Date:   Fri, 10 Feb 2023 11:54:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/5] mm: Do not try to write pinned folio during memory
 cleaning writeback
Message-ID: <20230210105412.7xobajl2p7ulhclr@quack3>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-3-jack@suse.cz>
 <4961eb2d-c36b-d6a5-6a43-0c35d24606c0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4961eb2d-c36b-d6a5-6a43-0c35d24606c0@nvidia.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-02-23 17:54:14, John Hubbard wrote:
> On 2/9/23 04:31, Jan Kara wrote:
> > When a folio is pinned, there is no point in trying to write it during
> > memory cleaning writeback. We cannot reclaim the folio until it is
> > unpinned anyway and we cannot even be sure the folio is really clean.
> > On top of that writeback of such folio may be problematic as the data
> > can change while the writeback is running thus causing checksum or
> > DIF/DIX failures. So just don't bother doing memory cleaning writeback
> > for pinned folios.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >   fs/9p/vfs_addr.c            |  2 +-
> >   fs/afs/file.c               |  2 +-
> >   fs/afs/write.c              |  6 +++---
> >   fs/btrfs/extent_io.c        | 14 +++++++-------
> >   fs/btrfs/free-space-cache.c |  2 +-
> >   fs/btrfs/inode.c            |  2 +-
> >   fs/btrfs/subpage.c          |  2 +-
> 
> Hi Jan!
> 
> Just a quick note that this breaks the btrfs build in subpage.c.
> Because, unfortunately, btrfs creates 6 sets of functions via calls to a
> macro: IMPLEMENT_BTRFS_PAGE_OPS(). And that expects only one argument to
> the clear_page_func, and thus to clear_page_dirty_for_io().
> 
> It seems infeasible (right?) to add another argument to the other
> clear_page_func functions, which include:
> 
>    ClearPageUptodate
>    ClearPageError
>    end_page_writeback
>    ClearPageOrdered
>    ClearPageChecked
> 
> , so I expect IMPLEMENT_BTRFS_PAGE_OPS() may need to be partially
> unrolled, in order to pass in the new writeback control arg to
> clear_page_dirty_for_io().

Aha, thanks for catching this. So it is easy to fix this to make things
compile (just a wrapper around clear_page_dirty_for_io() - done now). It
will be a bit more challenging to propagate wbc into there for proper
decision - that will probably need these functions not to be defined by the
macros.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
