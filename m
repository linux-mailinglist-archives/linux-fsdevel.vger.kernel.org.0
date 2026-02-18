Return-Path: <linux-fsdevel+bounces-77638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBYtL8tClml5dAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:52:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB515AB07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E344303C4C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4DE338939;
	Wed, 18 Feb 2026 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EJ3j7OKd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A7338906
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455170; cv=none; b=KukMgO+Vw7Y2z2TULyJy24cLls/OUvh5q/4jZNicUjWTUA2Q4OXwUgAnAXnnvajK1zkFT486TkmwqXNyTAiCqCfiFuU09OgAPWiF/GzElV71xjbz84n9Rs8R7LC/9s47/P8Fb49UicwqhG6qq/3SppoBgH8Gpnl1WtmU+hzyArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455170; c=relaxed/simple;
	bh=UjsXzZAFFhPASY2/ZRnpo3HDPaRUB92o1gKNPrtNlKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eajMTAH975TAai3yZp4gKl8I6/9NZ9wUZsqr2ynZ1cO+zyorUOone3pzg42chhsUuUwDMhHYQvxhTxwY1L4/KxfCS3bqaB5QPBYhK+IrcxIxyFY2VqMxdb390LL3Z1Jot9rpK44QoZSkc3oP8vM3Tnjtf2hTONc7YRBKF9QHpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EJ3j7OKd; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8842e5a2a1so53618866b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 14:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771455167; x=1772059967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GE2EcMrg554xVhaFDKxiIeKNmyek+c1hhafGucDFOeM=;
        b=EJ3j7OKdMaueUqEw/Q1gm+L+IfJy9PjUcfD9JXs4YmwzZ4ojLrGHebeU37sW3pyQgz
         oaWeviNfLlZ/Tg+8jxYoGmw3E8gERZbMb13I8pYhxKkBwf4xR6fFOzqi778dMBx71tC2
         TfHJwpIcC5EE2VSwxdcb8pB2hbVB8rs4jueZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771455167; x=1772059967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE2EcMrg554xVhaFDKxiIeKNmyek+c1hhafGucDFOeM=;
        b=hJ2Ucul+inDIsTSo6+/qKsyIobDnIEZXjSW8EPgDviQzLIlWY1digAGGsEqh6aatpc
         5Y04fF9yn0bSUDObrUh6jPPRQ1p/kY+/uCNvxIZ1a6AnS99muwuD3aYOSWWB4HhMbvPI
         faOkz0LV6XqXOnDGDq9LOjx5P8f3uyzUFZnYMZMH1PiBFuK+uBsaMzpo3/Nh/k9bOFbw
         OH+ICZIOxVAHP1ep9a0jv0X9/tLM4NAgKozP/pFi5ugHafsRMvE3e69WxVvLvNX8rn/L
         aIEfhyJP7iBbkdlLdIwr6EBcFFIrfXiuv+h79faRlciMwcZSWAiIanh/4LmvsdTpztrh
         4kWg==
X-Forwarded-Encrypted: i=1; AJvYcCU+ReCXSdn99uttytBcfg0mz0TaPquENJ+qHUjfQT6ZbLyvN8wf9Q6enNoPikVx27hiqgcgfec9VfJptg/O@vger.kernel.org
X-Gm-Message-State: AOJu0YysJjHFN+cNwa2Z7sOm+9+RthJTfOliUnU/krBpgekiLBnVV5iH
	x0R0vFQhCLK1iC+m1ec6JhkRUtesys0qJshhtnY2ijyBt8q++SWmsVM0s2uFNtJ28HKqvAPHUkP
	Uj6y4wMPqhw==
X-Gm-Gg: AZuq6aLiK3/2nOa3K5h8SExv0xSEuMIIUWJJowSPQmV6wpNpi0APvSMJs0prc5zl44w
	4pG5nYjofy0wr834J40dxhnLAyzfFVv/aJrJ/t4ACCtXiR6gOePkrLqkftKSsf9B4WyYgl/zYBJ
	XFjOuAxUQAvgsISUpl2a/7FFkkCsE8jRJVkeiJTet4MinPDGQYmqZg5d/mxznNAGs18p4w071LX
	pORJrG0Om1Z9Hyo+4QmBuOh+A8oD1wljQ8tiXyNFFjG319iWAAocLYEheBBW0Bi/3AMs/bcFq95
	CU4EOjRnUwWqgjt1cfPgaMASoTcFzLUqt47vlu5y7ROrXzqYOBX3WwpM+PAQmp3o1NkKEQz0y6D
	xgOSQYayhWUjLyObBq6hnK7po4KTgURQgVQTtLHhGled6iSnmT5tl/KDO6O4WkMaljp2+D6Mvie
	tTO4Vi0g3SF/5AxXChTBHtA888zSFrgIjOIHK1bzNd0RkfAf953VWH/b+MAbRoBBZnwzRHXznno
	RQYiRnUdOw=
X-Received: by 2002:a17:907:6eab:b0:b8e:796a:fd5c with SMTP id a640c23a62f3a-b8fb438cbf2mr1137934766b.27.1771455166951;
        Wed, 18 Feb 2026 14:52:46 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7386b49sm501657466b.22.2026.02.18.14.52.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 14:52:46 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b88593aa4dcso50503666b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 14:52:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyKnTRGjLiK5oPFkMDxNrLQXLObhbf2Gdgztl+Al8ggMXVyG6vZJ/Rygd/2a+2FjBjUlj5xK8czkMNvqR1@vger.kernel.org
X-Received: by 2002:a17:907:9727:b0:b73:398c:c5a7 with SMTP id
 a640c23a62f3a-b8fb4499f2amr1150499166b.41.1771455165803; Wed, 18 Feb 2026
 14:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217190835.1151964-1-willy@infradead.org> <20260217190835.1151964-2-willy@infradead.org>
 <CAHk-=wjkyw-sap1dNkW7v8at8MvF3j5wshC1Gw3XEpHBbBw6BQ@mail.gmail.com>
 <aZYoXsUtbzs-nRZH@casper.infradead.org> <CAHk-=wiXCcnp5VuAZO7D7Gs75p+O4k-__ep+-2zapQ4Bqkd=rQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiXCcnp5VuAZO7D7Gs75p+O4k-__ep+-2zapQ4Bqkd=rQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Feb 2026 14:52:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wggNowW32UcNWHQ4Ak5J-0mZT_EO+PAEw2DLe7tr8-Dtg@mail.gmail.com>
X-Gm-Features: AaiRm52QTAKbKgSZbjtmFVsStzsphbgy2PJask8ezbA7n0nuMuFqfyfcbZxak7I
Message-ID: <CAHk-=wggNowW32UcNWHQ4Ak5J-0mZT_EO+PAEw2DLe7tr8-Dtg@mail.gmail.com>
Subject: Re: [RFC 1/1] rwsem: Shrink rwsem by one pointer
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77638-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4EAB515AB07
X-Rspamd-Action: no action

On Wed, 18 Feb 2026 at 14:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, this is all from just looking at the patch, so maybe I missed
> something, but it does look very wrong.

Bah. And immediately after sending, I went "maybe I should look at the
code" more closely.

I think my suggestion to just remove the check was right, but the
return value of rwsem_del_waiter() needs to be fixed to be the "I used
to be the first waiter, but there are other waiters and I updated the
first waiter pointer".

              Linus

