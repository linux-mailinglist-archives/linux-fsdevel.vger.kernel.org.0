Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D8F7992C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 01:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345191AbjIHXWK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 19:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbjIHXWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 19:22:09 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CDA210B
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 16:22:01 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3ab3aa9ae33so1894194b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Sep 2023 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694215321; x=1694820121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=syNNnHGjFyimA65ZLjV7ktwTwR7ohH9BRu/o/01Ja9Y=;
        b=DmMmEBx90mfJhSzR8uCQm/3BpD+nG4sAdIytTa8WAca2wYcL8qD69njjQkGp17S1so
         Hf+cdTbMdlCr1WsKZhwDmy+aW1n/SDSzvI6CqXrFixqzmV8bL6odvgZX14cXFXi6S1YI
         cYpPjWUUDjblQcaXyfiSbffs6Z3Dx9yeXNB+Q+q4mrczemdfF6vVihYCLRTFKh66wRV5
         dmBHvhLOMyJQb8LdwQfviuMuVWX0ZJESFE2mdHdG/3GgN+D3XRORiRHZ+0dAySPT+WQ7
         Mh29q/BFRnLCV2ZoLYyE31PoAicbKagx0KOELPB8d8z3aVwpyKLHbHzGtx1+BfJRfPVm
         rqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694215321; x=1694820121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syNNnHGjFyimA65ZLjV7ktwTwR7ohH9BRu/o/01Ja9Y=;
        b=RpNpOi5zUeP/BrLGuBK65BgeRP2QwdMdbpev0k2aqEtOSnHC3UNYZwHXpDuyjZp+Kt
         RjaLreC6p6vqX9ZAwJOA87vV+xUg6bcllA3l5ylwD4WRz0PHtkyin+HZtVygw1WqKaIC
         ZD0ciWVxp7ccSgNtISfxbuGF6HOSsbKraRd2PdMG8J8RHomOsfTbtCWo3hkcO6TD0bjI
         kTDvR4meDXi+HArt5urOUgXWbjA4CeCwO82L/ZXuk8ZhKp2x+PENsl73ggUZcyOwszmS
         BI6dgp2Yd9brBwNI17LEey1V5oNBa4Owboau+mDY0MLZuww18OH4YTYDJfkq0OAK4i+J
         gJ/w==
X-Gm-Message-State: AOJu0Yz9FwnyKaHDjWnCkFWjVqlQXlaK13x0N7OZ1JU4BMbSNnlDiqSF
        dU1JoUPBPwZTnH3GxRAaREnPTCj82wHN1/88F20=
X-Google-Smtp-Source: AGHT+IFCknF6+J8C5jUO0k1Opi9mR8wmU3LkZT/E6IXbbbk19C4lK/P+s2l7FwwzqhQM+J8Zu3nbBg==
X-Received: by 2002:aca:2806:0:b0:3a7:a299:1201 with SMTP id 6-20020aca2806000000b003a7a2991201mr3804137oix.23.1694215320838;
        Fri, 08 Sep 2023 16:22:00 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id x20-20020a656ab4000000b00574164301d1sm1400452pgu.47.2023.09.08.16.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 16:22:00 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qeknV-00CfLL-2m;
        Sat, 09 Sep 2023 09:21:57 +1000
Date:   Sat, 9 Sep 2023 09:21:57 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPuslQOwcNmDHVo/@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <ZPrdgyy9gam+DdEr@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPrdgyy9gam+DdEr@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:38:27AM -0700, Christoph Hellwig wrote:
> On Thu, Sep 07, 2023 at 08:54:38AM +1000, Dave Chinner wrote:
> > There's a bigger policy question around that.
> > 
> > I think that if we are going to have filesystems be "community
> > maintained" because they have no explicit maintainer, we need some
> > kind of standard policy to be applied.
> > 
> > I'd argue that the filesystem needs, at minimum, a working mkfs and
> > fsck implementation, and that it is supported by fstests so anyone
> > changing core infrastructure can simply run fstests against the
> > filesystem to smoke test the infrastructure changes they are making.
> 
> Yes, that's what I tried to imply above.  We could relax fsck a bit
> (even if that is playing fast and lose), but without mkfs there is
> no way anyone can verify anything
> 
> > 
> > I'd suggest that syzbot coverage of such filesystems is not desired,
> > because nobody is going to be fixing problems related to on-disk
> > format verification. All we really care about is that a user can
> > read and write to the filesystem without trashing anything.
> 
> Agreed.
> 
> > I'd also suggest that we mark filesystem support state via fstype
> > flags rather than config options. That way we aren't reliant on
> > distros setting config options correctly to include/indicate the
> > state of the filesystem implementation. We could also use similar
> > flags for indicating deprecation and obsolete state (i.e. pending
> > removal) and have code in the high level mount path issue the
> > relevant warnings.
> 
> Agreed.
> 
> > This method of marking would also allow us to document and implement
> > a formal policy for removal of unmaintained and/or obsolete
> > filesystems without having to be dependent on distros juggling
> > config variables to allow users to continue using deprecated, broken
> > and/or obsolete filesystem implementations right up to the point
> > where they are removed from the kernel.
> 
> I'd love to get there, but that might be a harder sell.

Yet that is exactly what we need. We need a well defined life-cycle
policy for features like filesystems. Just as much as we need a
clear, well defined process for removing obsolete filesystems, we
need a well defined policy for merging new filesystems.

The lack of well defined policies leads to arguments, arbitary
roadblocks being dropped again and again in front of merges, and it
does not prevent things like "dumping" from occurring. i.e. the
filesystem is merged, and then the "maintainer" immediately goes
AWOL and this new filesystem becomes an instant burden on the rest
of the fs development community to the point where fs developers
already immediately disregard any issue on a kernel that has used
that filesystem.

Without defined policies and processes to avoid repeating the same
mistakes and arguments and disagreements over and over for each new
filesystem someone wants to merge or remove, we aren't going to pull
ourselves out of the hole we've dug. This isn't the wild west here;
this is a room full of professional engineers. Defining new
processes and policies to make things easier, take less resources,
cause less friction, make operations more efficient, etc is part of
what we are supposed to do. Not everything can be solved with code;
the lack of defined processes for making major changes is the
biggest single issue leading to the problems we have right now....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
