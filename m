Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24234366FCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 18:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbhDUQRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241753AbhDUQRX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:17:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A68C06174A;
        Wed, 21 Apr 2021 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VZtC96Y0rpZ/52zKQRX4/P2lTW92hzX2CCMG++WmSmQ=; b=l5o9ShQKethQzm+HeTC3GC8Hlb
        bebQKKhYDn9xfC/9aQ2QcoabqTOygNoJ8pOuTjWO59kTWcX9EhLI/8A2m2RBTvW/wIcFo8tEpH6tj
        opeJ3tYBPw/yDGReuzqf/FpZHo/MyRkf3UaOWV2ZqjeQm8FM91Ar136HMnSI/Eb+efyh46Oi5B+pp
        twZglBMv+kmcX6Lfud0ZDZB0biZsG6PiYvrBHOR1e68fQtRvXn6GKDs7Dw2zPBRj8EqocFdMhFKKA
        a6+3Ox02Yfqj8YptVWFCKtOcun+0OLE7r6yYfiT8G1+k9q8EE1+MzbUOtj3iy0ReIaEGi4y6pro5S
        3BLhoOQQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lZFWa-00GkII-JV; Wed, 21 Apr 2021 16:16:29 +0000
Date:   Wed, 21 Apr 2021 17:16:24 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        dan.j.williams@intel.com, virtio-fs@redhat.com, slp@redhat.com,
        miklos@szeredi.hu, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dax: Add an enum for specifying dax wakup mode
Message-ID: <20210421161624.GJ3596236@casper.infradead.org>
References: <20210419213636.1514816-1-vgoyal@redhat.com>
 <20210419213636.1514816-2-vgoyal@redhat.com>
 <20210421092440.GM8706@quack2.suse.cz>
 <20210421155631.GC1579961@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421155631.GC1579961@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:56:31AM -0400, Vivek Goyal wrote:
> +/**
> + * enum dax_entry_wake_mode: waitqueue wakeup toggle

s/toggle/behaviour/ ?

> + * @WAKE_NEXT: wake only the first waiter in the waitqueue
> + * @WAKE_ALL: wake all waiters in the waitqueue
> + */
> +enum dax_entry_wake_mode {
> +	WAKE_NEXT,
> +	WAKE_ALL,
> +};
> +
>  static wait_queue_head_t *dax_entry_waitqueue(struct xa_state *xas,
>  		void *entry, struct exceptional_entry_key *key)
>  {
> @@ -182,7 +192,8 @@ static int wake_exceptional_entry_func(w
>   * The important information it's conveying is whether the entry at
>   * this index used to be a PMD entry.
>   */
> -static void dax_wake_entry(struct xa_state *xas, void *entry, bool wake_all)
> +static void dax_wake_entry(struct xa_state *xas, void *entry,
> +			   enum dax_entry_wake_mode mode)

It's an awfully verbose name.  'dax_wake_mode'?

