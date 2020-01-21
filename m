Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12FE143503
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 01:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAUA6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 19:58:17 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38321 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgAUA6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 19:58:17 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so998644ilq.5;
        Mon, 20 Jan 2020 16:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCPW3+dWDbIRbuQST+6q3D+xQJA7cb2wL+8i3SSdMng=;
        b=CmfOrPn5I0OXkPkPYdGUfwC9DGpaxJcvf4EO/ChdeWRIE+cz3VPuwTv2kt7F/ejfLt
         +5oarpKWJhtIq5qHxRY+OM3F3DbK/lISzVt1O/DNMIK+6FzbAYtkBomjBydD5vkybwVt
         WHKBY32+y/GHkCC1pILK0CsKcPz9HS9R6dbsnIsmSO6UkzUPdJZoK5PdvPaCeAaGOZ9H
         7rh6mntdZTRtB5XdxddKrqKz1MyTfVhkYOxu77pncnHWI9m06OkF9w1g4nr14OJjCiEJ
         4/h56XzsnecWhZ46bLSqMWwlA8h1rtkqyUuU7V5CC+iVU0OQMQLodTGjKB7VxXF+FaGI
         LP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCPW3+dWDbIRbuQST+6q3D+xQJA7cb2wL+8i3SSdMng=;
        b=f8nMGLmpzMYzN/wbXC2oAtFIAcAQ35+1fBJEKXJoY/2MRpjCDg0xD8c3+kFS8VcO8o
         FaZkdSxVLp15pNOtLJjbNQlD7Zuc4TVSEwHskHVA9AOhZN7EIvLP9XrlC5W24KaCOc4s
         20gz+9PLsgUje8+kPmMwu93P8paplW+mwQY2HAjeBLaOZoEs/Yp2K86aomwdjclvKSWg
         oh2U2orm4OtL1aTE1LeOc2hYFiEPwn7y64wQ2GOEaqyXDQJ+FTdUEcUpmoRH76g7YTOA
         R8EQ0hj9FvP15XkM8IsfCEeiv0wdPhRbSRZmGW3TzrV3L9Efe4/Wa0pIhibMV9/7b+PT
         UoKg==
X-Gm-Message-State: APjAAAVMssy81sMhX9a5iEySXzi7mCLvidjM6+0yhsJRrBYaMYlB95sC
        R29mfpx97U1M5PBgpoYrRyJzF9TU397oBtR9Rcc=
X-Google-Smtp-Source: APXvYqzzLVHqJ9R/pIklyiAxN/CVdDSqAajpe3Jnc3ruqoDbUecyhaLg16p4RHME8gdVoNOhNvDb9VtsbgcXgpkLBJ8=
X-Received: by 2002:a05:6e02:d05:: with SMTP id g5mr1537570ilj.272.1579568296399;
 Mon, 20 Jan 2020 16:58:16 -0800 (PST)
MIME-Version: 1.0
References: <20160210191715.GB6339@birch.djwong.org> <20160210191848.GC6346@birch.djwong.org>
In-Reply-To: <20160210191848.GC6346@birch.djwong.org>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 20 Jan 2020 18:58:05 -0600
Message-ID: <CAH2r5mtM2nCicTKGFAjYtOG92TKKQdTbZxaD-_-RsWYL=Tn2Nw@mail.gmail.com>
Subject: Re: [LFS/MM TOPIC] fs reflink issues, fs online scrub/check, etc
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     lsf-pc@lists.linux-foundation.org, xfs <xfs@oss.sgi.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since SMB3 protocol has at least three ways to do copy offload (server
side copy),
the reflink topic is of interest to me and likely useful to discuss
for Samba server as
well as client (cifs.ko)

On Wed, Feb 10, 2016 at 1:19 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> [resend, email exploded, sorry...]
>
> Hi,
>
> I want to discuss a few FS related topics that I haven't already seen on
> the mailing lists:
>
>  * Shared pagecache pages for reflinked files (and by extension making dax
>    work with reflink on xfs)
>
>  * Providing a simple interface for scrubbing filesystem metadata in the
>    background (the online check thing).  Ideally we'd make it easy to discover
>    what kind of metadata there is to check and provide a simple interface to
>    check the metadata, once discovered.  This is a tricky interface topic
>    since FS design differs pretty widely.
>
>  * Rudimentary online repair and rebuilding (xfs) from secondary metadata
>
>  * Working out the variances in the btrfs/xfs/ocfs2/nfs reflink implementations
>    and making sure they all get test coverage
>
> I would also like participate in some of the proposed discussions:
>
>  * The ext4 summit (and whatever meeting of XFS devs may happen)
>
>  * Integrating existing filesystems into pmem, or hallway bofs about designing
>    new filesystems for pmem
>
>  * Actually seeing the fs developers (well, everyone!) in person again :)
>
> --Darrick
> --
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Thanks,

Steve
