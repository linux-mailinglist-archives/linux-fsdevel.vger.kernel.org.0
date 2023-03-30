Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED39C6D12E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Mar 2023 01:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjC3XQh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 19:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjC3XQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 19:16:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7141024A;
        Thu, 30 Mar 2023 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sNZf8S8tAdiAtHNv7P7z5NGeuKmDoJoQUzbTOv5U604=; b=ouTsP78z3P4it/9JFsVjOojCp+
        lY8lKc1N8WpVb+t2H9yNwbWU+MXePFeVQTPkxiC3IOCjsDCbKMcl17ee4yL5JxcYQJfEZdDaYyvpm
        UeGRYbGn8fZpfnBJmD6LKSYp38a4IGZol7JwFine1zCft3dAA7+0ZYSEdntctnwVmj0VzhE99RhnZ
        Wo13MsUV8iz4o9/k/FAEKPMB2ycoHyT0R/YxB02dRlSXu+EChuLBdRoiQNgTzcXHRDRqMj8c0WK0F
        vOgwXs/LnMM4U7G7YqyEdigyfCu35poBGP6FagjrTnY86rnIe4H9WLIGGV8jaI3ZarlX3A/RJaSud
        R0LXqUqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pi1VJ-005J6y-26;
        Thu, 30 Mar 2023 23:16:25 +0000
Date:   Thu, 30 Mar 2023 16:16:25 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, martin@omnibond.com,
        axboe@kernel.dk, akpm@linux-foundation.org, hubcap@omnibond.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org
Subject: Re: [PATCH 1/5] zram: remove the call to page_endio in the bio
 end_io handler
Message-ID: <ZCYYSdpmWRJynC6d@infradead.org>
References: <20230328112716.50120-1-p.raghav@samsung.com>
 <CGME20230328112718eucas1p214a859cfb3d7b45523356bcc16c373b1@eucas1p2.samsung.com>
 <20230328112716.50120-2-p.raghav@samsung.com>
 <ZCYSincU0FlULyWJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCYSincU0FlULyWJ@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:51:54PM -0700, Minchan Kim wrote:
> > to remove the call to page_endio() function that unlocks or marks
> > writeback end on the page.
> > 
> > Rename the endio handler from zram_page_end_io to zram_read_end_io as
> > the call to page_endio() is removed and to associate the callback to the
> > operation it is used in.
> 
> Since zram removed the rw_page and IO comes with bio from now on,
> IIUC, we are fine since every IO will go with chained-IO. Right?

writeback_store callszram_bvec_read with a NULL bio, that is it just
fires off an async read without any synchronization.

