Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA753877B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 20:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237580AbiE3Spw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 May 2022 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiE3Spu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 May 2022 14:45:50 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070CA674F6;
        Mon, 30 May 2022 11:45:49 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id c2so5122849edf.5;
        Mon, 30 May 2022 11:45:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAkw8oENY46kqEXvGVH0+01/kTxWc6N9ZT20+okexmw=;
        b=WlN/4GwYvqJw62FHjMBSctXHuTcXkwiRWlQS/q8KNC7jEKFwCSVtbZxbpMTymAXu8p
         eXVth10lQNPomzIgHETy8H53SmvWA21re+9f5wYCtryYvBFaX6GLwpyMkxpo49WplkEa
         A9aRUXyB6bZIlWQkJq0o99LF6DyowDHO2vIWe70DoeTmsjj7f/R++UerjFxZbiq1r9Mh
         W0NS/h4SMDtUdIJ5RY5pagW12QDTHBULtdYmZ9WAPYl/rzhnaHhjWlYRaetK6QyikRmN
         fnvBGBuT99PF2+snGfpU/T7uO3Fg7WFuJ3GAhcWVi24znes+Eiu5750tiHp3dO6R8DNX
         m7pw==
X-Gm-Message-State: AOAM530RIzEhkE8arxUojhkevZ7mkYxFkGF2EbAMq6qZxWOExt73hQqg
        TFp7BHKQDZekwg1KUZ47NAZj+H8s62E=
X-Google-Smtp-Source: ABdhPJyoyRdFSYCCp2183JD7jHWriXDiKxrt/c7hMj0sCp4i5bgdfvm37T9jy9MuT1HPeKNjXtQB6Q==
X-Received: by 2002:aa7:db02:0:b0:42d:c3ba:9c86 with SMTP id t2-20020aa7db02000000b0042dc3ba9c86mr11825400eds.337.1653936346880;
        Mon, 30 May 2022 11:45:46 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id h13-20020a170906590d00b006f3ef214db3sm4323375ejq.25.2022.05.30.11.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 May 2022 11:45:46 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id k19so7602517wrd.8;
        Mon, 30 May 2022 11:45:46 -0700 (PDT)
X-Received: by 2002:adf:e19a:0:b0:210:157c:7b3c with SMTP id
 az26-20020adfe19a000000b00210157c7b3cmr15477515wrb.121.1653936346098; Mon, 30
 May 2022 11:45:46 -0700 (PDT)
MIME-Version: 1.0
References: <165391973497.110268.2939296942213894166.stgit@warthog.procyon.org.uk>
In-Reply-To: <165391973497.110268.2939296942213894166.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Mon, 30 May 2022 15:45:34 -0300
X-Gmail-Original-Message-ID: <CAB9dFdtak3PsPDZMbsiAEMbCx-UNvwOGFtROhZpcaN6=90HE0A@mail.gmail.com>
Message-ID: <CAB9dFdtak3PsPDZMbsiAEMbCx-UNvwOGFtROhZpcaN6=90HE0A@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix infinite loop found by xfstest generic/676
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 30, 2022 at 11:09 AM David Howells <dhowells@redhat.com> wrote:
>
> In AFS, a directory is handled as a file that the client downloads and
> parses locally for the purposes of performing lookup and getdents
> operations.  The in-kernel afs filesystem has a number of functions that do
> this.  A directory file is arranged as a series of 2K blocks divided into
> 32-byte slots, where a directory entry occupies one or more slots, plus
> each block starts with one or more metadata blocks.
>
> When parsing a block, if the last slots are occupied by a dirent that
> occupies more than a single slot and the file position points at a slot
> that's not the initial one, the logic in afs_dir_iterate_block() that skips
> over it won't advance the file pointer to the end of it.  This will cause
> an infinite loop in getdents() as it will keep retrying that block and
> failing to advance beyond the final entry.
>
> Fix this by advancing the file pointer if the next entry will be beyond it
> when we skip a block.
>
> This was found by the generic/676 xfstest but can also be triggered with
> something like:
>
>         ~/xfstests-dev/src/t_readdir_3 /xfstest.test/z 4000 1
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>
>  fs/afs/dir.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index 932e61e28e5d..bdac73554e6e 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -463,8 +463,11 @@ static int afs_dir_iterate_block(struct afs_vnode *dvnode,
>                 }
>
>                 /* skip if starts before the current position */
> -               if (offset < curr)
> +               if (offset < curr) {
> +                       if (next > curr)
> +                               ctx->pos = blkoff + next * sizeof(union afs_xdr_dirent);
>                         continue;
> +               }
>
>                 /* found the next entry */
>                 if (!dir_emit(ctx, dire->u.name, nlen,

Looks good, and fixes the hang with generic/676.

Reviewed-and-tested-by: Marc Dionne <marc.dionne@auristor.com>

Marc
