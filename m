Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5443A6A35B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 00:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBZXvF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 18:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBZXvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:51:04 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB41631C
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 15:51:01 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id z2so4969884plf.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Feb 2023 15:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZRz1s/KRyO2Uxle7inVvqWM+4+Zegth9BIYrB8VHgJo=;
        b=Mk9tRRfW308oYU3sLQ9yDdi2b3JL5istzYA1UAT00A3pKm3FAvG/xGqJ5/miW1RysM
         /CqsMcjdybw8Bo9iiRVpNU4Umt6d5Gt9dh5zmiVrlCp7366v3Ujk/vxERazGT2EObXDs
         E2ROzMGJwFWIVc/swERCL/ssQ2fhO90sCYWSVt1gUFeIUCyhCIHM4BDpaJn9PMlH+CTW
         Upx+Na8pZmYuq4FwymuNcI8m2JTDaJmk4E8oui+2O4xDj3fWiLc1QFoWfPpoYniyuSoI
         qsEGgGD9WGutpkTiQ3JcoO3/2xVfqOozEew6jMBI54emEqIMDlChsH8cQpY7QSG4Os5Z
         lG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRz1s/KRyO2Uxle7inVvqWM+4+Zegth9BIYrB8VHgJo=;
        b=AuHTfn1AQXxE5TkLKsLcy/8pczVsAhYj8quwc0d/05lpq+4VaXsOwMX+eGRbHNertB
         lCTowcHyhpuCdr2fqXpGH7Fyvy0TgUBAERqqwZHhq8coaVBZv0Vr/4JDooquxpbfEC0U
         cGzqkKNqNaFvPcTqjOfZJultH96Wcf5LHslp8GW7NCMOYgcYLZqd/ObtfIIkye6Fy3si
         ZqyjpHwuhyV8kFMXmRINYXj2K6hBxcUVleSjKcn6oaM61T0naeWyWi4zXU9v56iu6IoV
         NHeIkzTzbAg37NVM0Ztg5/M3Kr7x/OfRnOennH8VJiM481UheC5e0Vuhbe2/5nrYAbyH
         SL+w==
X-Gm-Message-State: AO0yUKW4ZPqHNlVKXmcdaz1hzilogKwdSSfeuzGkqV00d391z/3qxpsy
        qmqVUv7bKTzvb99pt39sTdUpDQ==
X-Google-Smtp-Source: AK7set9nFy4/f6XcyXZVPqFl639UstSp++qbIKME5kqRCmc5ElckiPp+IUv8d1xCQl78ZiAXr5MTlg==
X-Received: by 2002:a17:902:eccc:b0:19c:387c:bd65 with SMTP id a12-20020a170902eccc00b0019c387cbd65mr28220861plh.10.1677455460789;
        Sun, 26 Feb 2023 15:51:00 -0800 (PST)
Received: from dread.disaster.area (pa49-186-4-237.pa.vic.optusnet.com.au. [49.186.4.237])
        by smtp.gmail.com with ESMTPSA id d13-20020a170902aa8d00b00198d7b52eefsm3129186plr.257.2023.02.26.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 15:51:00 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pWQnB-002WaD-LN; Mon, 27 Feb 2023 10:50:57 +1100
Date:   Mon, 27 Feb 2023 10:50:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        djwong@kernel.org, dan.j.williams@intel.com, hch@infradead.org,
        jane.chu@oracle.com, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v10 2/3] fs: introduce super_drop_pagecache()
Message-ID: <20230226235057.GY360264@dread.disaster.area>
References: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1676645312-13-3-git-send-email-ruansy.fnst@fujitsu.com>
 <20230220212506.GS360264@dread.disaster.area>
 <b872f2e8-c451-697b-e9cf-63c5bae52a8a@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b872f2e8-c451-697b-e9cf-63c5bae52a8a@fujitsu.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 21, 2023 at 09:57:52AM +0800, Shiyang Ruan wrote:
> 
> 
> 在 2023/2/21 5:25, Dave Chinner 写道:
> > On Fri, Feb 17, 2023 at 02:48:31PM +0000, Shiyang Ruan wrote:
> > > xfs_notify_failure.c requires a method to invalidate all dax mappings.
> > > drop_pagecache_sb() can do this but it is a static function and only
> > > build with CONFIG_SYSCTL.  Now, move its implementation into super.c and
> > > call it super_drop_pagecache().  Use its second argument as invalidator
> > > so that we can choose which invalidate method to use.
> > > 
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > 
> > I got no repsonse last time, so I'll just post a link to the
> > concerns I stated about this:
> > 
> > https://lore.kernel.org/linux-xfs/20230205215000.GT360264@dread.disaster.area/
> 
> Please see patch 3.  I changed the code: freeze the fs, then drop its
> caches.

Neither the patch nor the cover letter have a changelog in them
that mention you changed anything. Please, at least, keep a change
log in the cover letter so that people know what has changed from
version to version without having to look at every patch and line of
code again.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
