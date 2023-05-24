Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8EB70EF7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 09:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239940AbjEXHfK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 03:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239992AbjEXHfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 03:35:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBB291
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 00:35:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-25374c9be49so622287a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 00:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684913705; x=1687505705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O0M90dYEtoB+tX95FKz0Jj4hKmcCt+vtzXw6fRk3trk=;
        b=WCK/moH3TMm6NtivNgmKsUsBm8l+Kxtmp01ZtIL/pbTxvgi6Exn7jWFQY0TR+67vQ8
         HmK5bZ8rQmm9BdvoKo6XBR8Idrsnq4ykCG/sKaXvVjQVFiU2sxMBcxnhKMBX/lXCWbpd
         fHxz/1EubAeHIGNQrS9P28TswPGD3DvJdFIJd4ZmY/FSXiZX6vxV4uJjTt4c69lVfXCB
         fggs7ICMEOPjrWYK9R+N2gKGYMxx1CRHH89iIaSeq5M3L4eHnX0Xq2P8wBaT7MCyXxFK
         AFnP5HPLO0ad5B62yxOiTOkUPZsbUTLddDV8yIrsHn/syehTZ/vQ68X2T5iz+zvn8JjW
         7mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684913705; x=1687505705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0M90dYEtoB+tX95FKz0Jj4hKmcCt+vtzXw6fRk3trk=;
        b=FUBOo1KBxx8U48NDVkvdsfND22p751h0+YaASG5F8nkN4y8UGvQOgDSNww3UFZRZJP
         j2+fZoHq/oJ9SK61yAWbBbIq1AiKzNRwzI4S9yrXpOQdyJXCsP42qlFvk6h8wjD+5DW6
         8W9NypOpmKIG2DAItunK+yG9AHDteQ64OfEbOyUE2Z24jy3UjfuFBhwu186Wn8WJjkSK
         SQ76jTZQcG9ssxK/F1+yAghhp1SNEXBflaaVhxVpEiAuKGRyS6TLUMuVMmP5TCW54hdC
         mz5iFLfDwyXyeStGmTWZ2yJFghjowNyMQNFXF7NsMa3cmKrGGvFRPvowwIKvEaJA0ttA
         NSIw==
X-Gm-Message-State: AC+VfDxCi6axO21w8BrngF2FlFkGQ4HCkVCCfzjKuKsnjuuCC850mHGP
        v6Zzcl7+lAWYTT/TydjA3DvG2g==
X-Google-Smtp-Source: ACHHUZ6UeStupei4VgkExMH9NL+gLbB8bBfErJC2pwxidR1k45P0Di9t+zSp2el1Ydxxv+Ev+VA3Rw==
X-Received: by 2002:a17:902:e5c8:b0:1aa:e425:2527 with SMTP id u8-20020a170902e5c800b001aae4252527mr17443473plf.21.1684913705482;
        Wed, 24 May 2023 00:35:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001a505f04a06sm7976312plz.190.2023.05.24.00.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 00:35:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q1j1S-003FTy-2N;
        Wed, 24 May 2023 17:35:02 +1000
Date:   Wed, 24 May 2023 17:35:02 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 20/32] vfs: factor out inode hash head
 calculation
Message-ID: <ZG2+Jl8X1i5zGdMK@dread.disaster.area>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-21-kent.overstreet@linux.dev>
 <20230523-plakat-kleeblatt-007077ebabb6@brauner>
 <ZG1D4gvpkFjZVMcL@dread.disaster.area>
 <ZG2yM1vzHZkW0yIA@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZG2yM1vzHZkW0yIA@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 11:44:03PM -0700, Christoph Hellwig wrote:
> On Wed, May 24, 2023 at 08:53:22AM +1000, Dave Chinner wrote:
> > Hi Christian - I suspect you should pull the latest version of these
> > patches from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git vfs-scale
> > 
> > The commit messages are more recent and complete, and I've been
> > testing the branch in all my test kernels since 6.4-rc1 without
> > issues.
> 
> Can you please send the series to linux-fsdevel for review?

When it gets back to the top of my priority pile. Last time I sent
it there was zero interest in reviewing it from fs/vfs developers
but it attracted lots of obnoxious shouting from some RTPREEMPT
people about using bit locks. If there's interest in getting it
merged, then I can add it to my backlog of stuff to do...

As it is, I'm buried layers deep right now, so I really have no
bandwidth to deal with this in the foreseeable future. The code is
there, it works just fine, if you want to push it through the
process of getting it merged, you're more than welcome to do so.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
