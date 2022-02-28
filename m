Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A914C7DD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 23:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiB1WyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 17:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiB1WyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:54:07 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEB11C5
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 14:53:27 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id t5so3345838pfg.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Feb 2022 14:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zibmIXYjhxaupOk9s0xWr7duCuTjugvyvgKLHyYpgFE=;
        b=iCpxXt6G0aThtvRUcLNU8SriL190rIC2M+2t85Gz/EPinufDECNpaCnslsRSQAk3ep
         MPSStIzbBpIxl3lRd+df6HbZ3lim+gftRnXLHB8sidpRHKV2QhZoSgXk99khZDcvuzcT
         Spee0qr8TUPt+3I4rqnlZ4mG/KhdXvQrBaZQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zibmIXYjhxaupOk9s0xWr7duCuTjugvyvgKLHyYpgFE=;
        b=MAyTjN9Drq8OPasqGOSd0mqc+lFQP45IzYBcWLooLho7J7X/KhvpDUvhE/E5Y1MtAJ
         HfZUyxVRtKrLiCIt809uS/TG02GmsBK2/rACNfCrKL2nHGp8OPlcJItcklMfFPnD95kv
         KadM+C04fPYBmjnlJOgsAyng0kFH1PlAyn3TUw65Drzn2kcKpzCmiwlra3kSc09zzO9H
         6yJsjERlasOcJXGMyaJAuLzxB04iR3SHpEHTaCEr+SNUV8bq9aUsvSGTYvy3mvoHrj0c
         E2hc0L/EhS3gvHDDH3dcSPU4l3+TIZZvdmWckUCDmwNRavl7jOwUy62+RsUo+B1DEWd0
         bX9Q==
X-Gm-Message-State: AOAM532HbPZjm15J63RaH5bVO9m9luIpmFrIi1o47mhWucvNqQxF1BTR
        Lgo22FeY6Vv8j+l2jMLzsNn1lg==
X-Google-Smtp-Source: ABdhPJzHZGv/HnLcdSxWcXgVP/q5WimYbT2Car4mVv68atOJnIPOjOQrAQTFGQxx45g0YLdkIV/MsA==
X-Received: by 2002:a65:6210:0:b0:374:ba5:aacc with SMTP id d16-20020a656210000000b003740ba5aaccmr18921903pgv.8.1646088806198;
        Mon, 28 Feb 2022 14:53:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f9-20020a056a00228900b004f3ba7d177csm14943547pfe.54.2022.02.28.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 14:53:25 -0800 (PST)
Date:   Mon, 28 Feb 2022 14:53:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        stable@vger.kernel.org,
        Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        regressions@lists.linux.dev, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 5.16 v2] binfmt_elf: Avoid total_mapping_size for ET_EXEC
Message-ID: <202202281452.93E321A39@keescook>
References: <20220228205518.1265798-1-keescook@chromium.org>
 <ce8af9c13bcea9230c7689f3c1e0e2cd@matoro.tk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce8af9c13bcea9230c7689f3c1e0e2cd@matoro.tk>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 28, 2022 at 05:14:26PM -0500, matoro wrote:
> On 2022-02-28 15:55, Kees Cook wrote:
> > Partially revert commit 5f501d555653 ("binfmt_elf: reintroduce using
> > MAP_FIXED_NOREPLACE").
> > 
> > At least ia64 has ET_EXEC PT_LOAD segments that are not virtual-address
> > contiguous (but _are_ file-offset contiguous). This would result in
> > giant mapping attempts to cover the entire span, including the virtual
> > address range hole. Disable total_mapping_size for ET_EXEC, which
> > reduces the MAP_FIXED_NOREPLACE coverage to only the first PT_LOAD:
> > 
> > $ readelf -lW /usr/bin/gcc
> > ...
> > Program Headers:
> >   Type Offset   VirtAddr           PhysAddr           FileSiz  MemSiz
> > ...
> > ...
> >   LOAD 0x000000 0x4000000000000000 0x4000000000000000 0x00b5a0 0x00b5a0
> > ...
> >   LOAD 0x00b5a0 0x600000000000b5a0 0x600000000000b5a0 0x0005ac 0x000710
> > ...
> > ...
> >        ^^^^^^^^ ^^^^^^^^^^^^^^^^^^                    ^^^^^^^^ ^^^^^^^^
> > 
> > File offset range     : 0x000000-0x00bb4c
> > 			0x00bb4c bytes
> > 
> > Virtual address range : 0x4000000000000000-0x600000000000bcb0
> > 			0x200000000000bcb0 bytes
> > 
> > Ironically, this is the reverse of the problem that originally caused
> > problems with ET_EXEC and MAP_FIXED_NOREPLACE: overlaps. This problem is
> > with holes. Future work could restore full coverage if load_elf_binary()
> > were to perform mappings in a separate phase from the loading (where
> > it could resolve both overlaps and holes).
> > 
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Reported-by: matoro <matoro_mailinglist_kernel@matoro.tk>
> > Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using
> > MAP_FIXED_NOREPLACE")
> > Link:
> > https://lore.kernel.org/r/a3edd529-c42d-3b09-135c-7e98a15b150f@leemhuis.info
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Here's the v5.16 backport.
> > ---
> >  fs/binfmt_elf.c | 25 ++++++++++++++++++-------
> >  1 file changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index f8c7f26f1fbb..911a9e7044f4 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1135,14 +1135,25 @@ static int load_elf_binary(struct linux_binprm
> > *bprm)
> >  			 * is then page aligned.
> >  			 */
> >  			load_bias = ELF_PAGESTART(load_bias - vaddr);
> > -		}
> > 
> > -		/*
> > -		 * Calculate the entire size of the ELF mapping (total_size).
> > -		 * (Note that load_addr_set is set to true later once the
> > -		 * initial mapping is performed.)
> > -		 */
> > -		if (!load_addr_set) {
> > +			/*
> > +			 * Calculate the entire size of the ELF mapping
> > +			 * (total_size), used for the initial mapping,
> > +			 * due to first_pt_load which is set to false later
> > +			 * once the initial mapping is performed.
> > +			 *
> > +			 * Note that this is only sensible when the LOAD
> > +			 * segments are contiguous (or overlapping). If
> > +			 * used for LOADs that are far apart, this would
> > +			 * cause the holes between LOADs to be mapped,
> > +			 * running the risk of having the mapping fail,
> > +			 * as it would be larger than the ELF file itself.
> > +			 *
> > +			 * As a result, only ET_DYN does this, since
> > +			 * some ET_EXEC (e.g. ia64) may have virtual
> > +			 * memory holes between LOADs.
> > +			 *
> > +			 */
> >  			total_size = total_mapping_size(elf_phdata,
> >  							elf_ex->e_phnum);
> >  			if (!total_size) {
> 
> This does the trick!  Thank you so much!!

Excellent; thank you for testing! I'll send this to Linus shortly.

-- 
Kees Cook
