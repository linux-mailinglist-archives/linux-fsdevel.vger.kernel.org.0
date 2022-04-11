Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220C34FC300
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbiDKRPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239952AbiDKRPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 216512408C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649697185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qOJohGt27FNKYr3QwvcQ0EegG1Bmj5dONFlcPsKr8yo=;
        b=Q5H7vDu5a5xyv2ckpbrKT/2qB9gC/5I59P4yvIelRngVh3WgYRHUPkEVi+RheBMRXZ/4cj
        WD75Lx+ycWbZL34Cwmpb8eP/4c4OLcSCGBFatAe21S3n8LdPEv9w2GGBfpqL4dR6bmKRjD
        AWSgRKIwvLl+CxsHApkYWRMzPGXTniE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-VkJbX49sOj6-901VB3sbCw-1; Mon, 11 Apr 2022 13:13:04 -0400
X-MC-Unique: VkJbX49sOj6-901VB3sbCw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97C9C899EC2;
        Mon, 11 Apr 2022 17:13:03 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 905E940CF911;
        Mon, 11 Apr 2022 17:13:03 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 23BHD3kg003774;
        Mon, 11 Apr 2022 13:13:03 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 23BHD37M003770;
        Mon, 11 Apr 2022 13:13:03 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Mon, 11 Apr 2022 13:13:03 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
In-Reply-To: <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com> <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 11 Apr 2022, Linus Torvalds wrote:

> On Mon, Apr 11, 2022 at 4:43 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > If you run a program compiled with OpenWatcom for Linux on a filesystem on
> > NVMe, all "stat" syscalls fail with -EOVERFLOW. The reason is that the
> > NVMe driver allocates a device with the major number 259 and it doesn't
> > pass the "old_valid_dev" test.
> 
> OpenWatcom? Really?

Yes. I use OpenWatcom to verify that my programs are clean ANSI C without 
any gccisms.

Other than that, it is not much useful - it has it's own libc, it's own 
module format, and programs compiled with OpenWatcom cannot be linked with 
existing *.a or *.so libraries.

> > This patch removes the tests - it's better to wrap around than to return
> > an error. (note that cp_old_stat also doesn't report an error and wraps
> > the number around)
> 
> Hmm. We've used majors over 256 for a long time, but some of them are
> admittedly very rare (SCSI OSD?)
> 
> Unfortunate. And in this case 259 aliases to 3, which is the old
> HD/IDE0 major number. That's not great - there would be other numbers
> that didn't have that problem (ie 4-6 are all currently only character
> device majors, I think).

Should we perhaps hash the number, take 16 bits of the hash and hope 
than the collision won't happen?

> Anyway, I think that check is just bogus. The cp_new_stat() thing uses
> 'struct stat' and it has
> 
>         unsigned long   st_dev;         /* Device.  */
>         unsigned long   st_rdev;        /* Device number, if device.  */
> 
> so there's no reason to limit things to the old 8-bit behavior.
> 
> Yes, it does that
> 
>   #define valid_dev(x)  choose_32_64(old_valid_dev(x),true)
>   #define encode_dev(x) choose_32_64(old_encode_dev,new_encode_dev)(x)
> 
>   static __always_inline u16 old_encode_dev(dev_t dev)
>   {
>         return (MAJOR(dev) << 8) | MINOR(dev);
>   }
> 
> which currently drops bits, but we should just *fix* that. We can put
> the high bits in the upper bits, not limit it to 16 bits when we have
> more space than that.

Yes - we can return values larger than 16-bit here. But there's a risk 
that the userspace code will extract the values using macros like this and 
lose the upper bits:

#define major(device)           ((int)(((device) >> 8) & 0xFF))
#define minor(device)           ((int)((device) & 0xff))

> Even the *really* old 'struct old_stat' doesn't really have a 16-bit
> st_dev/rdev.
> 
>            Linus

For me, the failure happens in cp_compat_stat (I have a 64-bit kernel). In 
struct compat_stat in arch/x86/include/asm/compat.h, st_dev and st_rdev 
are compat_dev_t which is 16-bit. But they are followed by 16-bit 
paddings, so they could be extended.

If you have a native 32-bit kernel, it uses 'struct stat' defined at the 
beginning of arch/x86/include/uapi/asm/stat.h that has 32-bit st_dev and 
st_rdev. If you use a 64-bit kernel with 32-bit compat, it uses 'struct 
compat_stat' defined in arch/x86/include/asm/compat.h that has 16-bit 
st_dev and st_rdev. That's an inconsistency that should be resolved.

What did glibc do? Did it use 16-bit dev_t with following padding or 
32-bit dev_t? (the current glibc just uses stat64 and 64-bit dev_t always)

Mikulas

