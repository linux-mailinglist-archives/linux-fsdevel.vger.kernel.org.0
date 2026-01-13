Return-Path: <linux-fsdevel+bounces-73407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A12D18056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 11:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DB2B303D684
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4C38A9D2;
	Tue, 13 Jan 2026 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7rq/4in";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pJQcF+MU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09B938B7AE
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300077; cv=none; b=nLjfWxONJNcmxoqQ+X4fP/yuE/6Uwk3lWx3RF4USRPAXtI9ZhFERfdgi5xc40kY6hhw9WtONqtn9jitsvss4bVczIakj34eHKH16QkexDhGT12tm30UCcSe9okVhleXtHKtC6UbT4Wymn2/ft0H2eoQbEgcMjlY2jNFa38vtHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300077; c=relaxed/simple;
	bh=Y1EG2gg9trMLtTzJzcQqnxtPYB99MBscnRy8ZXGd7Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS/5OTqGvgQVyplLsVp8ZgVZARiTQuIQr/DKLgzctbiSz1kKAtEezRChSDKwXr7vwxN9HLEg+jRaYNnbPZb4KpbMAgYV3wuCjv6grOVNSTI+C5YemtdVJILjRxIUKwNxDokdCe2GoFQrXHSEj9EqpJABLgoN63Gt0KSjJUVloRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7rq/4in; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pJQcF+MU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768300074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E0z1MicA7DsF+xKcCgaImlqMyjxE6Xv47VRmj/QLAAM=;
	b=g7rq/4ingq3eh4j4OAbXughDq9MYyoWl8cnHnfc6fuSbU8XL0lB3tXFZnjoXI5/ujhuBmg
	OJDT3Jsc7/u9NFB6Nho010Wjp29z4J7wsadgxwWVXaxE+wCWlDLztFoH4qRUE6q/VJC+tj
	oC7GELMHiOhonDHPFbv1t5pEGEzLr9k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Bj1ZLjumM9mv1BGf5tGO9A-1; Tue, 13 Jan 2026 05:27:53 -0500
X-MC-Unique: Bj1ZLjumM9mv1BGf5tGO9A-1
X-Mimecast-MFC-AGG-ID: Bj1ZLjumM9mv1BGf5tGO9A_1768300072
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so51343045e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768300072; x=1768904872; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E0z1MicA7DsF+xKcCgaImlqMyjxE6Xv47VRmj/QLAAM=;
        b=pJQcF+MU67bLK+KX4sIjHk+TafqlmuQf3TrfHXOfZVFiQ3QkUOadfCsbX/kZaJh2Dd
         V5grPgHtOzmyZBCRE9Koqcq6zkCRkwl9jlDlDlTDyo+h03AzXB+B3WZ2fVM+LGYJeKPJ
         yhUaAWQCdVZ7DzlqMZC7GWz1nBD1F1OzZVZ8bDJMTdOO/WvgSyJSbkpjYO6oBwAJjl2f
         RIBbHO6YEwBRHrJV2Wn3RsZYBzGfTpAG4Y7xvByUx5vVLvQuzyd0tERYON1Rt3kpc2Fs
         FIQZ6M/6N8UsG6tqEG/8Z+HccD/rNzv6w6oE7uMS4UrRWODH+bNE/f2g5fb3MJS0flmM
         Xyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300072; x=1768904872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0z1MicA7DsF+xKcCgaImlqMyjxE6Xv47VRmj/QLAAM=;
        b=V4XyNmsnxX+zXXeKUk41diE66ZnBSUTlfiSkhtXsRLTvp7KJEfuk6oeff9e0wGGqBk
         Nh4ebSfnfwExZfp9+a5YE1F6XqrEX/cEH8P70/SM+TglAhtFHWqBLoIQ2PsU+jiSynXv
         OLNsTgQquLusx5fC04VMYfVTNYRMRelRupMyndU6LRJd6G9mSii8VZ+/bGLIzpkzj7Tg
         GmwOFz3U/MXWTW17TE6NDssBVApyXjy7QMAZ1l4sZO53gIhc4MVlJHcfeLo7FEik6O4B
         pcFSLMOfpwlf7B9xLZKq0uWDFZxR2a1hTHjayBqXAVEuA6SVEMVxEut4zxO/+0CUcFKN
         jPag==
X-Forwarded-Encrypted: i=1; AJvYcCW/oNDFMWgyv9OUgn9cYdKUCFXnc1nDbfX2xMLLltCKlCmdX56GNr0awSFmvikGa5y4HcFgDhmVc3ToZuVg@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvis980th960k62R+X92HBrxWF7V5H+R63moYwrFPxqV8U0hw
	/tfsgAcI86CQlNMU/OMxBZrYT+rrGys0zossbxs3I9hAEmYX4goL+wrn6GAqa5YtMRQ65LdES4X
	SRiRKXnJs7cpRo8nO4+6J0CNgYORUtapN4MJwj1/QWRmCWbvNsz9sJKymDOnfy3lpAHx89DPngA
	==
X-Gm-Gg: AY/fxX6wOO4PnCHOMnlGhla7QB4VZWZJDsAIEJtk/Vg+pl6HK0HhGOqDFFh8ptPgVYO
	byYMk25UG0x38PBajG+4cqw92m7JCPJovlEFVeJdwUkqc4kRf+GPdLIphDnpA7kXKEf8ZwVE5TA
	AsobSnxyIDw3QeNLNGcCWkfA1hKYRcb6OnKoNoNm3s+cMZeqJI6STIotZl8fn0Q9SCWpjx11LoA
	NL+uR4LPWbi0vnhdSt5lPnnlQA1YLetPXGiU6MOX3Iwfbzu1b5KfycxR2uFdvkuXSCrR9PMjutP
	1BrGGkXWAFdj7Yl03v4nXAw+fTI2vhUVFTmCQ/NjST/rNzfiTzbZRuFsaZNq1NmZJtY6S0o3q3g
	=
X-Received: by 2002:a05:600c:4685:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-47d84b41bcbmr245060505e9.29.1768300071692;
        Tue, 13 Jan 2026 02:27:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR2ffY/nFR+GP3KY/RVv+hIA96YMk+myFc+0psgr29NAZFkwA7UJxzHTC3X0Uic0XrdUJ4pw==
X-Received: by 2002:a05:600c:4685:b0:477:7975:30ea with SMTP id 5b1f17b1804b1-47d84b41bcbmr245060245e9.29.1768300071196;
        Tue, 13 Jan 2026 02:27:51 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f620ac8sm389705405e9.0.2026.01.13.02.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 02:27:50 -0800 (PST)
Date: Tue, 13 Jan 2026 11:27:49 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	david@fromorbit.com, hch@lst.de
Subject: Re: [PATCH v2 1/22] fsverity: report validation errors back to the
 filesystem
Message-ID: <7nix5lf63rm6hrkpr3y37culoiiz53rerj5lcur5bez6gbstc7@xgu6qwkx4qa6>
References: <cover.1768229271.patch-series@thinky>
 <dx6z2f5lrnevosqoqr4a2aa5bmxldmishn6ln22hvdkuxxmjqa@rddd4kri6bce>
 <20260113012911.GU15551@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113012911.GU15551@frogsfrogsfrogs>

On 2026-01-12 17:29:11, Darrick J. Wong wrote:
> > To: "Darrick J. Wong" <aalbersh@redhat.com>
> 
> Say    ^^^^^^^ what?

oh damn, sorry, that's my broken script

> 
> On Mon, Jan 12, 2026 at 03:49:50PM +0100, Darrick J. Wong wrote:
> > Provide a new function call so that validation errors can be reported
> > back to the filesystem.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/verity/verify.c              |  4 ++++
> >  include/linux/fsverity.h        | 14 ++++++++++++++
> >  include/trace/events/fsverity.h | 19 +++++++++++++++++++
> >  3 files changed, 37 insertions(+), 0 deletions(-)
> > 
> > diff --git a/fs/verity/verify.c b/fs/verity/verify.c
> > index 47a66f088f..ef411cf5d8 100644
> > --- a/fs/verity/verify.c
> > +++ b/fs/verity/verify.c
> > @@ -271,6 +271,10 @@
> >  		data_pos, level - 1, params->hash_alg->name, hsize, want_hash,
> >  		params->hash_alg->name, hsize,
> >  		level == 0 ? dblock->real_hash : real_hash);
> > +	trace_fsverity_file_corrupt(inode, data_pos, params->block_size);
> > +	if (inode->i_sb->s_vop->file_corrupt)
> > +		inode->i_sb->s_vop->file_corrupt(inode, data_pos,
> > +						 params->block_size);
> 
> If fserror_report[1] gets merged before this series, I think we should
> add a new FSERR_ type and call fserror_report instead.
> 
> https://lore.kernel.org/linux-fsdevel/176826402610.3490369.4378391061533403171.stgit@frogsfrogsfrogs/T/#u

I see, will health monitoring also use these events? I mean if XFS's
fsverity need to report corrupting error then

-- 
- Andrey


