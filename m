Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A58A771E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 00:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfICWi0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 18:38:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45947 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725882AbfICWi0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 18:38:26 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-96.corp.google.com [104.133.0.96] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x83McFRu018715
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Sep 2019 18:38:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5DF7442049E; Tue,  3 Sep 2019 18:38:15 -0400 (EDT)
Date:   Tue, 3 Sep 2019 18:38:15 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>, Qian Cai <cai@lca.pw>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
Message-ID: <20190903223815.GH2899@mit.edu>
References: <1567523922.5576.57.camel@lca.pw>
 <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <20190903211747.GD2899@mit.edu>
 <CABeXuvoYh0mhg049+pXbMqh-eM=rw+Ui1=rDree4Yb=7H7mQRg@mail.gmail.com>
 <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0AcPzuGeNFMW=ymO0wH_cmgnynLGYXGjqyrQb65o6aOw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 03, 2019 at 11:48:14PM +0200, Arnd Bergmann wrote:
> I think the warning as it was intended makes sense, the idea
> was never to warn on every inode update for file systems that
> cannot handle future dates, only to warn when we
> 
> a) try to set a future date
> b) fail to do that because the space cannot be made available.

What do you mean by "try to set a future date"?  Do you mean a trying
to set a date after 2038 (when it can no longer fit in a signed 32-bit
value)?  Because that's not what the commit is currently doing.....

> I would prefer to fix it on top of the patches I already merged.
> 
> Maybe something like:
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9e3ae3be3de9..5a971d1b6d5e 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -835,7 +835,9 @@ do {
>                                  \
>                 }
>          \
>         else    {\
>                 (raw_inode)->xtime = cpu_to_le32(clamp_t(int32_t,
> (inode)->xtime.tv_sec, S32_MIN, S32_MAX));    \
> -               ext4_warning_inode(inode, "inode does not support
> timestamps beyond 2038"); \
> +               if (((inode)->xtime.tv_sec != (raw_inode)->xtime) &&     \
> +                   ((inode)->i_sb->s_time_max > S32_MAX))
>          \
> +                       ext4_warning_inode(inode, "inode does not
> support timestamps beyond 2038"); \
>         } \
>  } while (0)

Sure, that's much less objectionable.

> However, I did expect that people might have legacy ext3 file system
> images that they mount, and printing a warning for each write would
> also be wrong for those.

I guess I'm much less convinced that 10-15 years from now, there will
be many legacy ext3 file systems left.  Storage media doesn't last
that long, and if file systems get moved around, e2fsck will be run at
least once, and so adding some e2fsck-time warnings seems to be a
better approach IMHO.

						- Ted
