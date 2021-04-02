Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DA03530A6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 23:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBVRT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 17:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhDBVRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 17:17:18 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C09C0613E6;
        Fri,  2 Apr 2021 14:17:17 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id u8so4471279qtq.12;
        Fri, 02 Apr 2021 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9s2mmzkVUItIXMHJVPtfePsIFMwda03/XFVlOMThKYc=;
        b=DrgbVjvmplwOHIYPBriH0typURCu7r+4nJVsaxQ86BW30Hzdrf8i62s5vqMuwi3Jfh
         Gn0GnbaHu+K7vMspslNpV2fHBIUcsXuYu5am8OWIOmYYPGBl9OzsBMaNR3RZk1cyJsMO
         wTRuu9SzkYZChNrF39gom/KUt+WxMFfbgucKe7ZIS9dIzUK1p+9p93w95EknKEqafnLT
         EldN0qil5Dtu78aPDPFv4gwYUXkwi6n1w7R2+s7A70TYC1pTIMiaKb1rxHYdjgHIh9pS
         UXgEvRtK9srKRjQcfnWbDencOZb7nIoNFepyc/z5B/RUvJzflApPfXLI0a8eg2YxsF3u
         bxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9s2mmzkVUItIXMHJVPtfePsIFMwda03/XFVlOMThKYc=;
        b=VxkjMrMQDWXcXJqboSq2NUJMXKXXW+gbPVu3089yZYQoYyXCi/gdmOYk9gVuqjTT0e
         HQjImS4n3N6NjNhVc/ysIaUvfeIGp+sJWWBcY/yz6zAckIhX7PkQKjWhCTIiwag0PXks
         1MjCRKJi4w7bGZ5Mq0qTPzyq2M9kADRoPINB1i0Os9w+ErkHiaR04lzuPlTHRHEwNXnM
         PGaBLkyEcaB15k4L4O1EbWOtxIdPh4jLjpANv9umLacljW9kmkysZwrLBY7ShFwyT49s
         0wAs+J1Xs5CSz282YhqZeozMoIFKFMu1DiPf3icoDAzmBxk27FvmV+2uv1njm8BBw6Ma
         YXZQ==
X-Gm-Message-State: AOAM533+cTsr5xlJGjmyLANYROVPOLjmWWTYlhEqhDnYgpkQIe+WDzxL
        KmeEUE1vwzCutrpQDoXdTg==
X-Google-Smtp-Source: ABdhPJwQMQYx+M/cmt2QhHgkac6Czlz981nasiiNR9+r9my59xjQpBb/nWlLV1ZG+CJEt+S//JHAig==
X-Received: by 2002:ac8:745a:: with SMTP id h26mr13138255qtr.79.1617398236606;
        Fri, 02 Apr 2021 14:17:16 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id j26sm7448698qtp.30.2021.04.02.14.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 14:17:16 -0700 (PDT)
Date:   Fri, 2 Apr 2021 17:17:10 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: Provide address_space operation for filling
 pages for read
Message-ID: <YGeJ1hBP3lEMOSA2@moria.home.lan>
References: <20210120160611.26853-1-jack@suse.cz>
 <20210120160611.26853-3-jack@suse.cz>
 <20210120162001.GB3790454@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120162001.GB3790454@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 04:20:01PM +0000, Christoph Hellwig wrote:
> On Wed, Jan 20, 2021 at 05:06:10PM +0100, Jan Kara wrote:
> > Provide an address_space operation for filling pages needed for read
> > into page cache. Filesystems can use this operation to seriealize
> > page cache filling with e.g. hole punching properly.
> 
> Besides the impending rewrite of the area - having another indirection
> here is just horrible for performance.  If we want locking in this area
> it should be in core code and common for multiple file systems.

Agreed.

But, instead of using a rwsemaphore, why not just make it a lock with two shared
states that are exclusive with each other? One state for things that add pages
to the page cache, the other state for things that want to prevent that. That
way, DIO can use it too...

(this is what bcachefs does)
