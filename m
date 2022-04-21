Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E64350A780
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 19:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390996AbiDUR40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 13:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbiDUR4X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:56:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5262F4A926;
        Thu, 21 Apr 2022 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OzMBFt4cX9sZG3+xKaNjpIrCYXW+IugofzGvsiKoa1c=; b=r+8wwH27HmVqrnNXROGmLzk+8Z
        9BQdWmRbDA5sRoSKKRvgHo5MzzgfhN5j0Omy9hJXca1lszYylN6C6VhVBRerKkOqR3O3xnPvQx/0k
        cjFj+cO1nW6yYtWNecbGNXyOmd0a1BKLaez4I8cGDSH7bF0Qjy733QIvq74FIcyVyeaqQLJnoAyGd
        PpdS/8QRn5mLrCNg7LP4bWPEAmlsGn9sMfxBAPKo856bGPyOmrZJe2OLHRgVugg0+EtA41Os2EHp5
        JXtRD2c/UC/Yopn1biddSqI6/4c9rgw4hbPDEc8hy+f7H10LkQPzaeoOhsXbpJNOIXRx+lEndjkM7
        oBbuzUrw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhazi-00EWI6-QM; Thu, 21 Apr 2022 17:53:30 +0000
Date:   Thu, 21 Apr 2022 10:53:30 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-modules@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Pankaj Malhotra <pankaj1.m@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: scsi_debug in fstests and blktests (Was: Re: Fwd: [bug
 report][bisected] modprob -r scsi-debug take more than 3mins during blktests
 srp/ tests)
Message-ID: <YmGaGoz2+Kdqu05l@bombadil.infradead.org>
References: <CAHj4cs9OTm9sb_5fmzgz+W9OSLeVPKix3Yri856kqQVccwd_Mw@mail.gmail.com>
 <fba69540-b623-9602-a0e2-00de3348dbd6@interlog.com>
 <YlW7gY8nr9LnBEF+@bombadil.infradead.org>
 <00ebace8-b513-53c0-f13b-d3320757695d@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ebace8-b513-53c0-f13b-d3320757695d@interlog.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Moving this discussion to the lists as we need to really think
about how testing on fstests and blktests uses scsi_debug for
a high confidence in baseline without false positives on failures
due to the inability to the remove scsi_debug module.

This should also apply to other test debug modules like null_blk,
nvme target loop drivers, etc, it's all the same long term. But yeah
scsi surely make this... painful today. In any case hopefully folks
with other test debug drivesr are running tests to ensure you can
always rmmod these modules regardless of what is happening.

On Tue, Apr 12, 2022 at 06:03:40PM -0400, Douglas Gilbert wrote:
> On 2022-04-12 13:48, Luis Chamberlain wrote:
> > On Thu, Apr 07, 2022 at 10:09:54PM -0400, Douglas Gilbert wrote:
> > > Hi,
> > > Is it time to revert this patch?
> > 
> > Upstream kmod will indeed get patched soon witha  --patient-remove
> > option. So the issue is that. However, it doesn't mean driver's
> > can't / should strive to avoid these issues if they can. That is a
> > thing left to driver's to implement / resolve if they want.
> > 
> > In the meantime userspace should change to user the patient removal,
> > and if the upstream kmod doesn't have yet have it (note, the code is
> > not yet merged) then tools doing module removal should open code the
> > module removal. I modified fstests to do open coding of the patient
> > module removal in case kmod does not support it.  I have a similar patch
> > for blktests but that still requires regression testing on my part. I
> > hope to finish that soon though.
> > 
> > So the answer to your question: it depends on how well you want to deal
> > with these issues for users, or punt the problems to patient removal
> > usage.
> 
> Hi,
> There is a significant amount of work bringing down a driver like scsi_debug.
> Apart from potentially consuming most of the ram on a box, it also has the
> issue of SCSI commands that are "in flight" when rmmod is called.
> 
> So I think it is approaching impossible to make rmmod scsi_debug the equivalent
> of an atomic operation. There are just too many moving parts, potentially
> moving asynchronously to one another. This is an extremely good test for the
> SCSI/block system, roughly equivalent to losing a HBA that has a lot of disks
> behind it. Will the system stabilize and how long will that take?

I understand. But I really cannot buy "impossible". Impossible I think should
mean a design flaw somewhere.

At least for now I think we should narrow our objectives so that
this is *possible* within the context of fstests and blktests because
otherwise *we really should not be using scsi_debug* for high fidelity
in testing. One of the reasons is that we want to be able to run
fstests or blktests in a loop with confidence so that failures are
real. A failure due to the inability to not remove a debug module
makes gaining confidence in a baseline a bit difficult and you'd have
to implement hacks around it.

mcgrof@fulton ~/devel/blktests (git::master)$ git grep _have_scsi_debug tests | wc -l
10

mcgrof@fulton ~/devel/xfstests-dev (git::master)$ git grep _require_scsi_debug tests| wc -l
5

Not insane, but enough for us to care, but I think if we *narrow* our
scope to ensure scsi_debug *can* be removed *at least* with the patient
module remover we're good.

Do you think this is viable goal for scsi_debug?

> Setting up races between modprobe and rmmod on scsi_debug was certainly not
> top of mind for me.

Oh I get it. But the community has already embraced it for years on
fstests and blktests. So at this point I think we have no other option.

I think one thing we *can* do is *not* use scsi_debug for tests which
*really don't need scsi*.

> Storage systems such as SCSI are a lot better defined
> (and ordered) in the power-up scenario. Even with asynchronous scanning
> (discovery) of devices (even SSDs) it can take 10 plus seconds to bring up
> devices with a lot more handshaking between controller and the storage
> device. And even with SSDs, there is increased power draw during power-up
> (hard disks obviously need to accelerate the medium up to the rated speed).
> That leads to big storage arrays staggering when they apply power to
> different banks of SSDs/disks.

Sure..

> I wonder if anyone has tested building scsi_mod (the SCSI mid-level) as a
> module and tried rmmod on it while, say, a USB key is being read :-)

:)

  Luis
