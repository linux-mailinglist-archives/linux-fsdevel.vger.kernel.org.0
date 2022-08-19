Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D735599A2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 12:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348413AbiHSKxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 06:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348389AbiHSKxk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 06:53:40 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DCD29CB3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 03:53:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dc19so8048671ejb.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 03:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=vBMDaqWDKEZpAM5U5uRDZM2qZ+bVxGPTqcknyPxrAkk=;
        b=k8KcnyyIO8583kAqR7BJvj8IXFbdS1YtXCbda17OUo/bVOfB2cx7/GIWjS/awQdiz1
         rkylTtVS4H3rmfn9WheN+G4itwj4mtcu3HbiejgT45iNa8QeT6uLP3XdvVbYKC44oe2v
         C1naobgTxqO21F/ry9gV6pkJN/CPBd3HC5VAKe0AqUl6NCESQnv8NEGmo3pkqJU0lvu2
         dbIwD/a3aRR8bF4jg4nOL7i/a3IbJLmLDAfpXq7I5iWoIBYOxPwF+Gijjw7TUtVs/d41
         WDKZQEQwyTVYoyx9gYxsZrpT6u+iTS3JQZLxhqNThLM6BpWVomUGG4waOqYmo9+WzZ63
         uVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=vBMDaqWDKEZpAM5U5uRDZM2qZ+bVxGPTqcknyPxrAkk=;
        b=fJmNWd1VAMiS+ZkA5WlFLuMIICzXrcFmh9qznmppuDtpt0vzdQyAJ4vrOAEc0fc+jd
         27BmSjvGk+E+kg6iHzk583lJSw4ltsvOF6YDwwnUkAfgKrNyZ7E9gGjqSv9tusk487Ph
         HAGP/6r4QRB/NEkzxZkfe5gF3Q1AMR/YyOT6zTiQJWrYhGX1vbpno/KibURJe9jlrl6k
         YRr2oHzVXAyubHdA40GGPa/D5vVJz/x8deDw23n+UcozfrrwzC+OK+dk2/XkKSR+9GfW
         uCpdz+oFpkH3uf22072/zrK80KF6tOMOBKw2m2LNlLBNK4+pNLzhetP821xj2AK9C9h4
         D93g==
X-Gm-Message-State: ACgBeo1acMaG6yyPxPGt5w8oAuxZW02FYqHEdfPaUDy2izLudBDq9hg6
        VL4iFUx6mtpGYih20A8ux3k=
X-Google-Smtp-Source: AA6agR78DstU7QO1upcnXEjS/dlvS1K8wYT8OsVEOzsKzEO+05sLFlwNtaBG0l/0KREMsAEe6gfA2w==
X-Received: by 2002:a17:907:c10:b0:731:58aa:7783 with SMTP id ga16-20020a1709070c1000b0073158aa7783mr4688809ejc.19.1660906415536;
        Fri, 19 Aug 2022 03:53:35 -0700 (PDT)
Received: from pc636 (host-90-235-9-70.mobileonline.telia.com. [90.235.9.70])
        by smtp.gmail.com with ESMTPSA id b15-20020a17090630cf00b0073180489522sm2131178ejb.118.2022.08.19.03.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 03:53:35 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 19 Aug 2022 12:53:32 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC] vmap_folio()
Message-ID: <Yv9rrDY2qukhvzs5@pc636>
References: <YvvdFrtiW33UOkGr@casper.infradead.org>
 <Yv6qtlSGsHpg02cT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv6qtlSGsHpg02cT@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 10:10:14PM +0100, Matthew Wilcox wrote:
> On Tue, Aug 16, 2022 at 07:08:22PM +0100, Matthew Wilcox wrote:
> > For these reasons, I proposing the logical equivalent to this:
> > 
> > +void *folio_map_local(struct folio *folio)
> > +{
> > +       if (!IS_ENABLED(CONFIG_HIGHMEM))
> > +               return folio_address(folio);
> > +       if (!folio_test_large(folio))
> > +               return kmap_local_page(&folio->page);
> > +       return vmap_folio(folio);
> > +}
> > 
> > (where vmap_folio() is a new function that works a lot like vmap(),
> > chunks of this get moved out-of-line, etc, etc., but this concept)
> 
> This vmap_folio() compiles but is otherwise untested.  Anything I
> obviously got wrong here?
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dd6cdb201195..1867759c33ff 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2848,6 +2848,42 @@ void *vmap(struct page **pages, unsigned int count,
>  }
>  EXPORT_SYMBOL(vmap);
>  
> +#ifdef CONFIG_HIGHMEM
> +/**
> + * vmap_folio - Map an entire folio into virtually contiguous space
> + * @folio: The folio to map.
> + *
> + * Maps all pages in @folio into contiguous kernel virtual space.  This
> + * function is only available in HIGHMEM builds; for !HIGHMEM, use
> + * folio_address().  The pages are mapped with PAGE_KERNEL permissions.
> + *
> + * Return: The address of the area or %NULL on failure
> + */
> +void *vmap_folio(struct folio *folio)
> +{
> +	size_t size = folio_size(folio);
> +	struct vm_struct *area;
> +	unsigned long addr;
> +
> +	might_sleep();
> +
> +	area = get_vm_area_caller(size, VM_MAP, __builtin_return_address(0));
> +	if (!area)
> +		return NULL;
> +
> +	addr = (unsigned long)area->addr;
> +	if (vmap_range_noflush(addr, addr + size,
> +				folio_pfn(folio) << PAGE_SHIFT,
> +				PAGE_KERNEL, folio_shift(folio))) {
> +		vunmap(area->addr);
> +		return NULL;
> +	}
> +	flush_cache_vmap(addr, addr + size);
> +
> +	return area->addr;
> +}
> +#endif
> +
Looks pretty straightforward. One thing though, if we can combine it
together with vmap(), since it is a copy paste in some sense, say to
have something __vmap() to reuse it in the vmap_folio() and vmap().

But that is just a thought.

--
Uladzislau Rezki
