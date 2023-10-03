Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB47B6D62
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjJCPqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjJCPqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:46:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D214495;
        Tue,  3 Oct 2023 08:46:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396FEC433C7;
        Tue,  3 Oct 2023 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696348004;
        bh=9Om6q6hLGFKck5uVF88QEHxSQb3JRjlgYRDBBS8Ko7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nvLUqefqqq+UfAdun974USJG2lGVA+E9uzE1UmyR4zGMlCLE4mRvEFMdzdc7hoAnG
         rEY0Eycqxt/vs6xdrLqoRzb6PRqlFf4sdE7hVvkIt80+IyRidbf2YfPE2ttuUMvSvA
         wGyqJj6zJZgrRJ7+K9HmtHjLbkIe996KM31TOS1HCWkIwN1ibxDwJsFZ+XKbdjq7Gf
         x+siscIZha/yq4GLNOjX8Ys3f92sZXEZ1awqfIEj8SSvvCe025wnVtJ6OdCOQGG/ug
         wn+jbc5oS203t6qqRwD7fBPtH44umNhO6qZnMQEbRDSrKJ8QsW4ocrDBFJBHX4kRAa
         zbmiuqRPqVV4w==
Date:   Tue, 3 Oct 2023 08:46:43 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20231003154643.GF21298@frogsfrogsfrogs>
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-4-john.g.garry@oracle.com>
 <20230929224922.GB11839@google.com>
 <b9c266d2-d5d6-4294-9a95-764641e295b4@acm.org>
 <d3a8b9b0-b24c-a002-e77d-56380ee785a5@oracle.com>
 <ZRtztUQvaWV8FgXW@dread.disaster.area>
 <20231003025703.GD21298@frogsfrogsfrogs>
 <da12e81d-cf29-6dd3-b01e-2319aa9487d5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da12e81d-cf29-6dd3-b01e-2319aa9487d5@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 08:23:26AM +0100, John Garry wrote:
> On 03/10/2023 03:57, Darrick J. Wong wrote:
> > > > > > +#define STATX_ATTR_WRITE_ATOMIC        0x00400000 /* File
> > > > > > supports atomic write operations */
> > > > > How would this differ from stx_atomic_write_unit_min != 0?
> > > Yeah, I suppose that we can just not set this for the case of
> > > stx_atomic_write_unit_min == 0.
> > Please use the STATX_ATTR_WRITE_ATOMIC flag to indicate that the
> > filesystem, file and underlying device support atomic writes when
> > the values are non-zero. The whole point of the attribute mask is
> > that the caller can check the mask for supported functionality
> > without having to read every field in the statx structure to
> > determine if the functionality it wants is present.
> 
> Sure, but again that would be just checking atomic_write_unit_min_bytes or
> another atomic write block setting as that is the only way to tell from the
> block layer (if atomic writes are supported), so it will be something like:
> 
> if (request_mask & STATX_WRITE_ATOMIC &&
> queue_atomic_write_unit_min_bytes(bdev->bd_queue)) {
>     stat->atomic_write_unit_min =
>       queue_atomic_write_unit_min_bytes(bdev->bd_queue);
>     stat->atomic_write_unit_max =
>       queue_atomic_write_unit_max_bytes(bdev->bd_queue);
>     stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
>     stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;
>     stat->result_mask |= STATX_WRITE_ATOMIC;

The result_mask (which becomes the statx stx_mask) needs to have
STATX_WRITE_ATOMIC set any time a filesystem responds to
STATX_WRITE_ATOMIC being set in the request_mask, even if the response
is "not supported".

The attributes_mask also needs to have STATX_ATTR_WRITE_ATOMIC set if
the filesystem+file can support the flag, even if it's not currently set
for that file.  This should get turned into a generic vfs helper for the
next fs that wants to support atomic write units:

static void generic_fill_statx_atomic_writes(struct kstat *stat,
		struct block_device *bdev)
{
	u64 min_bytes;

	/* Confirm that the fs driver knows about this statx request */
	stat->result_mask |= STATX_WRITE_ATOMIC;

	/* Confirm that the file attribute is known to the fs. */
	stat->attributes_mask |= STATX_ATTR_WRITE_ATOMIC;

	/* Fill out the rest of the atomic write fields if supported */
	min_bytes = queue_atomic_write_unit_min_bytes(bdev->bd_queue);
	if (min_bytes == 0)
		return;

	stat->atomic_write_unit_min = min_bytes;
	stat->atomic_write_unit_max =
			queue_atomic_write_unit_max_bytes(bdev->bd_queue);

	/* Atomic writes actually supported on this file. */
	stat->attributes |= STATX_ATTR_WRITE_ATOMIC;
}

and then:

	if (request_mask & STATX_WRITE_ATOMIC)
		generic_fill_statx_atomic_writes(stat, bdev);


> }
> 
> Thanks,
> John
