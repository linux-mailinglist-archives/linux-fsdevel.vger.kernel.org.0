Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0D628F456
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 16:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbgJOOGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 10:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgJOOGd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:06:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB24C061755;
        Thu, 15 Oct 2020 07:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Y78eONskpyGlU4hGu9lHbAxkXtJjFWlaahMgdLwji6I=; b=B6ppARpmYwCguqRCWuD1mChED9
        0Ynel8CZX3dIMkGMZoYbet00r1q6dl7TVFrN72W9mH/FpfN+ODef1K3iXilMVq8tYAYphLYb8/VGu
        PHTN8gt5nuuzPNOguHRpKav6gSgQOjR75Bkg6sv1yH6A+JtGCEHdNIvQvXxScJftqXb1Cl5dJqpXI
        XWsI4YqRvnmF6acOelUUYNHxNmT1H3xye3fajByyN9b890hcmz5rUOLamoA+B8N262oSAy21FGroD
        Gd7AJKsJRntHU6MURMWkyIrel4h2vcq0Zx/DOdYSjq3RJ8SZOnH+Pwj1hcWEpBYRjYMOMGMJ2pwi9
        u502InRA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kT3tn-0004lO-7n; Thu, 15 Oct 2020 14:06:31 +0000
Date:   Thu, 15 Oct 2020 15:06:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-um@lists.infradead.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 01/16] mm: Add AOP_UPDATED_PAGE return value
Message-ID: <20201015140631.GZ20115@casper.infradead.org>
References: <20201009143104.22673-1-willy@infradead.org>
 <20201009143104.22673-2-willy@infradead.org>
 <20201015090651.GB12879@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015090651.GB12879@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 15, 2020 at 10:06:51AM +0100, Christoph Hellwig wrote:
> Don't we also need to handle the new return value in a few other places
> like cachefiles_read_reissue swap_readpage?  Maybe those don't get
> called on the currently converted instances, but just leaving them
> without handling AOP_UPDATED_PAGE seems like a time bomb.

Er, right.  And nobh_truncate_page(), and read_page().  And then I
noticed the bug in cachefiles_read_reissue().  Sigh.

Updated patch series coming soon.
