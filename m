Return-Path: <linux-fsdevel+bounces-29416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11AF97990C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 23:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F36B51C202F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 21:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52901154C0C;
	Sun, 15 Sep 2024 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/EEe4lg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284C13957C;
	Sun, 15 Sep 2024 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726433907; cv=none; b=G5dmQ82TTnSiCj4VAHgZHfyzWPeCuLIPRvqi01Qo4LnJgXG6JT7DBlLreg7Qnup2Wcw9WRyzmJLWH+1i04UiedTcWBNcPz3VE3OUgSLlT4Ir8V+q3zxiJObp9TzJpP65XvLGTIC9RmCe4ep7zIpY9DYixpTY+kV5lxNSiaVpqEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726433907; c=relaxed/simple;
	bh=4V3SRR+FZAgian5StshYXg7T5uzBN/vCNE9P+OlbYDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVt+CSk0LKz+4FmA0lyRq/ag2G3LvPj7/LEQFnXB9VDOljbxzh9zh60pj0+dCZGAhXfrPO1U1mfiHrHPwfWqRmeieA1SzVLaaxZYxWNm9tsIS5FVNJXaydJaK3Q+yiFoaBniS5K4P9zeOK8RwrTJu65E3wXhiXnmnvgkYs02EJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/EEe4lg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100EBC4CEC4;
	Sun, 15 Sep 2024 20:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726433906;
	bh=4V3SRR+FZAgian5StshYXg7T5uzBN/vCNE9P+OlbYDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/EEe4lg+pb90OXlzXQpdOu+V9e3CQ50R1htqSgleUtlh4fvJhmKUZEy7LqshbQMY
	 SYQ6sSuQ2Z7JAdAdPKHIJbGTGclmOzNKa7SC5DTrPKpTz+HO+Wt7sRITF+PVLjH8WL
	 RVFIMQ5HlGyCjYOxhssEAhZOhkceJECPQWSkRSvTDoD6zC0hY3T/nA8TDnafqIET/W
	 +n7Zx+4xQX2MdXnDRbI/ssbffP95O5mvUK2PDIYclfmD8W+3H8vOk/0Bi1463xyW3P
	 JLb+o1Zm3eQsoP0RbTgT/05df58L8xARGIhiCU+CTRC8aDUSDjEd79G26p+QxEHDEn
	 H6bxFaLtuiUCQ==
Date: Sun, 15 Sep 2024 13:58:25 -0700
From: Kees Cook <kees@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v10 5/8] rust: security: add abstraction for secctx
Message-ID: <202409151325.09E4F3C2F@keescook>
References: <20240915-alice-file-v10-0-88484f7a3dcf@google.com>
 <20240915-alice-file-v10-5-88484f7a3dcf@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915-alice-file-v10-5-88484f7a3dcf@google.com>

On Sun, Sep 15, 2024 at 02:31:31PM +0000, Alice Ryhl wrote:
> Add an abstraction for viewing the string representation of a security
> context.

Hm, this may collide with "LSM: Move away from secids" is going to happen.
https://lore.kernel.org/all/20240830003411.16818-1-casey@schaufler-ca.com/

This series is not yet landed, but in the future, the API changes should
be something like this, though the "lsmblob" name is likely to change to
"lsmprop"?
security_cred_getsecid()   -> security_cred_getlsmblob()
security_secid_to_secctx() -> security_lsmblob_to_secctx()

> This is needed by Rust Binder because it has a feature where a process
> can view the string representation of the security context for incoming
> transactions. The process can use that to authenticate incoming
> transactions, and since the feature is provided by the kernel, the
> process can trust that the security context is legitimate.
> 
> This abstraction makes the following assumptions about the C side:
> * When a call to `security_secid_to_secctx` is successful, it returns a
>   pointer and length. The pointer references a byte string and is valid
>   for reading for that many bytes.

Yes. (len includes trailing C-String NUL character.)

> * The string may be referenced until `security_release_secctx` is
>   called.

Yes.

> * If CONFIG_SECURITY is set, then the three methods mentioned in
>   rust/helpers are available without a helper. (That is, they are not a
>   #define or `static inline`.)

Yes.

> 
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Trevor Gross <tmgross@umich.edu>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

