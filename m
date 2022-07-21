Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFE257D744
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 01:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiGUXMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 19:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiGUXMU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 19:12:20 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F9574B486;
        Thu, 21 Jul 2022 16:12:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 74CF610E827F;
        Fri, 22 Jul 2022 09:12:18 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oEfL6-003jHk-74; Fri, 22 Jul 2022 09:12:16 +1000
Date:   Fri, 22 Jul 2022 09:12:16 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 6/6] NFSD: Repeal and replace the READ_PLUS
 implementation
Message-ID: <20220721231216.GR3600936@dread.disaster.area>
References: <20220715184433.838521-1-anna@kernel.org>
 <20220715184433.838521-7-anna@kernel.org>
 <EC97C20D-A317-49F9-8280-062D1AAEE49A@oracle.com>
 <20220718011552.GK3600936@dread.disaster.area>
 <CAFX2Jf=FrXHMxioWLHFkRHxBNDRe-9SBUmCcco9gkaY8EQOSZg@mail.gmail.com>
 <20220719224434.GL3600936@dread.disaster.area>
 <CF981532-ADC0-43F9-A304-9760244A53D5@oracle.com>
 <20220720023610.GN3600936@dread.disaster.area>
 <8122876aa3afe2b57d2c3153045d3e1936210b98.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8122876aa3afe2b57d2c3153045d3e1936210b98.camel@kernel.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62d9dd52
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
        a=tAJT2MkZe2RdVAGmcZcA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 20, 2022 at 08:55:23AM -0400, Jeff Layton wrote:
> On Wed, 2022-07-20 at 12:36 +1000, Dave Chinner wrote:
> > > Now how does the server make that choice? Is there an attribute
> > > bit that indicates when a file should be treated as sparse? Can
> > > we assume that immutable files (or compressed files) should
> > > always be treated as sparse? Alternately, the server might use
> > > the file's data : hole ratio.
> > 
> > None of the above. The NFS server has no business knowing intimate
> > details about how the filesystem has laid out the file. All it cares
> > about ranges containing data and ranges that have no data (holes).
> > 
> > If the filesystem can support a sparse read, it returns sparse
> > ranges containing data to the NFS server. If the filesystem can't
> > support it, or it's internal file layout doesn't allow for efficient
> > hole/data discrimination, then it can just return the entire read
> > range.
> > 
> > Alternatively, in this latter case, the filesystem could call a
> > generic "sparse read" implementation that runs memchr_inv() to find
> > the first data range to return. Then the NFS server doesn't have to
> > code things differently, filesystems don't need to advertise
> > support for sparse reads, etc because every filesystem could
> > support sparse reads.
> > 
> > The only difference is that some filesystems will be much more
> > efficient and faster at it than others. We already see that sort
> > of thing with btrfs and seek hole/data on large cached files so I
> > don't see "filesystems perform differently" as a problem here...
> > 
> 
> ^^^
> This seems like more trouble than it's worth, and would probably result
> in worse performance. The generic implementation should just return a
> single non-sparse extent in the sparse read reply if it doesn't know how
> to fill out a sparse read properly. IOW, we shouldn't try to find holes,
> unless the underlying filesystem can do that itself via iomap sparse
> read or some similar mechanism.

Yup, that's what I'd suggest initially, then a separate
investigation can be done to determine if manual hole detection is
worth the effort for those filesystems that cannot support sparse
reads effectively.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
