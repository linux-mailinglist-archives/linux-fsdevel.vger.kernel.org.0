Return-Path: <linux-fsdevel+bounces-36833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B2B9E9ADE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB07A165BD7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C5B84D29;
	Mon,  9 Dec 2024 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="09Rq10Ct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7190E7083A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733759338; cv=none; b=XIW71hxKWoHOPh6FqG0hQuWgo+gcEKEC2Y7dJOn4oHdpYc+9G3TUypA36S+s5+G1H5TQsHkK9fswLbL2tbe6vUe3XqKsvJ7Cg7htFYleZ+t6s4bLyqIRyUSDW0stHlcDKTL5Ul6aCnoVqJhY0Ea/me+ujyCmf/1EkopcasYahlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733759338; c=relaxed/simple;
	bh=+1gPbNuhgWNmracC0jeAOXJrN4OrvPv8fgIyVin6fFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNzSD8YQWryWa1mBuO/0V8N8LMuEZdVKR7QjLk0Rr/iHPb0Muph5OuCtoz3798U2wgQSBkiN88KCiCbruXGWRoExKbp2PdUUxqcy+UHr0i31HnFhz/hhwQcskKPbfoBQLQBnIjav+tp3Ar8ypZbyHa5LtOVUL/oaobZd32fm3hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=09Rq10Ct; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6c40a60cbso258800085a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2024 07:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1733759332; x=1734364132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+rocib44wz3azad7YGgw/juAs7642PWJsvqbrprPhSI=;
        b=09Rq10CtO3jE3pjSitmCgTObtKZE7UxydSWBvm1F7AxY4MTuY44BYzfRaLN1/iwkUL
         FCunacbmWN0+xkYfF1yjAQuJWKe6umXchmfZWFV6bUtrwFiTAB+FICLyBHuVhI20WZ3E
         5mkyLUiy5ahpyZIfNGGFBPQ65bvfVaZbJjyvytr1N0wYzQepZodGp+YY0J1r24WIEucy
         BlbTZngnSwk4NFgDAI3c4+tZhGd/cWl3OoyIfhfTEVrgUA2x7EV8xu3VhZQ//Ks28Kmm
         hO+rb1RcXxJdLhN82Onw+mNX4vxusEVnQqNleVLEo2t7I6uazL3NOZCRrETfwgQZQb45
         J2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733759332; x=1734364132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rocib44wz3azad7YGgw/juAs7642PWJsvqbrprPhSI=;
        b=PS1jL7sY/dVg3qghzh5NYXhKE6vFgQKzRGzvgTnDKv7ZwFnc1Yf98AcXGlAuOtN9xg
         CnWaKSla/KIYga9uW2HHT6oGVCDzE79B34rtLSGE8y7kS5xLb4WltDvZffFlNP6iEyt0
         ZLrw5hTQMKA+PnxHV3uNAqxSbA2e2/IxL3FZvG/lok1m9WGNAglyyqiFeLccxAxP7Rzm
         j3xyW2E+ZewQ3tL5k6d0dS+nycbrjgAn2yM8XOxOHe0y7q/mRsbjjP4IzTRUFcOoPGL7
         dXYVFRjwc5Qj5hNgngzCZFBNjYSeEtZ1kcHot47PNDZWvOczq8RI6TSUsLI2I3Lz7VMm
         q5ag==
X-Forwarded-Encrypted: i=1; AJvYcCW9Xm9uG2UUfA2QHf9fHBrcna4KcCFqRoq+RhlQuK054uHYRzb7gJmmH9cidaTn/dWmiLlPOQ0SQQbcA9Ef@vger.kernel.org
X-Gm-Message-State: AOJu0YyoTrCBamBkXS7n5z5GEJ9QVp0bKyDsM5ZQGC3M1/DEzaxcQ4Aj
	i2sKL1FeGY8JsyLPpFtHdEddLTzkBVGmgUaimTr/hbzhwRigNmUSnpH3uKOjU/g=
X-Gm-Gg: ASbGncvFK5n+kSMeWxxDgfAX7S12t8SH9qNodO/bE5k/g8yTV/BvrDw80VIDFBR+OkF
	hTiBamDMZDZqsJJKqndwVqZUn+t64SLzLLpI+FDYRMJOpYg89SBC4NAHZ+1KrYjkWo6feB5ChWe
	2x9RQjbyz39ru0RIsAjM0862VaAIx8OjDfaK0rWZ1YhAjrEWtyPMf601n+XAZoi0EOAUua8Wm+J
	4wUgK1FDNPPJhFODtJHKXCLkT3oWRshKggNIIztk31O3ku+IiTW75V6K6tHP93kEHzpfLjsGgnV
	mQzN+GbhEZg=
X-Google-Smtp-Source: AGHT+IEQriC+zFZKHIT7XELliYE5W1Ag1e13XbqttK/G+KE9+eLNvoVeR6spIpi4WFubXKMRbQzNQA==
X-Received: by 2002:a05:620a:270b:b0:7b6:dc74:82a8 with SMTP id af79cd13be357-7b6dcdc80edmr142296185a.9.1733759332275;
        Mon, 09 Dec 2024 07:48:52 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6d93dfe65sm69324185a.2.2024.12.09.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 07:48:51 -0800 (PST)
Date: Mon, 9 Dec 2024 10:48:50 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: silent data corruption in fuse in rc1
Message-ID: <20241209154850.GA2843669@perftesting>
References: <p3iss6hssbvtdutnwmuddvdadubrhfkdoosgmbewvo674f7f3y@cwnwffjqltzw>
 <cb2ceebc-529e-4ed1-89fa-208c263f24fd@tnxip.de>
 <Z1T09X8l3H5Wnxbv@casper.infradead.org>
 <68a165ea-e58a-40ef-923b-43dfd85ccd68@tnxip.de>
 <2143b747-f4af-4f61-9c3e-a950ab9020cf@tnxip.de>
 <20241209144948.GE2840216@perftesting>
 <Z1cMjlWfehN6ssRb@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1cMjlWfehN6ssRb@casper.infradead.org>

On Mon, Dec 09, 2024 at 03:28:14PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 09, 2024 at 09:49:48AM -0500, Josef Bacik wrote:
> > > Ha! This time I bisected from f03b296e8b51 to d1dfb5f52ffc. I ended up
> > > with 3b97c3652d91 as the culprit.
> > 
> > Willy, I've looked at this code and it does indeed look like a 1:1 conversion,
> > EXCEPT I'm fuzzy about how how this works with large folios.  Previously, if we
> > got a hugepage in, we'd get each individual struct page back for the whole range
> > of the hugepage, so if for example we had a 2M hugepage, we'd fill in the
> > ->offset for each "middle" struct page as 0, since obviously we're consuming
> > PAGE_SIZE chunks at a time.
> > 
> > But now we're doing this
> > 
> > 	for (i = 0; i < nfolios; i++)
> > 		ap->folios[i + ap->num_folios] = page_folio(pages[i]);
> > 
> > So if userspace handed us a 2M hugepage, page_folio() on each of the
> > intermediary struct page's would return the same folio, correct?  So we'd end up
> > with the wrong offsets for our fuse request, because they should be based from
> > the start of the folio, correct?
> 
> I think you're 100% right.  We could put in some nice asserts to check
> this is what's happening, but it does seem like a rather incautious
> conversion.  Yes, all folios _in the page cache_ for fuse are small, but
> that's not guaranteed to be the case for folios found in userspace for
> directio.  At least the comment is wrong, and I'd suggest the code is too.

Ok cool, Malte can you try the attached only compile tested patch and see if the
problem goes away?  Thanks,

Josef

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 88d0946b5bc9..c4b93ead99a5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1562,9 +1562,19 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 		nfolios = DIV_ROUND_UP(ret, PAGE_SIZE);
 
 		ap->descs[ap->num_folios].offset = start;
-		fuse_folio_descs_length_init(ap->descs, ap->num_folios, nfolios);
-		for (i = 0; i < nfolios; i++)
-			ap->folios[i + ap->num_folios] = page_folio(pages[i]);
+		for (i = 0; i < nfolios; i++) {
+			struct folio *folio = page_folio(pages[i]);
+			unsigned int offset = start +
+				(folio_page_idx(folio, pages[i]) << PAGE_SHIFT);
+			unsigned int len = min_t(unsigned int, ret, folio_size(folio) - offset);
+
+			len = min_t(unsigned int, len, PAGE_SIZE);
+
+			ap->descs[ap->num_folios + i].offset = offset;
+			ap->descs[ap->num_folios + i].length = len;
+			ap->folios[i + ap->num_folios] = folio;
+			start = 0;
+		}
 
 		ap->num_folios += nfolios;
 		ap->descs[ap->num_folios - 1].length -=

