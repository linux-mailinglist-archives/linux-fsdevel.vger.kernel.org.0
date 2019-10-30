Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673E2E9C5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfJ3Ndh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 09:33:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38339 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfJ3Ndh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 09:33:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so1004274plq.5;
        Wed, 30 Oct 2019 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NmJMKAmy/TavxqAqA2RWtnDhN8WsDQ/AjcqxUwK9McE=;
        b=ms1tA2c2pmV0DWT5qIE8aPePo7wRhFCDlxxY267QVvF+Pp6sdl3yPBfMYNlkAWJSR0
         7uikFPSmia0TNkyi8EJiRPYz1cieCRwBK4TWY7ovgl+RWxTEVzPng9W6R1vXPAU1pnrd
         lcYtvNdTX0XkbNEqoHTgqx01vxROGtqIs1rnb21xK7vKpyIwOf5KjomowillRHVxWNKf
         7OmN9s8z9snD64rTZtF9QH8xOqOcHvPd6g14sMbHjxXAmsNpBMoiKi56VbLAHaVinIk+
         Qw+BQhY/Qi8x1d1GZE71VIJv1rrU+h/wkbTEcf5hIUy7i+BLwrxrmSWcOEwc8YwFwpRA
         pcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NmJMKAmy/TavxqAqA2RWtnDhN8WsDQ/AjcqxUwK9McE=;
        b=aBalofSzaCkJP8p5dAeKylc+cAqlvmhwHEBf4Dcdsi3n3OWgcBPwV55DsycVoA2VsR
         MDMmYKP/CZWE74GovwcQQJPUa4kqa9mvpCD0i1P0XcQFqC1XLe7fxYnljSiFrv5Rau5+
         HNuQKaaWEo1U7D0XLdeQKJ60gV+flJX/3EG811Zwv5aTygTPJMs+he77eZNhJpxkx+hg
         BuvMKdo2c/Ww/oY+UZ594/NHrZG16R1vTJ4LFnFkJGEEHs/uswml9fjEH9vTSIjMZwZ/
         uTjX3OS6t8a81c4yoGmHP8xgSZgp75uVdiTejRX/EMG78IbfoBE9dDVLjGFSVauLgLsV
         oRdg==
X-Gm-Message-State: APjAAAX5BiTq3SXG342mRyanR1vMkJXf9vlU3CH6OZEzNBVXdo0lTaX1
        KbRFBRq2kUr2pvn9yYdouA==
X-Google-Smtp-Source: APXvYqwIBhqj3xEj906hIz41l7SUxMgaGNrb2ffi9JBnFMhMVCnscc2wc5NstMGVv0MjeSmJUAeEAQ==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr4653988pls.245.1572442416598;
        Wed, 30 Oct 2019 06:33:36 -0700 (PDT)
Received: from mypc ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f189sm3869906pgc.94.2019.10.30.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 06:33:35 -0700 (PDT)
Date:   Wed, 30 Oct 2019 21:33:27 +0800
From:   Pingfan Liu <kernelfans@gmail.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] xfs/log: protect xc_cil in xlog_cil_push()
Message-ID: <20191030133327.GA29340@mypc>
References: <1572416980-25274-1-git-send-email-kernelfans@gmail.com>
 <20191030125316.GC46856@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030125316.GC46856@bfoster>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 30, 2019 at 08:53:16AM -0400, Brian Foster wrote:
> On Wed, Oct 30, 2019 at 02:29:40PM +0800, Pingfan Liu wrote:
> > xlog_cil_push() is the reader and writer of xc_cil, and should be protected
> > against xlog_cil_insert_items().
> > 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > To: linux-xfs@vger.kernel.org
> > Cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/xfs/xfs_log_cil.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
> > index ef652abd..004af09 100644
> > --- a/fs/xfs/xfs_log_cil.c
> > +++ b/fs/xfs/xfs_log_cil.c
> > @@ -723,6 +723,7 @@ xlog_cil_push(
> >  	 */
> >  	lv = NULL;
> >  	num_iovecs = 0;
> > +	spin_lock(&cil->xc_cil_lock);
> >  	while (!list_empty(&cil->xc_cil)) {
> >  		struct xfs_log_item	*item;
> >  
> > @@ -737,6 +738,7 @@ xlog_cil_push(
> >  		item->li_lv = NULL;
> >  		num_iovecs += lv->lv_niovecs;
> >  	}
> > +	spin_unlock(&cil->xc_cil_lock);
> 
> The majority of this function executes under exclusive ->xc_ctx_lock.
> xlog_cil_insert_items() runs with the ->xc_ctx_lock taken in read mode.
> The ->xc_cil_lock spinlock is used in the latter case to protect the
> list under concurrent transaction commits.
> 
I think the logic of xc_ctx_lock should be at a higher level of file
system. But on the fundamental level, reader and writer should be
protected against each other. And there is no protection for the list
ops here.

BTW, even spinlock is not enough to protect integrity of a trans, and I
think another patch should be involved. I will send the extra patch,
which is applied on this one.

Thanks for your kindly review.

Regards,
	Pingfan
