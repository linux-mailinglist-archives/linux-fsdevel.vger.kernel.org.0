Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1A17BE924
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 20:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377059AbjJISWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 14:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjJISWM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:22:12 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2739C;
        Mon,  9 Oct 2023 11:22:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-406650da82bso44917355e9.3;
        Mon, 09 Oct 2023 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696875729; x=1697480529; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QNPXDJmDq42P4SZjOQqWUU6xEKR95NGLabdo7NuFsU4=;
        b=B77Q/a9udVAkRDqjcOskJW04XPM0901RpE4vkuxRXvR3nMpok0elwfNw01uwsUeVXO
         lfZ0vi/AmOSm817tYLyuDVkkoEl8rWLzwrYnFjhB3K753trOLdvuQ6cfAoKrVbGyA2t4
         5TAoOXEN9KCifMQwcSI6WWQmpM0yTpenHVUgomODAgHAjMtn7ivsAn/woo19NVGvp5P+
         ZE+gRcOKkBfKiE3egG+AHMsZ1Fw3OHMXabs4HkB99lSRA9q+Wt059zTYoq//PBoF9tgI
         N6n5nzjZ5drSAEUpDnXzBHKrOuUXE+Rnrr63gCoAPwGY57YyQZX83EyUS9oGJZIvwVZd
         oshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696875729; x=1697480529;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNPXDJmDq42P4SZjOQqWUU6xEKR95NGLabdo7NuFsU4=;
        b=E4HnzPFukmAcM50WkUjBF56qMm4N/tSArY/isaXf364URCmWOzPKzcwGN0YR2QRjBy
         qHcce2shkdfkr5cHEdV4GE3jvWN9w1187SEmTGv0sswTk1VWTEe1A5E3mqFFUnZXiswO
         yykVImjF/9Yydc4tguNrD88rV2z4liBYiNnqz+IlsbObpP0721QtAOZez4boC6+tS1lA
         6JoshQyQBrvqV2+MJLZvrodG9EesS/fB3IcPzN9Hh98Dr6AOc8LbzcQaddFc8yOJOeUl
         XvZdlPwMr0+AWatNXio1D2f8sA/vuXS+XrX29KBRyMQjUPwCXo+VFRGNvHSsoqmM8tnt
         kupg==
X-Gm-Message-State: AOJu0YxLHNP1j+UppeO3qeP5F79stAeynoNHNk+vLAXch6uN4ugYPw6C
        WkadMVlM0Hro1ORX0RuSME8=
X-Google-Smtp-Source: AGHT+IHR2xRRbxNnab9DHaoT1EeT+jNkKBJnPaPxUsiGf2iimUXeIORzdS4S4PZWTPgbrj2p76PN+w==
X-Received: by 2002:a05:600c:5103:b0:406:8498:3d3a with SMTP id o3-20020a05600c510300b0040684983d3amr13864929wms.14.1696875729027;
        Mon, 09 Oct 2023 11:22:09 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b004063cced50bsm11885043wmc.23.2023.10.09.11.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 11:22:07 -0700 (PDT)
Date:   Mon, 9 Oct 2023 19:22:07 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "=Liam R . Howlett" <Liam.Howlett@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: abstract VMA extension and merge into
 vma_merge_extend() helper
Message-ID: <ba75d32d-521a-4c8d-8b4c-fa491131e262@lucifer.local>
References: <cover.1696795837.git.lstoakes@gmail.com>
 <1ed3d1ba0069104e1685298aa2baf980c38a85ff.1696795837.git.lstoakes@gmail.com>
 <fe147a1e-6fe5-309f-b2e7-48f5f3c97bae@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe147a1e-6fe5-309f-b2e7-48f5f3c97bae@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 09, 2023 at 06:30:02PM +0200, Vlastimil Babka wrote:
> On 10/8/23 22:23, Lorenzo Stoakes wrote:
> > mremap uses vma_merge() in the case where a VMA needs to be extended. This
> > can be significantly simplified and abstracted.
> >
> > This makes it far easier to understand what the actual function is doing,
> > avoids future mistakes in use of the confusing vma_merge() function and
> > importantly allows us to make future changes to how vma_merge() is
> > implemented by knowing explicitly which merge cases each invocation uses.
> >
> > Note that in the mremap() extend case, we perform this merge only when
> > old_len == vma->vm_end - addr. The extension_start, i.e. the start of the
> > extended portion of the VMA is equal to addr + old_len, i.e. vma->vm_end.
> >
> > With this refactoring, vma_merge() is no longer required anywhere except
> > mm/mmap.c, so mark it static.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
> Nit:
> > @@ -2546,6 +2546,24 @@ static struct vm_area_struct *vma_merge_new_vma(struct vma_iterator *vmi,
> >  			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> >  }
> >
> > +/*
> > + * Expand vma by delta bytes, potentially merging with an immediately adjacent
> > + * VMA with identical properties.
> > + */
> > +struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> > +					struct vm_area_struct *vma,
> > +					unsigned long delta)
> > +{
> > +	pgoff_t pgoff = vma->vm_pgoff +
> > +		((vma->vm_end - vma->vm_start) >> PAGE_SHIFT);
>
> could use vma_pages() here

Will update in v2.

>
> > +
> > +	/* vma is specified as prev, so case 1 or 2 will apply. */
> > +	return vma_merge(vmi, vma->vm_mm, vma, vma->vm_end, vma->vm_end + delta,
> > +			 vma->vm_flags, vma->anon_vma, vma->vm_file, pgoff,
> > +			 vma_policy(vma), vma->vm_userfaultfd_ctx,
> > +			 anon_vma_name(vma));
> > +}
> > +
> >  /*
> >   * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
> >   * @vmi: The vma iterator
