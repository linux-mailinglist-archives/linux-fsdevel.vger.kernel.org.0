Return-Path: <linux-fsdevel+bounces-76414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGMXOQGJhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76414-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:11:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7080AF2402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 773353048E30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B713D3308;
	Thu,  5 Feb 2026 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1HAe1g8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2DB3A9D96
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293222; cv=none; b=unXJlebvzGRzcDK7/OY8iBS40qgv+Sipx6SZVYto1tFf+7pVbLGE2wPxYtttv3T44s+MvOtvWWDobwwqOjOQmXPA1gWGs+6bRi/q3oD9GZ5WgWMkJtRZudpCSCzITpVB58Kif3vu1jEz6Cbml8xSPb+5WFemdsqsKQpgvOM2030=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293222; c=relaxed/simple;
	bh=u+peTVHK2V5GDnlUQ9nOUzZqoANTtWMS/ko4tHyGhtY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SYNRS/2kllo7qi7NRH76Hpy1xbSCHcgZwszo81ISKCz0Ieg61CotK/uiRzndu8jPR2EHJj4W5WYlkms02x1aRP51u4KuPDFFbqqV3wjYeA2y6gzWvuRZeMinUTQGs/RnoG5FWhiXfX+aohCVtXVcQ9tLz21cQlAv2nTMyShZ68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1HAe1g8; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-480711d09f1so11598565e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 04:07:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770293221; x=1770898021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u+peTVHK2V5GDnlUQ9nOUzZqoANTtWMS/ko4tHyGhtY=;
        b=U1HAe1g8u4Hn34NcjAQhfrM9jb0n7yHtW2HTGFaZ/vruZ7iHfQqKOE1RSOLNV/QhI6
         oAmnO/2bFLTBWeJ9sOPYjohICu/jqEJZaNyQuA3cI5//gB9+M4KDHPXLGq5nuy6PmRGW
         D+XycDPDi2Vj+6lAcvxcuYr7l40jZ7nC37lxjKj72G1KzQGpesmVoEWUF+EhmQaAV87w
         6FkNIbTES0vDwWnHg7vW34E4WpFpogHZNeQQkTYS2B6W5a8NeLXERWXR9LoDZv/4Edwz
         e0KwQAnt/HaLf8mB0tXjpwR+JZ+F6u4eXBvhlogfwgfuXHcKmUDinzKIZWqa7xOIzRJf
         wEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293221; x=1770898021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u+peTVHK2V5GDnlUQ9nOUzZqoANTtWMS/ko4tHyGhtY=;
        b=tA3kBp8yl4HRiOnC0DNrBjxAh8UTRD90KzaX0JXhHzQbAW8nbbybqp9bBVvcHLP8CH
         CIommfEm/u7pSZafsQf0gN/Q3TPrl91Cs8ug/grJfeppV46QIFpNiMKc8UDhdAE4D30u
         oKvaajGg3TAjva9XvioXYUd1tiQ5c6/4bEgDpUdTcYQeYkmE2ZTFT6EAW66q6VO0iyLP
         CUfRUyRaEMdirwuwRoosGwRUu7zNguZpAgBNRjfxdICuZcGWXUMAA7r85I0gwfDmwN25
         r2fIcq5cgw25ufJ3OhAepIOwvw8Bc5FSOUAMltKHHt2Eg3l+BWIczDwH1Bfao/FKgFM/
         E7gA==
X-Forwarded-Encrypted: i=1; AJvYcCW6rlFeqGtZi4Vzq8JkiUyOjWqRxFnLmmlpgPV0YUNwz66fJKQVNUii3KGiEDe8suRoJp+hfRPU0/5glnt4@vger.kernel.org
X-Gm-Message-State: AOJu0YzsR1ohAhDTFdwwInX2Ut1Xz5zFbOhJNcFpU06+gdllzQVxyisE
	j3AHkA9fexpPkxrS8ZgOgbgVJrOWYOiLqrZ565kyhM9gXPQ4Ya1mwuG5QyrQNkB2wxvSJQIxCBv
	1nzkp3P0gLyytShfOEQ==
X-Received: from wmmi24.prod.google.com ([2002:a05:600c:4018:b0:46f:b32b:55f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c04b:10b0:483:a21:774a with SMTP id 5b1f17b1804b1-4830e9926cbmr64195215e9.26.1770293220868;
 Thu, 05 Feb 2026 04:07:00 -0800 (PST)
Date: Thu, 5 Feb 2026 12:07:00 +0000
In-Reply-To: <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
Message-ID: <aYSH5KG36fVQFePL@google.com>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-76414-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[34];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[archlinux.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gitlab.com:url]
X-Rspamd-Queue-Id: 7080AF2402
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:29:04AM +0000, Lorenzo Stoakes wrote:
> We either need a wrapper that eliminates this parameter (but then we're adding a
> wrapper to this behaviour that is literally for one driver that is _temporarily_
> being modularised which is weak justifiction), or use of a function that invokes
> it that is currently exported.

I have not talked with distros about it, but quite a few of them enable
Binder because one or two applications want to use Binder to emulate
Android. I imagine that even if Android itself goes back to built-in,
distros would want it as a module so that you don't have to load it for
every user, rather than for the few users that want to use waydroid or
similar.

A few examples:
https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/blob/5711a17344ec7cfd90443374a30d5cd3e9a9439e/config#L10993
https://salsa.debian.org/kernel-team/linux/-/blob/debian/latest/debian/config/arm64/config?ref_type=heads#L106
https://gitlab.com/cki-project/kernel-ark/-/blob/os-build/redhat/configs/fedora/generic/x86/CONFIG_ANDROID_BINDER_IPC?ref_type=heads

Alice

