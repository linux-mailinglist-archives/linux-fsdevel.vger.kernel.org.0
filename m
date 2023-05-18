Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B3570836A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbjEROBM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjEROBL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 10:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1ED10E5;
        Thu, 18 May 2023 07:01:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0988561561;
        Thu, 18 May 2023 14:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22874C433D2;
        Thu, 18 May 2023 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684418462;
        bh=4Im3v0IgUYIeUV6N/ZeLmE9WDFNsWEqr0RUZml2Q5/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+wm02X+LoomXyftqhOFhQZD69cBSUgk/6Ligw+Qe7ZvOOhrUO4Ea5O85zvIydwDZ
         aX4rEjeel0BD52p3R6HRuq6tcPW14tEVhoWlBeqOHPLaIlWnJrpQdXmAl9DBuHYS4D
         /2QmC7dLUldYb2D1DqBJycfPLgP9OvnBMLpFQtPfZjbZN6uixEATGZN03ky6DQjyNT
         w+oIOTy+K7XiJyjABLToRlAqoVdE0r0mcIVTZEassNa210h3Nc2rMlFQMRSKM8JjJm
         m7tvk7Kf91/9+Qvm7Yxs71SN7WAYnQ0JUyxeZTzargOpYG3k0lye9F6ZdpiDbJ57KN
         zZkrN2epRjd5w==
Date:   Thu, 18 May 2023 16:00:57 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.39
Message-ID: <20230518-gejagt-vervollkommnen-01451a4325b9@brauner>
References: <20230517112242.3rubpxvxhzsc4kt2@ws.net.home>
 <20230517-mahnmal-setzen-37937c35cf78@brauner>
 <20230518102316.f6s6v6xxnicx646r@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230518102316.f6s6v6xxnicx646r@ws.net.home>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 12:23:16PM +0200, Karel Zak wrote:
> On Wed, May 17, 2023 at 03:48:54PM +0200, Christian Brauner wrote:
> > This is a very exciting release! There's good reason for us to be happy
> > imho. This is the first release of util-linux with comprehensive support
> > for the new mount api which is very exciting.
> 
> We will see how many things in libmount and kernel are not ready ;-)

Yeah, I think we will indeed...
So, I think we need to port overlayfs to the new mount api because of
https://github.com/util-linux/util-linux/issues/1992#issuecomment-1486475153

> 
> > A part of that is of course the support for idmapped mounts and the
> > ability to recursively change mount properties, i.e., idempotently
> > change the mount properties of a whole mount tree.
> > 
> > It's also great to see support for disk sequence numbers via the
> > BLKGETDISKSEQ ioctl and the port to util-linux to rely on
> 
> BLKGETDISKSEQ is supported in the blockdev command only.
> 
> Lennart has also idea to support it in libmount to verify devices
> before the filesystem is attached to VFS. 
> 
> https://github.com/util-linux/util-linux/issues/1786
> 
> That's something we can work on in the next release.

Yeah, I remember discussing that. Though that doesn't eliminate all
races as we discussed on the thread and I plan to implement what I said in
https://github.com/util-linux/util-linux/issues/1786#issuecomment-1410515391
rather soon and talked about at LSFMM last week.

> 
> > statx(AT_STATX_DONT_SYNC|AT_NO_AUTOMOUNT) to avoid tripping over
> > automounts or hung network filesystems as we just recently discussed
> > this!
> > 
> > Thanks for working on this and hopefully we can add the missing pieces
> > of the new mount api in the coming months!
> 
> I would like to make the v2.40 development cycle shorter. The v2.39
> cycle was excessively long and large.

Yeah, but that was kinda expected given the switch to the new mount api.
I mean, after I did the initial support to get idmapped mounts working
in there you still had to port all the rest of libmount...
