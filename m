Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05DA4202525
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 18:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgFTQPl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 12:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTQPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:15:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA0FC06174E
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jun 2020 09:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9uIhA1Toyo/UbtRGFPRxn1KUA3aO8ENCwe/486W1u60=; b=DF9Vt5Ix2NXg1gSe0aD8ck7rcZ
        A9W/EnVNtINZylJZsnGMZdSX/9BVEux8H+WTR8kIUPiD61zmiszxFHGLNKy+IZnd1UFu0/KG4ugmu
        rcG+aLdSdxNPm5vM/KWDsWw93azfB8gUgVFbVJoyFrL4GGx/fEgz3GpKDDcnNmO+i3AgQCCkJaRR8
        j6U4msJrVuKXBWCJ+4tcmsmO97tb+W0qbs1+vDWQDn/0JjVIPBPxVkVYxPa7TVyaco37up2sKTsbZ
        elBXStpVSElTEubaBwIyPgKDEHQaRPuLFoied8+MrAJmQE3syG7TzMn8NlANueD7UiU4W5RK8YyHk
        kr9t/NJA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmg9T-0003ws-7N; Sat, 20 Jun 2020 16:15:31 +0000
Date:   Sat, 20 Jun 2020 09:15:31 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Files dated before 1970
Message-ID: <20200620161531.GE8681@bombadil.infradead.org>
References: <20200620021611.GD8681@bombadil.infradead.org>
 <CAK8P3a1UOJa5499mZErTH6vHgLLJzr+R0EYbcbheSbjw0VqsHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1UOJa5499mZErTH6vHgLLJzr+R0EYbcbheSbjw0VqsHQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 20, 2020 at 10:59:48AM +0200, Arnd Bergmann wrote:
> On Sat, Jun 20, 2020 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
> > le32_to_cpu() returns a u32.  Before your patch, the u32 was assigned
> > to an s32, so a file with a date stamp of 1968 would show up that way.
> > After your patch, the u32 is zero-extended to an s64, so a file from
> > 1968 now appears to be from 2104.
> 
> In the case of JFS, I think the change of behavior on 32-bit kernels was
> intended because it makes them do the same thing as 64-bit kernels.

Oh!  I hadn't realised that 64-bit kernels were already using a 64-bit
signed tv_sec.  That makes a world of difference.

> For JFS and the others that already used an unsigned interpretation
> on 64 bit kernels, the current code seems to be the least broken
> of the three alternatives we had:
> 
> a) as implemented in v4.18, change 32-bit kernels to behave the
>    way that 64-bit kernels always have behaved, given that 99% of
>    our users are on 64-bit kernels by now.
> 
> b) keep 32-bit and 64-bit kernels use a different interpretation,
>    staying compatible with older kernels but incompatible between
>    machines or between running the same user space on the
>    same machine in either native 32-bit mode or compat mode
>     a 64-bit kernel
> 
> c) change the 99% of users that have a 64-bit kernel to overflowing
>     the timestamps in y2038 because that was what the kernel
>     file system driver originally implemented on 32-bit machines
>     that no concept of post-y2038 time.

Yes, I agree, knowing more of the facts, this was the right decision to
make at the time, and I wouldn't change it now.  Thanks!
