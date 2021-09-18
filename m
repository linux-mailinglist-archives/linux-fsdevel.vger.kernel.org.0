Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9941048F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 09:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241265AbhIRHC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Sep 2021 03:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhIRHC6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:02:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC2CC061574;
        Sat, 18 Sep 2021 00:01:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id c8so42271619lfi.3;
        Sat, 18 Sep 2021 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6LFIPcmdFoFj4rklUTz5qGSaqnsNVcI23FWVEmDMQjs=;
        b=IH3+DjVepbtQzCKQi8qz39JqT7+RO5gl11M8W9tm0/UaqEgcI/3SYP43klsk2ZrN3F
         jF42z5ZqZ6EcJfe/92vPdDiK3jpacEvVTrXBRy7tL6aR0GdCy4IzGncLrAKPC7NC6iBE
         je3P9YiDsV20/clMkRNrPr1ZxUiVZ4xctKG3vQ9VrWDU0BwytCWOSR3z0jSJkHSrs3uB
         VFFBjQkrEGsPytda8oPQ9bNl7PYtMgq9uEqCLaQnJtaffctwNLnm06EeA8HIQU01Sc8F
         pz9exm6wfP95xQguZ1luRr8DfYIX1+8tanmtaaGnbT/JzFLBKqYwBq9jBn4NsiOCJZMc
         QYJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6LFIPcmdFoFj4rklUTz5qGSaqnsNVcI23FWVEmDMQjs=;
        b=MSswq2zFHven5WPu1oSWuD6LcVYIk5T0UScOKYaZFsaKPnJhuLO8rzxAhkEJ6YHNCa
         zAbSh70yWb2gjpTdmwLIeD9xaBRgpQLj++oK9VaGertjmTZD0DHZA+T1dyOPMCKk1I28
         v5lRsk6Pb09gHbfdB/ftunC0eSxM61qYxgpsUzGk+DWGSn3Tj2XHbczfoizg6rsPIoMa
         dx6xr5Hg19AYqoRsG1IrQhBpmtfWezrPfFROThr8QQA5x9tSRknY/OID9EhvoKGghLJH
         n+dOGzNVDdBb2ef+4kcc6FPM38gSGbwvR9HD/2Vsy8LbAy5yH84uRG5nMvN8KS7uU2yu
         9EJA==
X-Gm-Message-State: AOAM5315dIgyIjUkwewf3EMWFh0rijeDNsH8WQBC6prKe5MeZ6I9bYGG
        /goFm3FQExiZANIajAr0i9Zoxsp1+Xc=
X-Google-Smtp-Source: ABdhPJzRsRve3Ssj4TkmOw3kbZQxgkltubFsNVgc4WheBTwM4gS3oyYAmAsbvQhRWLAQyC7x8Ld+/A==
X-Received: by 2002:a05:6512:553:: with SMTP id h19mr11087093lfl.33.1631948494009;
        Sat, 18 Sep 2021 00:01:34 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id i18sm969297ljj.84.2021.09.18.00.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 00:01:33 -0700 (PDT)
Date:   Sat, 18 Sep 2021 10:01:31 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs/ntfs3: Speed up hardlink creation
Message-ID: <20210918070131.u3e2obnj4vejzfxj@kari-VirtualBox>
References: <a08b0948-80e2-13b4-ea22-d722384e054b@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a08b0948-80e2-13b4-ea22-d722384e054b@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 13, 2021 at 06:09:42PM +0300, Konstantin Komarov wrote:
> xfstest generic/041 was taking some time before failing,
> so this series aims to fix it and speed up.
> Because of this we raise hardlinks limit to 4000.
> There are no drawbacks or regressions.
> Theoretically we can raise all the way up to ffff,
> but there is no practical use for this.

Hi. Sorry for taking so long. Did not notice that this is actually
another version. Please use v2 in subject. I did ask you to write little
bit more to commit "Change max hardlinks limit to 4000". Now you have
write it here. Cover letter will not be in commit messages. You need to
write this info to commit message also.

> 
> Konstantin Komarov (3):
>   fs/ntfs3: Fix insertion of attr in ni_ins_attr_ext
>   fs/ntfs3: Change max hardlinks limit to 4000
>   fs/ntfs3: Add sync flag to ntfs_sb_write_run and al_update
> 
>  fs/ntfs3/attrib.c   | 2 +-
>  fs/ntfs3/attrlist.c | 6 +++---
>  fs/ntfs3/frecord.c  | 9 ++++++++-
>  fs/ntfs3/fslog.c    | 8 ++++----
>  fs/ntfs3/fsntfs.c   | 8 ++++----
>  fs/ntfs3/inode.c    | 2 +-
>  fs/ntfs3/ntfs.h     | 8 +++++---
>  fs/ntfs3/ntfs_fs.h  | 4 ++--
>  fs/ntfs3/xattr.c    | 2 +-
>  9 files changed, 29 insertions(+), 20 deletions(-)
> 
> -- 
> 2.33.0
> 
