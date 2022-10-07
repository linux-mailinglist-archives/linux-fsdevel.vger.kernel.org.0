Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC075F80D0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 00:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJGWgj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 18:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJGWgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 18:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6486582620
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Oct 2022 15:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665182195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6bv2go9G+BjO6JEUVB2l8Xszg9KiwwYaLXejJm6qDg=;
        b=CIyTD0CJdQXhn5Lh6ojQDDMYJuQfZ4ZodwaTpthoAxNV/7TaYL6O8TR0U2mD+zHy9e/q3n
        51G5vYwXF77rqtS5G6agMUbIBtWUNT97LWsvHKrRJotSK3ypuuCXdFmMwkwSNorjrEZGJ5
        w+lBp/u3JdXH0AtMFZg7t1o9yyFpZ98=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-vVlVjoWNMuy1bzr9M4DRSA-1; Fri, 07 Oct 2022 18:36:34 -0400
X-MC-Unique: vVlVjoWNMuy1bzr9M4DRSA-1
Received: by mail-qv1-f71.google.com with SMTP id eu10-20020ad44f4a000000b004b18126c4bfso3713275qvb.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Oct 2022 15:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6bv2go9G+BjO6JEUVB2l8Xszg9KiwwYaLXejJm6qDg=;
        b=xA+tDPL7jcDjv/VP3gZRrVqzaieoQxOY4AZrd+jlfuQ9puc4E1AUH1woyZR96+6qLT
         dhTw387L6d0upF8uKeiczUg8+XIgPsFBCjOCLuUKfznlGFYyHZh8jPZsSV8bSp2J4JZi
         QPQDrMyVh5IqxnNLpSIDG4QdZLnRz2xnnxzuGVZdD3Usec+kTgFMT7RwGuQ4TD1e02Pq
         3CuqOXDXTzyy91EsABqhqP0nCHQ99V1ytRqfOeeofz4cvu/HCjYuVKVE1N0ocTyKC/Rg
         9fJukHrJACtBX00/qUpqVTtK/pwHgo4o6iI5oZmstBN0SX/71lGqZ43SHSkVxadhv52+
         aeVw==
X-Gm-Message-State: ACrzQf0Pm9KAlMrYsHINO8HXbX/Ru/d4s++16cFQO1jKdsV9C78jdSHx
        wIp5ggHKw4vDePDZ1atavAMTs8mPH7Uynp8vh1bYoJ/C5djHNiBK9jv3WyWhBqlvCHYxbU/1cqg
        e+wFukOw8QX0eNjbYzw+rhJDDbQ==
X-Received: by 2002:ad4:5bc5:0:b0:4af:b73f:1914 with SMTP id t5-20020ad45bc5000000b004afb73f1914mr6080924qvt.117.1665182194075;
        Fri, 07 Oct 2022 15:36:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78p2McfJOYHRwtugZaxb3pWVgHssIx6T2xoDstxpOxZiXQBQs1wSoGi63opRGYZnFej6t5Pw==
X-Received: by 2002:ad4:5bc5:0:b0:4af:b73f:1914 with SMTP id t5-20020ad45bc5000000b004afb73f1914mr6080907qvt.117.1665182193919;
        Fri, 07 Oct 2022 15:36:33 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id r23-20020ae9d617000000b006ce5ba64e30sm2958721qkk.136.2022.10.07.15.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 15:36:33 -0700 (PDT)
Date:   Fri, 7 Oct 2022 18:36:30 -0400
From:   Peter Xu <peterx@redhat.com>
To:     syzbot <syzbot+2c2bb573a9524a95e787@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, jack@suse.cz,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, namit@vmware.com, rppt@kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] WARNING in change_pte_range
Message-ID: <Y0Cp7uHwq4yWMiDN@xz-m1.local>
References: <000000000000495a9305e9dea876@google.com>
 <0000000000004f5d5205ea790cf0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0000000000004f5d5205ea790cf0@google.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 07, 2022 at 03:08:22PM -0700, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit b1f9e876862d8f7176299ec4fb2108bc1045cbc8
> Author: Peter Xu <peterx@redhat.com>
> Date:   Fri May 13 03:22:56 2022 +0000
> 
>     mm/uffd: enable write protection for shmem & hugetlbfs
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=108e8fb8880000
> start commit:   511cce163b75 Merge tag 'net-6.0-rc8' of git://git.kernel.o..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=128e8fb8880000
> console output: https://syzkaller.appspot.com/x/log.txt?x=148e8fb8880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4520785fccee9b40
> dashboard link: https://syzkaller.appspot.com/bug?extid=2c2bb573a9524a95e787
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ecac35080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15668b38880000
> 
> Reported-by: syzbot+2c2bb573a9524a95e787@syzkaller.appspotmail.com
> Fixes: b1f9e876862d ("mm/uffd: enable write protection for shmem & hugetlbfs")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> 

#syz dup: WARNING in change_protection

-- 
Peter Xu

