Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48A4161F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 17:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241862AbhIWPYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 11:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbhIWPYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:24:15 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DA7C061574;
        Thu, 23 Sep 2021 08:22:42 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q125so8660869qkd.12;
        Thu, 23 Sep 2021 08:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HVxL0gvQeVwNSk7LMfLCfUfPmAJPbw6emcr/92Y6HPk=;
        b=p+5JZA/d0QPeEFee2vyGl0teLRbu+HhGmmfCC0GugTpHLUpXa2mLytkqGART6iVOgX
         nSocO8bRUPBGxcQYeC9A2+FRcSZVyaf441Haqy9KwVnJ6j48u4Pi5zcTQbOgp2XXLWoV
         ALe6HnXjJbk0ytmMafoFSeFw6yaLzTsZLClFvK2vKW544icq1yjPSkTHEcqgqAqHSwg9
         QUUFS9Dj2NHiP4vAVCS2IIKa0Hxhnz+an7+gD49oSnxRJ67N8wltVx7jF4CjXnZi5C3k
         /V7Ut1KmhKzIq91iI/vcVTO9lM6JbCPfMXuBvDre6n4T8ROlZdPn6+PuChs38Ge2dg2b
         rbuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HVxL0gvQeVwNSk7LMfLCfUfPmAJPbw6emcr/92Y6HPk=;
        b=5O4mH8NsuwEdmqvi2GoPUGKTTK/PQBVoOlc7JVu+lPjxaqd16+994bCmtOpB0zQOJh
         ejZUYGpcYHtpL3EoRPHT94GkP6d5f3BT5+viGCc6GQgjYP6xIGsQc/hWG92m2h1WIltl
         sQZnakgDwHnxSti0MYLZa3TGQGztmIvtY2vVbGoLLVq9bl57q0T7jKf89FW9+xp3SNSp
         DAMKHH+UmJKJUZ5KNEV7E9ZJ/kve3v7IJ2/GeO06YXOToSzPDONQB8udxKSdiTX8xVgB
         n0kYlYw6/Hbxl66dIzy9bxqxwZmWU7okUCzkab5e5lyjfS1VDc04sN5Lz65D/CQk0Ggi
         7BdQ==
X-Gm-Message-State: AOAM533ZogfblmiqMsa24oofajslPip1xqqadmLmf0O8z09DPrCcBYE1
        LLTD9eXe+3zNBRzBePr/XQ==
X-Google-Smtp-Source: ABdhPJxksgW3toWKjh5yTplDAjHXG0UVdVM765dWPTWwIfBpqQcVOllpbDWkWcyt9BuLJjXr4x9dyw==
X-Received: by 2002:a05:620a:530:: with SMTP id h16mr5269737qkh.230.1632410562138;
        Thu, 23 Sep 2021 08:22:42 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id z186sm4409646qke.59.2021.09.23.08.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:22:41 -0700 (PDT)
Date:   Thu, 23 Sep 2021 11:22:35 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Struct page proposal
Message-ID: <YUybu+OCpCM2lZJu@moria.home.lan>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <e567ad16-0f2b-940b-a39b-a4d1505bfcb9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e567ad16-0f2b-940b-a39b-a4d1505bfcb9@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 11:03:44AM +0200, David Hildenbrand wrote:
> Don't get me wrong, but before there are answers to some of the very basic
> questions raised above (especially everything that lives in page->flags,
> which are not only page flags, refcount, ...) this isn't very tempting to
> spend more time on, from a reviewer perspective.

Did you miss the part of the folios discussion where we were talking about how
acrimonious it had gotten and why, and talking about (Chris Mason in particular)
writing design docs up front and how they'd been pretty successful in other
places?

We're trying something new here, and trying to give people an opportunity to
discussion what we're trying to do _before_ dumping thousands and thousands of
lines of refactoring patches on the list.
