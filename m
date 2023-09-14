Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF987A0BB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 19:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbjINR1T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 13:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239146AbjINR1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:27:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C0135AB;
        Thu, 14 Sep 2023 10:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dqDv/hwF6Eczp53Duz1WARx/GLsoIfW+je4PWhL2caY=; b=v2nCBNcwGOOcphelXerTWx6E8j
        LW19T5hhXfSy0yd/e+djrb8Vr5bgOcEv61v8A0VpXSh0qKvaQF/EL8VULTfb3kTixW+HSIriR63gK
        F/CmEWG5VrFhqvQFDt8agFNKe5h+AJ1usqhvWW9cj7M6AN8CSzkr0ANn5s3TPGnRWwaNzvqgDldaI
        vLzXZBxTT3MgPGxAnSo+sNq9H+h4sfB4oG8CCg0lfF18F1nCeKhiel8lm/D+E+mwjZHf3fwJirIoj
        9inBEbAVJJNV1iS5EWrc9RFFPsi6n7TDo502SiyCCGzuMIR3Oe/REZf4v1bbjqL+GAYogV8P7qGQm
        kEGBKbpA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgq69-004BiD-EZ; Thu, 14 Sep 2023 17:25:49 +0000
Date:   Thu, 14 Sep 2023 18:25:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     akpm@linux-foundation.org, Hui Zhu <teawater@antgroup.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] buffer: Hoist GFP flags from grow_dev_page() to
 __getblk_gfp()
Message-ID: <ZQNCHeUAtpP9EFNX@casper.infradead.org>
References: <20230811161528.506437-1-willy@infradead.org>
 <20230811161528.506437-3-willy@infradead.org>
 <20230914091625.hjbmlanqc6sxonwi@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914091625.hjbmlanqc6sxonwi@quack3>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:16:25AM +0200, Jan Kara wrote:
> On Fri 11-08-23 17:15:27, Matthew Wilcox (Oracle) wrote:
> > grow_dev_page() is only called by grow_buffers().  grow_buffers()
> > is only called by __getblk_slow() and __getblk_slow() is only called
> > from __getblk_gfp(), so it is safe to move the GFP flags setting
> > all the way up.  With that done, add a new bdev_getblk() entry point
> > that leaves the GFP flags the way the caller specified them.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> Can't we just finish this gfp parameter conversion for all the users?
> There are five __getblk_gfp() users, three in buffer_head.h directly
> generate gfp mask, two (__bread_gfp() and sb_getblk_gfp()) pass it from the
> caller. All three __bread_gfp() callers are in buffer_head.h and directly
> generate gfp mask. sb_getblk_gfp() has five callers, all in ext4 and easily
> convertable as well.
> 
> This results not only in cleaner code but also just checking
> sb_getblk_gfp() callers shows how confused they currently are about the gfp
> argument (passing NOFS, NOFAIL and other pointless flags). Secondly, we can
> keep using sb_getblk_gfp() from the filesystems instead of having to decide
> between sb_getblk_gfp() and bdev_getblk().

I didn't do __bread_gfp() because it's basically an internal interface.
All users call sb_bread(), sb_bread_unmovable() or __bread().
It doesn't seem worth doing.  Now, if we start to see people actually
using __bread_gfp() outside of those three interfaces, I'd agree we need
to make it use GFP flags properly.

BTW, Andrew has taken the bdev_getblk() series into the mm tree, so
testing that tree might be a good idea for the ext4 developers (and other
filesystems; an earlier revision of this patchset  had a bug which would
have only affected nilfs2).
