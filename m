Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C9E6A8C4C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 23:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjCBW4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 17:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjCBW4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:56:32 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA2C559D3
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 14:56:29 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id h8so848120plf.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677797788;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qXTwXNN5BPBJ/NZ3OYbXwmxOPd3hLZf5+C8HCX49djg=;
        b=cPNPEoDiS/HfsiIItPLGT3E2KS7Pa2nDCzgKjzoBCNTmF5ovdMVml+ppsm005Cz2gc
         pMD41ueS/rsqWBDjk0Ang+swrwWISO9NpTVI+XcAlfsXxlunEfDcOqSyRkjHfJ2N7W3M
         nXhJv2G01aF56hxwfL9a8N8s/N1YUs1FWh6Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797788;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXTwXNN5BPBJ/NZ3OYbXwmxOPd3hLZf5+C8HCX49djg=;
        b=SVxpL45RZw4FDx5F+cWzExn3N7eITeN1t+QZ3t052jx6wotQ0+v4Whk5Si4yHGU9yn
         PxE74MH9ngbX5VEIsjcUkhOl20XNRltb/YIrDlbZT8ZrLtMuUREC7I7pkspsTxTUk+oY
         gLMYC4S6aB8z8Q69fuNzJTRt4WEDxAmas2WK624N+pKQdOeYcTKJKwOI6xlKCj5vgCyP
         +4G8rBBVsJsDBSCAAi9627hLLmmNFKB51nFCAYrbNrCVzX3eTY2qD51ax/7YcM+Ph2QF
         3Wa1tYWApSh2tpq8DZp8ArYpS7wR/xSi7ocbwLSwqULkd6KmohYlAS/w8TS8VheHPbFO
         LQfw==
X-Gm-Message-State: AO0yUKVkX/WCjG/MIdEJQkogef1EJLJ3ovKsWvpVZ52QIA2Jyx2jSNa2
        XvPG9AjTzkYQBruVlUltLrv+pA==
X-Google-Smtp-Source: AK7set+MdZhHyeith+B94HrQd6WpkfpBD5XCV21gXOzsSKhUw+dB78RFefTe7N6XbvDbdrdQDA//KA==
X-Received: by 2002:a17:902:ec88:b0:19a:e762:a1af with SMTP id x8-20020a170902ec8800b0019ae762a1afmr3404427plg.33.1677797788585;
        Thu, 02 Mar 2023 14:56:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b00198d7b52eefsm168326plh.257.2023.03.02.14.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:56:28 -0800 (PST)
Message-ID: <6401299c.170a0220.3a2e.0b8a@mx.google.com>
X-Google-Original-Message-ID: <202303021456.@keescook>
Date:   Thu, 2 Mar 2023 14:56:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org,
        j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] seccomp: simplify sysctls with
 register_sysctl_init()
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302202826.776286-8-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:28:22PM -0800, Luis Chamberlain wrote:
> register_sysctl_paths() is only needed if you have childs (directories)
> with entries. Just use register_sysctl_init() as it also does the
> kmemleak check for you.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
