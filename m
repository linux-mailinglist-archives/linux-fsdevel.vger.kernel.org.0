Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B8F44546E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 15:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhKDOER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 10:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231230AbhKDOEQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 10:04:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95EC861168;
        Thu,  4 Nov 2021 14:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636034498;
        bh=3kGj4emvfkStl3tUFewfgTDOklbXpnlBPOLnV7Kg0NA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GTrI06yVMlxr3+TB2TPX3Tv6at4cqKdv8aPn0/yYODoEsl+e8ak+Nm01htbG4iTU/
         OqpU1Y8zapOEu5PdRgqn5vBp2e+JCbb6iu+qzpEIl/R52Yff9DopvEv+jWOqxMP7qy
         7xUOhjp80o2E9RYfQb/7C9NRC71JWS0vs2rXVyDWr75Cda3pwNseatjcoxEg5uo0ai
         rgSlXjyCuo0lDVg9qEoUix3hpkXXXOIoYnNiJkzphWneoqchwAVQeXnZpyK4ibn2Hx
         Qa/4XGXZQ3h1QyrNZzFT0kQZd6+0zYOEcPsoBz5o+HNMm0vvzAOjWMV1khRxA/8gaQ
         pZxPfmK/xFQow==
Message-ID: <ac100fa4d845c932fd4ce79027b821e80a9adbbc.camel@kernel.org>
Subject: Re: FUSE statfs f_fsid field
From:   Jeff Layton <jlayton@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Date:   Thu, 04 Nov 2021 10:01:37 -0400
In-Reply-To: <CAJfpegtNDk2QA5VF+28zo6ViagW5CSvhaajs5ePwbC0r7AF=AA@mail.gmail.com>
References: <88ba5bf0c8d5f08b9556499a9891543530471f03.camel@kernel.org>
         <CAJfpegtNDk2QA5VF+28zo6ViagW5CSvhaajs5ePwbC0r7AF=AA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 (3.42.0-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-11-04 at 14:50 +0100, Miklos Szeredi wrote:
> On Thu, 4 Nov 2021 at 14:27, Jeff Layton <jlayton@kernel.org> wrote:
> > 
> > Hi Miklos!
> > 
> > I was looking at an issue [1] with ceph-fuse and noticed that statfs
> > always reports f_fsid == 0 via statfs. Is there a reason for not letting
> > the driver fill out that field?
> 
> Hi Jeff,
> 
> I do not remember ever hearing of this field.   The statfs(2) man page
> doesn't make it very obvious either:
> 
>    The f_fsid field
> 
>        [...] The general idea is that f_fsid contains some random
> stuff  such  that
>        the  pair (f_fsid,ino) uniquely determines a file.  Some operating sys‐
>        tems use (a variation on) the device number, or the device number  com‐
>        bined  with  the  filesystem  type. [...]
> 
> I'd be somewhat concerned about allowing an unprivileged fuse server
> to fill this, as that may allow impersonation of another filesystem.
> 
> For a privileged fuse server I see no problem with allowing to set this.

Thanks, Miklos,

Good point about impersonation. I'll have to think about whether it's
worthwhile to change this for privileged servers.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>
