Return-Path: <linux-fsdevel+bounces-31244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D299935C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3B1284861
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538E41DDC16;
	Mon,  7 Oct 2024 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ysoc/eeN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284E1DB349
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324778; cv=none; b=I/CQ29OzEU3hTdokSFzGbSM/rHDmvqY++fjcJT4w+YkJT8SZtxEDc/Tlhf+6iJlsaA4vlZqHI2YHZpAoJVBpqg9NlJ4E+YO1GqXfK26IyPLrKBsFDBQdUHWJRq2ts/tAabJp9sB+/1asQZPM/Tn0wHkGyB05JSTmUYobraBvfSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324778; c=relaxed/simple;
	bh=qPpfVtqAS2L1ezaV4Z0UzixAZyRPmq4QOJs33vi0Gac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rd7SzfQHe3++AcSPmB/jDz9NrO42eWvbLW0LKXBtWghFhNz29Kdy3K2juFEQ0TssFWf/zDJKcTrXVYOBD8SkdupeUyIF1ros31VcO5GSsdCq1ssLxMctFnUCBHk+uOfMamFviJQZKGW4py3g+J+l4CPuwo90L0L8E1aGwpYtD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ysoc/eeN; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fac60ab585so49615441fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728324775; x=1728929575; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LVNysWYUY4jZQfEOdfDhYGKNKb56ic6Qv43E6kWBbsI=;
        b=Ysoc/eeNFIxg50SLKuxu819PBZjqSu5AM2PSNBIHJhTSKvIL1HIwcm2fOz7Uw6Isk9
         huvwjaIpw9XHl0ecvM3c8Q2hJr2+xG2A2rm3iI9z808Byojz8A1wdL+HQSAZEg2vDj6I
         xnhVOmPPnzJl2tvE/nHtgtbHmD8bgRBr6hhcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728324775; x=1728929575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVNysWYUY4jZQfEOdfDhYGKNKb56ic6Qv43E6kWBbsI=;
        b=Mq2YdaUcTaVA9oW52Q2OR/feK3BwItYtJH7gzwuu4/Cz9issFtyXLPNva9fgdoRvat
         lKt4EQKnlic7OYOn8srgRb1FKWhPG+h1JK1YF0dKQVYZpz7CwNCgM3ss17l3kjvWaFWk
         0m8SQafd2BTc6eAvWei8MVNbu3MktTtTtJ9a/xf/I7jlDc1HVfGPttpaY9jBq4DsUcWg
         0G1d5dxpCi/K7vseavD0yZqpJBWUVsEDwV5rlEm4z10SsI5nWp7aSmvglvkKrnDPTPl3
         GL9zPbGNN7hbrwX1DaJxve1SZI1teUj/iDjQf/c7L9Muzy8BU0kT8IiM7rYu0Vxa6k4d
         4IPA==
X-Gm-Message-State: AOJu0YzrDGiHA5MhdBAzHzP74Ug7EaOy43WB57SsLFlPm0SCoJ7m35Re
	GFXUMsIsPxc/Me12aWYIjke2wqlyZrTMCvn/8wxY0YL8D1F55UrgDjWIci5ccPNZWzVuJDpDlrA
	jlAnvjQ==
X-Google-Smtp-Source: AGHT+IFLp0wtSCDArnoPWTblB1boLdaE7oEQcEazgO+YKHWN6r3Lqx+Q8rNbB5k/Cchx0iSeKd6nkw==
X-Received: by 2002:a2e:a985:0:b0:2f5:806:5cee with SMTP id 38308e7fff4ca-2faf3c5f7c9mr63675491fa.11.1728324774876;
        Mon, 07 Oct 2024 11:12:54 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05eb5f8sm3381148a12.60.2024.10.07.11.12.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 11:12:54 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9957588566so169562766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:12:53 -0700 (PDT)
X-Received: by 2002:a17:907:6ea6:b0:a99:3a81:190e with SMTP id
 a640c23a62f3a-a993a811a16mr921852366b.36.1728324773394; Mon, 07 Oct 2024
 11:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240822002012.GM504335@ZenIV> <20241007173912.GR4017910@ZenIV>
In-Reply-To: <20241007173912.GR4017910@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Oct 2024 11:12:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8XriUt2mJTJaHBTTufUJzunYG45R_i3ZVw71r+wfcYg@mail.gmail.com>
Message-ID: <CAHk-=wh8XriUt2mJTJaHBTTufUJzunYG45R_i3ZVw71r+wfcYg@mail.gmail.com>
Subject: Re: [PATCHES] fdtable series v3
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 10:39, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Changes since v2:
>         Rebased to 6.12-rc2, now that close_range() fix got into
> mainline.  No more than that so far (there will be followup
> cleanups, but for now I just want it posted and in -next).

Looks all sane to me, the patches look clean, and removing over a
hundred lines certainly is an improvement.

                     Linus

