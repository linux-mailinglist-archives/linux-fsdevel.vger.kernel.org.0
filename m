Return-Path: <linux-fsdevel+bounces-71185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39440CB7FDF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 06:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA1EE3054C8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 05:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EB30E0F0;
	Fri, 12 Dec 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZD7i7kNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1592D2877CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765519051; cv=none; b=N/JdKK3AT9e6gh03PymDnn7bOppK5RAacUeQObmA3Kk3GX84TKAvEWRgn39Z1quFyQ28iOiYRq9xk3lq6WWTkComMWnznYsjkFVGjHXzI/frUQzOd/uGC03oeiF9U+wdtNFgj/J4evHR+/JsY+e37IjjW4eHDKghCmvZ8YE3iVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765519051; c=relaxed/simple;
	bh=bfHfLDEC1zuL4ZtSUl/liIuxWJ7j4InBS4Yw4ZrVT5k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GnacyciCoJiVUap4cI9SzDKWqyUoL0j2rT4KVNwB84PxzxzTkUpQOlLCtAlPB5c54M8V5rTaVl2AK8y6Z3I05FARCb0R0Ll3gg/G6Eh3DnoMGFxjpS4hmRcnwKQ4TqaFgIwS1nWIu/A+TTmwk7roJXGagaIqMnk9NmEa2XOIxgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZD7i7kNB; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78a712cfbc0so9551537b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Dec 2025 21:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765519049; x=1766123849; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=i21Se228o7e5LfVMJKhazW4UhnTrDBucZ7bfhKbl75Q=;
        b=ZD7i7kNBQhZU0Jhjl7RmIXoP1agJEp3k8d8gqgGQC/iUU0rZGRErAnl2GTMurpoymO
         DpYG7+mSmEaFTNXSisXhtDnlDGnonAR2TLqGl0GfASJACsDV2yU43tBc0ovf4bE5y2r4
         S1VSgjWCl7TznvvoRPAVyeG7TIVrTa972aeEvrSMl34W/Lf+kFY3QW8gEv61v9GjG27E
         KcCn9Ru/az7fl6eiR9ARJRouYpaVNBMW8RFsASFnst+/g/rMaum8NTS3Rss4R7SdXyqH
         kVqzKsq3npa5vFuxEZjnezwOw/ZS6+SqgHOU6OWX23DbhsN7Mba/Vb05uIZ1VFOZJbUd
         jL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765519049; x=1766123849;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i21Se228o7e5LfVMJKhazW4UhnTrDBucZ7bfhKbl75Q=;
        b=kFaH+DgyxbqtwWTpc7U0VNHxVGW0UvnCvdEGWN++lUQAYrc6IGEtXhFxdkwE+mTn3p
         HLbNddviKzr/nS7hSxh+2pQe3l4ltBagqOO0nO+lROu6Ckw1m5vsnvWhVSPkzJVA3tzm
         gpOszeJWXbPGGa1a/qX0g8G/I7fNGeGKJriSjJbBogJ9s/qcwAuo7WkqBpAonXe/c2gS
         IJioYhsVssQVyhu7pHFw9GDSbUVDiPsTxAuMbw4s41PBTlmFw9+aG5o1YxcXRCCo6ahP
         mHgHXvgrK/5DgN85oSuzTG8b5q5Ct2Tf9cdhDRCSakphuSF36dRRpxzRNg1ZRUY3qgyI
         bdEw==
X-Forwarded-Encrypted: i=1; AJvYcCVUOrRjGAQ0KhOM30nYGpyUT2X7WlWNxDT3FLeoo780SdH3LJduSQzrOCiR85Zpo2tDN+OBBmaWD5/rztH3@vger.kernel.org
X-Gm-Message-State: AOJu0YzEXkALuDkESWMjgcBYUUEBg8IJd6IPpgmcP+SM2NATTmYS35B1
	15LVDRED9sR+jbKrnBt/I4EWXUcZV06BcQJV2YlxneFJuMSV6FgMm1oiOk5kQUyJpw==
X-Gm-Gg: AY/fxX55BvJB3Y4/BoPpG1KlUc2QVSwSwdp+qm+llVG94dbS5mZJsDTnHCjXS85zWq7
	KRRb/9ab6I/gQqaHFbjDUhi9YqYtco2JyKh5x07RGB024cWqRcdoLDYLjXXyR9MlW8kCla4TdpC
	dF3EqboKTVctIe0fHc6aEt5dd/0D0J8vs8tIn11OiFKbIQ0e+t7LML48CsHhjbarCcvIld/VOte
	c+xs5dxQ3fGbBrxPN13CLlU0K7lw6E0Z90JlUfL/1eBePVpX/TRj2jHkn5tmW7wquwiHJUuJ9A5
	FY+BH0kvOsVdcLQ+eRhCkCiG54uTQIvetcRsm6OowwJO73dmiRR63XBj0/LkSYVRNafpCB77+70
	VpVFZipk+wfF3j4mGttDRa1+tPI9In9AwiYjXjFQ+FBUsf5T3ooDrN00gIvAKxqZLgcOdYQI8so
	Ia1k49LA2Ir+FkUBYBGj6qOa+HboQRN+w4ewxLhPhtMuXTMppKGRy54DyGD5v7SJr7QnQFD/s=
X-Google-Smtp-Source: AGHT+IGZuHDsISTjDfQK5H60ZIz8jILBSpG+DpOMHG7/zrdVqW5LxRspyhN1oRFnpxvNHaCcPwfZVw==
X-Received: by 2002:a05:690c:6c86:b0:787:d1e7:e75b with SMTP id 00721157ae682-78e66ea2090mr8375797b3.64.1765519048813;
        Thu, 11 Dec 2025 21:57:28 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e69ffa216sm1656407b3.15.2025.12.11.21.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:57:28 -0800 (PST)
Date: Thu, 11 Dec 2025 21:57:15 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Al Viro <viro@zeniv.linux.org.uk>
cc: Hugh Dickins <hughd@google.com>, Christian Brauner <brauner@kernel.org>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.19 tmpfs __d_lookup() lockup
In-Reply-To: <20251212053452.GE1712166@ZenIV>
Message-ID: <8ab63110-38b2-2188-91c5-909addfc9b23@google.com>
References: <47e9d03c-7a50-2c7d-247d-36f95a5329ed@google.com> <20251212050225.GD1712166@ZenIV> <20251212053452.GE1712166@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 12 Dec 2025, Al Viro wrote:
> On Fri, Dec 12, 2025 at 05:02:25AM +0000, Al Viro wrote:
> > On Thu, Dec 11, 2025 at 07:56:38PM -0800, Hugh Dickins wrote:
> > 
> > > Of course, 2313598222f9 ("convert ramfs and tmpfs") (of Feb 26 2024!)
> > > comes out as the first failing commit, no surprise there.
> > > 
> > > I did try inserting a BUG_ON(node == node->next) on line 2438 of
> > > fs/dcache.c, just after __d_lookup's hlist_bl_for_each_entry_rcu(),
> > > and that BUG was immediately hit (but, for all I know, perhaps that's
> > > an unreliable asserition, perhaps it's acceptable for a race to result
> > > in a momentary node == node->next there).
> > 
> > Hmm...  Could you check if we are somehow hitting d_in_lookup(dentry)
> > in d_make_persistent()?
> 
> Another question: is it a CONFIG_UNICODE build and are you running with
> casefolding anywhere in the vicinity?  If so, does this thing reproduce
> without that?
> 
> Because that's one potential area of difference between shmem and ramfs
> (as well as just about anything else where tree-in-dcache might be
> relevant); if that's where the breakage happens, it would narrow the
> things down nicely...

No, sad to say, CONFIG_UNICODE is not set.

(I see why you're asking, I did notice from the diff that the
case-folding stuff in shmem.c used to do something different but
now the same in several places; but the case-folding people will
have to look out for themselves, it's beyond me.)

(And yes, I was being stupid in my previous response: once I looked
at how simple d_in_lookup() is, I understood your "hitting"; but at
least I gave the right answer, no, that warning does not show up.)

Hugh

