Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC170E949
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 00:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238596AbjEWWxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 18:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjEWWx3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 18:53:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E9FE5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 15:53:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae4baa77b2so1742715ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 15:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1684882407; x=1687474407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D4PhmKVouafwl2lkI37bc+Y4HJ74bZ8XIgMqc4mDI8U=;
        b=ydqarSiJJg8/qlfiybY04O3RO4ik8W1MGJy8LAFW2WWKhnJjVg/kliO9Csr6ezjTxQ
         CCr+qRpaopVTGsAn0f3l5dbMCo+p2W+aPNeaBhEtfP5bJ9Mjgnc5fTAqVn4RIB2q1YN9
         T4tabZcuFaOoU/7IsAEwcXQPtLoiHvECcuXyTIfNzB2W2sq5mFSLbAYLnz/KQMv1ljoG
         wZuSL7Bbl0DjHi49APaxTV/JWMjZM3CCRFDqQhqEu4zJlEZBtHCtHARwqCzUqKDFWYgN
         xW1Z5cvUGTnV+ZYWY/MRBI4erUVV8hNCo5i56rdI6V8+qX0d2IZFSvvBWq9u+nWEMdhO
         Wyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684882407; x=1687474407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4PhmKVouafwl2lkI37bc+Y4HJ74bZ8XIgMqc4mDI8U=;
        b=N2SaSmjlnzh5n04EOd533scbBRRoV8jwqc4mWAKSAOkQLZIs1+k3zWHZ5FXkOSWLVo
         olG3GY5jcGZyF+ezcccf64I0J/CKkANQZ8pIHOcwowG0+ZbDP4Ex/Zl5k2XFbYSKVKU+
         PCBJGO2DwF5NwdFnLKHQyqgYMknejtUnsy378rIURQ3lDQ1w8mOUepyZsEKDm8i7eAi1
         R9b4AP94gOuvAGJxgaE/O5rc1YwZzWL24etNM3+2cFhjXM5Mf04YdsyppvGKQ5poGM7X
         S8VZWwQckP0WfcXUYXf54cmVOMNrxpiYI8d/c7ApfdZ/YKOFaUQwZJCVbVFIxklPXcdP
         cBSQ==
X-Gm-Message-State: AC+VfDwNA/xLqIYqpFLXxQNw70nCcuTm9hpSw/b+MqDJVWbRMcJCyTxW
        RUaCS+KNmqqUuklk8u8T5oTtnA==
X-Google-Smtp-Source: ACHHUZ4rf3ZnipqrpeU5LtwMsMVWiU9amtx3ykAwdeSvQFidX6a1jAjFyPwJGzq92rRNbryEDFU+Kg==
X-Received: by 2002:a17:902:d50e:b0:1ae:6720:8e01 with SMTP id b14-20020a170902d50e00b001ae67208e01mr17699251plg.20.1684882407345;
        Tue, 23 May 2023 15:53:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b001a682a195basm7284710plg.28.2023.05.23.15.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 15:53:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q1asc-0036XB-37;
        Wed, 24 May 2023 08:53:22 +1000
Date:   Wed, 24 May 2023 08:53:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: (subset) [PATCH 20/32] vfs: factor out inode hash head
 calculation
Message-ID: <ZG1D4gvpkFjZVMcL@dread.disaster.area>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-21-kent.overstreet@linux.dev>
 <20230523-plakat-kleeblatt-007077ebabb6@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523-plakat-kleeblatt-007077ebabb6@brauner>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 11:27:06AM +0200, Christian Brauner wrote:
> On Tue, 09 May 2023 12:56:45 -0400, Kent Overstreet wrote:
> > In preparation for changing the inode hash table implementation.
> >
> >
> 
> This is interesting completely independent of bcachefs so we should give
> it some testing.
> 
> ---
> 
> Applied to the vfs.unstable.inode-hash branch of the vfs/vfs.git tree.
> Patches in the vfs.unstable.inode-hash branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.unstable.inode-hash
> 
> [20/32] vfs: factor out inode hash head calculation
>         https://git.kernel.org/vfs/vfs/c/b54a4516146d

Hi Christian - I suspect you should pull the latest version of these
patches from:

git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs.git vfs-scale

The commit messages are more recent and complete, and I've been
testing the branch in all my test kernels since 6.4-rc1 without
issues.

There's also the dlist-lock stuff for avoiding s_inode_list_lock
contention in that branch. Once the global hash lock is removed,
the s_inode_list_lock is the only global lock in the inode
instantiation and reclaim paths. It nests inside the hash locks, so
all the contention is currently taken on the hash locks - remove the
global hash locks and we just contend on the next global cache
line and the workload doesn't go any faster.

i.e. to see the full benefit of the inode hash lock contention
reduction, we also need the sb->s_inode_list_lock contention to be
fixed....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
