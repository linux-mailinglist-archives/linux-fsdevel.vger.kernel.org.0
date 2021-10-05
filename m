Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1F1423473
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 01:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhJEX25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 19:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236820AbhJEX24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:28:56 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C1C06174E
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 16:27:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id w11so442908plz.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 16:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9OW4RL81pIUdiw+zgh4jW1IlqFN74R1uy0F7HjdiocU=;
        b=JZe8Zhyu74F7LosaheIebMyt7o4GfPbBCkYP/9wP2Cz5wX4KOE7XbbNeECWc00RqwW
         wymyCg5V4ISRFq70VFTRDxHHKuIE3mZZh+D57pJGZrVYnSdYfT30twuDKw46x2HF+sfr
         7V9upegH4l5xtKqyQvl9xjOqx3XNhO3TBrWHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9OW4RL81pIUdiw+zgh4jW1IlqFN74R1uy0F7HjdiocU=;
        b=wVbW5POiDonjI4h8WZJWLrYLyu90OT8RQ9LrelhxWyC9t3Py/guiF1BqHOudBC0Bem
         /Qr03rEhJBjSWFVz+0pS32B4UO8Oc69QZWg0tkJx131TIlGSVQY5EoPEs3zC2RsurTHu
         cp2YhQh1+QmkM8bucFMNY4ffJoBHJPjAkIT6fx/dXljCvhnT4kbbfC5LRNhAnICAq62o
         liQuPM4LKWJUOiwt1tkxOCNbCI0FUlNmJL7kXv7IlmScsH4OIBtR02QHs9aMVgOrMtMC
         pYGT0Fl9YHSv/7/3NqhuvzCQ/tXXpOYNoYL7mFWREoil+jr69FX/luQcfZ9BfNRAVYdE
         GZQw==
X-Gm-Message-State: AOAM533xpsbEhBQ3fdIYL+aGarhu5oIEHFJDGJ9XOTOKCIk643V/8ZmD
        cKGsVEltesELOiXvPyFgbSIKIw==
X-Google-Smtp-Source: ABdhPJxBMXTOtss+AuYYPW5JCi3sHvUzY4RP0Xu+mwOes9zQB+0ckvefsntGWASR/8aWNgdlWzeOtg==
X-Received: by 2002:a17:902:ab17:b0:13e:b2e0:58b with SMTP id ik23-20020a170902ab1700b0013eb2e0058bmr7910203plb.9.1633476424794;
        Tue, 05 Oct 2021 16:27:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c15sm6524084pfp.39.2021.10.05.16.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 16:27:04 -0700 (PDT)
Date:   Tue, 5 Oct 2021 16:27:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chen Jingwen <chenjingwen6@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Andrei Vagin <avagin@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] elf: don't use MAP_FIXED_NOREPLACE for elf interpreter
 mappings
Message-ID: <202110051626.0AB43704@keescook>
References: <20210928125657.153293-1-chenjingwen6@huawei.com>
 <202110041255.83A6616D9@keescook>
 <20211005161212.2eb4ca912d131e72bf09bdd6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005161212.2eb4ca912d131e72bf09bdd6@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:12:12PM -0700, Andrew Morton wrote:
> On Mon, 4 Oct 2021 13:00:07 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > Andrew, are you able to pick up [1], BTW? It seems to have fallen
> > through the cracks.
> > 
> > [1] https://lore.kernel.org/all/20210916215947.3993776-1-keescook@chromium.org/T/#u
> 
> I added that to -mm on 19 September.:
> https://ozlabs.org/~akpm/mmotm/broken-out/binfmt_elf-reintroduce-using-map_fixed_noreplace.patch

Ah! Thank you. :)

-- 
Kees Cook
