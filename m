Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CCD407F78
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Sep 2021 20:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbhILSpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Sep 2021 14:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234185AbhILSpE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Sep 2021 14:45:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B6EC36101B;
        Sun, 12 Sep 2021 18:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631472230;
        bh=myVtFVE8GdckTLIYtqfXRD/WFkXdy8a5GR9YaI+qc8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzfX5ryKHbaA93jjvwzGg8MUR3mw9puZ4/nZgkdqizh6CxjtKS/i0878Nz2ysK3og
         ubLYGX8C934HU+nxP4Fw4axMt8FFw8U0l8y5wHtbwLu1cHY+q07NRhdF8PTHkEkaaa
         zZkG3b9SzFE+lK+/iSiBiAH74z24ErCvSCUsDzuJw8uBrPEX9SFnkEBOGQrQnm+wWy
         y80UYonc1YJ/HbNS5569VWM43aagGrCIsqi7ySG5VgFblzEBh4N8RsOFhi5fyGwPTy
         XyDf/e5SDhEwbghMfxf1ctfpFCal6OM7VY0XqGuafLZOEYq4cineigLDmcwcPGQhfA
         cioogxwj+yoRQ==
Received: by pali.im (Postfix)
        id 7E0FE87A; Sun, 12 Sep 2021 20:43:47 +0200 (CEST)
Date:   Sun, 12 Sep 2021 20:43:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Marcos Mello <marcosfrm@gmail.com>, ntfs3@lists.linux.dev,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ntfs3 mount options
Message-ID: <20210912184347.zrb44vpc3lfyy3px@pali>
References: <CAJZVDJAJa+j=hx2JswdvS35t9VU6TYF3uDZnzZ5hhtSzo9E-LA@mail.gmail.com>
 <CAC=eVgQKOdNbyDf2Qf=O9SnG=6nAGZ-nyuwOosf7YW5R3xbVLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC=eVgQKOdNbyDf2Qf=O9SnG=6nAGZ-nyuwOosf7YW5R3xbVLw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Friday 10 September 2021 15:19:16 Kari Argillander wrote:
> 10.09.2021 14.23 Marcos Mello (marcosfrm@gmail.com) wrote:
> > Hi, sorry email you directly, but this mailing list thing is cryptic
> > to me.
> 
> I CC also lists to this so now everyone knows. Also CC couple
> others who might be interested to talk about this.
> 
> > I was reading your patches cleaning up ntfs3 documentation and
> > realized some mount options diverge from NTFS-3G. This will make
> > udisks people unhappy.

If you still have to specify which fs driver want to use (ntfs, ntfs-3g,
ntfs3). So each software needs to be adjusted if want to start using
different fs driver even when mount options are same. So I think there
are no big issues that different fs driver are using different mount
options.

> This is true. They also diverge from the current NTFS driver. We have
> talk about it a little bit and before ntfs driver can go out from kernel we
> need to support those flags or at least some. udisk currently does only
> support NTFS-3G and it does not support kernel ntfs driver. So nothing
> will change.
> 
> I also agree that we should check mount options from ntfs-3g and maybe
> implement them in. Maybe we can just take some mount options with
> deprecated and print that this option is meant to use with ntfs-3g please
> note that this is kernel ntfs3 driver or something. It would still work for
> users. Ntfs-3g contains imo lot of unnecessary flags. Kernel community
> would probably not want to maintain so large list of different options.

Mount options which makes sense could be implemented. Just somebody
needs to do it.

> Ntfs-3g group also has acounted problems because they say that you
> should example use "big_writes", but not everyone does and that drops
> performance. Driver should work good way by default.

I agree. Mount option which is just a hack because of some poor
implementation should not be introduced. Instead bugs should be fixed.
Also it applies for "performance issues" which do not change behavior of
fs operations (i.e. read() / write() operations do same thing on raw
disk).

> And only if there
> is really demand there should be real mount option. But like I said, maybe
> we should add "fake" ntfs-3g options so if some user change to use ntfs3
> it will be pretty painless.

This really should not be in kernel. You can implement userspace mount
helper which translates "legacy" ntfs-3g options into "correct" kernel
options. /bin/mount already supports these helpers / wrappers... Just
people do not know much about them.

> > NTFS-3G options:
> > https://github.com/tuxera/ntfs-3g/blob/edge/src/ntfs-3g.8.in
> >
> > UDISKS default and allowed options:
> > https://github.com/storaged-project/udisks/blob/master/data/builtin_mount_options.conf
> >
> > For example, windows_names is not supported in ntfs3 and
> > show_sys_files should probably be an alias to showmeta.
> 
> Imo windows_names is good option. There is so many users who just
> want to use this with dual boot. That is why I think best option would
> be windows_compatible or something. Then we do everything to user
> not screw up things with disk and that when he checks disk with windows
> everything will be ok. This option has to also select ignore_case.
> 
> But right now we are horry to take every mount option away what we won't
> need. We can add options later. And this is so early that we really cannot
> think so much how UDSIKS threats ntfs-3g. It should imo not be problem
> for them to also support for ntfs3 with different options.

This is something which needs to be handled and fixed systematically. We
have at least 5 filesystems in kernel (bonus question, try to guess
them :D) which support some kind/parts of "windows nt" functionality.
And it is pain if every one fs would use different option for
similar/same functionality.

> > Also, is NTFS-3G locale= equivalent to ntfs3 nls=?
> 
> Pretty much. It is now called iocharset and nls will be deprecated.
> This is work towards that every Linux kernel filesystem driver which
> depends on this option will be same name. Ntfs-3g should also use
> it.

iocharset= is what most fs supports. Just few name this option as nls=
and for consistency I preparing patches which adds iocharset= alias for
all kernel filesystems. nls= (for those few fs) stay supported as legacy
alias for iocharset=.

Kari, now I'm thinking about nls= in new ntfs3 kernel driver. It is
currently being marked as deprecated. Does it really make sense to
introduce in new fs already deprecated option? Now when final linux
version which introduce this driver was not released yet, we can simply
drop (= do not introduce this option). But after release, there would be
no easy way to remove it. Adding a new option can be done at any time
later easily...

> > Thank you a lot for all the work put into ntfs3!
> >
> > Marcos
