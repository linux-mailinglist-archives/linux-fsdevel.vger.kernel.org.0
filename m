Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51247312BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 10:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245018AbjFOIwc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 04:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbjFOIwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:52:05 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F530DC
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 01:51:39 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-3f9b7345fb1so27462301cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686819099; x=1689411099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCtd60h4V4EHRJD4vwp1PDGCA8q+mlzKDRGda/PgiKA=;
        b=Jnq28tmV7ZVC/X1/2KIo5xXOOzRtZDU/hLkuKIMu/YCfNX8Y3MwN3C4vhs+Pth9kGI
         0JA0zrCLE54cTTOa338uRIQVPJWdSihi0AMTnWuwNQULa0LZ3lH8gFVSh6QQSgqDHku3
         DjM8lPkW83/rY3onhCLt6et2m2QA0iyWi9XBK0+1Vgwb2zmA7r7SAupdZoPDaYwgcBgE
         2adMK5KVqBFTYXTfw8yNl3T8lLI1++16gSfPAcGLZYfkJTDDPUW9JzUYpJbbGYkMDzZ8
         kXxB66693jNdirT/m4XEWUXIsocinenCeMtoko5z/ffPYblXOTSqQrKjjN4JBPSel+vQ
         P81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686819099; x=1689411099;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCtd60h4V4EHRJD4vwp1PDGCA8q+mlzKDRGda/PgiKA=;
        b=X9ciwUiiIYJNK22h/NSp1CoMQOUxf2KbwPksfbHUdk0+8s9wYEMglfNkkSREyifxO7
         kx30SzMfZ0dZaux9uyKL1IYBIhDv/mKOOsGCwkI9m8a5OrncLrPY9yKTrb+8qdgKtoSA
         eDnULanj4CeieAuV6zTFyH6UHq+rgl8vAHxZhSmRKs3HJDJcMEGYseKe2kVe1SMZFxWS
         YQmFcQBAL40U0LV9YfrJX6aIVg7aZWStGN2+pmZDfedOHqHNwbDgSH5SWVxkCdbKntPM
         AGmjbRHVXffXSswQLtqoP9+hH9DR2cCq6SHrIuA+rIV8HxqvkjT4PA95gPSnWoPY58zT
         wFrQ==
X-Gm-Message-State: AC+VfDw94WqXqPlJwC9b0qBu1uzt70NDOkRjKWuF6HbPYpDz0EADJQ+h
        MNLruT8XseQ58j53EmVl0EaNWg==
X-Google-Smtp-Source: ACHHUZ68AxrCw755I87FG0yFiJfDul/thfltQS6QfCx5gguIzNFJw+y3jyTV9mqBehUOrCi0EVKjxg==
X-Received: by 2002:ac8:57ce:0:b0:3f6:c0f7:a5c3 with SMTP id w14-20020ac857ce000000b003f6c0f7a5c3mr5976494qta.32.1686819098779;
        Thu, 15 Jun 2023 01:51:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id p3-20020a62ab03000000b00646e7d2b5a7sm934369pff.112.2023.06.15.01.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 01:51:38 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9ihb-00C0hg-0F;
        Thu, 15 Jun 2023 18:51:35 +1000
Date:   Thu, 15 Jun 2023 18:51:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Message-ID: <ZIrRFwElpZsAnl4Q@dread.disaster.area>
References: <20230614114637.89759-1-hare@suse.de>
 <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
 <ZInGbz6X/ZQAwdRx@casper.infradead.org>
 <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
 <ZIpS9u4P43PgJwuj@dread.disaster.area>
 <df8e7a88-f540-af93-77dc-164262a5a3d0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df8e7a88-f540-af93-77dc-164262a5a3d0@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 08:21:10AM +0200, Hannes Reinecke wrote:
> On 6/15/23 01:53, Dave Chinner wrote:
> > On Wed, Jun 14, 2023 at 05:06:14PM +0200, Hannes Reinecke wrote:
> > All you need to do now is run the BS > PS filesytems through a full
> > fstests pass (reflink + rmap enabled, auto group), and then we can
> > start on the real data integrity validation work. It'll need tens of
> > billions of fsx ops run on it, days of recoveryloop testing, days of
> > fstress based exercise, etc before we can actually enable it in
> > XFS....
> > 
> Hey, c'mon. I do know _that_. All I'm saying is that now we can _start_
> running tests and figure out corner cases (like NFS crashing on me :-).
> With this patchset we now have some infrastructure in place making it
> even _possible_ to run those tests.

I got to this same point several years ago. You know, that patchset
that Luis went back to when he brought up this whole topic again?
That's right when I started running fsx, and I realised it
didn't cover FICLONERANGE, FIDEDUPERANGE and copy_file_range().

Yep, that's when we first realised we had -zero- test coverage of
those operations. Darrick and I spent the next *3 months* pretty
much rewriting the VFS level of those operations and fixing all the
other bugs in the implementations, just so we could validate they
worked correct on BS <= PS.

But by then Willy had started working over iomap and filemap for
folios, and the bs > PS patches were completely bitrotted and needed
rewriting from scratch. Which I now didn't have time to do....

So today is deja vu all over again: the first time I run fsx on
a new 64kB BS on 4KB PS implementation it hangs doing something
-really weird- and unexpected in copy_file_range(). It shouldn't
even be in the splice code doing a physical data copy.  So something
went wrong in ->remap_file_range(), or maybe in the truncate before
it, before it bugged out over out of range readahead in the page
cache...

I got only 3 fsx ops in today, and at least three bugs have already
manifest themselves....

> Don't be so pessimistic ...

I'm not pessimistic. I'm being realistic. I'm speaking from
experience. Not just as a Linux filesystem engineer who has had to
run this fsx-based data integrity validation process from the ground
up multiple times in the past decade, but also as an Irix OS
engineer that spent many, many hours digging out nasty, subtle bs > ps
data corruption bugs of the Irix buffer/page cache.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
