Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B2531E84B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 10:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhBRJzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 04:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbhBRJMu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:12:50 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E849C061756;
        Thu, 18 Feb 2021 01:10:12 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id a16so852681ilq.5;
        Thu, 18 Feb 2021 01:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgQOiOPnq0DRvI2eZdQvsHnaIaMA+0qyu71WaKASe+E=;
        b=KIj9uV247HXRj8/OdXi7y7ObktVMiQkfY1zBawc3yoqptXXOeQTlt477Lr0LhrSGE9
         8E18Bxidf9al2BaaL4xQC/16sB1fQQ8/NXtUzgFeb2Tl+lMz/7TeP3pg/dihjZBohG7+
         Se3QMaNt+hpWGzO7FbyL236gNrhjqG1KqA1QlNO2w/DwML7TfhYsXFaNCZB4laQDaY+F
         oZkmK4iDfnSJRr1w54d303Bkhc5/PFzSLgJ4odjLMS35jswywGq2QGEUU14unumiNnAN
         qpHtfXb5gITTwAbd5vZpb18FanWx4e2pmi6XDDLIZ6epHqg+bRzfy3Pt7kKhL+hAezW9
         +e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgQOiOPnq0DRvI2eZdQvsHnaIaMA+0qyu71WaKASe+E=;
        b=kSJOO/Y2azAc3u998nFl7nQ5qNLFNurdH8g+1BiNILdwFp3z/Cbg78Ec3DCYtGUTkW
         G6TzrJ0qfnjiMtaLJB1p0nZTfLWl5xll32yNzUn9mekD6hDBSvR4+N6ZtNozRa5BeH+D
         w1SuBK6ayuobWjB6Z0AK5RkI2a5d+yAAx5Vv7QlOvQUZfs03XWVp2Zud57dUClRjg31g
         PjowJCqgQp9j2ZW+3OKKMQ3KrS5Xrclw6lIdYTSdGpYc/0Fhnm9+tLiE6TXD5jIjyJ7L
         M0RAANv/Hzs9Uim4X99ye5dx1RKvxfvr0kplb7o0Csom3MGhMJ5N2XaNUQM+2URgCZOa
         JOtA==
X-Gm-Message-State: AOAM530FXwNwJvZiX1Idh5R0/zAXMxrgje0AjryZmgQmZWm9alLI+PHZ
        5vQd2MnwpuMmkt2hwpITPklgq8+0qjAuO5FYR6o=
X-Google-Smtp-Source: ABdhPJwxXq4k2yVJ6n1V7pcmcKjBIF0kyD/ZKAbc2Dz8lUF9r8GD81APTW8Ak1u3Tadv0KMLHxr+7GYAW078rcvAOLg=
X-Received: by 2002:a92:8b89:: with SMTP id i131mr2975061ild.9.1613639411616;
 Thu, 18 Feb 2021 01:10:11 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de> <20210218074207.GA329605@infradead.org>
In-Reply-To: <20210218074207.GA329605@infradead.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Feb 2021 11:10:00 +0200
Message-ID: <CAOQ4uxgreB=TywvWQXfcHYMBcFm5OKSdwUC8YJY1WuVja6PccQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 18, 2021 at 9:42 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> This whole idea of cross-device copie has always been a horrible idea,
> and I've been arguing against it since the patches were posted.

Ok. I'm good with this v2 as well, but need to add the fallback to
do_splice_direct()
in nfsd_copy_file_range(), because this patch breaks it.

And the commit message of v3 is better in describing the reported issue.

Thanks,
Amir.
