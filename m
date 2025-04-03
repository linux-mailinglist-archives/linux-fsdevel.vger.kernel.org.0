Return-Path: <linux-fsdevel+bounces-45625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5ADA7A06D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88683B6F91
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD17C2459EE;
	Thu,  3 Apr 2025 09:48:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4412F1F4CBF;
	Thu,  3 Apr 2025 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743673681; cv=none; b=mBeECYUzCxqAL0Ah/TbmnAJ3T+VXIaHzjb3W8ZH+gnx7bR53ygrDG/TCTfp+FloIwwXQ4USJXw2VLFUWPtjuyPfJwjL27A4IYI2ZHKFUo6pOWLR/dYE/luDVsL5Q9w/m9M77p2Zzv0HxtquxCNp5H77+F2GJvRlr5xP04de02Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743673681; c=relaxed/simple;
	bh=AartUfdzmIakqtvTSGNQy2kuO3AQ8Ql/dz8mA7GWclE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q4vQmn4vyQ6edYfpCMbWCF1W3iQ7aXBJNT4T2wyEPT8QnZQUJfXuShaQLj4fUkuFJ66gr7A/o5exBDl3qrP2oG/0uLw1D9l2t+GIIed7klIynbfQyLzGxKUj3jn3d/qgbQ9UYjq5itaPjH5iNj2sbQOEr/Vj1wSfV/kSUcuyrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A589C4CEE3;
	Thu,  3 Apr 2025 09:47:58 +0000 (UTC)
Date: Thu, 3 Apr 2025 10:47:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Peter Collingbourne <pcc@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v5 2/2] kasan: Add strscpy() test to trigger tag fault on
 arm64
Message-ID: <Z-5ZTNbc-sl51Rrt@arm.com>
References: <20250403000703.2584581-1-pcc@google.com>
 <20250403000703.2584581-3-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403000703.2584581-3-pcc@google.com>

On Wed, Apr 02, 2025 at 05:07:00PM -0700, Peter Collingbourne wrote:
> From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> When we invoke strscpy() with a maximum size of N bytes, it assumes
> that:
> - It can always read N bytes from the source.
> - It always write N bytes (zero-padded) to the destination.
> 
> On aarch64 with Memory Tagging Extension enabled if we pass an N that is
> bigger then the source buffer, it would previously trigger an MTE fault.
> 
> Implement a KASAN KUnit test that triggers the issue with the previous
> implementation of read_word_at_a_time() on aarch64 with MTE enabled.
> 
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Peter Collingbourne <pcc@google.com>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> Link: https://linux-review.googlesource.com/id/If88e396b9e7c058c1a4b5a252274120e77b1898a

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

