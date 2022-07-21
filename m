Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE1957D39A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Jul 2022 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiGUSvV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Jul 2022 14:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiGUSvU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:51:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CF92ED5A
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 11:51:18 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id w29so1948346qtv.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Jul 2022 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ABlARo1q4W8MWl8fMSyyIWAkJhcwdZqRLERUMRVV8y0=;
        b=a3Dipqi7DP4aUkldrHp93ne1O6cTrWtFJpNvlTOIVlXo01XvWSk4dz1tX3rtPQH3F2
         jAZAdCSavV3Sqgbsz0881u6GS2ltM95tIgUSEsp0f4tJQdjSNgtsu7Jm0vYtk0N2CT3v
         Aif0YgWwWfuK44GRHXwEJRP03Ftyu1B4VkWa6AXBbpGhQcxyIz58MrwLQXzV7/YOGDWD
         JA9n9g/1CRGRGhplF8rk7GYAdQ3ph3PTTW9VPSa4A+IG/q+1eI6r6yd63bvqVxvRoThu
         CFd4/soAUrj26JEa+N7OTRsMBMcMiPKeKZJ6e4cI5qyemzqeYxtA9kaepAZ6wNVIN7X3
         sMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ABlARo1q4W8MWl8fMSyyIWAkJhcwdZqRLERUMRVV8y0=;
        b=wJWDzBxSVQxUjL2UpVW9l4JKGRucMAXzNv5RNxw27ol69IreG4FIAV04fy6gbs9iQM
         NktJ1Itt3NHqv37bEBHQpUsD6hIEcNCbRl8ffDuxcZvM56LAe2P5LpeYnyvWeOK/Sizq
         K9u9puxQZKLDp6cnAP4V6/8vK64wUR69zNsJpj5PwCXPWI4VbxorHYaRx4OV67N++Kop
         pHG7YqLzBv14zsttKc2oKSHMVeyfsbGfpytJ6mGl5xUOQBIdS1N8U0vf4NjyRHds9Lk0
         M5K4bEx4L1jGTlj5Vpi7z4hj82fUZE2yjh3TNXPm3z2dtC3V7JBBbhumdKV3dAmY9WOS
         KvYw==
X-Gm-Message-State: AJIora9rTFJnVI5NfqLfPdSHDOMX+k4EBn32ja4EeXJkArteYsPIRCGS
        Jd9IiDXemUXn/pxEbkpcnJHxCg==
X-Google-Smtp-Source: AGRyM1tSQawsbfCG3JVFskJrFAyZkEyE7wpSkmlKeLjG/ZzroPfTxIM/UKxdVXtcFB6JavtqQFxOGg==
X-Received: by 2002:ac8:5a12:0:b0:31e:f233:50f1 with SMTP id n18-20020ac85a12000000b0031ef23350f1mr15963077qta.229.1658429477857;
        Thu, 21 Jul 2022 11:51:17 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id q5-20020a05620a038500b006b5e833d996sm1745532qkm.22.2022.07.21.11.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 11:51:17 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1oEbGW-00022g-2R; Thu, 21 Jul 2022 15:51:16 -0300
Date:   Thu, 21 Jul 2022 15:51:16 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        akpm@linux-foundation.org, jhubbard@nvidia.com,
        william.kucharski@oracle.com, jack@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, ruansy.fnst@fujitsu.com, hch@infradead.org
Subject: Re: [PATCH] mm: fix missing wake-up event for FSDAX pages
Message-ID: <20220721185116.GC6833@ziepe.ca>
References: <20220704074054.32310-1-songmuchun@bytedance.com>
 <YsLDGEiVSHN3Xx/g@casper.infradead.org>
 <YsLHUxNjXLOumaIy@FVFYT0MHHV2J.usts.net>
 <62ccded5298d8_293ff129437@dwillia2-xfh.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ccded5298d8_293ff129437@dwillia2-xfh.notmuch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 11, 2022 at 07:39:17PM -0700, Dan Williams wrote:
> Muchun Song wrote:
> > On Mon, Jul 04, 2022 at 11:38:16AM +0100, Matthew Wilcox wrote:
> > > On Mon, Jul 04, 2022 at 03:40:54PM +0800, Muchun Song wrote:
> > > > FSDAX page refcounts are 1-based, rather than 0-based: if refcount is
> > > > 1, then the page is freed.  The FSDAX pages can be pinned through GUP,
> > > > then they will be unpinned via unpin_user_page() using a folio variant
> > > > to put the page, however, folio variants did not consider this special
> > > > case, the result will be to miss a wakeup event (like the user of
> > > > __fuse_dax_break_layouts()).
> > > 
> > > Argh, no.  The 1-based refcounts are a blight on the entire kernel.
> > > They need to go away, not be pushed into folios as well.  I think
> > 
> > I would be happy if this could go away.
> 
> Continue to agree that this blight needs to end.
> 
> One of the pre-requisites to getting back to normal accounting of FSDAX
> page pin counts was to first drop the usage of get_dev_pagemap() in the
> GUP path:
> 
> https://lore.kernel.org/linux-mm/161604048257.1463742.1374527716381197629.stgit@dwillia2-desk3.amr.corp.intel.com/
> 
> That work stalled on notifying mappers of surprise removal events of FSDAX pfns.

We already talked about this - once we have proper refcounting the
above is protected naturally by the proper refcounting. The reason it
is there is only because the refcount goes to 1 and the page is
re-used so the natural protection in GUP doesn't work.

We don't need surprise removal events to fix this, we need the FS side
to hold a reference when it puts the pages into the PTEs..

> So, once I dig out from a bit of CXL backlog and review that effort the
> next step that I see will be convert the FSDAX path to take typical
> references vmf_insert() time. Unless I am missing a shorter path to get
> this fixed up?

Yeah, just do this. IIRC Christoph already did all the infrastructure now,
just take the correct references and remove the special cases that
turn off the new infrastructure for fsdax.

When I looked at it a long while ago it seemd to require some
understanding of the fsdax code and exactly what the lifecycle model
was supposed to be there.

Jason
