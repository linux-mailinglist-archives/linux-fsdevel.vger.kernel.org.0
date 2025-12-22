Return-Path: <linux-fsdevel+bounces-71813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38138CD4945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 03:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C6203006A93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 02:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0317F2FF652;
	Mon, 22 Dec 2025 02:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fB4U4fR/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE2259C92
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766371737; cv=pass; b=o5SU/BRY7rdlcXoGmdZduMX5YSehy2Wact+srJcNQ/RtPHUuAH5dHcQT5LDA6nzVaxrOpUZO7+QRWwzl6aZIGw/knDB/xlxnEqbMPzGx2dm+nwRatomnhUQ5aQMWuzhB8QIPBxnQGPIFLz5EXmH/X7UalJ1c3mdleb2eRsKvDUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766371737; c=relaxed/simple;
	bh=0m+pcDn1Y4QSRuAPXVBQkxrWftTQwI+SMqc6yp0+T+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQ+HxZI/ccO5tqAPwPtT7Vp/W9u2xv4cWmx/DgydQGkShxEE7Ff2Ao3BpkDum9W7Ixiq/VNaha1fOn6BTBzWyMxl5GuhqfyCCzZH7gmdQlPS+XXMV9EqgMYpRJzuyxn3g/QIjbboKWBLJ7QPZjg6lzrwwAjQA16PwBPwmeKJWak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fB4U4fR/; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64baa44df99so16158a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Dec 2025 18:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766371734; cv=none;
        d=google.com; s=arc-20240605;
        b=IqdsGaHzN+WNM9v6b1IMmeiU0lmvCY9rIAq2O88HwhTxEM3mw3VN4asVzgj0Q9mXrt
         af1NuCNbY2/wk/VR1OU87/cqNLCxU0h69jOPlAl5xt6yOL8DzX1cNtORIgXan7O4tYLY
         3F89K131tvIyg18OestEoQkx+ljbqnN7SKk0oBd8dXcZuAcxcS8PQKHN/OS+mX6tPJDg
         s9fJ0374lGcHa0pR5Q+RiA2UUWBk2iVe/PDSBqMxqEt293NCbhEma/Y2tOVycZ+xJ/F6
         QDFpKjm5fn9nRxhmsbQileKNwuFhkB7W8S9sbSrlEL4GtYSNyOx34AAYarqibwIKZRhl
         vJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CwSTfOK2PQKjAWo+5ivUdXM7DoFjB7pfUDLS+oPx57g=;
        fh=ZTsNDWxS1BY8SVba889UOyNZoJEm0ZCuZDfJwJBG5z4=;
        b=ThDlzijBOCyDYAxWkpjhp8Up+BdltPFnUoDXgNtxTlLfi7t8JcsIrkSYGRxQ/1llY/
         TQlo/8iGtp34Vcqc6AyW6yuF97Kze1bGGJIHgzNxyBU3KFDX5PhaQ1Cu/7f41x7z+Esh
         +0ao/0qiSkb9cTcy4jEsWuiNVokvluAz1ZaKXddmmdtFJDb0Nwd9pD6x+0P6EbxylwzW
         eFxWB/ZtlJ5Yqw7QRvs6osnuqswCYhS8vkWPPsm3zB94QBQZGhlDbIuYVcICy1/6bwAr
         NyZFISWnE5gLLBvyFqtbzvzkDXICbSypuYh0HPgGmbn4/nh8R2sE95/C+V5DN+Fh3ZaZ
         olrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766371734; x=1766976534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwSTfOK2PQKjAWo+5ivUdXM7DoFjB7pfUDLS+oPx57g=;
        b=fB4U4fR/rmslyoD1cwKryzwn8Jl3yXNzLGnE8KMKwiyqdOwflkfsfKdXxUSzD4nM/d
         2yAu+5wgiQzuE4vQl683XnjHsMbclI02ALWvxo5mBmpjN1Nz/4Ip08j9/HaDLSMnjHZU
         J26SYXmvycWhmY50bUr1udHD05aegPgYefrNvNsFiek5uPSX2W7lXaLqhEhjFkQdVKEF
         Cu5je2tjqZxiYFSx9MAPgZ5LRHkiWdlOQlqHi+EG3u516hZcDt3MKaPUg6IjPnIML6pb
         Mt9HWsHzGynqXBXWIwyhbm6n+bhLQxCz2Kl+hv66DYLmNFpTY58g2Ve6Sg6vWrz3s06A
         Fojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766371734; x=1766976534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CwSTfOK2PQKjAWo+5ivUdXM7DoFjB7pfUDLS+oPx57g=;
        b=s6PvRqmmknwZh6fipnpKuTtl9qVkVX2kzuxl5hZWqS6kEzK54uR2p9diPWZPUHa6eZ
         u0PWdNWsmdkv8JudT2x9Xt0TCNG3LsN1I6wTIw3Id9vCh3lnJeOVpeUHCFL6kE5InVdN
         v1Kbem3w+dxFR/+EKu0JHX1GTuqB5ig03hd0Cr3QD8Stg0O03od2ME5zmQnNjO/5go4Z
         7KNvdKWbDxnt6B3tm4GNM8u1EHiFY2AF5ErWTfz+dEHIpqDQPd5ejWS80iQlBkwiqG5/
         aowkGFv35XK5P04AHlxYfmw1VH8JfVZ/7kWvY9zT0CD1LsH8VkVYXH7cbrV5VT2LsPxl
         2qPA==
X-Forwarded-Encrypted: i=1; AJvYcCW2g8RDeFA2JVoJE9n7w4jUdR54jVnFvvd/zxFKwSVlWgliGvWLnPt1s8pu9Zzhk1q5v9brKK26mAiapCo6@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7ryWudzmE46HxYXtlNSqxDJUXyeXCbSkx4MKDRSypB9IHifx
	cetN4D6E6mQJC5m86TqUkl8RC5FRRdE2+ZonwG1dtafwxgRsoJyZCv8iKXukEFHyB/jGkj1Ojau
	WnlkQ8M1foRaYegAdALhE9rq0ru0h6UaIYEQvdJsZ
X-Gm-Gg: AY/fxX5d/kTFoqMMTLY3thU7qqV1yWMqg0Bs3O9nNIGXi3Trq5bbKLHn+SN0++pcgIy
	RWctoD+Y7YEf71NyOEFoo7rFgZmMITmHMrPubj/ddStv1LJ3nwUnK0gJOkOXvLrrKHRJgvg7f6e
	3SHCCX5zqAfR2FE9DPWxrdEhzMMRD2M/ZUVmayRhs4NSusWXywmh7yyy/aLRER0TjKQ8tQR/Okb
	BRqeW1aPW0p6WZbtntTsJC6q8mK/XvmkLMW3GK6eEmI4aHDr4x1gnjeOD0dXKkORPRPf/Y5Qoi1
	M9FT+CNIBE1JgXxI56uxmSX7Du7W9r+QU0He
X-Google-Smtp-Source: AGHT+IGICnv+CNulcBUQj4EVMqHrV4XCI9DVrr3ZNtTi17PvRnxG9nGncqdET6iqs+YBkatoM7bhDOnN+T+cZex2OlM=
X-Received: by 2002:a05:6402:1753:b0:643:6984:cee9 with SMTP id
 4fb4d7f45d1cf-64d065c43f6mr35946a12.12.1766371733804; Sun, 21 Dec 2025
 18:48:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218071717.2573035-1-joannechien@google.com>
 <aUOuMmZnw3tij2nj@infradead.org> <CACQK4XDtWzoco7WgmF81dEYpF1rP3s+3AjemPL40ysojMztOtQ@mail.gmail.com>
 <aUTi5KPgn1fqezel@infradead.org> <CACQK4XCmq2_nSJA7jLz+TWiTgyZpVwnZZmG-NbNOkB2JjrCSeA@mail.gmail.com>
 <aUUymqMO4RfK8thK@infradead.org>
In-Reply-To: <aUUymqMO4RfK8thK@infradead.org>
From: Joanne Chang <joannechien@google.com>
Date: Mon, 22 Dec 2025 10:48:37 +0800
X-Gm-Features: AQt7F2p6Hjd_Nc7T5OEAyJgKQ5pr8sxJsosqYLA4O1HbB9YpKCqF7Pm762ItbGg
Message-ID: <CACQK4XAyDLfOcPWpRzKd+VXA5EtvzVNkxrZC9hjNJjx0uHx=Tg@mail.gmail.com>
Subject: Re: [PATCH v1] generic/735: disable for f2fs
To: Christoph Hellwig <hch@infradead.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org, 
	Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 7:10=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
> Well, for the file size you can test by doing a truncate to the expected
> size and _notrun if not supported.  I can't really think of a way that
> easy to directly check for the number of supported blocks.

I guess we can calculate the block limit by _get_max_file_size() /
block_size. However, I am concerned whether this method might mask a
regression that reduces a filesystem's supported file size. So I
wonder if explicit, hardcoded limits within the helper for known
architectural constraints (like for F2FS) would be safer, as we can
ensure tests are only skipped when the limitation is intended.

Please let me know if you have suggestions for either method.

Best regards,
Joanne

