Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04D1373F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgAJQpI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:45:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39038 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgAJQpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:45:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so2446764wrt.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2020 08:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ympT5AY/DLl6UvuOCQnir9hVpWD64MMWty4h6MSY0Uc=;
        b=grsTIxw69aF1wk5b95935hZWjq6OuMW2LUVE+UZgYwNKRK2xArvuAAXFlmsla9UBic
         QoxoszrvgwSlKPFJlE6/tOUAJ+8skkaNMQWEI6v7uWzO3mvd9qiUS/otfZMFQUAlHm/w
         8up97pyFZiEUl3kFEo+kNrPE/vlE2s0yDRVBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ympT5AY/DLl6UvuOCQnir9hVpWD64MMWty4h6MSY0Uc=;
        b=ncEqy8Rvd5kc4ljRyBQr5gdhB9DN+2S8XEWWYf0lgfEwa/hmaUfs6dSYPaCnCxhUJG
         dvKcl9KBWaefbHhbs6S31l29nzDm+YB+WbbyKbPG+Hhx1XKj90W19ROerFD6XTVQINa5
         L8R5bSNkdym5A3KT5xmsk65wVexRrA33YeDzp2ccr2WKaCqIwossxesAULvNgzZkVw1M
         m3t+wgV9tMjZzabQk+fwB+1wqsLab7t/5y+4PaUAUDDfLvAp83hgqaY/w51OB+xJnWKt
         hrZSM0nRSY5s37yjZaYu9X6rajaeVfBboqZ+eoLx0cY+LH0sm9kRvhxgIDl7d7D6Hjkl
         LRAQ==
X-Gm-Message-State: APjAAAX2xdKSHtY0U+IsZ67yYTsghsQA74MCkkNxtDoFPh5m1ggRVGvD
        GafcZ2Af7zoTeUuhiZpHpNjG1Q==
X-Google-Smtp-Source: APXvYqx8rXwpLQ7ifI81LfMYzyilHJtApNJMIaEHlbBH7ZTahixW6jrbn4b5p2Rj+1+wR/12UcK4Gw==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr4518896wrx.66.1578674705827;
        Fri, 10 Jan 2020 08:45:05 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id x10sm2823222wrp.58.2020.01.10.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 08:45:05 -0800 (PST)
Date:   Fri, 10 Jan 2020 16:45:03 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hugh Dickins <hughd@google.com>, Dave Chinner <david@fromorbit.com>
Cc:     Chris Mason <clm@fb.com>, Amir Goldstein <amir73il@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 2/2] tmpfs: Support 64-bit inums per-sb
Message-ID: <20200110164503.GA1697@chrisdown.name>
References: <ae9306ab10ce3d794c13b1836f5473e89562b98c.1578225806.git.chris@chrisdown.name>
 <20200107001039.GM23195@dread.disaster.area>
 <20200107001643.GA485121@chrisdown.name>
 <20200107003944.GN23195@dread.disaster.area>
 <CAOQ4uxjvH=UagqjHP_71_p9_dW9wKqiaWujzY1xKe7yZVFPoTA@mail.gmail.com>
 <alpine.LSU.2.11.2001070002040.1496@eggly.anvils>
 <CAOQ4uxiMQ3Oz4M0wKo5FA_uamkMpM1zg7ydD8FXv+sR9AH_eFA@mail.gmail.com>
 <20200107210715.GQ23195@dread.disaster.area>
 <4E9DF932-C46C-4331-B88D-6928D63B8267@fb.com>
 <alpine.LSU.2.11.2001080259350.1884@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2001080259350.1884@eggly.anvils>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Hugh, Dave,

Hugh Dickins writes:
>Dave, Amir, Chris, many thanks for the info you've filled in -
>and absolutely no need to run any scan on your fleet for this,
>I think we can be confident that even if fb had some 15-year-old tool
>in use on its fleet of 2GB-file filesystems, it would not be the one
>to insist on a kernel revert of 64-bit tmpfs inos.
>
>The picture looks clear now: while ChrisD does need to hold on to his
>config option and inode32/inode64 mount option patch, it is much better
>left out of the kernel until (very unlikely) proved necessary.

Based on Mikael's comment above about Steam binaries, and the lack of 
likelihood that they can be rebuilt, I'm inclined to still keep inode{64,32}, 
but make legacy behaviour require explicit opt-in. That is:

- Default it to inode64
- Remove the Kconfig option
- Only print it as an option if tmpfs was explicitly mounted with inode32

The reason I suggest keeping this is that I'm mildly concerned that the kind of 
users who might be impacted by this change due to 32-bit _FILE_OFFSET_BITS -- 
like the not-too-uncommon case that Mikael brings up -- seem unlikely to be the 
kind of people that would find it in an rc.

Other than that, the first patch could be similar to how it is now, 
incorporating Hugh's improvements to the first patch to put everything under 
the same stat_lock in shmem_reserve_inode.

What do you folks think?

Thanks,

Chris
