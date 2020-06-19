Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB27200109
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 06:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgFSEUv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 00:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgFSEUv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 00:20:51 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3359020789;
        Fri, 19 Jun 2020 04:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592540450;
        bh=9T0AEviO632sZSTUNtzmI3mY0uqN/4x8TYNPeuKa2ho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mY+DUhxDh+Qnevb5TU4KKwVJj7MPkASAN2TW9KMdOGGPpOJqxD6bvWc6R5+uxiSTn
         vQG/EWR+cbCYE5F6pxWNWXqG3VazfY0dm2nyIJCCNw2+jFwto4mV9XfTkptJZvzVBj
         IsxjM6raML1mkbJ60cjQ0ZfoEttRyaRI4RlroQcI=
Date:   Thu, 18 Jun 2020 21:20:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] f2fs: add inline encryption support
Message-ID: <20200619042048.GF2957@sol.localdomain>
References: <20200617075732.213198-1-satyat@google.com>
 <20200617075732.213198-4-satyat@google.com>
 <5e78e1be-f948-d54c-d28e-50f1f0a92ab3@huawei.com>
 <20200618181357.GC2957@sol.localdomain>
 <c6f9d02d-623f-8b36-1f18-91c69bdd17c8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6f9d02d-623f-8b36-1f18-91c69bdd17c8@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:39:34AM +0800, Chao Yu wrote:
> Hi Eric,
> 
> On 2020/6/19 2:13, Eric Biggers wrote:
> > Hi Chao,
> > 
> > On Thu, Jun 18, 2020 at 06:06:02PM +0800, Chao Yu wrote:
> >>> @@ -936,8 +972,11 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
> >>>  
> >>>  	inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> >>>  
> >>> -	if (io->bio && !io_is_mergeable(sbi, io->bio, io, fio,
> >>> -			io->last_block_in_bio, fio->new_blkaddr))
> >>> +	if (io->bio &&
> >>> +	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
> >>> +			      fio->new_blkaddr) ||
> >>> +	     !f2fs_crypt_mergeable_bio(io->bio, fio->page->mapping->host,
> >>> +				       fio->page->index, fio)))
> >>
> >> bio_page->index, fio)))
> >>
> >>>  		__submit_merged_bio(io);
> >>>  alloc_new:
> >>>  	if (io->bio == NULL) {
> >>> @@ -949,6 +988,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
> >>>  			goto skip;
> >>>  		}
> >>>  		io->bio = __bio_alloc(fio, BIO_MAX_PAGES);
> >>> +		f2fs_set_bio_crypt_ctx(io->bio, fio->page->mapping->host,
> >>> +				       fio->page->index, fio, GFP_NOIO);
> >>
> >> bio_page->index, fio, GFP_NOIO);
> >>
> > 
> > We're using ->mapping->host and ->index.  Ordinarily that would mean the page
> > needs to be a pagecache page.  But bio_page can also be a compressed page or a
> > bounce page containing fs-layer encrypted contents.
> 
> I'm concerning about compression + inlinecrypt case.
> 
> > 
> > Is your suggestion to keep using fio->page->mapping->host (since encrypted pages
> 
> Yup,
> 
> > don't have a mapping), but start using bio_page->index (since f2fs apparently
> 
> I meant that we need to use bio_page->index as tweak value in write path to
> keep consistent as we did in read path, otherwise we may read the wrong
> decrypted data later to incorrect tweak value.
> 
> - f2fs_read_multi_pages (only comes from compression inode)
>  - f2fs_alloc_dic
>   - f2fs_set_compressed_page(page, cc->inode,
> 					start_idx + i + 1, dic);
>                                         ^^^^^^^^^^^^^^^^^
>   - dic->cpages[i] = page;
>  - for ()
>      struct page *page = dic->cpages[i];
>      if (!bio)
>        - f2fs_grab_read_bio(..., page->index,..)
>         - f2fs_set_bio_crypt_ctx(..., first_idx, ..)   /* first_idx == cpage->index */
> 
> You can see that cpage->index was set to page->index + 1, that's why we need
> to use one of cpage->index/page->index as tweak value all the time rather than
> using both index mixed in read/write path.
> 
> But note that for fs-layer encryption, we have used cpage->index as tweak value,
> so here I suggest we can keep consistent to use cpage->index in inlinecrypt case.

Yes, inlinecrypt mustn't change the ciphertext that gets written to disk.

> 
> > *does* set ->index for compressed pages, and if the file uses fs-layer
> > encryption then f2fs_set_bio_crypt_ctx() won't use the index anyway)?
> > 
> > Does this mean the code is currently broken for compression + inline encryption
> > because it's using the wrong ->index?  I think the answer is no, since
> 
> I guess it's broken now for compression + inlinecrypt case.
> 
> > f2fs_write_compressed_pages() will still pass the first 'nr_cpages' pagecache
> > pages along with the compressed pages.  In that case, your suggestion would be a
> > cleanup rather than a fix?
> 
> That's a fix.
> 

FWIW, I tested this, and it actually works both before and after your suggested
change.  The reason is that f2fs_write_compressed_pages() actually passes the
pagecache pages sequentially starting at 'start_idx_of_cluster(cc) + 1' for the
length of the compressed cluster.  That matches the '+ 1' adjustment elsewhere,
so we have fio->page->index == bio_page->index.

I personally think the way the f2fs compression code works is really confusing.
Compressed pages don't have a 1:1 correspondence to pagecache pages, so there
should *not* be a pagecache page passed around when writing a compressed page.

Anyway, here's the test script I used in case anyone else wants to use it.  But
we really need to write a proper f2fs compression + encryption test for xfstests
which decrypts and decompresses a file in userspace and verifies we get back the
original data.  (There are already ciphertext verification tests, but they don't
cover compression.)  Note that this test is needed even for the filesystem-layer
encryption which is currently supported.

#!/bin/bash

set -e

DEV=/dev/vdb

umount /mnt &> /dev/null || true
mkfs.f2fs -f -O encrypt,compression,extra_attr $DEV
head -c 1000000 /dev/zero > /tmp/testdata

for opt1 in '-o inlinecrypt' ''; do
        mount $DEV /mnt $opt1
        rm -rf /mnt/.fscrypt /mnt/dir
        fscrypt setup /mnt
        mkdir /mnt/dir
        chattr +c /mnt/dir
        echo hunter2 | fscrypt encrypt /mnt/dir --quiet --source=custom_passphrase --name=secret
        cp /tmp/testdata /mnt/dir/file
        umount /mnt
        for opt2 in '-o inlinecrypt' ''; do
                mount $DEV /mnt $opt2
                echo hunter2 | fscrypt unlock /mnt/dir --quiet
                cmp /mnt/dir/file /tmp/testdata
                umount /mnt
        done
done
