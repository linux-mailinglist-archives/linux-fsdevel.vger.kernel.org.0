Return-Path: <linux-fsdevel+bounces-72494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2D8CF87C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 14:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E77C23010CD5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A690E32F761;
	Tue,  6 Jan 2026 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mSdGiVoW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA4430B53D
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705250; cv=none; b=qRka4bNVkBL33jf9BUfiK+5kGb4iht6r9n8mfkg0yCCYYKS0RvnDXQqPt59JDojuxOoaL8P1gjdAbhXv9LWl20GGlNMENXCymMzln1AWCDl4SPIkhA4W/rHDwB+fElQ1qvkp1MyAeuuJI3YUWT5IZPEaPTVxfLmD96t/J3paG48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705250; c=relaxed/simple;
	bh=xhANzf8zPHqInwt7sqx1ceuLymDpjEml1Zk8b+gRlII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCkeFgJgotr+ntE1c+drjRHbfFBuw4dLFWUlcypW/fvGOQhhX+qTvvJw8FqD83RrqA63CIKO+JiqPntJOeg8bvs6AfMVeOUE+vwrYpS0y6GCQ3PGeOrYeljOAMpbjuW+hoTqhqrqN602wllZ7O7/WJexdpxa4jljEJiUqO030LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mSdGiVoW; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88a379ca088so10256806d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 05:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767705246; x=1768310046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OKoNVgafDUk8SCtl+9edMLUBCEIskB7+sjp4jDlq9us=;
        b=mSdGiVoWGQ8WVOy3pDHc//onwx0ZD7bPlESoG/mheZPPl6OvGXY00QG5zUeHHsUpoC
         ZkIM5i3kl+q/BmV/c2UxY5Hg6cYFZNfuGTW/jbw9jPoaiPzS+G2sevBXqVDL5InkW8Rm
         4KGZoK+Aan82oN0WywwdZT+sZFWKPgoiLzsTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767705246; x=1768310046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKoNVgafDUk8SCtl+9edMLUBCEIskB7+sjp4jDlq9us=;
        b=D4AI973QGSNYc9jUbfQpFPaM+wc4IN2n/dHdNee5Hw9LvNwYaqe/PCyPvKukqZyQmZ
         gbvUSzKzQfdc7Y1U9e3FmC+Qh8OGEzrObv1DU6kI1H/gTgnELNdNWfCLWF6PxEaHrPpk
         EOoBQQlxfETUXMJgR9illJD0KXrEpQI/w543pReNY+hEII5yZPQ4LnK4+5/MCGErRMLw
         2sxXYx0mj71s9bPB85IZEJts6GvS5ijci/Vu12vnlLzi3cfOmdjUhr8YKqRdW1TnQmAE
         7f9UZKuA18LRm+Fgs8Dj/GaozQrekEg+O5ewXEXjsRMZ9glSHJynTQts3T5mr2eTZR9l
         bJuA==
X-Forwarded-Encrypted: i=1; AJvYcCUp25ohSyOSK8PMPAgbIvbTukgHmFGaUelTrQ49gYnxt2WcAXibQSgrgjZstYfj1aHI7Heu7XkbzFAqHpFo@vger.kernel.org
X-Gm-Message-State: AOJu0YzMLtFcKo4HkObEWUK4RgzI5vQ9YT6xsCY2LYXS+HGs7gz8SudP
	nW6uDC203rV2kQS9CKd8Cu8XoK39GqOHn9dPFJGtGqKTmFL2R233MAin+IjC3GsIlFhJhcObV4f
	nK3pnJG8Z+8tqs05qSlQ9ZFKI+MBL/UDEyj/n8bkbiw==
X-Gm-Gg: AY/fxX4rv3veBl9SzZ+4jOp0csmpNGX65CUIsZ4U3omzUH/kjehl8CVM04E1pNiu/rZ
	dFJnl74QbMSta43RC+tTKUZKpz7YnTxTQqnxnkrMGO9Pzq/uZwqn8wQl8bEgr9kIleOlQxEgw/E
	bUabXwP2r/DJNTtFwgO3eCk0LXWDQdW3xPhsArutVfx258mch5IqNL9TAFrScqg+HFEpctyKjxJ
	o7TS4vZUtxm+4ILRrsaMW9/2lNpfj3bW2QdaGE5FQ+3yRgH4wPuhO241p4rjGofgQGGiQ==
X-Google-Smtp-Source: AGHT+IHW76vCaJhXrXtTlnreXmPXnBIYSekopXMOxH3fFuu6sJOI0CsMQDsWF0DT/SavMiCaskutPoC4R4PdrvU0vSc=
X-Received: by 2002:a05:6214:5786:b0:890:587b:207c with SMTP id
 6a1803df08f44-89075e43bfbmr38843306d6.12.1767705246435; Tue, 06 Jan 2026
 05:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org>
In-Reply-To: <616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 Jan 2026 14:13:55 +0100
X-Gm-Features: AQt7F2pvvv_dgMF5DVe6cpYkBdBWgiQKoSy1bex9EciACOPG1MjR_kzstwfJ66w
Message-ID: <CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 11:05, David Hildenbrand (Red Hat)
<david@kernel.org> wrote:

> > So I understand your patch fixes the regression with suspend blocking but I
> > don't have a high confidence we are not just starting a whack-a-mole game

Joanne did a thorough analysis, so I still have hope.  Missing a case
in such a complex thing is not unexpected.

> Yes, I think so, and I think it is [1] not even only limited to
> writeback [2].

You are referring to DoS against compaction?

It is a much more benign issue, since compaction will just skip locked
pages, AFAIU (wasn't always so:
https://lore.kernel.org/all/1288817005.4235.11393.camel@nimitz/).

Not saying it shouldn't be fixed, but it should be a separate discussion.

> To handle the bigger picture (I raised another problematic instance in
> [4]): I don't know how to handle that without properly fixing fuse. Fuse
> folks should really invest some time to solve this problem for good.

Fixing it generically in fuse would necessarily involve bringing back
some sort of temp buffer.  The performance penalty could be minimized,
but complexity is what really hurts.

Maybe doing whack-a-mole results in less mess overall :-/

> As a big temporary kernel hack, we could add a
> AS_ANY_WAITING_UTTERLY_BROKEN and simply refuse to wait for writeback
> directly inside folio_wait_writeback() -- not arbitrarily skipping it in
> callers -- and possibly other places (readahead, not sure). That would
> restore the old behavior.

No it wouldn't, since the old code had surrogate methods for waiting
on outstanding writes, which were called on fsync, etc.

Thanks,
Miklos

