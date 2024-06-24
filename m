Return-Path: <linux-fsdevel+bounces-22245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B692E915260
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719F02831B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7B519CCE4;
	Mon, 24 Jun 2024 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oTDMZlN4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CF71EB48;
	Mon, 24 Jun 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719243041; cv=none; b=AbQSehuDUpWbH+9qqIGUudHbIo3FZfA2ibJBNj07xoixe8ukvOpDhJ8ykT+15FU4nsLBuzTHXFwh++wel/aePosqlM2VAq/EH8DJdvQXV9YqVSgln8FUpcS2dxo68gNMTqsxWkg717/wp27oocdSLalWcn1i1wl0xB4YeizzNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719243041; c=relaxed/simple;
	bh=HRhQJtabtRMNCUnl8RTGBTId6p/EedjvtfBS1qbdgPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDpmHWTCziXyV11xqzL8sJViOoNy7zlJmkkRU56VpddGzn8uL3/qavmMgNY7OBWno8ex6ddGIPvdYpe6YxZzFsn88c5mSpfWQgXhHdJEloiW8aWWAnkp4rEV4EZy/T8mqMuIjfbtrFGUlZ2Y3GPPTBJqNfFPNk1KkaRTA6UYcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oTDMZlN4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ibOseP3v+dBm3ryF8qHTc4kO0U1WTtO4bLBS/mcVu34=; b=oTDMZlN4SXslRY4K7g3pCQbGMD
	qsQfoMhI7YcQdflI7frvY7DJgaYzXxOaWibqzG6uc5Tk0XaPw7hpthbydXCkPWid9i1LM6i3DM70O
	tVGdEkKpNjmUaCi1AFIyvQ4gayZE3VzExPtj0+6X1+S+buOV8PjD7DNDqBnJIJwCt4y4cznv3XzUv
	gppbQlBZQWKJ6N0xlzAklb69xw+NFgMTMq95gPTeXMVK0CYuC28uPkIX5+eW2IiPG/ttMySf9X1pl
	56A4Yhnr4i2nBoObwCBbKkhSN6RJryWtvDqIGWTJvPuoJeYjyibwp0ybu94RNtpbC24EAo1bXsdaf
	c1HBWJBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLleN-0000000ABa2-439g;
	Mon, 24 Jun 2024 15:30:36 +0000
Date: Mon, 24 Jun 2024 16:30:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev,
	v9fs@lists.linux.dev, linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix netfs_page_mkwrite() to check folio->mapping
 is valid
Message-ID: <ZnmRGyuSZKtmJVhG@casper.infradead.org>
References: <614257.1719228181@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <614257.1719228181@warthog.procyon.org.uk>

On Mon, Jun 24, 2024 at 12:23:01PM +0100, David Howells wrote:
> @@ -508,6 +509,10 @@ vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_gr
>  
>  	if (folio_lock_killable(folio) < 0)
>  		goto out;
> +	if (folio->mapping != mapping) {
> +		ret = VM_FAULT_NOPAGE | VM_FAULT_LOCKED;
> +		goto out;
> +	}

Have you tested this?  I'd expect it to throw some VM assertions.

        ret = vmf->vma->vm_ops->page_mkwrite(vmf);
        /* Restore original flags so that caller is not surprised */
        vmf->flags = old_flags;
        if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))
                return ret;
...
                if (unlikely(!tmp || (tmp &
                                      (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
                        folio_put(folio);
                        return tmp;
                }

So you locked the folio, then called folio_put() without unlocking it.
Usually the VM complains noisily if you free a locked folio.

