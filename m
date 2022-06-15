Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D805D54CB9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 16:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347809AbiFOOoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349608AbiFOOnk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:43:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 532AF34B97
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655304218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ny12lVrcRGJMgmvk14cyamQFLrsIM5DE6LnCKw4y2Uo=;
        b=JkNJdGW1GZ79YfTcgIf7ChL1HnnFeEny6nkoqKD8zBNXJDkFqx1osGmpwcU2VRHDOHZMwk
        qTOXg0733fL4u8nbnb/g40zbHPzTeus/xcyjBRDth79mRwMFoBwt4pZuWgOQOmWWFr9s6k
        e+JU7EEmzf+2yOuWz4nOoDb7GebYGwA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-67-H3fTgl_tOpi5DxtrImS_CA-1; Wed, 15 Jun 2022 10:43:37 -0400
X-MC-Unique: H3fTgl_tOpi5DxtrImS_CA-1
Received: by mail-qt1-f197.google.com with SMTP id c1-20020ac81101000000b002f9219952f0so8908465qtj.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 07:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ny12lVrcRGJMgmvk14cyamQFLrsIM5DE6LnCKw4y2Uo=;
        b=zfF2AUGnqvTVKTXzDcF0mTJawI8ojdLxRtNTwjDNdMcE1EBMtlb8ESST1v8tDEyjMl
         iLVTKfhoz5Hv9hOvc1wemx2J+iOnEmS+KwrY4MsIJl6pk6dIRRD4HXnSLnNRQDlkkEFe
         m0RPlVeJePQ6RoEJyluHHRBkVazhvXbtAm90oEuQOr8DJqmf7+2e9yHqWdXRokksgt2G
         AGaReJ3l9KOpnhzE9mp+KwhiM27mEMIcZUixWcfoFMBS/VIBS8GCyAELeVg7c+QiP2yM
         uh14Y83bgeJVaoG0aG00UGmnoqz7BtOEnq/su9pwVgezZEJY+ULDU4C42UPvi3CpDfxU
         rcTQ==
X-Gm-Message-State: AOAM533L+CZEwGpGoUfO1nZVdijhOha6gFH1oqgCF/tlh6/10bxxumrd
        GMoNj2RSVkTWcOk6r+buFzfnJqZnkzto0tWOY8DtA/fMklEElXPmhptbbG8bU/yvAFA38jTw3zE
        XkoAEhcbPqB7AcLSaRZB9JEm9GA==
X-Received: by 2002:a05:622a:1209:b0:305:2d22:3248 with SMTP id y9-20020a05622a120900b003052d223248mr9107169qtx.189.1655304216672;
        Wed, 15 Jun 2022 07:43:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhNsQCt+SEJ11exDiQSabdbvj1/977RxfgmSJti+ewMj3teKQ5Vv+SgDnhQeIcfkfchZl2gA==
X-Received: by 2002:a05:622a:1209:b0:305:2d22:3248 with SMTP id y9-20020a05622a120900b003052d223248mr9107135qtx.189.1655304216273;
        Wed, 15 Jun 2022 07:43:36 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a445000b006a768c699adsm12355227qkp.125.2022.06.15.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 07:43:36 -0700 (PDT)
Date:   Wed, 15 Jun 2022 10:43:33 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ikent@redhat.com, onestero@redhat.com
Subject: Re: [PATCH 1/3] radix-tree: propagate all tags in idr tree
Message-ID: <YqnwFZxmiekL5ZOC@bfoster>
References: <20220614180949.102914-1-bfoster@redhat.com>
 <20220614180949.102914-2-bfoster@redhat.com>
 <Yqm+jmkDA+um2+hd@infradead.org>
 <YqnXVMtBkS2nbx70@bfoster>
 <YqnhW2CI1kbJ3NqR@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqnhW2CI1kbJ3NqR@casper.infradead.org>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 15, 2022 at 02:40:43PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 15, 2022 at 08:57:56AM -0400, Brian Foster wrote:
> > On Wed, Jun 15, 2022 at 04:12:14AM -0700, Christoph Hellwig wrote:
> > > On Tue, Jun 14, 2022 at 02:09:47PM -0400, Brian Foster wrote:
> > > > The IDR tree has hardcoded tag propagation logic to handle the
> > > > internal IDR_FREE tag and ignore all others. Fix up the hardcoded
> > > > logic to support additional tags.
> > > > 
> > > > This is specifically to support a new internal IDR_TGID radix tree
> > > > tag used to improve search efficiency of pids with associated
> > > > PIDTYPE_TGID tasks within a pid namespace.
> > > 
> > > Wouldn't it make sense to switch over to an xarray here rather
> > > then adding new features to the radix tree?
> > > 
> > 
> > The xarray question crossed my mind when I first waded into this code
> > and realized the idr tree seems to be some sort of offshoot or custom
> > mode of the core radix tree. I eventually realized that the problem wrt
> > to normal radix tree tags in the idr variant was that the tag
> > propagation logic in the idr variant simply didn't care to handle
> > traditional tags, presumably because they were unused in that mode. So
> > this patch doesn't really add a feature to the radix-tree, it just fixes
> > up some of the grotty idr tree logic to handle both forms of tags.
> > 
> > I assume it makes sense for this to move towards xarray in general, but
> > I don't have enough context on either side to know what the sticking
> > points are. In particular, does xarray support something analogous to
> > IDR_FREE or otherwise solve whatever problem idr currently depends on it
> > for (i.e. efficient id allocation)? I think Willy has done work in this
> > area so I'm hoping he can chime in on some of that if he's put any
> > thought into the idr thing specifically..
> 
> Without going into the history of the idr/radix-tree/xarray, the
> current hope is that we'll move all users of the idr & radix tree
> over to the xarray API.  It's fundamentally the same data structure
> for all three now, just a question of the API change. 
> 
> The XArray does indeed have a way to solve the IDR_FREE problem;
> you need to declare an allocating XArray:
> https://www.kernel.org/doc/html/latest/core-api/xarray.html#allocating-xarrays
> 
> and using XA_MARK_1 and XA_MARK_2 should work the way you want them to.
> 

Interesting, thanks. I'll have to dig more into this to grok the current
state of the radix-tree interface vs. the underlying data structure. If
I follow correctly, you're saying the radix-tree api is essentially
already a translation layer to the xarray these days, and we just need
to move legacy users off the radix-tree api so we can eventually kill it
off...

Brian

