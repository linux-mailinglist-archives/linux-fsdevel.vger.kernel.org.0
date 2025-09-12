Return-Path: <linux-fsdevel+bounces-61112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B91DB554A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 18:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4917C7ABAC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F59331AF3F;
	Fri, 12 Sep 2025 16:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDuJXpnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983528DC4
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 16:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757694496; cv=none; b=CQ3msn84cW1d7l7B8PSZlKX5xmHBwPeulMHHlrvsWTU0FidatQ/dHAbRHM22f8Ob3gRFb7lIhzPwyzbmWf/HsW9+G0rWN605JOQrAhD9Z5eYeWT5bJMJhOa8nKX/C4RD2mGJyg0+1odyI0CEmGrb+LUauzPhQ+Wk8RUqK8mbFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757694496; c=relaxed/simple;
	bh=4ZQds+rLQqXKtrUuxNGp9y/Vi70dhfBppH9lnk7gdCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1cOCLXjtt11IJCy6GWXSvelGtaJ3e28pJDgVw7l5g69LuhoZ0aBW9XYAEO5Fs7RIHG9aSGX+IDc2Gh6iBit3omtjYoyqSkAYL0CvkjI8mWpn595Pbk1nlAMAtlAFiyNnyrjX4yFn/5NJc/KHbfbgun8W9D7wqaWr9JdpGQJTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDuJXpnn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b3415bfb26so16284211cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 09:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757694494; x=1758299294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZQds+rLQqXKtrUuxNGp9y/Vi70dhfBppH9lnk7gdCA=;
        b=fDuJXpnnzZBgy62qA/zbs9nS//r+43P1NYWcv/V/VdowLoQ0o+SChONYShoeUoHeFG
         ygtVQvDW3+mH6sVgUEN8Im4BNY6c7xRwDyz5wC77cSNb3is9JD99KRJAAkhxJTLNF5Fr
         e7gdM4MIJh2Xt/1LSL2v8fOyDPSDq2GwTCpQ19ehQlD/Um2NGuPcd7i5JjsimIhAnJd8
         5eqNOK4/HMp1CoRFSw7gzvJM5tz/vHuwA2gwF59L+TcS4P7q/2o57vgpUaTndAuv3aIP
         /CA/+3Sfyf8Tr6xR2O4tuqrPzrA6gRJkJZyjTL5B1G72SweM9EOiV5N2UYr+PGo9xveV
         bSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757694494; x=1758299294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZQds+rLQqXKtrUuxNGp9y/Vi70dhfBppH9lnk7gdCA=;
        b=gTFNIrBjKNUQEodvpV3h2CW3c32HCzrFiVAtISXcO/2P/wG3+g9+TyDngvsBf4wNeZ
         eoES9lajoVKuFrqTtgQbAEj4tOqRDmZKemEXwYd/UFzBlAkWrS86TXMV7uC1597w26wz
         /lZQ8kG4tk4ns2TvFvmYTKbKtz2qxOvZUStkKDqF6T355ap7/XGwywzJpTtQRP4F+Jv5
         vdSvoy/tDvSLYAq0rhHI5Z5VdEW5zdvNVJ4dsn1ToQnBidnyoWPSn0SC7ZYWgwyuI0Wi
         ZfPZ9yReEJPjeDvNf2+4NTF1BiRSkPrjy6VI89U0jchskXrHXZf0nQ+o0PfLOxmodj8/
         zfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbqB36ofaevLsb2bVw8bIhoWOAphwSBNc/rfA9hxwMkID/ep+Jm6ear1Sopae7UivuYlBwjDOrXRhT5lT/@vger.kernel.org
X-Gm-Message-State: AOJu0YydChJuvc3be7Frv37vdT0Pjx07Yauf14y1aB9syYUWUkQR0PJ8
	t9rMPwpyg5a93yAs4k4bP6EZszPB2QLLHOLvmX6zrH8sGBJMniGXlV2iRsHNOjQHcrgPP76BCcl
	i3P4GYw7W1RudMRAU3wM5QCKro54iWbo=
X-Gm-Gg: ASbGncvQ9zC3sZbBrDHQ7yHYBfq4dtwleSJM7xRUldw9XxXg5zskl3abERJaf6iemLi
	mmuNfUhhPSExmyvWCXJrUdxp+h0HiPN0ypQsttsdodaaz3yZlUBRqXlEw5JNxHFinQwywxVW6Ni
	23L2kEmC86Wj3MUp2sBxMkkFv5EaOq950lzG1sJ5B9dAShulPCgyG66ml8qcBoe3ypHXhqA3tIW
	Pyhpp4mQrbjVcIyBGqPK65dKHMtG9EQZ4c5h1GD5Y77FdCY/7g8spuXZWd7i5E=
X-Google-Smtp-Source: AGHT+IH3sgRSs+dcbMoU7VA9j2cW53LQyv/IZLN7O9xGcrcKIirLDxNle7DY6XecZsiCSB6AFLxXPVP6mp6QV78ZXRU=
X-Received: by 2002:a05:622a:1c09:b0:4b5:b28e:f0ee with SMTP id
 d75a77b69052e-4b77d035872mr40986501cf.51.1757694493815; Fri, 12 Sep 2025
 09:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-6-joannelkoong@gmail.com> <aMKuxZq_MK4KWgRc@infradead.org>
In-Reply-To: <aMKuxZq_MK4KWgRc@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 12:28:02 -0400
X-Gm-Features: Ac12FXxFDjN5YQNfv2vrM4ZDEgMv6WgrZBCDj2pFB-Fs02NqF_4tIokmTzA_qak
Message-ID: <CAJnrk1b8+ojpK3Zr18jGkUxEo9SiFw8NgDCO9crg8jDavBS3ag@mail.gmail.com>
Subject: Re: [PATCH v2 05/16] iomap: propagate iomap_read_folio() error to caller
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:13=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 08, 2025 at 11:51:11AM -0700, Joanne Koong wrote:
> > Propagate any error encountered in iomap_read_folio() back up to its
> > caller (otherwise a default -EIO will be passed up by
> > filemap_read_folio() to callers). This is standard behavior for how
> > other filesystems handle their ->read_folio() errors as well.
> >
> > Remove the out of date comment about setting the folio error flag.
> > Folio error flags were removed in commit 1f56eedf7ff7 ("iomap:
> > Remove calls to set and clear folio error flag").
>
> As mentioned last time I actually think this is a bad idea, and the most
> common helpers (mpage_read_folio and block_read_full_folio) will not
> return and error here.
>
>

I'll drop this. I interpreted Matthew's comment to mean the error
return isn't useful for ->readahead but is for ->read_folio.

If iomap_read_folio() doesn't do error returns and always just returns
0, then maybe we should just make it `void iomap_read_folio(...)`
instead of `int iomap_read_folio(...)` then.

Thanks,
Joanne

