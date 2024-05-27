Return-Path: <linux-fsdevel+bounces-20286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027108D106B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 01:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC926282E4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 23:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8039B167D97;
	Mon, 27 May 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Fi/j6fy5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31413AD3E
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 23:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716850805; cv=none; b=nEEzZVGc3hzLsknrXxCxi9byYA2vgTj2YWB5II5I5Ci56ZC8Vct8nXbi7y7KdVRs+CTedssTGygOEbvE6sc5lZSkh1pb3zT0PoMW/M2TJUjaYj4SmVyGFInumlFt2qRZ0ELAe1y29VgpkSFkXoEY1RyyB7piWxzITYW1Dlquuyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716850805; c=relaxed/simple;
	bh=E6G+aqZWHlnrTbYwGo6oAwibuVwDcI8D1UquvAIxiPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4d55Qe19ka8tRnawYo8Oyfia8kRAD1h5uqnG3MSgAxfOPDxyF5LncPdfqHKwxcemYo+YkpYK56NJl8SACL+cd3azoi4M4ugFqqUFK3jTRNepWehLFdkvWk+SJ4idRAc/Bu3ZOtELGVne1g7hdz+911La9FXz//ffTuJGjXTGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Fi/j6fy5; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-68187b5d3fcso200864a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 16:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716850804; x=1717455604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mper/xMT5Q3IYA66Il/PWwArXhSI6HTMaJh9R/qoXig=;
        b=Fi/j6fy5QCJ62i5AD9zdW7pxC8S5h15wi80AHpJyytYNlQXmn1C0m1OK9RgOxrUlOX
         Msde3hlZgkTiLiuUil7BfYPUnwwCvSs02vIT+HH5eAKfBwrqpMcBfITG3kwF1/1rtAVo
         btNwcLD/vQ7Jm2I+P0Hnyahve9r9V4Co8+a9m0XOEfLP3GGFpIncynUGklQQz86WawVp
         aM5viVNDIVZ7HzZOHAlAKEabsFWji1BqYVnTiWpY2KLemm5aX5FWMjpCco2L0OvtZWMg
         kEUc/CIkQ5ynA5PmoL3NnBcgBTsJgNKzmYw5BuFa8fbDtw4PcZSVw+3unWzBCrsnoerc
         LZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716850804; x=1717455604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mper/xMT5Q3IYA66Il/PWwArXhSI6HTMaJh9R/qoXig=;
        b=n8Lc3LLcIwDnTpPEn6wnFquiNJUFn0+t2H9NQSYitLw9fAA0t1P8WYcoPA96cBgRzS
         d11k8wduxJaS4a0MMOHhjE+EOu8XkPYToROXsdXTWIPaiX7Cz52Dy9W81IamkbqLW4o3
         uRW2mfUNonFsdshqsfkBH1+yyOm51oBlNzal0J3+FYNUNrR0wsVE+GK4yK/qSz6cfoqm
         192IIVei36Id8l6VvDP+c27i7qMzbkx5mTQW5QO/0USuKKhPT4Sbce2XYVz7YCCJMsHo
         ZDnj66Sn95JYMBof3EOylSxnpZp5UkXb8bLEHR+45qUxp7luu2XNb2i+uGPyqHYNpcb6
         CxxA==
X-Forwarded-Encrypted: i=1; AJvYcCXjoJqwz5ByJtqm7gVwhA1PFsab2racFvqybQMR/MIitrgI504UK9UaBXpze4kZsYH89qz806/d9Rrq/Wob7ptBu4TkMFzp7FzxEyvh5g==
X-Gm-Message-State: AOJu0YyrtwzPL5Q3TpkC/2bXKNpsImuUiCg5N1PG3q7OjbHgJYTLpqUl
	uM0ybyjxA0To9DdRotFueQ/6TuKr30XbwirgBMZotIxZ4HWnLx3O/jSRSqrm8QQ=
X-Google-Smtp-Source: AGHT+IEBodEV0O3WOFxNjrc1u53pF65Ap/xAuIzuYtY1hdwU+UtlwfxMKYh27HDGJMMdTKbqi8t8ng==
X-Received: by 2002:a17:90a:c586:b0:2bf:fd73:1494 with SMTP id 98e67ed59e1d1-2bffd731533mr1282947a91.14.1716850803550;
        Mon, 27 May 2024 16:00:03 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f9b8144sm6337308a91.55.2024.05.27.16.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 16:00:03 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sBjJw-00CoWT-1R;
	Tue, 28 May 2024 09:00:00 +1000
Date: Tue, 28 May 2024 09:00:00 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <ZlUQcEaP3FDXpCge@dread.disaster.area>
References: <20240527210125.1905586-1-willy@infradead.org>
 <20240527220926.3zh2rv43w7763d2y@quentin>
 <ZlULs_hAKMmasUR8@casper.infradead.org>
 <ZlUMnx-6N1J6ZR4i@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlUMnx-6N1J6ZR4i@casper.infradead.org>

On Mon, May 27, 2024 at 11:43:43PM +0100, Matthew Wilcox wrote:
> On Mon, May 27, 2024 at 11:39:47PM +0100, Matthew Wilcox wrote:
> > > > +	AS_FOLIO_ORDER_MIN = 16,
> > > > +	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
> > > >  };
> > > >  
> > > > +#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > > > +#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> > > 
> > > As you changed the mapping flag offset, these masks also needs to be
> > > changed accordingly.
> > 
> > That's why I did change them?
> 
> How about:
> 
> -#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> -#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> +#define AS_FOLIO_ORDER_MIN_MASK (31 << AS_FOLIO_ORDER_MIN)
> +#define AS_FOLIO_ORDER_MAX_MASK (31 << AS_FOLIO_ORDER_MAX)

Lots of magic numbers based on the order having only having 5 bits
of resolution. Removing that magic looks like this:

	AS_FOLIO_ORDER_BITS = 5,
	AS_FOLIO_ORDER_MIN = 16,
	AS_FOLIO_ORDER_MAX = AS_FOLIO_ORDER_MIN + AS_FOLIO_ORDER_BITS,
};

#define AS_FOLIO_ORDER_MASK	((1u << AS_FOLIO_ORDER_BITS) - 1)
#define AS_FOLIO_ORDER_MIN_MASK	(AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MIN)
#define AS_FOLIO_ORDER_MAX_MASK	(AS_FOLIO_ORDER_MASK << AS_FOLIO_ORDER_MAX)

This way if we want to increase the order mask, we only need to
change AS_FOLIO_ORDER_BITS and everything else automatically
recalculates.

Doing this means We could also easily use the high bits of the flag
word for the folio orders, rather than putting them in the middle of
the flag space...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

