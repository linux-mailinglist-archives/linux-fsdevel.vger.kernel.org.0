Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CF2550F7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 06:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbiFTErp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 00:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFTEro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:47:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F1DDE8B;
        Sun, 19 Jun 2022 21:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fCr5yst88e9lOqfCL8d20AyDjixx1Tg4bKOmHaG5Jow=; b=CB7fZ7AWdEHyso1o/f+KTAvtct
        LpAuZ/vJN2PAKslW7c3JjUGbQZ0LDPxG4H/stpmRgfBfT5Jcf4B+pauHkDfLKtEoJB8zfxGyl3YlT
        WTW5R0VFufpOc8LsIN/XeVRUbzS2ThaEd6C1eZJvqjvZwk8X5sCORVr9UPyykDWItfvmRPQUluwzO
        gPMT+VPfarZYzTMA7AYFoGif0o9iV8ohWa6cYmtrxKRHmtblzYaIojoRc2FZ1ip98xax7GxHU9GyU
        wzyA5m2106PS6Ey5nYh8h5MJMRIIX49Xev2nT2tDv+tKn5EAU4+8ESZtOMq6O5YB5g+48y8xcn+Me
        oygBbQmg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o39K4-004s1L-KZ; Mon, 20 Jun 2022 04:47:36 +0000
Date:   Mon, 20 Jun 2022 05:47:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap: obey mapping->invalidate_lock lock/unlock order
Message-ID: <Yq/76OJgZ2GgRReN@casper.infradead.org>
References: <20220618083820.35626-1-linmiaohe@huawei.com>
 <Yq2qQcHUZ2UjPk/M@casper.infradead.org>
 <364c8981-95c4-4bf8-cfbf-688c621db5b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <364c8981-95c4-4bf8-cfbf-688c621db5b5@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 20, 2022 at 09:56:06AM +0800, Miaohe Lin wrote:
> On 2022/6/18 18:34, Matthew Wilcox wrote:
> > On Sat, Jun 18, 2022 at 04:38:20PM +0800, Miaohe Lin wrote:
> >> The invalidate_locks of two mappings should be unlocked in reverse order
> >> relative to the locking order in filemap_invalidate_lock_two(). Modifying
> > 
> > Why?  It's perfectly valid to lock(A) lock(B) unlock(A) unlock(B).
> > If it weren't we'd have lockdep check it and complain.
> 
> For spin_lock, they are lock(A) lock(B) unlock(B) unlock(A) e.g. in copy_huge_pud,

I think you need to spend some time thinking about the semantics of
locks and try to figure out why it would make any difference at all
which order locks (of any type) are _unlocked_ in,

> copy_huge_pmd, move_huge_pmd and so on:
> 	dst_ptl = pmd_lock(dst_mm, dst_pmd);
> 	src_ptl = pmd_lockptr(src_mm, src_pmd);
> 	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> 	...
> 	spin_unlock(src_ptl);
> 	spin_unlock(dst_ptl);
> 
> For rw_semaphore, they are also lock(A) lock(B) unlock(B) unlock(A) e.g. in dup_mmap():
> 	mmap_write_lock_killable(oldmm)
> 	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
> 	...
> 	mmap_write_unlock(mm);
> 	mmap_write_unlock(oldmm);
> 
> and ntfs_extend_mft():
> 	down_write(&ni->file.run_lock);
> 	down_write_nested(&sbi->used.bitmap.rw_lock, BITMAP_MUTEX_CLUSTERS);
> 	...
> 	up_write(&sbi->used.bitmap.rw_lock);
> 	up_write(&ni->file.run_lock);
> 
> But I see some lock(A) lock(B) unlock(A) unlock(B) examples in some fs codes. Could you
> please tell me the right lock/unlock order? I'm somewhat confused now...
> 
> BTW: If lock(A) lock(B) unlock(A) unlock(B) is requested, filemap_invalidate_lock_two might
> still need to be changed to respect that order?
> 
> Thanks!
> 
> > 
> > .
> > 
> 
