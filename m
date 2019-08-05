Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9515781738
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 12:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfHEKim (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 06:38:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40858 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfHEKim (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 06:38:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id r1so83839953wrl.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 03:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=nhcF4njZsguYPpGmNsYlX9l9INuM7smE0cJnjujhiVA=;
        b=lodqxxBAjM3+C4v1mG9kHvBt+4rObZj/P4IJe/X3pqCdD5t8lYY87yTX2ecGySvw3k
         Y2/Z475i4/uUX3csOghk24j0v4LmMq/SSFhPBVxnz8XehU6Sc3z5XB5k29BnNtGbars4
         QfrjZ3nXW3MrVZeOwx+oa13b99qlDCWFuG6kucDx9/bOtWXIVvW+Y8Zg8+mF/ijG0NwP
         QqVUxhv40aks4O6YcZjrVHmtjPdR3bpTVRnVsI4+R0o2BeX0oGvSa6c+6FBtybdV0Zyj
         GlsbxZPGTBGCjH7fPnv3fgYg4qmDPdgrcEYDNnl8z3AoJD3V6ncTMn1qyNxp9MbkW2Dp
         j9gQ==
X-Gm-Message-State: APjAAAWUitXeL8kzQ9CJn/HcuO30OfpiUOx3CfebGcoVGBTGi5XPjpY6
        6B6uvHo5f9YPbEI17LocOZpqew==
X-Google-Smtp-Source: APXvYqxnEIZ1vShqa8+K4LqEeKVgpDypeX98+GrcQMz1yUeybxTg/8GQX2KFj3X58jPFHojp/SaS/Q==
X-Received: by 2002:a5d:540e:: with SMTP id g14mr5027782wrv.346.1565001520116;
        Mon, 05 Aug 2019 03:38:40 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id m7sm70580746wrx.65.2019.08.05.03.38.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 03:38:39 -0700 (PDT)
Date:   Mon, 5 Aug 2019 12:38:37 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <20190805103835.mcketlhcxyrtko5c@pegasus.maiolino.io>
Mail-Followup-To: "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
References: <20190731141245.7230-1-cmaiolino@redhat.com>
 <20190731141245.7230-9-cmaiolino@redhat.com>
 <20190731232254.GW1561054@magnolia>
 <20190802134816.usmauocewduggrjt@pegasus.maiolino.io>
 <20190802152902.GI7138@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802152902.GI7138@magnolia>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > 
> > > Why doesn't this function just call fiemap_fill_kernel_extent to fill
> > > out the onstack @extent structure?  We've now implemented "fill out out
> > > a struct fiemap_extent" twice.
> > 
> > fiemap_fill_{user, kernel}_extent() have different purposes, and the big
> > difference is one handles a userspace pointer memory and the other don't. IIRC
> > the original proposal was some sort of sharing a single function, but then
> > Christoph suggested a new design, using different functions as callbacks.
> 
> It's harder for me to tell when I don't have a branch containing the
> final product to look at,

Good, I though I was the only one having issues with it :)

You can see the work here:

https://github.com/cmaiolino/linux/commits/FIEMAP_V5

^ This already includes changes addressing your concerns as we discussed int
this thread btw.

> but I'd have thought that _fill_kernel fills
> out an in-kernel fiemap extent; and then _fill_user would declare one on
> the stack, call _fill_kernel to set the fields, and then copy_to_user?

None of those functions will declare a fiemap_extent, the fiemap extent will be
declared before (in ioctl_fiemap() or bmap_fiemap()) calling either function and
then passed to the proper callback via fieinfo.fi_cb_data. This will be a user
or a kernel memory address, and the callbacks will handle the memory accordingly.

Cheers

-- 
Carlos
