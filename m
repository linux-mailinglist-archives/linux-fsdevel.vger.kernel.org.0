Return-Path: <linux-fsdevel+bounces-78946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKEnCEPKpWnEFgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:34:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD14A1DDDF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 18:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 303A23011165
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 17:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEED13168EF;
	Mon,  2 Mar 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JFr/n/ZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFEE317144
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 17:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472896; cv=none; b=RYBKZV+/s0HnzIqCCMuBQ17U26EM5EiXPgYOr00FDh8oIr8BCbqx8+V4JppK3Gf3F3ifgz8DW8+3vi5jStgea4cTkLFaOxzJU6UlhQ66vTq1JzmHvfXU+ZGnetCrX5m03PaKfuMAe4yhbqq8a/VQCe9uwISFov6UyzxTqXO80z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472896; c=relaxed/simple;
	bh=DX+xELAl0bpiVrjGYaZkMtgmkQplvgyN5cOscxnOeOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJEM7hMTgXHC9JTE+lpzpXktz+yRrLrM22SUzv4imbciwqx0YCJjUVM34JIgdIf7LOFiivFJwqt7uPS1nEKjpIbKe+as9krF6iqUDJkVJzKm+QOekT6FN6ytw3ArA0Dyg2dlfXxQYdtkVZYNWQ6FzZHI49Gjudjf80ukid79G0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JFr/n/ZS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-65fb991d7e7so6898891a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 09:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772472893; x=1773077693; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NhM0U/KytZp1XoP7N4M9fAB7JNIxjdmFkfjBUQb/l8Q=;
        b=JFr/n/ZSvw3W6quZk78Sqg7yZbUDoNVUU0+psd0OM5oxbNGdN1IQ3yWaYOYPze3Oj9
         ZIua8M9AesSviofrgVw/Q4sTOMM6mOK4XooSkLZTBwzDaWtpGZfmNUfhnshCmrGiKQHk
         1Zs+C6GmNQKSX+6G2DMbc8UtrPf1GmKh7DQgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772472893; x=1773077693;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhM0U/KytZp1XoP7N4M9fAB7JNIxjdmFkfjBUQb/l8Q=;
        b=VA4/9eON+Rq7S0x/2IGe6k+Vk36SaPb+7ZoH1oc2bAwmM3KrRisGWR7oyZzGXMlCLP
         hTyhypogV/WS5ElFLtnv06Pdn70rF/RJ4rr51fdfuarjcnYZPaRfeVvMhP53O/lsZNGc
         cPRb8y76R5lNCQFN/zsfAnpoDqtC6VzGlFdM4H3dMuvSlOSD99UQW50nqf1L9AK2vgq5
         WNNFTiq8ByYCsFVHThrW2Eb8Yl83LpkSYYQ0fzSljxly5CvncNUcu+sCp/z5cnO6cYiF
         enX6L8p7+GAVsKmSacbQLvccMPUQo85v+MvbmMMrzgn0C9D8u6JSE2xw3pC+8RhO90d3
         nizw==
X-Forwarded-Encrypted: i=1; AJvYcCWxgHXcytqPJHclcpUglt5Es/Yr7rlGMluuJBLNP3iDfNqS/c4HQ7WqbrtB2es8yGqe4DVVQI/qxLoQZPoo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bfAze28zw/oYPuOPYc5b6ynk0HzxEeDzwXREMH36biHOkxJj
	kcX9NMzo21kPKY1MLaBwaH0c39X/6nLYJpeS1LcHf2q6SwT1AUoXfAtz4lhHNQ2FcjZHGnbr5uN
	D0Z3Z74Fv2g==
X-Gm-Gg: ATEYQzyUUqI1gKC0LLITw0JpP2yuo5Hv81qmYkHU8fdJjCmf3Ruw67LrwX/RbQZNPAh
	akduADaPWh/FP1gKU34aQ1Er/GwWe5P7nKi4k7U02jxUUITd314L8F+FNrblzoOEm8f26JXI0tn
	bxUMrPuLqiKhe3LEnY1ZA3/XIRFlgYkryo7a5dww+AszdvxlJD/isFCsXhwOOnLIw0WhmDr86js
	YO8oEEV9q+NmJ6gj4q1HC9g5vH51CsWzj/agovKVYZhlev248O0EsxUfzjoVpjTw8GUMzwO0YyP
	zEzWf42AV3eo7w1k5XZOl9rM+ZyfPagf43bmmTnw/xGDREQ18o1am/nPawyfSfr0RHbUtwA3Zq5
	QX+Sg5r/NV+FVHvVkwCgu6KYuy0nqwZnYZzxG8fgIDutNfAsIMQi68tWnJXoUBH4j8/t72L9pvH
	vK60hdBpg4+HTiZIykghbQjf+TOydsoPpev0V0KtG23zI0IvSv/PO2gc7NakfOsls6dIQBg6IO
X-Received: by 2002:a17:907:2da6:b0:b90:bc06:2acc with SMTP id a640c23a62f3a-b93763613a2mr867639166b.5.1772472893437;
        Mon, 02 Mar 2026 09:34:53 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac73a5dsm483199066b.25.2026.03.02.09.34.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 09:34:53 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b78b638eso1257158f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2026 09:34:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXdpYBy/hxzVGAqaiHaxCCu9nYSRrJLMXaXgKsBUG2FJr6gCxBiTxpHJ53ypw2L6veXBNbUuAg2bF4fb87C@vger.kernel.org
X-Received: by 2002:a17:906:6a17:b0:b83:1326:7d45 with SMTP id
 a640c23a62f3a-b937b42886emr757779066b.32.1772472407269; Mon, 02 Mar 2026
 09:26:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302132755.1475451-1-david.laight.linux@gmail.com>
 <20260302132755.1475451-2-david.laight.linux@gmail.com> <e8a688b3-97e1-4523-9a82-8d9dd16e3d90@kernel.org>
In-Reply-To: <e8a688b3-97e1-4523-9a82-8d9dd16e3d90@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Mar 2026 09:26:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
X-Gm-Features: AaiRm52zcwSKl-2ZFc2XJ2K-Xgcl3ar6vYfBBv7z9Nop6yBvMYBvRXM6loWQHmg
Message-ID: <CAHk-=wjKWi=j_xcMBAi2Hkuut6aNeqXTwOFoMGkHfDA+3WXsgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] uaccess: Fix scoped_user_read_access() for
 'pointer to const'
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: david.laight.linux@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andre Almeida <andrealmeid@igalia.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Heiko Carstens <hca@linux.ibm.com>, Jan Kara <jack@suse.cz>, 
	Julia Lawall <Julia.Lawall@inria.fr>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, 
	Kees Cook <kees@kernel.org>, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: BD14A1DDDF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78946-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,zeniv.linux.org.uk,igalia.com,citrix.com,linux.ibm.com,kernel.org,csgroup.eu,infradead.org,stgolabs.net,suse.cz,inria.fr,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,efficios.com,ellerman.id.au,imag.fr,dabbelt.com,armlinux.org.uk,linutronix.de,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux-foundation.org:dkim,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, 2 Mar 2026 at 06:59, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> Can we get this fix merged in 7.0-rc3 so that we can start building 7.1
> on top of it ?

Applied this first patch. I'm not so convinced about the others in the
series, although people can always try to argue for them..

              Linus

