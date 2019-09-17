Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831A7B4CEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2019 13:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfIQLbO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Sep 2019 07:31:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45388 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfIQLbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Sep 2019 07:31:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id 4so1847233pgm.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2019 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=haHTGffRW5vANHA+WJrpU6ZKkWIFsJTyKM4HQ48Fqjw=;
        b=PDWr0cB7F7xLSAU12jIL5a86NRbxRJxAmhopvAfaaybXfe7oaJkct5DXzdg1AiQpOI
         fHfpc6PK5Fw2/YAndeXRsbP5t66Ip2pWV6tnCcI0amJRBKmLdTYqOUyLYw0mcFV2A883
         zIqpOFWf9yek6jEOCb0EU/B2oVLLnFVUV60OjAie7OFYqKz2PZHS/oXXYAxSxSKpReCI
         5dnC8h/cu9wLrTJaSapbYy5KwCsHZBJuiliu8yTkjZCnW7ipuiTEQXJM7wzKpspYXEc6
         IrsTuhg1nB0zwQ1Px1p+RCsK9RWPv181MvYf/c1BNUyVAEN5cplWQdOF2IDRmZMgHL1u
         Cwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=haHTGffRW5vANHA+WJrpU6ZKkWIFsJTyKM4HQ48Fqjw=;
        b=KMM17ZGLJJDEqqYn9JFrsw7y7M6PY5ULQzUxItdBo4Kxy0k6zhnnvxkU0/l4VTBN48
         5aOlB5px3BYV1tbAWYMvEjBn8s7rTAKlVoCL42o+pAAdtWgSIKtZezrg6TNSf5uru+sS
         ZaSqKd1xyFi/B0r1MBOWuDunnmolEzQT/SsV6NFmZ/YSJpabaCpv760P+Pk/R33v2ccZ
         5AVkhEEae4JJGNYns7/7JpKfoFmicii03udcGS4pGHVHfNZr3mS3+NxXrZnQovd34ReW
         9kLwgjSuSV3HJQKsWS+lrXy75dVZm4tyqis+bPFCOXBJnvzT4QyzzWWzb6WrUhNGHHmf
         J1Sg==
X-Gm-Message-State: APjAAAV00/uLgaOX8ExsyBoDaQbR2xWND5vGglKE1eVz9XZ2rO2h072s
        iNI1cz9gzTN/4eBHC4EA7cTj
X-Google-Smtp-Source: APXvYqzOsnXyMzVzJPL/ZiEDQGH3p2QIv1+lzH89Vs5iszm0w2T1uEdH1we+JzsYoSrLGpLjy5rLEA==
X-Received: by 2002:a17:90a:37d1:: with SMTP id v75mr4472866pjb.33.1568719868394;
        Tue, 17 Sep 2019 04:31:08 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id d20sm4411809pfq.88.2019.09.17.04.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 04:31:07 -0700 (PDT)
Date:   Tue, 17 Sep 2019 21:31:01 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190917113101.GA17286@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916121248.GD4005@infradead.org>
 <20190916223741.GA5936@bobrowski>
 <20190917090613.GC29487@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917090613.GC29487@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 17, 2019 at 02:06:13AM -0700, Christoph Hellwig wrote:
> On Tue, Sep 17, 2019 at 08:37:41AM +1000, Matthew Bobrowski wrote:
> > > Independent of the error return issue you probably want to split
> > > modifying ext4_write_checks into a separate preparation patch.
> > 
> > Providing that there's no objections to introducing a possible performance
> > change with this separate preparation patch (overhead of calling
> > file_remove_privs/file_update_time twice), then I have no issues in doing so.
> 
> Well, we should avoid calling it twice.  But what caught my eye is that
> the buffered I/O path also called this function, so we are changing it as
> well here.  If that actually is safe (I didn't review these bits carefully
> and don't know ext4 that well) the overall refactoring of the write
> flow might belong into a separate prep patch (that is not relying
> on ->direct_IO, the checks changes, etc).

Yeah, I see what you're saying. From memory, in order to get this right, there
was a whole bunch of additional changes that needed to be done that would
effectively be removed in a subsequent patch. But, let me revisit this again
and see what I can do.

> > > > +	if (!inode_trylock(inode)) {
> > > > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > > > +			return -EAGAIN;
> > > > +		inode_lock(inode);
> > > > +	}
> > > > +
> > > > +	if (!ext4_dio_checks(inode)) {
> > > > +		inode_unlock(inode);
> > > > +		/*
> > > > +		 * Fallback to buffered IO if the operation on the
> > > > +		 * inode is not supported by direct IO.
> > > > +		 */
> > > > +		return ext4_buffered_write_iter(iocb, from);
> > > 
> > > I think you want to lift the locking into the caller of this function
> > > so that you don't have to unlock and relock for the buffered write
> > > fallback.
> > 
> > I don't exactly know what you really mean by "lift the locking into the caller
> > of this function". I'm interpreting that as moving the inode_unlock()
> > operation into ext4_buffered_write_iter(), but I can't see how that would be
> > any different from doing it directly here? Wouldn't this also run the risk of
> > the locks becoming unbalanced as we'd need to add checks around whether the
> > resource is being contended? Maybe I'm misunderstanding something here...
> 
> With that I mean to acquire the inode lock in ext4_file_write_iter
> instead of the low-level buffered I/O or direct I/O routines.

Oh, I didn't think of that! But yes, that would in fact be nice and I cannot
see why we shouldn't be doing that at this point. It also helps with reducing
all the code duplication going on in the low-level buffered, direct, dax I/O
routines.

--<M>--
