Return-Path: <linux-fsdevel+bounces-17965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBFA8B4477
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 08:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E451C210D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 06:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E7F4085D;
	Sat, 27 Apr 2024 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHelbQa7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4936AEC;
	Sat, 27 Apr 2024 06:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714197833; cv=none; b=Vmzgrwv3+XyS9Mo1EKF4XFdVo9wYUTJ1OaGmhKOmNKVZCRU9pTWq5w+51+mLTds5N/X7jhCWZcpscAisu7IDld90Q0YCSII50DJ0CFCDTg/ClWvyW0/mTMVocwU/lMfrJZ/ywYNCywcpiIfNx/mOv+QlGbU2XHL3lFczE86jbW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714197833; c=relaxed/simple;
	bh=uXw+H5nJM2gMztHWvfehDR6ZpHLACmnAqKg0E7FtFbg=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=VVLd+0An5endksAkBJudhPVX0yQtz7GlyiQdfPhzcWN6H8bLmTIEBzIDyfuUE7+h7UtJCTx4PqsbkNvgQWpZaInArYtFxt1JAT4TvBQAC/qQ5krmaPo9T0mhxSa8NFNHf6hxPhh1cjk3lbnhgL4P545ME3HQ8nT5bV9ammlAwg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHelbQa7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so2600761b3a.0;
        Fri, 26 Apr 2024 23:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714197831; x=1714802631; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3IOHLrZqd44HtSA/0DoKCzkRaST5QkqoI/rM6oPm9WY=;
        b=jHelbQa7P4U6QbVaB+EBz+8NbP1GV6OBIKiZhgY/iAeCnwir1Bhm7ReNoLL7aMLwoe
         dr8c4X95Mb7k113wYsicNankNHWmOeQ1hH1ew0Lt+3pQZZkqT58H3CBwNLQlQ3LBkQ8u
         PyT4CuZUqRWNTEaDpwgMredZgbVaOFa1Zj+gCykwizMCzGA/SHGKYLViJU357fSFK/u3
         KGcPIwN0wf+dBUwVYkdrO6D5REUvWjSuIHVTZaKHZj9PaOcSGmF1TSDcczxzxIa+qF1k
         4jKXgU4o8t88H7BuRADQKCI1QQnervwFEJz6W3qRwOO/jkYl5eyfBl3jSePV9lobrjNB
         Z49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714197831; x=1714802631;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IOHLrZqd44HtSA/0DoKCzkRaST5QkqoI/rM6oPm9WY=;
        b=kV4az6Q23Ir/C1VCtP5Rgvw933BV96FujRcPG86dnDtDgTvryXWbCQLrK5ati0VYXb
         6oHrok1Ut0wl++8V9K6jEtPy/VgZrUDJGhvOJBguOITmZ+n3kHiie3yh9Kmh/nvmJa+1
         ricY9ZEClfpHj9PJd59S5mg8FDNxvLE9dxugPGORl64jEeiizUewfdowQqNO91Nv6bMC
         oelPFqUIHJeo8MSkiFevpJpoqekOYTaAOcRN1I7WBK1yYW690iwaeXw70OCyU0QWAjex
         bVTRu34/8M3/ZQkThNuUdN7IooI3v+xfzd4cpPuavPSbRhRAA3Ih6yWLCjhDgYxLJLfo
         DJQA==
X-Forwarded-Encrypted: i=1; AJvYcCWIidxhkcgEnk4X8GrRdXViYYg3WyUa0OT0JvoWsIAFS+XEtnrMNyRP7RQdaX72vPT1CrXgStqHKUt9N53SJvvOrVauXcM0dShy4FbOTehhHgSbFSZT2iiyMMt9JsMAzwK7HXyuZGlDVfpqF6UfF4gJtyvN44OahWQr+M7jLhfB8TLY1Wg=
X-Gm-Message-State: AOJu0YxZO29wLuzJJJjmXLXjJ0kdRME18rNwwSV7hkJTOAMIobAEommy
	/blFYXvC6mxm2qb0jVYO0tFO3f/yGKtclu0OpDKF4RxPHOFGRpFh
X-Google-Smtp-Source: AGHT+IHX4Vb5nIzPGl2995/ZrPA2lVTtTUUkX+amIv4aUnHWiK+uG7o4RkStsrkyngFG3ec7SBg+Ng==
X-Received: by 2002:aa7:888f:0:b0:6f3:f447:5861 with SMTP id z15-20020aa7888f000000b006f3f4475861mr6225pfe.5.1714197830906;
        Fri, 26 Apr 2024 23:03:50 -0700 (PDT)
Received: from dw-tp ([171.76.87.172])
        by smtp.gmail.com with ESMTPSA id g3-20020aa79dc3000000b006f2909ab504sm10956798pfq.53.2024.04.26.23.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 23:03:50 -0700 (PDT)
Date: Sat, 27 Apr 2024 11:33:46 +0530
Message-Id: <87v843xry5.fsf@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFCv3 7/7] iomap: Optimize data access patterns for filesystems with indirect mappings
In-Reply-To: <Ziv-U8-Rt9md-Npv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Sat, Apr 27, 2024 at 12:27:52AM +0530, Ritesh Harjani wrote:
>> Matthew Wilcox <willy@infradead.org> writes:
>> > @@ -79,6 +79,7 @@ static void iomap_set_range_uptodate(struct folio *folio, size_t off,
>> >  	if (ifs) {
>> >  		spin_lock_irqsave(&ifs->state_lock, flags);
>> >  		uptodate = ifs_set_range_uptodate(folio, ifs, off, len);
>> > +		ifs->read_bytes_pending -= len;
>> >  		spin_unlock_irqrestore(&ifs->state_lock, flags);
>> >  	}
>> 
>> iomap_set_range_uptodate() gets called from ->write_begin() and
>> ->write_end() too. So what we are saying is we are updating
>> the state of read_bytes_pending even though we are not in
>> ->read_folio() or ->readahead() call?
>
> Exactly.
>
>> >  
>> > @@ -208,6 +209,8 @@ static struct iomap_folio_state *ifs_alloc(struct inode *inode,
>> >  	spin_lock_init(&ifs->state_lock);
>> >  	if (folio_test_uptodate(folio))
>> >  		bitmap_set(ifs->state, 0, nr_blocks);
>> > +	else
>> > +		ifs->read_bytes_pending = folio_size(folio);
>> 
>> We might not come till here during ->read_folio -> ifs_alloc(). Since we
>> might have a cached ifs which was allocated during write to this folio.
>> 
>> But unless you are saying that during writes, we would have set
>> ifs->r_b_p to folio_size() and when the read call happens, we use
>> the same value of the cached ifs.
>> Ok, I see. I was mostly focusing on updating ifs->r_b_p value only when
>> the reads bytes are actually pending during ->read_folio() or
>> ->readahead() and not updating r_b_p during writes.
>
> I see why you might want to think that way ... but this way is much less
> complex, don't you think?  ;-)
>
>> ...One small problem which I see with this approach is - we might have
>> some non-zero value in ifs->r_b_p when ifs_free() gets called and it
>> might give a warning of non-zero ifs->r_b_p, because we updated
>> ifs->r_b_p during writes to a non-zero value, but the reads
>> never happend. Then during a call to ->release_folio, it will complain
>> of a non-zero ifs->r_b_p.
>
> Yes, we'll have to remove that assertion.  I don't think that's a
> problem, do you?

Sure, I will give it a spin.

-ritesh

