Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18B81888BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 16:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgCQPMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 11:12:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQPMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:12:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pbLHB9V9NtrdlKy9LTVkFQnPf56Ydm4tI2ppPZSZNps=; b=JGbggYpACVXwkcRv8YuvmvHqoh
        y5eFeNBYa6g94ApVUyxyK/sE9DiqYjC45GjIAdSItbRLRasxKVptDYaysBrtbAhAuihaeEAhXBo9m
        LcIiQPMA54oLyAzkC3jQf9V/5CDFflNwmkMX9O5dUZHv6kmQr4A/3rUIe1ryA2vgzcSm3BnbcdOeT
        dzl01/yTzexypl6U1WoCpaOhuMCNvZygAQG2Kalw6cyoOgRiqC9EmiV2z2uUmOQM2dk2ZzbajADeP
        nROhJP2WDbmJwzevTdO7RNpoDlNT54Rc//2GeSQcyhmeoDcOGFut/5IWpX+OTpJUZWOrDyt7mhxuE
        OPae1xAw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEDt8-0001yB-Mk; Tue, 17 Mar 2020 15:12:14 +0000
Date:   Tue, 17 Mar 2020 08:12:14 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/8] xarray: Explicitely set XA_FREE_MARK in
 __xa_cmpxchg()
Message-ID: <20200317151214.GB22433@bombadil.infradead.org>
References: <20200204142514.15826-1-jack@suse.cz>
 <20200204142514.15826-4-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204142514.15826-4-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 04, 2020 at 03:25:09PM +0100, Jan Kara wrote:
> __xa_cmpxchg() relies on xas_store() to set XA_FREE_MARK when storing
> NULL into xarray that has free tracking enabled. Make the setting of
> XA_FREE_MARK explicit similarly as its clearing currently it.

>  		if (curr == old) {
>  			xas_store(&xas, entry);
> -			if (xa_track_free(xa) && entry && !curr)
> -				xas_clear_mark(&xas, XA_FREE_MARK);
> +			if (xa_track_free(xa)) {
> +				if (entry && !curr)
> +					xas_clear_mark(&xas, XA_FREE_MARK);
> +				else if (!entry && curr)
> +					xas_set_mark(&xas, XA_FREE_MARK);
> +			}

This isn't right because the entry might have a different mark set on it
that would have been cleared before, but now won't be.  I should add
a test case for that ...
