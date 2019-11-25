Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02D108E15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 13:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKYMiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 07:38:51 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36795 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfKYMiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 07:38:50 -0500
Received: by mail-io1-f68.google.com with SMTP id s3so16047067ioe.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 04:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5f4xUL+V2+8/nQMkQs1b9op2wEG2TkCTmUU2i8ZzYk=;
        b=AHgt+QfsItPF5DapufRvH6vvDvsst4aKQbSqxqP24tQdnEHkKoAlzB0ygK8TNXfyVh
         F+OVMDWjsnnNL/xUWvoZxYFLiUvdXPp3iz7blyK5pxMDVb6xcnh6GGRAGHeuUSfpzoUH
         BxGBA2oucqlYT6DqajybB3niI5Js8/u5FBjR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5f4xUL+V2+8/nQMkQs1b9op2wEG2TkCTmUU2i8ZzYk=;
        b=SmWKDYHyd0887YziBsCNFN/JTFDoX91aaYO9eVWyzeDjDmC9Es1Y4pEUoXLxOs8X1y
         DYV0itO2H8+idahuCJaihqWsu8MESKiusd+hl/+80YtZ9FOwbxdHGZdKC+mYccRCypKk
         JD5b7jX5Kt0wJzhCmOUEHQhfR1z/D/R9uB2YvzhEa2poBnikYz0zBz4cicNbSZzeEDOA
         U/bpbPZFKJ+2W087hhXHxZobW5G/MWdz6NGkkYQPPUNqTIgZunmGjIIwLWcc5OJzyPwr
         GyNLaqTcnkpgGW7p15BIFLxnmozR/utpRm6kCMB9IQiFvREt7+vkc7BWM9vAR2trwkX7
         wBSw==
X-Gm-Message-State: APjAAAVZK1763aCPRaMdJkZGoKihfZ6e8DndjKhWAUsTu9P+GRPF9cJJ
        ehQeAeqcp3U/zqPz/NALdiE5gUqJAMHWB0aLi+8dTQ==
X-Google-Smtp-Source: APXvYqyrI2XBXiAG4sSRBpuTyXK5l4SVfiINViwTamqpuEuwVM+f4v+nY5E/X5KvWjtoQDk///u2B3UQGcG787QIN8E=
X-Received: by 2002:a6b:b296:: with SMTP id b144mr23856761iof.63.1574685529947;
 Mon, 25 Nov 2019 04:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20191118022410.21023-1-msys.mizuma@gmail.com>
In-Reply-To: <20191118022410.21023-1-msys.mizuma@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Nov 2019 13:38:38 +0100
Message-ID: <CAJfpegveuh3b0GMOmC3SuMOq=yi9sgBeOS2LGEetbfKqyS1xtQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: Fix the return code of fuse_direct_IO() to deal
 with the error for aio
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Content-Type: multipart/mixed; boundary="000000000000a58caf05982b0b24"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000a58caf05982b0b24
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 18, 2019 at 3:24 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> exit_aio() is sometimes stuck in wait_for_completion() after aio is issued
> with direct IO and the task receives a signal.
>
> That is because kioctx in mm->ioctx_table is in use by aio_kiocb.
> aio_kiocb->ki_refcnt is 1 at that time. That means iocb_put() isn't
> called correctly.
>
> fuse_get_req() returns as -EINTR when it's blocked and receives a signal.
> fuse_direct_IO() deals with the -EINTER as -EIOCBQUEUED and returns as
> -EIOCBQUEUED even though the aio isn't queued.
> As the result, aio_rw_done() doesn't handle the error, so iocb_put() isn't
> called via aio_complete_rw(), which is the callback.

Hi,

Thanks for the report.

Can you please test the attached patch (without your patch)?

Thanks,
Miklos

--000000000000a58caf05982b0b24
Content-Type: text/x-patch; charset="US-ASCII"; name="fuse-fix-leak-of-fuse_io_priv.patch"
Content-Disposition: attachment; 
	filename="fuse-fix-leak-of-fuse_io_priv.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k3eesp440>
X-Attachment-Id: f_k3eesp440

LS0tCiBmcy9mdXNlL2ZpbGUuYyB8ICAgIDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQoKLS0tIGEvZnMvZnVzZS9maWxlLmMKKysrIGIvZnMvZnVz
ZS9maWxlLmMKQEAgLTcxMyw4ICs3MTMsMTAgQEAgc3RhdGljIHNzaXplX3QgZnVzZV9hc3luY19y
ZXFfc2VuZChzdHJ1YwogCiAJaWEtPmFwLmFyZ3MuZW5kID0gZnVzZV9haW9fY29tcGxldGVfcmVx
OwogCWVyciA9IGZ1c2Vfc2ltcGxlX2JhY2tncm91bmQoZmMsICZpYS0+YXAuYXJncywgR0ZQX0tF
Uk5FTCk7CisJaWYgKGVycikKKwkJZnVzZV9haW9fY29tcGxldGVfcmVxKGZjLCAmaWEtPmFwLmFy
Z3MsIGVycik7CiAKLQlyZXR1cm4gZXJyID86IG51bV9ieXRlczsKKwlyZXR1cm4gbnVtX2J5dGVz
OwogfQogCiBzdGF0aWMgc3NpemVfdCBmdXNlX3NlbmRfcmVhZChzdHJ1Y3QgZnVzZV9pb19hcmdz
ICppYSwgbG9mZl90IHBvcywgc2l6ZV90IGNvdW50LAo=
--000000000000a58caf05982b0b24--
