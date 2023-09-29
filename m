Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9316A7B358D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 16:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbjI2Oda (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 10:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjI2Occ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74CDCF2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695997894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LN68gjvhRE/uK/tgsTkr2JfCXFJPDxl3anui1W37eq8=;
        b=NbstEghd7y7Z2Vl1OBkQ31YfRB3TWoNw/N74sy2sxm0APkz22p3Ota7CkmDHs7RyTVvz32
        KnmnAjHicpItMlmwfQlTkRKpNZmZBxzEMwe+B+v6ZxvxIR28IsphMYNDyg62uuEmGb1P61
        CCJM/SS7Tk9/9zL6BSkJDaquhHy2C64=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-gNO5p6oIOFK7tnqQ1Y7wDA-1; Fri, 29 Sep 2023 10:31:32 -0400
X-MC-Unique: gNO5p6oIOFK7tnqQ1Y7wDA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-65b13c48253so146198096d6.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 07:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997891; x=1696602691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LN68gjvhRE/uK/tgsTkr2JfCXFJPDxl3anui1W37eq8=;
        b=GTuyX+1DtsTmzLcEiOBjNmbpwnHy1XWpqd9AuVP5pFYZlxcVniB2OOCTTupf/NEufm
         Q/X9X2jooFr2iBP5CMy7d3mOvPcigOhKcjwIK9YVv6hZfEtC22FNYXafnhd8G0FOq6ye
         3Yz35Lo/swH13XUM0v1b51ndwJLgoWvp0TZMyVX2BB0qHzpDIYiPhGwa7BQ3gTw7g8sB
         HfLkTGbicMRMqgUUQ6h1+eZJEgbGi8tjf21Tpf3HFmIzHYmKPpNRtlV0a9/lD0NmEMc0
         BzamIoBDucW9m5c4/zlY3rBvqUyqmy+O+V7/XdMDlgPd6lqtr4Ttk7LTU78/KIDyF5rN
         JPtg==
X-Gm-Message-State: AOJu0Yzf0jGd55es7KMv6wsMLN1ouuS13cr5pZA3V4CCKsjI2ZKGCwxd
        VLJEu6PBxIb044teiS6nUjznsJ4m3qhDK7C7jsFy0zZm000oblGZ+vJ+g4gJRxZsItMGmemfyJi
        o572eEbczR6Lni5srMS1IsyyC1g==
X-Received: by 2002:a0c:df08:0:b0:658:4008:e2ba with SMTP id g8-20020a0cdf08000000b006584008e2bamr3684860qvl.63.1695997891676;
        Fri, 29 Sep 2023 07:31:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhbR/p9Yho9drcc2rwTlcFxOqf5amo+pifftu9tuTeK3v/6QZlgkoOAXPqcIFcVhZMaljK4g==
X-Received: by 2002:a0c:df08:0:b0:658:4008:e2ba with SMTP id g8-20020a0cdf08000000b006584008e2bamr3684846qvl.63.1695997891373;
        Fri, 29 Sep 2023 07:31:31 -0700 (PDT)
Received: from bfoster (c-24-60-61-41.hsd1.ma.comcast.net. [24.60.61.41])
        by smtp.gmail.com with ESMTPSA id p6-20020a0ce186000000b00656373f9c30sm1451665qvl.75.2023.09.29.07.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:31:30 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:31:46 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@lst.de, djwong@kernel.org
Subject: Re: [PATCH 2/2] bcachefs: remove writeback bio size limit
Message-ID: <ZRbf0gMtS6vkGDmN@bfoster>
References: <20230927112338.262207-1-bfoster@redhat.com>
 <20230927112338.262207-3-bfoster@redhat.com>
 <20230927220326.jcu4d4khpfjsn6qd@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927220326.jcu4d4khpfjsn6qd@moria.home.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 27, 2023 at 06:03:26PM -0400, Kent Overstreet wrote:
> On Wed, Sep 27, 2023 at 07:23:38AM -0400, Brian Foster wrote:
> > The bcachefs folio writeback code includes a bio full check as well
> > as a fixed size check when it determines whether to submit the
> > current write op or continue to add to the current bio. The current
> > code submits prematurely when the current folio fits exactly in the
> > remaining space allowed in the current bio, which typically results
> > in an extent merge that would have otherwise been unnecessary. This
> > can be observed with a buffered write sized exactly to the current
> > maximum value (1MB) and with key_merging_disabled=1. The latter
> > prevents the merge from the second write such that a subsequent
> > check of the extent list shows a 1020k extent followed by a
> > contiguous 4k extent.
> > 
> > It's not totally clear why the fixed write size check exists.
> > bio_full() already checks that the bio can accommodate the current
> > dirty range being processed, so the only other concern is write
> > latency. Even then, a 1MB cap seems rather small. For reference,
> > iomap includes a folio batch size (of 4k) to mitigate latency
> > associated with writeback completion folio processing, but that
> > restricts writeback bios to somewhere in the range of 16MB-256MB
> > depending on folio size (i.e. considering 4k to 64k pages). Unless
> > there is some known reason for it, remove the size limit and rely on
> > bio_full() to cap the size of the bio.
> 
> We definitely need some sort of a cap; otherwise, there's nothing
> preventing us from building up gigabyte+ bios (multipage bvecs, large
> folios), and we don't want that.
> 

Yeah, I forgot about the multipage bvecs case when I was first reading
through this code.

> This probably needs to be a sysctl - better would be a hint provided by
> the filesystem based on the performance characteristics of the
> device(s), but the writeback code doesn't know which device we're
> writing to so that'll be tricky to plumb.
> 

Agree, but IIUC it looks like there's more work to do (related to the
write bounce code) before we can change this limit. I've got a v2 of
this patch, which I'll post shortly, that retains the limit, fixes up
the logic wart that originally brought attention to this code, and adds
some comments. Thanks for the additional context.

Brian

> iomap has IOEND_BATCH_SIZE, which is another hard coded limit; perhaps
> iomap could use the new sysctl as well.
> 
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/bcachefs/fs-io-buffered.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/fs/bcachefs/fs-io-buffered.c b/fs/bcachefs/fs-io-buffered.c
> > index 58ccc7b91ac7..d438b93a3a30 100644
> > --- a/fs/bcachefs/fs-io-buffered.c
> > +++ b/fs/bcachefs/fs-io-buffered.c
> > @@ -607,8 +607,6 @@ static int __bch2_writepage(struct folio *folio,
> >  		if (w->io &&
> >  		    (w->io->op.res.nr_replicas != nr_replicas_this_write ||
> >  		     bio_full(&w->io->op.wbio.bio, sectors << 9) ||
> > -		     w->io->op.wbio.bio.bi_iter.bi_size + (sectors << 9) >=
> > -		     (BIO_MAX_VECS * PAGE_SIZE) ||
> >  		     bio_end_sector(&w->io->op.wbio.bio) != sector))
> >  			bch2_writepage_do_io(w);
> >  
> > -- 
> > 2.41.0
> > 
> 

