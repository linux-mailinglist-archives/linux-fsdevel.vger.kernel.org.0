Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4528B1E3241
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390126AbgEZWUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 18:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389613AbgEZWUr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 18:20:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936ABC061A0F;
        Tue, 26 May 2020 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XwPxUzMrfLWiY+zeasG0pmVYiHQIhzIbdSNkNN6qGgw=; b=qCb428azsiFiTY3bfIEilqYWFi
        EnnHHEGu+Ie2Gj2UbFpnLKRlezSYIlFDBUxXxeo/dJAoHM76uyjoDDXP2BhtDXrIxNFhyePSK81jq
        ISE4poEM92gnIinv4Z/Nc7v51Oea47l7msRB34LGfa4QJNv4ZJZBbrmc5cQ45hKvBGqqx0yTkLPZk
        wzvDQsTy5OvgTlCNaPg2vBimDwIaxRnhoUGRP7WyPCxSrrxJYznOS4hJnfY7G14vfrIRiwHVovwIi
        rz841xgkYwTe5YxUfoVHZVy//+p0uOkRMT+YsKA9emMroCkfnMhb4esqSZou4Ak8KG9gY7xEOmuAC
        Eld9a4jQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdhwF-0000yf-DI; Tue, 26 May 2020 22:20:47 +0000
Date:   Tue, 26 May 2020 15:20:47 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 36/36] mm: Align THP mappings for non-DAX
Message-ID: <20200526222047.GJ17206@bombadil.infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-37-willy@infradead.org>
 <B06C1160-D40B-4D38-8ECF-F8BDE80F6DC0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B06C1160-D40B-4D38-8ECF-F8BDE80F6DC0@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 26, 2020 at 04:05:58PM -0600, William Kucharski wrote:
> Thinking about this, if the intent is to make THP usable for any
> greater than PAGESIZE page size, this routine should probably go back
> to taking a size or perhaps order parameter so it could be called to
> align addresses accordingly rather than hard code PMD_SIZE.

Yes, that's a good point.  For example, on ARM, we'd want to 64kB-align
files which we could use 64kB pages, but there would be no point doing
that on x86.  I'll revert to the earlier version of this patch that
you sent.  Not sure how best to allow the architecture to tell us what
page sizes are useful to align to, but that earlier patch is a better
base to build on than this version.
