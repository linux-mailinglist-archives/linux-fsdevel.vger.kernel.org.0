Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04682141CFF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2020 09:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgASIfV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jan 2020 03:35:21 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42157 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbgASIfU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jan 2020 03:35:20 -0500
Received: by mail-il1-f196.google.com with SMTP id t2so24834591ilq.9;
        Sun, 19 Jan 2020 00:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnvCnon0B2vZEtChKK2eAEB4AoqKysFBIa8g4lTbzqs=;
        b=MICKMx0JRRKjGltjB7+mwIArqOPNrBi52HqBHbIC/HB4t4TdIOP/SYLkIFtT0HLvVG
         tSDbPRAdaXSTlVN12U/SJSdlA7hKR8rI8PVJrfn7JvU3xZi2O/SjgHo4sP7bZ+nVfoKO
         1pJ9NDQ7VCfATu4UcxLAGkBuY8maIv9yjW6OVwQ9lphaVD+BJ88DFDwmQf7nUMMiiepY
         bY8A1caHiEY6dAQNvSCOO++S/Ov/t9InaB+zvkyWPKZMj87SqgBYptJ3ODw8rwnvTGAB
         FF7gMujX0GT5MTdulwXvZje0OFRsJU3p+Bzoct9gGiOBvDTSFWCFomcGYXHUAfGZl+7E
         HMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnvCnon0B2vZEtChKK2eAEB4AoqKysFBIa8g4lTbzqs=;
        b=RaypSBwqKgbmyqYynmK6YegKi4/ZToOmfdEIBA7h9t2POjUkwsJRl3gYJYY9jcNwad
         SBapuuHuLijhQGqoFbcqzZ5Rup8TgldwN+vOpFgV+ltArFOFB7wGdgRtyyzwpU2L873n
         Nr0E1UFESNXLSoSmcLVQ2Y4WCcZlp7UYkMMp6Q0lO5R3DrF1rLWZySD2isKreTwyAg2T
         k7cAGPFUf4XHgMtlpgM7RGBBfn3aCeuUyJZwQCOA15Gp/d7DOfsMLMKxKJ6SFw/Mn3gV
         6sM9X7bacgof1w0LTXK72cbjERB2jKpFGoeVBxmxUCUkAmXgzx0n6Gq09qQ6llHBy2+t
         0dRw==
X-Gm-Message-State: APjAAAWEX8hSvBhnFIrU7xCHNpe4xKWTwTHLSW6+1HAcPoekkPXXGLJ9
        3W9KOjvJhlwyHipWLFon3auxbHvUiBuTwcDlyx4=
X-Google-Smtp-Source: APXvYqwZr4ZjR8ayJHlIXAe9Mu2fL/t/GmQP+UeWRJOzS1BF1xB3ciC2rHWyCUrxr286ENDotvVDU1t2Jngvyqsb2EQ=
X-Received: by 2002:a92:88d0:: with SMTP id m77mr6344819ilh.9.1579422919785;
 Sun, 19 Jan 2020 00:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20190829131034.10563-1-jack@suse.cz> <CAOQ4uxiDqtpsH_Ot5N+Avq0h5MBXsXwgDdNbdRC0QDZ-e+zefg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiDqtpsH_Ot5N+Avq0h5MBXsXwgDdNbdRC0QDZ-e+zefg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 19 Jan 2020 10:35:08 +0200
Message-ID: <CAOQ4uxgP_32c6QLh2cZXXs7yJ6e8MRR=yfEBjpv02FeC_HpKhg@mail.gmail.com>
Subject: Re: [PATCH 0/3 v2] xfs: Fix races between readahead and hole punching
To:     Jan Kara <jack@suse.cz>
Cc:     linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Boaz Harrosh <boaz@plexistor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 17, 2020 at 12:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Aug 29, 2019 at 4:10 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello,
> >
> > this is a patch series that addresses a possible race between readahead and
> > hole punching Amir has discovered [1]. The first patch makes madvise(2) to
> > handle readahead requests through fadvise infrastructure, the third patch
> > then adds necessary locking to XFS to protect against the race. Note that
> > other filesystems need similar protections but e.g. in case of ext4 it isn't
> > so simple without seriously regressing mixed rw workload performance so
> > I'm pushing just xfs fix at this moment which is simple.
> >
>
> Jan,
>
> Could you give a quick status update about the state of this issue for
> ext4 and other fs. I remember some solutions were discussed.
> Perhaps this could be a good topic for a cross track session in LSF/MM?
> Aren't the challenges posed by this race also relevant for RWF_UNCACHED?
>

Maybe a silly question:

Can someone please explain to me why we even bother truncating pages on
punch hole?
Wouldn't it solve the race if instead we zeroed those pages and marked them
readonly?

The comment above trunacte_pagecache_range() says:
 * This function should typically be called before the filesystem
 * releases resources associated with the freed range (eg. deallocates
 * blocks). This way, pagecache will always stay logically coherent
 * with on-disk format, and the filesystem would not have to deal with
 * situations such as writepage being called for a page that has already
 * had its underlying blocks deallocated.

So in order to prevent writepage from being called on a punched hole,
we need to make sure that page write fault will be called, which is the same
state as if an exiting hole has been read into page cache but not written yet.
Right? Wrong?

What am I missing here?

Thanks,
Amir.
