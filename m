Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF28839078D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhEYR1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 13:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbhEYR1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 13:27:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4CAC061574;
        Tue, 25 May 2021 10:26:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id y14so30994542wrm.13;
        Tue, 25 May 2021 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tb7ZXH1D1cwKZAT823HMk0GHO8oGdv5P3a7/nbM1BzU=;
        b=Ufo2RKRiquGpX291FCaRDo39U2YU+75WNJ+TJtorDu92rtzAJa5DnA3QA4fMdamUoD
         F2/nBcqGhlG4Hjv9BooXNfGEFY8KnnCGCjdNX+ZjrcvLsaGtyvnYyO6UTpZQFJsZegaO
         F0IitOdpnPvmGDRcvKh0JXApsAqi+qDfo1LU6hr52mRJbmIH5CUpWnDqIvWOQO0KXMuT
         CWV3XwPqRCMX2vKuprgYKfceM/YIEpK9iroIVomGrDC/uSsLN4Bhr6fEO2y/PVV9sV3b
         w5Myhwm17SRY4uwk4s75FSt10SfRCZc8uGKmRpIiUQlrldzPWLYikOR6m8hhacH5U+0D
         q84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tb7ZXH1D1cwKZAT823HMk0GHO8oGdv5P3a7/nbM1BzU=;
        b=LVPU1S4kVvmtRGh8NmYypo7zHItPSeBU+GpHgt9V5lWfamCB50iUx/35GqjNKubTtF
         fFOSpgM59rqAA8N+VKOXfJ1fnc+wqwbhctbK8h6sxgK7M7x3fFG8BdLwka75GPEFpTCH
         O4c38/H6wbpglFtEPK4Z4hByLhbpXmUmzCsM2rHIzX56fhEQ6d+yK4JW402VPWxkusTf
         3Bz/WFiHJu5pLheQhBOgvy4gNKLy6XqOdcUv95O09Vnt2RpKDj8rADoWkTFcNl3aLD2A
         0fPPJGa0ewahpm1XTr329lZczHVua1lRQbCf3OpKI5MmEc37AySKSvsvALcg/IMpBNKb
         8FHw==
X-Gm-Message-State: AOAM531C6ZdLHuQb8/8+R+CoWQCJ6SRM0gXWUedtjScE4JV2TUMIFEHM
        sFsjSPQ0OGH+FYRIHZdGIMJ2EBIahub4c6BnW8pCEhdl
X-Google-Smtp-Source: ABdhPJx+xwSs+sOqKLL1h4tnGVVN2FmMKCcxlZ4VXKMPAfy6ISj8IcCPLOOCj+F/FfiNs2KV5mpHhlX+JUOHsNpznHk=
X-Received: by 2002:adf:e8c3:: with SMTP id k3mr28870750wrn.255.1621963576504;
 Tue, 25 May 2021 10:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <162194384460.3999479.7605572278074191079.stgit@warthog.procyon.org.uk>
In-Reply-To: <162194384460.3999479.7605572278074191079.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Tue, 25 May 2021 14:26:05 -0300
Message-ID: <CAB9dFdt_BKRVyDXBrmymmiKvpNMv4HAdw=TTgxbOK-fVtEuKHA@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix the nlink handling of dir-over-dir rename
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 8:57 AM David Howells <dhowells@redhat.com> wrote:
>
> Fix rename of one directory over another such that the nlink on the deleted
> directory is cleared to 0 rather than being decremented to 1.
>
> This was causing the generic/035 xfstest to fail.
>
> Fixes: e49c7b2f6de7 ("afs: Build an abstraction around an "operation" concept")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---
>
>  fs/afs/dir.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 9fbe5a5ec9bd..78719f2f567e 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -1919,7 +1919,9 @@ static void afs_rename_edit_dir(struct afs_operation *op)
>         new_inode = d_inode(new_dentry);
>         if (new_inode) {
>                 spin_lock(&new_inode->i_lock);
> -               if (new_inode->i_nlink > 0)
> +               if (S_ISDIR(new_inode->i_mode))
> +                       clear_nlink(new_inode);
> +               else if (new_inode->i_nlink > 0)
>                         drop_nlink(new_inode);
>                 spin_unlock(&new_inode->i_lock);
>         }

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
