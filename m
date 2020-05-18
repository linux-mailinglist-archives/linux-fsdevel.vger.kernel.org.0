Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669641D7C0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgERO6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgERO6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 10:58:18 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E41C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 07:58:17 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id l21so9058761eji.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 07:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaljLdaQEqjIwG5s3riYxKTAYKM7jSvuGLXyEfayG+w=;
        b=jNxiiFVfs7pxf9eRib5F6j64/BEJZYOo6MRhu4yXLcyO+4obcNW971sHWzMTvUXdMv
         LFDQ+P2vbh9N7eUlbK9Z7CdtKfnjT2MNOLQI0r0J6ai843uC4nQ95r5HAenLNQzMnBra
         tf4/93uD6OfR4AeYqWb1xvT8Y8yaztEI5ixig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaljLdaQEqjIwG5s3riYxKTAYKM7jSvuGLXyEfayG+w=;
        b=txLRrKhaAGKZG7fw9rEPwS2hGs71x7F+xbGdNwQvVIaCwcgq05Fa922qK0NHaVHlMq
         5I456Blvt/GBQ9ADhu06ntoadK1LoPOZX68soGliKE8ryWv8oX87LYohT4nmc+vb+RAM
         qagjeXJ4lQf+MBNhJoESXQMY+bW7p4W7lHQfw5eQTqHPc0likmNfWAZZm0gfKiy2yeRV
         AL+nQ8WI5SprnNXVlj6EGv1YxZS6pgXs3C5Ec7EpPbfb/naRR1Ws8guEsEYrc9qiT3SK
         Jqn90BRJehPVELoAf1JdkTwPzxuSG2DzWhDKuCsGUoVT8UIhP9KJDCbOCPbbPW7KKqZJ
         MQBw==
X-Gm-Message-State: AOAM531nvOdusbU8v9Qa/trrHMDQKIihSvMluFfg0IXMbxFd7jjqWZZ5
        a/zByBD17Zoblro3SqzoMagLmaRCwLU6FELQC5pxag==
X-Google-Smtp-Source: ABdhPJwfPCg+ZFk8Sq/8O1mJJLB55LOH/sio1h+rP8/Wr1EQxFfHgOkepSWHZFhuItr7OWYcAu3+WC+9KxcyIrOAQIM=
X-Received: by 2002:a17:906:82d9:: with SMTP id a25mr15825176ejy.43.1589813896578;
 Mon, 18 May 2020 07:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <87a72qtaqk.fsf@vostro.rath.org> <877dxut8q7.fsf@vostro.rath.org>
 <20200503032613.GE29705@bombadil.infradead.org> <87368hz9vm.fsf@vostro.rath.org>
 <20200503102742.GF29705@bombadil.infradead.org> <CAJfpegseoCE_mVGPR5Bt8S1WZ2bi2DnUb7QqgPm=okzx_wT31A@mail.gmail.com>
 <20200518144853.GT16070@bombadil.infradead.org>
In-Reply-To: <20200518144853.GT16070@bombadil.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 May 2020 16:58:05 +0200
Message-ID: <CAJfpegtKQ85K2iJUvm-A+cTD1TKsa1AVTDnwbeky4hyf+SJfgQ@mail.gmail.com>
Subject: Re: [fuse-devel] fuse: trying to steal weird page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-mm <linux-mm@kvack.org>, miklos <mszeredi@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 4:48 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, May 18, 2020 at 02:45:02PM +0200, Miklos Szeredi wrote:

> > page_cache_pipe_buf_steal() calls remove_mapping() which calls
> > page_ref_unfreeze(page, 1).  That sets the refcount to 1, right?
> >
> > What am I missing?
>
> find_get_entry() calling page_cache_get_speculative().
>
> In a previous allocation, this page belonged to the page cache.  Then it
> was freed, but another thread is in the middle of a page cache lookup and
> has already loaded the pointer.  It is now delayed by a few clock ticks.
>
> Now the page is allocated to FUSE, which calls page_ref_unfreeze().
> And then the refcount gets bumped to 2 by page_cache_get_speculative().
> find_get_entry() calls xas_reload() and discovers this page is no longer
> at that index, so it calls put_page(), but in that narrow window, FUSE
> checks the refcount and finds it's not 1.

What if that page_cache_get_speculative() happens just before
page_ref_unfreeze()?  The speculative reference would be lost and on
put_page() the page would be freed, even though fuse is still holding
the pointer.

Thanks,
Miklos
