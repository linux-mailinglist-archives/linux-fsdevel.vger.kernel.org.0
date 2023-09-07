Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70C5796F4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 05:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbjIGDis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 23:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIGDis (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 23:38:48 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CBB10E9
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 20:38:44 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-571194584e2so294181eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Sep 2023 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1694057924; x=1694662724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uorzJTWjpJ1Fc52MIfasTvSm9qcmhLcqEHLz5w6p+gQ=;
        b=aCh6JGO2mBLrh0Fv5rOMlDchwxDQcKQ6J6gl2llWuiyd1xfbzmecCUD/wAPmqqtYH4
         UC6feE9xyciXZ34muzvLVVY25vWW36W1rIKFBPXN5ZtB/iqJwts+kWbvBc6hKUi6rFPB
         ylWbJ5Ix/ILjKl1ROXyihHp6ByTFGet7kvas6LteNrAsjNv7ipOGa/lvspt1LlobR4w8
         EcRhvlcie8bOwyCah3UjQBQE0NqdDBdy/bwhKWv0TGAjzK5VF+75TFDSbC7fT8F0mE5C
         y1x5eFMtq4uXdNIHXb8JvSOmgr2s3zmaYxGplNzXnDbtqhXg75GPSS5s+PYplnfjmcjK
         EroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694057924; x=1694662724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uorzJTWjpJ1Fc52MIfasTvSm9qcmhLcqEHLz5w6p+gQ=;
        b=kY4FbONNVqLifh/GqlrfEyNfGwrewmlYhGzyAGr8ycM5sBj0wseyO3Ld2G09vUWhJc
         1uHb0yIbBXVPxvJnqKqjhhfVmGzQtKUeOhTJ6ed8LysSfGzX2Qak8xhsv0hjS7G8h0+5
         oZzL7n1b2KPiMayMXc+8DJD5AN3aue04N8peXk7Tx7I5UK9NRfU8aayd+EtSrr+xxuyl
         wGwDlPhUHj5NNyiK6CCwEzum6qLAq0y3QYazu9Q7RwrTWL7Kqxd37evbdYZ1heN48kpn
         xKE5ILUP6UFOdPSjfNS/4soZIKjo/0dA980ojgniSFuWbuFigRFSXTsnBty8gPLrVCDn
         uksA==
X-Gm-Message-State: AOJu0Yy16z4+6lRRxWVHumg3RQN8mg5pk6iy6vTFuqiUqAxJaDe28xYm
        ogAH7xP0piwF1I/UTjgzr6kFdg==
X-Google-Smtp-Source: AGHT+IEDjq+OShKOIy6PXr7PgrmfLuQ+vrNWOIjP/J9E/GglwOVAegdinD6YN5kFQSgpQe/Tb6mbqg==
X-Received: by 2002:a05:6358:91a4:b0:12b:e45b:3fac with SMTP id j36-20020a05635891a400b0012be45b3facmr5912445rwa.32.1694057923767;
        Wed, 06 Sep 2023 20:38:43 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id n26-20020a638f1a000000b0055b61cd99a1sm11785712pgd.81.2023.09.06.20.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 20:38:43 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qe5qq-00BrjP-21;
        Thu, 07 Sep 2023 13:38:40 +1000
Date:   Thu, 7 Sep 2023 13:38:40 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
 <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906225139.6ffe953c@gandalf.local.home>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 10:51:39PM -0400, Steven Rostedt wrote:
> On Thu, 7 Sep 2023 12:22:43 +1000
> Dave Chinner <david@fromorbit.com> wrote:
> 
> > > Anyway, what about just having read-only be the minimum for supporting a
> > > file system? We can say "sorry, due to no one maintaining this file system,
> > > we will no longer allow write access." But I'm guessing that just
> > > supporting reading an old file system is much easier than modifying one
> > > (wasn't that what we did with NTFS for the longest time?)  
> > 
> > "Read only" doesn't mean the filesytsem implementation is in any way
> > secure, robust or trustworthy - the kernel is still parsing
> > untrusted data in ring 0 using unmaintained, bit-rotted, untested
> > code....
> 
> It's just a way to still easily retrieve it, than going through and looking
> for those old ISOs that still might exist on the interwebs. I wouldn't
> recommend anyone actually having that code enabled on a system that doesn't
> need access to one of those file systems.

In which cae, we should not support it in the kernel!

If all a user needs is a read-only implementation for data recovery,
then it should be done in userspace or with a FUSE back end. Just
because it is a "filesystem" does not mean it needs to be
implemented in the kernel.

> I guess the point I'm making is, what's the burden in keeping it around in
> the read-only state? It shouldn't require any updates for new features,
> which is the complaint I believe Willy was having.

Keeping stuff around as "read-only" doesn't reduce the maintainence
burden; it actually makes it harder because now you can't use the
kernel filesystem code to create the necessary initial conditions
needed to test the filesystem is actually reading things correctly.

That is, testing a "read-only" filesystem implementation requires
you to have some external mechanism to create filesystem images in
the first place. With a read-write implementation, the filesystem
implementation itself can create the structures that then get
tested....

Hence, IMO, gutting a filesystem implementation to just support
read-only behaviour "to prolong it's support life" actually makes
things worse from a maintenance and testing persepective, not
better....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
