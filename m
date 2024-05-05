Return-Path: <linux-fsdevel+bounces-18759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2A08BC06D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 15:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D33891F2164D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 13:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806FD1BF3F;
	Sun,  5 May 2024 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="StPHmh5c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205118046
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714914123; cv=none; b=otaE5q7a+eELHDb30WHLJ0vuf4S7uwurP4KCiDYVuqv7kFD4ZOGf9r3kAnHDgBZ9PpSwwfaIZSREpSd40gQbVUBaoqWXifm5WWhxJsRzQ1JuaKdHZ4Br4HhCgBxTAOJtFZ+D5jLHZ1J8HZiAsztD/dxhBuh52BI0iCOxdzTea20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714914123; c=relaxed/simple;
	bh=O4KaOLVu/xetmHl+nM+aCNphKLtUIP3F0qk4dXI3J94=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OjLO+Be1eJMwBrEOhw9NyVWjtsUfJXpHqtXmOtYrv/9UWn0DyHWsOmmhXMz2jQ7Uf/XkH98WERdYPJfORMrnRMna0A6Uu6/H2NAQlUYyP+70YOqgAKhDcResIdNZwsCUZXDvMvFxIer54FZtPRPkCT4icDsc57B7ZOB51IgLd8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=StPHmh5c; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GVPjuK/hAO7GWV0d0J2X+bi9+F43id/+1jsQqQzV2us=;
  b=StPHmh5cp5Y6GP8pRLGAQ9WqrAPRk6XWfb3G15WVbHFwww+Wtka5OizU
   Sa270rIlbLPtys74tjZ3VPzwq115g8qv5J6Hi/+2cwA4FXBGaMec6UaSX
   Ydi20tAom/vAIMqQZE9rF3odzUCc+rKTIdQUH57A5xYl28ruyIkzN3YVM
   k=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,256,1708383600"; 
   d="scan'208";a="164547327"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2024 15:01:57 +0200
Date: Sun, 5 May 2024 15:01:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Matthew Wilcox <willy@infradead.org>
cc: Dan Carpenter <dan.carpenter@oracle.com>, 
    Julia Lawall <julia.lawall@inria.fr>, 
    "Fabio M. De Francesco" <fmdefrancesco@gmail.com>, 
    Ira Weiny <ira.weiny@intel.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Bart Van Assche <bvanassche@acm.org>, Kees Cook <keescook@chromium.org>, 
    linux-fsdevel@vger.kernel.org
Subject: Re: kmap + memmove
In-Reply-To: <Zjd61vTCQoDN9tUJ@casper.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2405051500030.3397@hadrien>
References: <Zjd61vTCQoDN9tUJ@casper.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 5 May 2024, Matthew Wilcox wrote:

> Here's a fun bug that's not obvious:
>
> hfs_bnode_move:
>                                 dst_ptr = kmap_local_page(*dst_page);
>                                 src_ptr = kmap_local_page(*src_page);
>                                 memmove(dst_ptr, src_ptr, src);
>
> If both of the pointers are guaranteed to come from diffeerent calls to
> kmap_local(), memmove() is probably not going to do what you want.
> Worth a smatch or coccinelle rule?
>
> The only time that memmove() is going to do something different from
> memcpy() is when src and dst overlap.  But if src and dst both come
> from kmap_local(), they're guaranteed to not overlap.  Even if dst_page
> and src_page were the same.
>
> Which means the conversion in 6c3014a67a44 was buggy.  Calling kmap()
> for the same page twice gives you the same address.  Calling kmap_local()
> for the same page twice gives you two different addresses.
>
> Fabio, how many other times did you create this same bug?  Ira, I'm
> surprised you didn't catch this one; you created the same bug in
> memmove_page() which I got Fabio to delete in 9384d79249d0.
>

I tried the following rule:

@@
expression dst_ptr, src_ptr, dst_page, src_page, src;
@@

*                                dst_ptr = kmap_local_page(dst_page);
				... when any
*                                src_ptr = kmap_local_page(src_page);
				... when any
*                                memmove(dst_ptr, src_ptr, src);

That is, basically what you wrote, but with anything in between the lines,
and the various variables being any expression.

I only got the following results, which I guess are what you are already
looking at:

@@ -193,9 +193,6 @@ void hfs_bnode_move(struct hfs_bnode *no

 		if (src == dst) {
 			while (src < len) {
-				dst_ptr = kmap_local_page(*dst_page);
-				src_ptr = kmap_local_page(*src_page);
-				memmove(dst_ptr, src_ptr, src);
 				kunmap_local(src_ptr);
 				set_page_dirty(*dst_page);
 				kunmap_local(dst_ptr);
@@ -253,9 +250,6 @@ void hfs_bnode_move(struct hfs_bnode *no

 			while ((len -= l) != 0) {
 				l = min_t(int, len, PAGE_SIZE);
-				dst_ptr = kmap_local_page(*++dst_page);
-				src_ptr = kmap_local_page(*++src_page);
-				memmove(dst_ptr, src_ptr, l);
 				kunmap_local(src_ptr);
 				set_page_dirty(*dst_page);
 				kunmap_local(dst_ptr);

julia

