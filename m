Return-Path: <linux-fsdevel+bounces-34630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF99C6D27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83651B284D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2A91FF04F;
	Wed, 13 Nov 2024 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Fu6/4n6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C691FF5E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494941; cv=none; b=P3a07URF64c967+YyMIoh0iVLMn4QWTGNSQTyBhFHLmSpUi2/gP0B+8sZeIeFIno/bxUy6bm+G9F1NLjkkB/fm0EyamBz9HLnipM4gwYHgyo0y/MREodGEnccAfGOV/7ECjVgMYyj2qFWfVTVwqHjpH/oBfHmagKPcxa0k+siAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494941; c=relaxed/simple;
	bh=pIhC9/hK47e7+MFElUqH8Rd9EA0/oH4OsMHtOgvQWH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkcZCB6Ji43NEAr0/JnQjXqHWPLbKd0Uo2boQmJVAUWq9iEP5WWry0JL12506eR4lwa3d2kKDOjY+WgdBapbSNYE/OQW1r18z6IxUkEVeDZdF22pBifkGgR2xJuFZ4DS+gyTIiSWKoZu5OXDxhzOQWZFfeMM/X2d901T3eMqGBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Fu6/4n6d; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so6438875276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 02:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731494938; x=1732099738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fCWzNXcfZFUOOoSuUDtlh4LJbgNZ+Kyy0hvbqO83lWc=;
        b=Fu6/4n6d9SmA8u59MdgYOF025LcC4QRvYEW/TLubVVaxVtd7Y+eU5/BB4Ukejhe1Oj
         PDiytRYni/RKScgLao1jtj4YOF1wSLeXUvUXSNYesF14a6Mn9LT+7E+eEbhgDzX0qMWo
         tOSzoAK/gt7QXwB1FRHrmSOofosWH9LDVqv8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731494938; x=1732099738;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCWzNXcfZFUOOoSuUDtlh4LJbgNZ+Kyy0hvbqO83lWc=;
        b=gH8lLv/0vFN7Kr8LZxKxecY2UnnvqcOzO12XRymvhEnjWBOz2NQNmDNeId+4top72y
         FZDsTgTbx+RWIQQrnmQMtOQPXJv9F/xgrhMyVs1NaWDhTOJlyto+HdRm7epxa8TS9sHU
         1zCV7YwoabJA+3tBrlZK6wswQvbPZcBXdmh/o4M6D6bUwnadR7sb6Wy9klvmS6ZNdJhS
         z3YIPm9izbx9gdMKp+4TfvwnmP8Q6hJ5JbPk02OA9JiGWB2+Gy9WS9j7Jfr+KetCqPMI
         RLWpsoyjLdfiQtcjoXR0MC3OAjKfmorRCfI7eMCMEneOLAi33eRgeJLI0J05emD6Cz1J
         X0hQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFzcy6shPNqIe3AeU04wtCoilCc4Q8GUerMgl4Os73a9WOmt64LZaE0dn+VTtkn6gq/ig6Xjt0WyDUbXX6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywei2CrjfyZWydiWgfKFrYMYtWY9OV7vmxQbFFRYV4kv9uaWbqN
	95mkpCEhAZjvrrmWfr8t+mQzwT9QZj/X9KLM/vGotLPc7G9Ss5yrkJfOBJnaJt8EHJHIaC7oN35
	O7YxlgveTpimIbvmNNNwvhj1oUFGI3d3QboEmtA==
X-Google-Smtp-Source: AGHT+IHGSBNEx1q2vgfYf1kVAx6WwXY/JhE5tWtIMVAz6Et3j22+/n6fQViPrJ6PXuKqX/MEroYo6kUouNWSXr61TDc=
X-Received: by 2002:a05:690c:6601:b0:6ea:7b98:3a00 with SMTP id
 00721157ae682-6eaddda3741mr188382637b3.16.1731494937730; Wed, 13 Nov 2024
 02:48:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-dax-no-writeback-v1-1-ee2c3a8d9f84@asahilina.net>
In-Reply-To: <20241113-dax-no-writeback-v1-1-ee2c3a8d9f84@asahilina.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Nov 2024 11:48:47 +0100
Message-ID: <CAJfpeguawgi_Hnn2BwieNntbOCB1ghyijEtUOh4QyOrPis--dw@mail.gmail.com>
Subject: Re: [PATCH] fuse: dax: No-op writepages callback
To: Asahi Lina <lina@asahilina.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Sergio Lopez Pascual <slp@redhat.com>, asahi@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 20:55, Asahi Lina <lina@asahilina.net> wrote:
>
> When using FUSE DAX with virtiofs, cache coherency is managed by the
> host. Disk persistence is handled via fsync() and friends, which are
> passed directly via the FUSE layer to the host. Therefore, there's no
> need to do dax_writeback_mapping_range(). All that ends up doing is a
> cache flush operation, which is not caught by KVM and doesn't do much,
> since the host and guest are already cache-coherent.

The conclusion seems convincing.  But adding Vivek, who originally
added this in commit 9483e7d5809a ("virtiofs: define dax address space
operations").

What I'm not clearly seeing is how virtually aliased CPU caches
interact with this.  In mm/filemap.c I see the flush_dcache_folio()
calls which deal with the kernel mapping of a page being in a
different cacheline as the user mapping.  How does that work in the
virt environment?

Also I suggest to remove the writepages callback instead of leaving it
as a no-op.

Thanks,
Miklos

