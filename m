Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E697A3F3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 03:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjIRBho (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Sep 2023 21:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbjIRBha (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Sep 2023 21:37:30 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BDB11C
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 18:37:24 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a86a0355dfso2639537b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 Sep 2023 18:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695001044; x=1695605844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LI9ymsdGiVZWdQwsQNvvvmEPAhraly9Hp7SHOly1W0=;
        b=trBzM+A43Jx8t1o/YyNVT0aLsI17Nu2xuaC0Pxwvfqhh6G1Ne1L597qMpggcDruMg8
         D3R355qAA+jYctt0s1gjjiDr9/MFmnx/EPtut9VlHz2Qzx6bk5uvIhWDR0r7GD1cluuH
         eqtyQ+wUk4ohV/UOgecpn1xEY1FLmYI9EUFUbQVe3TBM1X8LsjEsTKiOp3H+fSxJxux/
         XJYVswLqAX8NJB+MHFqoX+9hdsMGCKd/YbSdz6PKx0WCP7mY2aPp5q/S6Y7Pm2doKbcT
         m0dB5tqtewDt378VKYp5EdWG99xEAdO5bGLFwWuHd2GOZYNLnOS//WBoR5MBR9eqSIvQ
         QpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695001044; x=1695605844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LI9ymsdGiVZWdQwsQNvvvmEPAhraly9Hp7SHOly1W0=;
        b=Yt+cFPtxTIka0+iN6XdythKg+fXrQGueBvaclTOxF8+XvTW3Q8FRTyUmyNa9VbQt1P
         VF0rI1nVzT5iJRjZtq2TxIX/n3MEPDLgXF+hV6YJQmw7HqlRkwxtgs4PJBqT6UKPhz+c
         RQl//S76pYPxPtPYRE0iAditOSjI70Nt+PX/EPnRpnMXK3GB8+4n9y+vL6Q/H634ZV+u
         v/kZnN69R8yZZuUGVKuX5GjJ1LAyIWLUMoEHE10dqIcQ2UPDE9XSA5+hit/Cozv2Z1ro
         IdvZRxxNOlpkyBLMP+W5FrRRDjZ/azvSS5XyNjrUkcmG2XJJcqIrlvR/dbV10zzGYgAX
         xJdg==
X-Gm-Message-State: AOJu0YyIakXQyDhCUW/hf5oM2kGdduyKjk0CoGhbBgNNtXvMEl3T4mfS
        zyKKyNHI9mGk6Jc8Y7FQySZ/Fg==
X-Google-Smtp-Source: AGHT+IH/SoY8oNCnJz38iT/mrKi7kfS17PiI2BMStlObz3JV6beguLPFkWY0zgMZ1znaCCL6hrWNcA==
X-Received: by 2002:a05:6870:5629:b0:1d5:c417:503e with SMTP id m41-20020a056870562900b001d5c417503emr9011635oao.57.1695001044193;
        Sun, 17 Sep 2023 18:37:24 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id ga9-20020a17090b038900b0026094c23d0asm6260301pjb.17.2023.09.17.18.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 18:37:23 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qi3CS-0029SM-1p;
        Mon, 18 Sep 2023 11:37:20 +1000
Date:   Mon, 18 Sep 2023 11:37:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: dentry UAF bugs crashing arm64 machines on 6.5/6.6?
Message-ID: <ZQep0OR0uMmR/wg3@dread.disaster.area>
References: <20230912173026.GA3389127@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912173026.GA3389127@frogsfrogsfrogs>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:30:26AM -0700, Darrick J. Wong wrote:
> Hi everyone,
> 
> Shortly after 6.5 was tagged, I started seeing the following stacktraces
> when running xfs through fstests on arm64.  Curiously, x86_64 does not
> seem affected.
> 
> At first I thought this might be caused by the bug fixes in my
> development tree, so I started bisecting them.  Bisecting identified a
> particular patchset[1] that didn't seem like it was the culprit.  A
> couple of days later, one of my arm64 vms with that patch reverted
> crashed in the same way.  So, clearly not the culprit.

I would suggest that this is the same problem as being reported
here:

https://lore.kernel.org/linux-fsdevel/ZOWFtqA2om0w5Vmz@fedora/

due to some kind of screwup with hash_bl_lock() getting broken on
arm64 by commit 9257959a6e5b ("locking/atomic: scripts: restructure
fallback ifdeffery").

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
