Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9266B1AF549
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 00:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDRWIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 18:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbgDRWIl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:08:41 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C1692064A;
        Sat, 18 Apr 2020 22:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587247721;
        bh=+JxDSAF2GkIsHTRigyqUKkgyWjs9af6lBO51pwF5L1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EZSsVPWYr3VBx31t/yJUyPOw6mzZCoPXb47pBtb5SF/FCvrRmLO7FaHjbAxwf6Ns7
         a+uu0zY74WRuawS+2Hs0+TX4rV/7VTMxgmlCPGEdMy+OP4ihGYNwLIrhpkGdBT9t/e
         v4f+IBcr0ZusVlHsG26EDRTSCG3HYjMN8iMvt2Ks=
Date:   Sat, 18 Apr 2020 15:08:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manfred Spraul <manfred@colorfullife.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH] ipc: Convert ipcs_idr to XArray
Message-Id: <20200418150840.5fd3916821a49993b0ff78e4@linux-foundation.org>
In-Reply-To: <20200418213451.GS5820@bombadil.infradead.org>
References: <20200326151418.27545-1-willy@infradead.org>
        <20200418131509.fb3c19bf450d618be797c030@linux-foundation.org>
        <20200418213451.GS5820@bombadil.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 18 Apr 2020 14:34:51 -0700 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Apr 18, 2020 at 01:15:09PM -0700, Andrew Morton wrote:
> > > --- a/ipc/util.c
> > > +++ b/ipc/util.c
> > > @@ -104,12 +104,20 @@ static const struct rhashtable_params ipc_kht_params = {
> > >  	.automatic_shrinking	= true,
> > >  };
> > >  
> > > +#ifdef CONFIG_CHECKPOINT_RESTORE
> > 
> > The code grew a few additional CONFIG_CHECKPOINT_RESTORE ifdefs. 
> > What's going on here?  Why is CRIU special in ipc/?
> 
> "grew a few"?  I added (this) one and deleted two others.  From in the
> middle of functions, like we usually prefer.
> 

Oh.

> 
> @@ -17,11 +17,11 @@ struct ipc_ids {
> ...
>  #ifdef CONFIG_CHECKPOINT_RESTORE
> -       int next_id;
> +       int restore_id;
>  #endif
> 
> > > +#define set_restore_id(ids, x)	ids->restore_id = x
> > > +#define get_restore_id(ids)	ids->restore_id
> > > +#else
> > > +#define set_restore_id(ids, x)	do { } while (0)
> > > +#define get_restore_id(ids)	(-1)
> > > +#endif
> > 
> > Well these are ugly.  Can't all this be done in C?
> 
> Would you rather see it done as:
> 
> static inline void set_restore_id(struct ipc_ids *ids, int id)
> {
> #ifdef CONFIG_CHECKPOINT_RESTORE
> 	ids->restore_id = id;
> #endif
> }
> 
> static inline int get_restore_id(struct ipc_ids *ids)
> {
> #ifdef CONFIG_CHECKPOINT_RESTORE
> 	return ids->restore_id;
> #else
> 	return -1;
> #endif
> }

Looks nicer.  Has type checking regardless of Kconfig.  Doesn't have
lval-and-rval in one case, neither in the other.  Doesn't risk
unused-var warnings dependent on Kconfig.  Etc.

Could also do

#ifdef CONFIG_CHECKPOINT_RESTORE
static inline void set_restore_id(struct ipc_ids *ids, int id)
{
	ids->restore_id = id;
}

static inline int get_restore_id(struct ipc_ids *ids)
{
	return ids->restore_id;
	return -1;
}
#else
...
