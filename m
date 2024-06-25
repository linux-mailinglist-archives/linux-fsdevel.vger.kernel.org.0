Return-Path: <linux-fsdevel+bounces-22443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 607EF9172B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 22:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED502B22C9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A096F17F374;
	Tue, 25 Jun 2024 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NSSPCt8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE21F17DE3B;
	Tue, 25 Jun 2024 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719348757; cv=none; b=Ntm5Qp96KOPFEyKCvfN1XPq+4szJVCk2kRW8Q5tuowmtGd20orbeUYNcEyz6DSPlLEqC/4hpuChzWn0WZl4/8Z+Opv2+9rAhDA5RyPvZfhphP77SSoginv/o05vw/ltTw9Qw9IEVvkdS7PK2I6vvRx0l/bjZPV3nnWj5Huki620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719348757; c=relaxed/simple;
	bh=7Vk/57j6HQa3g+1KrpUCkV83IiE+PdNNhcP691viN4I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bJ+x+O9Yd0hbYYEzBNEdQTvaBizeAdloBMi2rlHSFgO8VWv/29muYRKttdgPJqQVx2xXr2C240tAbBMmDUMT6STE8J5yp9xTUmQZQ8BKFu1Lv86UlZL4LMVreqg95QfUmYOBHB6UO4SyZiHKey791ZxUOjrWfC8U/pvv+bPffq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NSSPCt8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A63C4AF09;
	Tue, 25 Jun 2024 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719348756;
	bh=7Vk/57j6HQa3g+1KrpUCkV83IiE+PdNNhcP691viN4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NSSPCt8y2S5moueuEEc+dT5eo/rJUoj3q1bkCikGiaZe0hzc4gOah0daI3hojxLPh
	 gHbUYh9kPT3G4MouuG+kVN2ljW30ihFCb0/XLTi7XEMAaIk4F9r9/YlDwr7DPl0SVc
	 oggO9jAJc7w3KLrFOQsqDeT7HG/dpL00Gh9d0ct0=
Date: Tue, 25 Jun 2024 13:52:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kselftest@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
 <dave@stgolabs.net>, =?ISO-8859-1?Q?"Andr=E9_Almeida"?=
 <andrealmeid@igalia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
 <reinette.chatre@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 usama.anjum@collabora.com, seanjc@google.com, kernel-team@android.com,
 linux-mm@kvack.org, iommu@lists.linux.dev, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Centralize _GNU_SOURCE definition into lib.mk
Message-Id: <20240625135234.d52ef77c0d84cb19d37dc44f@linux-foundation.org>
In-Reply-To: <20240624232718.1154427-1-edliaw@google.com>
References: <20240624232718.1154427-1-edliaw@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 23:26:09 +0000 Edward Liaw <edliaw@google.com> wrote:

> Centralizes the definition of _GNU_SOURCE into lib.mk and addresses all
> resulting macro redefinition warnings.
> 
> These patches will need to be merged in one shot to avoid redefinition
> warnings.

Yes, please do this as a single patch and resend?

