Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAD3DF91E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 03:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhHDBEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 21:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhHDBEE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 21:04:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49EB660EE9;
        Wed,  4 Aug 2021 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628039032;
        bh=3zpTVINyDQY06hDwhYcrGO5+Ep7Qt5Tfwx09qPKhUSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKP6ry3t6DYW1/STHLt13HzOzHU51+xx8mVeLUKW6eVa16+T07HRrn4jB2qwvsiTJ
         lroMLc0yp7Mk0nu+cTODcTJaizbnClbLg7iAD5/TZ0edGk32QjxPoqvIyH4S+5zW8O
         +tXj9Y3R8owoZDv39tLITGVLB3Uvd5bomqd+KacsGUc6qu7am0XGodkGZlcawTGJzV
         2kDTnkkGMEmn1AEjuwDG4v+Y1Tcp4NIa7BIfTBU6ltNiirdAjnyj1rTotkNoJh7+kL
         kYqPdGxEQbL40TrbUMS4Rtqzg/rk+XnIC9ZjPqvUrXqhE0fyHoz95Od7oZGjQnjxuE
         NWvMCDgHBGHVA==
Date:   Tue, 3 Aug 2021 18:03:51 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        zajec5@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <20210804010351.GM3601466@magnolia>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu>
 <YQnU5m/ur+0D5MfJ@casper.infradead.org>
 <YQnZgq3gMKGI1Nig@mit.edu>
 <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
 <YQnkGMxZCgCWXQPf@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQnkGMxZCgCWXQPf@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 08:49:28PM -0400, Theodore Ts'o wrote:
> On Tue, Aug 03, 2021 at 05:10:22PM -0700, Linus Torvalds wrote:
> > The user-space FUSE thing does indeed work reasonably well.
> > 
> > It performs horribly badly if you care about things like that, though.
> > 
> > In fact, your own numbers kind of show that:
> > 
> >   ntfs/default: 670 tests, 55 failures, 211 skipped, 34783 seconds
> >   ntfs3/default: 664 tests, 67 failures, 206 skipped, 8106 seconds
> > 
> > and that's kind of the point of ntfs3.
> 
> Sure, although if you run fstress in parallel ntfs3 will lock up, the
> system hard, and it has at least one lockdep deadlock complaints.
> It's not up to me, but personally, I'd feel better if *someone* at
> Paragon Software responded to Darrrick and my queries about their
> quality assurance, and/or made commitments that they would at least
> *try* to fix the problems that about 5 minutes of testing using
> fstests turned up trivially.

<cough> Yes, my aim was to gauge their interest in actively QAing the
driver's current problems so that it doesn't become one of the shabby
Linux filesystem drivers, like <cough>ntfs.

Note I didn't even ask for a particular percentage of passing tests,
because I already know that non-Unix filesystems fail the tests that
look for the more Unix-specific behaviors.

I really only wanted them to tell /us/ what the baseline is.  IMHO the
silence from them is a lot more telling.  Both generic/013 and
generic/475 are basic "try to create files and read and write data to
them" exercisers; failing those is a red flag.

--D

> I can even give them patches and configsto make it trivially easy for
> them to run fstests using KVM or GCE....
> 
> 				- Ted
