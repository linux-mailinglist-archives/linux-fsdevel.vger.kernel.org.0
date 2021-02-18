Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45B31F148
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 21:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhBRUnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 15:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhBRUlp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 15:41:45 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31AEC0617AA;
        Thu, 18 Feb 2021 12:41:22 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id r23so8224156ljh.1;
        Thu, 18 Feb 2021 12:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFyQNASifwQpMLri08Ol4P6yp5dFeoJ6Rz1w04iex40=;
        b=ad9xrVWwPRJ0Op7IrKvZt0bJXunRvSzb1OGuouK5C/8+63N00msV3K1hURk0ID3R/t
         ssl6CA+hTMPJX/9Sr62yXSmtN/nkX7ytk1DTXwRHAplmTCj+7VQfEoFCAngSsig6xVOM
         wafKbDXUw5R9Ib/vN/DgZ2ijnRTaOkMnqgYalC2c0B/3kC9SpKIHNqQGWw3lnfYzPieO
         zac3ULzHVUiS/CzUScmj8giO7bJNLSWKbHHHzOKPKI6SH4VnXmkz+2bIatpm+3JaeGTu
         0WNWTxias5zgTTvhLwQyhUtog6ElixtiMQk/UqeRbfJJotEBLzgTg1hkhOl8WsdwHQQR
         dQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFyQNASifwQpMLri08Ol4P6yp5dFeoJ6Rz1w04iex40=;
        b=IMF8hs1ANiNwmmUFisKxbbZcTs+pQ+kfsHDs8++sSHLy/jlSsBwAJoXyzvygKN+heD
         k+xnaHDu6WxjomuAF89rbDswEt8YRHMi/rzHMFoxNihgeo03580KMcnRFQm+XPUsZsvB
         2vKG6iVHYzUJbCAtD9E1Qr/is0AGu04GiW4oFA2KfVh/iOj6E+rdqxaOopRkl6Gr4G2Z
         ENEYiOSD6HFdvw219NDo/Q9MyM0NsRpAbu/fDEFooX8tlNZIAQwrD0oWmU0ZGrKmfxA9
         RLCIFSzAXDRgeKagtGf8R24L8RjrT8lCOk5w1Bwq7G+Vs8MKHf6zo98MlhLFAty61GLN
         DggA==
X-Gm-Message-State: AOAM531vCEE26Ho44XL5x4SyY5MZW0KrH/EtrzKIbal+7RsaaZuBdQTz
        OYUTeMBfZ33cqzpEbuC64J7PZmHD+PAtw7b4WZI=
X-Google-Smtp-Source: ABdhPJzIe4u7R8N9hXZ7mZlqZtsMdthHDVWh1IqsLqv46KHoPGGXza+HzvNxYxde5rbeiZfOPb400z4NE3Ei7y3Na8A=
X-Received: by 2002:a05:6512:1311:: with SMTP id x17mr3289191lfu.307.1613680881337;
 Thu, 18 Feb 2021 12:41:21 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de> <20210218074207.GA329605@infradead.org>
 <CAOQ4uxgreB=TywvWQXfcHYMBcFm5OKSdwUC8YJY1WuVja6PccQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxgreB=TywvWQXfcHYMBcFm5OKSdwUC8YJY1WuVja6PccQ@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 18 Feb 2021 14:41:10 -0600
Message-ID: <CAH2r5ms46x-XviHDKRJEsPt64+qW+zDKwHHSO15gxsZ+a0-ToQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Luis Henriques <lhenriques@suse.de>,
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

On Thu, Feb 18, 2021 at 4:03 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, Feb 18, 2021 at 9:42 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Looks good:
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> >
> > This whole idea of cross-device copie has always been a horrible idea,
> > and I've been arguing against it since the patches were posted.
>
> Ok. I'm good with this v2 as well, but need to add the fallback to
> do_splice_direct()
> in nfsd_copy_file_range(), because this patch breaks it.

Interestingly, for ksmbd (cifsd) looks like they already do splice not
copy_file_range


-- 
Thanks,

Steve
