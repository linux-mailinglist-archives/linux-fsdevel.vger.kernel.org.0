Return-Path: <linux-fsdevel+bounces-18509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1788B9D6F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 17:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AED41C20F85
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63715B13A;
	Thu,  2 May 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD6JXjaU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C41B60BB6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 15:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663887; cv=none; b=XLBSrzKUVmtXi+6JsN0vb0NxOmtM0U5Y+vt/5jbQNd/vVNRDjdhnEz0tVt/tvEjyNZmitAg8z0uZwv2skKAoHXItoz+Y/sHdZ69xyOzxX/BdD5sfUwKw2/Cw+R2R29gqV9ttNNyw2deTAR1UJFxqhfsE77ZqRD22horlww6LZzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663887; c=relaxed/simple;
	bh=zywPH8/dSOmVZJVYvt9PJ6JqqHh9ICpy13lmwVdQNeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TazKXzhE1nrSsRYEKfpHrSLyATSkUF9LDm+GuYxWLP8YeABZEwEB+Mm458gi2zaT8wfxM06DJrX708om7hChyy1ErSw77AA8RDk/dgT/gxOUK8ZJEV2NS0WHJm+0gbdtualiy+76ObNa3FHjF93vCU/NB4jsgzTbYJz3ZU1MQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD6JXjaU; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f29e80800so1020247e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 08:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714663884; x=1715268684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz4pWrlFgyjwYvnScmZZlbzO6Sk2PvcgKXFchkKHGrE=;
        b=GD6JXjaUW6FjOozSS9z2Ad8RKpGO/aQX5kG11jwgSipCnO9RtzyU42T/qllLmOSGIO
         y9dGR5fMLJsoC/OMb0lQjzQCL/5zC9RpXbs5QLXGU6B7133L3HUpJdBsZQHayey3ONsc
         ddEXtb0WmQMKiRtZvaLkOyH9WhxRd8WC9x+zGQVjGTSYjZSlGpKja4kEC5U1OIVHp/xu
         Qo9P+s8et8KTurE34OXku5EohtLBByxJWHvoKJBO5Ot4km9yXVyvHf1HN4dzPUGVX8e3
         /Tdzkiv8P/ZmF1TP0TOMt+Kr+ueuzYRxaP1T9U7ZTENwB3ZQozBDKsQlUES5xtqFurG7
         0sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714663884; x=1715268684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz4pWrlFgyjwYvnScmZZlbzO6Sk2PvcgKXFchkKHGrE=;
        b=PDTuGlTJp9Ijy9Ed4+Gvjtk+TZRAUpCD9G8Vp+UWXvu5t1WaZeNAkcY49NpdLQ4hMG
         Eda1zJobtlU39NgIlW1zlrjK9+nVW2FLcoV8QwllecvlRW/hZMKa3PAK99P9EezKpIBU
         GTboNEyPVp5wn6CAPVUXpFCpFdWCZs9b6+ViJLNYqSQUJWiuCAVKl9EOqHIio38+6YBr
         tJN9Gy4yD4eonfATpyeyITHNIKaR9NgajcE3ujUaKDwrCBoJNfB7o6y9hEIGg+aOgE2D
         zrpfJ8jj9mk3jOvPLKhCm6FQnmBuxx3IjZ43cXgaIxFdjBbrp3B+thMBhRyS4K76TR8B
         KHCw==
X-Gm-Message-State: AOJu0Yz68HVzIEsrRcdBIvwysslDFLiDIr6prv4PMf41j2mOtBRci14Z
	TS0wdK0LC5GcuYY4VHA9mvninNzYWP0hmn/Cbc3dbu20meMw3KFR
X-Google-Smtp-Source: AGHT+IEM41jJBy+USoJjRE2kX7vNeIoiqcx0acR21vBmyFnYS7kzxVRXWWtquvDfkknaqK5ju+4EGA==
X-Received: by 2002:a19:7004:0:b0:51d:8159:598 with SMTP id h4-20020a197004000000b0051d81590598mr128480lfc.19.1714663883912;
        Thu, 02 May 2024 08:31:23 -0700 (PDT)
Received: from f (cst-prg-82-17.cust.vodafone.cz. [46.135.82.17])
        by smtp.gmail.com with ESMTPSA id p12-20020adfe60c000000b0034ccd06a6a3sm1524862wrm.18.2024.05.02.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:31:23 -0700 (PDT)
Date: Thu, 2 May 2024 17:31:12 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: RFC: asserting an inode is locked
Message-ID: <w5aicng35yjeqef7ll5kiakg2ayarodl7h5o4uxwi76zvaewxt@kcja7hf5qqhb>
References: <ZgTL4jrUqIgCItx3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZgTL4jrUqIgCItx3@casper.infradead.org>

On Thu, Mar 28, 2024 at 01:46:10AM +0000, Matthew Wilcox wrote:
> 
> I have this patch in my tree that I'm thinking about submitting:
> 
> +static inline void inode_assert_locked(const struct inode *inode)
> +{
> +       rwsem_assert_held(&inode->i_rwsem);
> +}
> +
> +static inline void inode_assert_locked_excl(const struct inode *inode)
> +{
> +       rwsem_assert_held_write(&inode->i_rwsem);
> +}
> 

Huh, I thought this was sorted out some time last year.

> Then we can do a whole bunch of "replace crappy existing assertions with
> the shiny new ones".
> 
> @@ -2746,7 +2746,7 @@ struct dentry *lookup_one_len(const char *name, struct den
> try *base, int len)
>         struct qstr this;
>         int err;
> 
> -       WARN_ON_ONCE(!inode_is_locked(base->d_inode));
> +       inode_assert_locked(base->d_inode);
> 
> for example.
> 
> But the naming is confusing and I can't think of good names.
> 
> inode_lock() takes the lock exclusively, whereas inode_assert_locked()
> only checks that the lock is held.  ie 1-3 pass and 4 fails.
> 
> 1.	inode_lock(inode);		inode_assert_locked(inode);
> 2.	inode_lock_shared(inode);	inode_assert_locked(inode);
> 3.	inode_lock(inode);		inode_assert_locked_excl(inode);
> 4.	inode_lock_shared(inode);	inode_assert_locked_excl(inode);
> 
> I worry that this abstraction will cause people to write
> inode_assert_locked() when they really need to check
> inode_assert_locked_excl().  We already had/have this problem:
> https://lore.kernel.org/all/20230831101824.qdko4daizgh7phav@f/
> 
> So how do we make it that people write the right one?
> Renaming inode_assert_locked() to inode_assert_locked_shared() isn't
> the answer because it checks that the lock is _at least_ shared, it
> might be held exclusively.
> 
> Rename inode_assert_locked() to inode_assert_held()?  That might be
> enough of a disconnect that people would not make bad assumptions.
> I don't have a good answer here, or I'd send a patch to do that.
> Please suggest something ;-)

Ideally all ops would explicitly specify how they lock and what they
check, so in particular there would be inode_lock_write or similar, but
that's not worth the churn.

Second best option that I see is to patch up just the assertions to be
very explicit, to that end:
inode_assert_locked_excl
inode_assert_locked_any

No dedicated entry for shared-only, unless someone can point out
legitimate usage.

So happens I was looking at adding VFS_* debug macros (as in a config
option to have them be optionally compiled in) and this bit is related
-- namely absent the debug option *and* lockdep all these asserts should
compile to nothing. But I can elide these asserts from my initial patch
and add them after the above is settled.

