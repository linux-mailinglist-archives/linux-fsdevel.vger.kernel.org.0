Return-Path: <linux-fsdevel+bounces-75363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKMEF4YedWkaBAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:33:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846F97EBA1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 20:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EF9A300EA97
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 19:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0539243376;
	Sat, 24 Jan 2026 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g8gGqjy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC6B665
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 19:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769283200; cv=none; b=I3QwL2Vo4fGoBh92QEm1i5zqwXbDJU3m4NE55NpVMtFrRpIjngkYvN3spzf+ppCuJffzNHGWvwiEXLMvMeXRAMFS1ujkKJYOvg2vAfx1lISuiX/liTvHVmf6mds0g1yYMgYAYn7Mh6gyx/ARyo8Y4K9Eh26kObgNGadgL8/viEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769283200; c=relaxed/simple;
	bh=lrvIaCln4NRR5uVWX7v45ONIBvNhOPOWAFRGgFZuxNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzNWR5lnFaKOh6AekNBA0cOdkxWthXsB7013TC5etuSNM2FEAgu31WWI1JptVgVC7k0Fnos/5RqWaTYMyEudHM/AEfmc69sUDCo0RBKLVPYhgckRYJs1MTvFswhR0ZKDlZmQgmsPYPyH6IM+mZ5n5FVi/8Ra5Ct4vzZ1iFWV714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g8gGqjy4; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8838339fc6so606715166b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 11:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769283197; x=1769887997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyM6PURhsru26mmyT/sar5DQj5evhmW9KcUHRfKKIXM=;
        b=g8gGqjy4DXqsNg9d7GsA/3yeyF4hQvstkdyqM/8k+v7EX30pcmSvLKCVWpB+d3CqN+
         Bgbby6iSbmRPLi+G91pJWoBTaHWi5th8UVdlF+IiI1h5Vvm7ONnGnNg6lF6vK1EOVZD5
         VTqVGzT58ZrQYls9OE6euQxkIg98/ljBsK6mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769283197; x=1769887997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyM6PURhsru26mmyT/sar5DQj5evhmW9KcUHRfKKIXM=;
        b=wBuivvJl4PjcYDi7YwconRMCpla+sOCQQQHitmMT2qdvGCULA6khqXav1nPQQICryu
         pO6QYvDif3R9UFqGB+fiSnx7pXnEuApbCYirYg4mU94l+YFT9bvpnBFJ3bIHJP1KVuru
         40a4SIhSo33+d23hB0FgJEBcvKrKoBhRQly3906MM9MQJEKT/sdwjvRoxVywRtX3FHMo
         kUDXz8ILrcaf28eCQBcd5lnpp/tYoStrlX+hN6VeRg3GXMS6wMeCHF9LlZT6nnfvO1hV
         gkISmjDUOE2Wexdtrw8hTFpiViclW6lxcf2S+4RE347isPSXib3Ow1NrbH6Z1Q1YIUWh
         kdHQ==
X-Gm-Message-State: AOJu0Yzblt7QIFAF0Nv8S7yR4v1c7HGAkBx0HfKZ5Cdc4JxHNcTP19sj
	JCJn2XTYPBpz7ZMayd6+F8VbJvPELkl/H4m4x70bSXtp8fKVb8uMgC3QlNiuh6NvGvXs6TgIDio
	LZRM0Zvw=
X-Gm-Gg: AZuq6aK7CpRCiwz2d6xJNRKzhg0I4ZMXvImF+7+gIGYMWP9hdy2UjJaM66iaXNNGJuo
	QfubF4wzP16iY8KPSpyewO4y28L5ZG6+sAU2SYCDVbY1cUC17Oo50mV/wng/AwpQVpamQMA1uHf
	m9U58T0fSnWFgse2KO3dnceCWSSFadXnfXUftmaKnaa9lCqZKxfXeIkfEzFIr3609FeiQDnpz9e
	0I1cSr5RlUS5PH9ymuFBwrpI5enUyV4HSwFgPn/tH+wd/Q14aQuwv/0zU2JadFflniaJ6LMQiEV
	I/rBTBnScKdAcxLlMIrapiIvI0mFTIOI4vN8Y6Ecbvke0DzBcF1Og9qrqdydyR5D67xdw20HBeZ
	vI7Ht6RC7a7JGFK8+yAlJZCD/1nwbNyz0qckoEtyMsmpMvUxiuDlYhAnPBCF83kORnM+f8sjym4
	Xh8kOc/Nm7fM+/WlCBJdVsYVSI/Z3qjlWkGVNIK4hw+gQHRyUmU4qP/B9olDuF
X-Received: by 2002:a17:907:7b8b:b0:b80:48f6:9cc6 with SMTP id a640c23a62f3a-b885a440fdfmr518061766b.32.1769283196355;
        Sat, 24 Jan 2026 11:33:16 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8872854909sm209870266b.44.2026.01.24.11.33.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 11:33:15 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b87003e998bso755192766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 11:33:15 -0800 (PST)
X-Received: by 2002:a17:907:970f:b0:b87:1ffc:bfc0 with SMTP id
 a640c23a62f3a-b885a3b6739mr597171566b.20.1769283195706; Sat, 24 Jan 2026
 11:33:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122202025.GG3183987@ZenIV> <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
 <20260123003651.GH3183987@ZenIV> <20260124043623.GK3183987@ZenIV>
 <CAHk-=wgkSAHswtOzvTXeBOz1GLNfsohSPdyzZmnVYe2Qx4fetQ@mail.gmail.com>
 <20260124053639.GL3183987@ZenIV> <CAHk-=wgGCyjEC9ookrcVou4__nkPbSosP7RG6AwntBZbdeAjuA@mail.gmail.com>
 <20260124184328.GM3183987@ZenIV>
In-Reply-To: <20260124184328.GM3183987@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 24 Jan 2026 11:32:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLR=hAPRWsPxV8GQ5VsNb+b+SQ7KpmPCkc9E6SsqnwqQ@mail.gmail.com>
X-Gm-Features: AZwV_QjYu3o1mtdG2EpX_hDWDly12ydbgE7MmTRZUMDGmPjUj0eM2fN0o4gzVgo
Message-ID: <CAHk-=whLR=hAPRWsPxV8GQ5VsNb+b+SQ7KpmPCkc9E6SsqnwqQ@mail.gmail.com>
Subject: Re: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>, 
	Max Kellermann <max.kellermann@ionos.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75363-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 846F97EBA1
X-Rspamd-Action: no action

On Sat, 24 Jan 2026 at 10:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> > In fact, RANDSTRUCT is so broken in general that we actually taint the
> > kernel if you enable that crazy option in the first place. So no,
> > "what if somebody enables it on random things" is not even remotely
> > worth worrying about.
>
> Very much agreed, but we *do* have that on e.g. struct path (two pointers),
> as well as struct inode, struct file, struct mount, etc.  As far as VFS goes,
> those are core data structures...

I certainly wouldn't mind if we remove the 'struct path' one in
particular. It's insanely pointless to do randstruct on two fields.

The inode and file structs make a lot more sense, in that they are
obviously not only much bigger, but they are prime candidates for the
kind of attacks that randstruct is designed for.

> While we are at it, does anybody have objections to making dentry->d_u anonymous?
> We are already using anonymous union members in struct dentry, so compiler support
> is no longer a consideration.
>
> Another thing in the same area:
>
> #define for_each_alias(dentry, inode) \
>         hlist_for_each_entry(dentry, &(inode)->i_dentry, d_u.d_alias)
>
> to avoid the boilerplate.  Objections?

No objection to either of those from me.

            Linus

