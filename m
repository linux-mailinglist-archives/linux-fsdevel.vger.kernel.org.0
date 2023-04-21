Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47216EB386
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 23:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjDUVXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 17:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjDUVXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:23:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1083A2114;
        Fri, 21 Apr 2023 14:23:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f195b164c4so5109865e9.1;
        Fri, 21 Apr 2023 14:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682112194; x=1684704194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yxnbDIY2T2BXEHeacyyEItpEvQKuaNh4fP8Jz0Ufxk8=;
        b=Kb2dP46Px5bQVRmYlVGy7ilcCdlu1RdygbnlHAhC2bwm5oKBa/ykrYJOvB0dYQ3obJ
         R6vd/02nV0NWichc7WyCd1Y0NkmIF7DxPMkzNlIoqHpsg3123RdU0TWX295Jgg1KUwpP
         bSjjy9WwPQoIihMwv7dH/j/D+45srGCyaZI2JeuLmwMZjuysZBBaCE20UhI+i40TEg/L
         FbYeYnh6Wi3Sj5AaiY7SLRnMwYSs3Y0GHcQjr/lrJs3v+tFEtlmvqGVVBpDJaZ834e0t
         eGM0C83aMEoFiSM/nC2nbxf9PfvWGJdlz4zUMXDNKchHFYLAy5HwidmSNXxWZylfUZCY
         BBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682112194; x=1684704194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxnbDIY2T2BXEHeacyyEItpEvQKuaNh4fP8Jz0Ufxk8=;
        b=H0sLV9vPxzEVPHS8ZTyyCKaqB5cx3iN9P77FRkUC91qvoMXHhZOkKV44ZZRpdCNQJV
         8pUg+1yNi87TweSlPYa6uG1IYovv4pcnsLN8I3EgwwQdV6tOQuPA/HSRQJfaQjZeScX8
         4RY+Fe0aP3JyTkna6rjjLV/OWOJM4o7eOT1El/FD+m0UiuzmKCJBSZSSSBQQNyoEJbYG
         bLUUqvtgBJeal4YT1DQNnVz4C7uGjOO3P87oYMWwK39oBYR3bJRDrIwVOX3yi51BneKV
         XGdK6jgY1f7DPV1I0GPi0dz4tY7URiEyJvo8vv3NCN+ONNEH3vj/UjdKyL1P9sHvlUM+
         alBA==
X-Gm-Message-State: AAQBX9dJnzvXSiAniGkxSDb6m9BBfyZKiNEhlvjymj7j1LiRgFFcF3Up
        wMJVWJ6hkjjCeDxKemzLvKk=
X-Google-Smtp-Source: AKy350Z/sfov6YlCgGxoBDEgNry2GO8OIGvhbzeo/q7/gFS9+kSvunl+s5NTFJ5LbftYF5WwCqov0w==
X-Received: by 2002:a1c:f715:0:b0:3f0:5887:bea3 with SMTP id v21-20020a1cf715000000b003f05887bea3mr3056263wmh.27.1682112194347;
        Fri, 21 Apr 2023 14:23:14 -0700 (PDT)
Received: from localhost (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.gmail.com with ESMTPSA id v15-20020a05600c444f00b003f09cda253esm9304031wmn.34.2023.04.21.14.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:23:13 -0700 (PDT)
Date:   Fri, 21 Apr 2023 22:23:12 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 0/3] permit write-sealed memfd read-only shared
 mappings
Message-ID: <b18577f5-86fe-4093-9058-07ba899f7dd6@lucifer.local>
References: <cover.1680560277.git.lstoakes@gmail.com>
 <20230421090126.tmem27kfqamkdaxo@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421090126.tmem27kfqamkdaxo@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 11:01:26AM +0200, Jan Kara wrote:
> Hi!
>
> On Mon 03-04-23 23:28:29, Lorenzo Stoakes wrote:
> > This patch series is in two parts:-
> >
> > 1. Currently there are a number of places in the kernel where we assume
> >    VM_SHARED implies that a mapping is writable. Let's be slightly less
> >    strict and relax this restriction in the case that VM_MAYWRITE is not
> >    set.
> >
> >    This should have no noticeable impact as the lack of VM_MAYWRITE implies
> >    that the mapping can not be made writable via mprotect() or any other
> >    means.
> >
> > 2. Align the behaviour of F_SEAL_WRITE and F_SEAL_FUTURE_WRITE on mmap().
> >    The latter already clears the VM_MAYWRITE flag for a sealed read-only
> >    mapping, we simply extend this to F_SEAL_WRITE too.
> >
> >    For this to have effect, we must also invoke call_mmap() before
> >    mapping_map_writable().
> >
> > As this is quite a fundamental change on the assumptions around VM_SHARED
> > and since this causes a visible change to userland (in permitting read-only
> > shared mappings on F_SEAL_WRITE mappings), I am putting forward as an RFC
> > to see if there is anything terribly wrong with it.
>
> So what I miss in this series is what the motivation is. Is it that you need
> to map F_SEAL_WRITE read-only? Why?
>

This originated from the discussion in [1], which refers to the bug
reported in [2]. Essentially the user is write-sealing a memfd then trying
to mmap it read-only, but receives an -EPERM error.

F_SEAL_FUTURE_WRITE _does_ explicitly permit this but F_SEAL_WRITE does not.

The fcntl() man page states:

    Furthermore, trying to create new shared, writable memory-mappings via
    mmap(2) will also fail with EPERM.

So the kernel does not behave as the documentation states.

I took the user-supplied repro and slightly modified it, enclosed
below. After this patch series, this code works correctly.

I think there's definitely a case for the VM_MAYWRITE part of this patch
series even if the memfd bits are not considered useful, as we do seem to
make the implicit assumption that MAP_SHARED == writable even if
!VM_MAYWRITE which seems odd.

Reproducer:-

int main()
{
       int fd = memfd_create("test", MFD_ALLOW_SEALING);
       if (fd == -1) {
	       perror("memfd_create");
	       return EXIT_FAILURE;
       }

       write(fd, "test", 4);

       if (fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE) == -1) {
	       perror("fcntl");
	       return EXIT_FAILURE;
       }

       void *ret = mmap(NULL, 4, PROT_READ, MAP_SHARED, fd, 0);
       if (ret == MAP_FAILED) {
	       perror("mmap");
	       return EXIT_FAILURE;
       }

       return EXIT_SUCCESS;
}

[1]:https://lore.kernel.org/all/20230324133646.16101dfa666f253c4715d965@linux-foundation.org/
[2]:https://bugzilla.kernel.org/show_bug.cgi?id=217238

> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
