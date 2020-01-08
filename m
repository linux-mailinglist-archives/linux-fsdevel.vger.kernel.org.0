Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA5BD134526
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 15:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgAHOiF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 09:38:05 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42744 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgAHOiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:38:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id y4so3537634ljj.9;
        Wed, 08 Jan 2020 06:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DJue8/6LAi2tlw85/kLQgrOu38pX1buqz3xnndYdkb4=;
        b=uTkbRiLMq4uyDlANwRVvyDvo6KFM4b7xpmkLPFOfEsST7+xd21eWq0XU/PjiYqwyXR
         qCU7bfDg7Ub3DLKcputeiysZldmRMLeslqYpoGcQ6dz+9W+1xleh62Hkn0khWkWcCD1T
         PE7lrjGfFpBS8l9EP+uY7wD9jQovSQn7gcUvtkADOxpCbFZ6IjElU/9Uq5IQiDR47dd7
         I4txYIFzz0iQIw7YYg6auAlRSWJ6O9hNkWP3uokOUsBABb8lmcT6HjbPEzqtSljIiN8y
         aRhgNNk49/2FLU/LAvbKIQ66deji5cDn4jyh6CQxd6aK3wujxu5mfX3+McsqQjcuEEs7
         uojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DJue8/6LAi2tlw85/kLQgrOu38pX1buqz3xnndYdkb4=;
        b=Ay8VAX8A42p25klxI1jZzSOeZ8x7Brymf16UtjaoOOvBGMJ57ouUuAmLZjpnlNfdq5
         ee2O6q3Iomv+ds932kRWVJUD59N5puTDcBi5n5SaxU4DvkSfXFVWaQ58J7rKQTeMy7ba
         X7nfP5ogvKDbxHxIGpiqGknp0rGcoJIlG5qmvRosOc8Og0hqwHCAubeHlpX2dDv7WJXq
         SNdv1g4UY2K4fAHTmXDOIcG8DrJhXSMrpxe38diyO99iugBBfG+CQZLkbZ3BJClmheiJ
         Cb2EkNs95VX8CEPK7y4L3iE+fdacpd1RcZN5CkYjRh1W6lnLZp85qarNr5ZVbaC4I1Y8
         KYXQ==
X-Gm-Message-State: APjAAAV787eH6dQJjx6k4oN9KOMO8fLXNogX7NTmD1fpEbE+6OqKbPhy
        HA0uan7aus2o31w3qgkpXN8=
X-Google-Smtp-Source: APXvYqxfw2SjsgOrvnNQobjIGJ3Q2def72Hm4QfXCeKCU74uYYOI4EPLHVPaAmihbFLUuhmyxmwbow==
X-Received: by 2002:a2e:98ca:: with SMTP id s10mr3198466ljj.160.1578494282566;
        Wed, 08 Jan 2020 06:38:02 -0800 (PST)
Received: from localhost.localdomain (h-88-110.A230.priv.bahnhof.se. [212.85.88.110])
        by smtp.gmail.com with ESMTPSA id r2sm1493279lfn.13.2020.01.08.06.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jan 2020 06:37:59 -0800 (PST)
From:   Mikael Magnusson <mikachu@gmail.com>
To:     david@fromorbit.com
Cc:     akpm@linux-foundation.org, amir73il@gmail.com,
        chris@chrisdown.name, hannes@cmpxchg.org, hughd@google.com,
        jlayton@kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tj@kernel.org, viro@zeniv.linux.org
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Date:   Wed,  8 Jan 2020 15:37:52 +0100
Message-Id: <20200108143752.9475-1-mikachu@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20200107001039.GM23195@dread.disaster.area>
References: <20200107001039.GM23195@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave Chinner writes:
> On Sun, Jan 05, 2020 at 12:06:05PM +0000, Chris Down wrote:
> > The default is still set to inode32 for backwards compatibility, but
> > system administrators can opt in to the new 64-bit inode numbers by
> > either:
> > 
> > 1. Passing inode64 on the command line when mounting, or
> > 2. Configuring the kernel with CONFIG_TMPFS_INODE64=y
> > 
> > The inode64 and inode32 names are used based on existing precedent from
> > XFS.
> 
> Please don't copy this misfeature of XFS.
> 
> The inode32/inode64 XFS options were a horrible hack made more than
> 20 years ago when NFSv2 was still in use and 64 bit inodes could
> not be used for NFSv2 exports. It was then continued to be used
> because 32bit NFSv3 clients were unable to handle 64 bit inodes.
> 
> It took 15 years for us to be able to essentially deprecate
> inode32 (inode64 is the default behaviour), and we were very happy
> to get that albatross off our necks.  In reality, almost everything
> out there in the world handles 64 bit inodes correctly
> including 32 bit machines and 32bit binaries on 64 bit machines.
> And, IMNSHO, there no excuse these days for 32 bit binaries that
> don't using the *64() syscall variants directly and hence support
> 64 bit inodes correctlyi out of the box on all platforms.
> 
> I don't think we should be repeating past mistakes by trying to
> cater for broken 32 bit applications on 64 bit machines in this day
> and age.

Hi,

It's unfortunately not true that everything handles this correctly.
32-bit binaries for games on Steam that use stat() without the 64 is
so prevalent that I got tired of adding the LD_PRELOAD wrapper script
and just patched out the EOVERFLOW return from glibc instead. (They
obviously don't care about the inode value at all, and I don't use any
other 32-bit binaries that do). This is probably a class of binaries
you don't care very much about, and not very likely to be installed on
a tmpfs that has wrapped around, but I thought it was worth mentioning
that they do exist anyway.

-- 
Mikael Magnusson
