Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A40C50D903
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 07:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiDYF73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 01:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDYF71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:59:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1381B38D91;
        Sun, 24 Apr 2022 22:56:25 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kk26so3101827qvb.6;
        Sun, 24 Apr 2022 22:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=yEtpP0V8bXsR3hzvKMHsezmMX2/PHsvriv0+UQGZXkA=;
        b=qn2xWHxfsL/YflUV6AWs2jqwGqY0JddqzwNB+5uzZOzncVjZYAcn5WvcPXUp1tf1x5
         JLRfjecTfxjeocC3JVUK/btbt/zYSx96hXaF6yZFILa/RgKhbdzXPLV+wvFkt3yhVOi9
         WyjRVBmRcn6CaS8PxDTgMcwPiHqZVOjqX5eGw5FbkssBdKNGhV7G7DFTyzwXBUiy4Lrq
         PpuIIvAsGPaakypH45Jo62fUl/bSWck+Lbh4P94WC6kd/dAg96vRnaofuMpx4lxL5o7l
         VHKlraViEOzc6qtAjbz/iySaIaPnkyLg6cYcIJILYoGabdeDqBvN0dIS+40Nd62zk6w9
         +e0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yEtpP0V8bXsR3hzvKMHsezmMX2/PHsvriv0+UQGZXkA=;
        b=u1mVzv3sFw6xKdL1kYKNIvjr6Wv/MAaoE7NFiH1OpZ6av4eNq7zEA8lKIcvdMgGUV4
         BSSlKCXIuDWtiDpfEoaR/C4y0pvA5irwYgCYGyUly9iNqzawD35n6xncO/2m8HCU3jlI
         972iGviaoDlfwDAv3TQ7ByjlgrOmrhF3Wvg8rZ5N+J/hdgpCeYL8ck3rLkoO0WW6W6wZ
         qccMSIrKa6l3d1+GYdDH47N+cKgwP3ijL1k44j/w2T4UXclcEL2o8ozEeHkGQ7cEU+EG
         Thunkohwdh/BlTZRKgpfQ1G1SE0Ebu4Iu1T8sHJPE5u9oquC8yAUSSsoQG9mZHqWbPs2
         looQ==
X-Gm-Message-State: AOAM531KxeZfo3wnxKQooBTkK0ykeBuPQdt6WLoPMQnVmhOhrP0QH7QO
        9UId2PMHWVApHt3JlXsJXw==
X-Google-Smtp-Source: ABdhPJzAxFXsVJ0WWB+a/uW3ENjomgA1MnU7dbP9wMly0PKxY+hDawYHFLH4F7OZHRJDaudnhEK29A==
X-Received: by 2002:ad4:5d68:0:b0:446:64dc:79db with SMTP id fn8-20020ad45d68000000b0044664dc79dbmr11197375qvb.111.1650866184049;
        Sun, 24 Apr 2022 22:56:24 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id a28-20020a05620a02fc00b0069e8e766a0csm4610371qko.94.2022.04.24.22.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:56:23 -0700 (PDT)
Date:   Mon, 25 Apr 2022 01:56:21 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220425055621.ffzp4lokgtsi72z2@moria.home.lan>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com>
 <20220421234837.3629927-7-kent.overstreet@gmail.com>
 <fcaf18ed6efaafa6ca7df79712d9d317645215f8.camel@perches.com>
 <YmYLEovwj9BqeZQA@casper.infradead.org>
 <20220425041909.hcyirjphrkhxz6hx@moria.home.lan>
 <9ab6601364a16c782ca36ab22a2c67face0785a7.camel@perches.com>
 <20220425045909.rhot6b4xrd4tv6h6@moria.home.lan>
 <2df59c0f4763b81741b12894434ceeaee35c85a2.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2df59c0f4763b81741b12894434ceeaee35c85a2.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 24, 2022 at 10:00:32PM -0700, Joe Perches wrote:
> On Mon, 2022-04-25 at 00:59 -0400, Kent Overstreet wrote:
> > On Sun, Apr 24, 2022 at 09:48:58PM -0700, Joe Perches wrote:
> > > On Mon, 2022-04-25 at 00:19 -0400, Kent Overstreet wrote:
> > > > On Mon, Apr 25, 2022 at 03:44:34AM +0100, Matthew Wilcox wrote:
> > > > > On Sun, Apr 24, 2022 at 04:46:03PM -0700, Joe Perches wrote:
> > > > > > > + * pr_human_readable_u64, pr_human_readable_s64: Print an integer with human
> > > > > > > + * readable units.
> > > > > > 
> > > > > > Why not extend vsprintf for this using something like %pH[8|16|32|64] 
> > > > > > or %pH[c|s|l|ll|uc|us|ul|ull] ?
> > > > > 
> > > > > The %pX extension we have is _cute_, but ultimately a bad idea.  It
> > > > > centralises all kinds of unrelated things in vsprintf.c, eg bdev_name()
> > > > > and clock() and ip_addr_string().
> > > > 
> > > > And it's not remotely discoverable. I didn't realize we had bdev_name()
> > > > available as a format string until just now or I would've been using it!
> > > 
> > > Documentation/core-api/printk-formats.rst
> > 
> > Who has time for docs?
> 
> The same people that have time to reimplement the already implemented?

Touché :)
