Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B7040ED0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240646AbhIPWEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 18:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240317AbhIPWEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 18:04:43 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AD3C061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 15:03:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j16so7277947pfc.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Sep 2021 15:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4stWjV+988moSr8o995OIf8ggHEv0wfGWBUivSMtLdE=;
        b=P4NV3mSxnseSsUwN1r4NRyp6pr/mGZacESSUAMJ4OA+ZSrKJezFJJLBTBqIGE5zj29
         fGLa8Iljpr3nqHZTQFQp8l5bvDwsrhpN+vnIpX//X5XzvsLhDyiRXqjCRtt+6PGG5T2A
         2/1o6jaBirRCA+eTm6GobnrXmpuh83bdlbabE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4stWjV+988moSr8o995OIf8ggHEv0wfGWBUivSMtLdE=;
        b=7jeb86VvIkgfxolYn0NDYsANlCi8CPMStoyeN4ZDoxnMNwuykEDQrn8/cIJYTVhi9J
         9mE4GtLDynUuc067i0uQASvVxBMfGCiVBzgn+NLPfWyF0Mdu4xfnBqd1YL51m/PugkNL
         VXHw0txNU3CVSnNvW0VuggAvAHTqULCqybCB+Xz3Gwy9fnQsBYr2XGrD7yw+bGpCXgYG
         il0bSHXqodsaM/7GzLdhDEP20ANN7HfNGzpqm7zSd0kPiZQDrq11p1O7Z8eEj4xTVJKK
         Xo38s+wd/3Z6hJaHZ5PEVsmVtQJGJhTcR5pffjilFdBEVrs8zmex8oKGMQUTc7x7Utvs
         yXHA==
X-Gm-Message-State: AOAM531fK1VPnAp8N9Fm7dNYWU0fLCrmb2PHMGSiJMqLbpL/G8Oufdrl
        Fbh5IiLYi9D8glmiWo+fqfGO+Q==
X-Google-Smtp-Source: ABdhPJzByTUQfNUTQXxfAdKQO1SbJaWR9nrJXL7Z5u9uxynbmpO0acSoreFm30VnzwHjGd5cvjNgCw==
X-Received: by 2002:a63:5c1b:: with SMTP id q27mr6786249pgb.284.1631829801905;
        Thu, 16 Sep 2021 15:03:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11sm4184633pff.144.2021.09.16.15.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:03:21 -0700 (PDT)
Date:   Thu, 16 Sep 2021 15:03:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Huth <thuth@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, linux-s390@vger.kernel.org,
        Jia He <hejianet@gmail.com>,
        Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] sysctl: introduce new proc handler proc_dobool
Message-ID: <202109161502.7B79ED57F@keescook>
References: <20210803105937.52052-1-thuth@redhat.com>
 <20210803105937.52052-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803105937.52052-2-thuth@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 03, 2021 at 12:59:36PM +0200, Thomas Huth wrote:
> From: Jia He <hejianet@gmail.com>
> 
> This is to let bool variable could be correctly displayed in
> big/little endian sysctl procfs. sizeof(bool) is arch dependent,
> proc_dobool should work in all arches.
> 
> Suggested-by: Pan Xinhui <xinhui@linux.vnet.ibm.com>
> Signed-off-by: Jia He <hejianet@gmail.com>

Hi! I apologize for the delay. Yes, this looks good to me; thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
