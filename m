Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA646AD3A6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 02:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjCGBB3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Mar 2023 20:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCGBB2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Mar 2023 20:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BAC303DE
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Mar 2023 17:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678150839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VHFntejT56JbD/rUEQWs9tWFnUbRv9RbZFyVXVHrMio=;
        b=dj2/2ErKB18ReCVgFiujYVsWFdllbOvi5wMkY2PhU5AaXJ3ufzhDlAw42w858fC2AsdA/C
        rGrcaA4As8C2qT1dlTTJUVTOX+vcbotG7xS1WUEGsNjRlwBQU4BQplZN4IuAezWKek1Vbg
        SlNQAphxPEw0WJZBiklwgpzyAVTw6bM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-0XGBsVA6Moqd-t0PSzFeSg-1; Mon, 06 Mar 2023 20:00:38 -0500
X-MC-Unique: 0XGBsVA6Moqd-t0PSzFeSg-1
Received: by mail-qt1-f200.google.com with SMTP id h21-20020ac87d55000000b003bffb1c9745so6235206qtb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Mar 2023 17:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678150838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHFntejT56JbD/rUEQWs9tWFnUbRv9RbZFyVXVHrMio=;
        b=2z9YPnKrVZRw+oW8cw3gWTZtQwWFEL+CGqJ9TJakEn7N3gYjVC7JRie2egYeTrxM+x
         nVujlGeJ77oUZfiURH8Sg6aJEQ7NLn0sZRDakFUUA3sfqpnRq+7fa8hsoMXQZQWOK+3q
         STDiZw4KxqUy58I2CcOp41nV44FQ9i3myt6u+EZvLgJSbDX+BBUdFbx4P8FoLMTfvhOE
         XAgsXwWxqhAvidVa0QTORvXCFROp4iyBHeoFsIAuLT5685iGrWAismPDZ5VUOGbWm1EK
         atAZFIT2kmhKxJRyZn7nWE1fRdMfa1mktrTCuJ4+gOYzt89gd88VdTrUUJLLrm66ilqL
         rg/w==
X-Gm-Message-State: AO0yUKWXMmh2qQPNVis8m9Zr2zaEDt1G34CWDMB2c3iqC+e3uwZU6BAK
        fQ1W37VOvSG6DZEUVmZ7N8eSAciA/X8mOzsxCAYy5oxISI1MlydbF0Q9P1KyvWSbRLLYHnETmhD
        BJzJ0z7R5gujBA+13J2z71wt/6w==
X-Received: by 2002:ac8:4e49:0:b0:3bf:a564:573b with SMTP id e9-20020ac84e49000000b003bfa564573bmr22624855qtw.0.1678150837983;
        Mon, 06 Mar 2023 17:00:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9mNewiLEJ/Qcl0fkXX58JVHG+qYCqPmSyNkMCeEvogUl0mdbdtpfbHSmtHHB3rrhxwI1DA3g==
X-Received: by 2002:ac8:4e49:0:b0:3bf:a564:573b with SMTP id e9-20020ac84e49000000b003bfa564573bmr22624808qtw.0.1678150837670;
        Mon, 06 Mar 2023 17:00:37 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id v25-20020ac873d9000000b003c033b23a9asm1407231qtp.12.2023.03.06.17.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 17:00:37 -0800 (PST)
Date:   Mon, 6 Mar 2023 20:00:35 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Message-ID: <ZAaMs44nspRQJmrk@x1n>
References: <20230306225024.264858-1-axelrasmussen@google.com>
 <20230306225024.264858-4-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306225024.264858-4-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:50:22PM -0800, Axel Rasmussen wrote:
> Many userfaultfd ioctl functions take both a 'mode' and a 'wp_copy'
> argument. In future commits we plan to plumb the flags through to more
> places, so we'd be proliferating the very long argument list even
> further.
> 
> Let's take the time to simplify the argument list. Combine the two
> arguments into one - and generalize, so when we add more flags in the
> future, it doesn't imply more function arguments.
> 
> Since the modes (copy, zeropage, continue) are mutually exclusive, store
> them as an integer value (0, 1, 2) in the low bits. Place combine-able
> flag bits in the high bits.
> 
> This is quite similar to an earlier patch proposed by Nadav Amit
> ("userfaultfd: introduce uffd_flags" - for some reason Lore no longer
> has a copy of the patch). The main difference is that patch only handled

Lore has. :)

https://lore.kernel.org/all/20220619233449.181323-2-namit@vmware.com

And btw sorry to review late.

> flags, whereas this patch *also* combines the "mode" argument into the
> same type to shorten the argument list.
> 
> Acked-by: James Houghton <jthoughton@google.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Mostly good to me, a few nitpicks below.

[...]

> +/* A combined operation mode + behavior flags. */
> +typedef unsigned int __bitwise uffd_flags_t;
> +
> +/* Mutually exclusive modes of operation. */
> +enum mfill_atomic_mode {
> +	MFILL_ATOMIC_COPY = (__force uffd_flags_t) 0,
> +	MFILL_ATOMIC_ZEROPAGE = (__force uffd_flags_t) 1,
> +	MFILL_ATOMIC_CONTINUE = (__force uffd_flags_t) 2,
> +	NR_MFILL_ATOMIC_MODES,
>  };

I never used enum like this.  I had a feeling that this will enforce
setting the enum entries but would the enforce applied to later
assignments?  I'm not sure.

I had a quick test and actually I found sparse already complains about
calculating the last enum entry:

---8<---
$ cat a.c
typedef unsigned int __attribute__((bitwise)) flags_t;

enum {
    FLAG1 = (__attribute__((force)) flags_t) 0,
    FLAG_NUM,
};

void main(void)
{
    uffd_flags_t flags = FLAG1;
}
$ sparse a.c
a.c:5:5: error: can't increment the last enum member
---8<---

Maybe just use the simple "#define"s?

>  
> +#define MFILL_ATOMIC_MODE_BITS (const_ilog2(NR_MFILL_ATOMIC_MODES - 1) + 1)

Here IIUC it should be "const_ilog2(NR_MFILL_ATOMIC_MODES) + 1", but
maybe..  we don't bother and define every bit explicitly?

> +#define MFILL_ATOMIC_BIT(nr) ((__force uffd_flags_t) BIT(MFILL_ATOMIC_MODE_BITS + (nr)))
> +#define MFILL_ATOMIC_MODE_MASK (MFILL_ATOMIC_BIT(0) - 1)
> +
> +/* Flags controlling behavior. */
> +#define MFILL_ATOMIC_WP MFILL_ATOMIC_BIT(0)

[...]

> @@ -312,9 +312,9 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  					      unsigned long dst_start,
>  					      unsigned long src_start,
>  					      unsigned long len,
> -					      enum mcopy_atomic_mode mode,
> -					      bool wp_copy)
> +					      uffd_flags_t flags)
>  {
> +	int mode = flags & MFILL_ATOMIC_MODE_MASK;
>  	struct mm_struct *dst_mm = dst_vma->vm_mm;
>  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
>  	ssize_t err;
> @@ -333,7 +333,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	 * by THP.  Since we can not reliably insert a zero page, this
>  	 * feature is not supported.
>  	 */
> -	if (mode == MCOPY_ATOMIC_ZEROPAGE) {
> +	if (mode == MFILL_ATOMIC_ZEROPAGE) {

The mode comes from "& MFILL_ATOMIC_MODE_MASK" but it doesn't quickly tell
whether there's a shift for the mask.

Would it look better we just have a helper to fetch the mode?  The function
tells that whatever it returns must be the mode:

       if (uffd_flags_get_mode(flags) == MFILL_ATOMIC_ZEROPAGE)

We also avoid quite a few "mode" variables.  All the rest bits will be fine
to use "flags & FLAG1" if it's a boolean (so only this "mode" is slightly
tricky).

What do you think?

Thanks,

-- 
Peter Xu

