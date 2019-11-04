Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20AFEF0DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 23:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbfKDW6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 17:58:47 -0500
Received: from fieldses.org ([173.255.197.46]:60204 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729122AbfKDW6q (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 17:58:46 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 36CE5ABE; Mon,  4 Nov 2019 17:58:46 -0500 (EST)
Date:   Mon, 4 Nov 2019 17:58:46 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Chuck Lever <chucklever@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/35] user xattr support (RFC8276)
Message-ID: <20191104225846.GA13469@fieldses.org>
References: <cover.1568309119.git.fllinden@amazon.com>
 <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
 <20191024231547.GA16466@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <18D2845F-27FF-4EDF-AB8A-E6051FA03DF0@gmail.com>
 <20191104030132.GD26578@fieldses.org>
 <358420D8-596E-4D3B-A01C-DACB101F0017@gmail.com>
 <20191104162147.GA31399@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104162147.GA31399@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:21:47PM +0000, Frank van der Linden wrote:
> On Mon, Nov 04, 2019 at 10:36:03AM -0500, Chuck Lever wrote:
> > 
> > Following the server's local file systems' mount options seems like a
> > good way to go. In particular, is there a need to expose user xattrs
> > on the server host, but prevent NFS clients' access to them? I can't
> > think of one.
> 
> Ok, that sounds fine to me - I'll remove the user_xattr export flag,
> and we had already agreed to do away with the CONFIGs.
> 
> That leaves one last item with regard to enabling support: the client side
> mount option. I assume the [no]user_xattr option should work the same as
> with other filesystems. What about the default setting?

Just checking code for other filesystems quickly; if I understand right:

	- ext4 has user_xattr and nouser_xattr options, but you get a
	  deprecation warning if you try to use the latter;
	- xfs doesn't support either option;
	- cifs supports both, with xattr support the default.

Not necessarily my call, but just for simplicity's sake, I'd probably
leave out the option and see if anybody complains.

> Also, currently, my code does not fail the mount operation if user xattrs
> are asked for, but the server does not support them. It just doesn't
> set NFS_CAP_XATTR for the server, and the xattr handler entry points
> eturn -EOPNOTSUPP, as they check for NFS_CAP_XATTR. What's the preferred
> behavior there?

getxattr(2) under ERRORS says:

	ENOTSUP
	      Extended attributes are not supported by the filesystem,
	      or  are disabled.

so I'm guessing just erroring out is clearest.

I also see there's an EOPNOTSUPP return in the nouser_xattr case in
ext4_xattr_user_get.  (errno(3) says ENOTSUP and EOPNOTSUPP are the same
value on Linux.)

--b.
