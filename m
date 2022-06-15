Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6493854CB9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 16:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349512AbiFOOoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347088AbiFOOoh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B43F35A97
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 07:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655304276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p8aqxPrbwUikaFJ7h1+NENmyUaL55DhysfxWhHj/6PQ=;
        b=EymyL3WjOdNLCR2cWfz08adgzmp6ZwtyMlQViQKXHuMrsDSAri3mZPRe1B6VQtxFz3N7qo
        Zwb6iBC8SUhGnt8q69l/7QcAaeCZI41TTXjbzBnxnM3iYVv2AHiQO8WHH3Yli3k8w9cGMO
        y1E7Hby4iRQFgWup6SB+fBzb/6NNYbo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-gPqfabNGMpKrG46FNGl5xw-1; Wed, 15 Jun 2022 10:44:34 -0400
X-MC-Unique: gPqfabNGMpKrG46FNGl5xw-1
Received: by mail-qt1-f199.google.com with SMTP id 15-20020ac8570f000000b00304e9e3b19aso8933306qtw.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 07:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p8aqxPrbwUikaFJ7h1+NENmyUaL55DhysfxWhHj/6PQ=;
        b=Ghd1gutaEr2e98XS38yzO6ZkDY/FleovguEp3RN8maW7zXXOX9ANVqWErh8U4HeKPX
         4RXfmdvi5qGOPaCEzqVrW4yhjYL6J4JZohF9j6l14+v4zVjOnAyBz6/t/yG4BfHcdjJE
         cHR4c+zXuJv+bR9FQ2EY7rXk7iBmE6qenk1da43uNBT3b8ghua1hEoq1NnEve1gkinJu
         ++YZSedSFNpLgAQ+voWFs1SIriPC/QUc4Al3Pyn8m4rg8AgKgTLnHMjBGljigbGqSURH
         Sm23483VV0zPRVRfd5p8IPDKmITc5d5zuw58jv2vxZaxJnbJfXM7tgqplKpGTJxXxq7o
         vNCw==
X-Gm-Message-State: AOAM532ATlZCY7iiWHMa3YfPSSAUBa+J9j+EIKsGdG9Sb91aUFPDpcWg
        0T6qpHqxy4+YxRcY8FYbTypicZ4sZBt7JZmC9+jduMWP9WfLxBwHdGxPzhu0j8RLmMYnjl083zF
        sMwUgG8NOyQXFstxVixIBjbrwcQ==
X-Received: by 2002:a37:614a:0:b0:6a6:af3b:e9cb with SMTP id v71-20020a37614a000000b006a6af3be9cbmr8416949qkb.744.1655304273708;
        Wed, 15 Jun 2022 07:44:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzge1omPQUkCEWKDlYeyMLUAmi8/M6QqFRpZ0n4Yr0pF8Uy9by/Z6/gkL92sGQ+BicczDrrvw==
X-Received: by 2002:a37:614a:0:b0:6a6:af3b:e9cb with SMTP id v71-20020a37614a000000b006a6af3be9cbmr8416920qkb.744.1655304273284;
        Wed, 15 Jun 2022 07:44:33 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id t37-20020a05622a182500b003051ce7812asm10124816qtc.5.2022.06.15.07.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:44:32 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:44:31 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com
Subject: Re: [PATCH 3/3] proc: use idr tgid tag hint to iterate pids in
 readdir
Message-ID: <YqnwT2SafZcVaFNO@bfoster>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-4-bfoster@redhat.com>
 <YqniOxl4ACKVp9hM@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqniOxl4ACKVp9hM@casper.infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 02:44:27PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 14, 2022 at 02:09:49PM -0400, Brian Foster wrote:
> > +++ b/include/linux/idr.h
> > @@ -185,6 +185,20 @@ static inline bool idr_is_group_lead(struct idr *idr, unsigned long id)
> >  	return radix_tree_tag_get(&idr->idr_rt, id, IDR_TGID);
> >  }
> >  
> > +/*
> > + * Find the next id with a potentially associated TGID task using the internal
> > + * tag. Task association is not guaranteed and must be checked explicitly.
> > + */
> > +static inline struct pid *find_tgid_pid(struct idr *idr, unsigned long id)
> > +{
> > +	struct pid *pid;
> > +
> > +	if (radix_tree_gang_lookup_tag(&idr->idr_rt, (void **) &pid, id, 1,
> > +				       IDR_TGID) != 1)
> > +		return NULL;
> > +	return pid;
> > +}
> 
> The IDR is a generic data structure, and shouldn't know anything about
> PIDs, TGIDs or tasks.
> 

Hm, Ok. So I suppose this interface should probably be split up a bit
more. The idr wrappers can be more generic along the lines of
idr_set_tag(), idr_is_tagged(), idr_get_next_tagged(), etc. This would
use something like an IDR_TAG1 internally (instead of IDR_TGID) to
basically expose support for a single, generic, idr-iternal (but
external radix-tree) tag for idr consumers. (Presumably this would map
directly over to xarray marks per your reply to patch 1). Then, the
find_tgid_pid() bits can be lifted into the pid code along the lines of
find_ge_pid() (along with perhaps some other simple "tgid" wrappers over
the idr tag mechanism).

If that sounds generally reasonable, I'll wait for any feedback on the
functional approach and follow up with something like that in v2..

Brian

