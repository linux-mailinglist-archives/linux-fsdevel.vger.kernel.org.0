Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 778C2A14EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 11:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfH2J2j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 05:28:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34445 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfH2J2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 05:28:39 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so5648202ioa.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2019 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v06lta4MYVBJBZLQ73bBpIez3Zzb0/6n6ZDJgeZvvFA=;
        b=Hc9GLAgOOnaaXsF3NrbM7AecX7f3q0LEmVqWdNl+cCygzK/RxeejM05rD+PoBYvpNy
         iCfIvK00i3nYnz/7hEF1IyoD0raYoTA0Fi7pIXSNsQiydr+b2RWwANqNTLEGdoi4TVze
         EI0HrSen2CJeJvMGU2pb8OzX9tm5amIQIkLoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v06lta4MYVBJBZLQ73bBpIez3Zzb0/6n6ZDJgeZvvFA=;
        b=QUcygq2sOaMH0RkjhwYc+9ShPaVSL/O7N/Bqxik+2ws3cPJli9bWr5bSbeT+ldXORr
         NMCVe3RkBAoS44aAJaJJNCmqVK+646QxoFlE+MxkdPmSTknRAinBqhektqstm7kXtZm9
         QJLJluZh28UQwOymgmyb/Uoyzpr8sppEAd7BF7Wn5Xn54F+lLGGRdphxPYzsOw4CY1ld
         W31G8Omeb5VQR/V0MRLSB6rxqapIEmsTW87GO28w9E18VmjZo1jm1xW1qo9X8gdmWERn
         +V771fq3Arx9yI40Ikpe17ejRKiTWjSko9oFZAIwMdkQyh7g3Yx+b32KHtCLBHkZ2MZe
         58oA==
X-Gm-Message-State: APjAAAVbv1EFJAp48nPDk/O5CHVRdd2Wo16rB4jXiujd/5SKFLiWLsx7
        zPEFHEDJyPNtsrGhUkMRp40QqO53+1MQ+owMDPt2VA==
X-Google-Smtp-Source: APXvYqyUavfINYtqJHGpZUBR9A9V8dAVHmilYmO0JxPFl0AJag7dkVSKSrPI4+FtMTzlVFjVPwtJnqsyT6kSq+5gC8c=
X-Received: by 2002:a5e:da48:: with SMTP id o8mr593380iop.252.1567070918305;
 Thu, 29 Aug 2019 02:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190821173742.24574-1-vgoyal@redhat.com>
In-Reply-To: <20190821173742.24574-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 29 Aug 2019 11:28:27 +0200
Message-ID: <CAJfpegv_XS=kLxw_FzWNM2Xao5wsn7oGbk3ow78gU8tpXwo-sg@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] virtio-fs: shared file system for virtual machines
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 21, 2019 at 7:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi,
>
> Here are the V3 patches for virtio-fs filesystem. This time I have
> broken the patch series in two parts. This is first part which does
> not contain DAX support. Second patch series will contain the patches
> for DAX support.
>
> I have also dropped RFC tag from first patch series as we believe its
> in good enough shape that it should get a consideration for inclusion
> upstream.

Pushed out to

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next

Major changes compared to patchset:

 - renamed to "virtiofs".  Filesystem names don't usually have
underscore before "fs" postfix.

 - removed option parsing completely.  Virtiofs config is fixed to "-o
rootmode=040000,user_id=0,group_id=0,allow_other,default_permissions".
Does this sound reasonable?

There are miscellaneous changes, so needs to be thoroughly tested.

I think we also need something in
"Documentation/filesystems/virtiofs.rst" which describes the design
(how  request gets to userspace and back) and how to set up the
server, etc...  Stefan, Vivek can you do something like that?

Thanks,
Miklos
