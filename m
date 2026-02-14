Return-Path: <linux-fsdevel+bounces-77234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHT4AWD1kGkCeAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 23:21:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ECC13DB45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 23:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3DB53016EC7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Feb 2026 22:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FCE314D08;
	Sat, 14 Feb 2026 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wri4QK1T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F826E6F8
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771107664; cv=none; b=Z5NSAQA1osOaF0zT/qGJSSqw8Cs0sQY/EBznMXcQuY29PIqGLANnbmRBkM0q4qdGxcv9owof2EWfPhjGpe3S/oZTpJDrhUqSvtDIOYHkdab8uosZMXtN0hTbjlhb1u24B45P9nt9KzOzXmSy9QybkwT12wjdqTw++ACYM+k4K/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771107664; c=relaxed/simple;
	bh=//zRrWhjq2Bwrga6F6V/tszomUIh5gEKf8efc4PgfJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkgEzt3yCis7dhZwZzFL/C8LCYVE6o5z3LRbIu4xSjM02TJiDXM602LOh3Qs2DhtJJ3SofdCSnP9zZ4jxRDzF/qIAB6zsByoeGqDr1GbAnsTmMkR4vUVrQjLmELnBjOjP4pLqitw6+Da17T9PrOsPPC9uD2O3FUuX0d+1YsOjMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wri4QK1T; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65a1b17a99aso3700586a12.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 14:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771107661; x=1771712461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JWQi7XRtc1k2Wo3ssUlb/bYjje86J5o7oD3gW7VZANc=;
        b=Wri4QK1TR1kfqRaGMX8wvFSda96meePidAr+FsCVHt39IWn5OcmphpO4wPyRbv5umV
         bjauAbUEhZFV0LGkfM7AWpn9zDz2enY/O8BkBPVVvnQelvM+vtMCkMv1i8C+bRKs0RZl
         ZkdxzSdu3SJzXUOTkam2Hf7f1ZMm9RPws2HRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771107661; x=1771712461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWQi7XRtc1k2Wo3ssUlb/bYjje86J5o7oD3gW7VZANc=;
        b=tTyeantlNgDwh9pKnvWMHYrPLpKC7pZpEOc/B2Sktnw1xmAZCU5s54qThJVkTSoOK8
         lAcGXlbVa4pVy+pX1KXkrs9HzeqZqMwI5gQ9+b2LevbOX2xVdpDd0zEmQRuEyF97AXUq
         +uqQ0Ci4Xt0W7Ixpu+MslUk+SgJbXXPSARKqtl++9Vwatd2CFjEZ0pA+45c73N6NR7Pq
         vMDKG3iMQJWs9rN7JSUYak38IZb1NVv02IVw/mhvg3HFCXwsi+46RZxkyLWKqyE6ZxJF
         B07C3tXe3qGzJZqOO81vqUXlEH1YVFVF4Q5UM1HGAdPGz7xev/sEPWujTlk32pOVWGJa
         0Sdw==
X-Forwarded-Encrypted: i=1; AJvYcCXBiEc5JV4uhjUpfL6PhJI27XCezrF3BhjmdElxD8g7uKCAahfSITg38ER9rp6APIs/2cogXp0WJsSdERjI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6kKNprdw0MzfhQ/anZ7ws5snvUYC7AJqsHlgHav9WEEPiScAR
	zWRe+EFN9FpEx9QMgbvbkj6XW1uEsq5+W2qNm0RE5nt/A82iMeu0pulnoWKWqVxkQz2zvpNG4Nh
	bhIQZq5g=
X-Gm-Gg: AZuq6aLtLlcZ4YDdE5h9tav1MSHRi54VWbxqM93CLI2Ml8wTwwpy14PTL9EbQzfIdCL
	6RmIFpljsjZ4UV/Uz/bN2gIEtAVM7T8lmXH9a3CRJNFJD59Utw3tzaV7OL/YgcwvwHRRrZY35K+
	/0xVaR0qJBybJ4eyVr3H/AWH7qg/3vJmjrQXZ6WT74cwN56fk7Mgdrd7xDZx2o9HwvNuRldQwDB
	CeDobO4vpICR5GkKPXAHBt/9Hxw8UJLRo5QDGD68QsgN0QRJUSr4rxXqphchbI5BHv++4RdP9CE
	kMNvsobaGQZIwLI8NUzY3Zpf+taLL42/feMN4uzzF0HNM15BmWnvJ+y7CJdDIHeBVC5W+TgZraR
	rbKxFC4EJTTqSMUyC+qIf03BAXBjwm2ezbf2mpW5c2UAwvN7VLDhAhLvnn8JLZxPsmB6MYKAPuL
	yPHrHfSSXXMpb/1X1EileoBkL461tgrMiSxRy5xOhhX1rrUqPCUKN/hz0LWQezxu5vilGyx4/8
X-Received: by 2002:a17:907:8693:b0:b8f:a724:8710 with SMTP id a640c23a62f3a-b8fb4501342mr362235766b.50.1771107661558;
        Sat, 14 Feb 2026 14:21:01 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc763bacfsm106686666b.36.2026.02.14.14.21.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Feb 2026 14:21:01 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8845cb5862so267183166b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Feb 2026 14:21:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMWtOY7vte7kE8XsK7V/ArlQevjqNs/BmpF176qE7EJ3QYknjzQVBmpXt36YaqwzBnXnOKHB6ihlzXlTsv@vger.kernel.org
X-Received: by 2002:a17:906:f593:b0:b88:68b6:e578 with SMTP id
 a640c23a62f3a-b8fb4214745mr337427966b.25.1771107661112; Sat, 14 Feb 2026
 14:21:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260214211830.15437-1-ebiggers@kernel.org> <20260214211830.15437-2-ebiggers@kernel.org>
 <20260214215008.GA15997@quark>
In-Reply-To: <20260214215008.GA15997@quark>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 14 Feb 2026 14:20:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgFNdEJXtoJzkektG3=Tqmk=vNp-J2nWnFicxnHNG2Ndg@mail.gmail.com>
X-Gm-Features: AaiRm528B7N9YxtufVXSjYAah-YQlAO1sSDZ7nzbSQ5JrbU2aWa4vm7YMBox5W0
Message-ID: <CAHk-=wgFNdEJXtoJzkektG3=Tqmk=vNp-J2nWnFicxnHNG2Ndg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] f2fs: use fsverity_verify_blocks() instead of fsverity_verify_page()
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77234-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 72ECC13DB45
X-Rspamd-Action: no action

On Sat, 14 Feb 2026 at 13:50, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Let me know if you'd prefer that we verified the whole folio here
> instead.

This looks good to me.

And hopefully some day that "rpages" becomes "rfolio" (and this can
all go away and it becomes fsverity_verify_folio() and simpler).

It does look like the "cluster size" thing could maybe be made to
simply be the size of one folio for those things, and then being a
single folio of size "PAGE_SIZE << i_log_cluster_size" might simplify
other code too.

Then instead of walking multiple pages, you'd always have exactly one
folio (just different sizes depending on cluster size).

But that's just from a very quick look, and I might mis-understand the
code I saw...

                      Linus

