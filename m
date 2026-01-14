Return-Path: <linux-fsdevel+bounces-73637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47577D1CFA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 08:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD05C3010BE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 07:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F1A322B7F;
	Wed, 14 Jan 2026 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfDgOx7g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="muCquDrG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681537A49B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jan 2026 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377575; cv=none; b=Qo8MugYtzLjyMhFlbj2vvUHgCIWtiR1zUJZFu/NeS0iwU7NPWHmKgzXvSaa2z/k7YRFGEYO04HVViXnQZ7bjhpC8Hacs3ixxaMqFXV30kEd/YXsQ9dH8rO8ORYzgDTHDmvBUgNUMKtJ6sWrWW3Npr4kN8pXAgs6buMwGhXVWDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377575; c=relaxed/simple;
	bh=1aUKYIRl2BwEm914CynRUZT9PGBuxECbpl4PjADuaek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeS9sp/UeEr615aY1f6tUglHWAv+KWGywkC6J3SEG4dXu7byl87FcD1sZzGbeVA5lOEl0tPPTcGMQdRHlYdnOh6eltG7Kd1zC8obBe/zZY+ypffuNHEfrRNY0Bq6xHTJImqnU+pDDAFbo9Wu3VqzXzzKdkaT2CPOad9HQRQV4sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfDgOx7g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=muCquDrG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768377570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ttw7mSCoUtfFUMLK1cUNknHOhK7ms79WYyJovBvM2fs=;
	b=PfDgOx7gu56odT1roEdkxiGvX6ooinSo3vWWYtIRisZkfwyjRJY7NfuVfOKYCv8saaw7sA
	zT8LcLOPmEa2OLr9CP4vZnu1Wi+PyDfP0+T8Cb5dHiTHSVw6FGOnwGvibyIWTk/Sd8lZJq
	kx9isWhQaLhjYQWLgq4PHhN8Zfit2xM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-r6b8gAhuNruyq9KsEjiulw-1; Wed, 14 Jan 2026 02:59:28 -0500
X-MC-Unique: r6b8gAhuNruyq9KsEjiulw-1
X-Mimecast-MFC-AGG-ID: r6b8gAhuNruyq9KsEjiulw_1768377567
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4325b182e3cso4115727f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 23:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768377567; x=1768982367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ttw7mSCoUtfFUMLK1cUNknHOhK7ms79WYyJovBvM2fs=;
        b=muCquDrGNfBFYex6dW5o3kdcTn9fFxcmeyd5rLbS2Mgk69P+L5JvjRd9FERAb3jPNN
         XGe7E4ZyRFrUpn+OtMhBmJ3evLgrNyJCesM03rLHZR8UUShf8ZyTCsUVwFs4+j98FNbP
         d7ny4i8ZaHLX81s51hFAIHNFwSpkmlxhCXnuBnEpOzr9LmJ6oeAdcQfUT6Ed4y0jmruE
         tdQL9YIRjG/iZ0aOtKBbrR5r2/+q4sERsnk4u6a/NeOZg4KoNib2hUasIMemijDN5tk/
         QZsRCiG9fNDqR/6IkwPAsqCaBwKLnqJHzlnMXqQoJ66GoMcP5GOC9dI2zpXy3bHohbHy
         GG1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768377567; x=1768982367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ttw7mSCoUtfFUMLK1cUNknHOhK7ms79WYyJovBvM2fs=;
        b=W3IjEjO2hiPcEOBTXPFw8lIuM057Tj6R36E9IOHBpxgMjEctxb+uQWc8AjNFDDMZ5L
         FqvL3yNNCF8hjbiZAN+czIJXfJWPmBgtEiE8elf4E17RIfcaKd4RUfJxcx/CqFPTwvZG
         8FxvR3et3JaqTIliU8yndpU1b/SF1OYMTsy/Aw89CEgKX29NQdtIZCL5PfKQ8Lncvhrm
         FvI77GhmBe4hozkbFX2tmU+BGf3c4wplOpbtchhpMp+XcI4sxL2GHQcca4t91Phk3E8z
         PbjN+tl6dFWXeHt1JEDiyvBcAtxYT8MwVxyKonZW8++XcaeTOLEAcQXhFp8wnIixkoV8
         CIfg==
X-Forwarded-Encrypted: i=1; AJvYcCXf3m/hBOAGTV1aYHUuC/dDw5NIjzSyZ5N27Z7yeYXnI0Pa0scXU8kA+6jFlopde3Q0od3ChDZudmiwcS+2@vger.kernel.org
X-Gm-Message-State: AOJu0YwdM+qqbCxTMuNyd+OkfZvCmihWrMl33Th6UDbNwuxIErk4PVZn
	kh4s01/IdDKMTh4VQslLfB3U3hBUg3o3C8JfdoZ6EXFe4S6WxuFIz5cdmp/eerXJvSM6cj/p8Gd
	pIYyQ27bLRH8ZkC+tYphzri/DnF+T0N/sZ4Nc2LtDk7Hv7OhKpXnscDaxIkqmV/FJ2w==
X-Gm-Gg: AY/fxX6G7XPYcwSdnME5Z/FlnLusF1L0Q8X4Ga8aIwcf39zqLzzi9V2GRhWblRuMyAD
	BGRj9GjcDJNhbLqFXHVOPIn86Cj2NV42s/Rw325O9xIHIk8vwXbcx5NaAE6DQUm9KRZI/zAKMXe
	V0RLulgaHUSJw2zremNFBgmccRIkzIEnBBfEERKRQf1NpVPYGBJCAYlg3K7ixq+GlCfDl85f2sY
	Df/+jL1dRYWEVnf1/GeqSVwTfko90TGP6qoef/2TpWzyqvszTiT+/Dn/qa5/IN+lGbtEGMqEvG7
	6vOBP1WJcHPHdn0b1VaQarF/dxBQcfA6Rne6axXy3HEIZShoDzZXWeYY9SfR+tyj+yHb5I/pRZ0
	=
X-Received: by 2002:a05:600c:4f4d:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47ee338a84cmr18465455e9.32.1768377567236;
        Tue, 13 Jan 2026 23:59:27 -0800 (PST)
X-Received: by 2002:a05:600c:4f4d:b0:477:b48d:ba7a with SMTP id 5b1f17b1804b1-47ee338a84cmr18465175e9.32.1768377566779;
        Tue, 13 Jan 2026 23:59:26 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee54b8c9bsm14967685e9.3.2026.01.13.23.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 23:59:26 -0800 (PST)
Date: Wed, 14 Jan 2026 08:59:25 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fsverity@lists.linux.dev, 
	linux-xfs@vger.kernel.org, ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, 
	aalbersh@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 13/22] xfs: introduce XFS_FSVERITY_REGION_START
 constant
Message-ID: <dktp3ghx5h4eqcfgam6dj2eaajfbje6kis2z27ofovuz63lfe2@37pwttncu4ki>
References: <cover.1768229271.patch-series@thinky>
 <qwtd222f5dtszwvacl5ywnommg2xftdtunco2eq4sni4pyyps7@ritrh57jm2eg>
 <20260112224631.GO15551@frogsfrogsfrogs>
 <5ax7476dl472kpg3djnlojoxo2k4pmfbzwzsw4mo4jnaoqumeh@t3l4aesjfhwz>
 <20260113180655.GY15551@frogsfrogsfrogs>
 <20260114064735.GD10876@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114064735.GD10876@lst.de>

On 2026-01-14 07:47:35, Christoph Hellwig wrote:
> On Tue, Jan 13, 2026 at 10:06:55AM -0800, Darrick J. Wong wrote:
> > > hmm right, check in begin_enable() will be probably enough
> > 
> > I think that would probably be more of a mount-time prohibition?
> > 
> > Which would be worse -- any fsverity filesystem refuses to mount on
> > 32-bit; or it mounts but none of the fsverity files are readable?
> > 
> > Alternately I guess for 32-bit you could cheat in ->iomap_begin
> > by loading the fsverity artifacts into the pagecache at 1<<39 instead of
> > 1<<53, provided the file is smaller than 1<<39 bytes.  Writing the
> > fsverity metadata would perform the reverse translation.
> > 
> > (Or again we just don't allow mounting of fsverity on 32-bit kernels.)
> 
> What are the other file systems doing here?  Unless we have a good
> reason to differ we should just follow the precedence.
> 

The ext4/f2fs/btrfs does this

	round_up(inode->i_size, 65536);

It's not fixed offset but next block after EOF. As EOF won't move
this is fine. So, this works for both 32/64bits

-- 
- Andrey


