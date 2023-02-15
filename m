Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7786975A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Feb 2023 06:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBOE77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 23:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjBOE75 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 23:59:57 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59459311C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 20:59:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id fu4-20020a17090ad18400b002341fadc370so956333pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Feb 2023 20:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CaZgKqOUe0VVRH5ftQYEOTV1BVr4Wv8d3kXjdyKziRI=;
        b=rketxIr4gImJPorL4R5BRrbp+c0WJjOM6XhLDCzwXdV6Fj1IT4O0ZK8DFJCWACBnVd
         nQqxyMQoCbntnZoJztkq64u0znEbhYif7EjCaLuLvgcYkX3wlJnfr7QPAdnCDBpAsnK2
         k3NzSt9lKQC4InHgH1A7iKw/ayUkNVETC+TSIQ23+DvbBC0iCSuWLgyv5+Ju45HThA1t
         FyXFYz8rHviPYEGVGqvBo3x2vs7XvZ5irj2NGf8AeEK31To10XgAbZaWPY+h8D5LhBq/
         PjPpSBH8/eI5TO767b2bsmgSXYnTPhm5RHRDbBI8xY9wZHIFyHtYwGc3lkltkMvP3WcT
         It6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CaZgKqOUe0VVRH5ftQYEOTV1BVr4Wv8d3kXjdyKziRI=;
        b=FNYzBti5Ldlis2WJeZ1d0+2h1X4EmyJwUpV8JfMUKZNO8ii60LFwK+moLG1KziM5zr
         sEiKz6UJDuey8IgUwOzmCMSht+2kkNjqRZ/k66SW7mWDq3EiUO5xytyMNgjSiCKnIJDM
         II8YZnKZ5J27fAet857ttXqnUnerj/n2ranVSg0umVT6kMcTDdbEzXUYaMlQL+opJRmp
         WSXtU15k7wpkbAcRxvr/b0DtIDQykS2110ZAOSacp4RL1x2L8A23/IlBuzH30X6Ze6od
         I8VynBuxLC4thSncZeRLwp76TOHwBgS+ulGeDf8c6FIpxyfd/qSHnmJuUI+Ei+/R+4Dx
         5GLA==
X-Gm-Message-State: AO0yUKXKdZKWFrEEgOWUWqBn5Zy4OG036khI1ZgwBtsthOlGqRRjEhJN
        tx1rDALH/8j3c5UyPqj86bON1g==
X-Google-Smtp-Source: AK7set+JG/B78Wq9ZBXSoUQJVRPwNoUSoonIc9EyVLGDRxv5C5xNQ3cyJaZxI/N31YGytS8k0cKOHQ==
X-Received: by 2002:a17:903:2344:b0:19a:586c:2b81 with SMTP id c4-20020a170903234400b0019a586c2b81mr1271624plh.40.1676437195868;
        Tue, 14 Feb 2023 20:59:55 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id jm15-20020a17090304cf00b001994a0f3380sm11035857plb.265.2023.02.14.20.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 20:59:55 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pS9tY-00FTp0-LH; Wed, 15 Feb 2023 15:59:52 +1100
Date:   Wed, 15 Feb 2023 15:59:52 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 4/5] block: Add support for bouncing pinned pages
Message-ID: <20230215045952.GF2825702@dread.disaster.area>
References: <20230209121046.25360-1-jack@suse.cz>
 <20230209123206.3548-4-jack@suse.cz>
 <Y+oKAB/epmJNyDbQ@infradead.org>
 <20230214135604.s5bygnthq7an5eoo@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214135604.s5bygnthq7an5eoo@quack3>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 14, 2023 at 02:56:04PM +0100, Jan Kara wrote:
> On Mon 13-02-23 01:59:28, Christoph Hellwig wrote:
> > Eww.  The block bounc code really needs to go away, so a new user
> > makes me very unhappy.
> > 
> > But independent of that I don't think this is enough anyway.  Just
> > copying the data out into a new page in the block layer doesn't solve
> > the problem that this page needs to be tracked as dirtied for fs
> > accounting.  e.g. every time we write this copy it needs space allocated
> > for COW file systems.
> 
> Right, I forgot about this in my RFC. My original plan was to not clear the
> dirty bit in clear_page_dirty_for_io() even for WB_SYNC_ALL writeback when
> we do writeback the page and perhaps indicate this in the return value of
> clear_page_dirty_for_io() so that the COW filesystem can keep tracking this
> page as dirty.

I don't think this works, especially if the COW mechanism relies on
delayed allocation to prevent ENOSPC during writeback. That is, we
need a write() or page fault (to run ->page_mkwrite()) after every
call to folio_clear_dirty_for_io() in the writeback path to ensure
that new space is reserved for the allocation that will occur
during a future writeback of that page.

Hence we can't just leave the page dirty on COW filesystems - it has
to go through a clean state so that the clean->dirty event can be
gated on gaining the space reservation that allows it to be written
back again.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
