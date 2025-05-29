Return-Path: <linux-fsdevel+bounces-50089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BFEAC81C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF521BC3981
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D81822FF42;
	Thu, 29 May 2025 17:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mNkCvsum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8791F22D4EF;
	Thu, 29 May 2025 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748540296; cv=none; b=Oh2Bu9LD/B4IG2SVrmNZ4uLeLEzfglPa7kS5abIvBOPJ/a2KimkQVKCmkrOF8T1zx9ZWbNs7vRCMbxDbqStN/EqIE3ItMi4rjtasbRqc4zqPl4L0v30JosJrjuZtuUQC0XzJLLcRpgYhz3tSwW5DkctlEKUd6Ck3eYlo0JARxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748540296; c=relaxed/simple;
	bh=u5W8+G4Kc80GVPR5lDWHQq/K4gBJuA+Me3jvmg/cMcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7n0TafSbUw94Xel5Sp3uvNvIWIcpV5JE2Im5alkYUDE2BgVn1rDIUrdU89xoHsznQ1djwqjdYPacGuEFQDD/m+B00c2CwDpi9KK9M0OZaMZN/6JMS8mFbez4lRFkY57eFiYUh7pPrXCmIoPyZdCobU6RwJ8Fhg9sFlc/cTRV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mNkCvsum; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=u5W8+G4Kc80GVPR5lDWHQq/K4gBJuA+Me3jvmg/cMcE=; b=mNkCvsumMnTM1jruECZSDfplVQ
	4ejHwx651aciRGIvYai0NFiojOgNy4zti3mTyKygL30Y6ROgUvkDnL8eIG8tZN4lUY/FwD1GEIh5n
	ww09S4N/VphC5OQzfcW5j+QjjnAeIHJLnWYYFMYQbB8T5+V8KudA/osGtw7sZtxqhUuDzz/i0Pq9V
	MvQVEMd+5/SlOL4Srh3tBRCa1UL0dd7wlYCRjPno1tN5j1gSXCXkueVRCZDXseWjCbMLTyX7D7diS
	qHd5yKJRZ4N67NZGpSDlDEhSgTIxunkYGZD3xmrkrVrwY13US9yGkx2p4Gvwg8hwaJ/wA51pJJpC4
	+eKm0uzA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKhCk-00000001rPl-0bsy;
	Thu, 29 May 2025 17:38:10 +0000
Date: Thu, 29 May 2025 18:38:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Song Liu <song@kernel.org>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, kernel-team@meta.com,
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, brauner@kernel.org,
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
	repnop@google.com, jlayton@kernel.org, josef@toxicpanda.com,
	mic@digikod.net, gnoack@google.com
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <20250529173810.GJ2023217@ZenIV>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 29, 2025 at 09:53:21AM -0700, Song Liu wrote:

> Current version of path iterator only supports walking towards the root,
> with helper path_parent. But the path iterator API can be extended
> to cover other use cases.

Clarify the last part, please - call me paranoid, but that sounds like
a beginning of something that really should be discussed upfront.

