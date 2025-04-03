Return-Path: <linux-fsdevel+bounces-45667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229BA7A87A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 19:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6D71899164
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 17:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A952517A0;
	Thu,  3 Apr 2025 17:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCdr+qHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC233DB;
	Thu,  3 Apr 2025 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700813; cv=none; b=CMchTA/JKw9/V+rzZ5OjLOLyfQ7h9RrRD3K0dnMeCYnaElMn+wKGEQuR5MyFA4xJ9O31dx+4Ky8P62j4GLN2U+QBq2rL0nxqLu/pDMOLjq9S6DmMJH7EBFOPrTpEhZ1Iuvdei55g2+oVoIh6x1hFVUNyEPiUjLDo8sDtpNoFtTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700813; c=relaxed/simple;
	bh=sFuYz6JPzsyLyw23Bxb4nuISYFMQwzsbDTizTe+xTfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXdDk5EdwmkZ/7Z6IbNvGGy93zEGma/cD/9e5kYJxFSXyI8rtOwfOAQCEhbpIgWpnhuZSIo7TiVH1OqeVGo1gLr+LiTYtQ/mUW6yQnKv1Amxmush2y2sUKRW58uLZ2ZCEQWgLV4oGG5ce9nfXN+UGVy0WSRmUxTPebt75KF0rcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCdr+qHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECA6C4CEE3;
	Thu,  3 Apr 2025 17:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743700812;
	bh=sFuYz6JPzsyLyw23Bxb4nuISYFMQwzsbDTizTe+xTfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UCdr+qHrUzxqGXD00oLkRgLfGfi6fPu309b8L/8qRnEdTB00l9SA1GeRAx7OHPcY/
	 /Ug9G7RoIVBBZAgkWBt2Uu915t4MF9yDLzK7AxkYTeCfa3jUPE34OOEbXhza1NyGON
	 ktFLz9RJuC370d/OG5Lsv9yKmgrIPW5KEVhTFakHNRkne9ilukh3IQ7gD6Bu/iw4Sm
	 /EgNuvyBAUYmQYRADU9DS/H8XRFg/2YlMw1XeobLWHby5ie8zPDnTdwzp8HBz0bgEY
	 K1DANIO1VZfN4L0kPmCDuupJJhry19CslLl1lubkAH+Yf2DtIyc0TVqcmU/2pkbGzK
	 4A+6r2cR+RQSA==
From: Kees Cook <kees@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <pcc@google.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
Date: Thu,  3 Apr 2025 10:20:07 -0700
Message-Id: <174370080532.3186212.8943506811501747476.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403000703.2584581-1-pcc@google.com>
References: <20250403000703.2584581-1-pcc@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 02 Apr 2025 17:06:58 -0700, Peter Collingbourne wrote:
> This series fixes an issue where strscpy() would sometimes trigger
> a false positive KASAN report with MTE.
> 
> v5:
> - add test for unreadable first byte of strscpy() source
> 
> v4:
> - clarify commit message
> - improve comment
> 
> [...]

Applied to for-next/hardening, thanks!

[1/2] string: Add load_unaligned_zeropad() code path to sized_strscpy()
      https://git.kernel.org/kees/c/acc66d46810d
[2/2] kasan: Add strscpy() test to trigger tag fault on arm64
      https://git.kernel.org/kees/c/48ac25ef250d

Take care,

-- 
Kees Cook


