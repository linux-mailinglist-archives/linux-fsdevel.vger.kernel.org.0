Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CDF2CBA85
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 11:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgLBK0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 05:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbgLBK0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:26:10 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01021C0617A6;
        Wed,  2 Dec 2020 02:25:24 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id w8so1036644ilg.12;
        Wed, 02 Dec 2020 02:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFjLmlLgs9QHk2nxUfRF9OLmenUFrrX2jd4v12/6Dbk=;
        b=PkPCRUbNggyiNac/Cq1FST7xcvqEEUPnyv1UIhS5U1/3B+j9y5niucPi2g6tkrHyMs
         1XVkmG+gYihpLNVq3Gc6gPtDttjOy5XWg9L4DoznreUy6sRsrAbkmIABybbIiYnebFsD
         4OONlO/tZl7ZzZK6+Xl5vQw83h4KLD2c5Psn8Pi93zxz9/P94SzPRYihNV/oQ86e/j+u
         02xD5E9dM74nkcE2H2N6IfNKiqDEMHlwR5ccJF2Ds38HL+wr0s2th9YrEYtN8Ay8IyqG
         Bc8+WWH+qmOJtId62HdCDA8UAedImCmPqr982JRS9GcGODw+29X8CSub9FcX5DyyUHMB
         JaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFjLmlLgs9QHk2nxUfRF9OLmenUFrrX2jd4v12/6Dbk=;
        b=tKhX80z0P5uEp7oVg40TnMpt2u785RlbMaz6ArxhOvHwWubxnbQ+j7nvMu6NVa+Gsn
         9xNKLCXoctS40m386hUUC3u/+RDaKuhaM6B9kn9qoV29XMBN0Mm6ftwUqTis0Wld52iG
         FSTiloOu9NuhHJNYwmfHIXx7DbC1vDW2Q3DLIPCR6SgmaJ8V/tAIN2BLnDlvmoLRjvPf
         uxmdPbSFdMnXA+pvkcZ34C2jhebOUbjBTDQ4HIDv6+oUEAUSUInJ3Q7qLtcEccy4aM8S
         fdtEELpJvCK7ss/YW4AIqFeiF+W5wRMTCwKSxNI7nfhTZgd9cgrRafqmrT2cHKbAJvvN
         D2Pw==
X-Gm-Message-State: AOAM532hrQxenkhh4O6AqTpCYS9bEqEVMEHs1kF1C+rQw9TaLnaqNJk9
        Un4TpJyWvlWDzzH1Cu9ukCubfWPETehBx5zhd2HNAmqWbLY=
X-Google-Smtp-Source: ABdhPJxPRVyErgOwPDJBbab36zTv2PjFi1DJGIx13Cjbeh7DDxc9ITeSc4VgHyDBbZmGHVZrJIwrbS2Prsg5t+Ot5tg=
X-Received: by 2002:a92:6403:: with SMTP id y3mr1732278ilb.72.1606904723393;
 Wed, 02 Dec 2020 02:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20201202092720.41522-1-sargun@sargun.me>
In-Reply-To: <20201202092720.41522-1-sargun@sargun.me>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 2 Dec 2020 12:25:12 +0200
Message-ID: <CAOQ4uxiUTsXEdQsE275qxTh61tZOB+-wqCp6gaNLkOw5ueUJgw@mail.gmail.com>
Subject: Re: [PATCH] overlay: Implement volatile-specific fsync error behaviour
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 2, 2020 at 11:27 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> Overlayfs's volatile option allows the user to bypass all forced sync calls
> to the upperdir filesystem. This comes at the cost of safety. We can never
> ensure that the user's data is intact, but we can make a best effort to
> expose whether or not the data is likely to be in a bad state.
>
> We decided[1] that the best way to handle this in the time being is that if
> an overlayfs's upperdir experiences an error after a volatile mount occurs,
> that error will be returned on fsync, fdatasync, sync, and syncfs. This is
> contradictory to the traditional behaviour of VFS which fails the call
> once, and only raises an error if a subsequent fsync error has occured,
> and been raised by the filesystem.
>
> One awkward aspect of the patch is that we have to manually set the
> superblock's errseq_t after the sync_fs callback as opposed to just
> returning an error from syncfs. This is because the call chain looks
> something like this:
>
> sys_syncfs ->
>         sync_filesystem ->
>                 __sync_filesystem ->
>                         /* The return value is ignored here
>                         sb->s_op->sync_fs(sb)
>                         _sync_blockdev
>                 /* Where the VFS fetches the error to raise to userspace */
>                 errseq_check_and_advance
>
> Because of this we call errseq_set every time the sync_fs callback occurs.
>
> [1]: https://lore.kernel.org/linux-fsdevel/36d820394c3e7cd1faa1b28a8135136d5001dadd.camel@redhat.com/T/#u
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-unionfs@vger.kernel.org
> Cc: Jeff Layton <jlayton@redhat.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> ---

Looks safe :-)

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

We should consider sending this to stable, but maybe let's merge first
and let it
run in master for a while before because it is not a clear and immediate danger
and if anyone is using volatile already I hope they read all the
warnings on the box.

Thanks,
Amir.
