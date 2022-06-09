Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991FD5456EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 00:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345371AbiFIWGS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 18:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345239AbiFIWGQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 18:06:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3161F0A43
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 15:06:15 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gl15so36219181ejb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6UoMg7XAdZhjLF3+TuyFXMPmzf7hGCGFPyI+PbeCZf8=;
        b=bg+vgE40WdCztmrYjVSM/YJF9ZXtLor8NrvacxWrs8tmReVOyatbyF3+bwL2eQ+QeM
         h+OM4NPlRuZy2i1/Ro6kdbLrzQGd7SZNUFH7OSOKsX6tGe3TeNeXQa/eGc0tnjd1Yy2D
         IwGPT6SLiwVu0vhgUhkqA+ubHnvIUAQpO7X4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6UoMg7XAdZhjLF3+TuyFXMPmzf7hGCGFPyI+PbeCZf8=;
        b=L+IT37RTbLAdVEoUAJDbDc/taox1muwRnVGteX0Blh356gKeC5Z3c/pfug1VbuhF8N
         v4n8fLCVuQFUp1x1iuIE+B4FOvlwrqtQnz7AIyPD5pnkM7Irncu2Lbkz2KDwnZlTkj+a
         6A56Rle7FbzaB9ivCsIGZxj00nrWAzGRWR2wqi5sYNvMfrjZ3jMPupvNixBiLoGt8s5o
         h41dikwnpkODizCKMDkKqMVSsV579uftR1QNxLhZSlnTFC+Bg6b9IoqabMZl5wavxQAx
         RDoO/DDYtYUG2UVJkIq7GV+nFHc380g7VjrpyCLe455ZHfSIU8IcvhNh3tG45xBkGz1M
         nFxg==
X-Gm-Message-State: AOAM530ofxY1Is4GkFr+wH+PTHjXIwb1vbsMrulIcNpSVnxbxh5Mxhun
        iXjE5aV/+Iezg2RV3HP4/4+qteXNrttbgAmPxrs=
X-Google-Smtp-Source: ABdhPJzxU0+JNG3kbFdo9nYI7Ezm+JTSbhvyRqQTiUDnW9xmEqIHc7flOVDhswQKC6sSyqRDzIQc5w==
X-Received: by 2002:a17:907:9619:b0:6ff:5c3c:bcae with SMTP id gb25-20020a170907961900b006ff5c3cbcaemr39110840ejc.585.1654812373887;
        Thu, 09 Jun 2022 15:06:13 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id q24-20020aa7d458000000b0042aad9edc9bsm15440248edr.71.2022.06.09.15.06.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jun 2022 15:06:13 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso252412wms.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 15:06:13 -0700 (PDT)
X-Received: by 2002:a05:600c:42c6:b0:39c:4bfd:a4a9 with SMTP id
 j6-20020a05600c42c600b0039c4bfda4a9mr5442248wme.8.1654812362760; Thu, 09 Jun
 2022 15:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <40676.1654807564@warthog.procyon.org.uk> <CAHk-=wgkwKyNmNdKpQkqZ6DnmUL-x9hp0YBnUGjaPFEAdxDTbw@mail.gmail.com>
In-Reply-To: <CAHk-=wgkwKyNmNdKpQkqZ6DnmUL-x9hp0YBnUGjaPFEAdxDTbw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jun 2022 15:05:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGrrF20LshkNGJ41UmNN13MU6x0_npwaJQi9cr626GQQ@mail.gmail.com>
Message-ID: <CAHk-=whGrrF20LshkNGJ41UmNN13MU6x0_npwaJQi9cr626GQQ@mail.gmail.com>
Subject: Re: [PATCH] netfs: Fix gcc-12 warning by embedding vfs inode in netfs_i_context
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Steve French <smfrench@gmail.com>,
        William Kucharski <william.kucharski@oracle.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical@lists.samba.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 9, 2022 at 3:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> IOW, I think you really should do something like the attached on top
> of this all.

Just to clarify: I did apply your patch. It's an improvement on what
used to go on.

I just think it wasn't as much of an improvement that it should have
been, and that largely untested patch I attached is I think another
step in a better direction.

                      Linus
