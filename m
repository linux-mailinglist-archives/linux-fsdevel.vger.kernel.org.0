Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E9D29CB1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2019 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfEXRGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 May 2019 13:06:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34083 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfEXRGq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 May 2019 13:06:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id h2so2330340pgg.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 May 2019 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nd2Lj9Q7aDsjzQ8w/THzJxRiwvjWHcaNNXAaDuTseEo=;
        b=g/ueHChDmzv10RhToAZSHSTBKjmteHa2+GUrTouq4WT3zsId5XyPYsDLo0VEZ2lsk8
         xxwdc+zYgqElB7Hvgr2sCKnjTYGslk7l0zl7pL6buSlo4cp3mxDXesT1bju4whIW9YTD
         Xuy4SOumA5cjyBIoyw9VlY9FgRNaGt/IqUr+XyQYlD5nDnja70C44raTby78ZUIDd1gl
         a5Sp9sBHrPzzyBHOEJQJe5yj3Kd+hIFzn2zlMyvZHtC4Byo12tj+FkG/59LC1tfn7w8G
         Pxe7hqzs2TKDKBOdg5W94Xk89woskg4bqexiagAxDpcv/zg5EhumBoaR1/Fa0bIqYdRx
         aAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nd2Lj9Q7aDsjzQ8w/THzJxRiwvjWHcaNNXAaDuTseEo=;
        b=O5YQUjBgR2ElWFB9a5Dtx1Akp3OQNsOfxDnG7OsRXYXZhBUNt/jfv9M9H3Fhpxqx8Q
         yHNOy1Uonxlu8S+wB/cyxzN7jM5tbW1KoBinQ1YHzhZKtA8wGATmXYEbO28oPsVGVo3H
         nU/mHJ10Q+1qefmlMcq7F6waXHbbKlu/H0QShSvSF2kU+PW+DOM/Priser+7kvkPz9ej
         VtvbsIXLQL0PX29tT6xu+vcDvPwqARw2szJ70PzTwzRWW9FNnVvnIsxOc3Gm8WusKCCN
         aPtauVV9j5lOS/CvSuGNcE+gyuu3Qg9zJpRCVxKpiCEZFfUryFVQj5J6ML4/AY+UTVdi
         cP3Q==
X-Gm-Message-State: APjAAAW9eKv6ur1nkfdvPrI3bjx49UPi4vjxZSimMe2L9S8jXsQr+Pfl
        1gIUfzv7xStAEPPxSHJ75InyPg==
X-Google-Smtp-Source: APXvYqyCulQRmI3PhrXkVMrT+R32nDK0uKlw4vnyyo1uY2kcnPUkhXPwQBLT45X7DGw97sr105YGzg==
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr10749010pjq.46.1558717605295;
        Fri, 24 May 2019 10:06:45 -0700 (PDT)
Received: from localhost ([2620:10d:c090:180::805])
        by smtp.gmail.com with ESMTPSA id h5sm3485126pfk.163.2019.05.24.10.06.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 10:06:44 -0700 (PDT)
Date:   Fri, 24 May 2019 13:06:42 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: xarray breaks thrashing detection and cgroup isolation
Message-ID: <20190524170642.GA20546@cmpxchg.org>
References: <20190523174349.GA10939@cmpxchg.org>
 <20190523183713.GA14517@bombadil.infradead.org>
 <CALvZod4o0sA8CM961ZCCp-Vv+i6awFY0U07oJfXFDiVfFiaZfg@mail.gmail.com>
 <20190523190032.GA7873@bombadil.infradead.org>
 <20190523192117.GA5723@cmpxchg.org>
 <20190523194130.GA4598@bombadil.infradead.org>
 <20190523195933.GA6404@cmpxchg.org>
 <20190524161146.GC1075@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524161146.GC1075@bombadil.infradead.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 24, 2019 at 09:11:46AM -0700, Matthew Wilcox wrote:
> On Thu, May 23, 2019 at 03:59:33PM -0400, Johannes Weiner wrote:
> > My point is that we cannot have random drivers' internal data
> > structures charge to and pin cgroups indefinitely just because they
> > happen to do the modprobing or otherwise interact with the driver.
> > 
> > It makes no sense in terms of performance or cgroup semantics.
> 
> But according to Roman, you already have that problem with the page
> cache.
> https://lore.kernel.org/linux-mm/20190522222254.GA5700@castle/T/
> 
> So this argument doesn't make sense to me.

You haven't addressed the rest of the argument though: why every user
of the xarray, and data structures based on it, should incur the
performance cost of charging memory to a cgroup, even when we have no
interest in tracking those allocations on behalf of a cgroup.

Which brings me to repeating the semantics argument: it doesn't make
sense to charge e.g. driver memory, which is arguably a shared system
resource, to whoever cgroup happens to do the modprobe / ioctl etc.

Anyway, this seems like a fairly serious regression, and it would make
sense to find a self-contained, backportable fix instead of something
that has subtle implications for every user of the xarray / ida code.
