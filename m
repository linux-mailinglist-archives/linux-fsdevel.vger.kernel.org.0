Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 078F01233D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 18:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfLQRq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 12:46:57 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48172 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfLQRq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:46:57 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ihGvs-0001VN-Ue; Tue, 17 Dec 2019 17:46:53 +0000
Date:   Tue, 17 Dec 2019 17:46:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
Message-ID: <20191217174652.GB4203@ZenIV.linux.org.uk>
References: <20191212145042.12694-1-labbott@redhat.com>
 <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com>
 <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
 <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com>
 <20191212213609.GK4203@ZenIV.linux.org.uk>
 <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 10:15:03AM +0100, Miklos Szeredi wrote:

> Just need a flag in fc indicating if this option comes from the old interface:
> 
>          if (strcmp(param->key, "source") == 0)
>                  return -ENOPARAM;
>          /* Just log an error for backwards compatibility */
>          errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name,
> param->key);
>          return fc->legacy ? 0 : -ENOPARAM;

	What the hell for?  Just have a separate ->parse_param() instance
for "promiscuous fs, will accept bullshit options" and have such filesystems
use it explicitly.  With default being not that, but rejecting unknowns.
