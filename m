Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55172370F86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 May 2021 00:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhEBXAU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 May 2021 19:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhEBXAT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 May 2021 19:00:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577AC06174A
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 May 2021 15:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=glxyuYJp1BIGffXRJutfwTpBRZp72WEHpUf+fCAIPeU=; b=Q+T02j36y4Mb/3Z4UELnNVU5Va
        oIb7WRvxu6kzHCaFiT8ZpS/AcA1uHWA5Pcu9WZrydm8k7tb/xFlBHI2xmTu1KZaLz5ZlCMg95LBrO
        T571cF8AM8lY6HcI6UNNH9kFOMldQuFu5pfraHQI9IGcMaOpbmw4lj1jQs/FpEsJ/ga7h9USEg59n
        KmUrTYtAD/gwHNgQlcXgDrZbFgGmUK0n1KclqOsokgT+t5P0gslegNOqkNVE6YHD91dSus+2d3Q78
        HGD2P215YEH+WRSKL9KL6vS69gMEnNKztohdMCUmuXHCqIHIncyVyMP8MDYijgE0tCZ8OlpFj3JTT
        iB1ivt7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ldL38-00EMSJ-5S; Sun, 02 May 2021 22:59:04 +0000
Date:   Sun, 2 May 2021 23:58:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Marshall <hubcap@omnibond.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Mike Marshall <hubcapsc@gmail.com>
Subject: Re: [GIT PULL] orangefs pull request for 5.13
Message-ID: <20210502225854.GA1847222@casper.infradead.org>
References: <CAOg9mSQ-p8vJ6LbSeTeNUCfu-PsT2=iS2+Kab-LYCu9h6MUu2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOg9mSQ-p8vJ6LbSeTeNUCfu-PsT2=iS2+Kab-LYCu9h6MUu2A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 02, 2021 at 04:45:19PM -0400, Mike Marshall wrote:
> orangefs: implement orangefs_readahead
> 
> mm/readahead.c/read_pages was quite a bit different back
> when I put my open-coded readahead logic into orangefs_readpage.
> It seemed to work as designed then, it is a trainwreck now.

Hey Mike,

I happened to have a chance to look at orangefs_readahead today, and
I'd like to suggest a minor improvement.

It's possible for rac->file to be NULL if the caller doesn't have a
struct file.  I think that only happens when filesystems call their own
readahead routine internally, but in case it might happen from generic
code in the future, I recommend you do something like ...

-       struct file *file = rac->file;
-       struct inode *inode = file->f_mapping->host;
+       struct inode *inode = rac->mapping->host;
...
-       i_pages = &file->f_mapping->i_pages;
+       i_pages = &rac->mapping->i_pages;
...
-                       inode->i_size, NULL, NULL, file)) < 0)
+                       inode->i_size, NULL, NULL, rac->file)) < 0)

(i have this change all tangled up with some other changes in my tree,
so no easy patch to apply, sorry)
