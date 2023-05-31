Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1329F717947
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 09:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjEaH7A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 03:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbjEaH6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 03:58:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11949E6A;
        Wed, 31 May 2023 00:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 709A8636A0;
        Wed, 31 May 2023 07:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0046AC4339E;
        Wed, 31 May 2023 07:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685519586;
        bh=S0GisPmsqjyz7HCMTOJiz8ZWWhleMBu7VOEDA1PRQAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNGpOMbqUyPbLn9cRXfHlKeQs9E2d3KUWh3P7F+bE3jatKI89Ph1ubaXGVb1Npi3g
         1j/q4Rk6j2pLRdZ2gtoGMyaSD72BnTuQ35sm4PEfw1QNhdgjENObxBQC8ABwYokQ1p
         0LTZiUGeuhzIKEgYG3+kV2kfaM/xyfy3tSf5lkiZfltOaLZ0Yf1a9SlZI+pasM9oTw
         O8+vqBAL9M3AwuT2PLokyn5H/6l5dNYBgalhf97LukxvciFG5dBeGG+uTuFGmZZzQJ
         zlfXOjRsSXRKunDt46Q7hF3dTt5RlWVThiAhMTnCeyapq2RYrwN/i2IScdxrBbTISQ
         IRRre9952mazA==
Date:   Wed, 31 May 2023 09:53:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Benjamin Segall <bsegall@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] epoll: ep_autoremove_wake_function should use
 list_del_init_careful
Message-ID: <20230531-zupacken-laute-22564cd952f7@brauner>
References: <xm26pm6hvfer.fsf@google.com>
 <20230531015748.GB1648@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531015748.GB1648@quark.localdomain>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 30, 2023 at 06:57:48PM -0700, Eric Biggers wrote:
> On Tue, May 30, 2023 at 11:32:28AM -0700, Benjamin Segall wrote:
> > autoremove_wake_function uses list_del_init_careful, so should epoll's
> > more aggressive variant. It only doesn't because it was copied from an
> > older wait.c rather than the most recent.
> > 
> > Fixes: a16ceb139610 ("epoll: autoremove wakers even more aggressively")
> > Signed-off-by: Ben Segall <bsegall@google.com>
> > Cc: stable@vger.kernel.org
> > ---
> >  fs/eventpoll.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > index 52954d4637b5..081df056398a 100644
> > --- a/fs/eventpoll.c
> > +++ b/fs/eventpoll.c
> > @@ -1756,11 +1756,11 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
> >  static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
> >  				       unsigned int mode, int sync, void *key)
> >  {
> >  	int ret = default_wake_function(wq_entry, mode, sync, key);
> >  
> > -	list_del_init(&wq_entry->entry);
> > +	list_del_init_careful(&wq_entry->entry);
> >  	return ret;
> >  }
> 
> Can you please provide a more detailed explanation about why
> list_del_init_careful() is needed here?

Yeah, this needs more explanation... Next time someone looks at this
code and there's a *_careful() added they'll want to know why.
