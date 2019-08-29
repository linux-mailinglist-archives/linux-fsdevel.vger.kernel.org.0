Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90119A2A54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 00:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfH2Wxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 18:53:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33857 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfH2Wxy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:53:54 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1i3TIe-00068C-MH
        for linux-fsdevel@vger.kernel.org; Thu, 29 Aug 2019 22:53:52 +0000
Received: by mail-io1-f70.google.com with SMTP id h7so5888509ioj.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 15:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W5tNZ8pk5+mXwwGMBEXrR6iGUCDn22iPErdXfsUdHGA=;
        b=XRWFxubauAHC8S050yyRS0p9rg44y3IYLlVk67aVPnAIBwH3VXGHGHsnsmHktT+ieJ
         rVi29kGdonG/4K3t+39EGlKebe/SYr/NWRCToXH+tjaZzKxCjEstwDT0EWikHURiES4b
         wMczHbnlmkwqv3Bu6TQjfs5mc9ROlOTabHRUEX25/fWznZ/Wr/SLJI4j2cv7PBBmI7Ge
         HKibL8E6LfiuBR3pB12flaOT9TY8Svw0GkFv/V5swlqwLq6lGnj2v70jY0FY4szWEzKF
         63tpssGqMoCODWxrn9KMSOHX6aY9lAvkj4Y4ckHpD5Kj0L0HxooiAX/h+cyrSrG7AQaW
         qpWA==
X-Gm-Message-State: APjAAAVixgoZ84AdH2kGvEb0FwrBMaOMVGUwqqyJqdHZx+0BkoKZY8qx
        UxlVNxtlOVHE1tU40t4LXyCMdQnM4diOOTqRcW5I9ZbyidARL+K6V+fEBVT+ph8XXc+OceVlErc
        bkevY/twsYcYRySwFIIyFA8kCF1EQN6S+j+H0z9GawXY=
X-Received: by 2002:a6b:9107:: with SMTP id t7mr10633601iod.150.1567119231509;
        Thu, 29 Aug 2019 15:53:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyMu2HmqWRM4hRJDak0MNAQEWQVqI5SkWX+ag1YJqTIfXQ9BjE9aCIfJKUqGD/car75caUU0w==
X-Received: by 2002:a6b:9107:: with SMTP id t7mr10633569iod.150.1567119231085;
        Thu, 29 Aug 2019 15:53:51 -0700 (PDT)
Received: from xps13.canonical.com (c-71-56-235-36.hsd1.co.comcast.net. [71.56.235.36])
        by smtp.gmail.com with ESMTPSA id g8sm3121494ioc.30.2019.08.29.15.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:53:50 -0700 (PDT)
Date:   Thu, 29 Aug 2019 16:53:48 -0600
From:   dann frazier <dann.frazier@canonical.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.com>,
        Colin King <colin.king@canonical.com>,
        Ryan Harper <ryan.harper@canonical.com>
Subject: Re: ext4 fsck vs. kernel recovery policy
Message-ID: <20190829225348.GA13045@xps13.dannf>
References: <CALdTtnuRqgZ=By1JQ0yJJYczUPxxYCWPkAey4BjBkmj77q7aaA@mail.gmail.com>
 <5FEB4E1B-B21B-418D-801D-81FF7C6C069F@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FEB4E1B-B21B-418D-801D-81FF7C6C069F@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 27, 2019 at 02:27:25PM -0600, Andreas Dilger wrote:
> On Aug 27, 2019, at 1:10 PM, dann frazier <dann.frazier@canonical.com> wrote:
> > 
> > hey,
> >  I'm curious if there's a policy about what types of unclean
> > shutdowns 'e2fsck -p' can recover, vs. what the kernel will
> > automatically recover on mount. We're seeing that unclean shutdowns w/
> > data=journal,journal_csum frequently result in invalid checksums that
> > causes the kernel to abort recovery, while 'e2fsck -p' resolves the
> > issue non-interactively.
> 
> The kernel journal recovery will only replay the journal blocks.  It
> doesn't do any check and repair of filesystem correctness.  During and
> after e2fsck replays the journal blocks it still does basic correctness
> checking, and if an error is found it will fall back to a full scan.

hey Andreas!

Here's a log to clarify what I'm seeing:

$ sudo mount /dev/nbd0 mnt
JBD2: Invalid checksum recovering data block 517634 in log
JBD2: Invalid checksum recovering data block 517633 in log
[...]
JBD2: Invalid checksum recovering data block 517004 in log
JBD2: Invalid checksum recovering data block 4915712 in log
JBD2: recovery failed
EXT4-fs (nbd0): error loading journal
mount: /tmp/mnt: can't read superblock on /dev/nbd0.
$ sudo e2fsck -p /dev/nbd0 
/dev/nbd0: recovering journal
JBD2: Invalid checksum recovering block 517732 in log
JBD2: Invalid checksum recovering block 517519 in log
[...]
JBD2: Invalid checksum recovering block 4915712 in log
Journal checksum error found in /dev/nbd0
/dev/nbd0: Clearing orphaned inode 128798 (uid=0, gid=0, mode=040600, size=4096)
/dev/nbd0: Clearing orphaned inode 514998 (uid=0, gid=0, mode=040600, size=4096)
[...]
/dev/nbd0: Clearing orphaned inode 774759 (uid=0, gid=0, mode=0100600, size=4096)
/dev/nbd0 was not cleanly unmounted, check forced.
/dev/nbd0: 2127984/2195456 files (0.0% non-contiguous), 2963178/8780544 blocks


So is it correct to say that the checksum errors were identifying
filesystem correctness issues, and therefore e2fsck was needed to
correct them?

> > Driver for this question is that some Ubuntu installs set fstab's
> > passno=0 for the root fs - which I'm told is based on the assumption
> > that both kernel & e2fsck -p have parity when it comes to automatic
> > recovery - that's obviously does not appear to be the case - but I
> > wanted to confirm whether or not that is by design.
> 
> The first thing to figure out is why there are errors with the journal
> blocks.  That can cause problems for both the kernel and e2fsck journal
> replay.
> 
> Using data=journal is not a common option, so it is likely that the
> issue relates to this.

You're probably right - this issue is very easy to reproduce w/
data=journal,journal_checksum. I was never able to reproduce it
otherwise.

> IMHO, using data=journal could be helpful for
> small file writes and/or sync IO, but there have been discussions lately
> about removing this functionality.  If you have some use case that shows
> real improvements with data=journal, please let us know.

I don't have such a use case myself. The issue was reported by a user,
and it got me wondering about the basis for our passno=0 default.

  -dann
