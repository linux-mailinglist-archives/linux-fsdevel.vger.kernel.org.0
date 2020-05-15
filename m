Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A751D47C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgEOIJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbgEOIJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 04:09:34 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768FFC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:09:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x77so628332pfc.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1vyc3N6Wpm82JIZilzNLGJALVVKWdLUl/sk+JrP3SQY=;
        b=WfQKqFbsR7j0aT0EBVSN2m33HEItYHviYT/e/Oyrp6O+5EmrwjqvbC5f+YgJHhS/Ml
         5HZLGNLbbHysm+MGzdihZhtYNWYX/2aurTMWuP6AqSQFXitKJTySL+XS5PZt21DhvH1K
         AkCIkBjKMNiC6QdGXn+Qi0B43psoWAOmYK2ZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vyc3N6Wpm82JIZilzNLGJALVVKWdLUl/sk+JrP3SQY=;
        b=T+d4lrBTCV004BgsutzHwNGvLxUHyVVzTYukJy3Dx2UzfOLuNfaiEnGMSAeDcsalCr
         QsVc2dVrtbsg1ZZmIBuFPg6d31kymjmayX8otkVaK6yWEDNF8/RRUPhHgxKXWo9V4tvM
         UhWNjIXP46krzFRlYzv1WxkRqMZsLWt5LQ146LMhpiD6W5S3XEMbkBf1vffh+aa78pqq
         Huxt/EPfOcNjfjPWphXlVcHY5luUPBo2wgiIm9O6FLx0g8rU6KS/vFkstH7zHMYojmum
         oESSAgct/VZKRRlk8NqHT8kZL4J8gbSvAdWpyulg4a91Mp+3EjC9vj+viIugSBSFYVXh
         4XVQ==
X-Gm-Message-State: AOAM53370ysFldkY3UF2JeF8mXxdWrW7nFWBcNydBiVNkLKuJ0YBYxEH
        mimfCXDaFLi8w3JCRZVZcbJvnA==
X-Google-Smtp-Source: ABdhPJzj1TkiQ319JdD4TFwt6e2PerHI09OJDhtWGz+jcdRwTxCJRsyCrrUnlx6JTEkb6ZP+l0+hDw==
X-Received: by 2002:a62:ae13:: with SMTP id q19mr2697929pff.310.1589530171972;
        Fri, 15 May 2020 01:09:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y14sm1222453pff.205.2020.05.15.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:09:30 -0700 (PDT)
Date:   Fri, 15 May 2020 01:09:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 3/4] watchdog: move watchdog sysctl to watchdog.c
Message-ID: <202005150107.DA3ABE3@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-4-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589517224-123928-4-git-send-email-nixiaoming@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 12:33:43PM +0800, Xiaoming Ni wrote:
> +static int sixty = 60;

This should be const. (Which will require a cast during extra2
assignment.)

-- 
Kees Cook
