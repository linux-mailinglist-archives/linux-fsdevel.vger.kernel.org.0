Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5658E5A6E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2019 00:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfF1W17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 18:27:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41704 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfF1W17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 18:27:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so3658264pff.8;
        Fri, 28 Jun 2019 15:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zew3pu5ACLyjWDkbz64MHkLv1qO1WTV0/WPKnVwSaEE=;
        b=MEDIv/IM3ucHq7Mf6O2O24yNKeI7mYbZpcU2C5isBuCHxMsXx8TqthAuSOvnCAMP3N
         9ikHyW7cssBldoSoNquhgJa8Zb5Zp26aKHvR19HMixf/e6GI8IICxS6V5RDv7kaU+3lG
         sJnKbF/+3VMfJuimrCrbQ2gLUZom81mbvF2HG79HV+I0xZ/aBA3sMOO9kVYqQkDu4iYS
         4yxcDDCJ/8+wM3ek7nVsHuCJM2DAmboMiqB+judd0mMNzelSIRPIwovr1IqrVDPs7Lq9
         hkZ4t3VI6yXPHNAienH8gbwB6cUdJpZNydInYU6Fa7k/PFf3B8edEi8sSZ3aEdR3P02H
         B1bA==
X-Gm-Message-State: APjAAAX/GL6+Hy1KuQ7BBIuUgFOpJlLhp7nfhzWPWIy8oRlHpnMV3TN6
        fNoi00KW8alj1GCmn4uLRWM=
X-Google-Smtp-Source: APXvYqz3CEbNA+vipHzXogk+ZmrQLp7DBLwyjnSHHTcmvI3EULTJb01v11fgCw7nOHNERq3Uo1lU+Q==
X-Received: by 2002:a17:90a:8a0b:: with SMTP id w11mr15817399pjn.125.1561760878604;
        Fri, 28 Jun 2019 15:27:58 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id j15sm3392948pfr.146.2019.06.28.15.27.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 15:27:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2B044402AC; Fri, 28 Jun 2019 22:27:56 +0000 (UTC)
Date:   Fri, 28 Jun 2019 22:27:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] iomap: move the xfs writeback code to iomap.c
Message-ID: <20190628222756.GM19023@42.do-not-panic.com>
References: <20190624055253.31183-1-hch@lst.de>
 <20190624055253.31183-12-hch@lst.de>
 <20190624234304.GD7777@dread.disaster.area>
 <20190625101020.GI1462@lst.de>
 <20190628004542.GJ7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628004542.GJ7777@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:45:42AM +1000, Dave Chinner wrote:
> On Tue, Jun 25, 2019 at 12:10:20PM +0200, Christoph Hellwig wrote:
> > On Tue, Jun 25, 2019 at 09:43:04AM +1000, Dave Chinner wrote:
> > > I'm a little concerned this is going to limit what we can do
> > > with the XFS IO path because now we can't change this code without
> > > considering the direct impact on other filesystems. The QA burden of
> > > changing the XFS writeback code goes through the roof with this
> > > change (i.e. we can break multiple filesystems, not just XFS).
> > 
> > Going through the roof is a little exaggerated.
> 
> You've already mentioned two new users you want to add. I don't even
> have zone capable hardware here to test one of the users you are
> indicating will use this code, and I suspect that very few people
> do.  That's a non-trivial increase in testing requirements for
> filesystem developers and distro QA departments who will want to
> change and/or validate this code path.

A side topic here:

Looking towards the future of prosects here with regards to helping QA
and developers with more confidence in API changes (kunit is one
prospect we're evaluating)...

If... we could somehow... codify what XFS *requires* from the API
precisely...  would that help alleviate concerns or bring confidence in
the prospect of sharing code?

Or is it simply an *impossibility* to address these concerns in question by
codifying tests for the promised API?

Ie, are the concerns something which could be addressed with strict
testing on adherence to an API, or are the concerns *unknown* side
dependencies which could not possibly be codified?

As an example of the extent possible to codify API promise (although
I beleive it was unintentional at first), see:

http://lkml.kernel.org/r/20190626021744.GU19023@42.do-not-panic.com

  Luis
