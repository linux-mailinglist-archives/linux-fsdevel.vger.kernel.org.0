Return-Path: <linux-fsdevel+bounces-65556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39089C078F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205841C407BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 17:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDA3344045;
	Fri, 24 Oct 2025 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="SRfYErt3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD11D515;
	Fri, 24 Oct 2025 17:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761327370; cv=none; b=ZFq26R8KLyKadxZZcF4ZcrZaliG5C4PzvgTgjfxtJUXysm8aAZeabHMYZwygHQIdehPtXkxDPJSDpCfJSHqtY2FlfvtVfyAAunl0EQMwNVIS5I+QflI1p+S/jL2EVtIBjSrEoAyyA0xt9NW5ME4DYMnafR6TYXNAmxMND9f1BPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761327370; c=relaxed/simple;
	bh=h7ssBD9jsiigCaBkESGzjzM8Uz4G6ar06c1cpCnGPJ0=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=flIBzUx6yJA4dVq9/CQ26/kPOE/wj0G1x4KmHXgeNiOZ8vHoYVLZxoF3h+Ye/fMzw6OiFQTjuQbYuEImoXEFppVXUm07caBjDVwYFgG09nPtrAkbcWt+xl1mX9h9V1lNSVkxW4LCh3YA5itUBkHOpKqKOVkS1oRB63H2QiSdX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=SRfYErt3; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vmCP+pvBWjOmbkUmBX4W/jzxaydDg3hSDrVnUTEMRhY=; b=SRfYErt3hJGmMtFia2xTlJTs8I
	gNGJxaayMrqfSaogj+hdT75QlqlXiJ6ywnfNvKtSfBcpE5bViOwuQKHVnCLBz5bJxmQDZwX6QRANV
	O41r+XTW8DGwHX7hGaVgq6hGz2JElH+bEbM6augZC9juluiLZiHp8q6KXrsRh0YhvOEdyeLlKRd2Y
	ZKy3EWYaNf/VRKWev+/KhBPhxI7OrM+0gmN6wtc1FeoKitydfrekz5fNLYKj0Pxrmv1jjAzES1ixK
	2oWsGtMsW8KbA5z05b2e0Zq9q+QkN1y0/hVZpaoMa8FyI9uCqipaEmmCWGU82eTFyPhorvHpTYUHS
	PG8hRchw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1vCLhq-00000000JlH-3nYX;
	Fri, 24 Oct 2025 14:36:02 -0300
Message-ID: <2f19d9bf0e8d2b70d52403e676bc119d@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Howells
 <dhowells@redhat.com>, netfs@lists.linux.dev
Subject: Re: [PATCH 08/10] netfs: Use folio_next_pos()
In-Reply-To: <20251024170822.1427218-9-willy@infradead.org>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-9-willy@infradead.org>
Date: Fri, 24 Oct 2025 14:36:02 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Paulo Alcantara <pc@manguebit.org>
> Cc: netfs@lists.linux.dev

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

