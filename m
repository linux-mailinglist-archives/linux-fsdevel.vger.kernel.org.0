Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEC69946B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 15:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbfHVNDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 09:03:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42895 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731563AbfHVNDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:03:39 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so11574612iob.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2019 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdtsaaLnk5gqq3aceEJtkbVxwRwyC5oCEmINL7vwO0Y=;
        b=dJbJUZENVWk/gpYy4RQ7L8HRr4Hp/LovPvut1DZcM1VCDqHCyKszVzS77nUUPiAJtk
         JUPJcJD+h7iDMQjkb5oMu9XCRsRVVaXzk1UJq6IZKTjwtS4mL6ogiNjTNfjeSn2kPZvC
         /6O+rFMiazotGIwxzxKZMxEAcpa2OpsiDQheg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdtsaaLnk5gqq3aceEJtkbVxwRwyC5oCEmINL7vwO0Y=;
        b=jm/jgKsYfTTBS2F/UCiOjieXVCYxeXv/PXYP1sM98J5CkgF/fGZDm7Jy7NVDU1msaK
         0I31xmdNRW36mTU4OyrUEv6GpizOQ3wRyBM/3XSbui9pa+L1Yuc7Sv5kJF9kZaQmGZCk
         gl9U4Bzwj5rYmVmsFmJHRfaeWFxkzkQvH5IHESsazXCePFz9A9E3FlnP4dVw+Iyv9GGb
         0Pr4VrjXQRowuu5UUhWJtmAI2HEhj+R5IoU/O/AuZX+jQgBs2if9FN75J11h3uQXn/bJ
         dT5URvJcCVlQKsLDg77XQ5pron0gul/dsWnIICgVxvLHIetfKnf6TUt/24lEDg1ovq2k
         BywQ==
X-Gm-Message-State: APjAAAXLWrH1sv9RiWU65BuF8pScEtVQ8TEC/+0VpuEwd8hKeb9kuAlX
        pdYQQh07ZVjYp9otH75tmG/R9852z7sw8nmS/fLoe38kGCU=
X-Google-Smtp-Source: APXvYqzxJdFOpymGRAbr9oCUteVx8g68gayTWEhopzpoCdB/iJ2md1LtcV0rK8FwBgk0bkJuVtcruSE0Z6P145bF5/4=
X-Received: by 2002:a5e:9403:: with SMTP id q3mr9468254ioj.63.1566479018387;
 Thu, 22 Aug 2019 06:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190822073300.6ljb36ieah5g2p55@XZHOUW.usersys.redhat.com> <CAJfpegsJCpabQ7-pag9KU+NmXyrtJPauQi4poO9B9rZADLLvzg@mail.gmail.com>
In-Reply-To: <CAJfpegsJCpabQ7-pag9KU+NmXyrtJPauQi4poO9B9rZADLLvzg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 22 Aug 2019 15:03:26 +0200
Message-ID: <CAJfpegvenW4yHks6r5zOSv_QWubeaB4zEF0dtiJ-H++pqGkLvg@mail.gmail.com>
Subject: Re: [PATCH] fs/open.c: update {m,c}time for truncate
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 22, 2019 at 2:08 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, Aug 22, 2019 at 9:33 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> >
> > Just like what we do for ftruncate. (Why not)
> > Without this patch, cifs, sometimes NFS, fail to update timestamps
> > after truncate call.
>
> Digging through history:
>
> 4a30131e7dbb ("[PATCH] Fix some problems with truncate and mtime semantics.")
> 6e656be89999 ("[PATCH] ftruncate does not always update m/ctime")
>
> These are pretty old commits (>10years); has anything changed since
> then relative to the required semantics for truncate/ftruncate?

SUSv3/POSIX:2004:

   "Upon successful completion, if the file size is changed, this
function shall mark for update the st_ctime and st_mtime fields of the
file"

SUSv4/POSIX:2008:

   "Upon successful completion, truncate() shall mark for update the
last data modification and last file status change timestamps of the
file..."

Note the omission of the "if the file size is changed" condition...

Thanks,
Miklos
