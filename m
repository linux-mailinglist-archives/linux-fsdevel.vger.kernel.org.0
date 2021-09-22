Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C277413F82
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 04:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhIVChx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 22:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhIVChw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:37:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56B8661178;
        Wed, 22 Sep 2021 02:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632278183;
        bh=fot5GTOfzIwkSGTvycywEcAtayVaDZk7RQjs5hY/iLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khIvVq5mk15hhgiDYyVIhMn4rPlsUa37QqB7PQiomxMNZCy21dcnfr2926AVgMkjw
         FWS6HJzEhb5QqQ0F1ALQwsOm9Y6BDQ1XCoJ5H08at1fXpBCIRa2QAKAo4BUD3azuhI
         e9r1S4j9cQoTHBsohvHGmMKkYprM2Ttwuy18uLI3Cv3owuc/USJ4l7YxJzOTBBRBJj
         v0XfZepdLpzZCe+FLz8vK4bQEg9w5nIoUps0awJgMF3nWJ1h9tsGMpY6jTEdz/CJxA
         bFi5LBqpgp3AMcD0OT3FtrIjUT53CnonqunBdqCc+6XBCfQgFOYOJT80AvsfZOlH2v
         92vZJk3V6Kf8g==
Date:   Tue, 21 Sep 2021 19:36:22 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Eric Sandeen <sandeen@redhat.com>,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 3/3] ext2: remove dax EXPERIMENTAL warning
Message-ID: <20210922023622.GC570615@magnolia>
References: <1631726561-16358-1-git-send-email-sandeen@redhat.com>
 <1631726561-16358-4-git-send-email-sandeen@redhat.com>
 <20210917094707.GD6547@quack2.suse.cz>
 <YUSRHjynaozAuO+P@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUSRHjynaozAuO+P@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 01:59:10PM +0100, Christoph Hellwig wrote:
> On Fri, Sep 17, 2021 at 11:47:07AM +0200, Jan Kara wrote:
> > On Wed 15-09-21 12:22:41, Eric Sandeen wrote:
> > > As there seems to be no significant outstanding concern about
> > > dax on ext2 at this point, remove the scary EXPERIMENTAL
> > > warning when in use.
> > > 
> > > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > 
> > Agreed. Do you want my ack or should I just merge this patch?
> 
> Please do not merge it.  The whole DAX path is still a mess and should
> not be elevated to non-EXPERMINTAL state in this form.

Hi Christoph,

'still a mess' isn't all that useful for figuring out what still needs
to be done and splitting up the work.  Do you have items beyond my own
list below?

 - still arguing over what exactly FALLOC_FL_ZERO_REINIT_WHATEVER_PONIES
   should be doing
 - no reflink support, encompassing:
 - hwpoison from mmap regions really ought to tell the fs that bad stuff
   happened
 - mm rmap can't handle more than one owner

--D

