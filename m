Return-Path: <linux-fsdevel+bounces-25583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E4A94DA5C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 05:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35A21F228B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2024 03:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A862013B590;
	Sat, 10 Aug 2024 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OKcteNk8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A361802B;
	Sat, 10 Aug 2024 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723261609; cv=none; b=NvccSnj+CyxJVmcQ9XBRvOtjGjyTj/HDeSA+Z2IKt1UmXlmjPGvsYYSrkLiRCsY3wTruTYuEU1+a7hWVVsjDmZTDpS6hTtTIovkweoywkI7YfULqEUo5OyEdrVt8XhJ/zQLUkDILw1ZeewuJ2Fhvs6ZHrV+UE6MVamxVhgA3ZuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723261609; c=relaxed/simple;
	bh=pCc5rZlUkjug+JYB2R0ck8yvhlhb886WMpEdh1diQiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKy6vmaUrfS13GGbxD3vC836Jnmu6WQ0T2AY5KjN6E4HDf49d1qUk5ECJU57SDmNZA0ke8raHkPWUcuyEV5D0V7bf9s39a8R9L9Jc7nHHsPULEkZGWebkrcCV/SbeNT673L+U6vY9wPJ1OLmkVmSUDuMOEAQ9/+TxRId8dmf4Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OKcteNk8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=V4V88+6ORKnoZTEvMKe3KHy18Q83Bw1qagLhsOGfx48=; b=OKcteNk84wbrZYnhyixObNQn0q
	HY4geaS3G4th988swtHI8B8dbTHZtTjWxKG9ZWCXLdJJ84bP6ZuG/ZG0cwe95qpA2QAbJ6LydzCOO
	CdQOPA7cndO56rD+DLrmBBX5yNwTgBrb5cA946JLXoLe9juipYYLmT79oKtaLhuIjJ/uYqggLQuMU
	3Z8chDpZsZqPOk7cuDu2ZLNYf0I9nKHg8INUeoS8K7nrc8YIzW8PdWalnKRoXT1o87kjDa7EwZCMo
	xV0HIlFdOOxSAJOmNvSnnVP5+bRilPjlGAn7IMz9fCVFXk773ZB0rpAFO9SPCByK8xjbV8I+756Mk
	dTDHk5Aw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1scd40-00000000Ku3-1OUp;
	Sat, 10 Aug 2024 03:46:44 +0000
Date: Sat, 10 Aug 2024 04:46:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: viro@kernel.org, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	bpf@vger.kernel.org, brauner@kernel.org, cgroups@vger.kernel.org,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 35/39] convert bpf_token_create()
Message-ID: <20240810034644.GC13701@ZenIV>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-35-viro@kernel.org>
 <CAEf4BzasSXFx5edPknxVnmk+o6oAyOU0h_Tg_yHVaJcaJfpPOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzasSXFx5edPknxVnmk+o6oAyOU0h_Tg_yHVaJcaJfpPOQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 06, 2024 at 03:42:56PM -0700, Andrii Nakryiko wrote:

> By constify you mean something like below?

Yep.  Should go through LSM folks, probably, and once it's in
those path_get() and path_put() around the call can go to hell,
along with 'path' itself (we can use file->f_path instead).

