Return-Path: <linux-fsdevel+bounces-76415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKMxEiaJhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:12:22 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD653F2419
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DF4630601B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6A13D3308;
	Thu,  5 Feb 2026 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PAbW9UuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC00133ADBA
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 12:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293253; cv=none; b=M5tLjVNvtr4F2agvyOcnEmQ8DebO68VOibY77AEOmTJ4dbboS4PK2/3IURyz9t/Km9MWRT6Hu8ALN+d4jcct7vt35ItR726x7rkEBtUolGw55pRR5gwgA4BKG9kepLPmJ6hBApESZuld9Z+mOZzPL+qIBxGbKdKFDtti3hlZp2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293253; c=relaxed/simple;
	bh=EUbyPSPzg8O/FCruDlcxDBtyuxWhSzYDy+sSVCSNiwk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sc3T2uoMBJYz8EibuNJ9s7c+amSmqhR8e02j8iV2PwRPqxXM2Tu17xu5d7yv9G/Cm8uX1YYU0daDI6wQ8GuTtAy9ph6QRPgpOMUK8RLMiI7x8v0tq1swnBUWwqq71So0e7P9GCv7hdjs/5YefNpBYCAUckcgWjwP3B4+gsaNKpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PAbW9UuY; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-42fdbba545fso1754304f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 04:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770293251; x=1770898051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AiRDpPfBdhyz5wlzzzVx6PwkN51eGtr6n3cy1jg4OEU=;
        b=PAbW9UuYnetR5vDfvxtaFul/hV5JkM7tan3qTmdfmFByLa/lpdG/ghUyLuOoA3g65e
         c+A8y1QaDSMbocnhBddBrpXMPtEjDWr2cZNt9NtGsf6m0b7yGkcH3Hvd3UCjk4apEhjw
         u/zBfrOTdCWr03V9Z6I4cT3Uu3BtQlZLdjl7L4G2KUg3JZ/fBq1J851kwyETl+sTEIBA
         lLfP+89WqO6ssKux6qqCKTtJhu6dmgnbMAAGBxO4vXxAcnrCMBEqf0m1lMzEO9AnRw0R
         p5Uz2DLHxBIOSOaJyuEDG00L7i19aFtXxbYH1RKMLa4xDD4jncvyVnrfcUy90MgPqnjp
         4Qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293251; x=1770898051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiRDpPfBdhyz5wlzzzVx6PwkN51eGtr6n3cy1jg4OEU=;
        b=c/2DBrD4rgNS2OE/KGcBvTNPDMBqaeZwuoaD8GeUMDbpg3GRvJmyaURmxQ2zaBTczb
         UEzpQsuOK7N/GWtEtdW6PI+1Qp3gAYDKoYEQ0eWTx/fWurNBj3WUumbwfJ/kS4SwpQ03
         bxDsyP/W0JXh4RulYb0nOk8a0W6JlJ/uYNsb3kc7+3JyG/UHV0ru58w++rrkkheWmjDK
         YXZVvA1JxolOvvWUSEYIUrv7WncU7OGuBG4oRO2KDcZdrMWXqINHmTg/t1iXT0vT4CbF
         W+sUQFR7yzNreCkHNRVzDusg0O2MEJ+z+zGXahE00ACKJ41fwBshemn+LVWmWjOheo+4
         rHfg==
X-Forwarded-Encrypted: i=1; AJvYcCU/iD+vXFXuNqZYokiGfOoEa5OcUYNfswJCnOcgBxUXFkrzhA9I7VGrA0mmcllEaXFlTohCg4lmxdHZvbOb@vger.kernel.org
X-Gm-Message-State: AOJu0YzyfMBzx5w4X82Bf5HI8Np9Vv4h72MamOT/SmC0HLZWt9QyeU/i
	eb62e6jXYrszvv9EpdIJorXupkn5iNAn2WfanjhRjaI9RDRlixth0XazP3NIrkCLcG0vcX1lbDJ
	EJUr3RJ2V1lLqO2ywUQ==
X-Received: from wrbbs27.prod.google.com ([2002:a05:6000:71b:b0:435:c29b:f782])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4201:b0:435:a135:777d with SMTP id ffacd0b85a97d-436213d7b3amr4150152f8f.9.1770293251034;
 Thu, 05 Feb 2026 04:07:31 -0800 (PST)
Date: Thu, 5 Feb 2026 12:07:30 +0000
In-Reply-To: <luj2ggjo47mvjzhzavoy72ro6kaoj46cicudjrc6646vs3s7q5@wzc7aabgdlkl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-1-dfc947c35d35@google.com> <20260205-mitschnitt-pfirsich-148a5026fc36@brauner>
 <luj2ggjo47mvjzhzavoy72ro6kaoj46cicudjrc6646vs3s7q5@wzc7aabgdlkl>
Message-ID: <aYSIAoK5KkZ3ver5@google.com>
Subject: Re: [PATCH 1/5] export file_close_fd and task_work_add
From: Alice Ryhl <aliceryhl@google.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76415-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,google.com,zeniv.linux.org.uk,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.cz,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org,lst.de];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD653F2419
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:52:37PM +0100, Jan Kara wrote:
> 
> Agreed. And just to demonstrate the point binder's use would become the
> first of such bugs because it is prone to the module being removed while
> the task work is in flight and thus do_close_fd() code can be freed by the
> time it gets executed.

Good point ...

> Generally, making some code modular usually requires more effort than just
> flipping the Kconfig to tristate. You usually need to make sure all objects
> and queued work is flushed before the module can be removed. Not sure how
> much of this is taken care of by Rust though...
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

