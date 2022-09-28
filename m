Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904415EE302
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 19:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbiI1RZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 13:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiI1RYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:24:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B97F11836;
        Wed, 28 Sep 2022 10:24:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id d42so21494574lfv.0;
        Wed, 28 Sep 2022 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dFFDss8ZkTsJUFXPbq77SyHdbR0hvnx58KwhDKqLpSo=;
        b=ZiTnifmxRkPCeTB4+ebf2uhFYDRQMWouSa5MdgsLfW8vtobqMkhQzBrSicMxVo05OZ
         qV5w7W26YKEzy6yEw/eAqiyVEbwXW6KJv8Lb3GF+c/fTl8INVzBBw0Nh1Erfo5KGbo2q
         Lbla69FnR1k7HY//+qqC3+SuDLBnADl7ULIb0V/LKm2AZ0NwsFXiX7AuAgmztZRysimZ
         QBhYEo3O9TfwoSwnc5j/Lgq7ykw4NYPhAx1W8SLtYc4Z3koD8LdT3TYOPzwauswBnwDU
         vQi+aO3qq7OYHbxn4HgRuG7X++rq9iFbDMFn3M0cwfg4c3KsSLPweUqjCXVDGE8fQmpA
         rLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dFFDss8ZkTsJUFXPbq77SyHdbR0hvnx58KwhDKqLpSo=;
        b=qgZjBfzXlsNBULTjUOkjBKXlnpT16SoTPBSnlBK3UAQWBkdoZ7/cTyr0iEGRY16cld
         EWA3wddedI5wTQGLi0F2oXd9xNekk5V485wJKPBROFY5IeL9oZVbBmAZBAuWoiPQpp9N
         sAl+Tp3mXniqlRABWGBfjcL3nc97qSptw6xFX4YrYORzBTcr2FQlnIAFMRAp8ymtvaMO
         rteDeYIu2Bb7iRzGv6HCflH/BtJr+zFFSiWsWkwcT9Us6tCOjDEcSNE+89QGWMR7XcWo
         bTymHL2Xs7p0hsn747PISabbz44XxkdtNBpN0NaLhzXcyULyjyHk8f32ewlfGb1yiNsQ
         AEPw==
X-Gm-Message-State: ACrzQf0Wd8Yk4Ifuck8QgxKrPJP/KGKdpAHgNu2MvdMEIbYLz+Tr4aCE
        fLe+Fql9Kuf0Kel4XtCShh0nYA7AHPzrKWgJFZI=
X-Google-Smtp-Source: AMsMyM7vANgFuHUEO9H9bCKbcXCI+zshpprYVfozSllCNMES2Vlkvl622gA3/aR8WXroRHZciBcE8+bXl70+cAtF1tM=
X-Received: by 2002:a05:6512:1047:b0:49f:5309:3a0c with SMTP id
 c7-20020a056512104700b0049f53093a0cmr13216773lfb.683.1664385886495; Wed, 28
 Sep 2022 10:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
 <YyiDg79flhWoMDZB@gmail.com> <2c8b7116-56e9-3202-c47e-e42078c85793@collabora.com>
In-Reply-To: <2c8b7116-56e9-3202-c47e-e42078c85793@collabora.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Wed, 28 Sep 2022 10:24:35 -0700
Message-ID: <CANaxB-xDiTRCuWxBmrSH1u3e_ADbxCoQKmEoSsYfm4yW7k=v4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:26 AM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Hi,
>
> Thank you for reviewing.
>
> On 9/19/22 7:58 PM, Andrei Vagin wrote:
> >> This ioctl can be used by the CRIU project and other applications which
> >> require soft-dirty PTE bit information. The following operations are
> >> supported in this ioctl:
> >> - Get the pages that are soft-dirty.
> >
> > I think this interface doesn't have to be limited by the soft-dirty
> > bits only. For example, CRIU needs to know whether file, present and swap bits
> > are set or not.
> These operations can be performed by pagemap procfs file. Definitely
> performing them through IOCTL will be faster. But I'm trying to add a
> simple IOCTL by which some specific PTE bit can be read and cleared
> atomically. This IOCTL can be extended to include other bits like file,
> present and swap bits by keeping the interface simple. The following
> mask advice is nice. But if we add that kind of masking, it'll start to
> look like a filter on top of pagemap. My intention is to not duplicate
> the functionality already provided by the pagemap. One may ask, then why
> am I adding "get the soft-dirty pages" functionality? I'm adding it to
> complement the get and clear operation. The "get" and "get and clear"
> operations with special flag (PAGEMAP_SD_NO_REUSED_REGIONS) can give
> results quicker by not splitting the VMAs.

This simple interface is good only for a limited number of use-cases.
The interface
that I suggest doesn't duplicate more code than this one, but it is much more
universal. It will be a big mess if you add a separate API for each
specific use-case.

>
> >
> > I mean we should be able to specify for what pages we need to get info
> > for. An ioctl argument can have these four fields:
> > * required bits (rmask & mask == mask) - all bits from this mask have to be set.
> > * any of these bits (amask & mask != 0) - any of these bits is set.
> > * exclude masks (emask & mask == 0) = none of these bits are set.
> > * return mask - bits that have to be reported to user.
> >
> >> - Clear the pages which are soft-dirty.
> >> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
> >> soft-dirty PTE bit
> >>
> >> There are two decisions which have been taken about how to get the output
> >> from the syscall.
> >> - Return offsets of the pages from the start in the vec
> >
> > We can conside to return regions that contains pages with the same set
> > of bits.
> >
> > struct page_region {
> >       void *start;
> >       long size;
> >       u64 bitmap;
> > }
> >
> > And ioctl returns arrays of page_region-s. I believe it will be more
> > compact form for many cases.
> Thank you for mentioning this. I'd considered this while development.
> But I gave up and used the simple array to return the offsets of the
> pages as in the problem I'm trying to solve, the dirty pages may be
> present amid non-dirty pages. The range may not be useful in that case.

This is a good example. If we expect more than two consequent pages
on average, the "region" interface looks more prefered. I don't know your
use-case, but in the case of CRIU, this assumption looks reasonable.

> Also we want to return only a specific number of pages of interest. The
> following paragraph explains it.
>
> >
> >> - Stop execution when vec is filled with dirty pages
> >> These two arguments doesn't follow the mincore() philosophy where the
> >> output array corresponds to the address range in one to one fashion, hence
> >> the output buffer length isn't passed and only a flag is set if the page
> >> is present. This makes mincore() easy to use with less control. We are
> >> passing the size of the output array and putting return data consecutively
> >> which is offset of dirty pages from the start. The user can convert these
> >> offsets back into the dirty page addresses easily. Suppose, the user want
> >> to get first 10 dirty pages from a total memory of 100 pages. He'll
> >> allocate output buffer of size 10 and the ioctl will abort after finding the
> >> 10 pages. This behaviour is needed to support Windows' getWriteWatch(). The
> >> behaviour like mincore() can be achieved by passing output buffer of 100
> >> size. This interface can be used for any desired behaviour.

Now, it is more clear where this interface came from. It repeats the interface
of Windows' getWriteWatch. I think we have to look wider. The
interface that reports
regions will be more efficient for many use-cases. As for
getWriteWatch, it will require
a bit more code in user-space, but this code is trivial.

Thanks,
Andrei
