Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94D049D9D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 06:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbiA0FLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 00:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiA0FLh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:11:37 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2038CC06161C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 21:11:37 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id a8so1634602pfa.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 21:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VCZReluAQz03PjKIcLsn7Ofw32SpNnxULP0yGB9FXj4=;
        b=l8QPVBNha478nRZx7KWxLRe65XQSi0a9Z4lg1ujV9NFPutAxzJwVuu+d/2lLT3J9pD
         57RNFjNLj7cgn3iuVqSY2WTaxop/Np7hpXD0yTH1dlP9q04w9p+4cWHVQDj2K2/zn9GB
         79prvx2gOVx62Bd5CG1bB5IT15Nw2Mmtm9diI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VCZReluAQz03PjKIcLsn7Ofw32SpNnxULP0yGB9FXj4=;
        b=i3pUBUdr3EnwZTXxlTUSX9BVG3pQgrK/wWf3jZqy+W6SfYqRnRMKoyFWtekytfgF7q
         mtKuA5u23TegbEIjc8m5A74H+Wlhdky3LMQq+StwaiPPbDqLYZUXCzvZpsjh8iPJSn+A
         4T4OZeeRNBFgp2DFO7VcmagE6B34FImzAa11GXlZbLdSbx5698ek/Ua9WzBSIPZdNMIQ
         tetx62pg4CgVZVkB+bSY5nFO+dlHq/0aQ8TH3dLMO2LMKJq+MQ4v0kFWzNSSeYm90KJg
         kdMoTcHeQKpZ7yjpR7watIxapaXGgjGFgn45zI1h+G8ZvKXoH/qKZfuY4iiImH0TOUs5
         u6tQ==
X-Gm-Message-State: AOAM533RH/tKYVGsrM/by+43TKsnL+YAHSyIhCBBncjlzxIDFxPzC6xx
        yMw+0rxheHfQ2fHmxj0eTWCQfg==
X-Google-Smtp-Source: ABdhPJy+5R8QdwKwEBzG9FNRh8E/Dyt2EPExenO1WHJZSde39cI7EoDprQsjiDqNkffkw7k0lmhCSA==
X-Received: by 2002:a62:8853:: with SMTP id l80mr1663796pfd.26.1643260296622;
        Wed, 26 Jan 2022 21:11:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mh1sm934134pjb.29.2022.01.26.21.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 21:11:36 -0800 (PST)
Date:   Wed, 26 Jan 2022 21:11:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Akira Kawata <akirakawata1@gmail.com>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        lukas.bulwahn@gmail.com, Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fs/binfmt_elf: Refactor load_elf_binary function
Message-ID: <202201262106.E0BADCEE4@keescook>
References: <20211212232414.1402199-1-akirakawata1@gmail.com>
 <20211212232414.1402199-3-akirakawata1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211212232414.1402199-3-akirakawata1@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 13, 2021 at 08:24:12AM +0900, Akira Kawata wrote:
> I delete load_addr because it is not used anymore. And I rename
> load_addr_set to first_pt_load because it is used only to capture the
> first iteration of the loop.
> 
> Signed-off-by: Akira Kawata <akirakawata1@gmail.com>

Thanks for splitting this out. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
