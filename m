Return-Path: <linux-fsdevel+bounces-62208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEF9B88624
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 10:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB2E1C81E71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86152ECD0F;
	Fri, 19 Sep 2025 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="efvsP4I3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C032BEC26
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270048; cv=none; b=oPpCPFY6qj4B/WYnWhD1EZJJflCA6YfJR+0xfhsK7zHY15VnvcOK53dgIO0/1GsxYksgMU7Yb0bOCtoyLb/VJjlGcFjMulIjjQkDeLwISGS/6nMkKNSOmznaGrRk+2gauyosFS5V2X37IyKF9alP79BLmHCqnyYpj7GzNjtsOzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270048; c=relaxed/simple;
	bh=4uxyFgZPdvgxdFlolxDKkw2mOesq1UDZPUI9cuRy23A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9RlAUmUaVAXSFeaj6mYRayTULLPvhaUDYzKHAD3oWUSmgZW0BustSZcsUykGK04oiQYzjKUWt0/L++4tESmGhzqeH4lJf/YyUPBhOHuxaTryxNKdG73tAmifCSrViP/pNe41pdSca+WhG5W6EETw6tpI9xgqHRkbn7B+SGs5IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=efvsP4I3; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b5ed9d7e96so19183001cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 01:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1758270045; x=1758874845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3zqWI6jBnKkVsPYUw9SIO+azuN2z3hgMJ01p9A5iII0=;
        b=efvsP4I3INdgnfiGTXclJaj8ujSqdUaj+MZmi02KgKNHvmpGWYyGLE4PFOY/CSKQZz
         81x/c0T3gJmvoepADqVvPLW56M7buM2qHxizHnEyhO1aQvYz0aBWB12vC7ehSg3Rnk2Q
         L55OmfHUvVQVp3Pfx7WT3Kmm44V1kXih3uuCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270045; x=1758874845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3zqWI6jBnKkVsPYUw9SIO+azuN2z3hgMJ01p9A5iII0=;
        b=XnUMCuPRyBIZYkBclTrgo3uK3Sa2l/oYPX91OekDKQmG8sFhJadH2GUqREqo92uCwZ
         LSYu8X/9GTvINP48ZOU35xIqihAl0DrZ4fgwnZ0YdTMQH1A7Qd21qm+GzqOMt0VhXDV8
         6kxS32UR9SINWfz6aZBJjgXebF8xsLTxcZ8PCn5gthlOkT6nFmxSgEEl7P8c0QtbUZta
         p9yqT6gXUcBjmgyce5OKjI9gMnf1QJFzIT8pwsic1dRIYUnEHs2cbxfGcHEmEgvKm3YM
         jPP+V6U2iAWwUcZ52Byt12icYNDxYmQSHX2JcMyqPHKGHCWR02FWsR/CDwb1ksnQ53Dy
         R0Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVr7lLcPfS0vLpUTKhXWEh++U2Zm3j6Pwg9WTp+FbBD+kIWFOLXV54CRvD9NoOfvIw+A2lmBjcD09JKSQqP@vger.kernel.org
X-Gm-Message-State: AOJu0YyMd/toICP3Sccy/2CAnV1KG21FHIn1/WVcOnoozza9gsiPefaC
	8qlaMsR2IeJVtFgp/qf5dwlhvUVg/oQtnJMTB4tryHKDYXiv20zLnUkhJ+OpsvtRLtyepUDkugy
	ohuIdOeQyVqEq34zqmamR3U/oXa3B3IWaqHrZul8cNW85LTfRL+oq
X-Gm-Gg: ASbGncv/5Wr+2CNaNVilFjdlnsr448KhLldRUa+H0DS7jPQlJHgECAs18ZWpQ5es7vG
	Lsp1emREAoVJtEhLBT+RfimgTrBemdsAqp+JoPjhIi2PKS307jRH+jdFLAragEjVA/uRXmeEqhR
	UkVB2No7PfMjfS17lsF///BM8tklc4m0eF0vpSbCeDHyCtXMBVcLrj02mQnOZVajJ6QyIDuRkE8
	1A9Ytw8ofQjoqMrud8QKMf6HWpROsFAFmBsq+g=
X-Google-Smtp-Source: AGHT+IE7niVqcp2ir00cjS3910NvVS7nX6P/tIswWeRlZzgkoYyCdo+bwE8H0NpmIp673Xg6QBcD2pH4FSbJ2Z4V1Yk=
X-Received: by 2002:a05:622a:15cf:b0:4b6:18ff:3630 with SMTP id
 d75a77b69052e-4bdada0c077mr64855811cf.24.1758270044558; Fri, 19 Sep 2025
 01:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917153031.371581-1-mszeredi@redhat.com> <175815978155.1696783.12570522054558037073@noble.neil.brown.name>
 <CAJfpeguvJNwEy_Vt-d4YhKW8u_qs56pUPVrLrj039VmnA7G=RQ@mail.gmail.com>
In-Reply-To: <CAJfpeguvJNwEy_Vt-d4YhKW8u_qs56pUPVrLrj039VmnA7G=RQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Sep 2025 10:20:33 +0200
X-Gm-Features: AS18NWCW9y11Qoq9YeKosfQc6Z4z3KwLbQEOdP0LfOobOc0R7aHYYzGtPbN1YAY
Message-ID: <CAJfpeguQT9GQ4nkDO25Dt1DLqChqBA3oEg_Y13zdUZiYnDPdZg@mail.gmail.com>
Subject: Re: [PATCH] fuse: prevent exchange/revalidate races
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Sept 2025 at 12:02, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 18 Sept 2025 at 03:43, NeilBrown <neilb@ownmail.net> wrote:

> > Or maybe we could sample d_seq before calling ->d_revalidate() and only
> > allow d_invalidate() to succeed if d_seq is unchanged.  If it changed,
> > we repeat .... something.  Maybe the revalidate, maybe the lookup, maybe
> > the whole path ??

Checking d_seq makes sense.  But that doesn't deal with the case of a
rename that modified the fs on the server but didn't yet get to
d_move/d_exchange.  In that case d_seq would be unchanged, yet
invalidation could be triggered.

To detect this I think a dentry flag (DENTRY_RENAMING) is sufficient.
This flag would be set before calling ->rename() and cleared after
d_move.   A d_invalidate_reval() variant would check both for the
sampled d_seq and the dentry flag and if either indicates that the
dentry has been renamed after starting the revalidation or is in the
process of being renamed, then skip the invalidation.

Sending a patch (done with help from me pal Claude).

Thanks,
Miklos

