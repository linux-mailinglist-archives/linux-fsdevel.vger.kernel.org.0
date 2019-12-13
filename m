Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A525F11E0C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 10:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLMJa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 04:30:28 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35603 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfLMJa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:30:27 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so1728540iol.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 01:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VbLwtEEii+eZr02TAunYp0r9vwXzyFh2PvhryUpIvu0=;
        b=AZz89padS3ilULxI3+ozr300rmWfzzY1kN8fVffLYF4fQ5tWQXv8YlmkSnJ48Xmya4
         45uwmFCQHFOSWHVRCRVGXS90qtIHSfbfPZF/PIMUQwY6QJnniGpn3Smza5HPBVWcvGje
         9yz7fNP6u3GFZji5pYEWMCuwskl2FiPYRj0+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VbLwtEEii+eZr02TAunYp0r9vwXzyFh2PvhryUpIvu0=;
        b=AvH05MPRcsyFQ4Ey+AZPoBOdM/7mnGT7zskXg1Ntz9QArLS1eAjLuHmqz9psud1LgY
         TAjuZJuu35kOohH170/8ib09nHXXiJIypr7fZpu/iIeP5DdCkB/dsaHy0YT0yAJ5vVie
         sd97d0b/Id/NDWMxrDib24Qtj7LpMdDYF3MKIb4q9km2txoBBx5M8X4PxszqxYiTX9I2
         qUQRRn4kRs+kmSi9Q6HLNWfT/5FHoCESurIf+N8+tDP1unaWkZKN0uaYsr44JhS7usvv
         rtMs0irGXcRSHJ46RAH+FVbYJgyzk4hUJ/SQ3Cf/Qnz0U8nvG4ntpUIwcyaI42lDu47M
         wxlw==
X-Gm-Message-State: APjAAAXaMLJUBg9OCklNgoaIHRF9YHRbNwKSs72N4lQy42jDcLKi8zE5
        1FTtG96si3rT9N07yEbswtsdpq7uW491oAY06MJwCg==
X-Google-Smtp-Source: APXvYqzwM8OVdjfc6nPVJOOHNFpeyNvYtMcf+cL5pDaYSQBuwa61eiV16PuC1ggtwJieCU4wJrSqxFkFc28L62I7NLM=
X-Received: by 2002:a5d:8846:: with SMTP id t6mr5453453ios.63.1576229425684;
 Fri, 13 Dec 2019 01:30:25 -0800 (PST)
MIME-Version: 1.0
References: <20191212145042.12694-1-labbott@redhat.com> <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com> <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
 <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com> <20191212213609.GK4203@ZenIV.linux.org.uk>
 <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com>
In-Reply-To: <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Dec 2019 10:30:14 +0100
Message-ID: <CAJfpegu+mMVm8vNMZhUVveWKRz4VgcMip7vC4iBhZahWbk=qPw@mail.gmail.com>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 10:15 AM Miklos Szeredi <miklos@szeredi.hu> wrote:

> I have sent patches for the above numerous times, all been ignored by
> DavidH and Al.  While this seems minor now, I think getting this
> interface into a better shape as early as possible may save lots more
> headaches later...

Refs:

https://lore.kernel.org/linux-fsdevel/20191128155940.17530-12-mszeredi@redhat.com/
https://lore.kernel.org/linux-fsdevel/20191128155940.17530-13-mszeredi@redhat.com/
https://lore.kernel.org/linux-fsdevel/20190619123019.30032-7-mszeredi@redhat.com/
etc...

Thanks,
Miklos
