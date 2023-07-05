Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733A2748426
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjGEM1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGEM1g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:27:36 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892B19B7;
        Wed,  5 Jul 2023 05:27:18 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b70224ec56so4638911fa.3;
        Wed, 05 Jul 2023 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688560037; x=1691152037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kJSPvo6YE4Pcu6NTPEmUuQAJR6NuIEKWGUFTkdLT+Zo=;
        b=UTbFIgtSqyOkhSCGJNKlGTjaxGvpn5dtHCeSvBlpWtR6h/m/YrlsO69lGKaEehKpTP
         5lWeOk5AYuWrzSHbYH0GvKvUVMAA78peDOsBtGc4fZv1M6uYE7Yxg7hMyewtzmbgp+aJ
         iKmh5DsDGYEFbeoqxouKvftPiPLPOjsjeZ9rLlrb8xo2+dPYGF5SEizkGd5bHU1PuhxM
         LZkPFZ8u+qTeEtIFJILmKG0S2Gen+TNYgKJjwoehvNcoU2CZvR1y488B4QN+T21gxrkf
         tr2Jj7ljHPluop6P6jcV9a8wuNaqEj7ydsiJcYzSfDg350qmYjSZ1iWv9mx3W3Xne3Nc
         v4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688560037; x=1691152037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJSPvo6YE4Pcu6NTPEmUuQAJR6NuIEKWGUFTkdLT+Zo=;
        b=iKTWcuKBlaPPJFEBCDJSuHIuLbrBH6VqtMl9fZ+TywuWJbknx4uQfmSQY3lwJjyvJT
         APoOcOGxVU6Q4tPu4BnogiDN2Zg88gPT6dNy3JCaOqDWvgfSSsAop2c9Njo9rio2Lyx0
         mGLV4N6e5BbgP+f+C5jmYQ3z5G6ncqQXRgh4hTpbufJaXg4yehY8v+qaTaFGOkudir9e
         +d13pDvBCJte4B+eG+DCiKFihJSUa9HlXyDcYNNbmzjdCbyA2P6rADcrPr4NGSih0IaA
         PlYKL2YcMl1jIQEusNVsNRKrQnW7O0n9b+3z0hVJF4Fo3AHaDSQK0qr6QUJZG8bJMvJE
         ri6g==
X-Gm-Message-State: ABy/qLa34ZgMOI/NFbweQxd9w5J0a8JGb67RzFSJjb7906FSY9UcpGWI
        XX0yMNpNwZSJ4qkxR19WZuweiTqtVID+l1xugLo=
X-Google-Smtp-Source: APBJJlGzO5WUPFKyK5n9U5kWFV8e+yxrPXUKJMYEuJ/JQY/cddmT1oRTc7JJ/G8g9GoJxyG3MkVyCxqSbRFuyoh5isI=
X-Received: by 2002:a2e:9899:0:b0:2b6:cff1:cd1c with SMTP id
 b25-20020a2e9899000000b002b6cff1cd1cmr11143689ljj.34.1688560036469; Wed, 05
 Jul 2023 05:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230704122727.17096-1-jack@suse.cz>
In-Reply-To: <20230704122727.17096-1-jack@suse.cz>
From:   Mike Fleetwood <mike.fleetwood@googlemail.com>
Date:   Wed, 5 Jul 2023 13:27:03 +0100
Message-ID: <CAMU1PDj7f4RGBKLaN5zLFTTERnF9NFPq3RxuWygSWnzUthnKWQ@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6 v2] block: Add config option to not allow writing
 to mounted devices
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 4 Jul 2023 at 13:57, Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> This is second version of the patches to add config option to not allow writing
> to mounted block devices. For motivation why this is interesting see patch 1/6.
> I've been testing the patches more extensively this time and I've found couple
> of things that get broken by disallowing writes to mounted block devices:
> 1) Bind mounts get broken because get_tree_bdev() / mount_bdev() first try to
>    claim the bdev before searching whether it is already mounted. Patch 6
>    reworks the mount code to avoid this problem.
> 2) btrfs mounting is likely having the same problem as 1). It should be fixable
>    AFAICS but for now I've left it alone until we settle on the rest of the
>    series.
> 3) "mount -o loop" gets broken because util-linux keeps the loop device open
>    read-write when attempting to mount it. Hopefully fixable within util-linux.
> 4) resize2fs online resizing gets broken because it tries to open the block
>    device read-write only to call resizing ioctl. Trivial to fix within
>    e2fsprogs.
>
> Likely there will be other breakage I didn't find yet but overall the breakage
> looks minor enough that the option might be useful. Definitely good enough
> for syzbot fuzzing and likely good enough for hardening of systems with
> more tightened security.

5) Online e2label will break because it directly writes to the ext2/3/4
   superblock while the FS is mounted to set the new label.  Ext4 driver
   will have to implement the SETFSLABEL ioctl() and e2label will have
   to use it, matching what happens for online labelling of btrfs and
   xfs.

Thanks,
Mike
