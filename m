Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62838DFA42
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfJVBt0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 21:49:26 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40425 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfJVBtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 21:49:25 -0400
Received: by mail-pg1-f196.google.com with SMTP id 15so3583592pgt.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2019 18:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cYd8ROhMNq1Yx+vOsBONaKOy7KeVJVgFB+LYLRUxDgE=;
        b=TFBptRq3ve/tPAMq3b0V8kT4Xd0iReoVP7HNznmMumSnWXMSWwlza3Uc6AyyQVElIx
         hKLIAKeVXZ7CYXilmRzi+njAv2oVri01gkVEniuAoyefK2hxnP2PDVLv3DCBqjSF8499
         U5AYYP7gRGFwu1rfFp4TcLNu6tSIcf99XvGLBg81/W8vU8XVWTGi+7L9Bz4EVPws2jPk
         mT7fzvaj5ZrX70loZoXKYAbH2sMI3xAM100X52Xm7Knfdy3gBImXszpF+VQi6tSqWzGx
         5ju+WnTH5bhnY2KHyAuyIi5wu8tCq0tzqjb1zcUpoBgMKMGVVAlcfYBfEXnVfUc+9pwE
         9cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cYd8ROhMNq1Yx+vOsBONaKOy7KeVJVgFB+LYLRUxDgE=;
        b=itl3a29HLy9eVKHNaCl183jwNH4btBgI+t44Yb10fln+OQT6BXLkOatmjAcXDhpWhN
         +SUF4/khgBOkvEKN9SXb8OeaJK7VyFPLMcepxj/9JdZWXOT+9VGMzZvF+rfMm8JUEVc3
         NcYr5/ut5e+vwHQT5yZbjp9dIublmrvhyGvhKbEutL+ioBlYU9zzV578UPbTEGbrtZMg
         djBFkSPWTEQGqmovWqEja0vLx+IR5vnhspP8/CfngdSHrThlFzhmSryshXGAvIo2/ECs
         aRxfHWFuLKa1xuQHC2PmjxsQhY8XkbxuReXFsJeAVLKhD0bH+klbUzzHJNtF5Ztqk7GS
         UQHw==
X-Gm-Message-State: APjAAAULRj2Hu8tl4xi/Vpvai3GieT2/wtmjnJEbk4sUAkzYkhHOQKnu
        ZMGooILOVlxxt/5gi40Vwn8mPHX26mH1
X-Google-Smtp-Source: APXvYqwoqsLbPzmAZETxvHQWf9PUCzQB2+x1jzr+FtzeR4gk+LtQk8N9Y3WH/CXf4ZS7F1MR0XnHRQ==
X-Received: by 2002:a63:c446:: with SMTP id m6mr976716pgg.136.1571708964617;
        Mon, 21 Oct 2019 18:49:24 -0700 (PDT)
Received: from athena.bobrowski.net (n1-41-199-60.bla2.nsw.optusnet.com.au. [1.41.199.60])
        by smtp.gmail.com with ESMTPSA id y144sm17865523pfb.188.2019.10.21.18.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 18:49:23 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:49:17 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 02/12] ext4: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <20191022014917.GB5092@athena.bobrowski.net>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <995387be9841bde2151c85880555c18bec68a641.1571647179.git.mbobrowski@mbobrowski.org>
 <20191021132818.GB25184@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021132818.GB25184@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 03:28:18PM +0200, Jan Kara wrote:
> On Mon 21-10-19 20:17:46, Matthew Bobrowski wrote:
> > This patch is effectively addressed what Dave Chinner had found and
> > fixed within this commit: 8a23414ee345. Justification for needing this
> > modification has been provided below:
> > 
> > When doing a direct IO that spans the current EOF, and there are
> > written blocks beyond EOF that extend beyond the current write, the
> > only metadata update that needs to be done is a file size extension.
> > 
> > However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
> > there is IO completion metadata updates required, and hence we may
> > fail to correctly sync file size extensions made in IO completion when
> > O_DSYNC writes are being used and the hardware supports FUA.
> > 
> > Hence when setting IOMAP_F_DIRTY, we need to also take into account
> > whether the iomap spans the current EOF. If it does, then we need to
> > mark it dirty so that IO completion will call generic_write_sync() to
> > flush the inode size update to stable storage correctly.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> Looks good to me. You could possibly also comment in the changelog that
> currently, this change doesn't have user visible impact for ext4 as none of
> current users of ext4_iomap_begin() that extend files depend of
> IOMAP_F_DIRTY.

Sure, I will add this.

> Also this patch would make slightly more sense to be before 1/12 so that
> you don't have there those two strange unused arguments. But these are just
> small nits.

You're right. I will rearrange it in v6 so that this patch comes
first.

> Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks Jan!

--<M>--
