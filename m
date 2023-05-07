Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438EE6F9CA1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 01:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjEGXKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 May 2023 19:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjEGXKT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 May 2023 19:10:19 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7DF7EED
        for <linux-fsdevel@vger.kernel.org>; Sun,  7 May 2023 16:10:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6439d505274so1873175b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 May 2023 16:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683501015; x=1686093015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cf9ozNn9m9GwwXbOgML9WuRXk00Zt2u0q7VwC/zESD0=;
        b=3SIiysEyjQE5vmvbxt7A5GrvbR9vD5Nisg/kY7Hcvwndfc4cm6QdbuDaWDORFQZgSt
         iIGs6LDzP6Bop4QbJXVFydpBsfDeyp5raXL1cd+tsSY0tkny+j1QWILmTOFEM+gR/WJC
         vUOl6AF0wekHhBW9y+Ax4bKRZuLYnkuNbW77GofkBISkEAu+U/3O5AT0yM+iZO1U1pyX
         TT/xm61krUhSeMSiNYF8zHxerT6iP/HD+XHvsjeQOPRxpz7ZtqkWhS5JDGxn2mRhmK36
         Nk52cFyxFe/pqxSSsHYOUHWL7vcGuVfXT+pSUpHxkDxaZwtLIKjy9bg40w8oWCZvL56D
         lHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683501015; x=1686093015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cf9ozNn9m9GwwXbOgML9WuRXk00Zt2u0q7VwC/zESD0=;
        b=NY3tk/u0RGXfXlnn9o8P/bqILh71kic31TIEgJ1KjX5TPglirr6JeGe8/XmIfSixgU
         8owvw1CrluUZJEzqbnR8/GrZQw5vNnS4Xm9Un5M5OyCluaVgVq1bZayamG+YJWXmhr8G
         jPJ/YNaKU2E1MupU9Axb3TxsDis6dUxgEjhJvFyZYD2MExgYuflak+ejhNZwQl6q30Z6
         Pk53ofyQJBJ3B7vVRL/rodKoIU8EOycZ+q+Hy2jCYkk0/UsjISfTgF+/C2arF5q6bBYw
         NTA1hoTSZ0NF0Ci2WLFQtd+lAnYZbbKQKmIcT6YIWHrEiSeoKMjK7Mcvih6Lf6cTTqzb
         uD0w==
X-Gm-Message-State: AC+VfDyoU1mHzcRAwfL9Ait7TAI2+weDT4r/1Go8eL25vOWqitC/qeNC
        1nh3Mc0LSpuL6wrn1uZ524HAeh9+CONpbCtNZaA=
X-Google-Smtp-Source: ACHHUZ5+Gs2aaht1zRO/z4BZeA6pbRC8DFUtLQYaTA/5akf+0Mfzyjg/juEjo3Y8rpTCGwsoe8eH5Q==
X-Received: by 2002:a05:6a00:1a41:b0:63b:8778:99e4 with SMTP id h1-20020a056a001a4100b0063b877899e4mr10999170pfv.2.1683501015135;
        Sun, 07 May 2023 16:10:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id a4-20020aa78644000000b00640d80c8a2bsm4630572pfo.50.2023.05.07.16.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 16:10:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pvnW7-00CbgF-QD; Mon, 08 May 2023 09:10:11 +1000
Date:   Mon, 8 May 2023 09:10:11 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-btrfs@vger.kernel.org, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-fsdevel@vger.kernel.org,
        kernel@gpiccoli.net, kernel-dev@igalia.com, vivek@collabora.com,
        ludovico.denittis@collabora.com, johns@valvesoftware.com,
        nborisov@suse.com
Subject: Re: [PATCH 0/2] Supporting same fsid filesystems mounting on btrfs
Message-ID: <20230507231011.GC2651828@dread.disaster.area>
References: <20230504170708.787361-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504170708.787361-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 04, 2023 at 02:07:06PM -0300, Guilherme G. Piccoli wrote:
> Hi folks, this is an attempt of supporting same fsid mounting on btrfs.
> Currently, we cannot reliably mount same fsid filesystems even one at
> a time in btrfs, but if users want to mount them at the same time, it's
> pretty much impossible. Other filesystems like ext4 are capable of that.
> 
> The goal is to allow systems with A/B partitioning scheme (like the
> Steam Deck console or various mobile devices) to be able to hold
> the same filesystem image in both partitions; it also allows to have
> block device level check for filesystem integrity - this is used in the
> Steam Deck image installation, to check if the current read-only image
> is pristine. A bit more details are provided in the following ML thread:
> 
> https://lore.kernel.org/linux-btrfs/c702fe27-8da9-505b-6e27-713edacf723a@igalia.com/
> 
> The mechanism used to achieve it is based in the metadata_uuid feature,
> leveraging such code infrastructure for that. The patches are based on
> kernel 6.3 and were tested both in a virtual machine as well as in the
> Steam Deck. Comments, suggestions and overall feedback is greatly
> appreciated - thanks in advance!

So how does this work if someone needs to mount 3 copies of the same
filesystem at the same time?

On XFS, we have the "nouuid" mount option which skips the duplicate
UUID checking done at mount time so that multiple snapshots or
images of the same filesystem can be mounted at the same time. This
means we don't get the same filesystem mounted by accident, but also
allows all the cases we know about where multiple versions of the
filesystem need to be mounted at the same time.

I know, fs UUIDs are used differently in btrfs vs XFS, but it would
be nice for users if filesystems shared the same interfaces for
doing the same sort of management operations...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
