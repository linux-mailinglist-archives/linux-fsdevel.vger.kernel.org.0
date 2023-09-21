Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D749F7A98AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjIURv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIURvN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B0030C7
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n5pyZLuCo/XvXRs78cLj8dcUE4Os6CZvVNQ9E5PNqc8=;
        b=ix2GbXva1Aa2Gg/tYz1Q9wMos7a/bcyJs15wd1ISSjYQjBAOb54x419cglzBoQ03qTouSG
        rNHRNxuTXX2D52oKLfrmNrS84Rn5RdqZeH+3UVKf448yuXqHeLtY68vJH5J1SbXLVCj20s
        gJV7VX49Zlosj/4BR6OSLleR8mbUJN4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-FhQRcqMaNM6CM9eTZ9j94w-1; Thu, 21 Sep 2023 06:36:37 -0400
X-MC-Unique: FhQRcqMaNM6CM9eTZ9j94w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40524bc3c5cso6127885e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Sep 2023 03:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695292596; x=1695897396;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5pyZLuCo/XvXRs78cLj8dcUE4Os6CZvVNQ9E5PNqc8=;
        b=p8zKq+WVdjJT86EfPBpiWMCrmHbuK+PwG4X3aHBN8hbXkomTyMMYZJFQ9OMrg7Ym2D
         5wBe0J32VKfJB/ARRuPnrAkdlncXhz7iUlL4F64BuRpHjQXenZ2vZCS0W5PnIUm5ms04
         vIxXlt4C6qYeeokOOUP9FIwGWvfpZjlN0lysVB9IwKcjbcMVBh+Gl4V6SyIDboOlSwSQ
         Wq2m3dEhZVimB5Rx2t+1p1ITEYR/zxp63WpxQXgIY2ea3XCxSeKwNMLo143DdjEVF5zp
         Iu/55BCY0gcfjqiNjlvn+zK+oY/bVb91iwIbSJGgznpU2Jkn1xMvuna7vvRslrSds1V/
         Ix3A==
X-Gm-Message-State: AOJu0YwLsyZktzs7TXfKL7zl1wfv8O83JJDitfWgZ3NcRbMi1mrtQGyk
        bvM7Fzx3OrT6Z+VOOAqFkx7KeGf9RGOAtRO4ERUU/eObjD7Hx6kbecJXkRdo0bvDr9hsSzX3sVr
        +GrA5V+N3qBuiigf9JNcKka7mYx8Dy76CNJ0o
X-Received: by 2002:adf:fe8a:0:b0:31a:d4a9:bdac with SMTP id l10-20020adffe8a000000b0031ad4a9bdacmr4758967wrr.11.1695292596351;
        Thu, 21 Sep 2023 03:36:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo4IlMYvVaA5s4LWesfAld9qk/d4qdTGLbpvwo6KlcwOZdqJ9/fXFN20xWoWzNksmmABizyA==
X-Received: by 2002:adf:fe8a:0:b0:31a:d4a9:bdac with SMTP id l10-20020adffe8a000000b0031ad4a9bdacmr4758950wrr.11.1695292595980;
        Thu, 21 Sep 2023 03:36:35 -0700 (PDT)
Received: from rh (p200300c93f1ec600a890fb4d684902d4.dip0.t-ipconnect.de. [2003:c9:3f1e:c600:a890:fb4d:6849:2d4])
        by smtp.gmail.com with ESMTPSA id z8-20020adff748000000b0031fedb25b85sm1378553wrp.84.2023.09.21.03.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 03:36:35 -0700 (PDT)
Date:   Thu, 21 Sep 2023 12:36:34 +0200 (CEST)
From:   Sebastian Ott <sebott@redhat.com>
To:     =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
In-Reply-To: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
Message-ID: <36e93c8e-4384-b269-be78-479ccc7817b1@redhat.com>
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hej,

since we figured that the proposed patch is not going to work I've spent a
couple more hours looking at this (some static binaries on arm64 segfault
during load [0]). The segfault happens because of a failed clear_user()
call in load_elf_binary(). The address we try to write zeros to is mapped with
correct permissions.

After some experiments I've noticed that writing to anonymous mappings work
fine and all the error cases happend on file backed VMAs. Debugging showed that
in elf_map() we call vm_mmap() with a file offset of 15 pages - for a binary
that's less than 1KiB in size.

Looking at the ELF headers again that 15 pages offset originates from the offset
of the 2nd segment - so, I guess the loader did as instructed and that binary is
just too nasty?

Program Headers:
   Type           Offset             VirtAddr           PhysAddr
                  FileSiz            MemSiz              Flags  Align
   LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
                  0x0000000000000178 0x0000000000000178  R E    0x10000
   LOAD           0x000000000000ffe8 0x000000000041ffe8 0x000000000041ffe8
                  0x0000000000000000 0x0000000000000008  RW     0x10000
   NOTE           0x0000000000000120 0x0000000000400120 0x0000000000400120
                  0x0000000000000024 0x0000000000000024  R      0x4
   GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                  0x0000000000000000 0x0000000000000000  RW     0x10

As an additional test I've added a bunch of zeros at the end of that binary
so that the offset is within that file and it did load just fine.

On the other hand there is this section header:
   [ 4] .bss              NOBITS           000000000041ffe8  0000ffe8
        0000000000000008  0000000000000000  WA       0     0     1

"sh_offset
This member's value gives the byte offset from the beginning of the file to
the first byte in the section. One section type, SHT_NOBITS described
below, occupies no space in the file, and its sh_offset member locates
the conceptual placement in the file.
"

So, still not sure what to do here..

Sebastian

[0] https://lore.kernel.org/lkml/5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com/

