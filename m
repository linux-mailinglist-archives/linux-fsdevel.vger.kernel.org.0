Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033E63C88CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbhGNQk5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:40:57 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:46410 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229595AbhGNQk5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:40:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UfnzWK-_1626280681;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UfnzWK-_1626280681)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Jul 2021 00:38:03 +0800
Date:   Thu, 15 Jul 2021 00:38:00 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Rafa?? Mi??ecki <zajec5@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YO8S6IK8/WsInasF@B-P7TQMD6M-0146.local>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Rafa?? Mi??ecki <zajec5@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com>
 <YO755O8JnxG44YaT@kroah.com>
 <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
 <20210714161352.GA22357@magnolia>
 <YO8OP7vzHIuKvO6X@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO8OP7vzHIuKvO6X@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On Wed, Jul 14, 2021 at 05:18:07PM +0100, Christoph Hellwig wrote:
> On Wed, Jul 14, 2021 at 09:13:52AM -0700, Darrick J. Wong wrote:
> > Porting to fs/iomap can be done after merge, so long as the ntfs3
> > driver doesn't depend on crazy reworking of buffer heads or whatever.
> > AFAICT it didn't, so ... yes, my earlier statements still apply: "later
> > as a clean up".
> 
> I on the other hand hate piling up mor of this legacy stuff, as it tends
> to not be cleaned up by the submitted.  Example: erofs still hasn't
> switched to iomap despite broad claims, also we still have a huge

Just some word of this, I've been always actively developing and
converting legacy stuffs to new APIs these years, such as new mount
APIs, xarray, which can be seen by changelog compared with other
filesystems. The iomap buffered I/O stuff is mainly because it
doesn't support tailing-packing inline, although which has been
requested for people who cares more about storage itself, like:
https://lore.kernel.org/lkml/3dbeff43-0905-3421-4652-41b7a935f3c1@gmail.com/
And I can also show the benefits by using tailing-packing inline
by taking Linux source code tree (many random tail blocks) as an
example...

I'm now working on this tailing-packing inline iomap support as
well. But Anyway, erofs didn't use buffer head in the beginning
since I can see some flew of buffer head approach itself, it just
works on raw bio and page cache interfaces for now.

Thanks,
Gao Xiang

> backlog in the switch to the new mount API.
