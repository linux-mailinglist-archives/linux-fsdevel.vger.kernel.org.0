Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B387B5ED2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 03:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbjJCBv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 21:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjJCBv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 21:51:57 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791F4CC
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 18:51:53 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-58916df84c8so217077a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 18:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696297913; x=1696902713; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ryilhvn2NwsqlzE716oXqoFx5LNv9PYSQOslNalU2W8=;
        b=AYLiTDKNuQs6w0myGbYLWykexKtd0cL2ILJCgbMyGqfi2E/AST3Ez76buB1Yg8vDeP
         JOPgT+faK6MMXOGsY0rsndMEEF6ofBIrizHO0xK2MRd2BkCTOsjVcyXb4O9dbsaWjS94
         m6XTbReLg1xxPVKWz+zOgx1nG+UVfPSQnAkEf1oXj7xKcx5D5z6PWw186VXVWC64mSW3
         5n5lzD3KfksLJBI/Jwy7CNc5XDQDD8nY5xJja7RXdfrb+7lkq1zvM7zHJjyczrT0U9pi
         39YdfznnXMtbEReBZIie/SyIGERuto65oKDR5sQfhWKCKm2H/n+oPOYvKD8NV4fuGHbX
         ZHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696297913; x=1696902713;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryilhvn2NwsqlzE716oXqoFx5LNv9PYSQOslNalU2W8=;
        b=vtnF3mGim6piTpr86QB3t4OPKfLlAH2v49s/xlWkdThCjSrTG0ZcqVrEw/ddC14rVk
         8pbiVHwaBsLUXBv6CThyypXmO/I93Z93i2435RMd35n+4x/uL3nAajKriyFv1W3NUk6l
         aBFERdZlSqB3/6TNGkjFPhRhSZYVOih3MEEpKQnCvK0Bsqyp3UnwbYc6vQNuT29gs6l4
         p12cRXDbm0c8jr6mzkO5T/+ZKfCoGSoeLorm2g5ObFfLJk4YCtFhGt8zDfzk665Jl0VW
         TfaIB7lBniMRp4nDkjC4RNDo/eO2bohNJiF3n/3GbgZlQItPFRyBxQWwYLEJHb8s5iQW
         Vhng==
X-Gm-Message-State: AOJu0Yyu5vR6PFENfVIX5qmLZhEettSCbLrffpsZTy+rLKlXFKj+ic69
        Gq602Byo1lgzGELqjVazR7VOPg==
X-Google-Smtp-Source: AGHT+IEtTWVWyP4SpkC8z1hoWBSmgGgWtpEEGbSrB1vJsTjGxcQSPIpPK5eSkJU5QkXOcYPJ8oQPAw==
X-Received: by 2002:a05:6a20:7f89:b0:14c:d5d8:9fed with SMTP id d9-20020a056a207f8900b0014cd5d89fedmr14193403pzj.54.1696297912959;
        Mon, 02 Oct 2023 18:51:52 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id z17-20020aa785d1000000b00690c7552098sm154707pfn.44.2023.10.02.18.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 18:51:52 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qnUZh-008huh-38;
        Tue, 03 Oct 2023 12:51:49 +1100
Date:   Tue, 3 Oct 2023 12:51:49 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Eric Biggers <ebiggers@kernel.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Message-ID: <ZRtztUQvaWV8FgXW@dread.disaster.area>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
 <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 10:51:36AM +0100, John Garry wrote:
> On 01/10/2023 14:23, Bart Van Assche wrote:
> > On 9/29/23 15:49, Eric Biggers wrote:
> > > On Fri, Sep 29, 2023 at 10:27:08AM +0000, John Garry wrote:
> > > > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > > > index 7cab2c65d3d7..c99d7cac2aa6 100644
> > > > --- a/include/uapi/linux/stat.h
> > > > +++ b/include/uapi/linux/stat.h
> > > > @@ -127,7 +127,10 @@ struct statx {
> > > >       __u32    stx_dio_mem_align;    /* Memory buffer alignment
> > > > for direct I/O */
> > > >       __u32    stx_dio_offset_align;    /* File offset alignment
> > > > for direct I/O */
> > > >       /* 0xa0 */
> > > > -    __u64    __spare3[12];    /* Spare space for future expansion */
> > > > +    __u32    stx_atomic_write_unit_max;
> > > > +    __u32    stx_atomic_write_unit_min;
> > > 
> > > Maybe min first and then max?  That seems a bit more natural, and a
> > > lot of the
> > > code you've written handle them in that order.
> 
> ok, I think it's fine to reorder
> 
> > > 
> > > > +#define STATX_ATTR_WRITE_ATOMIC        0x00400000 /* File
> > > > supports atomic write operations */
> > > 
> > > How would this differ from stx_atomic_write_unit_min != 0?
> 
> Yeah, I suppose that we can just not set this for the case of
> stx_atomic_write_unit_min == 0.

Please use the STATX_ATTR_WRITE_ATOMIC flag to indicate that the
filesystem, file and underlying device support atomic writes when
the values are non-zero. The whole point of the attribute mask is
that the caller can check the mask for supported functionality
without having to read every field in the statx structure to
determine if the functionality it wants is present.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
