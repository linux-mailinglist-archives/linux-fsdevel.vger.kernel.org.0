Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8401C126B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgEAMuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 08:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728443AbgEAMuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 08:50:55 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A531C061A0C;
        Fri,  1 May 2020 05:50:55 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUV7x-00FtME-PR; Fri, 01 May 2020 12:50:49 +0000
Date:   Fri, 1 May 2020 13:50:49 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] exec: open code copy_string_kernel
Message-ID: <20200501125049.GL23230@ZenIV.linux.org.uk>
References: <20200501104105.2621149-1-hch@lst.de>
 <20200501104105.2621149-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501104105.2621149-3-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 01, 2020 at 12:41:05PM +0200, Christoph Hellwig wrote:
> Currently copy_string_kernel is just a wrapper around copy_strings that
> simplifies the calling conventions and uses set_fs to allow passing a
> kernel pointer.  But due to the fact the we only need to handle a single
> kernel argument pointer, the logic can be sigificantly simplified while
> getting rid of the set_fs.

I can live with that...  BTW, why do we bother with flush_cache_page() (by
way of get_arg_page()) here and in copy_strings()?  How could *anything*
have accessed that page by its address in new mm - what are we trying to
flush here?
