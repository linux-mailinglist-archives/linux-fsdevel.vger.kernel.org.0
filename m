Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534F51024D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 13:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfKSMun (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 07:50:43 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40040 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfKSMun (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:50:43 -0500
Received: by mail-yb1-f193.google.com with SMTP id y18so8695214ybs.7;
        Tue, 19 Nov 2019 04:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGsGXeAQ4sQC52wPWxR7qbHgovaaBNZdZEO6kE8t71U=;
        b=P6r/GVQ/XR+jj8+CI4OC536QjZ/3Oqm2KHOTQYy0AXAXCyeMVi0kCIGq8Dmk+don5E
         CkKj8HfNKrc9aKzXY4Jkw3WMQrUHlu5++6gONWtlH+ifULFairnk21PgGsie/DNKWCEH
         1o9NNZvXmk/aHTryHsHCP4ebR8mxn4z/L84k3Y+ABKmP+A20Q9zeMEEloog7xiInmVaU
         gaUe1LIhLs7Pr3J8uE7LGauhBW4qu6R6chRXIjAfxPdQ4n4gbsQeu/1DsCPepEIuaqMe
         u60AjaRtd5HWDsKr7C5SI/xffP4RQHwB7YgjeCduaM4RYjym4sqcewpIkM6OAwBeRjku
         P4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGsGXeAQ4sQC52wPWxR7qbHgovaaBNZdZEO6kE8t71U=;
        b=qnZxmmu0M2QyhJj0adPVwj586VDvTO+KFyW8FANKwlFc5Las94b7WWnWq1C/1NQ8/9
         9esRbW8iCroSQq7wQcRfEMGp8FRoMuEA9pMpSRxXcFu09gfxJpTkK2zuFPk2KPbmU6b2
         ksCa1x8CJHBeYKYATJO3aCaHCvEJkwJQ9jhKBnT1jfQKBWUB7o71zl15WHZYbgan6myd
         uHYCraE3XkvKkTyTvRjkdJaTu9y5o53IboD1yFaPwQd0wCa0lPrTKvcK94YuHdE4DIS0
         AM5meZ3qP59pLnI/dNKcHMmoMzrxvnvQhJSEXrZMF7+huMf8+uMnEe8Cu6137Q7Xi1Hm
         W3Kw==
X-Gm-Message-State: APjAAAXZh87TeOACKGr301hNlwB9gvoF/AEgUL+RKSI7bnNBtYy27ogg
        pY5/MQPclOx9zgGTqmIDTHIKm1ZCmlLflKlHdeXlXV30
X-Google-Smtp-Source: APXvYqwJ9Q03AWogB5mchAiJKDvUADq9PLyB1m7yNMoxdKDtI+oy8ehk09JH8Xf2kIf2dtVPpr0wmX8pufXvYc80lzg=
X-Received: by 2002:a25:6649:: with SMTP id z9mr25664452ybm.132.1574167842050;
 Tue, 19 Nov 2019 04:50:42 -0800 (PST)
MIME-Version: 1.0
References: <1574129643-14664-1-git-send-email-jiufei.xue@linux.alibaba.com>
 <1574129643-14664-3-git-send-email-jiufei.xue@linux.alibaba.com>
 <CAOQ4uxhU0NGqX-P4XTJ+kf6sXNCnUCBxgp1u2-aDV5p15Jh+tg@mail.gmail.com>
 <142a7524-2587-7b1c-c5e0-3eb2d42b2762@linux.alibaba.com> <CAOQ4uxgR3KO9kXGdqif0A-QBrVLn9id2eFANMDprCz62jSAmaQ@mail.gmail.com>
 <e88b8262-c475-f969-ef65-d888aee20e20@linux.alibaba.com>
In-Reply-To: <e88b8262-c475-f969-ef65-d888aee20e20@linux.alibaba.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 19 Nov 2019 14:50:31 +0200
Message-ID: <CAOQ4uxiNxgVkAH_uG7tABFP7_X9EWQxcC2A00dkXTPJzToXhvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ovl: implement async IO routines
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> >>
> >> Refer to function generic_file_read_iter(), in direct IO path,
> >> file_accessed() is done before IO submission, so I think ovl_file_accessed()
> >> should be done here no matter completion/error or IO is queued.
> >
> > Mmm, it doesn't matter much if atime is updated before or after,
> > but ovl_file_accessed() does not only update atime, it also copies
> > ctime which could have been modified as a result of the io, so
> > I think it is safer to put it in the cleanup hook.
> >
>
> Can you give a more detailed description that a read op will modify
> ctime as a result of the io?
>
> I found that it will trigger BUG_ON(irqs_disabled()) while
> calling ovl_file_accessed() on async IO return path. The calltrace
> is pasted below:
>
> ovl_file_accessed
>   -> touch_atime
>     -> ovl_update_time
>       -> generic_update_time
>         -> __mark_inode_dirty
>           -> ext4_dirty_inode
>             -> __ext4_get_inode_loc
>               -> __find_get_block
>                 -> lookup_bh_lru
>                    -> check_irqs_on
>
> So I need more detail to find how to fix this issue.
>

It's not important. Please ignore. I din't know there was an issue
with placing touch_atime() in completion context.

Thanks,
Amir.
