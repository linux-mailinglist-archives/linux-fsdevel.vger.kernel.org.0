Return-Path: <linux-fsdevel+bounces-44123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE1FA62DF8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 15:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE8D17A6D8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Mar 2025 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C223A202C45;
	Sat, 15 Mar 2025 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="Kqk4R/fm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D028F4;
	Sat, 15 Mar 2025 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742048079; cv=none; b=Wvxbz7N/pXYLczWqD3yG/FU0RPCxuLn1oriSCObupxrKzhV/ulLUActyScMa19r0NEbCaM14kSF1OckZsyHsjSqfeTPgBF54yoOvUWuxE3krODUgT05opu+EhyjkLvPWghONpCwm1wJKoXNmYejYV589QxXY9N8uN2TTsN925zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742048079; c=relaxed/simple;
	bh=B3YznuWjoZCjX4Cn9npsPWTPaOamh/m7ntXOsj4+f6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwAj8H5hiWP4gfCJ+go5kXUoG/C1Yx0mEaRucBjH0P7g6zTTfvlHuZYwFUTeVHTi/+9xNif+gDO6ONcQkKxddwXHuM9X6IX3SnFKcKJFYWFKMrKjvXlNzOqPdYQNMcXfC2ptmTGGdaaMral+xg462UUy0yKFFrfOu8Uv01daJJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=Kqk4R/fm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZFNXV047Jz9smr;
	Sat, 15 Mar 2025 15:14:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742048074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkzquW45bQIDk5GWnrRlp9BUPNkZHHJscF8H/Tu5E+c=;
	b=Kqk4R/fml7XpPnY4mzgk9nJ2ykekTDxNIicdbs4qiLwVhC6VhLEzHMUWGVR7xKjV2ilMi3
	h63ft3PR6svwzxBsr328xL9Q2qEcrQkEeS7pFodp98mY13plxx4hJsGX+0uU7GUJX/OvIr
	IpwdCzIoiKcS0swRRH+IUgdbjrnW2I7Bgf5djMTRB/KsoOw/UrjXfUk4awqNwna++kUUCu
	yg6BADha9CEr0oCa2fU162vZ/KTb9191YOfPLBerRGRoqne4V44QUO7QK0SLAlWFf9NaHh
	J8nRa7F178py/SYMkXMM4V6qGIj3ecTwgurIkYgcmYPEnxSFHDNtrvsCPZoqpA==
Date: Sat, 15 Mar 2025 10:14:29 -0400
From: Ethan Carter Edwards <ethan@ethancedwards.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tytso@mit.edu, 
	ernesto.mnd.fernandez@gmail.com, sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
	willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH RFC 1/8] staging: apfs: init lzfse compression library
 for APFS
Message-ID: <qfsx67vdly35gj642ae6wok6kzms6iuy626p5sfkqincofwfu2@3r5tk65hj4ie>
References: <20250314-apfs-v1-0-ddfaa6836b5c@ethancedwards.com>
 <20250314-apfs-v1-1-ddfaa6836b5c@ethancedwards.com>
 <51af0391-4dcf-434b-8c10-8682ab4a6179@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51af0391-4dcf-434b-8c10-8682ab4a6179@stanley.mountain>

On 25/03/15 12:41PM, Dan Carpenter wrote:
> On Fri, Mar 14, 2025 at 05:57:47PM -0400, Ethan Carter Edwards wrote:
> > +static size_t lzfse_decode_buffer_with_scratch(uint8_t *__restrict dst_buffer,
> > +                         size_t dst_size, const uint8_t *__restrict src_buffer,
> > +                         size_t src_size, void *__restrict scratch_buffer) {
> > +  int status;
> > +  lzfse_decoder_state *s = (lzfse_decoder_state *)scratch_buffer;
> > +  memset(s, 0x00, sizeof(*s));
> > +
> > +  // Initialize state
> > +  s->src = src_buffer;
> > +  s->src_begin = src_buffer;
> > +  s->src_end = s->src + src_size;
> > +  s->dst = dst_buffer;
> > +  s->dst_begin = dst_buffer;
> > +  s->dst_end = dst_buffer + dst_size;
> > +
> > +  // Decode
> > +  status = lzfse_decode(s);
> > +  if (status == LZFSE_STATUS_DST_FULL)
> > +    return dst_size;
> > +  if (status != LZFSE_STATUS_OK)
> > +    return 0;                           // failed
> > +  return (size_t)(s->dst - dst_buffer); // bytes written
> > +}
> 
> You'd be better off doing a reformat of the white space before sending
> the driver.  The really basic stuff.

Yes, I apologize. Admittedly, I did not scrutinize the library code as
much as I should have. I will refactor it in the next revision.

> 
> regards,
> dan carpenter
> 

