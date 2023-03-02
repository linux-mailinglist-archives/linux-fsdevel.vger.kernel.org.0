Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C406E6A8C57
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 23:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCBW5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 17:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCBW5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 17:57:02 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3100558484
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Mar 2023 14:56:53 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l1so709615pjt.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Mar 2023 14:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677797812;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bh8uEZAD/yvWP1Lrn9R+0QNZba+XTTUTVdSRMgAQcmQ=;
        b=K//SvYScc9/RPlNzAc+bbNZPJfdelma3q9O4bB1wnxAJ4F3+DrxFkHfD9CzyFhzWbQ
         zxzjRce8GzbRVhw5ROu1iovSYFPgJkpXdsVV9KLRuZ+DLM3i6IU1sNlajSgCAnvliBm1
         V57qqveobMxUQT7AgmZQGrEwmKkrWRVbgNjpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797812;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bh8uEZAD/yvWP1Lrn9R+0QNZba+XTTUTVdSRMgAQcmQ=;
        b=7aML80rhIotAaahvu3E3d/5g7b77nYFDcjhP2cdx3UPtNqNHN3a+zC9NaTggOfDMCg
         5kksF7O2ompSU77G55oBRn96Q61CKHzOW14kqTthxJqoLNKyg6dseaLyDhdnX8a2GWOc
         vdwd46sNf8G6kjpY3ZjcUhG1c79bA3H1VyRIETu6zGTQYKJliMwBv5HE8LxY9VxzpWQq
         ED32XRzNikqz5rRhiSvUmKVLbEN2Qj7DfP2o+LoxOoqEwL1rhe9kHf96C01bnARS99kU
         wFzkMU/TGKdbR4B1E5bbHSidyufQuhk/OsqxsNdGhyBjsuUBmhLPCafZ2WDxO7s+zBZC
         trhg==
X-Gm-Message-State: AO0yUKX4zgAu7fpYU6gXlGAcrNWXCjmRCIPwYhN5GwN9mRBOmwa2jR99
        S4vk/qMizj8yLWsh8ajGThqWDA==
X-Google-Smtp-Source: AK7set8NQA8CZRtcwSlTz7C5GCelOHtAp1Ylxj2HvVTT0A4/xUpLXx5v+dscM8DAlm1E4D6F1Zi9ew==
X-Received: by 2002:a17:902:d2c9:b0:19e:3b41:1828 with SMTP id n9-20020a170902d2c900b0019e3b411828mr4267544plc.22.1677797812569;
        Thu, 02 Mar 2023 14:56:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id kx7-20020a170902f94700b001990028c0c9sm192659plb.68.2023.03.02.14.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:56:52 -0800 (PST)
Message-ID: <640129b4.170a0220.e5ce3.0f65@mx.google.com>
X-Google-Original-Message-ID: <202303021456.@keescook>
Date:   Thu, 2 Mar 2023 14:56:51 -0800
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
Subject: Re: [PATCH 06/11] yama: simplfy sysctls with register_sysctl()
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302202826.776286-7-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 12:28:21PM -0800, Luis Chamberlain wrote:
> register_sysctl_paths() is only need if you have directories with
> entries, simplify this by using register_sysctl().
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
