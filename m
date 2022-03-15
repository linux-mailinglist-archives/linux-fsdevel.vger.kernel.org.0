Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE184DA412
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Mar 2022 21:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351740AbiCOUi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 16:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244652AbiCOUi6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 16:38:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C74BFFD
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 13:37:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so3269544pjb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2SjlFuTvdI+/x8XXiMs+YY131MZzREL4QXlv7A56cUE=;
        b=QiGAEg9rYwqAARR3PZAMwuxch8LUkYCPEOSxE3NzNLyxm13uuFXgqJl8leLjE24Bc8
         stapljuf79sK8mjI53Uhjd1Jt1TdhB9C4MaUcI62/Ul2eWOlUr8qasJREVYvoZgVFPZH
         tPNPN+lwpehLMqGKpfWjeDd6gVBkfMWbKU51s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2SjlFuTvdI+/x8XXiMs+YY131MZzREL4QXlv7A56cUE=;
        b=mwzEwVp5aUkctckUE2PoFcDYgyaYtWVTuwikdkdXR/vBYTxA9NdtqQcAGVnvBYjSRB
         lCXJSeNKPQpYo2Hj5wAU/jnIRqpDAKmLndTacbY22MNsYwfYCGvRJFiMsPp+TiOv7iT5
         PPJVijGr78VJfWiT6f4lbCnYic/2g7GN3i09pqHOfxP3sd19uPyS+4lh9n5lsCjhWHI+
         6/QOBje+WNnLLGJ6EkaSn99oTaTDVew6S4SF+inn5lElsH6bD6AfURlEuA2HWwOdOL47
         wO9lUedvTAjQZuzyekBGdQfTTTX93rAWtcEE6CEGRZJ4xDvhde+fUizEyUytwtr4peIM
         Qzng==
X-Gm-Message-State: AOAM532oOXFgNuoYvyCUZVpfdgbWtE2rKE8oKWqt4J58l5uQzaBptHKS
        P36V4A6POBNGQZU16P6Siiarfg==
X-Google-Smtp-Source: ABdhPJxk8N1Im2OHQ8whN6QrGAOXCDXJUU+6W4tjKYIdJnnQli+gJ4l7Vc65sC/0hZYttobd2vt2Gg==
X-Received: by 2002:a17:90a:4590:b0:1bc:4afa:1778 with SMTP id v16-20020a17090a459000b001bc4afa1778mr6654452pjg.14.1647376664429;
        Tue, 15 Mar 2022 13:37:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q11-20020a056a00084b00b004f73e6c26b8sm25786493pfk.25.2022.03.15.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 13:37:44 -0700 (PDT)
Date:   Tue, 15 Mar 2022 13:37:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH 3/3] elf: Don't write past end of notes for regset gap
Message-ID: <202203151329.0483BED@keescook>
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
 <20220315201706.7576-4-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315201706.7576-4-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 15, 2022 at 01:17:06PM -0700, Rick Edgecombe wrote:
> In fill_thread_core_info() the ptrace accessible registers are collected
> to be written out as notes in a core file. The note array is allocated
> from a size calculated by iterating the user regset view, and counting the
> regsets that have a non-zero core_note_type. However, this only allows for
> there to be non-zero core_note_type at the end of the regset view. If
> there are any gaps in the middle, fill_thread_core_info() will overflow the
> note allocation, as it iterates over the size of the view and the
> allocation would be smaller than that.
> 
> There doesn't appear to be any arch that has gaps such that they exceed
> the notes allocation, but the code is brittle and tries to support
> something it doesn't. It could be fixed by increasing the allocation size,
> but instead just have the note collecting code utilize the array better.
> This way the allocation can stay smaller.
> 
> Even in the case of no arch's that have gaps in their regset views, this
> introduces a change in the resulting indicies of t->notes. It does not
> introduce any changes to the core file itself, because any blank notes are
> skipped in write_note_info().

Hm, yes, fill_note_info() does an initial count & allocate. Then
fill_thread_core_info() writes them.

> 
> This fix is derrived from an earlier one[0] by Yu-cheng Yu.
> 
> [0] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/
> 
> Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  fs/binfmt_elf.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index d61543fbd652..a48f85e3c017 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1757,7 +1757,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  				 const struct user_regset_view *view,
>  				 long signr, size_t *total)
>  {
> -	unsigned int i;
> +	unsigned int note_iter, view_iter;
>  
>  	/*
>  	 * NT_PRSTATUS is the one special case, because the regset data
> @@ -1777,11 +1777,11 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  
>  	/*
>  	 * Each other regset might generate a note too.  For each regset
> -	 * that has no core_note_type or is inactive, we leave t->notes[i]
> -	 * all zero and we'll know to skip writing it later.
> +	 * that has no core_note_type or is inactive, skip it.
>  	 */
> -	for (i = 1; i < view->n; ++i) {
> -		const struct user_regset *regset = &view->regsets[i];
> +	note_iter = 1;
> +	for (view_iter = 1; view_iter < view->n; ++view_iter) {
> +		const struct user_regset *regset = &view->regsets[view_iter];
>  		int note_type = regset->core_note_type;
>  		bool is_fpreg = note_type == NT_PRFPREG;
>  		void *data;
> @@ -1800,10 +1800,11 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  		if (is_fpreg)
>  			SET_PR_FPVALID(&t->prstatus);
>  

info->thread_notes contains the count. Since fill_thread_core_info()
passes a info member by reference, it might make sense to just pass info
itself, then the size can be written and a bounds-check can be added
here:

		if (WARN_ON_ONCE(i >= info->thread_notes))
			continue;

> -		fill_note(&t->notes[i], is_fpreg ? "CORE" : "LINUX",
> +		fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
>  			  note_type, ret, data);
>  
> -		*total += notesize(&t->notes[i]);
> +		*total += notesize(&t->notes[note_iter]);
> +		note_iter++;
>  	}
>  
>  	return 1;
> -- 
> 2.17.1
> 

If that can get adjusted, I'd be happy to carry this patch separately in
for-next/execve (or I can Ack it and it can go with the others here in
the series).

(And in a perfect world, I'd *love* a KUnit test to exercise this logic,
but I don't think we're there yet with function mocking, etc.)

-- 
Kees Cook
