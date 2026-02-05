Return-Path: <linux-fsdevel+bounces-76425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G7cEfuLhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:24:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E93F2689
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FAE8300753C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002BD3D34AE;
	Thu,  5 Feb 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnU8kDqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7B3D34AB
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294263; cv=pass; b=rbaGNEIptRuAlrRj8pNeHaIQMb1A4vVVxApiKhjeTmwC0OParXaJjq0mtCoUgnr2v1ij8EC0ADEL0bQGE5ncEL4Z8uxJ+YPGjdtepCzAcXGAjPZRfcJo4Gxa4RGxxyUrlsC7m8uQ4IyW/spTadnsabV94Q29wPYa+K+1LBj+ZTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294263; c=relaxed/simple;
	bh=ZYfglyr8WBVX6WQ6sjuoZun+RCx3dM35uvyj1qgWTPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R0ZnAT0WA4TvDDTn7P3mIXFmAXuGJvu6nr2gvelS0YBJKZm5VpG2pzXBRifjZe7U7YftxKOsDoJxEGRonMsvTXYlQsv94FMUgLbMkJuT5HATbZEPSGEpTMHdXcAn8GOCnOHoGwqLwTYlWBQNQRf2vJVsp9KuEx6qR9fXp+m6HNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnU8kDqr; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b7267ff06fso74957eec.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 04:24:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770294262; cv=none;
        d=google.com; s=arc-20240605;
        b=UX9fWzjhTIszUEDywPrfDTNa+fLHeYRFU1WYdTm8A8TbzDtXHG7fFP5/YD4c9yzsaE
         vzupKONd0fOXbJwzzimbjN3zxIpzaFVksJELFlne1MyazWiBA3KPMjpHIzERR/81wAdA
         znGrMKt9aSUAYc9agj+5BryHcc3ZqwmmHLd0FPwQgwHT0VQ6SUgLi3Oiey6O4TeSw/Cw
         hUdSbyhoScVAoRNWdT0z98SYlxvejujUwEs71ORvC9fHl5caLxTF//rpPFq5pPw8Hpzr
         wDvW9y6cPjhGwx/gIfVrEVi+zKzYRgyVbKeJnSCcuvcoosKHFLhNzAB078Re3h5m/UE0
         EN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZYfglyr8WBVX6WQ6sjuoZun+RCx3dM35uvyj1qgWTPs=;
        fh=VYI0OvuW+DXbs6oYczqYklj54h2aHKyHUHHyP0Cfg2s=;
        b=A8ZYrdbWnAUK6VkyZg4Eo1Zx1BhU69/oUy/a0xvkwjYGfzAULvdzenCjwz9pU8iOCM
         gGDFnGIBKrAzmnQfsqt9b1NA/wFRNPI87zV0zrkdfZLmEtAVHrj/aQhPhu5NlMx73O/S
         spej4SU/sct9Wf3W3Ws57wTM+aue6kiwy16LUVyvA0+1LL5Wb8tsBc50QFgIA5LCYekS
         ncaDyZRfPa+sjVZhzaSbPBzElehBPyxKI6TVfc2+Mu7iWo8nPy/aM7NQvaR44ptT3660
         u3XpQbiKgppk9WQ3dVIHMKWHKnjJKQPUYwxX/GxgxVvAOMuE+w4JMJd3wyQtoieq0IIj
         Khrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770294262; x=1770899062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZYfglyr8WBVX6WQ6sjuoZun+RCx3dM35uvyj1qgWTPs=;
        b=XnU8kDqrS2YhYpPsk5DKy0ZhYzpXsTa4XvtAPQJXk2jWUaD6NACbVjw3wt+4PKy59s
         G3RY7K+FnXaDMtPalbxDHtxFeB6IMJ13tBy/OFHe1OZNf+KfI7SgRC6aK6ErLuE+sXSJ
         l6bASrhO91s+p4BE7QlHRt23d5YFeov4A9mDmL2LgV8QkOUvdEmgmZM5gcyJwsV+ncXf
         ll28toMSo9yvX7hDub0AVwMh/V3uPzZ4wcvQnUNiYakKgT9Gzgt5lo2S31Us5gzaUj42
         lRsYqnaY3pC1RNC+I0oU8wnMtBxglbgg9d0BsIjO4v1/MmEaEIrN7w9jOyVg2x058E9S
         hD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770294262; x=1770899062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZYfglyr8WBVX6WQ6sjuoZun+RCx3dM35uvyj1qgWTPs=;
        b=thaZCkC4jMHGyXqElP7CYhioKf+VCWheydcqvUe4M+1S6h2VR8BUaAxUt88MTCEzGv
         59v3QySfCYJP2KFkl39FB7zgtLOfVX0Hfyk0u0yPXOx/IM/SY7qa152vtuESTzZ2gb07
         Q260lwyDpWiXOri4+w/zZuldKZ7Vt8267fDyRaxBk+ZV8GuayEc5PuiCQR1fQyaWeiZa
         YkWcAua5KD4rNI6Tc/itxxpyomYQ24+hsNQT0R0G46mH1hVWOclCniHdlClir5+u2MYT
         mbyD6ayqa4bdYJJAOBHaj98ijmxRumoHxmQzIuHjkrmHdRoKkpkPaljmWpYeME9BWNio
         uxRA==
X-Forwarded-Encrypted: i=1; AJvYcCU19WEPjDdGMKnkboFLPEaNcG28wo0kMkkfHWEEh2cC2TfxBo9rIbi/QH2l0IeQISl3MluDTTCIx1BLFvt2@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsTl2JF+4ZppLlXbVRwWT9pmcgA+vBBBJ4L9Hb7Dr4kca6igo
	ynG7UL9Qt/EYaSAAPFapveLUVHIqqUzoT3e7OCFNyWkZ5mtgnfz5N9YFbuJTCRVgYPmmlzwiMsf
	JoovaGRiie0X2cvRJwCAd9xq922CB+Xo=
X-Gm-Gg: AZuq6aK7yXVDSAsQk9IzTa1CatZyGc8Awfdrf+zoxR7OQtQs9IvDdUXRQngjBQ5r0oU
	zXIBvGpNV2A2d6kX8R1NR2uSE1HJXtkd95hZGcgcS26LfVwqAsPTTgbDrtqEa/1ejsSCibZIJw4
	/FIhox73TQ+hFSaf4pWWpBzEwX/AxCOYpZz9Fh5B7ogSWqrO9RubvxpaigyTyYh5vWjLgmkuKMe
	VKQ1+HnScXagYu6FFdbqwC5dvqmVg/2wiPK1htF6f3byWRqeTnzR70n58PTmHTinN58wdcH5PST
	ljgqHrN5qXG/vUQDSpwv4+37Aef/NlIUnp4GihOQE5FxYlAG/xz6XG58x3ABOdS7kzcycZCUX9Z
	ubCzXQOVcnzGN
X-Received: by 2002:a05:7300:c29:b0:2b7:b88d:b75d with SMTP id
 5a478bee46e88-2b832743f4dmr1457533eec.0.1770294262402; Thu, 05 Feb 2026
 04:24:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org> <ab63390c-9e75-4a45-9bf4-4ceb112ef07f@lucifer.local>
In-Reply-To: <ab63390c-9e75-4a45-9bf4-4ceb112ef07f@lucifer.local>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 5 Feb 2026 13:24:09 +0100
X-Gm-Features: AZwV_QjQOk6KBIhhGsJHJbikCfRdoq7wVHVjUzF565W0EbHofNdnPpSD4f5sZ4A
Message-ID: <CANiq72=ybFtqsh18zkC3e1iyR-RoffcL_ZDr-fU7SjzJiFERHw@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "David Hildenbrand (arm)" <david@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76425-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_CC(0.00)[kernel.org,google.com,linuxfoundation.org,zeniv.linux.org.uk,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org,infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F1E93F2689
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 12:58=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> What??
>
> Alice - can you confirm rust isn't exporting stuff that isn't explicitly =
marked
> EXPORT_SYMBOL*() for use by other rust modules?
>
> It's important we keep this in sync, otherwise rust is overriding kernel =
policy.

Currently, Rust GPL-exports every mangled symbol from the `kernel`
crate. To call something you would need to be a Rust caller (not C --
that is not supported at all, even if technically you could hack
something up) and the Rust API would then need to give you access to
it (i.e. you need to be able to pass the Rust language rules, e.g.
being public etc.).

In this case if we are talking about the `VmaRef` type, someone that
can get a reference to a value of that type could then call the
`zap_page_range_single` method. That in turns would try to call the C
one, but that one is not exported, right? So it should be fine.

In the future, for Rust, we may specify whether a particular crate
exports or not (and perhaps even allow to export non-GPL, but
originally it was decided to only export GPL stuff to be on the safe
side; and perhaps in certain namespaces etc.).

Cheers,
Miguel

