Return-Path: <linux-fsdevel+bounces-57593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2560B23C00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 00:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3115812B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F327E077;
	Tue, 12 Aug 2025 22:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbYXOr36"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C62F0685
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755038849; cv=none; b=hN0xBWwRNADp0G+0kctK3JfGlE6hh1WJyHlkdNGzx07AKJg8dghOFaee9xDEVksOILxqEQFl+0yYKj0X8FxrUH7ot++hI5HXpthddqdObCLvQHs3l6WIe1uUio5vNTzkATpQJMAM6/MIepqGEKqba8b+bvyQo0a64LZz5tCWHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755038849; c=relaxed/simple;
	bh=z80Ce4qwQmqdD70AXLu0v9WHK75cVzVlZL48TooJBbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc20iXVVZ1+Fk6uHP6g1fM4k2/VSLUEB2iEEJYkUn99busVp/zDPw7p1fxnAB3NQx8vIyIYycsJbJTuQdSSO0RSRfDRCSQe/X4SYXx/seIkxqf7cNu02gnSEruHXzcxDgD6sspALhn4Z30pmW1jHDVutJtJvToS84mO+W2MJkys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbYXOr36; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4af2019af5aso68488051cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755038847; x=1755643647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z80Ce4qwQmqdD70AXLu0v9WHK75cVzVlZL48TooJBbU=;
        b=UbYXOr362OYhog4wXdx+vZArSrvWeXtkRLLUyDwHLYP4kyOutFI/8mGz7xHUgTr/09
         H5oZniMYiFlDIGFZEu/jNWEHUiA5J8rPXt7M+hYdvkq2j/YdJiOwyRrVAH+rwrbjKWAH
         Hf4h3CupxDjuVUoXeXJkPY2P7PoEfHZj3OQNy7AxDafOUjlD//Q0zoQSasVzvUFLoLMV
         Rp+4zVbJKk3L9fQSLPqft9tn5W3jaqZvUYgjH74UKjvA93trGzZWQzMWA2bSuMJhL1ta
         b/oM9ZL+dFazJe06eq/P0wJCT21fX04V44cxGcmO2wqhQTx+omhnbjiMeQsfKUmlkIqo
         o9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755038847; x=1755643647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z80Ce4qwQmqdD70AXLu0v9WHK75cVzVlZL48TooJBbU=;
        b=WNaeIBVRlwK3pRnHe7WBOIlFbL95t8rtmQabHWP68S5dP9TA5ToGfqzqpr++/De0oU
         0zRgsn4lw56k3z0/dW59oZeTDUKuci1CFZPBjc5VO/fS1KVAlBHq+/tAy2flSLhudzwj
         HQRAI+tNN7f1J7d7ve3MOOXhtwWilaPQJJpuhVm4jOGEQch/qzXHXv0ulG0+dAGn1lgG
         8MDVwnNeCnF8mTzvqqCBsfV5ttLJm4WWiUe4S/Wi7iiElDCY1B/el7Yhv8IqIyqTVc8O
         WL/4b2bdwCYNU7QbcMMOUj+4D/ib/aw7VKRhfcWq5GrpBh+Xi3QV/Qhv8lQVlQr9ccHT
         Cn/w==
X-Forwarded-Encrypted: i=1; AJvYcCUmEp+PwQtiIsLnDEA9FtZko2UYlso0TM31cqmZZ+5zCkNbQ9m3jmSitzSORq1YDslMgE9AWJBl9SzI/QZr@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5GbO2eWQjbkR+CGxYnyWJGCna8cAffFmanJUleKMux4dvAxQs
	K+o+8fRZ+mfGLeSTGc2qw/pa2ktyXrhPAY7VBKsgy01B4U0jlO+P0n629MGr6hy9D5i++h1a+Ng
	8H7ycTxAC9nQnyp8qLpECykw3uub91ao=
X-Gm-Gg: ASbGncvRiedwbcM3BN+nk73d+U48C06u++ux2oIw8XNT0j0jLJLwshASWQ8+s50qnYr
	kQFN3umV/dwrJX7AbbZfPlz0lXh3sngcXC7qtVjOXOkIZGyXgc67XpQnlQz7/OEHOrl94vtW3uP
	Yy2xJUIBTR62nIL18I+HOpqkpcTyua4y9CEbEVn+VuPw1Z1p+xSiGZMaGBCUEvMKGXRuh5/WYr9
	Uc+X0HwWS21VX5pt6Q=
X-Google-Smtp-Source: AGHT+IFSbwqbwJbqWUWnnrUsmCnbhK1s5FH+xgvtTM02etvvi3eCYlyzmpHtRJ/vcDLYFCtunyIiGEgkZXGjhvTzByk=
X-Received: by 2002:ac8:6909:0:b0:4b0:74ac:db35 with SMTP id
 d75a77b69052e-4b0fc7135d8mr13745961cf.12.1755038846792; Tue, 12 Aug 2025
 15:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812014623.2408476-1-joannelkoong@gmail.com>
In-Reply-To: <20250812014623.2408476-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 Aug 2025 15:47:16 -0700
X-Gm-Features: Ac12FXxl118n1toG1Y34RUfULIQ5BqtXPgNlRM3Bqc0gLULyakY5P5qtAqIWC5s
Message-ID: <CAJnrk1ZYZmr4yne25WV7LjOTptb2OTarZ23Tf7gfZUk4aSwppA@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix fuseblk i_blkbits for iomap partial writes
To: brauner@kernel.org
Cc: miklos@szeredi.hu, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:49=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On regular fuse filesystems, i_blkbits is set to PAGE_SHIFT which means
> any iomap partial writes will mark the entire folio as uptodate. However
> fuseblk filesystems work differently and allow the blocksize to be less
> than the page size. As such, this may lead to data corruption if fuseblk
> sets its blocksize to less than the page size, uses the writeback cache,
> and does a partial write, then a read and the read happens before the
> write has undergone writeback, since the folio will not be marked
> uptodate from the partial write so the read will read in the entire
> folio from disk, which will overwrite the partial write.
>
> The long-term solution for this, which will also be needed for fuse to
> enable large folios with the writeback cache on, is to have fuse also
> use iomap for folio reads, but until that is done, the cleanest
> workaround is to use the page size for fuseblk's internal kernel
> blksize/blkbits values while maintaining current behavior for stat().
>
> This was verified using ntfs-3g:
> $ sudo mkfs.ntfs -f -c 512 /dev/vdd1
> $ sudo ntfs-3g /dev/vdd1 ~/fuseblk
> $ stat ~/fuseblk/hi.txt
> IO Block: 512
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Fixes: a4c9ab1d4975 ("fuse: use iomap for buffered writes")

Please ignore this version of the patch. This is superseded by the
newer version here:
https://lore.kernel.org/linux-fsdevel/20250812214614.2674485-1-joannelkoong=
@gmail.com/T/#t

Thanks,
Joanne

