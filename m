Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD67520BAEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbgFZVFO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 17:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFZVFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:05:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A490C03E979
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 14:05:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a14so576298pfi.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2020 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wZoxiP0mTeiu9+lN0In23h0uJGDaqzSh/2yHrJcG0vY=;
        b=W6zzf4n1FJ+jbypcb/n75nQ9f/qgNuv1aMFledULOSq+3p7GtFYtHvD+jWVHob7zij
         Oi0GziKAhh9/2WERpXPcNsYysb41CMLrjmgII0ZRcxG0QjymJwmMX5cvNVzyBh/DJ/D+
         XVZxAvq0ePQdTnXIAJqa7f4ekDTEqtW3W52cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wZoxiP0mTeiu9+lN0In23h0uJGDaqzSh/2yHrJcG0vY=;
        b=TXx3RaffP7exZQfb5E7003TOxwN3da9xU2rzIec2E+gIpQl8/B50zaN9AGnNvRqt44
         +FJCmt1So+lngSMKJvX4D+RZS1F9eB63QNZPw0cVq09JKjfB6KIRRX/ISbgICQl2YcIv
         IBKuN1ZcSD8din4tKfYxiJklWru2mKCzhvEe9v9CoURxSwLoRYC3dnzD7M+2E28WR6kT
         A0q5AWSdX2DBmxRITgzgePjh9im8k4c8OpoViBwtW+faR1WF5ipd8c3SGJM0GpTj8Yr2
         JTl+uhDV89ENFJO813ngLSF3z13wZgUcXkPRMyfAjKEkHZAxO2Z3tENpMXJwyztTYPxc
         Bw4Q==
X-Gm-Message-State: AOAM532nu8xU8yvpb36wacfbfz5/R2Hn80SSlcOdWzAfrRGVWat1ZS7a
        tkNm2KgQSbTViHw2118mspsy0g==
X-Google-Smtp-Source: ABdhPJy3s8sc/ERwXoxJsr+XLKL9bz5tQ5UtuzDRNXOvRBhYMKE4oIsAIGdPPetiSVb8MYDyRT/BAg==
X-Received: by 2002:aa7:8681:: with SMTP id d1mr4531191pfo.230.1593205513960;
        Fri, 26 Jun 2020 14:05:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm11572394pgk.93.2020.06.26.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:05:13 -0700 (PDT)
Date:   Fri, 26 Jun 2020 14:05:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 8/9] fs: don't allow kernel reads and writes without iter
 ops
Message-ID: <202006261403.3E1397040F@keescook>
References: <20200626075836.1998185-1-hch@lst.de>
 <20200626075836.1998185-9-hch@lst.de>
 <20200626135147.GB25039@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626135147.GB25039@casper.infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:51:47PM +0100, Matthew Wilcox wrote:
> On Fri, Jun 26, 2020 at 09:58:35AM +0200, Christoph Hellwig wrote:
> > +static void warn_unsupported(struct file *file, const char *op)
> > +{
> > +	char pathname[128], *path;
> > +
> > +	path = file_path(file, pathname, sizeof(pathname));
> > +	if (IS_ERR(path))
> > +		path = "(unknown)";
> > +	pr_warn_ratelimited(
> > +		"kernel %s not supported for file %s (pid: %d comm: %.20s)\n",
> > +		op, path, current->pid, current->comm);
> > +}
> > +
> 
> how about just:
> 
> 	pr_warn_ratelimited(
> 		"kernel %s not supported for file %pD4 (pid: %d comm: %.20s)\n",
> 			op, file, current->pid, current->comm);
> 
> also, is the pid really that interesting?

Yes, pid matters, especially when there may be many of something running
(e.g. rsync).

-- 
Kees Cook
