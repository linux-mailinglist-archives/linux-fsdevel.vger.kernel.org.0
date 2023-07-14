Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BF1753C01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jul 2023 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235586AbjGNNrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jul 2023 09:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbjGNNrr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:47:47 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02723A8C
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 06:47:33 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c2cf29195f8so1866565276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Jul 2023 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689342453; x=1691934453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1nW0XcudUVC9Qhuuwb+nWUzcisedgXCvMeHhDG6QAY=;
        b=Ms7fC7hBI6+rEMXzh7BvL77d4/n5FgbrgK1KcJL0pjmQT5LkmfhRfjUquak1+R0f66
         f0+jacDIAlT3W6EUKiS6AvjJu1xlXFENfR+m+ECoRJjLaoyRwUdOczzWJXAptrStYP1Y
         D15Y7wxeEnxm3+IIgNY42IjhRfx1vBG59aWirrE/5Z4X4+ApYeM40rV1PuOBamgWXqYD
         R+h4Qw98gpzGupF07dwoNFMlC4r00rBxbVqSuNwsQ+seleMiWNjDq+Og7iuukoMcS0ri
         mUXh11t6PKi9psQ0UaI8IM/Iabgp96AWw5ipnr3ehSCfaf7suZBC9rZJbQPN9vZu0PmL
         rdpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342453; x=1691934453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1nW0XcudUVC9Qhuuwb+nWUzcisedgXCvMeHhDG6QAY=;
        b=b6n9plI5oXcUHJmG4YVHaJfJB7iaz6U4WAfDGanULxL5cIwyIovKoPw6MPB52jlA5z
         GJEypo/QmfgGDNkBEgToP0eputgdlEjfskvyrlPyOtTSqRaTFGenB4af2L1QPhPGoCGM
         yCZ6+y42fRoMAA5yDdsGyKYEAtkpMHtFrgq1NvKRE1b6/cv0qUaaFdHhK/G4fNboCzhs
         jDob3E5e4DCnwNCgf0eCFWDZhfF28Oh3G/5DLF24XvuwUZAbK4wl8sZ9CtKmGa1yONr9
         0bMLqpSAHX3US1S5gT+twB7YubxMexyFnDgWAtDSwApF1Z+cbSRLcBMz9hb5S99R+35N
         reBw==
X-Gm-Message-State: ABy/qLbRKrRRPNT4I3kgo8GuZ1V9Gl9d38SRmwwiS/dJHu4WtommmhN7
        ceiuf0buDeIgOIZ9+btHnqKWKw==
X-Google-Smtp-Source: APBJJlHzsnQ81dc3bDvHu55owqNNgE5WYZHH6jxwGV04wmzl/oLv3zJVgOa6yw3gE4ElvNnQGTvVWA==
X-Received: by 2002:a0d:cc0d:0:b0:57a:871e:f625 with SMTP id o13-20020a0dcc0d000000b0057a871ef625mr4214125ywd.52.1689342452291;
        Fri, 14 Jul 2023 06:47:32 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x6-20020a0dee06000000b0056dfbc37d9fsm2333536ywe.50.2023.07.14.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:47:31 -0700 (PDT)
Date:   Fri, 14 Jul 2023 09:47:30 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 16/23] btrfs: further simplify the compress or not logic
 in compress_file_range
Message-ID: <20230714134730.GC338010@perftesting>
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153144.22834-17-hch@lst.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:31:37PM +0200, Christoph Hellwig wrote:
> Currently the logic whether to compress or not in compress_file_range is
> a bit convoluted because it tries to share code for creating inline
> extents for the compressible [1] path and the bail to uncompressed path.
> 
> But the latter isn't needed at all, because cow_file_range as called by
> submit_uncompressed_range will already create inline extents as needed,
> so there is no need to have special handling for it if we can live with
> the fact that it will be called a bit later in the ->ordered_func of the
> workqueue instead of right now.
> 
> [1] there is undocumented logic that creates an uncompressed inline
> extent outside of the shall not compress logic if total_in is too small.
> This logic isn't explained in comments or any commit log I could find,
> so I've preserved it.  Documentation explaining it would be appreciated
> if anyone understands this code.
> 

Looks like it's just a optimization, no reason to allocate a whole async extent
if we can just inline a page and be done.  It's not necessarily required, but
could use a comment.  Thanks,

Josef
