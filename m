Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA072886B9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 12:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387570AbgJIKSi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgJIKSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:18:38 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E80C0613D2;
        Fri,  9 Oct 2020 03:18:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u19so9565191ion.3;
        Fri, 09 Oct 2020 03:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Y4lptqLbscY9tMeYKpziy+lZfi07IAnN2JlQGiAiY2Y=;
        b=YbZrcyp8iB4BWyJcfn64Dumb50RbytQy9JYECrmb77dbmoAdWIBJOIcg54WR50izmi
         55F0PriXbq/cdZVk+69gqbpHGTQIvpAtu+rvqdTIzWEbOv/BwHafx8wRsqlc4Wt9GlqC
         ShAW4jv71J2cGfTG/K0dRKBo3t1/J/fmdJCY9aL5SyJbkFSViKLdZ5e+LbqFLSHA2NQK
         fQmprcHgV7ZOWSlqb3u+uqjgWU/8RAc1UFt4ORjkrYfSghhpRsDrj/EgkxyxPlAY3dyO
         VlVkjyeLPzQvYTp0gkApXz1lzbGmwfvrC0F11pjgRjhBxmOWF/S5L2xYtLp44f43EdPT
         kJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Y4lptqLbscY9tMeYKpziy+lZfi07IAnN2JlQGiAiY2Y=;
        b=JHyZtJSqST/ed8EHax+V6JQYvCqsYqoCmBo5b+4nyBKLgqnaCgkebxfjMXvayaOxaA
         5HekWPHn8Hdd1Oggb2HOr4yRIwY9Y3gDjmFwmNGVAVF6vBWsDhLhELa23FHkiuJJm06k
         vkf1eBfI7j/Wo9YiagoHZaEROpyX9DKH6KM5MtPa2ueHMHBIJ58yrJDX1/x7R2tLPbQ8
         DIQrtDEig6hJWFzNFMTBUjgJmzJBzQCAOkvPzUb0B8+Eu7XvPT4lZtX/T0psZrtKJh/M
         38+fMdqqWeh8LucEewFEsXK32PWuI7ste17EQS8RZti5ObIkj8G6gdCOFEFF8VLFCPRR
         Q/SA==
X-Gm-Message-State: AOAM532vF+5wnpl+RpCtN2ISes+/DrnW1GF2NglOjsNs8qIy4O+xjau3
        28zwumF64Zf+ROimyvKOIcmsJfE6azm0jD+2wUYt5G1NnHiCEQ==
X-Google-Smtp-Source: ABdhPJyn1jxZ2DRcKx96ZWhTYK2Ft3WJX50NELibl8KfUB9/8XIwa2Fze6N+3AWegm4Uwv+BJqSRtNvAF5gp1b23QJ8=
X-Received: by 2002:a02:7717:: with SMTP id g23mr10123023jac.97.1602238715692;
 Fri, 09 Oct 2020 03:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com>
 <CA+icZUVPXFkc7ow5-vF4bxggE63LqQkmaXA6m9cAZVCOnbS1fQ@mail.gmail.com> <22e5c5f9-c06b-5c49-d165-8f194aad107b@linux.ibm.com>
In-Reply-To: <22e5c5f9-c06b-5c49-d165-8f194aad107b@linux.ibm.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Oct 2020 12:18:23 +0200
Message-ID: <CA+icZUXLDGfHVGJXp2dA2JAxP8LUV4EVDNJmz20YjHa5A9oTtQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: Fix bs < ps issue reported with dioread_nolock
 mount opt
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jack@suse.cz, anju@linux.vnet.ibm.com,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 9:19 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
>
> On 10/9/20 12:16 PM, Sedat Dilek wrote:
> > On Thu, Oct 8, 2020 at 5:56 PM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> >>
> >> left shifting m_lblk by blkbits was causing value overflow and hence
> >> it was not able to convert unwritten to written extent.
> >> So, make sure we typecast it to loff_t before do left shift operation.
> >> Also in func ext4_convert_unwritten_io_end_vec(), make sure to initialize
> >> ret variable to avoid accidentally returning an uninitialized ret.
> >>
> >> This patch fixes the issue reported in ext4 for bs < ps with
> >> dioread_nolock mount option.
> >>
> >> Fixes: c8cc88163f40df39e50c ("ext4: Add support for blocksize < pagesize in dioread_nolock")
> >
> > Fixes: tag should be 12 digits (see [1]).
> > ( Seen while walking through ext-dev Git commits. )
>
>
> Thanks Sedat, I guess it should be minimum 12 chars [1]
>
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n177
>

OK.

In my ~/.gitconfig:

[core]
       abbrev = 12

# Check for 'Fixes:' tag used in the Linux-kernel development process
(Thanks Kalle Valo).
# Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
# Usage: $ git log --format=fixes | head -5
[pretty]
   fixes = Fixes: %h (\"%s\")

Hope this is useful for others.

- Sedat -
