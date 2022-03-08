Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DED4D239D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 22:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350493AbiCHVud (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 16:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiCHVud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:50:33 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249465574D
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 13:49:35 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id z15so524458pfe.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Mar 2022 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UvxhNuo1pWdGPwLc6pa1lU2igYRccw9Zy2lYHKm+tqE=;
        b=j3BGSMMz077x39VXI5WDuz3dGrSNFzeWRbnGPrs2GZisCmwxX9g0KzulKe1XNjsdch
         DNc1a0DMv+yuJBSmE/+3xjeVF6tB1II9fDiI2//2HE2XHm686I1b0MtOirbUcqSfj0wL
         xhGHDCHOBY5aSxDB2n47oB9IvUh1AhDK91068=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvxhNuo1pWdGPwLc6pa1lU2igYRccw9Zy2lYHKm+tqE=;
        b=gUcHFqZ6CXAGCsp1VRi1dDvz5tST9InIacBDxs8LnFsdfDvsD+ijococDuXaUPc/0N
         g03d7v0rjjSL8U+kmkITFmWUtTq25LiHSyk7ix6ZlVqTEghkPBWhLapnJbJKqeZYhRfQ
         6nKeh0N/v4dcbS2MNYbDazh9u5kj6eULW8VQXeeK00csefzL54X1bYqSXjNf98NPld89
         swmnu6eYmlL13M7zFXB3xnI5vLBOp0xEs843sfH3XiHqIv/AQ3TCHuIJ6WxgT78P00me
         0ShgMWSeKPOPKXiYDMuzzNyU2hOzC8yuG4eK5cAnazcfhrL0icaAs6dyFqlacgTTT+Gz
         0V7w==
X-Gm-Message-State: AOAM530logo21JFO52HuD6XI5jJ84fUJ1wPRLvGikdULjIdKi4ALCrMU
        wj2pnVM1Xb8oJCztSNigNYP/Ag==
X-Google-Smtp-Source: ABdhPJyVVvRyodq7F3sMaUkYdwCNFcxDicKQF/KDk5+fJ3EqXw9JtUH3m/BtiPyz2eanpjv6m7yKaw==
X-Received: by 2002:a63:8bc4:0:b0:380:af7d:4c7a with SMTP id j187-20020a638bc4000000b00380af7d4c7amr1155825pge.162.1646776173626;
        Tue, 08 Mar 2022 13:49:33 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d10-20020a056a00198a00b004f72d2c024asm18620pfl.185.2022.03.08.13.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 13:49:33 -0800 (PST)
Date:   Tue, 8 Mar 2022 13:49:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org
Subject: Re: [GIT PULL] Fix fill_files_note
Message-ID: <202203081342.1924AD9@keescook>
References: <20220131153740.2396974-1-willy@infradead.org>
 <871r0nriy4.fsf@email.froward.int.ebiederm.org>
 <YfgKw5z2uswzMVRQ@casper.infradead.org>
 <877dafq3bw.fsf@email.froward.int.ebiederm.org>
 <YfgPwPvopO1aqcVC@casper.infradead.org>
 <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
 <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
 <87h788fdaw.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h788fdaw.fsf_-_@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:35:03PM -0600, Eric W. Biederman wrote:
> 
> Kees,
> 
> Please pull the coredump-vma-snapshot-fix branch from the git tree:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git coredump-vma-snapshot-fix
> 
>   HEAD: 390031c942116d4733310f0684beb8db19885fe6 coredump: Use the vma snapshot in fill_files_note
> 
> Matthew Wilcox has reported that a missing mmap_lock in file_files_note,
> which could cause trouble.
> 
> Refactor the code and clean it up so that the vma snapshot makes
> it to fill_files_note, and then use the vma snapshot in fill_files_note.
> 
> Eric W. Biederman (5):
>       coredump: Move definition of struct coredump_params into coredump.h
>       coredump: Snapshot the vmas in do_coredump
>       coredump: Remove the WARN_ON in dump_vma_snapshot
>       coredump/elf: Pass coredump_params into fill_note_info
>       coredump: Use the vma snapshot in fill_files_note
> 
>  fs/binfmt_elf.c          | 66 ++++++++++++++++++++++--------------------------
>  fs/binfmt_elf_fdpic.c    | 18 +++++--------
>  fs/binfmt_flat.c         |  1 +
>  fs/coredump.c            | 59 ++++++++++++++++++++++++++++---------------
>  include/linux/binfmts.h  | 13 +---------
>  include/linux/coredump.h | 20 ++++++++++++---
>  6 files changed, 93 insertions(+), 84 deletions(-)
> 
> ---
> 
> Kees I realized I needed to rebase this on Jann Horn's commit
> 84158b7f6a06 ("coredump: Also dump first pages of non-executable ELF
> libraries").  Unfortunately before I got that done I got distracted and
> these changes have been sitting in limbo for most of the development
> cycle.  Since you are running a tree that is including changes like this
> including Jann's can you please pull these changes into your tree.

Sure! Can you make a signed tag for this pull?


If it helps, my workflow look like this, though I assume there might be
better ways. (tl;dr: "git tag -s TAG BRANCH")


PULL_BRANCH=name-of-branch
BASE=sha-of-base
FOR=someone
TOPIC=topic-name

TAG="for-$FOR/$TOPIC"
SIGNED=~/.pull-request-signed-"$TAG"
echo "$TOPIC update" > "$SIGNED"
git request-pull "$BASE" git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git "$PULL_BRANCH" | awk '{print "# " $0}' >> "$SIGNED"
vi "$SIGNED"

git tag -sF "$SIGNED" "$TAG" "$PULL_BRANCH"
git push origin "$PULL_BRANCH"
git push origin +"$TAG"


-- 
Kees Cook
