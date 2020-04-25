Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3CD1B84EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDYIyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgDYIyh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:54:37 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15007C09B04A;
        Sat, 25 Apr 2020 01:54:37 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id o127so13080119iof.0;
        Sat, 25 Apr 2020 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpUgeIr/Sb1mNoyDa9dRYqt5Z8fi7wWrSG5Np2rqPKs=;
        b=rSqYBD0+QgTGF1wshchySMo/sX09uAJj81nvpjgdWbL8MUM/1NUH+CpjTCDt7g/0xF
         Qtg7w2TemG/FlXVH0Ss5kdO0YKE5l0SBV2qJjJT1XOVcKdjlLzUsgQ8tlZjQ7OTxJSgd
         9vVbePNHtgfm775LuR0iS8q+QFfU0ARTI12mokYqqqYDkSYswJetHI8RTurWUAt7gvty
         dd/XEB5CcTlQ8W+68pDZtAnRon3+YNx83tFL5s+XQUWCzcqxEhwGPUZc13p39sTHdB0K
         BpGTlrylopCQZy4rqj6cwxyT6CAYjFP55PIELWhpW4XyJHlsgQPwkr4dPrmTZHukbRkb
         KXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpUgeIr/Sb1mNoyDa9dRYqt5Z8fi7wWrSG5Np2rqPKs=;
        b=kLIbJAe7jAhcgjZb5BQ/LQX+CKpneAUzQUdJlSY5PSxJWl1Qk4AavxEPWgw0q23bZV
         VF08LAgneBBHt0fOJyYvpW/HjuILd6qZDZgfNrH5YX4xp5FZFuU3TgKSIeeZT7wuOu54
         ywA+bbrenS3xnuh/8O27FMAGgLo/z3PsFAiOnTMbvgLNPX8pA8hQB4XiZt7oDkJMQjJE
         M/teKo9cyfDCayH5lISghi0CWw8yDidEBMvgfH+uKe0VHZsm9N+69BYv+hqN/6XrH9YP
         A+pmx8ZLxe2F/cjoEOnmjDFlfdG0Bt8eEOamGgKTCmpGce+4lORSr1hW5k9HmuanPac7
         v87g==
X-Gm-Message-State: AGi0PuZ0fQTYUtGYee7ymIUXcp7gm2EC6E0XeBylxhiyiCwkppqTsCrw
        Q1Ts6YInE7d25dMhlcdj5yKLLHpcngsk4MBmX3I=
X-Google-Smtp-Source: APiQypL58IIi642njWgZmKReL3wevwHQsLNJKMGmGJe80b9V3wEY9QxGzn5auiFY3Fy8fNdf/Cf7CqjRwNog5VD3dpc=
X-Received: by 2002:a02:c9cb:: with SMTP id c11mr11389577jap.93.1587804876312;
 Sat, 25 Apr 2020 01:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587555962.git.riteshh@linux.ibm.com> <39b4bf94f6723831a9798237bb1b4ae14da04d98.1587555962.git.riteshh@linux.ibm.com>
In-Reply-To: <39b4bf94f6723831a9798237bb1b4ae14da04d98.1587555962.git.riteshh@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 25 Apr 2020 11:54:25 +0300
Message-ID: <CAOQ4uximFUoL3-ovymF=jX=w-xy8Kf-B9=eJvJ9TZG=0spxwnQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] overlayfs: Check for range bounds before calling i_op->fiemap()
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 23, 2020 at 1:48 PM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> Underlying fs may not be able to handle the length in fiemap
> beyond sb->s_maxbytes. So similar to how VFS ioctl does it,
> add fiemap_check_ranges() check in ovl_fiemap() as well
> before calling underlying fs i_op->fiemap() call.
>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  fs/overlayfs/inode.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
> index 79e8994e3bc1..9bcd2e96faad 100644
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -455,16 +455,21 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
>         int err;
>         struct inode *realinode = ovl_inode_real(inode);
>         const struct cred *old_cred;
> +       u64 length;

To be more clear, I would call that reallen, but apart from that, you may add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.
