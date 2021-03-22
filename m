Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075EE344C25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhCVQrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 12:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhCVQq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:46:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E541AC061574;
        Mon, 22 Mar 2021 09:46:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id w8so8783865pjf.4;
        Mon, 22 Mar 2021 09:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kbxl2EyvYQ+iEiBcY8QE8ei5vvB+dVWj1V2/xyWw0TE=;
        b=vE1h4GIKLa2cwkoNekpc4wTiTM8egP5qas0EmsOfTsG5h27ncb1QxZga0l31AlsSTt
         YNEOM42+qHVSLO4n5W1fojznc+DjYhSmoOUeRw1CGhBRL4nhZczRzhvQXUeWoULl3Xff
         StqX9j9fuqOSDwCOcICI0nD+u0QIgRKSDHVHp/S8Mb448prsly7ecY0zs0+wtXMZwGUa
         P17eSiE+K1RFVZnFnZKjQi6x9hLMu0brG4NcTqFbhNKJNXETBXzLtGyk/e9EZK25a731
         CAaF2ZD64GIKW/8orz8BIaBJTJSuxD4dOi6nWufjwoAPDvo+AqSYX8HD1/PzG9VsSB6H
         GL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kbxl2EyvYQ+iEiBcY8QE8ei5vvB+dVWj1V2/xyWw0TE=;
        b=BmAPlA3J3vr542/mo85MB2ZUjj1LC/BlWULZXNHzbC9XjsGw6v4qHZVqZyQ78zrkRM
         TzIlXS7Yb1R7riJmuKDW6yQTKEwbW+xktLP8xPptf++vxYLfMYU/XUOxu5Gu8vrNGaFJ
         eEZt63vrpGy3BKbWbGN/Y91+BicfLYUH8FENfSN5xZe491OJDIM1z0tvDgoZdEHaXlmX
         jghqIU+aThbqzFZVaIPhZXZoywD0Qb31HtoL7RgwECAp5bWCSGxghXsXinNxsahBFep0
         TTxk7H7H8rOcxuqpWB58xQ4tnq9zLdwfps3YlTNSlVhDXEQf2OVHvBaZNdZmyFzlNdSQ
         WwPA==
X-Gm-Message-State: AOAM533ySiBnl3fCew95esLOpqDKvMQFqJEfNs89pL08M8MmNKNiNRX8
        PLDzVDOMl+xX9NjFmmOEbwU=
X-Google-Smtp-Source: ABdhPJwbk6V2o84od6hlmEJbFwKiLBCPqnL7u6PR+tGEMrq4u+vAROD/AIzO5JdsjNRdKQbAZu1zcg==
X-Received: by 2002:a17:90a:17c3:: with SMTP id q61mr7810pja.58.1616431616507;
        Mon, 22 Mar 2021 09:46:56 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6568:690d:7590:b7b5])
        by smtp.gmail.com with ESMTPSA id h68sm4088095pfe.111.2021.03.22.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 09:46:55 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 22 Mar 2021 09:46:53 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Chris Goldsworthy <cgoldswo@codeaurora.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, joaodias@google.com,
        surenb@google.com, mhocko@suse.com, david@redhat.com,
        vbabka@suse.cz, linux-fsdevel@vger.kernel.org,
        oliver.sang@intel.com
Subject: Re: [PATCH v4 3/3] mm: fs: Invalidate BH LRU during page migration
Message-ID: <YFjJ/fpe8acRxeN5@google.com>
References: <20210319175127.886124-1-minchan@kernel.org>
 <20210319175127.886124-3-minchan@kernel.org>
 <20210320093249.2df740cd139449312211c452@linux-foundation.org>
 <YFYuyS51hpE2gp+f@google.com>
 <20210320195439.GE3420@casper.infradead.org>
 <8a01ba3dc10be8fa9d2cb52687f3f26b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a01ba3dc10be8fa9d2cb52687f3f26b@codeaurora.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 03:51:40PM -0700, Chris Goldsworthy wrote:
> On 2021-03-20 12:54, Matthew Wilcox wrote:
> > On Sat, Mar 20, 2021 at 10:20:09AM -0700, Minchan Kim wrote:
> > > > > Tested-by: Oliver Sang <oliver.sang@intel.com>
> > > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > Signed-off-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
> > > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > >
> > > > The signoff chain ordering might mean that Chris was the primary author, but
> > > > there is no From:him.  Please clarify?
> > > 
> > > He tried first version but was diffrent implementation since I
> > > changed a lot. That's why I added his SoB even though current
> > > implementaion is much different. So, maybe I am primary author?
> 
> Hey Minchan, let's have you as the primary author.
> 
> > Maybe Chris is Reported-by: ?  And don't forget Laura Abbott as original
> > author of the patch Chris submitted.  I think she should be Reported-by:
> > as well, since there is no code from either of them in this version of
> > the patch.
> 
> Yes, let's have a Reported-by: from Laura. We can change my Signed-off-by to
> Reported-by: as well.

Thanks Matthew and Chris.

I just wanted to give more credit(something like Co-authored-by if we have
such kinds of tag) to Chris since I felt he had more than. :)

Okay, let's have something like this.

From: Minchan Kim <minchan@kernel.org>

..

Tested-by: Oliver Sang <oliver.sang@intel.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: Laura Abbott <lauraa@codeaurora.org>
Reported-by: Chris Goldsworthy <cgoldswo@codeaurora.org>
Signed-off-by: Minchan Kim <minchan@kernel.org>

Andrew, if you want me resend the patch, let me know.

Thank you.
