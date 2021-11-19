Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8B145676E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Nov 2021 02:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhKSBYa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 20:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhKSBYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 20:24:30 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65C7C061574;
        Thu, 18 Nov 2021 17:21:28 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 200so7155945pga.1;
        Thu, 18 Nov 2021 17:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2tqyKsYyBJPy8juVSwDxf6dA198i0oRskzgoD5wXhVA=;
        b=gh7FKTdHnIkH40vcOiXEHQSc40+CbmMLGxXHQL1TM99/KotE6UZ7BAevMuqQe9cOnq
         cPQSgKuj2YhRiUbKHPjZKr37BHXeuorXGXaGNi78kEAqgVnH8xHAYEKxEzmK8fL0j0a/
         eNhEh63l+dMtwaCFTD8+TGOOoXfCDQMNd83QtWZTHtgCy1iAFwLx1XgWpbdvKOgQtJQw
         VtniABkAE6EOPsZus685AGQMhsmlalV7xv2edoJ01ZDmh7YRy9b9MG23K6PakVhfdPsT
         K78iT8u3Tvm7PwKA7NGujUyPgfinvEaq04qXzFs0u11UtCk5jvkFBZxBzASTRvKr/v11
         C80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2tqyKsYyBJPy8juVSwDxf6dA198i0oRskzgoD5wXhVA=;
        b=n0/lTBcgPcQ1gaou/3zdeEdxeq4MLFfzjuhExL6j9T8VxYHBd5YYen2TpbRyHnoHA9
         flBdRUN4/ljsoycMSvopsC8KIcaoDh/sY5SIEP+1oZgFnGyZEMYPcHoHChCb2pSZu6eG
         0JQjF2I1GQ6ySXLFWntNaI0Us4/lF6PFQXn2rGeurE1/yGCGEP54G2xOPkQvAgZtQj4h
         US6ycq7BkU4rmG7/K737BanEsB4Zm83+e7YDeaa2wPdmhpgNMBjY6HAvZDWTtjj69RvW
         khZqaJJktTcIvFpOPHs86tPd1hTX39aclV1+corWTxb2kJnu3P0kOhpzDf4wSQppEP5J
         zcXQ==
X-Gm-Message-State: AOAM533JYBPtfBUQShf6lKubes6waMZgtUCWXskSCM/TnrgXSqhSGJ3Z
        iAOm6HwWg68AJ2gf+ki2A58=
X-Google-Smtp-Source: ABdhPJwJFPs73QBS6Z9LcgPajEZ8yhsB/CqsdXRVwU3900TXljo/1EJcdB6WG1/SfZUkU+Ji+PWrHA==
X-Received: by 2002:a63:7882:: with SMTP id t124mr14673903pgc.149.1637284888100;
        Thu, 18 Nov 2021 17:21:28 -0800 (PST)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x33sm805475pfh.133.2021.11.18.17.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 17:21:27 -0800 (PST)
Date:   Fri, 19 Nov 2021 09:21:18 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Steve French <smfrench@gmail.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>, CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [regression] mm, cifs panic
Message-ID: <20211119012118.qh3awizpkuimlhrj@xzhoux.usersys.redhat.com>
References: <20211118042914.wnffm3ytzmxjdubn@xzhoux.usersys.redhat.com>
 <CAH2r5mtW35HzmNDNxPXj1cKiEsyaz45_mcsQmWkTa_orOkS7ug@mail.gmail.com>
 <20211118133215.4b8168a062693b32442eb928@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118133215.4b8168a062693b32442eb928@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 01:32:15PM -0800, Andrew Morton wrote:
> On Thu, 18 Nov 2021 10:18:16 -0600 Steve French <smfrench@gmail.com> wrote:
> 
> > Andrew Morton had posted Matthew Wilcox's patch (to fix the recent
> > regression in mm/swap.c) in email (on the 9th) to fs-devel titled:
> > 
> >        "+ hitting-bug_on-trap-in-read_pages-mm-optimise-put_pages_list.patch"
> > 
> > The patch was reviewed and verified (tested) to fix the problem but
> > has not been merged into mainline.  Various xfstests break without
> > this patch.
> 
> It's in my next batch of fixes to send to Linus.  Hopefully tomorrow.

Great! Thanks!

-- 
Murphy
