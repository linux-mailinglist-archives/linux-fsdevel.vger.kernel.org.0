Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90856839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2019 14:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfFZMHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jun 2019 08:07:21 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41719 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFZMHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:07:21 -0400
Received: by mail-oi1-f193.google.com with SMTP id g7so1696825oia.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2019 05:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoKKEjXBM4cP1xpPyuSdYmutpS68XoPtYXXMUeOUHus=;
        b=BE1k67+PDhgUxwhQPhM292nq3RWjlJ78w988APLdRtJ1f0gknaV7piRVybc1La1LEH
         je3YNDsDq7ol1lcPMlUhBzL4imJGaYH3iT+PD/yRm7TElXnA+o17e/tt/mbmHzzY/9gv
         jOOnTxytdMWwjVLSIvJ3moqeChxio32yz79b8rPcrMFHG1S7dFa/+KpRyEnc6itPQVky
         G1jdwHj4jZ2AT5VnzU8F+3Uo0X36gbiHsx5F9PYBaeIxQfrzlx2Kt01zf7OV8Q3dP/Lt
         LbD9X97X66SmsyG6mK6n9tiuE19akpOwN+ESJPttLwNcXj8N23CXrJQPBT/az5cwHTi+
         64pg==
X-Gm-Message-State: APjAAAUmLPzR6ha08Rtv8FKBHntVKIWHYhpeIFN4woyjrapphMKr/9J/
        /+fonRU2x2L5MfXCDFXH45tOHW8y/7uxEn9VvdCjA7xownI=
X-Google-Smtp-Source: APXvYqw4QK5tcXZHs/HO9eHJu+gJ3v4dClKZMuGx+LHaemFAfCrtURTYBuEj6ikRj8Zb72meGE0sdW/8QMUAfVyN6M0=
X-Received: by 2002:aca:b58b:: with SMTP id e133mr1518193oif.147.1561550840707;
 Wed, 26 Jun 2019 05:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190618144716.8133-1-agruenba@redhat.com> <20190624065408.GA3565@lst.de>
 <20190624182243.22447-1-agruenba@redhat.com> <20190625095707.GA1462@lst.de>
 <20190625105011.GA2602@lst.de> <20190625181329.3160-1-agruenba@redhat.com> <20190626060329.GA23666@lst.de>
In-Reply-To: <20190626060329.GA23666@lst.de>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 26 Jun 2019 14:07:09 +0200
Message-ID: <CAHc6FU7bk-BtWreHTLgokVPTxvVCrMvdn1c1qwt+Z+z5nuUmSg@mail.gmail.com>
Subject: Re: [PATCH] fs: Move mark_inode_dirty out of __generic_write_end
To:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 26 Jun 2019 at 08:04, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jun 25, 2019 at 08:13:29PM +0200, Andreas Gruenbacher wrote:
> > On Tue, 25 Jun 2019 at 12:50, Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > > That seems way more complicated.  I'd much rather go with something
> > > > like may patch plus maybe a big fat comment explaining that persisting
> > > > the size update is the file systems job.  Note that a lot of the modern
> > > > file systems don't use the VFS inode tracking for that, besides XFS
> > > > that includes at least btrfs and ocfs2 as well.
> > >
> > > I'd suggest something like this as the baseline:
> > >
> > > http://git.infradead.org/users/hch/xfs.git/shortlog/refs/heads/iomap-i_size
> >
> > Alright, can we change this as follows?
> >
> > [Also, I'm not really sure why we check for (pos + ret > inode->i_size)
> > when we have already read inode->i_size into old_size.]
>
> Yeah, you probably want to change that to old_size.  Your changes look
> good to me,
>
> Can you just take the patch over from here as you've clearly done more
> work on it and resend the whole series?

Ok, done. It's just the two patches; passes xfstests for xfs and gfs2,
the current users.

Darrick, can you please push this in the next merge window as "usual"?

Thanks,
Andreas
