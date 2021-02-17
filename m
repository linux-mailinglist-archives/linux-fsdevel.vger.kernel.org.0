Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3448D31E16F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 22:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbhBQVdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 16:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhBQVct (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:32:49 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B333C061574;
        Wed, 17 Feb 2021 13:32:09 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id t29so9268827pfg.11;
        Wed, 17 Feb 2021 13:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q5lpJnSfMK2r040N1CTw4nW5Tu3iCtr8TbUrRfyRBDw=;
        b=XYyy4U5xgETcDbter4ThfNo1nWOwUyn5Zka4yGJXnczgDxpu8OzC2SeQfO652VBz7b
         PhM7QTV1nG24H/7zGkXgEEhj/sHZrIFSN4mAbV2dY9SLWPJlGs19V6yFIlVlLuIKi0+g
         wvGTrsrkHtC2g/q+Soxs3lXAbEaXYrcKABklOK2ADvRnTMSyDsCEP5mJ84z2Gz/3/f1F
         Fe2+uauF3lqBsuqdWiy8H7XsjDQf5z+wsYjgoxt6tRWBNpz1CM2ORMfGHl7tcI2WcR16
         SFybEEpwND09gVKNl0Tg/ZnbK0DCh62p7azXT5Yb8Q9Uce5XFRBkrgSOcggkaNrjK/FH
         nHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=q5lpJnSfMK2r040N1CTw4nW5Tu3iCtr8TbUrRfyRBDw=;
        b=okcnmrN11fkgNi+fM53l/dsRVhxPDo6ox/zDYOT+4New+3aXLpcySLf27Gwo0iW1M7
         GQ7iSIEWakhO9EFVHwxUlK14SXM8fTcwuyJxcmzMIoaM89qmf4VDNcYKAXfdJ5QAPo/R
         PblVfwTw2Exr+5W/7HxmRs2y55qGL+n2w5LlOVgvmpO2SrdYnR8Z4S1tbTrKNnnoXUQD
         RgLuae2IBnkF88bHX6rLp9Gs3C6eU308R+uU7Qk2htTUfawFrhRnjErwghieWx3YHb0c
         MpHtx7oZIwoaDd3eZClfsKHX0cUAlJuImX0QQCeGxvHDnhBvSLdPdW8sSctY8W7rrSS4
         T8fQ==
X-Gm-Message-State: AOAM533DhSz1Z2M4lenov2+PH7cfH0Hsx2AJHAXDh+0t8z+BRe30rMza
        KSwMppO5DQm0AFZzgehrv4o=
X-Google-Smtp-Source: ABdhPJysKKbh3uXsS1n47LDBCg2iETu9A7l0d8w0U7tJONzrFie6igTVAhyGJBI9zbY82LKAKpN9zA==
X-Received: by 2002:a65:4082:: with SMTP id t2mr1174216pgp.140.1613597528714;
        Wed, 17 Feb 2021 13:32:08 -0800 (PST)
Received: from google.com ([2620:15c:211:201:157d:8a19:5427:ea9e])
        by smtp.gmail.com with ESMTPSA id bj9sm3132679pjb.49.2021.02.17.13.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:32:07 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 17 Feb 2021 13:32:05 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, david@redhat.com, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <YC2LVXO6e2NVsBqz@google.com>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
 <YC2Am34Fso5Y5SPC@google.com>
 <20210217211612.GO2858050@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217211612.GO2858050@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 09:16:12PM +0000, Matthew Wilcox wrote:
> On Wed, Feb 17, 2021 at 12:46:19PM -0800, Minchan Kim wrote:
> > > I suspect you do not want to add atomic_read inside hot paths, right? Is
> > > this really something that we have to microoptimize for? atomic_read is
> > > a simple READ_ONCE on many archs.
> > 
> > It's also spin_lock_irq_save in some arch. If the new synchonization is
> > heavily compilcated, atomic would be better for simple start but I thought
> > this locking scheme is too simple so no need to add atomic operation in
> > readside.
> 
> What arch uses a spinlock for atomic_read()?  I just had a quick grep and
> didn't see any.

Ah, my bad. I was confused with update side.
Okay, let's use atomic op to make it simple.

Thanks for the review, Mattew and Michal.
