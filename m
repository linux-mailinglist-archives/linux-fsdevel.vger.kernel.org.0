Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0982678B7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 09:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgILH4Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgILH4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 03:56:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782DAC061573
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2020 00:56:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d16so1986375pll.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Sep 2020 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hkQEv8N2/w/dmNjYwzWRoPRR2BMD1Mf3MgOBCOD6/rw=;
        b=Q9kfaBgCkng9JivxtuhaKvmzjWwgFuCsu9/UAxcUobUAoj/9SPC7EtdbYOSRjTOJSc
         Fnr1MUOI8CX0s6DIV8FgquI2A4SjmZo40Wi1doqaY36HoTm2EikFQnPgjDOY0VzHymxD
         ZiEKD4FD9hAvoUJOm1e9BDVFp4AD63ZWGdalU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hkQEv8N2/w/dmNjYwzWRoPRR2BMD1Mf3MgOBCOD6/rw=;
        b=RyuQHiEoyTXNVobQWpJ0T6Clumi8YHwQ1EMjNPlyAzMU2FTKy9zTCVpysy3UqxUX0r
         dIVcfuxuOWwU7fSPqRVcw5BkGr99uejB6rKXIm2LUrK5rPubsl5i3LN4FdiDVV5dVX0X
         ChB4jpsNEAxl9GlMGm7glq1gFLXnX2CUH4kal/GX+j7JnR9WsAimDun7HOF7Jhfcj+dK
         /tYvGJCVySKIdBXknm7b1H2aKGCLBunzHVYV2MsXxtQD+kWPy7LK9qjPYG+u+LnltV6Y
         5GRL2Xu1W96wlz3aMboP3aQPCJ7uHX4QVRjMk6uhViArABj0TrIs71c3LX3IwkQxOcwv
         AUjQ==
X-Gm-Message-State: AOAM53061queZ9RjW+sye43KYhmgAfuE5Pu7xDTmidasSt0Ywk63PfoY
        oKUo07a5B3HXs9jeOei9e3+6aQ==
X-Google-Smtp-Source: ABdhPJwQevL1YXacLJDW8V7rFiaRpiL0yftWZ/h48xy/1yQZi0+Jij9pWA3ZgVkjnFKvtTVUwsjfUQ==
X-Received: by 2002:a17:902:8c91:b029:d1:9be4:7fe6 with SMTP id t17-20020a1709028c91b02900d19be47fe6mr5905601plo.33.1599897380079;
        Sat, 12 Sep 2020 00:56:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm4369191pfq.82.2020.09.12.00.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 00:56:19 -0700 (PDT)
Date:   Sat, 12 Sep 2020 00:56:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Morris <jmorris@namei.org>
Cc:     kernel-hardening@lists.openwall.com, John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation
 (fbfam)
Message-ID: <202009120055.F6BF704620@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
 <alpine.LRH.2.21.2009121002100.17638@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2009121002100.17638@namei.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 12, 2020 at 10:03:23AM +1000, James Morris wrote:
> On Thu, 10 Sep 2020, Kees Cook wrote:
> 
> > [kees: re-sending this series on behalf of John Wood <john.wood@gmx.com>
> >  also visible at https://github.com/johwood/linux fbfam]
> > 
> > From: John Wood <john.wood@gmx.com>
> 
> Why are you resending this? The author of the code needs to be able to 
> send and receive emails directly as part of development and maintenance.

I wanted to flush it from my "review" TODO list, mainly.

-- 
Kees Cook
