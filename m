Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C27786F8C35
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 May 2023 00:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjEEWFx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 18:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjEEWFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 18:05:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E026A618C;
        Fri,  5 May 2023 15:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E429D6410B;
        Fri,  5 May 2023 22:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A297C433D2;
        Fri,  5 May 2023 22:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683324280;
        bh=f1jvZDrF9Qn33CLcZ4WNk/v3Df+AvMJXxv7DwWGW0QQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OkpKowf89TZVFXs+kZPV9yhxvlS1WPcn+RJAUjhk+F+NdGsM3DowjGujTCVspntEk
         cjONoTzL+Mbd5t+9AKB6wfFG/v2mMcL4zUbTCd68MALmZ0bvdAsdyqB1NiUPsHURQx
         Pb+EiF47Gw2FrzOLU0+uch5xJIwNkrwQ88DqtgRjz2heN6tSAyMM3taWJ6o/co195G
         InfdsysxEKZtg6MGDEsuLv05bAtcsJBM0d3KZPxDWL0S6H+Cc+wgMhp3zHymC2qu4N
         b7tWMZGshPp0ERKEWKp+Mkk6aHJZ+zyeGly/ASTr+Ej/LlVg2ok1XVQwXyBr+Dr0m5
         X42vWMe7zA2bg==
Date:   Fri, 5 May 2023 15:04:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     John Garry <john.g.garry@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
Subject: Re: [PATCH RFC 02/16] fs/bdev: Add atomic write support info to statx
Message-ID: <20230505220439.GK15394@frogsfrogsfrogs>
References: <20230503183821.1473305-1-john.g.garry@oracle.com>
 <20230503183821.1473305-3-john.g.garry@oracle.com>
 <20230503215846.GE3223426@dread.disaster.area>
 <96a2f875-7f99-cd36-e9c3-abbadeb9833b@oracle.com>
 <20230504224033.GJ3223426@dread.disaster.area>
 <644fe4aa-cb89-0c14-4c90-cc93bcc6bbc2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <644fe4aa-cb89-0c14-4c90-cc93bcc6bbc2@oracle.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 05, 2023 at 09:01:58AM +0100, John Garry wrote:
> On 04/05/2023 23:40, Dave Chinner wrote:
> 
> Hi Dave,
> 
> > > No, not yet. Is it normally expected to provide a proposed man page update
> > > in parallel? Or somewhat later, when the kernel API change has some
> > > appreciable level of agreement?
> > Normally we ask for man page updates to be presented at the same
> > time, as the man page defines the user interface that is being
> > implemented. In this case, we need updates for the pwritev2() man
> > page to document RWF_ATOMIC semantics, and the statx() man page to
> > document what the variables being exposed mean w.r.t. RWF_ATOMIC.
> > 
> > The pwritev2() man page is probably the most important one right now
> > - it needs to explain the guarantees that RWF_ATOMIC is supposed to
> > provide w.r.t. data integrity, IO ordering, persistence, etc.
> > Indeed, it will need to explain exactly how this "multi-atomic-unit
> > mulit-bio non-atomic RWF_ATOMIC" IO thing can be used safely and
> > reliably, especially w.r.t. IO ordering and persistence guarantees
> > in the face of crashes and power failures. Not to mention
> > documenting error conditions specific to RWF_ATOMIC...
> > 
> > It's all well and good to have some implementation, but without
> > actually defining and documenting the*guarantees*  that RWF_ATOMIC
> > provides userspace it is completely useless for application
> > developers. And from the perspective of a reviewer, without the
> > documentation stating what the infrastructure actually guarantees
> > applications, we can't determine if the implementation being
> > presented is fit for purpose....
> 
> ok, understood. Obviously from any discussion so far there are many details
> which the user needs to know about how to use this interface and what to
> expect.
> 
> We'll look to start working on those man page details now.

Agreed.  The manpage contents are what needs to get worked on at LSFMM
where you'll have various block/fs/storage device people in the same
room with which to discuss various issues and try to smooth out the
misundertandings.

(Also: I've decided to cancel my in-person attendance due to a sudden
health issue.   I'll still be in the room, just virtually now. :()

--D

> Thanks,
> John
