Return-Path: <linux-fsdevel+bounces-26157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCFC955457
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 02:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C371F22BB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 00:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60351C32;
	Sat, 17 Aug 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxb8RYG/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686A621
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 00:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723854955; cv=none; b=Hf+cMDyvFW1jWcvDjGSr9FxTCKbiRIRxanMZNC4wHGO1z1Umn+S4qhodykxGtjvqYWfEmYWhKuQShkYqXEQbP6KsEea8oKcV7r+La8yUWVA0R0KVZBaciYYCufKlvO5G6glGo/0SLu2j8O7s0Kxn3VjO6dq7szQwKoa6ngsd92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723854955; c=relaxed/simple;
	bh=P8Znbs/4oDICCc0R23VSngJRLKaID2HfeJJ3+I3HgZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fWZT17DRpqoC42PXTAcBy8M5Odlepo5rvjllb0sRaJymI8yiNfCEdsWXRdOUEi+RENMTyGoH3XATRf4bV7qdsz7FzmpvJ0klAh2oep2PPjaTm8JUX1VCg6umNih3PfXcErrNiOGlkPxZrqiEGBSFAOhULb+ge2tdeegfDbm2PeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dxb8RYG/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f01993090so3116859e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 17:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723854952; x=1724459752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ouKWpSZi70y2zABNdLnB0sD/Ven33OLtqT0MAp8KpjM=;
        b=Dxb8RYG/imRsIF4NKG9/O7niWxBtkljgOWJwvLbsBZSxmr+DiWE/lBlO41MYd7XS11
         u+xjrZZjQhGoC6T7DmUmiGVv2xwZpbwDlqGiRJmlYylZVZdGJQ1gKCVyRf2SOs2JTrXQ
         qjzIQXnRRVb2AUbnKxjXMOQuBpyppPxt5vPctAIMv1cCtdL+p2VXuLsOLCCmZsln/h4x
         gO3i7VUt1Fy4YaUMfQ8a8Rhzu6LxuY+mOavzzC0cBTyLrsktxzcDHeZLNS4Mm6YIVtm1
         +j+rlefmYPjsGPZlEkt4efLJY0PUsWv0cQ8SRMWQ2SobPsZVdWJX+IF1MN9erER+5MZw
         Iqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723854952; x=1724459752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouKWpSZi70y2zABNdLnB0sD/Ven33OLtqT0MAp8KpjM=;
        b=CdUhbMhzEqNXDpAFJT3njW1fq7oup5xTVZ1XTF/+f/1YNQofKnsHAWeHfphgPhBhrj
         1MAZ4P6EeS2ekhM3VO4/PCR7siOb4hHdD8jOHDtfK1yS52+9yF7cjO3M4hiEtOKYO0Xl
         DZQKg1keZubX/lydI5ZG6raT1ZNO5F4ADr4Lak1ubI11PD2/Q1BPsIKWktaISQtzyJBa
         KSIIDmCWXw62DCiNDMFw8hLbdY2EdbsMPPlvk8uFKv9Nf7rdPFAT39Xd1wxzKGejq1vx
         PHCmXw0I9SUZksygBn8dD/CqYJ9+OnMb6jMnks2zlCbM9zDwHkESNGaDby1hK6JecDLd
         NaQA==
X-Forwarded-Encrypted: i=1; AJvYcCURg2m9gEwy5GJg5yoTmD1CsfRRlQIOF7BNeN7nbbjmNb0+GbeuMNjDaxtET2CeYTs+WRMyLUPMR2ldTVttK7XQINqlXp6KgveXnBe87w==
X-Gm-Message-State: AOJu0YxDlhyUOCN3GXMcPidjxjb+7rCl81LyN6SReU0OuYvgT+pv+xPH
	PCkvgg4bFIAhT9/eWWrWqsbfaH4j9I5300WaVVCZQefCqvQI1z0+
X-Google-Smtp-Source: AGHT+IGgP1YP0N3B2mNgKRKJty4TZtiXgyDryGROnKBl+ECIIfn2pHPZj9gbC8SzG2FV3auIG9QJ1A==
X-Received: by 2002:a05:6512:1596:b0:52e:9d60:7b4c with SMTP id 2adb3069b0e04-5331c6f1026mr2403962e87.61.1723854951213;
        Fri, 16 Aug 2024 17:35:51 -0700 (PDT)
Received: from f (cst-prg-76-86.cust.vodafone.cz. [46.135.76.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed650903sm35115195e9.18.2024.08.16.17.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 17:35:50 -0700 (PDT)
Date: Sat, 17 Aug 2024 02:35:40 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] inode: remove __I_DIO_WAKEUP
Message-ID: <rkjfi4wcv3rzthhc3ytswry3vposdxpm7bzfjz4tozdyaazdle@rg7x23beryre>
References: <20240816-vfs-misc-dio-v1-1-80fe21a2c710@kernel.org>
 <2834955.1723825625@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2834955.1723825625@warthog.procyon.org.uk>

On Fri, Aug 16, 2024 at 05:27:05PM +0100, David Howells wrote:
> Christian Brauner <brauner@kernel.org> wrote:
> 
> > Afaict, we can just rely on inode->i_dio_count for waiting instead of
> > this awkward indirection through __I_DIO_WAKEUP. This survives LTP dio
> > and xfstests dio tests.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > ---
> >  fs/inode.c         | 23 +++++++++++------------
> >  fs/netfs/locking.c | 18 +++---------------
> >  include/linux/fs.h |  9 ++++-----
> >  3 files changed, 18 insertions(+), 32 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 7a4e27606fca..46bf05d826db 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -2465,18 +2465,12 @@ EXPORT_SYMBOL(inode_owner_or_capable);
> >  /*
> >   * Direct i/o helper functions
> >   */
> > -static void __inode_dio_wait(struct inode *inode)
> > +bool inode_dio_finished(const struct inode *inode)
> >  {
> > -	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP);
> > -	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
> > -
> > -	do {
> > -		prepare_to_wait(wq, &q.wq_entry, TASK_UNINTERRUPTIBLE);
> > -		if (atomic_read(&inode->i_dio_count))
> > -			schedule();
> > -	} while (atomic_read(&inode->i_dio_count));
> > -	finish_wait(wq, &q.wq_entry);
> > +	smp_mb__before_atomic();
> > +	return atomic_read(&inode->i_dio_count) == 0;
> 
> Can atomic_read_aquire() be used here?
> 

I think the key point is that smp_mb__before_atomic is not usable with
atomic_read and atomic_set -- these merely expand to regular movs, not
providing a full fence (in contrast to lock-prefixed instructions on
amd64).

As for what ordering is needed here (and in particular would acquire do
the job), I don't know yet.

> >  static inline void inode_dio_end(struct inode *inode)
> >  {
> > +	smp_mb__before_atomic();
> >  	if (atomic_dec_and_test(&inode->i_dio_count))
> 
> Doesn't atomic_dec_and_test() imply full barriering?  See atomic_t.txt,
> "ORDERING":
> 
>  - RMW operations that have a return value are fully ordered;
> 

smp_mb__before_atomic is indeed redundant here.

atomic_dec_and_test and its variants are used for refcounting relying on
the implicitly provided ordering (e.g., see fput)

