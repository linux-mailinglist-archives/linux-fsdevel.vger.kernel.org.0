Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0662C48EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 21:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgKYUTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 15:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKYUTm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:19:42 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC3C0613D4;
        Wed, 25 Nov 2020 12:19:34 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y18so5883413qki.11;
        Wed, 25 Nov 2020 12:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wTpG1f7I5Mn7omq14ZEE1b1D1RGafIOA8Nh3enwy9Pw=;
        b=dhUspYM1wMwx4g0p349xFh+cvmkFpUHO1fMAZy5dL/oqd7kSU1ym0YtWGCwe2K5BNw
         aVwhhCckrBdx67CbATI/FFwUOrbyBQxEavleHAqEAzxG3D9N0conr/HIspxr9fzB6SfX
         i43+lRwnKCGUgJA9cRAA9Ia9ro51DDhqCV8/s5EXlHTEJAjPYAn71BuXgNVEaOWGHhM5
         mSZeoeXij9s0EAWe8DhLGkPD+d8qJ0w9uk4zhr+1KpPzvTLi317obMTNtjWvqw22AAjn
         KI0qVXs/lejTVRHvWB2yfTW87bz2pPoM76U/jKdBe6vlpVASMEZRlI5rvHT10TKYbrfB
         7MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wTpG1f7I5Mn7omq14ZEE1b1D1RGafIOA8Nh3enwy9Pw=;
        b=lTjBcokzEdHtn3X1OT7SH5Eema4BrbZdeVMezc5wehmV6chs5JU8htUcYGS/2jOQyB
         PN4vrguCP0s29ZjMxN6JOgS/l4Qdz01tfIp7JBZTG1+LBtllwAnlboveVa3H+lXcsLlC
         C6RPB5celA97DeEiu++CgHQpwkOcjuVONLWQo1Yu5kxnaxWjmnJqXZVH3WnFLZak7T1L
         2tIsL9JECz9aC4qz5lRbEkKZFacdljPK3BXniqcRKEi9NE3lYVrnDGr7BCs4UD619w1R
         qmcdjaLQq80rtz83xVxamSmxgjs4P2EEEimCgJZaJXLyJYJtnTQuJj+u6novwOrVADmr
         iKiQ==
X-Gm-Message-State: AOAM531XKt+ebMAGMBkwHM1iHrXi8CkyjbabyvXs4QoU8Rzc0pKmE7c5
        G4ma7JOxdsNA07EEFLpv144=
X-Google-Smtp-Source: ABdhPJzv1jmYfISttH52Qv7X3ML12jiaN/y3FPvYZps3l/Q0JJ9ycbQ/3m35eYW3aCrzEXDwhiCBYw==
X-Received: by 2002:a37:4796:: with SMTP id u144mr656941qka.235.1606335573858;
        Wed, 25 Nov 2020 12:19:33 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id w54sm446145qtb.0.2020.11.25.12.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:19:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 15:19:10 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        dm-devel@redhat.com, Richard Weinberger <richard@nod.at>,
        Jan Kara <jack@suse.com>, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 23/45] block: remove i_bdev
Message-ID: <X768PnFhrPtJk4U5@mtj.duckdns.org>
References: <20201124132751.3747337-1-hch@lst.de>
 <20201124132751.3747337-24-hch@lst.de>
 <X71g4Tm+3RiRg4Gf@mtj.duckdns.org>
 <20201125162926.GA1024@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125162926.GA1024@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Nov 25, 2020 at 05:29:26PM +0100, Christoph Hellwig wrote:
> > I was wondering whether losing the stale bdev flushing in bd_acquire() would
> > cause user-visible behavior changes but can't see how it would given that
> > userland has no way of holding onto a specific instance of block inode.
> > Maybe it's something worth mentioning in the commit message?
> 
> With stale bdev flushing do you mean the call to bd_forget if
> i_bdev exists but is unhashed?  It doesn't actually flush anything but

Yeah.

> just detaches the old bdev from the inode so that the new one can be
> attached.  That problem goes away by definition if we don't attach
> the bdev to the inode.

Yeah, I think so. Was just wondering whether the problem actually goes away.

Thanks.

-- 
tejun
