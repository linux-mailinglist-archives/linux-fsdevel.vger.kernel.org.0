Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486446F8CCC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 01:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjEEXb7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 19:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjEEXb6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 19:31:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C5E4EE0
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 16:31:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6434e65d808so2636895b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 May 2023 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683329516; x=1685921516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8uJUh2UWnCD23NYvfrOwl5QVSa+EISSPPjSd5uCE+wE=;
        b=hDEcZYca3fchq1Az69ce+GM2HlxTVEnOzK8YFMewKwbqZCip3SHcTYv/NcDIqyTNH6
         6/hGMJGeAOIgWb/20BfirWkR35QBYAA+xxb9UTxtticDLCSXojwOTJHrLF41Hyxt+YaK
         T6maGzq8mC7t7pPrzFzvo7tagiEYNn31u5qQDJ5kPqpuSoGyoZ6o9H6prNABkmmq5Vda
         sAFdVw3t5XhZHMPBJWIWz8Mo0sUVFZ/yYBYT9v0jzLBiEZiqao4hD7ETWKMwjPa4m+3H
         6Kaaa5nlzpH6ZAGnMfax9hrBUWORjcoA9eZU7VzKuHhAQmaO+YQSkq3pVUg4X0ClKxGM
         gbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683329516; x=1685921516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uJUh2UWnCD23NYvfrOwl5QVSa+EISSPPjSd5uCE+wE=;
        b=dQyx2X6ViUwMIU0uu+X1O/WFxN6wJUsWIBqotPblh6ojxuCHC1/ybXr5DFRtrGM/Sx
         qHY3GM6QjIzglcl8tu+axm2d8iJDlqJo/P961wumgIiz8FpqUYBpL/XFXGduF4v+Mhh1
         KXgosytNEbaz2Kp3LZ4J3E4qS5uOcMuxEcBcG1GfLNunqLJ1oBWFNDCq9GzoxZ78Fhxt
         szA5IsM+l1YLA5M+Q0SzMnLSXyDfSU/YCglkR7n9vIQWYn7S0YuxKRGOazgFpG2mPqWj
         zrDJl+UZA8hAgJuXvgf1fAAWzk7K5kQQ6LxEcSYDgWUQ8rrm+docXeBePQBIxRBu4upU
         Vj3A==
X-Gm-Message-State: AC+VfDwyggnq/j6eoaDjlPwWG//dR+/dJhLbpcQkvDmCWWOdfpQB5Oi9
        7Z9NvD9k7rMzWVUkzJ4g7OyD0g==
X-Google-Smtp-Source: ACHHUZ5jCHNKEp8ajfUWEYHb1TloSL5+Po0yDLYzFo11T7JFr0OlW1iJj/ZhwBeZIssHPkp/uFRVmQ==
X-Received: by 2002:a05:6a00:2346:b0:63f:2f00:c6d with SMTP id j6-20020a056a00234600b0063f2f000c6dmr4289043pfj.2.1683329516140;
        Fri, 05 May 2023 16:31:56 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id k2-20020aa792c2000000b0063d24fcc2b7sm2109256pfa.1.2023.05.05.16.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 16:31:55 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pv4u0-00BpIl-W1; Sat, 06 May 2023 09:31:53 +1000
Date:   Sat, 6 May 2023 09:31:52 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
Message-ID: <20230505233152.GN3223426@dread.disaster.area>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-2-john.g.garry@oracle.com>
 <20230503213925.GD3223426@dread.disaster.area>
 <fc91aa12-1707-9825-a77e-9d5a41d97808@oracle.com>
 <20230504222623.GI3223426@dread.disaster.area>
 <ZFWHdxgWie/C02OA@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFWHdxgWie/C02OA@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 10:47:19PM +0000, Eric Biggers wrote:
> On Fri, May 05, 2023 at 08:26:23AM +1000, Dave Chinner wrote:
> > > ok, we can do that but would also then make statx field 64b. I'm fine with
> > > that if it is wise to do so - I don't don't want to wastefully use up an
> > > extra 2 x 32b in struct statx.
> > 
> > Why do we need specific varibles for DIO atomic write alignment
> > limits? We already have direct IO alignment and size constraints in statx(),
> > so why wouldn't we just reuse those variables when the user requests
> > atomic limits for DIO?
> > 
> > i.e. if STATX_DIOALIGN is set, we return normal DIO alignment
> > constraints. If STATX_DIOALIGN_ATOMIC is set, we return the atomic
> > DIO alignment requirements in those variables.....
> > 
> > Yes, we probably need the dio max size to be added to statx for
> > this. Historically speaking, I wanted statx to support this in the
> > first place because that's what we were already giving userspace
> > with XFS_IOC_DIOINFO and we already knew that atomic IO when it came
> > along would require a bound maximum IO size much smaller than normal
> > DIO limits.  i.e.:
> > 
> > struct dioattr {
> >         __u32           d_mem;          /* data buffer memory alignment */
> >         __u32           d_miniosz;      /* min xfer size                */
> >         __u32           d_maxiosz;      /* max xfer size                */
> > };
> > 
> > where d_miniosz defined the alignment and size constraints for DIOs.
> > 
> > If we simply document that STATX_DIOALIGN_ATOMIC returns minimum
> > (unit) atomic IO size and alignment in statx->dio_offset_align (as
> > per STATX_DIOALIGN) and the maximum atomic IO size in
> > statx->dio_max_iosize, then we don't burn up anywhere near as much
> > space in the statx structure....
> 
> I don't think that's how statx() is meant to work.  The request mask is a bitmask, and the user can
> request an arbitrary combination of different items.  For example, the user could request both
> STATX_DIOALIGN and STATX_WRITE_ATOMIC at the same time.  That doesn't work if different items share
> the same fields.

Sure it does - what is contained in the field on return is defined
by the result mask. In this case, whatever the filesystem puts in
the DIO fields will match which flag it asserts in the result mask.

i.e. if the application wants RWF_ATOMIC and so asks for STATX_DIOALIGN |
STATX_DIOALIGN_ATOMIC in the request mask then:

- if the filesystem does not support RWF_ATOMIC it fills in the
  normal DIO alingment values and puts STATX_DIOALIGN in the result
  mask.

  Now the application knows that it can't use RWF_ATOMIC, and it
  doesn't need to do another statx() call to get the dio alignment
  values it needs.

- if the filesystem supports RWF_ATOMIC, it fills in the values with
  the atomic DIO constraints and puts STATX_DIOALIGN_ATOMIC in the
  result mask.

  Now the application knows it can use RWF_ATOMIC and has the atomic
  DIO constraints in the dio alignment fields returned.

This uses the request/result masks exactly as intended, yes?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
