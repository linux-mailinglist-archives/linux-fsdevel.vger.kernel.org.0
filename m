Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647EB31E117
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 22:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhBQVNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 16:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhBQVNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:13:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E036EC061756;
        Wed, 17 Feb 2021 13:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+QiMwQdRUcPLnja4B/hwgwVfd5Ka44yMq76PcR+cIX4=; b=uy6aekCMzBzamtXkK9dDlSbcZO
        hbz9ohlsLmE9j+6C7xPkng0CIkfe6c/1OY/1d4TVimAN64WYWP5Llb18/WKraYoiqKIhg25YM0/Rh
        /w4RhzcuaY8HFo3OGWGhDt2pbN4BcfVgrW8vckVLv4l5HmjlnoY6DeBfMdKfZZAshVRt3b3G3w5eK
        OuMsFWE74KVRuhyGixZ7kNP6LsiewwA7Kst16p94+cQEYBS/AE0aXO5C+lU0qBQWk5fNA8zO/ci3G
        otrojDM6e93H7e3EDd5eL5ivgAFzooHDSvwRXAfYHxMRFnuedp80z8R3/FrDHXW8ILmQyJ4ILhR2F
        BpJcSk+w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCU6p-000syx-Fv; Wed, 17 Feb 2021 21:11:53 +0000
Date:   Wed, 17 Feb 2021 21:11:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgoldswo@codeaurora.org,
        linux-fsdevel@vger.kernel.org, david@redhat.com, vbabka@suse.cz,
        viro@zeniv.linux.org.uk, joaodias@google.com
Subject: Re: [RFC 1/2] mm: disable LRU pagevec during the migration
 temporarily
Message-ID: <20210217211143.GN2858050@casper.infradead.org>
References: <20210216170348.1513483-1-minchan@kernel.org>
 <YCzbCg3+upAo1Kdj@dhcp22.suse.cz>
 <YCzm/3GIy1EJlBi2@dhcp22.suse.cz>
 <YC2BzdHxF0xEdNxH@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC2BzdHxF0xEdNxH@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 12:51:25PM -0800, Minchan Kim wrote:
> I'd like to avoid atomic operation if we could.

Why do you think that the spinlock is better?

