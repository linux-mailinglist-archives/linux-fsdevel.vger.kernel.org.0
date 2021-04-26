Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A61F36B438
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 15:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhDZNra (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhDZNr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 09:47:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA5C061574;
        Mon, 26 Apr 2021 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N1CS+JREmKmZmsb3/+Y0E8O1tSvBvWwvhYqw5K1frW8=; b=fyFSwHnVtojOmyAIldsnUxbp2c
        fStqfRoBxbicVf6TyYYq5KR7CSJtoZlTTGuM55J44givMzR8eZ6GmAM9wLvG2YRqzc1esFeeuM/5N
        5kzj7tysOOMdsK3iixuRAjwN3UEKRmXeyAf8ljNskHktrDG6f90ueV6ojBicMYS/cR6CwKGV8d2DY
        ELU56FceROBeH1ibYgIa1NJvmGI9rkEEOTOd5onPHysUEFA/3xQKzSPzTIuVhmTeFUYcYGLJJqleY
        hcipJwnP68IeYZLj2WZoRCgao/jEx6d8B8QCOvvqpYtNU2mw90m0fXkoUuVTGsXCocKhCH1tk/ztB
        TnIlW3tA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb1ZI-005fv5-OG; Mon, 26 Apr 2021 13:46:36 +0000
Date:   Mon, 26 Apr 2021 14:46:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, jack@suse.cz,
        slp@redhat.com, groug@kaod.org
Subject: Re: [PATCH v4 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210426134632.GM235567@casper.infradead.org>
References: <20210423130723.1673919-1-vgoyal@redhat.com>
 <20210423130723.1673919-2-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423130723.1673919-2-vgoyal@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 23, 2021 at 09:07:21AM -0400, Vivek Goyal wrote:
> +enum dax_wake_mode {
> +	WAKE_NEXT,
> +	WAKE_ALL,
> +};

Why define them in this order when ...

> @@ -196,7 +207,7 @@ static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
>  	 * must be in the waitqueue and the following check will see them.
>  	 */
>  	if (waitqueue_active(wq))
> -		__wake_up(wq, TASK_NORMAL, wake_all ? 0 : 1, &key);
> +		__wake_up(wq, TASK_NORMAL, mode == WAKE_ALL ? 0 : 1, &key);

... they're used like this?  This is almost as bad as

enum bool {
	true,
	false,
};

