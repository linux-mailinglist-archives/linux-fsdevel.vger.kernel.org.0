Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33593034C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbhAZF1I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbhAZBxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:53:45 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3604C0617AB
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 17:53:01 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a109so14840196otc.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 17:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tyhicks-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xxAVgjAWeUTEVk1HKoPhPhQyjhCFuGz73HIshLBYon4=;
        b=riPm+/XUbjsAldf1p8jPot+uVTxVczaBXz0aEQG7pvqrNi1989sRc/7cbedqpPJPx9
         nzsf66cprhMZT2cJbOEQAnxvi48Dds+OfeLAYrGgEbRez4WPjZ7WxbOHuJSganDrzCSi
         Y/15cdUHCTLPzgEzBOxIy8h27TyTOwjjBZpGjsievDj3LuyRVXuBDwo3n1ZT3pXS2N7V
         2vlii1CFP1R7IoYfng2lqfkebgwsEVGHnh6Rd/Ok01UoeEZjeakwah+DQcwmHUu1F+uF
         AeglkbPIhIr6BMfzKfqBgePaBlZrhitoSQuxrRHN8B3xZo/nro6oNYhHlsOgx0FMwri0
         b7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xxAVgjAWeUTEVk1HKoPhPhQyjhCFuGz73HIshLBYon4=;
        b=InHutj8mI3RDjohAbw35KByPzQ7DonpqGNZi76lDzEIrvus9f+J2iA6DPtpXHQJK//
         rk+i0GnLwq4WENFa2Mq7gxo4AkKPRYSa24+CCuQuHpP3DWeqtWTLJVebqnIi2gTlmM//
         LiSqVUbbRloW6/tEhH42nHmIqaC1fhsXLtc3dffNYukmW9lzQD0ojE1sGxiWBjWis2LS
         nyqeReVvIBYOfZlDrTLFf1OBnhotn6142yxUqy2RoKAqHoksUdXicnCJanU3JpouF22t
         UDdpLL21hhxsb2dpugMAt4Cidl4rk5w8eL5MlasPb7C93aGDzhGQVur8AGB0Jq7eqvA0
         pLQw==
X-Gm-Message-State: AOAM531ly5flK5Ky9Ayd67P5Xili5Y4lnGbruLQW1Kgn/D6IYHu/kRrE
        cPNF87TF+X4I+hAipn/Nl6qhtw==
X-Google-Smtp-Source: ABdhPJwmBKO2BxEJEdzwgX6J9ip8RQTuHi2fV5X10UwC0NNCZWDYPMwTCr8sBOgxExy4ZelLMj18eA==
X-Received: by 2002:a05:6830:1545:: with SMTP id l5mr2484767otp.61.1611625981223;
        Mon, 25 Jan 2021 17:53:01 -0800 (PST)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net. [162.237.133.238])
        by smtp.gmail.com with ESMTPSA id y10sm2846742ooy.11.2021.01.25.17.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 17:53:00 -0800 (PST)
Date:   Mon, 25 Jan 2021 19:52:59 -0600
From:   Tyler Hicks <code@tyhicks.com>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 1/2] ecryptfs: fix uid translation for setxattr on
 security.capability
Message-ID: <20210126015259.GC81247@sequoia>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
 <20210119162204.2081137-2-mszeredi@redhat.com>
 <20210122183141.GB81247@sequoia>
 <CAOssrKd-P=4n-nzhjnvnChbCkcrAaLC=NjmCTDRHtzRtzJaU-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOssrKd-P=4n-nzhjnvnChbCkcrAaLC=NjmCTDRHtzRtzJaU-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-01-25 14:25:38, Miklos Szeredi wrote:
> On Fri, Jan 22, 2021 at 7:31 PM Tyler Hicks <code@tyhicks.com> wrote:
> >
> > On 2021-01-19 17:22:03, Miklos Szeredi wrote:
> > > Prior to commit 7c03e2cda4a5 ("vfs: move cap_convert_nscap() call into
> > > vfs_setxattr()") the translation of nscap->rootid did not take stacked
> > > filesystems (overlayfs and ecryptfs) into account.
> > >
> > > That patch fixed the overlay case, but made the ecryptfs case worse.
> >
> > Thanks for sending a fix!
> >
> > I know that you don't have an eCryptfs setup to test with but I'm at a
> > loss about how to test this from the userns/fscaps side of things. Do
> > you have a sequence of unshare/setcap/getcap commands that I can run on
> > a file inside of an eCryptfs mount to verify that the bug exists after
> > 7c03e2cda4a5 and then again to verify that this patch fixes the bug?
> 
> You need two terminals:
> $ = <USER>
> # = root
> 
> $ unshare -Um
> $ echo $$
> <PID>
> # echo "0 1000 1" > uid_map
> # cp uid_map gid_map
> # echo 1000 2000 1 >> uid_map
> # echo 2000 3000 1 >> uid_map
> # cat uid_map > /proc/<PID>/uid_map
> # cat gid_map > /proc/<PID>/gid_map
> $ mkdir ~/tmp ~/mnt
> $ mount -t tmpfs tmpfs ~/tmp
> $ pwd
> /home/<USER>
> # nsenter -t <PID> -m
> # [setup ecryptfs on /home/<USER>/mnt using /home/<USER>/tmp]
> $ cd ~/mnt
> $ touch test
> $ /sbin/setcap -n 1000 cap_dac_override+eip test
> $ /sbin/getcap -n test
> test = cap_dac_override+eip [rootid=1000]
> 
> Without the patch, I'm thinking that it will do a double translate and
> end up with rootid=2000 in the user namespace, but I might well have
> messed it up...
> 
> Let me know how this goes.

Spot-on instructions. Thank you for taking the time to provide the
steps.

I was able to repro the bug and verify the fix. The change visually
looks good to me and it passed through the eCryptfs regression tests.

I've pushed it to the eCryptfs next branch and I plan to submit it to
Linus on Thursday. Thanks again!

Tyler

> 
> Thanks,
> Miklos
> 
