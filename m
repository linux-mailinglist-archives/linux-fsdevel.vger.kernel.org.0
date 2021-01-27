Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97170306186
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 18:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhA0REw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 12:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhA0RCq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:02:46 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F40AC061574;
        Wed, 27 Jan 2021 09:01:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id a20so1609817pjs.1;
        Wed, 27 Jan 2021 09:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vtepp4TZmVRvIbUVDYOarm58wBYnXPgnDjuNfeHxdtc=;
        b=ZgCmQUbVt9Ht+2dI0uE93whJgeLCVOUmzWeIxNqpjxtqOaXNdmeEG9qipZ+10Zc/zb
         2ybd+rCe/aNVN1vdCzKEWqFPK2rZqH5xbiiVqcPZBP1LJ64fthGKYk/aY28E8LMyNGa7
         O/CdUhpXmnqjZRkAyuyI4GCyYTLffo5wZ/w+kAnBY6xn2Rl6Dfqks4BORPwcft5+30Df
         ZPTtAqnDJk/jTl4v4qhc0YoKAtnw668EeAmVKTge0o+wlLxy4YKKJNwXgX5TsHCDIAC/
         J0hj3JMCo5O7zkYwV2RRbZLdDWtMLcJdF/CmfkkvaWN4VgItvp9rSUFi5nLIwzemZFmM
         WylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vtepp4TZmVRvIbUVDYOarm58wBYnXPgnDjuNfeHxdtc=;
        b=XIyAeVwjVU4ZIazuY8otr5PZx3exIjnsP4QS7IBKaUfdAyr04bkNJ9XtWVjMplIAjx
         MFV2s2lXyEAwasWktyoQGiWTbSA4OyUftlDCySFbZ528NtFphAmVV+vLNg6+jiB0TO6a
         j3/XsHOROt1dLk/9bSftDT86tdX3y4vwiX+T3+HHVp0JyAAKRQ4uNZ10IEONce/WQjI8
         qb3BQ8r8QH6PGhhiOj1X4grFqMsi35PtqqKyBq3Y9e0hg/yr7fNl80HoBYQfAumUGlcN
         SN0n5TOaG7JCf8nZeEGh+26FQv6hOc1Xx5GdcZ6VfmF4MEQK/MemKK8jxShje6cinnRb
         l6IA==
X-Gm-Message-State: AOAM530VAkh2R5fQqKUjjT4Spt08hRX+OP/hUk0yoQG2NwSr/KqvnSNI
        C/qxDIRqfVFzyDDwHZ95CLo=
X-Google-Smtp-Source: ABdhPJzmHhfUFA/75Zv/UDnqfz6FCOjqg2rT0LuDRrn5TaPMOXPDx/ORUyPSivMQuwCqJtUASFgh8g==
X-Received: by 2002:a17:902:b206:b029:dc:1f41:962d with SMTP id t6-20020a170902b206b02900dc1f41962dmr12522286plr.28.1611766916993;
        Wed, 27 Jan 2021 09:01:56 -0800 (PST)
Received: from google.com ([2620:15c:211:201:9dd5:b47b:bb84:dede])
        by smtp.gmail.com with ESMTPSA id q197sm2937750pfc.155.2021.01.27.09.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 09:01:55 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 27 Jan 2021 09:01:52 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        viro@zeniv.linux.org.uk, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Laura Abbott <lauraa@codeaurora.org>
Subject: Re: [PATCH v4] fs/buffer.c: Revoke LRU when trying to drop buffers
Message-ID: <YBGcgGLcXhvLl9+/@google.com>
References: <cover.1611642038.git.cgoldswo@codeaurora.org>
 <e8f3e042b902156467a5e978b57c14954213ec59.1611642039.git.cgoldswo@codeaurora.org>
 <YBCexclveGV2KH1G@google.com>
 <20210127025922.GS308988@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127025922.GS308988@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:59:22AM +0000, Matthew Wilcox wrote:
> On Tue, Jan 26, 2021 at 02:59:17PM -0800, Minchan Kim wrote:
> > The release buffer_head in LRU is great improvement for migration
> > point of view.
> > 
> > A question: 
> > 
> > Can't we invalidate(e.g., invalidate_bh_lrus) bh_lru in migrate_prep or
> > elsewhere when migration found the failure and is about to retry?
> > 
> > Migration has done such a way for other per-cpu stuffs for a long time,
> > which would be more consistent with others and might be faster sometimes
> > with reducing IPI calls for page.
> 
> Should lru_add_drain_all() also handle draining the buffer lru for all
> callers?  A quick survey ...
> 
> invalidate_bdev() already calls invalidate_bh_lrus()
> compact_nodes() would probably benefit from the BH LRU being invalidated
> POSIX_FADV_DONTNEED would benefit if the underlying filesystem uses BHs
> check_and_migrate_cma_pages() would benefit
> khugepaged_do_scan() doesn't need it today
> scan_get_next_rmap_item() looks like it only works on anon pages (?) so
> 	doesn't need it
> mem_cgroup_force_empty() probably needs it
> mem_cgroup_move_charge() ditto
> memfd_wait_for_pins() doesn't need it
> shake_page() might benefit
> offline_pages() would benefit
> alloc_contig_range() would benefit
> 
> Seems like most would benefit and a few won't care.  I think I'd lean
> towards having lru_add_drain_all() call invalidate_bh_lrus(), just to
> simplify things.

Fair enough.
