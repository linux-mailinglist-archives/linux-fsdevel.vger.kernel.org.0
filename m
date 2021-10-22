Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5544373C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 10:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhJVInv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 04:43:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37232 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJVInu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:43:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2E471212C8;
        Fri, 22 Oct 2021 08:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1634892092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUTA5Jw5vXR7hfBklBPTGzgJVoiY+oGxN0ZIH2ohiuU=;
        b=hUeet1mvoGA5h/fTMMNRWlNcPBNVd/vMlJXCdqzUYqCN21jWa8ML3xIM6eneby/KN3MBMv
        r+gStONFMg8gxkY48tjc6Z0Ol2/9ATChBGk3rx5XV2JzpG+CBKffrwj1CzkukmX+P54MoI
        tG9+6ycKKO6eEOPoQ97jRJBptPjACDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1634892092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jUTA5Jw5vXR7hfBklBPTGzgJVoiY+oGxN0ZIH2ohiuU=;
        b=93TfJ6AlqJHa9yXjCPyODn6CTm5FhUSb9kiJtGJhmueazloUFAr8rZS/ygrMCciVWT+AeN
        XIUcYzyPA9K4XXCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0A738A3B81;
        Fri, 22 Oct 2021 08:41:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B2BB51E11B6; Fri, 22 Oct 2021 10:41:27 +0200 (CEST)
Date:   Fri, 22 Oct 2021 10:41:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Phillip Susi <phill@thesusis.net>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-erofs@lists.ozlabs.org, linux-btrfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
        linux-bcache@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: Readahead for compressed data
Message-ID: <20211022084127.GA1026@quack2.suse.cz>
References: <YXHK5HrQpJu9oy8w@casper.infradead.org>
 <87tuh9n9w2.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuh9n9w2.fsf@vps.thesusis.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-10-21 21:04:45, Phillip Susi wrote:
> 
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > As far as I can tell, the following filesystems support compressed data:
> >
> > bcachefs, btrfs, erofs, ntfs, squashfs, zisofs
> >
> > I'd like to make it easier and more efficient for filesystems to
> > implement compressed data.  There are a lot of approaches in use today,
> > but none of them seem quite right to me.  I'm going to lay out a few
> > design considerations next and then propose a solution.  Feel free to
> > tell me I've got the constraints wrong, or suggest alternative solutions.
> >
> > When we call ->readahead from the VFS, the VFS has decided which pages
> > are going to be the most useful to bring in, but it doesn't know how
> > pages are bundled together into blocks.  As I've learned from talking to
> > Gao Xiang, sometimes the filesystem doesn't know either, so this isn't
> > something we can teach the VFS.
> >
> > We (David) added readahead_expand() recently to let the filesystem
> > opportunistically add pages to the page cache "around" the area requested
> > by the VFS.  That reduces the number of times the filesystem has to
> > decompress the same block.  But it can fail (due to memory allocation
> > failures or pages already being present in the cache).  So filesystems
> > still have to implement some kind of fallback.
> 
> Wouldn't it be better to keep the *compressed* data in the cache and
> decompress it multiple times if needed rather than decompress it once
> and cache the decompressed data?  You would use more CPU time
> decompressing multiple times, but be able to cache more data and avoid
> more disk IO, which is generally far slower than the CPU can decompress
> the data.

Well, one of the problems with keeping compressed data is that for mmap(2)
you have to have pages decompressed so that CPU can access them. So keeping
compressed data in the page cache would add a bunch of complexity. That
being said keeping compressed data cached somewhere else than in the page
cache may certainly me worth it and then just filling page cache on demand
from this data...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
