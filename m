Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6278E7B5F2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 04:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjJCC5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 22:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjJCC5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:57:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835AAA1;
        Mon,  2 Oct 2023 19:57:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A19CC433C7;
        Tue,  3 Oct 2023 02:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696301824;
        bh=VaFWFM5fxDWGkb8H1vk6Bq8dR22TjRNx4fMlMFNeYbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fcq3zcCoO8Cw3fSu03I/MN7v4SZVVerKmQLt2XdPAdd7oRhQuf/3qGM718GYYKXHr
         XYLU3kV10AQEcShXicFobffOpIo33qy2nJhifxPjZROX1vPVEEt0c8Pz3JkK/8jbIT
         6LVV4LblD5xEPcQDCvNh7+FXEWbywSAq5R7Arlb9QueR6vapcefnZ2kHNvdW/OyJP/
         9eY+eZ0+4caJ2Nx2QB6+hdzRq61ZL115VvKrna6IYqrqH1D680fWp8IxG+bAtUNo7O
         ZG4OuNPJzfpH1L6gTDg2BwvvXSB5MDg3XIwWbOQa7fnSrhQeGW/0/YK4SrYySgvCkB
         zS58IZ7Vc1rzw==
Date:   Mon, 2 Oct 2023 19:57:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Eric Biggers <ebiggers@kernel.org>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH 03/21] fs/bdev: Add atomic write support info to statx
Message-ID: <20231003025703.GD21298@frogsfrogsfrogs>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
 <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
 <ZRtztUQvaWV8FgXW@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZRtztUQvaWV8FgXW@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 12:51:49PM +1100, Dave Chinner wrote:
> On Mon, Oct 02, 2023 at 10:51:36AM +0100, John Garry wrote:
> > On 01/10/2023 14:23, Bart Van Assche wrote:
> > > On 9/29/23 15:49, Eric Biggers wrote:
> > > > On Fri, Sep 29, 2023 at 10:27:08AM +0000, John Garry wrote:
> > > > > diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> > > > > index 7cab2c65d3d7..c99d7cac2aa6 100644
> > > > > --- a/include/uapi/linux/stat.h
> > > > > +++ b/include/uapi/linux/stat.h
> > > > > @@ -127,7 +127,10 @@ struct statx {
> > > > >       __u32    stx_dio_mem_align;    /* Memory buffer alignment
> > > > > for direct I/O */
> > > > >       __u32    stx_dio_offset_align;    /* File offset alignment
> > > > > for direct I/O */
> > > > >       /* 0xa0 */
> > > > > -    __u64    __spare3[12];    /* Spare space for future expansion */
> > > > > +    __u32    stx_atomic_write_unit_max;
> > > > > +    __u32    stx_atomic_write_unit_min;
> > > > 
> > > > Maybe min first and then max?  That seems a bit more natural, and a
> > > > lot of the
> > > > code you've written handle them in that order.
> > 
> > ok, I think it's fine to reorder
> > 
> > > > 
> > > > > +#define STATX_ATTR_WRITE_ATOMIC        0x00400000 /* File
> > > > > supports atomic write operations */
> > > > 
> > > > How would this differ from stx_atomic_write_unit_min != 0?
> > 
> > Yeah, I suppose that we can just not set this for the case of
> > stx_atomic_write_unit_min == 0.
> 
> Please use the STATX_ATTR_WRITE_ATOMIC flag to indicate that the
> filesystem, file and underlying device support atomic writes when
> the values are non-zero. The whole point of the attribute mask is
> that the caller can check the mask for supported functionality
> without having to read every field in the statx structure to
> determine if the functionality it wants is present.

^^ Seconding what Dave said.

--D

> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
