Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD54500673
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 08:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240154AbiDNG6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 02:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiDNG6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:58:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E918253B6A;
        Wed, 13 Apr 2022 23:55:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c7so5631657wrd.0;
        Wed, 13 Apr 2022 23:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i5T2WuBIH0R0XDT0hQ5tatOdI9zhR+OTM38wDNtLi/4=;
        b=quhoyem2wmG5f5Pm04RZJs9nRUI+pzpefnP4f5/zV+b5jtV7aDQczTHfGbvXJAEMEa
         NiqZub798ga5ETHr0HoNs3d3uHVDg6BPpHDX1l4QeO8bmcz66Ud+2wKZ0YaflaKTZ4no
         njPa2Xr6Zfbfm+SJWe4mQRGq/7FjfH4I9Smo8Rgt0VvkE74erI8tGli7H65tbt3dIAaQ
         3cZXVEopRXYvF9Alqk9IOWG+d1PtPitV9ALcZanOJ89H+CfqIGUa8HK5Am7TWZd2AmeO
         1wU9Ks933V3RHbugNY6zw4BAPNsJ9lbzXl55fU72Ow7lbNuWUL65CZ7N1C1qiIXxIg8R
         olxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i5T2WuBIH0R0XDT0hQ5tatOdI9zhR+OTM38wDNtLi/4=;
        b=dbmyBKdNtpEqY1yKSYHVUVYSq2CNuPT03f1GNx3H/eD+Ncth/prJmaQ4iTpTKOubHK
         zggEjT8WAaGt5QKLiCuMc5OmhYuZ0DwHLvw4IhBJmDrs4j1800QqZlvmsB1vC/1nYKJk
         p1UdV9z3hgWMGeXFLUsiEct2iiBFMIbc+54tv3ofN78rRzmc2dGEGkgd9lHyKJtwBMML
         V2HARrYPrung2BE9TJLy1BQ4xGvxY8il72qVXwdTUT0vpHry1Zv77QAmZWfjcguQRd4j
         8YxF6UFFV55W4MrqQnwnD6LU+wExjcwoSX1PM6asTACm6CJn06S2uqHj4LjHjRx8Ey3R
         Yang==
X-Gm-Message-State: AOAM532af8oZ6V2ZI/pmo2XAr4prR2Y/c/HMBiq/gPzrtWoS2b4Jk8Tu
        aMAsKvcCj566FrdaiRK6+scHZBJC3g==
X-Google-Smtp-Source: ABdhPJzbwTBljyJ1F1r3r8n0KSRXdhTI46ye3xa1CTBUHMjQbYUXO389NEcVFe0SsMx02tcGpt+OCQ==
X-Received: by 2002:a05:6000:1c8:b0:207:af9e:a4ec with SMTP id t8-20020a05600001c800b00207af9ea4ecmr915277wrx.9.1649919339489;
        Wed, 13 Apr 2022 23:55:39 -0700 (PDT)
Received: from localhost.localdomain ([46.53.249.105])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b00207b99923d0sm990376wrr.20.2022.04.13.23.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 23:55:38 -0700 (PDT)
Date:   Thu, 14 Apr 2022 09:55:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Daniel Colascione <dancol@google.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/smaps_rollup: return empty file for kthreads instead
 of ESRCH
Message-ID: <YlfFaPhNFWNP+1Z7@localhost.localdomain>
References: <20220413211357.26938-1-alex_y_xu.ref@yahoo.ca>
 <20220413211357.26938-1-alex_y_xu@yahoo.ca>
 <20220413142748.a5796e31e567a6205c850ae7@linux-foundation.org>
 <1649886492.rqei1nn3vm.none@localhost>
 <20220413160613.385269bf45a9ebb2f7223ca8@linux-foundation.org>
 <YleToQbgeRalHTwO@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YleToQbgeRalHTwO@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 14, 2022 at 04:23:13AM +0100, Matthew Wilcox wrote:
> On Wed, Apr 13, 2022 at 04:06:13PM -0700, Andrew Morton wrote:
> > On Wed, 13 Apr 2022 18:25:53 -0400 "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca> wrote:
> > > > 258f669e7e88 was 4 years ago, so I guess a -stable backport isn't
> > > > really needed.
> > > 
> > > Current behavior (4.19+):
> [...]
> > > Pre-4.19 and post-patch behavior:
> > 
> > I don't think this will work very well.  smaps_rollup is the sort of
> > system tuning thing for which organizations will develop in-house
> > tooling which never get relesaed externally.
> > 
> > > 3. As mentioned previously, this was already the behavior between 4.14 
> > >    and 4.18 (inclusive).
> > > 
> > 
> > Yup.  Hm, tricky.  I'd prefer to leave it alone if possible.  How
> > serious a problem is this, really?  
> 
> I don't think "It's been like this for four years" is as solid an argument
> as you might like.  Certain distributions (of the coloured millinery
> variety, for example) haven't updated their kernel since then and so
> there may well be many organisations who have not been exposed to the
> current behaviour.  Even my employers distribution, while it offers a
> 5.4 based kernel, still has many customers who have not moved from the
> 4.14 kernel.  Inertia is a real thing, and restoring this older behaviour
> might well be an improvement.

Returning ESRCH is better so that programs don't waste time reading and
closing empty files and instantiating useless inodes.

Of course it is different if this patch was sent as response to a regression.
