Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E732645E187
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 21:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350954AbhKYU36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 15:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbhKYU14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 15:27:56 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9429C061763;
        Thu, 25 Nov 2021 12:21:28 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id l22so18910265lfg.7;
        Thu, 25 Nov 2021 12:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mnoEOb8Hv954j3i4irIBD7t76uu0fsOSVAr2WZwq1j0=;
        b=pRWmT9Ia87UdxCoz9ngZywa5cyo1TrHHSDhzi/kxAH03obgBufvviWVuWnNvrgamk7
         otTIj5HnTwkGfW5wfpVFFlVSzyrihfOmwk8KHFDX0Z2C+gDI7A8ZwBvBWibGMdeJKY/7
         gHBOK5N9+ceIhs+pp+6jJGkJDcCeUdZZPUsHJk9cdIRwuHBe9/RHlwpsDr+bCeQbfq6E
         JhySC1Ms7V5LkxsiootlkMa7W5tZabwArWAvY5hCtsRVfyzC0zqSBvlo825npiJeONc2
         JIopjq2LqZA9FWio6fPspxXNCIc7yyLK8yn4nxoOEqfXIrgOIEtHx2bSZfsYVu2TwQ0P
         0cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mnoEOb8Hv954j3i4irIBD7t76uu0fsOSVAr2WZwq1j0=;
        b=WvSD8j4+fk7H9TM/N/MRF7vt7G6wOD1hAjmZEMWB176SnVifQsQSy/Xi9F6BjcxY+/
         1gt1nPN116MfXtdoUbYwkbxYes19EyPgt2u3XObgtFmk+8WEvEN60pwmHpHzt0sKLX9s
         H7UmYilrOUSq+ee/mDijmf9VFnudHdJGXGebqKpdr563KXNK3hpq5hf3iwHtIwsZc+2v
         kysuvvUD1aIefkdhBgYDqSLIenaFq/59q2giQpmZq3WQqv971k2z26fHA2GHnzIb8hOj
         VTXv0aC3mHSj0BWHARsx3YkIngLwvrqv3V06C0E/xFYM9MC348FdBM93JrUYxT6luIG0
         bMYA==
X-Gm-Message-State: AOAM530DEGFtqgHSWOSHapq1EPDl7hgkZsxNtNktTtYKzfXb0U66N3eV
        /87UtHL/hyqkcxkG5YhXSMY=
X-Google-Smtp-Source: ABdhPJzv6tVHfjPCNBYsQmVAMCejhhFupK/eFYJ+PY32Yv0mLT+rVrWUAqrkeiZTN0ZKjY9QGhH8qg==
X-Received: by 2002:a05:6512:31c4:: with SMTP id j4mr26213026lfe.173.1637871687025;
        Thu, 25 Nov 2021 12:21:27 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id m20sm339742lfu.241.2021.11.25.12.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 12:21:25 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 25 Nov 2021 21:21:23 +0100
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YZ/wQ+EuGzpxA0DO@pc638.lan>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
 <YZ06nna7RirAI+vJ@pc638.lan>
 <20211123170238.f0f780ddb800f1316397f97c@linux-foundation.org>
 <YZ6cfoQah8Wo1eSZ@pc638.lan>
 <YZ9Nb2XA/OGWL1zz@dhcp22.suse.cz>
 <CA+KHdyUFjqdhkZdTH=4k=ZQdKWs8MauN1NjXXwDH6J=YDuFOPA@mail.gmail.com>
 <YZ/i1Dww6rUTyIdD@dhcp22.suse.cz>
 <YZ/sC/N+fHUREjo0@pc638.lan>
 <YZ/uUR1SGuMbEtzm@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ/uUR1SGuMbEtzm@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Thu 25-11-21 21:03:23, Uladzislau Rezki wrote:
> > On Thu, Nov 25, 2021 at 08:24:04PM +0100, Michal Hocko wrote:
> > > On Thu 25-11-21 19:02:09, Uladzislau Rezki wrote:
> > > [...]
> > > > Therefore i root for simplification and OOM related concerns :) But
> > > > maybe there will be other opinions.
> > > 
> > > I have to say that I disagree with your view. I am not sure we have
> > > other precedence where an allocator would throw away the primary
> > > allocation just because a metadata allocation failure.
> > > 
> > Well, i tried to do some code review and raised some concerns and
> > proposals.
> 
> I do appreciate your review! No question about that.
> 
> I was just surprised by your reaction that your review feedback had been
> ignored because I do not think this is the case.
> 
> We were in a disagreement and that is just fine. It is quite normal to
> disagree. The question is whether that disagreement is fundamental and
> poses a roadblock for merging. I definitely do not want and mean to push
> anything by force. My previous understanding was that your concerns are
> mostly about aesthetics rather than blocking further progress.
>
It is not up to me to block you from further progress and of course it
was not my intention. You asked for a review i did it, that is it :)

--
Vlad Rezki
