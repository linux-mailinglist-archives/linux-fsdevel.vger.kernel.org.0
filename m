Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F04E3EF1A7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 01:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfKEAGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 19:06:24 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:41368 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfKEAGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 19:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1572912382; x=1604448382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wHCb0DOmdBzYoKDMkMD9QuuVs7vQesj/JneQ/kip5P0=;
  b=cJ3AIfAzMC61+Ffp4ks5MVXmYsrbl++/DFXL/TAcorACzR2wqwSM9VXx
   NIyov8pEKZtrRtqN4bgP/yXwTJ7QfhKhuccbpY+W4Mob0jgWFEAVEOd4A
   dUtIwOuJQbkrhHivFa7/Q+rfAUjKzoerBojmAu9091ZH/wvlyyWq08E5y
   Y=;
IronPort-SDR: QprfF84xfmk4eZzeW+mz6/8I8dCVQESW9VHPlMivnWoT6AiljdD092VXBuaIiFbW7mz7WoN9xV
 wDAktcRJ3Q0w==
X-IronPort-AV: E=Sophos;i="5.68,268,1569283200"; 
   d="scan'208";a="4107701"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Nov 2019 00:06:13 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS id 9DDD9A17C0;
        Tue,  5 Nov 2019 00:06:12 +0000 (UTC)
Received: from EX13D11UEE002.ant.amazon.com (10.43.62.113) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 5 Nov 2019 00:06:12 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D11UEE002.ant.amazon.com (10.43.62.113) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 5 Nov 2019 00:06:11 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Tue, 5 Nov 2019 00:06:11 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id B0006C8354; Tue,  5 Nov 2019 00:06:11 +0000 (UTC)
Date:   Tue, 5 Nov 2019 00:06:11 +0000
From:   Frank van der Linden <fllinden@amazon.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Chuck Lever <chucklever@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/35] user xattr support (RFC8276)
Message-ID: <20191105000352.GA24610@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
 <9CAEB69A-A92C-47D8-9871-BA6EA83E1881@gmail.com>
 <20191024231547.GA16466@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <18D2845F-27FF-4EDF-AB8A-E6051FA03DF0@gmail.com>
 <20191104030132.GD26578@fieldses.org>
 <358420D8-596E-4D3B-A01C-DACB101F0017@gmail.com>
 <20191104162147.GA31399@dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com>
 <20191104225846.GA13469@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191104225846.GA13469@fieldses.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 04, 2019 at 05:58:46PM -0500, Bruce Fields wrote:
> Just checking code for other filesystems quickly; if I understand right:
> 
> 	- ext4 has user_xattr and nouser_xattr options, but you get a
> 	  deprecation warning if you try to use the latter;
> 	- xfs doesn't support either option;
> 	- cifs supports both, with xattr support the default.
> 
> Not necessarily my call, but just for simplicity's sake, I'd probably
> leave out the option and see if anybody complains.

Sounds good, I'll go with that.
> 
> > Also, currently, my code does not fail the mount operation if user xattrs
> > are asked for, but the server does not support them. It just doesn't
> > set NFS_CAP_XATTR for the server, and the xattr handler entry points
> > eturn -EOPNOTSUPP, as they check for NFS_CAP_XATTR. What's the preferred
> > behavior there?
> 
> getxattr(2) under ERRORS says:
> 
> 	ENOTSUP
> 	      Extended attributes are not supported by the filesystem,
> 	      or  are disabled.
> 
> so I'm guessing just erroring out is clearest.
> 
> I also see there's an EOPNOTSUPP return in the nouser_xattr case in
> ext4_xattr_user_get.  (errno(3) says ENOTSUP and EOPNOTSUPP are the same
> value on Linux.)

Sure. So, to recap, here's what I'll do:

* Remove the CONFIG options - enable the code by default.
* Server side:
	* Remove the export file option to not export extended attributes
* Client side:
	* Always probe user xattr support, and use it when available
	  (returning EOPNOTSUPP, as expected, for all xattr syscalls if
	   it is not available).

Thanks for the feedback so far - much appreciated. I'll submit the separate
client and server patch sets this week.

- Frank
