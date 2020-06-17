Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7961FD43A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 20:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgFQSSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 14:18:17 -0400
Received: from fieldses.org ([173.255.197.46]:44718 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbgFQSSQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:18:16 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 223B79236; Wed, 17 Jun 2020 14:18:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 223B79236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592417896;
        bh=KtmAiOpxjonJm6p2XrJ3KhXpfJP9LvW18NUJP3OZN6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PnLv37V+jqA2q+2rUJ6i2wsqsMKU0ipsX7gKn+bGR+Zwgu86X1Cf3WxUdSDSULf+I
         wFbxEnE/dedS4Xwg0i0TdBH4MHajsqZhKUdM8cyIHR72IGXDdZE5LhD7Kl0wljv0D9
         WjUbu35AH6Cm9EtZMnmTlb141jq7RuAXr/G0hQr8=
Date:   Wed, 17 Jun 2020 14:18:16 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200617181816.GA18315@fieldses.org>
References: <20200616202123.12656-1-msys.mizuma@gmail.com>
 <20200617080314.GA7147@infradead.org>
 <20200617155836.GD13815@fieldses.org>
 <24692989-2ee0-3dcc-16d8-aa436114f5fb@sandeen.net>
 <20200617172456.GP11245@magnolia>
 <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f0df756-4f71-9d96-7a52-45bf51482556@sandeen.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:55:24PM -0500, Eric Sandeen wrote:
> On 6/17/20 12:24 PM, Darrick J. Wong wrote:
> > On Wed, Jun 17, 2020 at 12:14:28PM -0500, Eric Sandeen wrote:
> >>
> >>
> >> On 6/17/20 10:58 AM, J. Bruce Fields wrote:
> >>> On Wed, Jun 17, 2020 at 01:03:14AM -0700, Christoph Hellwig wrote:
> >>>> On Tue, Jun 16, 2020 at 04:21:23PM -0400, Masayoshi Mizuma wrote:
> >>>>> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> >>>>>
> >>>>> /proc/mounts doesn't show 'i_version' even if iversion
> >>>>> mount option is set to XFS.
> >>>>>
> >>>>> iversion mount option is a VFS option, not ext4 specific option.
> >>>>> Move the handler to show_sb_opts() so that /proc/mounts can show
> >>>>> 'i_version' on not only ext4 but also the other filesystem.
> >>>>
> >>>> SB_I_VERSION is a kernel internal flag.  XFS doesn't have an i_version
> >>>> mount option.
> >>>
> >>> It probably *should* be a kernel internal flag, but it seems to work as
> >>> a mount option too.
> >>
> >> Not on XFS AFAICT:
> >>
> >> [600280.685810] xfs: Unknown parameter 'i_version'
> > 
> > Yeah, because the mount option is 'iversion', not 'i_version'.  Even if
> 
> unless you're ext4:
> 
> {Opt_i_version, "i_version"},
> 
> ok "iversion" is what mount(8) takes and translates into MS_I_VERSION (thanks Darrick)
> 
> # strace -vv -emount mount -oloop,iversion fsfile mnt
> mount("/dev/loop0", "/tmp/mnt", "xfs", MS_I_VERSION, NULL) = 0
> 
> FWIW, mount actually seems to pass what it finds in /proc/mounts back in on remount for ext4:
> 
> # strace -vv -emount mount -o remount mnt
> mount("/dev/loop0", "/tmp/mnt", 0x55bfcbdca150, MS_REMOUNT|MS_RELATIME, "seclabel,i_version,data=ordered") = 0
> 
> but it still looks unhandled on remount.  Perhaps if /proc/mounts exposed
> "iversion" (not "i_version") then mount -o remount would DTRT.

I'd rather just eliminate the option, to the extent possible.

It was only ever a mount option since it caused a performance regression
in some filesystems, but I *think* that was addressed by Jeff Layton's
work (f02a9ad1f15d "fs: handle inode->i_version more efficiently").

XFS in particular is just using this flag to tell knfsd that it should
use i_version.  I don't think it was really intended for userspace to be
able to turn this off.

--b.
