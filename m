Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C15B9B4E69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 14:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfIQMtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 08:49:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38663 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfIQMtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:49:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so2116837pfe.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ivL+7BxcvNPtsk87vtiqzEY0l9qsqqcgA3nEl+3vuKc=;
        b=MLg7c27exZe1UjrUa6DYN1rLT97yfjGvUXfO7L+VKEKh+DxvKdk2FI1gPYWVY5Z5gq
         uQwrHq1jvjcMi/mdR5+TTkx0LjrVSFQJFfhRDjCDCaYq7pg/7GIhYnQBRpOs+tsW5JCe
         YWDIBkI7sk//I4vfAaPRYQUyJQ8prpfqhTz9d1DgAex4Pc+2gJku+NeLp8OoCOAcTna6
         3uA+jyMuvxrlA2gi+vLYEupDPT3wfZD2bJ9xP8Q0W2oj2f2uMDP8xqxijguaOfe9GoGD
         epusYE4BT2/BO+nzpJLnMfOp/4aHHwYJfnvyadp0LFzQAxTffqkA6kx7J7X441TlZC/9
         w7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ivL+7BxcvNPtsk87vtiqzEY0l9qsqqcgA3nEl+3vuKc=;
        b=qY641gm/ABipv+8oa4fyHUnehJxHct02sFeNsgI7mgN9/SXDkL2A9p5Aai3HY2JCOV
         Oj+HOL7NkYUiIvsTHbApugB2chlH/iv6PkKQaxQqibPrlXty4Ue5T+xpW7Hu3Rj40IxR
         XaJe8LXtGX7NpOlDXPpVVmeq9cueaicabvm+d2E4Q4Dsh9JEMdxC9eVP/yNaha9q3kko
         VXIR5rHR59F8gOs/Q7jOAzPKBWStz+ZGwyXLhQf3+/RELZqGAS3FCwsHEq7HAXuEdFop
         IhyGjcc9HAjKjeDEAY7h2KQ1dm6Xbprl6cJ9f5L/DJg7GRMm8oZRCX5cOeC0di6YFNsF
         LcTg==
X-Gm-Message-State: APjAAAWa1PAg3zOx3LA9Jd7arakixkBh9vROFf1+WdvypqHZKPchA5kS
        q/0itNvsXyEqYRnWNDV4DvUJ
X-Google-Smtp-Source: APXvYqxWo7NntCCLvNAO1Yv9/nxQJN1IjFhK6qfvfttgzSoQEuPawMMLzQGuquVSUSrQBVryhtdkdQ==
X-Received: by 2002:a62:8c97:: with SMTP id m145mr3881290pfd.241.1568724545799;
        Tue, 17 Sep 2019 05:49:05 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id s1sm7905549pjs.31.2019.09.17.05.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:49:05 -0700 (PDT)
Date:   Tue, 17 Sep 2019 22:48:59 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v3 4/6] ext4: reorder map.m_flags checks in
 ext4_iomap_begin()
Message-ID: <20190917124859.GC17286@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <8aa099e66ece73578f32cbbc411b6f3e52d53e52.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916120533.GB4005@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916120533.GB4005@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 16, 2019 at 05:05:33AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 12, 2019 at 09:04:30PM +1000, Matthew Bobrowski wrote:
> > @@ -3581,10 +3581,21 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >  		iomap->type = delalloc ? IOMAP_DELALLOC : IOMAP_HOLE;
> >  		iomap->addr = IOMAP_NULL_ADDR;
> >  	} else {
> > -		if (map.m_flags & EXT4_MAP_MAPPED) {
> > -			iomap->type = IOMAP_MAPPED;
> > -		} else if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> > +		/*
> > +		 * Flags passed to ext4_map_blocks() for direct IO
> > +		 * writes can result in m_flags having both
> > +		 * EXT4_MAP_MAPPED and EXT4_MAP_UNWRITTEN bits set. In
> > +		 * order for allocated unwritten extents to be
> > +		 * converted to written extents in the end_io handler
> > +		 * correctly, we need to ensure that the iomap->type
> > +		 * is also set appropriately in that case. Thus, we
> > +		 * need to check whether EXT4_MAP_UNWRITTEN is set
> > +		 * first.
> > +		 */
> > +		if (map.m_flags & EXT4_MAP_UNWRITTEN) {
> >  			iomap->type = IOMAP_UNWRITTEN;
> > +		} else if (map.m_flags & EXT4_MAP_MAPPED) {
> > +			iomap->type = IOMAP_MAPPED;
> 
> I think much of this would benefit a lot from just being split up.
> I hacked up a patch last week that split the ext4 direct I/O code
> a bit, but this is completely untested and needs further splitup,
> but maybe you can take it as an inspiration for your series?

Nice, I really like this! :-)

The ext4_iomap_begin() callback is kind of already getting larger than it
should have to be and I can only see it growing moving forward, so why not
split it up now.

> E.g. at least one helper for filling out the iomap from the ext4
> map data, and one for the seek unwritten extent reporting.  The
> split of the overall iomap ops seemed useful to me, but might not
> be as important with the other cleanups:

Yeah, I think I'll leave the iomap operations as they are for now. Something
to definitely consider at a later point though.

--<M>--
