Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D3E796ED8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 04:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237471AbjIGCWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 22:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjIGCWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:22:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB1819A0
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 19:22:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf092a16c9so4238525ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 19:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694053366; x=1694658166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=srIwWKbC660nigrXTpX+thXv3rAgs/4zyz6RieRjYho=;
        b=sl6iPcM6iI0UnTBNSs58rc45y3CCab0fitgj2yWrzvTa9Sy8rIthIeEAliKZ3LY3Jz
         5XhyLySFaFZLf+MI61MTx2wSyLvWX2VuQrw1qYJ5K1zHiDE0wTnSkEoyynVOEZTRrF4v
         bdKXnzUw4T5UxIRBuQxBOxXUVkEe6ziGD9gzAH40XpgfRK6gvaz1naovH3zDVTVrC/M+
         2ISpJO+lUvG7lzASPSwlNfkhrUBqx/hth4FTqvXr2RJxrM9m3rMybFsooeiRpVyIS3uV
         kAYXtEWGpctHDZNvZ/LG5g+8f+Iw7IoP82SmORMicECOkN4MXwvN5G/1aNGUvgiZ8Vjh
         taBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694053366; x=1694658166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srIwWKbC660nigrXTpX+thXv3rAgs/4zyz6RieRjYho=;
        b=kuK3TaYcfmdkS/BNodMGcYudCfXms1AGdW2CvS3+kcsmoHtR2Zn8pGe8KOBTBK+biy
         KnSDzIG40VeK5vKJJlwWp8VKehkQ01qFK2qdXAtEby18QiNIAcT5nfBbE8doXhBKOJFO
         31TfhWc2nYJVqQ5VfOWm61pwpnzFLoZ5gm+BV8XX74kRRmKP2ywOYgavVFkDWmuWo3oZ
         KuSgsyIaB2Ij3LhO8f94FqvyYkllVhIrj8lLAVqo4aw15xICJ+GySq4P/bQmQY4T8Ep+
         siFls6q6PMFAAjrAC7Kko+gezXQZM9q3fCGQY8hxmNKXV5B0LkOh1UI0uJ2Dv0dgTuQL
         38Mg==
X-Gm-Message-State: AOJu0Yzj6PKfcyaD/9iupbNpJVkDWRHBj7Yaz4agUyMiZ288wpQgY5eA
        me+sFVgOw4QIcfwQbPJqYg0xig==
X-Google-Smtp-Source: AGHT+IGXEgwTgDu15D8hEMBL3TxZQ44fyP5BziVoXzPSzJnafhlvNTErafURMhuJEuS4Y5eaGAOAhQ==
X-Received: by 2002:a17:903:1d2:b0:1bd:fbc8:299e with SMTP id e18-20020a17090301d200b001bdfbc8299emr23403514plh.4.1694053366281;
        Wed, 06 Sep 2023 19:22:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001aadd0d7364sm11707517plg.83.2023.09.06.19.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 19:22:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qe4fL-00BqCW-1c;
        Thu, 07 Sep 2023 12:22:43 +1000
Date:   Thu, 7 Sep 2023 12:22:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPkz86RRLaYOkmx+@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906215327.18a45c89@gandalf.local.home>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:53:27PM -0400, Steven Rostedt wrote:
> On Thu, 7 Sep 2023 08:54:38 +1000
> Dave Chinner <david@fromorbit.com> wrote:
> 
> > And let's not forget: removing a filesystem from the kernel is not
> > removing end user support for extracting data from old filesystems.
> > We have VMs for that - we can run pretty much any kernel ever built
> > inside a VM, so users that need to extract data from a really old
> > filesystem we no longer support in a modern kernel can simply boot
> > up an old distro that did support it and extract the data that way.
> 
> Of course there's the case of trying to recreate a OS that can run on a
> very old kernel. Just building an old kernel is difficult today because
> today's compilers will refuse to build them (I've hit issues in bisections
> because of that!)
> 
> You could argue that you could just install an old OS into the VM, but that
> too requires access to that old OS.

Well, yes - why would anyone even bother trying to build an ancient
kernel when all they need to do is download an iso and point the VM
at it?

> Anyway, what about just having read-only be the minimum for supporting a
> file system? We can say "sorry, due to no one maintaining this file system,
> we will no longer allow write access." But I'm guessing that just
> supporting reading an old file system is much easier than modifying one
> (wasn't that what we did with NTFS for the longest time?)

"Read only" doesn't mean the filesytsem implementation is in any way
secure, robust or trustworthy - the kernel is still parsing
untrusted data in ring 0 using unmaintained, bit-rotted, untested
code....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
