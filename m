Return-Path: <linux-fsdevel+bounces-10233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3E8491EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 00:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB71281E3F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 23:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB24610A25;
	Sun,  4 Feb 2024 23:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sODf5qCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15A410958
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Feb 2024 23:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707090346; cv=none; b=SyrY9sYLfF1J38FHnfU3x4aJ4dS/aP4cagdc1kZ20bkOU3PZNCMlE3kjm2ewaLn5Etyzoo+k0Z+pPYA0XOVEK9mav7E/c1bwLmVMZsa44ZbilDtaL7ZuBbGEr03CkRmLGN9868hkSB2Tcd47yzos4AYNJTdudI7HD6qPS8F+C3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707090346; c=relaxed/simple;
	bh=ZWrAYkEObX8RJzVDe3A4PJku6DRjgp+Pzb2LMv636KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqXY1qrhWFRg4syH09YNfFJwGsFCdQoa3xS9AKKFp5EMR8Xud9f5OQsnwmrlPAcrwXk8ZPFXuQHwgrcY13fZHIgG3OvvfaUs6/vciP2br/o9NHLSg5CmbJd08txJ40Ug2D3TzKUfxKvb1yrtSbUCMKiW2PPEWnrnOmUSjNS1S6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sODf5qCk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso4732865ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Feb 2024 15:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1707090344; x=1707695144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pvV2EpIUxaX7NT7kLqul2ISaFb45XQHzr81IwPkRSMw=;
        b=sODf5qCkkZLOy837B8hRguTwFz8PbCKtqRSTZ5dw2hdbRkRtm79EhvYOAZFMIAi1UC
         uo3Jne9/LXrsbUT/N8efwPXuhSZ8xik3kYt1K25T0dEHb3jjJasfsrX68XlgLzqxDKhN
         e6fGy8Xp+ByfSaURS37JiFd7jZeFmN9/0WBo+Fo6Pz+Ynds+o7Zeh6yP5DVcVbpCmTbZ
         fMGhVA/Ue+LA6AKguQB9lQgBqxclCw3oK8RE5cJROPkXgRbu5ngG6geniilG2yKnNkqC
         QlBR40B9V6CbIKNepoXPOHdScyfcqWh1EOS5QydJvCKdwFk47XMa4b3wDqph+pcOqCHr
         Andg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707090344; x=1707695144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvV2EpIUxaX7NT7kLqul2ISaFb45XQHzr81IwPkRSMw=;
        b=JFcUqVWY2wIIGkF9QkSdQJJLjMhBXlT6KCqP2vLpwo6FK9Cww8g4S3urwj5NBNz19E
         vUH+SSq/mO4eAnVfHNZ2xumYjtt/NKSHtxBYtqcrHkpRb1forWXzRAPRqzSFGMiKqZGH
         MjZeymk+xMNIMwOUqvOsC2+joQLo+bu2SriPKTIpMdS3LsJ5l1L6g2GhX6nU8g/qD2uL
         4XISqnL7+De8XUh58v89N5Hz3pYWUuK3mo0vYEzvatawEBlnoVmlCtr+Aj1uKrBSxquf
         qUy2r4/Jukm/Fac23pP5c87NGuDTDlFZgI40vEl9gOQekXQaX7lGDLMHWftVVAf1z2QS
         86lw==
X-Gm-Message-State: AOJu0Yzv5ayUg1scJXYS5XJYI6L3A4r7mbjaxdHouuT5cZEzuu6nmW7W
	vqs1Si2OF+DCrS2EsNNcMMchvrQakTZKDFkkPduAy890mkXWLHgDWo6+DuVCLlU=
X-Google-Smtp-Source: AGHT+IEgPuKAB4wPTf1zcjRLNfL97sIjLpYWWHuGJD3cM/33XdDSLK6OD/xjovQ9r+CU32P944mdSg==
X-Received: by 2002:a17:902:d4c7:b0:1d6:f17b:ecfc with SMTP id o7-20020a170902d4c700b001d6f17becfcmr6355888plg.15.1707090343975;
        Sun, 04 Feb 2024 15:45:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXv058kBTv74LvoPUADWwMn0wYajYRcRQIS/3H9ZLZO04+7JLzQ1H5IKF3thDY/LNJRyBHFuDK9eghvhVB/JQn/O5o0GAkm1izdGtDbIEAeMRcSwV743SoZ9QZFfxmau5rLX+ptSG+6elg8wqlCKClvSnyoCQKhI7E6twx23283M/jFfQwcWNWpOqFGQlI=
Received: from dread.disaster.area (pa49-181-38-249.pa.nsw.optusnet.com.au. [49.181.38.249])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902d11200b001d8ee19ab34sm5084689plw.29.2024.02.04.15.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:45:43 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rWmBA-0029Bi-0S;
	Mon, 05 Feb 2024 10:45:40 +1100
Date: Mon, 5 Feb 2024 10:45:40 +1100
From: Dave Chinner <david@fromorbit.com>
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
Message-ID: <ZcAhpOi0UpMhtLYT@dread.disaster.area>
References: <2701740.1706864989@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2701740.1706864989@warthog.procyon.org.uk>

On Fri, Feb 02, 2024 at 09:09:49AM +0000, David Howells wrote:
> Hi,
> 
> The topic came up in a recent discussion about how to deal with large folios
> when it comes to swap as a swap device is normally considered a simple array
> of PAGE_SIZE-sized elements that can be indexed by a single integer.
> 
> With the advent of large folios, however, we might need to change this in
> order to be better able to swap out a compound page efficiently.  Swap
> fragmentation raises its head, as does the need to potentially save multiple
> indices per folio.  Does swap need to grow more filesystem features?

The "file-based swap" infrastructure needs to be converted to use
filesystem direct IO methods. It should not cache the extent list
and do raw direct-to-device IO itself, it should just build an
iov that points to the pages and submit that to the filesystem
DIO read/write path to do the mapping and submission to disk.

If we tell the dio subsystem that it is IOCB_SWAP IO, then we can
do things like ignore unwritten bits in the extent mappings so
we don't have to do transactions to avoid unwritten conversion on
write or do timestamp updates on the inode...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

