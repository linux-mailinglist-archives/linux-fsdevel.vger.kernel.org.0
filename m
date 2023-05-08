Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBAD6FB20E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 May 2023 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbjEHN4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 May 2023 09:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjEHN4a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 May 2023 09:56:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B3436550
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 May 2023 06:56:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so13269345e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 May 2023 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683554188; x=1686146188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19DXl8Cwep38RZYqA5V880Y84eA06vdWD+RdS89kIwI=;
        b=IM/Li4tQnctEvBZh4oCQjtD2S9HXII5srZDmexgQ9NoiUkuflTBSCScJ45Davd4Fip
         8xPJSKjPcZgfPGtTn5k9vYIuoXLki8ka/RmskSFmCqkXEpIoE/ZQxMzXNfvkQV0iVK+B
         PSVrmE6Jb6FKpy45HvEloo7Ot4O9wAP6nJ0NGTOoHNdzxt2GouD4hb32d/fyT/60venS
         SJzkFTf6CDA5i0tzASHBQeERoAW+ZTXUGXDURhH0D1ogVO/0yTd2OWJ6B6mHhkAxk+po
         KAyALZDE8kh4nq+uFzAPRbkU3NOoxUesaFWgOZz5oNmKu6mOIZ7mrQEPr63AqgfcxgLv
         yDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683554188; x=1686146188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=19DXl8Cwep38RZYqA5V880Y84eA06vdWD+RdS89kIwI=;
        b=PARfEIMxtcTdOSmT6aok80wj6WHmVczMJ5eQ+AS+dp08/tH7jkTc9QhNWABQpxNAhH
         jKrt4/y4Mw6sUFXKClmWaneS9gSnPl2LZVDO9WQp6w+7O4vyiqgmaG4uLWtkfMcslUjs
         xFglJcKNXIGGWC6YjaPC65MUpMA9+Mxeue68tXYOod8wHmZYaQPADdzeHrh9rqL8JgXo
         VO8CfKKX+tJHRyGYrMNRETVCltQNJGnFhQa41xzDF/f9LosAm9hU5PFdo4va6wNLY3Gr
         PqSrvjoRb/WUpPyLRTYNZjczGSyJ1JDKXMIkxAndelRRqtaM3XBDldfU3bNcsqmMwJ/d
         GY0A==
X-Gm-Message-State: AC+VfDylAfkqnz0hmmSz0dnlofHfNr4dYevqMy/8O5/5UlsEdvHWHiAe
        /JJDXt6RWEW4088QU+dR6RHFeQ==
X-Google-Smtp-Source: ACHHUZ5S+Sjuq/JaIdy19cG3DkzAGZ/DgPbwOzlGd4hs3OiK6fImSIKlZtG8kQghbUgkcfcfS66nxA==
X-Received: by 2002:a05:600c:218:b0:3f4:28fd:83e0 with SMTP id 24-20020a05600c021800b003f428fd83e0mr653771wmi.31.1683554187831;
        Mon, 08 May 2023 06:56:27 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003f3e50eb606sm16741700wma.13.2023.05.08.06.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 06:56:25 -0700 (PDT)
Date:   Mon, 8 May 2023 16:56:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+48011b86c8ea329af1b9@syzkaller.appspotmail.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] filemap: Handle error return from __filemap_get_folio()
Message-ID: <7bd22265-f46c-4347-a856-eecd1429dcce@kili.mountain>
References: <20230506160415.2992089-1-willy@infradead.org>
 <CAHk-=winrN4jsysShx0kWKVzmSMu7Pp3nz_6+aps9CP+v-qHWQ@mail.gmail.com>
 <CAHk-=winai-5i6E1oMk7hXPfbP+SCssk5+TOLCJ3koaDrn7Bzg@mail.gmail.com>
 <CAHk-=wiZ0GaAdqyke-egjBRaqP-QdLcX=8gNk7m6Hx7rXjcXVQ@mail.gmail.com>
 <CAHk-=whfNqsZVjy1EWAA=h7D0K2o4D8MSdnK8Qytj2BBhhFrSQ@mail.gmail.com>
 <CAHk-=wjzs7jHyp_SmT6h1Hnwu39Vuc0DuUxndwf2kL3zhyiCcw@mail.gmail.com>
 <20230506104122.e9ab27f59fd3d8294cb1356d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506104122.e9ab27f59fd3d8294cb1356d@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 06, 2023 at 10:41:22AM -0700, Andrew Morton wrote:
> --- a/fs/afs/dir_edit.c~afs-fix-the-afs_dir_get_folio-return-value
> +++ a/fs/afs/dir_edit.c
> @@ -115,11 +115,12 @@ static struct folio *afs_dir_get_folio(s
>  	folio = __filemap_get_folio(mapping, index,
>  				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
>  				    mapping->gfp_mask);
> -	if (IS_ERR(folio))
> +	if (IS_ERR(folio)) {
>  		clear_bit(AFS_VNODE_DIR_VALID, &vnode->flags);
> -	else if (folio && !folio_test_private(folio))
> +		return NULL;
> +	}
> +	if (!folio_test_private(folio))
>  		folio_attach_private(folio, (void *)1);
> -
>  	return folio;
>  }

This one is quite tricky for Smatch.  I mentioned earlier that the
existing Smatch check for error pointer dereferences has some stupid
stuff going on.  I've replaced some of the stupid and I'll testing it
tonight.

1)  There is an existing check which complains if you have "if (p) "
    where p can be an error pointer, but not NULL.  If I revert the fix,
    I get the correct warning now.

    fs/afs/dir_edit.c:242 afs_edit_dir_add()
    warn: 'folio0' is an error pointer or valid *NEW*

2) There is an existing check for dereferencing error pointers.  However,
   I don't think kmap_local_folio() actually  dereferences the folio.
   The folio_nr_pages() function does, but depending on the .config,
   it's kind of complicated and buried inside a READ_ONCE().  I've
   improved the Smatch code for this but I don't have a solution yet.

3) I've created a new warning which generally complains about passing
   error pointers.  Obviously there are functions where that's normal,
   like passing error pointers to IS_ERR() and dev_err_probe().  It
   may or may not be useful.  I'll look at the warnings tomorrow.

    fs/afs/dir_edit.c:265 afs_edit_dir_add()
    warn: passing error pointer 'folio0' to folio_nr_pages()

regards,
dan carpenter
