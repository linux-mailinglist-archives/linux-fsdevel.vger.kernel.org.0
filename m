Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296AA1AF526
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 23:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgDRVez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 17:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDRVez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 17:34:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E51CC061A0C;
        Sat, 18 Apr 2020 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FCIeSzEYM5cBJ5QKnrFD/l00gE1X3fxUAHuUbbJXvBo=; b=FMVHKdYlsA9pIzaGaKXdrCKQ2l
        I5qMwSv8W26YQHn8pkLFkbDTL7P1UIggv9p2FQ5hpD4CNVvt+5NvrIp9bO0X/pwct0cpK26xkmoAV
        zPGPKBEiugEyGBL6l6O84S25liLBXajlKfZ2YwMZJvMzDhVbbtJEGMkq+ZSRTztR/XHiFwlhXvG6E
        0cJczkw97qiwu9FKK5xM0C7jeFJ28jL0SnwSoiN90PHQN+dVbHcM6yRFPsSIY2etDSOsDrQKprDUD
        8kax0MIOyNglB9MM2fOqUwlP3ufTdw3bbZlngow+RTjJXZPR08/Nyg1q/2MGyMc/ZrYlbp9UkiSSO
        2+Q4WGkg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPv6y-0006Vw-1j; Sat, 18 Apr 2020 21:34:52 +0000
Date:   Sat, 18 Apr 2020 14:34:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] ipc: Convert ipcs_idr to XArray
Message-ID: <20200418213451.GS5820@bombadil.infradead.org>
References: <20200326151418.27545-1-willy@infradead.org>
 <20200418131509.fb3c19bf450d618be797c030@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200418131509.fb3c19bf450d618be797c030@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 18, 2020 at 01:15:09PM -0700, Andrew Morton wrote:
> > --- a/ipc/util.c
> > +++ b/ipc/util.c
> > @@ -104,12 +104,20 @@ static const struct rhashtable_params ipc_kht_params = {
> >  	.automatic_shrinking	= true,
> >  };
> >  
> > +#ifdef CONFIG_CHECKPOINT_RESTORE
> 
> The code grew a few additional CONFIG_CHECKPOINT_RESTORE ifdefs. 
> What's going on here?  Why is CRIU special in ipc/?

"grew a few"?  I added (this) one and deleted two others.  From in the
middle of functions, like we usually prefer.

I mean, this is why we need something like this:

@@ -17,11 +17,11 @@ struct ipc_ids {
...
 #ifdef CONFIG_CHECKPOINT_RESTORE
-       int next_id;
+       int restore_id;
 #endif

> > +#define set_restore_id(ids, x)	ids->restore_id = x
> > +#define get_restore_id(ids)	ids->restore_id
> > +#else
> > +#define set_restore_id(ids, x)	do { } while (0)
> > +#define get_restore_id(ids)	(-1)
> > +#endif
> 
> Well these are ugly.  Can't all this be done in C?

Would you rather see it done as:

static inline void set_restore_id(struct ipc_ids *ids, int id)
{
#ifdef CONFIG_CHECKPOINT_RESTORE
	ids->restore_id = id;
#endif
}

static inline int get_restore_id(struct ipc_ids *ids)
{
#ifdef CONFIG_CHECKPOINT_RESTORE
	return ids->restore_id;
#else
	return -1;
#endif
}
