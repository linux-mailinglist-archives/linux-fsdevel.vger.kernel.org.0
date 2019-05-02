Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B36F11818
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 13:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEBLUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 07:20:04 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39571 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfEBLUE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 07:20:04 -0400
Received: by mail-yw1-f68.google.com with SMTP id x204so1251444ywg.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 04:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+D5VUZn+Yb6P85sIoiQuPJTfWNYQICmTFwW3mz6oljQ=;
        b=ObP7GkFfdLoMmZgX6kZ0UAVPcQzpd/GnbitUN0B7QeEQz2XqsTWZ1TATlm+HxxdjSa
         Ok+kRmZ6LpHARRKlmyZqLFIjxTkMyFl4wKFdSJNKQTjZI90ssbm3ggShchv7a0m+2BAw
         CfUZKqUZyWg+NDamr4fh1dS4U05VEcMTtybhVqUTc9vKtdNz8dH55ORf1HEETTZukMrX
         +ZC8dyUTMIWhzKgiipLRQNZVUo/cBr4ly+z7Zf8Lo6pqLAF8ivvBiX7XbMDjzHLt/zb9
         534mbQHA4KfzN1vupR1M7Q6nrjK3hnLSqGgyi9hnRMMmdJpYwkE1LUZ65uivLlXguxCr
         8a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+D5VUZn+Yb6P85sIoiQuPJTfWNYQICmTFwW3mz6oljQ=;
        b=FAJ5rkKxj8qgP4fqsKQK9O6ykc4GpfubsTD7UuxK+lLc3mQaqOLiqFH3CjuwVrUjPF
         T5xZs+D1ddd5g8SsHgwL54V5xDO26BjzOUM3KIacycUHTdm4rSi1m1apl/hBth6p3dfV
         0M1PJfUXHTqyas5Jl1KWKLp8eg2IF3FyOs3mMZxTGWMOCmwv0dexCIVIC1Buqg5HFPqb
         7gwVQA04HOC9ANQvhpbNtkPcBxmiKDU+Xv/JJIwWOEkmGuARgE764TWGnXdk4B4w7vSD
         78Wub/ACvgIIZcSfX+vYicQvhKHpNPJm5qujo1OKShLbsGP95rKMp9yv3gzABXsYHki0
         ZdAg==
X-Gm-Message-State: APjAAAX/pBonbS2ODLOd25m82v+cGiT3EmrZt6G8/m3CS88vxAARfRea
        aQa1pcFi8BR3u5M8T4kk1xDNqF1VlnosLeNQ/biO1aT5CKM=
X-Google-Smtp-Source: APXvYqxE7eOKAQ3px7Gpem8juLQVvInXXxZ5kYC7TrTSrzVmYmuovVl3E4OQ10+4Xvkb59SNV7U5HzBBRDOVWrdhpDY=
X-Received: by 2002:a5b:48a:: with SMTP id n10mr2449710ybp.320.1556796003031;
 Thu, 02 May 2019 04:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com>
In-Reply-To: <20190502040331.81196-1-ezemtsov@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 May 2019 07:19:52 -0400
Message-ID: <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     ezemtsov@google.com
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 12:04 AM <ezemtsov@google.com> wrote:
>
> Hi All,
>
> Please take a look at Incremental FS.
>
> Incremental FS is special-purpose Linux virtual file system that allows
> execution of a program while its binary and resource files are still bein=
g
> lazily downloaded over the network, USB etc. It is focused on incremental
> delivery for a small number (under 100) of big files (more than 10 megaby=
tes each).
> Incremental FS doesn=E2=80=99t allow direct writes into files and, once l=
oaded, file
> content never changes. Incremental FS doesn=E2=80=99t use a block device,=
 instead it
> saves data into a backing file located on a regular file-system.
>
> What=E2=80=99s it for?
>
> It allows running big Android apps before their binaries and resources ar=
e
> fully loaded to an Android device. If an app reads something not loaded y=
et,
> it needs to wait for the data block to be fetched, but in most cases hot =
blocks
> can be loaded in advance and apps can run smoothly and almost instantly.

This sounds very useful.

Why does it have to be a new special-purpose Linux virtual file?
Why not FUSE, which is meant for this purpose?
Those are things that you should explain when you are proposing a new
filesystem,
but I will answer for you - because FUSE page fault will incur high
latency also after
blocks are locally available in your backend store. Right?

How about fscache support for FUSE then?
You can even write your own fscache backend if the existing ones don't
fit your needs for some reason.

Do you know of the project https://vfsforgit.org/?
Not exactly the same use case but very similar.
There is ongoing work on a Linux port developed by GitHub.com:
https://github.com/github/libprojfs

Piling logic into the kernel is not the answer.
Adding the missing interfaces to the kernel is the answer.

Thanks,
Amir.
