Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4261133A112
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Mar 2021 21:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhCMUha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Mar 2021 15:37:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:36668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234165AbhCMUg7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Mar 2021 15:36:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D578564ECD;
        Sat, 13 Mar 2021 20:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1615667819;
        bh=lrVRSwJF8M5etHaNGCsRwuMHeCP7ip37fuj2Mk8p21o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p/7UxP4+8dasaGAPa7pttK3E/8+FQ8ox9J+WxO7TOfSEWqYTugcp4mcpMevhQ+jis
         yGIe6zZaUUzVWcTnZdUOyT4W0s7eearabw+2GSU2dOxs+v93bvm9QByXDMFgVPCoiz
         O/Jh08ZOTkmesvom0o8j0BDmb6zvonJF+Wn6pCO8=
Date:   Sat, 13 Mar 2021 12:36:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 00/25] Page folios
Message-Id: <20210313123658.ad2dcf79a113a8619c19c33b@linux-foundation.org>
In-Reply-To: <20210305041901.2396498-1-willy@infradead.org>
References: <20210305041901.2396498-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  5 Mar 2021 04:18:36 +0000 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Our type system does not currently distinguish between tail pages and
> head or single pages.  This is a problem because we call compound_head()
> multiple times (and the compiler cannot optimise it out), bloating the
> kernel.  It also makes programming hard as it is often unclear whether
> a function operates on an individual page, or an entire compound page.
> 
> This patch series introduces the struct folio, which is a type that
> represents an entire compound page.  This initial set reduces the kernel
> size by approximately 6kB, although its real purpose is adding
> infrastructure to enable further use of the folio.

Geeze it's a lot of noise.  More things to remember and we'll forever
have a mismash of `page' and `folio' and code everywhere converting
from one to the other.  Ongoing addition of folio
accessors/manipulators to overlay the existing page
accessors/manipulators, etc.

It's unclear to me that it's all really worth it.  What feedback have
you seen from others?

