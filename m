Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470A64C7C9A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 23:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiB1WBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 17:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiB1WBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:01:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBB7541AF;
        Mon, 28 Feb 2022 14:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5WUeW4akqS5GfHg5EOz3T8yMoCMl6xSGODw81Gr0/2w=; b=jkwtCgC2cyOmTmxmqjDeGU1+07
        PYxbFMG8kM4rLHikKA9m1OYv8Br9HfL2zv/4LntsntqijfkLDfnawEcDN4oS/cUBqIDyOkjyOeZUm
        1Y0ylJLHNjKhrZS7lQHwKgArsGsowEIMa4nUYTFz/istL/aYVAVFBH1Gb837xZiWPvbbVAXaq5uzW
        FLRiWGEpwQsOXKR3h2373GOKQoJn0EozL1zO/sm43d5accjXV6MnE3Sr3eQJaAzA1sa+ERvqcyyqi
        e/Kc7G5FBSFYfNrhK/l1Fa6FuAHA1eK9d6TGy96Mj2KYxQDQ/245wHEi+GAMPwnNP1zGtoGv2SJu3
        V750nciA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOo4g-00EFC6-Nw; Mon, 28 Feb 2022 22:00:58 +0000
Date:   Mon, 28 Feb 2022 14:00:58 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Steven Whitehouse <swhiteho@redhat.com>,
        Steve French <stfrench@microsoft.com>,
        Samuel Cabrero <scabrero@suse.de>,
        David Teigland <teigland@redhat.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] are we going to use ioctls forever?
Message-ID: <Yh1GGnn3avI3cjYH@bombadil.infradead.org>
References: <20220201013329.ofxhm4qingvddqhu@garbanzo>
 <f4f86a3e1ab20a1d7d32c7f5ae74419c8d780e82.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4f86a3e1ab20a1d7d32c7f5ae74419c8d780e82.camel@HansenPartnership.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 01, 2022 at 07:56:19AM -0500, James Bottomley wrote:
> On Mon, 2022-01-31 at 17:33 -0800, Luis Chamberlain wrote:
> > It would seem we keep tacking on things with ioctls for the block
> > layer and filesystems. Even for new trendy things like io_uring [0].
> 
> And many systems besides ... we're also adding new ioctls for things
> like containers.
> 
> However, could I just ask why you object to ioctls?  I agree, like any
> drug, overuse leads to huge problems.  However, there are medicinal use
> cases where they actually save a huge amount of pain.  So I think as
> long as we're careful we can still continue using them.

Getting to the point we are comparing use of ioctls with drugs is a good
indication we probably haven't given much thought to our sloppy dependency on
them.

> What is the issue?  Just the non-introspectability of the data from the
> perspective of tools like seccomp?

That's one. The opaque nature is silly. I can run blktrace on tons of
my /dev/ files and do *interesting* stupid things. This just seems
plain wrong...

> > For a few years I have found this odd, and have slowly started
> > asking folks why we don't consider alternatives like a generic
> > netlink family. I've at least been told that this is desirable
> > but no one has worked on it. *If* we do want this I think we just
> > not only need to commit to do this, but also provide a target. LSFMM
> > seems like a good place to do this.
> 
> It's not just netlink.  We have a huge plethora of interfaces claiming
> to replace the need for ioctl as a means for exchanging information
> between a multiplexor and an in-kernel set of receivers.

Yes and with io-uring cmd coming into my radar, and folks wanting to
do things like io-uring for ioctls get's me thinking this is just
going to get sloppier. I admit I like the idea of io-uring cmd for
ioctls but I would have to think that's our future.

> The latest
> one I noticed would be fsconfig, although that is filesystem specific
> (but could be made more generic).

Thanks I'll check that out.

> And, of course, configfs was
> supposed to be another generic but introspectable configuration
> exchange system.  We're quite good at coming up with ioctl replacement,
> however when we do they don't seem to be as durable.  I think we should
> really examine what we think the problem is in detail before even
> starting to propose a solution.

Sure, and evaluate what solutions already exist.

Alrighty, so as an example... I recall when we were working on trying to
avoid doing the stupid ioctl mess with wireless. Yes it made sense to
use generic netlink, but the results are quite impressive if you ask me
in terms of clarify and documentation:

include/uapi/linux/nl80211.h

So I can't be doing stupid things like sending a NL80211_CMD_GET_BEACON
command to an ethernet device, for instance. But that's not just it. The
clear specification of data types is great.

ioctls for new features for fileystems / the block layer just makes
them seem almost cavemen like. And that we don't stop and seem to have
a clear north star for an alternative does get me to ask do we really
want an alternative and if so so well let's get to it.

  Luis
