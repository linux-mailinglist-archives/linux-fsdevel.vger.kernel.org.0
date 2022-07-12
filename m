Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F25721CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 19:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiGLRdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 13:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiGLRdX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:33:23 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E68C4460
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 10:33:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mf4so14404016ejc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mRIVhl5guQrXZ0/Ez2Hr3fYE2IT2iDZ4PPDSwFOX/Y0=;
        b=V6/V9rtqaJEeqohiqSuEv47BPTa2PNcq9ig3RTPmnNnVdbNfeDzyIiv/IHCCD+WSr0
         x5btDD3zFbLCGnmcovMEjcloEUMGKifhhAUlGznFlXdqngGEieh6V+ASYK1QEzyMkD6V
         nY0Cjkuui0YS/0bwAw14ZyTW4wot5DPgN1ylo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mRIVhl5guQrXZ0/Ez2Hr3fYE2IT2iDZ4PPDSwFOX/Y0=;
        b=rK58qSdopdra9C4VCc23uZwzdX6mecJAWgn1FlZCYH19EFf93BN9HUEUs4C1FT6rCa
         H5ZbKPrEi6bVEQwJXBcVNylyfMdWR9cb499NB6Ays7RcGn+uwxph9pZwQYoiPKd9YMza
         OdWln4G1G0q/o0/pGgWCRc+iA1fDRygkxNzRasmd/F3nUhEh/e4+VzfdcB/2qDNMpPTN
         MTgCd7XuNEAychx6fRXo5oIpksZheIoYNX3Z94n/7MxbiblU74x6amRfUX3y6NnMGecc
         Nh/DMTLGOrjOB4UYcX460ZP58HDTjcKo2jsM+qYU5Kss71s7Iu3M1hEWQZ9LDi7t7Dpk
         cAQQ==
X-Gm-Message-State: AJIora9qiuU7vyEEbvRaJucVq4jhmW54sHYUqpV43qTbDm4cFEpt3PFq
        7cUXWXP5Aeh+GF4YioHZpFOcQCIxn1i9t9aD
X-Google-Smtp-Source: AGRyM1u01kIDh3+A8ZqGb+cPXyRgtGJReWdqLIIpqSBwsDPhYF5j8u8HWNdQVBsxs6L7V/slKdbciA==
X-Received: by 2002:a17:907:7639:b0:72b:60b5:7458 with SMTP id jy25-20020a170907763900b0072b60b57458mr9600499ejc.664.1657647199820;
        Tue, 12 Jul 2022 10:33:19 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id gg9-20020a170906e28900b006ff0b457cdasm4043939ejb.53.2022.07.12.10.33.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 10:33:18 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id v14so12167789wra.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 10:33:18 -0700 (PDT)
X-Received: by 2002:a5d:69c2:0:b0:21d:807c:a892 with SMTP id
 s2-20020a5d69c2000000b0021d807ca892mr23116772wrw.274.1657647197746; Tue, 12
 Jul 2022 10:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
In-Reply-To: <a7c93559-4ba1-df2f-7a85-55a143696405@tu-darmstadt.de>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 12 Jul 2022 10:33:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
Message-ID: <CAHk-=wjrOgiWfN2uWf8Ajgr4SjeWMkEJ1Sd=H6pnS_JLjJwTcQ@mail.gmail.com>
Subject: Re: Information Leak: FIDEDUPERANGE ioctl allows reading writeonly files
To:     ansgar.loesser@kom.tu-darmstadt.de,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Amir Goldstein <amir73il@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Matthew Wilcox <willy@infradead.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Security Officers <security@kernel.org>,
        Max Schlecht <max.schlecht@informatik.hu-berlin.de>,
        =?UTF-8?Q?Bj=C3=B6rn_Scheuermann?= 
        <scheuermann@kom.tu-darmstadt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[ Adding random people who get blamed for lines in this remap_range
thing to the participants ]

On Tue, Jul 12, 2022 at 5:11 AM Ansgar L=C3=B6=C3=9Fer
<ansgar.loesser@tu-darmstadt.de> wrote:
>
> using the deduplication API we found out, that the FIDEDUPERANGE ioctl
> syscall can be used to read a writeonly file.

So I think your patch is slightly wrong, but I think this is worth
fixing - just likely differently.

First off - an odd technicality: you can already read write-only files
by simply mmap'ing them, because on many architectures PROT_WRITE ends
up implying PROT_READ too.

So you should basically expect that "I have permissions to write to
the file" automatically means that you can read it too.

People simply do that "open for writing, mmap to change it" and expect
it to work - not realizing that that means you have to be able to read
it too.

Anybody who thought otherwise was sadly wrong, and if you depend on
"this is write-only" as some kind of security measure for secrets, you
need to fix your setup.

Now, is that a "feature or a bug"? You be the judge.It is what it is,
and it's always been that way. Writability trumps readability, even if
you have to do special things to get there.

That said, this file remap case was clearly not intentional, and
despite the mmap() issue I think this is just plain wrong and we
should fix it as a QoI issue.

A dedupe may only write to the destination file, but at the same time
it does obviously have that implication of "I need to be able to read
it to see that it's duplicate".

However, your patch is wrong:

> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -414,11 +414,11 @@ static bool allow_file_dedupe(struct file *file)
>
>       if (capable(CAP_SYS_ADMIN))
>           return true;
> -    if (file->f_mode & FMODE_WRITE)
> +    if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D (FMODE_READ |
> FMODE_WRITE))
>           return true;

This part looks like a good idea - although it is possible that people
will argue that this is the same kind of issue as 'mmap()' has (but
unlike mmap, we don't have "this is how the hardware works" issues, or
"long history of uses").

But

> -    if (!inode_permission(mnt_userns, inode, MAY_WRITE))
> +    if (!inode_permission(mnt_userns, inode, MAY_READ | MAY_WRITE))

looks wrong.

Note that readability is about the file *descriptor*, not the inode.
Because the file descriptor may have been opened by somebody who had
permission to read the file even for a write-only file.

That happens for capability reasons, but it also happens for things
like "open(O_RDWR | O_CREAT, 0444)" which creates a new file that is
write-only in the filesystem, but despite that the file descriptor is
actually readable by the opener.

I wonder if the inode_permission() check should just be removed
entirely (ie the MAY_WRITE check smells bogus too, for the same reason
I don't like the added MAY_READ one)

 The file permission check - that was done at open time - is the
correct one, and is the one that read/write already uses.

Any permission checks done at IO time are basically always buggy:
things may have changed since the 'open()', and those changes
explicitly should *not* matter for the IO. That's really fundamentally
how UNIX file permissions work.

                Linus
