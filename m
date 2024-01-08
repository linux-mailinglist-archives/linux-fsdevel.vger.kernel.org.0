Return-Path: <linux-fsdevel+bounces-7525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0398B826BAE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 11:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88224B20C31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D2814008;
	Mon,  8 Jan 2024 10:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3YGwpeK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9CE13FF5;
	Mon,  8 Jan 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a27733ae1dfso173027066b.3;
        Mon, 08 Jan 2024 02:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704710538; x=1705315338; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=essechqTIh3Wk2fuG/cG3+Uk9BkeUhmlNbyQ6iPF6cI=;
        b=c3YGwpeKGut91h93aGSs+ZvGxQlrWAB1NCZd8PkRAaqrP4gW8gVcPcSrIEcVFrqAcV
         C1HKccaXtmqZ9OSe7u146G6dGhU/2cv5yLSHbj9jfW7Ez3FchBYv6clsbXHxQLnP62U0
         7qDNKQHcFy+M6JvA7OaQY+LLiMo65/rmdie4oWLqIX6sPfghQmhS9+937aiXv5xQQKa6
         4XhcmD76Mzw0YSLtRFYr2IUMLLn48OKkdUcd5npi3DUvwff3dO1x8AtlCFHtGSa4tkBj
         jC+ZW27ehT+JxBSxlj8QrpFs2Yu+J5afaXTdC+BTq5RqVrEqhNt8TaKClLO41PdJ29aC
         +SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704710538; x=1705315338;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=essechqTIh3Wk2fuG/cG3+Uk9BkeUhmlNbyQ6iPF6cI=;
        b=BDxXnftlrGQKBKxlPo6gbeAnwlNh+5CtVF1oTbNfnzW8b6h2VbF4G9S/vH+Me6xHBm
         3bjX3w0csZTbJgzSLwsKceMJkiJyy0e6DJYI84D8oPg9LOT9v6U9YkQVaj7nLcE01tY+
         nKcDN6Bw6TlY9LoJZJcSzbj7wDmhklUrHYrLv+ysqnGTr96rPgQ2vTVgnJX9Kzf/VXpi
         vhoPn1UnE95OuZoZIMe5pumUFBCAYnE+KMUGkcr2N6Q2kK+O9s0Mey0ZNP2uCrd82Arr
         9Q4oNPesfnQyXmD5Kp/3DaVPqFjjarL6iRbz536ngzh6wWs4qjleNh+2ko5yK7xedI9Y
         q8Ww==
X-Gm-Message-State: AOJu0YxrvHPubleImX5MDqrkkcPygnASs1zlOZCZw4WXDrUgxN5xj4R3
	xa2vljezBYPzwbTyfd6X98Y+lfXOyjq5Xrc5nFDMlYlfuNk=
X-Google-Smtp-Source: AGHT+IGnMgm//ZiKhyWY0YJFgfLWiNpJQNS9XQBgM5UbdLL9WYsiKWBec3wJvI/svisC+jP2gfAUBQxKrHrh7Vq4AIg=
X-Received: by 2002:a17:907:9404:b0:a26:6e94:5812 with SMTP id
 dk4-20020a170907940400b00a266e945812mr1026756ejc.24.1704710537759; Mon, 08
 Jan 2024 02:42:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Mon, 8 Jan 2024 11:42:06 +0100
Message-ID: <CAKXUXMzXN=+hKDPP-RdHKELA_fGA6PcdCj5fXM32qh4Px0Hprg@mail.gmail.com>
Subject: Reference to non-existing CONFIG_NETFS_FSCACHE
To: David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear David,

I have seen that you have made some recent changes in netfs now
visible in linux-next.

In commit 62c3b7481b9a ("netfs: Provide a writepages implementation"),
you have added some code that is included under #ifdef
CONFIG_NETFS_FSCACHE, but if I read the code correctly, the actual
intended config here is called CONFIG_FSCACHE. As I am not 100% sure
and this code just appeared on linux-next, I thought I would just
write you a mail rather than sending a one-line RFC patch.


Best regards,

Lukas

