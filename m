Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF64C1D47D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 10:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgEOILC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbgEOILB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 04:11:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E6FC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:11:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b8so622304pgi.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xOrE5zGn6uPvmnJr7dBeSUQ5HqdT7v+oxYQZGlXnk+k=;
        b=aQuQ7L7Kspm6klbOPbMp85wrVBOSaFLGPXT2ylm2Afy/8IpK0mPfvSEdSe0lS8gV9F
         lSbC2KcZQLcUd+RalxmvtSoHOKNH5H3GUoyNArCaRmplNtS71CZGR+49REu1kZmATNj0
         ek0PqLhGJ97mwudkzZ3IV8oV6tboH+V8sy1Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xOrE5zGn6uPvmnJr7dBeSUQ5HqdT7v+oxYQZGlXnk+k=;
        b=YNWMP/qRLFKv7uJHKBOzSbQbYov0x4V7sYQ2FURdgWC2axZhGjfkQtv6ugMWK2qfFz
         kYIP8VTgpn24WItJ4iMsySVqqqkXYutx62gIbEYnCrjt3qS8a/wlobOYBeJGW0AGFkj3
         liDPPvgqVnf7eUymCJjBXWurSb9j+mn9eqqFj1UcZ3HbQHUdiuKbd4zj2GdWWqfJdtEa
         PUQ1bln1A81jM2j0Q4I0FQhLtRP6ccNhGCEe8PxpTqSkQvW2hx909z8t9U2TvY24ks9Y
         17HrsKxsTatXf1QrEstzQ9CicPSu8i79vTX4suVxuK/0h/HOai0295FWPG5l2lJD3xhE
         ukAw==
X-Gm-Message-State: AOAM533xmuxTKM4ynINk3x50pMwaJwUG93PUz1TanmKMN45OXU1I/CS5
        wCITYjHvU8omfpUbPROg4kGGJg==
X-Google-Smtp-Source: ABdhPJyP3BeKXl/GD0/wS+1lUTuYpFPeJVCT1f8Nl02MY/sGyaBt5ioRr7b1dUWMy5lSsevjMtp1ew==
X-Received: by 2002:a63:211b:: with SMTP id h27mr2033439pgh.207.1589530261328;
        Fri, 15 May 2020 01:11:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm1262581pfk.199.2020.05.15.01.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:11:00 -0700 (PDT)
Date:   Fri, 15 May 2020 01:10:59 -0700
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
Subject: Re: [PATCH 4/4] sysctl: Add register_sysctl_init() interface
Message-ID: <202005150110.988A691@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-5-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589517224-123928-5-git-send-email-nixiaoming@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 12:33:44PM +0800, Xiaoming Ni wrote:
> In order to eliminate the duplicate code for registering the sysctl
> interface during the initialization of each feature, add the
> register_sysctl_init() interface

I think this should come before the code relocations.

-- 
Kees Cook
