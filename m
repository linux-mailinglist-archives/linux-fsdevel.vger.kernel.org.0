Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6C978E0FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 22:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbjH3UvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 16:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbjH3UvH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:51:07 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A684F4
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 13:50:31 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a812843f0fso29833b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1693428495; x=1694033295; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R1jYqqYryQFVoqC0CvIasISxt5p5l9C337JF0IzaaeQ=;
        b=LpsMinb33tx2djlJIVaQfk9VF/WLPhX3VY4pTWtUtXhTpu2w9122vHhAyoVgVlC7Sx
         9Wcb1HMziztEgYwB6fYKPqKt0xA0KsQPHKE0GJGqH2iS9OWkVxeu6P5cIjT/S5nwuZLA
         V0JB6TwseKx2UUSuomCMFWlBkC18MGb7vPJGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693428495; x=1694033295;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1jYqqYryQFVoqC0CvIasISxt5p5l9C337JF0IzaaeQ=;
        b=i8StCXb7fE0Bd3gRfsPW9O5WVAEMcSv7OwQ0WPfLG1a+cuqocCUdkntmU5xsejpc4s
         1neJrC5Joe7vwHPxjoRw0EItz4+xYAjc9SZ8k95yliTlaCwOV6EbIAQpY0QeIyFdRmk5
         lF1U3RBoVoAXYlC9QvAeYIWW7R1wu2qYvOEUqvcU/O38KIerXc+ENpM1AB3b37ic6CqA
         yG4zxoxpEKHIJ7TbMlcWJuudPn3jUBcIoBhLuV0XjKP9wFeXKFQ50hznyhygfwI2HCqE
         15ZKJNH/BDG47kxA5H94xs5+q3tFFsVeYjY9/6ymyGOfLPfI46szud2bcB/2P/8wD1es
         Ju4Q==
X-Gm-Message-State: AOJu0YzFP9BoJ21CP25J12faCA5elOY7BNS/NIeEEJkmyAIjY0qh5biC
        Z5BiPi2ZKU5bblPqxZrkPA4GuxMT0ygZl/wJjXg=
X-Google-Smtp-Source: AGHT+IEOQuaCPRSlM4hl/aNm6eNbq7glyuDloY1WGu09H10YoJhpVGz0OCCWbXl2tZAJMU+ICD6XIA==
X-Received: by 2002:a92:ce8a:0:b0:347:7421:9d85 with SMTP id r10-20020a92ce8a000000b0034774219d85mr3271193ilo.29.1693423602581;
        Wed, 30 Aug 2023 12:26:42 -0700 (PDT)
Received: from CMGLRV3 ([2a09:bac5:9478:4be::79:1b])
        by smtp.gmail.com with ESMTPSA id m2-20020a924a02000000b0034ac1a32fd9sm3918084ilf.44.2023.08.30.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:26:42 -0700 (PDT)
Date:   Wed, 30 Aug 2023 14:26:39 -0500
From:   Frederick Lawler <fred@cloudflare.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Daniel Dao <dqminh@cloudflare.com>, linux-fsdevel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, djwong@kernel.org
Subject: Re: Kernel NULL pointer deref and data corruptions with xfs on 6.1
Message-ID: <ZO+X75hK24e0Plgk@CMGLRV3>
References: <CA+wXwBRGab3UqbLqsr8xG=ZL2u9bgyDNNea4RGfTDjqB=J3geQ@mail.gmail.com>
 <ZMHkLA+r2K6hKsr5@casper.infradead.org>
 <CA+wXwBQur9DU7mVa961KWpL+cn1BNeZbU+oja+SKMHhEo1D0-g@mail.gmail.com>
 <ZMJizCdbm+JPZ8gp@casper.infradead.org>
 <ZM0t8rYZewA3dO0W@CMGLRV3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZM0t8rYZewA3dO0W@CMGLRV3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

On Fri, Aug 04, 2023 at 11:57:22AM -0500, Frederick Lawler wrote:
> Hi Matthew,
> 
> On Thu, Jul 27, 2023 at 01:27:56PM +0100, Matthew Wilcox wrote:
> > On Thu, Jul 27, 2023 at 11:25:33AM +0100, Daniel Dao wrote:
> > > On Thu, Jul 27, 2023 at 4:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Fri, Jul 21, 2023 at 11:49:04AM +0100, Daniel Dao wrote:
> > > > > We do not have a reproducer yet, but we now have more debugging data
> > > > > which hopefully
> > > > > should help narrow this down. Details as followed:
> > > > >
> > > > > 1. Kernel NULL pointer deferencences in __filemap_get_folio
> > > > >
> > > > > This happened on a few different hosts, with a few different repeated addresses.
> > > > > The addresses are 0000000000000036, 0000000000000076,
> > > > > 00000000000000f6. This looks
> > > > > like the xarray is corrupted and we were trying to do some work on a
> > > > > sibling entry.
> > > >
> > > > I think I have a fix for this one.  Please try the attached.
> > > 
> > > For some reason I do not see the attached patch. Can you resend it, or
> > > is it the same
> > > one as in https://bugzilla.kernel.org/show_bug.cgi?id=216646#c31 ?
> > 
> > Yes, that's the one, sorry.
> 
> I setup a kernel with this patch to deploy out. It'll take some time to
> see any results from that. I did run your multiorder.c changes with/without
> the change to lib/xarray.c and that seemed to work as intended. I didn't see
> any regressions across multiple seeds with our kernel config.
> 
> Fred

We deployed out the xarray lib fix to our fleet and didn't notice any more
issues cropping up wrt this error among other oddities. LGTM

Fred
