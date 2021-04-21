Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B61366986
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 12:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbhDUK6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 06:58:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:35492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhDUK6E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 06:58:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619002649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rgVvXl99TxnibcW76eYvhg6wpPaOgg+p9bccUoVFxxs=;
        b=b6CyN9SxhFfZjTTdYIQvTKNt4IfcXFXUGqZZgtYgycjhCjHVTyJO+Nm64qI+MUFZEN89qx
        0/5HRjjPSgc/foprJoUiqhzBdLZ804nlBYre2Cj4o12VvXdtlo84o7vj4YaqOK/NMkvwKH
        sDC5MoXlQI3KrSGua6OjVjS8aBB6TAg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A8F7AEE7;
        Wed, 21 Apr 2021 10:57:29 +0000 (UTC)
Date:   Wed, 21 Apr 2021 12:57:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Peter.Enderborg@sony.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        adobriyan@gmail.com, akpm@linux-foundation.org,
        songmuchun@bytedance.com, guro@fb.com, shakeelb@google.com,
        neilb@suse.de, samitolvanen@google.com, rppt@kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, willy@infradead.org
Subject: Re: [PATCH v5] dma-buf: Add DmaBufTotal counter in meminfo
Message-ID: <YIAFGF4QFX92WG/I@dhcp22.suse.cz>
References: <20210417163835.25064-1-peter.enderborg@sony.com>
 <YH6Xv00ddYfMA3Lg@phenom.ffwll.local>
 <176e7e71-59b7-b288-9483-10e0f42a7a3f@sony.com>
 <YH63iPzbGWzb676T@phenom.ffwll.local>
 <a60d1eaf-f9f8-e0f3-d214-15ce2c0635c2@sony.com>
 <YH/tHFBtIawBfGBl@phenom.ffwll.local>
 <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbde932e-8887-391f-4a1d-515e5c56c01d@sony.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 21-04-21 10:37:11, Peter.Enderborg@sony.com wrote:
> On 4/21/21 11:15 AM, Daniel Vetter wrote:
[...]
> > We need to understand what the "correct" value is. Not in terms of kernel
> > code, but in terms of semantics. Like if userspace allocates a GL texture,
> > is this supposed to show up in your metric or not. Stuff like that.
> That it like that would like to only one pointer type. You need to know what
> 
> you pointing at to know what it is. it might be a hardware or a other pointer.
> 
> If there is a limitation on your pointers it is a good metric to count them
> even if you don't  know what they are. Same goes for dma-buf, they
> are generic, but they consume some resources that are counted in pages.
> 
> It would be very good if there a sub division where you could measure
> all possible types separately.  We have the detailed in debugfs, but nothing
> for the user. A summary in meminfo seems to be the best place for such
> metric.

I strongly suspect that the main problem of this patch (and its previous
versions) is that you are failing to explain the purpose of the counter
to others. From what you have said so far it sounds like this is a
number which is nice to have because gives us more than nothing. And
while this is not really hard to agree with it doesn't really meet the
justification for exporting yet another counter to the userspace with
all the headache of the future maintenance. I think it would hugely help
to describe a typical scenario when the counter would be useful and the
conclusion you can draw from the exported value or a set of values over
time.

And please note that a mixed bag of different memory resources in a
single counter doesn't make this any easier because then it essentially
makes it impossible to know whether an excessive usage contribues to RAM
or device memory depletion - hence this is completely bogus for the OOM
report.
-- 
Michal Hocko
SUSE Labs
