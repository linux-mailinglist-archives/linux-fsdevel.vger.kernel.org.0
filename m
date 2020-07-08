Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AABF217FA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 08:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgGHGf3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 02:35:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41408 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbgGHGf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:35:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id f2so17761763plr.8;
        Tue, 07 Jul 2020 23:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wcGsk/H34ADHkkcrhevzy9A6V7aeuvW0VaA+xIQKcJI=;
        b=ebFUpcFPAHeH/k++QKEcZ8gP7s929BeGB/rko+35QUexuF8CrBKs1YW5xkPb1hhokH
         HAWpCoFoA7E15lV7yrUqkJiqWGK3fMTRdFe/JLcie6SQVORLq5URnkHeF943/pgXg12V
         ftzxE+LeqB1Qlmwomul6Smkqt3jlZ5LVGZwdsddDzDBaSp9HkiRXiOmFQ49647l0nGNy
         yenp8gYOl82EkiBuw2W/3AveMUc3qr8N8cnGJ1Ajan3KfZO0Lkj7HdzSbBykWb4eZW7W
         zxPr5JrDRb0xUMvdVH37YCvhavaw/yxgfWPQ4VUXbr+hI6uevPEpGmAgaON2Fsx8Lmcl
         p4tw==
X-Gm-Message-State: AOAM5305zuY+FfCltfMl7+ucwIrvs/hg70+pKz/0PBqucBUwl7PfSO+m
        HHNf4mgwhrnFkeyMmzjiSCRkGtVxsVA=
X-Google-Smtp-Source: ABdhPJwRXovytVEyyAT/lpHCAHItwhk1xn4NAYtBTkSi6xafA4n3ZPFiHU6WnOqp9vfv8jYYmkuKgw==
X-Received: by 2002:a17:90a:e017:: with SMTP id u23mr8047308pjy.179.1594190127774;
        Tue, 07 Jul 2020 23:35:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u23sm2791327pgn.26.2020.07.07.23.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 23:35:26 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 62403400DB; Wed,  8 Jul 2020 06:35:25 +0000 (UTC)
Date:   Wed, 8 Jul 2020 06:35:25 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 10/16] exec: Remove do_execve_file
Message-ID: <20200708063525.GC4332@42.do-not-panic.com>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
 <20200702164140.4468-10-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702164140.4468-10-ebiederm@xmission.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 11:41:34AM -0500, Eric W. Biederman wrote:
> Now that the last callser has been removed remove this code from exec.
> 
> For anyone thinking of resurrecing do_execve_file please note that
> the code was buggy in several fundamental ways.
> 
> - It did not ensure the file it was passed was read-only and that
>   deny_write_access had been called on it.  Which subtlely breaks
>   invaniants in exec.
> 
> - The caller of do_execve_file was expected to hold and put a
>   reference to the file, but an extra reference for use by exec was
>   not taken so that when exec put it's reference to the file an
>   underflow occured on the file reference count.

Maybe its my growing love with testing, but I'm going to have to partly
blame here that we added a new API without any respective testing.
Granted, I recall this this patch set could have used more wider review
and a bit more patience... but just mentioning this so we try to avoid
new api-without-testing with more reason in the future.

But more importantly, *how* could we have caught this? Or how can we
catch this sort of stuff better in the future?

> - The point of the interface was so that a pathname did not need to
>   exist.  Which breaks pathname based LSMs.

Perhaps so but this fails to do justice of the LSM consideration done
for the patch which added this during patch review [0], and I
particularly recall I called out LSM folks to bring their ray guns out at
this patch. It didn't get much attention.

Let me recap a few points I think your commit log should somehow
consider. You do as you please.

Users of shmem_kernel_file_setup() spawned out of the desire to                                                                                                      
*avoid* LSMs since it didn't make sense in their case as their inodes                                                                                                      
are never exposed to userspace. Such is the case for ipc/shm.c and                                                                                                         
security/keys/big_key.c. Refer to commit c7277090927a5 ("security: shmem:                                                                                                  
implement kernel private shmem inodes") and then commit e1832f2923ec9                                                                                                      
("ipc: use private shmem or hugetlbfs inodes for shm segments").

And the umh module approach was doing:

 a) mapping data already extracted by the kernel somehow from
    a file somehow, presumably from /lib/modules/ path somewhere, but
    again this is not visible to umc.c, as it just gets called with:
                                                                                                                                                                          
     fork_usermode_blob(void *data, size_t len, struct umh_info *info)
                                                                                                                                                                          
 b) Creating the respective tmpfs file with shmem_kernel_file_setup()
 c) Populating the file created and stuffing it with our data passed
 d) Calling do_execve_file() on it.

So, although I was hoping LSM folks would chime in for things I may have
missed during my patch review, my recollection from the patch thread was
that this becuase of a) it in theory could skip out on dealing with LSMs.

[0] https://lkml.kernel.org/r/20180509022526.hertzfpvy7apz6ny@ast-mbp               

  Luis
