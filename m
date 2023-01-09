Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8207B662BF0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbjAIRAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237273AbjAIQ7k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:59:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D5310FFE
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 08:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673283536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y7DKy4vOeCO8Sem/CefZNHXeGVX6UXQGeGnokxcES9k=;
        b=LXBpbRjkyKwxpXMd2t9G1kcg0OsTxILHsnwcY63R7dtgkXJq9BRBQalwqFIh47+HOnmMO9
        yAH9I2glKeUXEm321SWGnu5ESdJB4EOY/OhhdGmWyZOz+rT1Gb6qPlTuVJx3DvvL/mVLHU
        LWZl7Uc87KeMmkFtPKOJv56Hqy6RbLY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-301-__o2UNRMNweeYZPK4bQBfw-1; Mon, 09 Jan 2023 11:58:55 -0500
X-MC-Unique: __o2UNRMNweeYZPK4bQBfw-1
Received: by mail-ed1-f71.google.com with SMTP id z20-20020a05640240d400b0047028edd264so5744760edb.20
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Jan 2023 08:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7DKy4vOeCO8Sem/CefZNHXeGVX6UXQGeGnokxcES9k=;
        b=N/xSI223igkT+EuQsk3HByRDXqoK+WfWV8Ma8bhk8MH3NQXncVP5Cfdb1107p2v3xX
         VAG79RzrG9WatzkME6XxcUfx51U7ouTyD/jnmTGxDXAhTYZYjg2clXHLggxVG6tx/3Ee
         jzCZieqj8gE82OljIQBf75Hs6kOiF6fG38MDe/vSQDuNViJt9vydrELuDJ714pSfL+MH
         OT0T1Ve/QgUwQhZAqGl86LcWGq0ycxp3iJBL5RQ6E7wTms0PN14Ko7V++CEMKHrYEmpy
         5lwzTui8cr2Tq2WxpTbeGZnU0DqiHMntrSnr8IWb+eYm9EGuka43VRaQ40BiYR9xg+sT
         zm7A==
X-Gm-Message-State: AFqh2kose0e2/AI/SnKRqUUGob9HIc6qgytR8daQvb9UuoxcQtw4FikW
        dbe20XS1szX4FlohxEp+4ygzEs0fsSYzeUE8cTYRLgxhO5PzB2Fj0XJX4HdXdk1Ag9QMFONS94r
        /8ivWKz26oMSmmB78s9wxJ1U5
X-Received: by 2002:a17:907:a4c3:b0:84d:150d:5006 with SMTP id vq3-20020a170907a4c300b0084d150d5006mr13353604ejc.49.1673283534308;
        Mon, 09 Jan 2023 08:58:54 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuOeAlXgZiVxDJIkM4CJlSFeuYh+a6mL+BWtu2R4kRZIgQk863QLnt66+pciqQgu8HF5AhFtw==
X-Received: by 2002:a17:907:a4c3:b0:84d:150d:5006 with SMTP id vq3-20020a170907a4c300b0084d150d5006mr13353595ejc.49.1673283534157;
        Mon, 09 Jan 2023 08:58:54 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b0077a8fa8ba55sm3928923ejf.210.2023.01.09.08.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 08:58:53 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:58:52 +0100
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 09/11] iomap: fs-verity verification on page read
Message-ID: <20230109165852.cndsmzlkqevdgc46@aalbersh.remote.csb>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-10-aalbersh@redhat.com>
 <Y5jMYxgFARhStFrb@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jMYxgFARhStFrb@sol.localdomain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:02:59AM -0800, Eric Biggers wrote:
> On Tue, Dec 13, 2022 at 06:29:33PM +0100, Andrey Albershteyn wrote:
> > Add fs-verity page verification in read IO path. The verification
> > itself is offloaded into workqueue (provided by fs-verity).
> > 
> > The work_struct items are allocated from bioset side by side with
> > bio being processed.
> > 
> > As inodes with fs-verity doesn't use large folios we check only
> > first page of the folio for errors (set by fs-verity if verification
> > failed).
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 80 +++++++++++++++++++++++++++++++++++++++---
> >  include/linux/iomap.h  |  5 +++
> >  2 files changed, 81 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 91ee0b308e13d..b7abc2f806cfc 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/bio.h>
> >  #include <linux/sched/signal.h>
> >  #include <linux/migrate.h>
> > +#include <linux/fsverity.h>
> >  #include "trace.h"
> >  
> >  #include "../internal.h"
> > @@ -42,6 +43,7 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
> >  }
> >  
> >  static struct bio_set iomap_ioend_bioset;
> > +static struct bio_set iomap_readend_bioset;
> >  
> >  static struct iomap_page *
> >  iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
> > @@ -189,9 +191,39 @@ static void iomap_read_end_io(struct bio *bio)
> >  	int error = blk_status_to_errno(bio->bi_status);
> >  	struct folio_iter fi;
> >  
> > -	bio_for_each_folio_all(fi, bio)
> > +	bio_for_each_folio_all(fi, bio) {
> > +		/*
> > +		 * As fs-verity doesn't work with multi-page folios, verity
> > +		 * inodes have large folios disabled (only single page folios
> > +		 * are used)
> > +		 */
> > +		if (!error)
> > +			error = PageError(folio_page(fi.folio, 0));
> > +
> >  		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
> > +	}
> 
> fs/verity/ no longer uses PG_error to report errors.  See upstream commit
> 98dc08bae678 ("fsverity: stop using PG_error to track error status").

Thanks! Missed that.

> 
> - Eric
> 

-- 
- Andrey

