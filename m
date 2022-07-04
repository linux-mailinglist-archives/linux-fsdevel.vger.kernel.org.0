Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DE5564AE3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 02:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbiGDA2J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 20:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGDA2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D5146273
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 17:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656894486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KaOqL05Ps6uhrMzHuCOajL20Q0d9A5HdIZuOghHczsA=;
        b=JIDx6Og8Gj6ddCslj/9+hSBi/N3OjNMkLVfDr5O5wVmFZSl5QMg1+CoLyOCSj5/IikGKsv
        eDJfSHDgPpnjUkvun30Ew3FLYC0xfwubmxdeD2k+euGuD90clztNmuE9GdOyHkEvHuI8Sz
        PcFjyDu8b5JLucHu/F+Ids/djoz4D60=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-QGC7METAMZmauiSUHT1D6Q-1; Sun, 03 Jul 2022 20:28:05 -0400
X-MC-Unique: QGC7METAMZmauiSUHT1D6Q-1
Received: by mail-ed1-f69.google.com with SMTP id z17-20020a05640235d100b0043762b1e1e3so6036412edc.21
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Jul 2022 17:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KaOqL05Ps6uhrMzHuCOajL20Q0d9A5HdIZuOghHczsA=;
        b=JdqIvg4bE7TelDT/BLtB0UEq48G+iR/XyYXc/ifiEsJGtbMEwqgoa5lKd4tiIfCGjs
         PXo9Kx4WBQfdilL9v3GF/Nuncya6MCHUVE8sBko4f+bv9WaTEZZ+ps5F7LXjBwO1xRN5
         fCaGrZ2EHYu6nEgkyFestttwnfng0ZoftyWBUc0bIE93Q3hnCdvsexclh4mq7QZwQ1df
         k3Otnyuta+53Psj+bKyOLI5Sxbh3NnHjTgTB3QWX4tteMnx0946wsClH1qmIl6qj3g98
         DOK8swNyqPRtqp7FJkXK38rh3Ij0sd6jtGad6FQELg/ZeENZyfPxh7vj6heSjqJtMS8r
         UjEQ==
X-Gm-Message-State: AJIora86d5Nqja2JXvose2fcCEuN7NweqTv6YISTbL4IiPUPQNyiaT9b
        m2mldfa2y1FOwh4/6Y3SNgT5INYlrI0f/t0ZMItrpS+KmHLSv3KSC7UQCtM3IxeZvod+9Hjq5SD
        TEotHBMWZ/C7gE/mU4G8hcxSzXg==
X-Received: by 2002:a17:907:9488:b0:722:e5c8:c647 with SMTP id dm8-20020a170907948800b00722e5c8c647mr25659274ejc.291.1656894484451;
        Sun, 03 Jul 2022 17:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tcUAU1lKCz9GNKy7EtOXC3/ZrGPSQpn7jqZTgAk6gvwW3u4/BpvwAo+0cmPpJ0xoClkP5dRw==
X-Received: by 2002:a17:907:9488:b0:722:e5c8:c647 with SMTP id dm8-20020a170907948800b00722e5c8c647mr25659267ejc.291.1656894484297;
        Sun, 03 Jul 2022 17:28:04 -0700 (PDT)
Received: from pollux ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id jz2-20020a170906bb0200b00726314d0655sm13524634ejb.39.2022.07.03.17.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 17:28:03 -0700 (PDT)
Date:   Mon, 4 Jul 2022 02:28:02 +0200
From:   Danilo Krummrich <dakr@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] treewide: idr: align IDR and IDA APIs
Message-ID: <YsIx4DSiaZPyMEMu@pollux>
References: <20220703181739.387584-1-dakr@redhat.com>
 <YsIAypeKXFg97xbG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsIAypeKXFg97xbG@casper.infradead.org>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 03, 2022 at 09:49:14PM +0100, Matthew Wilcox wrote:
> On Sun, Jul 03, 2022 at 08:17:38PM +0200, Danilo Krummrich wrote:
> > For allocating IDs the ID allocator (IDA) provides the following
> > functions: ida_alloc(), ida_alloc_range(), ida_alloc_min() and
> > ida_alloc_max() whereas for IDRs only idr_alloc() is available.
> > 
> > In contrast to ida_alloc(), idr_alloc() behaves like ida_alloc_range(),
> > which takes MIN and MAX arguments to define the bounds within an ID
> > should be allocated - ida_alloc() instead implicitly uses the maximal
> > bounds possible for MIN and MAX without taking those arguments.
> > 
> > In order to align the IDR and IDA APIs this patch provides
> > implementations for idr_alloc(), idr_alloc_range(), idr_alloc_min() and
> > idr_alloc_max(), which are analogue to the IDA API.
> 
> I don't really want to make any changes to the IDR API.  I want to get
> rid of the IDR API.

Forgot to mention, I noticed that there is even a new user of the IDR API in
next/master: commit d8782ec59eb8 ("mlxsw: Add an initial PGT table support")

Maybe it makes sense to point out that the IDR API is deprecated and XArray
should be used instead at the beginning of the IDR documentation file, such
that it's obvious for new potential users?

- Danilo

