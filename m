Return-Path: <linux-fsdevel+bounces-16937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9258A52E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 16:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A24C1F214E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7421574E37;
	Mon, 15 Apr 2024 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GxYCA+wE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA1674BE8
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190691; cv=none; b=I4M+KLSwyh656NPvs28+nq61x1WTQEg9PHMzSLcvZoTApXpyWo4/xhf/RjspWySnqYoVYGupUHKPG9jBVMKPEuzYjxL7OLUyzXjZrhZANnaFWBFgMDSHusJFxYcyPb6xaw4wgOX4LS0l8h0y76SANWQZUoHdh/b2dZbkoI0aI0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190691; c=relaxed/simple;
	bh=s7Xj9xi+J3VOaPxS9cliZyr2iTz57B5HKKp5IrSvKlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIfubMDxIEeDZws+24B/5ofbmt/ItEZqChkxLP3g+qZ8zy4JeHcNqkqRcC4sYxfYSQsVWO4Wta/0/0t//58IMna9HHLtxSJ6D49MJVwWV563519H8/tehM9hC48E/0XfnTb1StU+PQPFSWts4sTpmyy6PwHHRCVLGYn7KCr8BKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GxYCA+wE; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6157c30fbc9so32213437b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1713190688; x=1713795488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqqqjCa8OZ82zdxbWAvkpK8zvR3ppQ2NndSIF2x4rXo=;
        b=GxYCA+wEVdEIjjWzJWYg+WtDHHIliDSd8tKsr7BV7/MNn1GAfzIGGsjaYd1K1nC47x
         vSDYX4sAGl3dWOguqWAOzQsiR3l2a5GCXoMgNM60CbTbnQU4DYOtkdtqEGzpNJ1M0YZG
         uQw5KNJcmYoJdcaPUXYHVNp3fe+w7CGUJ/SPJ96v3rXFwkPh6f3QXK91XZOF32M12JQC
         Ji8q8ysobl0MyXu0MqYf8ztHm+RuXlZSrC84cqaRtpeht1x8CxcwMPIAYXaT4Z+hGC7+
         rVG2YJ4JyNKKpzlG7HNhuL8+NZugo/5Ayugwl9nKzsB0LSuLDrRKrkXS0JcMorbjGX6N
         OF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190688; x=1713795488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqqqjCa8OZ82zdxbWAvkpK8zvR3ppQ2NndSIF2x4rXo=;
        b=LprwbKtP3oBhfvvbubOH7WCsbXMBkNcuUrm7hLAvm8zGpT2Jwmlintr9cE1YlEpQc8
         wB6HFVUiDYdnAy/Ks32K9BiAI4VXnTMJ4W3ovDCCCQc1mEPsThNyx/mVtnWqQU1k6ZaR
         rqfIhwml4dgHQwSxJ65sZGulnUjwgPiH9L2COv1t8puxmA+Qy1bTISbd04DftnYBvheY
         YGabglc7zdPfQVl3J5HM6553D8g8N4mWQX9gSEI/eYntxg4AYkiX4RXPullQyuviZkVV
         q8prNcavt9FCV2gAks797feaJSl62K+H5IUayTnGgix3MIY/sgYb85OWHXJWnFwMkHuu
         AyGg==
X-Forwarded-Encrypted: i=1; AJvYcCXLnBaNK0lI1afUYbPnzpByfe8ox8GVe0apQY2A1/wv9acDL9orWk8JWAw451m7FuJss8r5WLunFOnFwsSLb2HLsw6LY0YZP5XLs/E3vA==
X-Gm-Message-State: AOJu0YzBvk2w5iqZgCktSsoA0InpWLEGH44eNctrY7apwuJWjZfDBgqZ
	IhE9H+Fpsaa76LG2ymZrjS2EvZdDPVASvn3Zt2+NEbyoA8ocCexpb4l4HnyV5y1yxIn8C/CaLJU
	SAGjYLHsAAXuTJRA4qrRQMiUxZeo7HD8xfyZS
X-Google-Smtp-Source: AGHT+IFLkqpounEUU/2bE6dJh6q9whX/HjDtCGadHGTvaVHifyPAFZys4Iq+yJ+GbVJMCc2FKsEdAoulZVngTb0CJTg=
X-Received: by 2002:a0d:eb02:0:b0:615:3996:5c86 with SMTP id
 u2-20020a0deb02000000b0061539965c86mr9873358ywe.21.1713190688256; Mon, 15 Apr
 2024 07:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328-jag-sysctl_remset_misc-v1-0-47c1463b3af2@samsung.com>
 <CGME20240328155911eucas1p23472e0c6505ca73df5c76fe019fdd483@eucas1p2.samsung.com>
 <20240328-jag-sysctl_remset_misc-v1-2-47c1463b3af2@samsung.com> <20240415134406.5l6ygkl55yvioxgs@joelS2.panther.com>
In-Reply-To: <20240415134406.5l6ygkl55yvioxgs@joelS2.panther.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Apr 2024 10:17:57 -0400
Message-ID: <CAHC9VhTE+85xLytWD8LYrmdV8xcXdi-Tygy5fVvokaLCfk9bUQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] security: Remove the now superfluous sentinel element
 from ctl_table array
To: Joel Granados <j.granados@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Muchun Song <muchun.song@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Luis Chamberlain <mcgrof@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, 
	io-uring@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:44=E2=80=AFAM Joel Granados <j.granados@samsung.c=
om> wrote:
>
> Hey
>
> This is the only patch that I have not seen added to the next tree.
> I'll put this in the sysctl-next
> https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=
=3Dsysctl-next
> for testing. Please let me know if It is lined up to be upstream through
> another path.

I was hoping to see some ACKs from the associated LSM maintainers, but
it's minor enough I'll go ahead and pull it into the lsm/dev tree this
week.  I'll send a note later when I do the merge.

--=20
paul-moore.com

