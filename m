Return-Path: <linux-fsdevel+bounces-52817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED4AE72B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 00:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A301A3A3BD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 22:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A42D25A625;
	Tue, 24 Jun 2025 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFVJ0BiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB44307496
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750805877; cv=none; b=gMSuJYlFBX1jkW5nOcEPy3BiH/RiQsRrbpDaMOpRvYnj7y0YRUi6BEDaU1nc6JbkuXpnfVdkUcgNpZEV7F52fZWCkpBpHgGwBNPDDDQFow08SeYlhiNeCiK657lgXMEE+xGmIbayoNNt6ONy+hA4HHy9ERA6Fpn0c+T4yrPQeDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750805877; c=relaxed/simple;
	bh=Bh9Gj+rkVHKw+/2AGLhkPqheXXbbWYLTzOb6GXkO5Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MpGqbSWVrksdMy0Nw14EbCMev8AHKQqKhh7DBvNn9ZQX0u0hl2i97EIGs5bhFSWTulMjqGyEeo9H5KMmbs5g0FBkqDe0yxNoU9oYu8If/wDnKutTMtwF2IW8TOE7gqywHq1O/wfeONiFQrN8WgfPoP//szCSg66a22wZE/EoH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFVJ0BiS; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a4312b4849so11185821cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750805875; x=1751410675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bh9Gj+rkVHKw+/2AGLhkPqheXXbbWYLTzOb6GXkO5Hw=;
        b=CFVJ0BiSIzkJgtFrIYiX8GZSOQX4eU7AwpPRbwSHKhMDvR0UNX+jxcoVSbZa1ooWeY
         DeSTEUAtVgpiAxVqcmJYS8RZDUQuPZvH0BrFUYGZgXKOVSnhJIhPGg6zW00HcU7vJqnL
         DqN9sryUHaScHhRvx0lu9ktm8rtSGuujxiw2ZZuC/I2wM/0wcdAfAsOn0WA2PR4n7wWH
         gmExK/spFzKUTI4+CnxDBMKlKqwS+kgbmk0JGKgyC19D1GFkJC2TFGXpo9uEvnpDY9N7
         iqrXO+iSmHcqPL7J9KyQXwmUMDWpc+ImwdLEX7ZRUC8JBi9LQZuCoPmnNCE+JqM0A7Lm
         wCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750805875; x=1751410675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bh9Gj+rkVHKw+/2AGLhkPqheXXbbWYLTzOb6GXkO5Hw=;
        b=sDpr6PhP3zW5/MStapAT51KxhQY1msVd47JX2vImbTmyvmc5d/9ee1mt4BgMq8oXea
         NjwHbvGHu+WafZTx55eZAJWL59KONve4LLwUSyrythcwDi4Ua00kUssuLKcHope8lRCj
         YHmWK58nLEvt+Ax2o9bu+vcZ/QOCBBf6UeuWM8YVecxUYVTl3DHnNCSwaQviuE4JXyg5
         6mTzD6dbmR8b8Xlkj27OBB503CuSh17bBze664ahQKynetxAiS9AHkn8C1LcyOd3LFab
         gks9AEl2MA7p1RCZm006n4a548pdWFlo8DcaxXCvijqV5MaEsambnhE4jLwYvBdw+DJG
         rE5g==
X-Forwarded-Encrypted: i=1; AJvYcCW6XlI451WPgKeEBAFKMe4Oiv3l4NMhJie+bL4Fr2I/RM8D2U6USXCmnoZY/ZOLpRny20SRg/C9l+Pl/4Na@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxsFtQaSmG2qCPwCfvWNamCZE+P6mLoCbL9jeq6w2WJ2/0WCf
	GMltun3OzfHJDSZzqNr8+6r921uRUMxqqg0bsNvYwy/6ud6xOWLw+SuZ0A4BsCfhOUMS7e2OueA
	TSvKlPKAh9WjNjr8JQIDR2QWybk8sDrc=
X-Gm-Gg: ASbGncvJ/F3L7sc1v8LBs5SCafmz9MkxIu/oQrk6Ln2REkfKfxpuw8NiRfyKW10VIxA
	ED4ieb+wOV0/iDaFkYlxzOa49JJAEr1MSaCNfwkThLreqBOSlZ0l8TWkSvwhqD05Kv10gKXYuXm
	OoQkNpF0y0861LEZhM5Mnslm1/7H2cuuOfoJPbVRzlaDcd2iwYNt+jpGkCifnJqtwV8/aXNA==
X-Google-Smtp-Source: AGHT+IFYVYk7xMkuLCHQebdA/JGCLbzKnbBGqaVK/qJIIQZlTqMzgvwK5DjjUSmAwEsoQxZexXN3yKHTe2uDbqa/x40=
X-Received: by 2002:a05:622a:18a7:b0:4a7:bf73:c5fb with SMTP id
 d75a77b69052e-4a7c06da56fmr17644351cf.22.1750805874993; Tue, 24 Jun 2025
 15:57:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250614000114.910380-1-joannelkoong@gmail.com>
 <aE1VvnDfZj0oJMMv@bfoster> <CAJnrk1aUqLeas5n4qo7VpVn-+tgRZfBTSyhFR95TxXOzMDjKVA@mail.gmail.com>
 <20250624-damen-abtauchen-c73cdf291eef@brauner>
In-Reply-To: <20250624-damen-abtauchen-c73cdf291eef@brauner>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Jun 2025 15:57:44 -0700
X-Gm-Features: AX0GCFv1RDFJmwwnAP5GX6ZYMQNcA4mEbw5RfgOQYpLavQCgX-Edo_ySlffW1es
Message-ID: <CAJnrk1b=-iLNm24Mjnurun_gGE0i3dqypJOAQVC3Scmcta1FqA@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix fuse_fill_write_pages() upper bound calculation
To: Christian Brauner <brauner@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 2:07=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > Miklos or Christian, could this fix be added to the next release candid=
ate?
>
> Snatched.

Thanks, Christian.

