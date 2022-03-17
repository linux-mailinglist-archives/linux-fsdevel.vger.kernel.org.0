Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51D54DD007
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 22:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiCQVRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 17:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiCQVRq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:17:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F0A1A7770;
        Thu, 17 Mar 2022 14:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mQVi/8AUGelccD6B82H7IX/Q4dG4lWAcNI5AMJjQ7Ww=; b=hJe+x6ypYZMPRYM+nzGb+mzE3o
        M4G15eQPY+WAdTrlxvOCmJxVkqSZvod7K8f+G3t1ZECiN/R9M9rrWjBJymo282e1laNhQutHt8jE3
        eaJAmEcmTMVF3VAi8UZALMXOSsqaA2iDoghRHxTzSil6AMVmdndedIPoecexanjGyfPJuviG1gGce
        l8MIKXuzvBfPYYSDo3bv47PYE0zQDThYogTCLghFBfK6Ph6cp7lYNFQQfMq65hF6Vpfjmw9zB806A
        B4Wf4GAQMQ598uNZ+qDtoA7Wxj+OJFt27QVkKml6t4YMiBuC1wUNAW/XEYNwij4+//zDgcsGCDI4y
        TLkcR+GQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUxTo-007KMx-A5; Thu, 17 Mar 2022 21:16:20 +0000
Date:   Thu, 17 Mar 2022 21:16:20 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Brian Foster <bfoster@redhat.com>, Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Ashish Sangwan <a.sangwan@samsung.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
Message-ID: <YjOlJL7xwktKoLFN@casper.infradead.org>
References: <YjDj3lvlNJK/IPiU@bfoster>
 <YjJPu/3tYnuKK888@casper.infradead.org>
 <CAHk-=wgPTWoXCa=JembExs8Y7fw7YUi9XR0zn1xaxWLSXBN_vg@mail.gmail.com>
 <YjNN5SzHELGig+U4@casper.infradead.org>
 <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZvOpaP0DVyqOnspFqpXRaT6q53=gnA2psxnf5dbt7bw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:26:35PM -0700, Linus Torvalds wrote:
> On Thu, Mar 17, 2022 at 8:04 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > So how about we do something like this:
> >
> >  - Make folio_start_writeback() and set_page_writeback() return void,
> >    fixing up AFS and NFS.
> >  - Add a folio_wait_start_writeback() to use in the VFS
> >  - Remove the calls to set_page_writeback() in the filesystems
> 
> That sounds lovely, but it does worry me a bit. Not just the odd
> 'keepwrite' thing, but also the whole ordering between the folio bit
> and the tagging bits. Does the ordering possibly matter?

I wouldn't change the ordering of setting the xarray bits and the
writeback flag; they'd just be set a little earlier.  It'd all be done
while the page was still locked.  But you're right, there's lots of
subtle interactions here.

> That whole "xyz_writeback_keepwrite()" thing seems odd. It's used in
> only one place (the folio version isn't used at all):
> 
>   ext4_writepage():
> 
>      ext4_walk_page_buffers() fails:
>                 redirty_page_for_writepage(wbc, page);
>                 keep_towrite = true;
>       ext4_bio_write_page().
> 
> which just looks odd. Why does it even try to continue to do the
> writepage when the page buffer thing has failed?
> 
> In the regular write path (ie ext4_write_begin()), a
> ext4_walk_page_buffers() failure is fatal or causes a retry). Why is
> ext4_writepage() any different? Particularly since it wants to keep
> the page dirty, then trying to do the writeback just seems wrong.
> 
> So this code is all a bit odd, I suspect there are decades of "people
> continued to do what they historically did" changes, and it is all
> worrisome.

I found the commit: 1c8349a17137 ("ext4: fix data integrity sync in
ordered mode").  Fortunately, we have a documented test for this,
generic/127, so we'll know if we've broken it.
