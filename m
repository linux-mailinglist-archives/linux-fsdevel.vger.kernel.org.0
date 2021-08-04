Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950163DFB7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Aug 2021 08:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhHDGi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Aug 2021 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbhHDGi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Aug 2021 02:38:27 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DE7C0613D5;
        Tue,  3 Aug 2021 23:38:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m13so2615662lfg.13;
        Tue, 03 Aug 2021 23:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RGi+UjdGgDWz1eAwnozhR2gWINzZqIgqVqUuObzwmS0=;
        b=uVHrBHbnhwooKsFvpB0aHMp3qXRizv+vurz5f5TvQJJwPreqwud/BDLt049mR1ZnXP
         NhVK8+OK7z0GN0d0kQKgdp7uGDiOO4xXtgGyhT0X3XGw/YChw+mMA22yJRtefz+KtmOt
         SXuRF5wfqocpk2X6LWe2TYfmRF62f2taLKOO23e3c4+6BcNefO14vRug+aA4w7DAwXbd
         et4ufESMrUps29kq4a6y4fF0m3GsXdkj65u5bDm0xi7FqWMD4sCZTGAiDI8dPYzi8RXm
         a8izzXT6Pp4CJ/gzFkoOFQQz46dtMSzGR0CrbhFKfVZJB2MPKmjntPw2QWluKSgbnxaj
         jVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RGi+UjdGgDWz1eAwnozhR2gWINzZqIgqVqUuObzwmS0=;
        b=RfLZOgoBKeG5mG8riBVPt/m17+KLbV9GQL87AvgnPcZnMMXtIXtz5g7kz+roWo2WPs
         diY5N0dMIZY0VAfSaOCZrAIOwboSnKIGSqGXrZCvjQ5p4qTeBFKyUUjutRNHp/S1NhmK
         g+JqB+2cSrANrHkry0AcBk0ZbNK6AGr29avF72r385Jx7mwE5UPfhOCbijw8Iwz4IVl2
         TZ1pgASSXFPpRtanUCdz+rTBUsz+yLaRzDdBPzyITZvtEkSQwhJP2wRileVO1nCoDOoN
         2Z5HHB30w81KtFy/GKOH2hnx8PtXMZV/A+wefhOnuamXUJLtHM/bOcamlwJFY1P8VJ9q
         HemQ==
X-Gm-Message-State: AOAM532JVVTDVdPXwQlOMF2XJvAGVLoZa3hUqF1ExY1a/fiiV4RyyQ9x
        cB49vqjoEGikr8HphobD4+E=
X-Google-Smtp-Source: ABdhPJx1S4jrbszhB/Y7mKBHxW+sz5YOBXMVfcOWSmA5w3yYP3ZrB3blHuE8lWd20wbcWxbT3wpaMQ==
X-Received: by 2002:a05:6512:23a4:: with SMTP id c36mr14995274lfv.539.1628059093007;
        Tue, 03 Aug 2021 23:38:13 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id h11sm105805lfc.4.2021.08.03.23.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 23:38:12 -0700 (PDT)
Date:   Wed, 4 Aug 2021 09:38:10 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        zajec5@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <20210804063810.dvnqgxnaoajy3ehe@kari-VirtualBox>
References: <4e8c0640-d781-877c-e6c5-ed5cc09443f6@gmail.com>
 <20210716114635.14797-1-papadakospan@gmail.com>
 <CAHk-=whfeq9gyPWK3yao6cCj7LKeU3vQEDGJ3rKDdcaPNVMQzQ@mail.gmail.com>
 <YQnHxIU+EAAxIjZA@mit.edu>
 <YQnU5m/ur+0D5MfJ@casper.infradead.org>
 <YQnZgq3gMKGI1Nig@mit.edu>
 <CAHk-=wiSwzrWOSN5UCrej3YcLRPmW5tViGSA5p2m-hiyKnQiMg@mail.gmail.com>
 <YQnkGMxZCgCWXQPf@mit.edu>
 <20210804010351.GM3601466@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804010351.GM3601466@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 06:03:51PM -0700, Darrick J. Wong wrote:
> On Tue, Aug 03, 2021 at 08:49:28PM -0400, Theodore Ts'o wrote:
> > On Tue, Aug 03, 2021 at 05:10:22PM -0700, Linus Torvalds wrote:
> > > The user-space FUSE thing does indeed work reasonably well.
> > > 
> > > It performs horribly badly if you care about things like that, though.
> > > 
> > > In fact, your own numbers kind of show that:
> > > 
> > >   ntfs/default: 670 tests, 55 failures, 211 skipped, 34783 seconds
> > >   ntfs3/default: 664 tests, 67 failures, 206 skipped, 8106 seconds
> > > 
> > > and that's kind of the point of ntfs3.
> > 
> > Sure, although if you run fstress in parallel ntfs3 will lock up, the
> > system hard, and it has at least one lockdep deadlock complaints.
> > It's not up to me, but personally, I'd feel better if *someone* at
> > Paragon Software responded to Darrrick and my queries about their
> > quality assurance, and/or made commitments that they would at least
> > *try* to fix the problems that about 5 minutes of testing using
> > fstests turned up trivially.
> 
> <cough> Yes, my aim was to gauge their interest in actively QAing the
> driver's current problems so that it doesn't become one of the shabby
> Linux filesystem drivers, like <cough>ntfs.
> 
> Note I didn't even ask for a particular percentage of passing tests,
> because I already know that non-Unix filesystems fail the tests that
> look for the more Unix-specific behaviors.
> 
> I really only wanted them to tell /us/ what the baseline is.  IMHO the
> silence from them is a lot more telling.  Both generic/013 and
> generic/475 are basic "try to create files and read and write data to
> them" exercisers; failing those is a red flag.
> 

Konstantin has wrote about these thing see below.

On Thu, 20 Aug 2020 10:20:26 +0000, Konstantin Komarov wrote: 
> xfstests are being one of our standard test suites among others.
> Currently we have the 'generic/339' and 'generic/013' test cases
> failing, working on it now. Other tests either pass or being skipped
> (due to missing features e.g. reflink). 
Source:
https://lore.kernel.org/linux-fsdevel/7538540ab82e4b398a0203564a1f1b23@paragon-software.com/

Also code tells that xfstests is being used in Paragon. In ntfs3/file.c:

/*
* Unwritten area
* NTFS is not able to store several unwritten areas
* Activate 'ntfs_sparse_cluster' to zero new allocated clusters
*
* Dangerous in case:
* 1G of sparsed clusters + 1 cluster of data =>
* valid_size == 1G + 1 cluster
* fallocate(1G) will zero 1G and this can be very long
* xfstest 016/086 will fail without 'ntfs_sparse_cluster'
*/
/*ntfs_sparse_cluster(inode, NULL, vcn,
 *	              min(vcn_v - vcn, clen));
 */

I'm just bringing this thing up because so many has asked and Konstantin
has not responded recently. Hopefully he will soon. Of course is it
little bit worrying that example generic/013 still fails after almoust
year has passed and Konstantin said he is working on it. And it seems that
more tests fails than beginning of review process.

> --D
> 
> > I can even give them patches and configsto make it trivially easy for
> > them to run fstests using KVM or GCE....
> > 
> > 				- Ted
