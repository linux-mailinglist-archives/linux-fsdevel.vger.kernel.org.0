Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1515D7511C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjGLUTi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGLUTi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:19:38 -0400
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA551FEE
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 13:19:37 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689193175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LRjkX1alqufdFp+5oDuqNAJ4YZpsTFqeehXA3ckgvjk=;
        b=HjAc5YxXPVPo/BB4dkzyLewEHGl8569ijrwJHsDTxvX7raSf8T/h83wknlmtGhl++GNQ8C
        eSV+Ow9rU+z9O75Ci1C3vEoHnfEVDHKfsrBhi1aK5z8DyVwAHr8JTPqSKwiIkNDzd8q89M
        gd2moP+hsPJmt+BoG8ewxWF3xzgiEFY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 29/32] lib/string_helpers: string_get_size() now returns
 characters wrote
Message-ID: <20230712201931.kuksw5zmuwah7tqs@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-30-kent.overstreet@linux.dev>
 <202307121248.36919B223@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202307121248.36919B223@keescook>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:58:54PM -0700, Kees Cook wrote:
> On Tue, May 09, 2023 at 12:56:54PM -0400, Kent Overstreet wrote:
> > From: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> > printbuf now needs to know the number of characters that would have been
> > written if the buffer was too small, like snprintf(); this changes
> > string_get_size() to return the the return value of snprintf().
> 
> Unfortunately, snprintf doesn't return characters written, it return
> what it TRIED to write, and can cause a lot of problems[1]. This patch
> would be fine with me if the snprintf was also replaced by scnprintf,
> which will return the actual string length copied (or 0) *not* including
> the trailing %NUL.

...All of which would be solved if we were converting code away from raw
char * buffers to a proper string building type.

Which I tried to address when I tried to push printbufs upstream, but
that turned into a giant exercise in frustration in dealing with
maintainers.
