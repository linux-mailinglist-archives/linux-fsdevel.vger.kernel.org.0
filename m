Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E283691D0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 11:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjBJKm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 05:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjBJKmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:42:25 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4BF34C1F;
        Fri, 10 Feb 2023 02:42:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2F6E63FE8E;
        Fri, 10 Feb 2023 10:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676025743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiLp0nIlB2IXBYhm+6Edakc0p6tqgjH4KpcYsBQFpLg=;
        b=mQE/LUprHzh3stPmglOJ6jd3j2pgKsJODJhmu0VY3MhqZ8PLt8axg/z4NfRLR2Qp+E515L
        Rd+hDKvOjSdhC7N717IOBDHARedFEYAIroyfTsk9XlTqyofvoionsSqVwhfF/x3vPfDCZy
        b87rfhT13wBptvCOwpjm45QF8Uv7CXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676025743;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eiLp0nIlB2IXBYhm+6Edakc0p6tqgjH4KpcYsBQFpLg=;
        b=cRvRDsg8afBmL2ySK1Lp/33L4BWOacH291O70bjzPGsKMqvaZ09Dn4vms3ULCpxYnmODBJ
        bSTMTaYjH5Ir83Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22A8F1325E;
        Fri, 10 Feb 2023 10:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 50FwCI8f5mOxUQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 10 Feb 2023 10:42:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 94D6AA06D8; Fri, 10 Feb 2023 11:42:22 +0100 (CET)
Date:   Fri, 10 Feb 2023 11:42:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 3/5] mm: Do not try to write pinned folio during memory
 cleaning writeback
Message-ID: <20230210104222.yt5ktthtwyc6f4iw@quack3>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-3-jack@suse.cz>
 <4961eb2d-c36b-d6a5-6a43-0c35d24606c0@nvidia.com>
 <175bbfce-a947-1dcd-1e5f-91a9b8ccfc25@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <175bbfce-a947-1dcd-1e5f-91a9b8ccfc25@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 09-02-23 18:10:23, John Hubbard wrote:
> On 2/9/23 17:54, John Hubbard wrote:
> > On 2/9/23 04:31, Jan Kara wrote:
> > > When a folio is pinned, there is no point in trying to write it during
> > > memory cleaning writeback. We cannot reclaim the folio until it is
> > > unpinned anyway and we cannot even be sure the folio is really clean.
> > > On top of that writeback of such folio may be problematic as the data
> > > can change while the writeback is running thus causing checksum or
> > > DIF/DIX failures. So just don't bother doing memory cleaning writeback
> > > for pinned folios.
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >   fs/9p/vfs_addr.c            |  2 +-
> > >   fs/afs/file.c               |  2 +-
> > >   fs/afs/write.c              |  6 +++---
> > >   fs/btrfs/extent_io.c        | 14 +++++++-------
> > >   fs/btrfs/free-space-cache.c |  2 +-
> > >   fs/btrfs/inode.c            |  2 +-
> > >   fs/btrfs/subpage.c          |  2 +-
> > 
> 
> Oh, and one more fix, below, is required in order to build with my local
> test config. Assuming that it is reasonable to deal with pinned pages
> here, which I think it is:
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index 9c759df700ca..c3279fb0edc8 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -313,7 +313,7 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
>  		if (!page)
>  			continue;
> -		if (!page_mapped(page) && clear_page_dirty_for_io(page)) {
> +		if (!page_mapped(page) && clear_page_dirty_for_io(&wbc, page)) {
>  			int ret;
>  			SetPageReclaim(page);
> 

Thanks, fixed up. It didn't occur to me to grep drivers/ for these
functions :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
