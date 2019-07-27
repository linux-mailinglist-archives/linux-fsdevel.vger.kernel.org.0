Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA10778F7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 15:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfG0Nd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 09:33:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34279 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbfG0Nd1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 09:33:27 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so58185366otk.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2019 06:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pKsm0Glo5GvWJ2FgAFUVIAU/XUG0KKO3Gz3Fqbr57A=;
        b=T0I7XaQIc0/iThEhKyKs1FTnZjdaKBO2cH/gmGwwNZfizPt0zfvmtKgMO3bDeUMGJ9
         2eL+FOIfXJs7eJPMlNqqyvRo7AE7tTXZ9t2wwK5mhvxXYqpZhI9I9nfOxO0mlJRR9X8+
         dsINBarTbfBYbig5BRo+tfVQ4XZZVPj1lwaU/EKd89WDg3y15AlcfaeDCgSHK7JYnQHz
         IaqkqWS1+MRMOoj8qmjJ3Wxks5//eCwgg7q3Db5V6gd2EKvyZa7J2HNvgmWxz8ovGl1p
         4JGyyhXIJxXNi2K6tCL5rYmVDPGJdPUkNiHqTmFC4RabQOX7dtMra46c2cOSUh/xIT8U
         Z3oQ==
X-Gm-Message-State: APjAAAV70gX/9MfvpuLqCjuV81KGgxr/uqfcqpJS1ycuE4LnbmbFhIfQ
        o+nwA8ALLLlApJyX/CK1rKRENP7nhxz6LAqsPANGMQ==
X-Google-Smtp-Source: APXvYqyAbW1b8uSXlX1kLfH6Wz3b/HKGqixPASzcQcxCPj1SJ/ze1kYlHQlYZ5Gx2uUiwFUm8rQ2kx+E3q/bIM3MDzo=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr22763240otn.297.1564234406426;
 Sat, 27 Jul 2019 06:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190722095024.19075-1-hch@lst.de> <20190726233753.GD2166993@magnolia>
In-Reply-To: <20190726233753.GD2166993@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 27 Jul 2019 15:33:14 +0200
Message-ID: <CAHc6FU7L52soLiRafnOiTsaMYp4X_NmjjimpMMzdaoSH_afT+A@mail.gmail.com>
Subject: Re: lift the xfs writepage code into iomap v3
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 27 Jul 2019 at 01:38, Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Mon, Jul 23, 2019 at 11:50:12AM +0200, Christoph Hellwig wrote:
> > Hi all,
> >
> > this series cleans up the xfs writepage code and then lifts it to
> > fs/iomap.c so that it could be use by other file system.  I've been
> > wanting to this for a while so that I could eventually convert gfs2
> > over to it, but I never got to it.  Now Damien has a new zonefs
> > file system for semi-raw access to zoned block devices that would
> > like to use the iomap code instead of reinventing it, so I finally
> > had to do the work.
>
> Hmm... I don't like how there are xfs changes mixed in with the iomap
> changes, because were I to take this series as-is then I'd have to
> commit both to adding iomap writeback code /and/ converting xfs at the
> same time.
>
> I think I'd be more comfortable creating a branch to merge the changes
> to list.h and fs/iomap/, and then gfs2/zonefs/xfs can sprout their own
> branches from there to do whatever conversions are necessary.
>
> To me what that means is splitting patch 7 into 7a which does the iomap
> changes and 7b which does the xfs changes.  To get there, I'd create a
> iomap-writeback branch containing:
>
> 1 7a 8 9 10 11 12
>
> and then a new xfs-iomap-writeback branch containing:
>
> 2 4 7b
>
> This eliminates the need for patches 3, 5, and 6, though the cost is
> that it's less clear from the history that we did some reorganizing of
> the xfs writeback code and then moved it over to iomap.  OTOH, I also
> see this as a way to lower risk because if some patch in the
> xfs-iomap-writeback branch shakes loose a bug that doesn't affect gfs2
> or zonedfs we don't have to hold them up.
>
> I'll try to restructure this series along those lines and report back
> how it went.

Keeping the infrastructure changes in separate commits would certainly
make the patches easier to work with for me. Keeping the commits
interleaved should be fine though: patch "iomap: zero newly allocated
mapped blocks" depends on "xfs: set IOMAP_F_NEW more carefully", so a
pure infrastructure branch without "xfs: set IOMAP_F_NEW more
carefully" probably wouldn't be correct.

Thanks,
Andreas
