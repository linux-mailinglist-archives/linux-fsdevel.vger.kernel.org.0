Return-Path: <linux-fsdevel+bounces-71181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B35AACB7E8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 06:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79F963048D47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 05:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D082274646;
	Fri, 12 Dec 2025 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AR679X4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FB3B8D67
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 05:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516552; cv=none; b=H0jOvEW6D4WLBT08VPDeb4YI/luYGSH4MJNHbjgNfHwnxCiUiG06zeTluR6MnRGa+CCqgcw00Li02xkMd+hHZ1nPSNDjUwJZ4ussIVUdlmOGhgqbfWp2i3r535maFtwmpWtuPFuP+OaAhbYyUtohnFm/WDmT4Z8d93EVO6+n4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516552; c=relaxed/simple;
	bh=P/4fHit3XUT8QBZzqwt0uv/JBee16RdfMfdfYXcg910=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X0f3uIDUuVSP3+sPVZGdFB6GlTzNcsOPe8UTVgPDRoOwPa9mYyUbjYuhZpVIeAVKHIYSURRR9G9tPp2lVQwZaCt77xLRwUuHeFxFZSnQL/8Acw/gKeSrurgRzgfJkbDKJUcgiQ0Y/Z9ONxb80l4TvhVzQGJnHYwkQ99IEeWQH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AR679X4L; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64464de1c45so909564d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 21:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765516550; x=1766121350; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KPFmcLhqBnBTcaIEv2PJZuGjTwqiV4AuTcMDvkQwEyw=;
        b=AR679X4Lg0a8uIGpeXSwKZj97qZAC18ZyB2XPMSqfS3ZdK5z+5Ow0aKKb0bj1o44Iu
         LlFbbeQnyRoWpBGqeJ7BXv8meO4fzg6LvVNtXphbArTHMAHqTb2z0O37Tbt+QmbnMMCJ
         qtY+5FDbRwA1TFZdlKO2Keg7BYSc3oB0dk/38vKdmYqifUwEMdzvFxCRqQw3fGBMVoub
         ef8NVJ+ighXJYIRdRAO2hi4xo3n4wEFb9f7SO+eTbrgyp33sD9qbkPdYXlMOCWOZOIvE
         vFSaU/9CJBfheGkJ+/VNO310EKWPYEJSzKGGYwOm/jFSHfJ/F5gXQHzs/W77N5TcJ0k/
         PMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516550; x=1766121350;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPFmcLhqBnBTcaIEv2PJZuGjTwqiV4AuTcMDvkQwEyw=;
        b=iLYTTvBXcOqv2/xrDFoLN6z+PFqd99xBXNw2mqUSWK/naWIOqtbb/XtELQ272MJR6U
         EYFk7ch/4EsUNdBqEA4O8151H3HH+oJgOj+arxaEOXOvWf6zWnbDjBe3+pzOLegHnNTy
         N+LzoO93WTNwTHN0Iu93IXl8Oo3yNVZu6B3ChCgcVrJzS5q5cuQLoK86f//FSXd8d7GS
         6RX8XaMut6E5IGcbsa28MqQnh1winpoYudAjGUtDDICElV8sl2qU2QxN4HYt3bOlOhGI
         V1CczP5u6atRF1M85VJsZSmVZAyLrNrltHJTEf28n+OW35MSkFFxuRbZmay1pwQ/sv7R
         3GAg==
X-Forwarded-Encrypted: i=1; AJvYcCUELF/8HsSnY3QPfNRkCyZdS46sRkT0OvD5TQ+L+P3lTY+5vbQoe3VY3mumLrT/VkwBaFW61HAVrRjslzS6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy39N2fy6lw1MY2SSKm0a096irCAI5+7ZoVQ2X4NcfJZ7aS+R5m
	ZlYtUWzr5IkVKeuwwnruV+Mbh/6yBMC5zXdj8dn/d1icjm/29/iYIX3KONIerXdKig==
X-Gm-Gg: AY/fxX7ukBIBkC0xE1LY56Mwj1NLUA78sRtitNnk3I3OLUieCAGmLOX+VAviIWtpJMu
	pgMDoQxREr+V1yQ/aGXJS3Rb33mUmRn5miFnCJo89CTCpbQg2A4F+0g2rI/igIa7rwXdyGz7jPp
	9rc51KuZT5yl0Hu7forPlRhjJnjOwG0QkvIZyE0ydVXSMwwqm/Ww5Mi0YcE/8CnHAWOVyGz7FSC
	QqzNk7RaISiEr098orbZ089M89UVrpQ0dZJ8KISCvemyykghKQJANMVZcOqF81Q3pB5lcIX5WRj
	TQmv6+j05m2u2PL7QgRC1u/kmkiPUWLcT6QehvmFXjMHy/nW+xxjN8llNHJeNS2aJYiXIZ2sAzF
	xITJBWnVCbJ0khtobyVp62navLquRz8SMkmZCh5aV0/5CoFqxZQclW9q2MymlFTPkyT4U7q3duv
	IoVxwl04f25oieFhtMaiPuSU84QJktqJmBhIGelnPa4H2YFsybCZF9DSSBY+U8ynhXGbTW8LzJq
	tzG1wtRzw==
X-Google-Smtp-Source: AGHT+IGj4VXQERBjFBx4z8QJxqfKFrAr0raivKj93bfeYMOpD2/ljOQYzi5YzTwvUjTi4XXcYyBnYQ==
X-Received: by 2002:a53:cc0f:0:b0:640:db91:33c4 with SMTP id 956f58d0204a3-645555d245cmr503152d50.18.1765516550148;
        Thu, 11 Dec 2025 21:15:50 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e6a2161bcsm1378637b3.25.2025.12.11.21.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:15:49 -0800 (PST)
Date: Thu, 11 Dec 2025 21:15:37 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Al Viro <viro@zeniv.linux.org.uk>
cc: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.19 tmpfs __d_lookup() lockup
In-Reply-To: <20251212050225.GD1712166@ZenIV>
Message-ID: <7f288332-5514-e2ed-69e2-50c5e0304d92@google.com>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com> <20251212050225.GD1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Dec 2025, Al Viro wrote:
> On Thu, Dec 11, 2025 at 07:56:38PM -0800, Hugh Dickins wrote:
> 
> > Of course, 2313598222f9 ("convert ramfs and tmpfs") (of Feb 26 2024!)
> > comes out as the first failing commit, no surprise there.
> > 
> > I did try inserting a BUG_ON(node == node->next) on line 2438 of
> > fs/dcache.c, just after __d_lookup's hlist_bl_for_each_entry_rcu(),
> > and that BUG was immediately hit (but, for all I know, perhaps that's
> > an unreliable asserition, perhaps it's acceptable for a race to result
> > in a momentary node == node->next there).
> 
> Hmm...  Could you check if we are somehow hitting d_in_lookup(dentry)
> in d_make_persistent()?

Am I being stupid and misunderstanding you? I haven't tried
running with any printks, it seems obvious from the source that
d_make_persistent() always calls __d_instantiate(), which has a
WARN_ON(d_in_lookup(dentry)) at the start.

But I didn't see that warning fire on any occasion.

Hugh

