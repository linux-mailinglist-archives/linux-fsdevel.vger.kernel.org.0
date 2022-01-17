Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E892C4909BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 14:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiAQNrV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 08:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiAQNrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:47:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA8BC061574;
        Mon, 17 Jan 2022 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y+GfV1ciTu5PkTMNHSQWf16IvxPhRvaU9RtvP9UrOCc=; b=MOoLrZE07HPBDM6LInnvE+cZfW
        1kZb9ZUhWaETScJlrqeH/ZPMLYpZTaaM1OxJ0mPPDbRzIOe6SruMhZ/TDdu+nvGRJk62SbNwkjA1K
        rG51l/cgmWN1MgRlYUgnRZc+yf2z/UHjj1uI/n6othnfwHYjwMmvl99fvyRTyWe7jC79/ttn0rgJg
        Xr/0uVtiEx5Lp17guB1cytWhCwuPWE7H7Wop5j2WN4Kyb6IBelJNdr6koAgdabz1IiwwArUKrHD77
        WPwRWst5eAzlG3MqiLG8v+AspYj5nhFkTO9s4uqna3a1+ZRbeS2PsM1nbczMTm9MV/P7OpxwWuFNi
        dB8IfxPg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9SLt-008FTt-UV; Mon, 17 Jan 2022 13:47:18 +0000
Date:   Mon, 17 Jan 2022 13:47:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     ceph-devel@vger.kernel.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ceph: Uninline the data on a file opened for writing
Message-ID: <YeVzZZLcsX5Krcjh@casper.infradead.org>
References: <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:44:33PM +0000, David Howells wrote:
> +	if (ceph_caps_issued(ci) & (CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO)) {
> +		folio = filemap_get_folio(inode->i_mapping, 0);
> +		if (folio) {
> +			if (folio_test_uptodate(folio)) {
>  				from_pagecache = true;
> -				lock_page(page);
> +				folio_lock(folio);
>  			} else {
> -				put_page(page);
> -				page = NULL;
> +				folio_put(folio);
> +				folio = NULL;

This all falls very much under "doing it the hard way", and quite
possibly under the "actively buggy with races" category.

read_mapping_folio() does what you want, as long as you pass 'filp'
as your 'void *data'.  I should fix that type ...

