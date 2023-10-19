Return-Path: <linux-fsdevel+bounces-776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F7A7CFFD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 18:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE5B81C20E7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88429CE6;
	Thu, 19 Oct 2023 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS01mPqG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E39208DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 16:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8357EC433C7;
	Thu, 19 Oct 2023 16:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697733762;
	bh=rF0BRiX64t8aoWsH1ntm/CUWz4Tnl30Pg+AbeCttr24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DS01mPqGmfuhLWNvjote86j5gw4Ko02cL/UyQ1NTYfMWi5O2oTxgWBVVIUljoRKyf
	 ZgWU3BaeocNScdBebIbotL7+mFqVQuoRh5SI4ZIhgZ1qMVgruChmKVzIQKyjrG0GOb
	 /w3E7qydPb9dI49Fm/1SSB8ToskWgfR3qyhW3JirWH3bVKTqoSjLJDetuyRbHZqrT8
	 jyiNZtfNYfqanOsgSgE2pzklHYKlYETkDaiS8dhRgqK3GOpMB8h46yIEj/VfLsBIlO
	 3piYfTXhlGAXW9uIl4b4x4bjXeplzrHKa6RhOorHrUYD/KmxdL2pfhgWoTMxdBAulS
	 qdd8eUhGLq5Dw==
Date: Thu, 19 Oct 2023 09:42:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Kees Cook <keescook@chromium.org>,
	Ferry Toth <ftoth@exalondelft.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <20231019164240.lhg5jotsh6vfuy67@treble>
References: <ZS6PRdhHRehDC+02@smile.fi.intel.com>
 <ZS6fIkTVtIs-UhFI@smile.fi.intel.com>
 <ZS6k7nLcbdsaxUGZ@smile.fi.intel.com>
 <ZS6pmuofSP3uDMIo@smile.fi.intel.com>
 <ZS6wLKrQJDf1_TUe@smile.fi.intel.com>
 <20231018184613.tphd3grenbxwgy2v@quack3>
 <ZTDtAiDRuPcS2Vwd@smile.fi.intel.com>
 <20231019101854.yb5gurasxgbdtui5@quack3>
 <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTFAzuE58mkFbScV@smile.fi.intel.com>

On Thu, Oct 19, 2023 at 05:44:30PM +0300, Andy Shevchenko wrote:
> So, what I have done so far.
> 1) I have cleaned ccaches and stuff as I used it to avoid collisions;
> 2) I have confirmed that CONFIG_DEBUG_LIST affects boot, the repo
>    I'm using is published here [0][1];
>    3) reverted quota patches until before this merge ([2] - last patch),
>       still boots;
> 4) reverted disabling of CONFIG_DEBUG_LIST [2], doesn't boot;
> 5) okay, rebased on top of merge, i.e. 1500e7e0726e,  with DEBUG_LIST [3],
> 	   doesn't boot;
> 6) rebased [3] on one merge before, i.e. 63580f669d7f [4], voilà -- it boots!;
> 
> And (tadaam!) I have had an idea for a while to replace GCC with LLVM
> (at least for this test), so [0] boots as well!
> 
> So, this merge triggered a bug in GCC, seems like... And it's _the_ merge
> commit, which is so-o weird!

I'm not really a compiler person, but IMO it's highly unlikely to be a
GCC bug unless you can point to the bad code generation.

If CONFIG_DEBUG_LIST is triggering it, it's most likely some kind of
memory corruption, in which case seemingly random events can trigger the
detection of it (or lack thereof).

Any chance it boots with the following?

diff --git a/include/linux/bug.h b/include/linux/bug.h
index 348acf2558f3..29e9e3498902 100644
--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -84,7 +84,7 @@ static inline __must_check bool check_data_corruption(bool v) { return v; }
 		if (corruption) {					 \
 			if (IS_ENABLED(CONFIG_BUG_ON_DATA_CORRUPTION)) { \
 				pr_err(fmt, ##__VA_ARGS__);		 \
-				BUG();					 \
+				WARN_ON(1);				 \
 			} else						 \
 				WARN(1, fmt, ##__VA_ARGS__);		 \
 		}							 \
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..395c4f5d8aa6 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -25,7 +25,7 @@
 #endif
 
 #ifdef CONFIG_DEBUG_LIST
-#define LIST_BL_BUG_ON(x) BUG_ON(x)
+#define LIST_BL_BUG_ON(x) WARN_ON(x)
 #else
 #define LIST_BL_BUG_ON(x)
 #endif

