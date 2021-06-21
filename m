Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463533AE45A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 09:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUHvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 03:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhFUHvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 03:51:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C055C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 00:48:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n7so18473962wri.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B+3nVzY+A+yS0flLb0aI3OtB+R+qY6lENuass8lUP0s=;
        b=pCfdWjHBStJoBNJ03nESo/gmOCXuo7I7UpHcNfI+jjdN+mbVNglwqjbQSVwgxiKdgp
         X1I213X8ek79cNJz9yoYL+R+KBUqL5TVIjSjxpxsMKFOGfmeUkucwoO87ARFDY310HED
         9loNoUsZ9V+PE+LTNkqHTr0Hwd+Ksde+egOWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+3nVzY+A+yS0flLb0aI3OtB+R+qY6lENuass8lUP0s=;
        b=ftWLr02ADXeChaZG1mn/iptAv5mbf0c5e4dMdH8dZU12UDJ+LxmF67VlxJMkxaPhE+
         ee8RnCXkB9m1OgOwQ4mSGrulFqlNAqOgQDPiBeNL+UXW5AeBbjly6tNDjmrhCgT7frLZ
         zLBKRubkAz6JBBHZKbLU9b0U06fv7K64tQxXXHIUtgkvVm7BXBVy5BQfPW3fAtPbelgA
         BVmZNsSbbqSpQsqYgIxBVD/9jdvf0Ulu+D5aPoaAcK8bDrMaTQp+3HRT6XTMS2fBhxRX
         X3m6JeLhAU+kuurNMYizPBV0LECQGqH+agu5RgMhsTWzOylZlAtn1HAoM+Gqmxb//Cyf
         lRmA==
X-Gm-Message-State: AOAM530UGCKt97XFeTvgLu2M/HHNZ2haA544pwRBaPpdlhzb2Zso2OOr
        77cILomQYRjNPhyYRO36MU3kqA==
X-Google-Smtp-Source: ABdhPJwlmGeWNnu7+LMn0PR5SFRES8r0KS+HkgeAVqct4wQYG19Gp8ttx0vb8rjLnj1si7mags41IA==
X-Received: by 2002:adf:eb82:: with SMTP id t2mr26701649wrn.337.1624261728564;
        Mon, 21 Jun 2021 00:48:48 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id h15sm16564269wrq.88.2021.06.21.00.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 00:48:48 -0700 (PDT)
Date:   Mon, 21 Jun 2021 09:48:45 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Pradeep P V K <pragalla@codeaurora.org>
Cc:     stummala@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V1] fuse: Set fuse request error upon fuse abort
 connection
Message-ID: <YNBEXVUPgqYbraq6@miu.piliscsaba.redhat.com>
References: <1618582752-26178-1-git-send-email-pragalla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618582752-26178-1-git-send-email-pragalla@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 07:49:12PM +0530, Pradeep P V K wrote:
> There is a minor race in setting the fuse out request error
> between fuse_abort_conn() and fuse_dev_do_read() as explained
> below.
> 
> Thread-1			  Thread-2
> ========			  ========
> ->fuse_simple_request()           ->shutdown
>   ->__fuse_request_send()
>     ->queue_request()		->fuse_abort_conn()
> ->fuse_dev_do_read()                ->acquire(fpq->lock)
>   ->wait_for(fpq->lock) 	  ->set err to all req's in fpq->io
> 				  ->release(fpq->lock)
>   ->acquire(fpq->lock)
>   ->add req to fpq->io
> 
> The above scenario may cause Thread-1 request to add into
> fpq->io list after Thread-2 sets -ECONNABORTED err to all
> its requests in fpq->io list. This leaves Thread-1 request
> with unset err and this further misleads as a completed
> request without an err set upon request_end().
> 
> Handle this by setting the err appropriately.

The fix looks good, but still allows the request to block during the copy phase
after being aborted, which the FR_LOCKED/FR_ABORT bits are meant to prevent.

Here's an updated fix.  It does not allow the request to be queued on the
fpq->io list after fuse_abort_conn() has aborted requests on that list.

Can you verify that it fixes the race you reported?

Thanks,
Miklos


--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1272,6 +1272,15 @@ static ssize_t fuse_dev_do_read(struct f
 		goto restart;
 	}
 	spin_lock(&fpq->lock);
+	/*
+	 *  Must not put request on fpq->io queue after having been shut down by
+	 *  fuse_abort_conn()
+	 */
+	if (!fpq->connected) {
+		req->out.h.error = err = -ECONNABORTED;
+		goto out_end;
+
+	}
 	list_add(&req->list, &fpq->io);
 	spin_unlock(&fpq->lock);
 	cs->req = req;
