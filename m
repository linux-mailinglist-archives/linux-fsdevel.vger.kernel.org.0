Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B609227A33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgGUIHV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgGUIHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:07:21 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C73C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 01:07:20 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id a30so9620277ybj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 01:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9JzkjVDZR784mTk6XJkn5jeJolgYLLn52EBNfD00gM=;
        b=KnrgobuYvbzjRUlqFlUVjQWuKdXvsutzjB6O5blHpUvMMen4gQbdN1mm0WqcEpjAaS
         1SFTczqxxFFpH9hzaM4U/BTDjOZqNEZM8HMNFSe25ejqPceVunZr6hKhosFIofmJELvi
         6J7fpWNI5GOj8ZK3BH1dmLIf25WbgVwpEKRo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9JzkjVDZR784mTk6XJkn5jeJolgYLLn52EBNfD00gM=;
        b=LMcN/SWPG3ucqjah8ZXczX1G8Iw70EsqjQTR4+1kWNswyf0lgyWXvG0MlLUr9V9Oi8
         GV7ubWOdCRL+VO20/QHFy1qxvAlEmEBDEgYPwQ2d7ggkgVSA5Xnvvmy1iOPK4OljtxBd
         vKAWXsigsWqtrR6Og2PB+58dZKiI9lpKsMxIJLWlg08mxEDc4Ao5LyJTPS2876hC4oAM
         FOLzsKTk7cXdwmImOlRvqPNq0B146/qPS39FN+1/8Vb7zDoK4SGURxgnsIAWEtANIu8u
         fhTFlMYsLeZ4niKDR9nXyY6h0Kmm90fEz/8wsEs/iivirKD9zpnG8wQ2yJErBsxuEqs4
         gCEQ==
X-Gm-Message-State: AOAM533C/g1XtAoY/kbedyk2fjUoKpK20SOj4tPb1v3zwJMusRbN2Pg5
        ZMPSQ5F0yzjMBMNLcSXisFqxVLXuZmsMKw5/BkB+iQ==
X-Google-Smtp-Source: ABdhPJyTLkf7Xg6uT7aaw8rW0H9HaN7ZWJPzYgw3ku75DcZcLm5RfI2ewMpmWwlcuQOkYkLZA42zRsylkumnaDTKQ2Y=
X-Received: by 2002:a25:ab0e:: with SMTP id u14mr41794846ybi.181.1595318839461;
 Tue, 21 Jul 2020 01:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200713090921.312962-1-chirantan@chromium.org>
 <20200713095700.350234-1-chirantan@chromium.org> <20200713095700.350234-2-chirantan@chromium.org>
In-Reply-To: <20200713095700.350234-2-chirantan@chromium.org>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Tue, 21 Jul 2020 17:07:08 +0900
Message-ID: <CAJFHJrqEU=k2dLkKAD-SsKwkVeQ3KPf5wveph9u86BxdbM7q8w@mail.gmail.com>
Subject: Re: [PATCHv4 2/2] fuse: Call security hooks on new inodes
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 13, 2020 at 6:57 PM Chirantan Ekbote <chirantan@chromium.org> wrote:
>
> Add a new `init_security` field to `fuse_conn` that controls whether we
> initialize security when a new inode is created.  Set this to true when
> the `flags` field of the fuse_init_out struct contains
> FUSE_SECURITY_CTX.
>
> When set to true, get the security context for a newly created inode via
> `security_dentry_init_security` and append it to the create, mkdir,
> mknod, and symlink requests.
>

Are there any other concerns with this patch? Or can I expect that it
will get merged eventually?
