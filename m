Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BB564BDF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 21:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237294AbiLMUdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 15:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbiLMUdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:33:25 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1B5F85
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 12:33:24 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c7so3002491pfc.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 12:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dEs/S8NWma6i4dvM1f0FXpEgwRLdheeJBWEYU/PAoQo=;
        b=Xhg5H+2sRfETY8uUlA6HFgMZzFxmCoCBW66RzuUkXNxyEEg+kONpmPc+sfafkfCf7q
         YGjh52nXEKjJnOBn0C4IMZiUG0tfcgtWVZ7pOZPsxepTHFBC0Gv68F/yC2m87mqOK4UZ
         35hf5BzQFKOklM+FDUW20UcUSbAvMXXNID+LsERnwdUhzPJHEaP8Eu3BY+r8GqFGp0Wx
         yGI2xAPBondMFMUfkHnGbnC+sMceQUrMcEIrAY+X+lQ07fioZKLLCWESVzrDRaIUOR+n
         8TlrSCLaIXV0jGJvJIKsfI71E9zbEAkdkNRxqRB52XWcAaufqcWaLaYDGmtsvrrBqX4U
         jS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEs/S8NWma6i4dvM1f0FXpEgwRLdheeJBWEYU/PAoQo=;
        b=XjfAWiIFd4ee/WU5X7Cz+CA2Bzrwj2pskoZAI58dQiuFwGls58Eq69SCeRFAvtmWfa
         o61cUSZabBiyyEWnlIu1q6GH7xi3W35crRbpwrvp53V10A9pRYXj0RHGU6JB/ZxxVsdF
         dWlUvtBJD/t6Z65jvtXePLcmP7LoEHX8J9GiENyGhs1g0ilRB5n5H0YAnaCDHZsXZxpQ
         Z3B0IP4dnlNlB6VSPgl21zGGuAbeegfnW0ZiuZ+aTS5lgOMAwJbtO/4cop57P9GOW8TH
         ohhCstSgBLQk/RQ7z6JFmq3dEJVHq+ab05iIVFiV7y/klPli/RV7fQ3NKP9LT1KvIM+2
         pyaQ==
X-Gm-Message-State: ANoB5pl7VVFP754CUAKjHB9gfQT5B2Vf88aSt9QCzG2nKS9P6ABw7xcO
        H2Qcqia83STaDTHu76ffmQAmFg==
X-Google-Smtp-Source: AA0mqf5vXVx6ItO8e8H7K12Ed2M1OnULY+vHyqbvlkeCVJsNoq8FX/fPjHID+KqJfQM3OMGV1xXeoA==
X-Received: by 2002:a62:cd0c:0:b0:577:2a9:96ef with SMTP id o12-20020a62cd0c000000b0057702a996efmr24006776pfg.28.1670963603802;
        Tue, 13 Dec 2022 12:33:23 -0800 (PST)
Received: from dread.disaster.area (pa49-181-138-158.pa.nsw.optusnet.com.au. [49.181.138.158])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79590000000b0056bb36c047asm8078167pfj.105.2022.12.13.12.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 12:33:23 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1p5Bxn-00852T-Jk; Wed, 14 Dec 2022 07:33:19 +1100
Date:   Wed, 14 Dec 2022 07:33:19 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] xfs: add fs-verity support
Message-ID: <20221213203319.GV3600936@dread.disaster.area>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-11-aalbersh@redhat.com>
 <Y5jNvXbW1cXGRPk2@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jNvXbW1cXGRPk2@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:08:45AM -0800, Eric Biggers wrote:
> On Tue, Dec 13, 2022 at 06:29:34PM +0100, Andrey Albershteyn wrote:
> > 
> > Also add check that block size == PAGE_SIZE as fs-verity doesn't
> > support different sizes yet.
> 
> That's coming with
> https://lore.kernel.org/linux-fsdevel/20221028224539.171818-1-ebiggers@kernel.org/T/#u,
> which I'll be resending soon and I hope to apply for 6.3.
> Review and testing of that patchset, along with its associated xfstests update
> (https://lore.kernel.org/fstests/20221211070704.341481-1-ebiggers@kernel.org/T/#u),
> would be greatly appreciated.
> 
> Note, as proposed there will still be a limit of:
> 
> 	merkle_tree_block_size <= fs_block_size <= page_size

> Hopefully you don't need fs_block_size > page_size or

Yes, we will.

This back on my radar now that folios have settled down. It's
pretty trivial for XFS to do because we already support metadata
block sizes > filesystem block size. Here is an old prototype:

https://lore.kernel.org/linux-xfs/20181107063127.3902-1-david@fromorbit.com/

> merkle_tree_block_size > fs_block_size?

That's also a desirable addition.

XFS is using xattrs to hold merkle tree blocks so the merkle tree
storage is are already independent of the filesystem block size and
page cache limitations. Being able to using 64kB merkle tree blocks
would be really handy for reducing the search depth and overall IO
footprint of really large files.

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
