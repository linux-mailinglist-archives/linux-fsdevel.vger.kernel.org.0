Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5688A23EE5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgHGNjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 09:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGNjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:39:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421B8C061574;
        Fri,  7 Aug 2020 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eNlt5+MOMqdMiipq56av3Q5dInH/0IZEcBwwhkePOhw=; b=jooGZOBZPN+/zhWloZREEQs9Qe
        1Gm0HEqpmKTnkfVygGtCjNGPDIVzbn6Oy4iJaZzm2CfGsgeL8I6RGXh+QirerafkOCyyFLowQfn04
        IChcKEfRifcIOwSxygkNiijBPFeNHpOZTqM6nCUYljV7yii6nwcVfTblozH6g8PM6Q312CvbDI25M
        zjBglzIXAyMENEhkum19A1pCMt7D7s7lweM2Z4sd2VbM7V6c6Cd5CwISpe/CWHJm+3fcz7fTwgtvK
        Rlxfs1dl7r8mlxzgjjjbi+UlFk1MHOgX7V6pvrUvfVUZV9ivnPN/+OOwdWfrzlX5EzJ1coyIw+I7X
        K4lH3vDg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k42aH-0003o5-B8; Fri, 07 Aug 2020 13:38:57 +0000
Date:   Fri, 7 Aug 2020 14:38:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        dan.j.williams@intel.com, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de, qi.fuli@fujitsu.com, y-goto@fujitsu.com
Subject: Re: [RFC PATCH 0/8] fsdax: introduce FS query interface to support
 reflink
Message-ID: <20200807133857.GC17456@casper.infradead.org>
References: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807131336.318774-1-ruansy.fnst@cn.fujitsu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 09:13:28PM +0800, Shiyang Ruan wrote:
> This patchset is a try to resolve the problem of tracking shared page
> for fsdax.
> 
> Instead of per-page tracking method, this patchset introduces a query
> interface: get_shared_files(), which is implemented by each FS, to
> obtain the owners of a shared page.  It returns an owner list of this
> shared page.  Then, the memory-failure() iterates the list to be able
> to notify each process using files that sharing this page.
> 
> The design of the tracking method is as follow:
> 1. dax_assocaite_entry() associates the owner's info to this page

I think that's the first problem with this design.  dax_associate_entry is
a horrendous idea which needs to be ripped out, not made more important.
It's all part of the general problem of trying to do something on a
per-page basis instead of per-extent basis.

