Return-Path: <linux-fsdevel+bounces-8467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1B9837192
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 20:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CCB2B320F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0A451006;
	Mon, 22 Jan 2024 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuBJLLG8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D141862D;
	Mon, 22 Jan 2024 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946407; cv=none; b=KBSne2XajvuRMnw/NOtvqSq67RQ5sBrTI9IqBCeeRR3G3TeBX7LEC4e/YvSZ+zfSD5cmSAYmEGS+WzEKTnGjp31GcgikUm3OIVHGA9dONqqTORWCuTaOiIbj0EaSIFdoErnLEkztdoX3rW2Rtq+YOj1OMzLqO4htyciYo2r6adY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946407; c=relaxed/simple;
	bh=YxA3FciUh7WHWBP8rVCXFrEYIPVi1Wiu8BGAwLHobBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDjW0FFdL5DMRviDqmImWYBrAYVoTbkBW6nuqjtPAs8kLxbhSP65al9Z0nnzg35dIFdj4qgC7U51KIxKs7by/r/zhw9e/FnLTau51d4BBhCPM3NVXc4v/vYZmUjDL8ZOwkFRv7/BlxsxOoBW/8fOh+CRa8o1KbfUZNZ016IIYZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuBJLLG8; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6818aa08a33so23933716d6.0;
        Mon, 22 Jan 2024 10:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705946405; x=1706551205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWHeU5nfhZzhpJGxwjKpWMEQyqrAZX6MeJJ3MaBUJ7I=;
        b=iuBJLLG8KCNxtDWCpJPHporTd6zJrQRq/ZCewBkdRPX6au+0wIOtRu2tjfydoOIk7Q
         1Hz8UiFB6SyEQjkbPTfbZIVfSKDgQyKU6bnknydy2jUIuw8kvfUQ+jzwnoqKh9yHxtV6
         nAgDdjhA4H7l83/OsgjFUecgHo9Jac27AWtyD1/v9YPKmftWVDjH9XhDVjKTkiun9vcK
         ab6g1X4sM/cDEU7zu/k0NUlQiq+QUisvyBQJQGUJVyje6Cufk3jfSZOutFFghkG2E6Dn
         s/TU7rkGCWIr4/RocAMeea9ImUv8cgJ9N6zpw2VQBW0esEdzlADi3O6Ks1AAkWtcnzwO
         EnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705946405; x=1706551205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWHeU5nfhZzhpJGxwjKpWMEQyqrAZX6MeJJ3MaBUJ7I=;
        b=MrFUjVIn0IyayqkoTk70FKy/BTlDxUVYgMzuyKckuP9A7Eu6o8QYuSe+htotwdmAO3
         818T9LK9iiDckKKaLbXnYLaPvEGiBtaVnzisUrJ2xt4KmTIt/HoRlZG3M0Ib0zUoIPAK
         q9L9ju75ajdrhBRQO1Eu/b0ydHBVnxv8+xswnGaX7NITeBnl9WczcR5X5HQ3TMW+3XXK
         bQAbCnsTDQWAjRyyORHJsr5J5lzai449TxAARA78qAXNbZN74eu23py7cyd2fGLY1PFF
         K9AKeNpAGauHxVS68IodE39gFRT2Hc0yBOnwTJBydj7OLx8ahtsCQ+kK2WGuCdykBwdu
         QQRA==
X-Gm-Message-State: AOJu0YzRq/mhPn8CqnsHg0VS5Vg2doivp8qa2H2naU2HXP1i6XrPI91r
	TwGb2Llmk/c0o39KbdE0va3rvuzzUPnQkmkLW16vdggfrYqf06IL
X-Google-Smtp-Source: AGHT+IGUIjD0P1Ej78kJM2emWkqZB/fgUU1RLgTBmY0AF4qHo9R8F4UrRs4yhvEtBHsUgxzdHBtoFA==
X-Received: by 2002:a05:6214:caf:b0:685:29b1:19da with SMTP id s15-20020a0562140caf00b0068529b119damr5878000qvs.12.1705946404774;
        Mon, 22 Jan 2024 10:00:04 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id kv2-20020a056214534200b0067f0a06c1e3sm2587292qvb.132.2024.01.22.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:00:04 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 859A227C0068;
	Mon, 22 Jan 2024 13:00:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 22 Jan 2024 13:00:03 -0500
X-ME-Sender: <xms:Iq2uZQ4OCUiSXsg-lxbfibO1GPZyq7CceE0aZ95Qdh3Fwnj2RG_6FA>
    <xme:Iq2uZR6sWS9D1yTjeMavCki5EoJBrDa3yAE577gwP4BAVrnT7J2_GzAKFYiMlErAb
    rd6K1wLkP2kDg4tMw>
X-ME-Received: <xmr:Iq2uZfeU2WDBqYJgtm0RGP1IJLzzdksyYwWopyA_14YvdWw_DOWImzJEqHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Iq2uZVLDEYP1o0zeuOeFpzf3i49A7AP0FReTKAiP0CZpB5fZ8QUjLQ>
    <xmx:Iq2uZUKa5yubdzpJCJyV7MDSAiBlgHTClCD9Ucx1msIrrxwxZ4wZKA>
    <xmx:Iq2uZWyW8rdTlsXR2DHdsad9Bm64tdYBGLHUB5GZHUmu-5thzabZjg>
    <xmx:I62uZUBafyQ-NpUprxsnp341muA_GdXRQuRTRuxGKMf8So3XwMRlvQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 13:00:01 -0500 (EST)
Date: Mon, 22 Jan 2024 09:59:25 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kees Cook <keescook@chromium.org>,	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Daniel Xu <dxu@dxuuu.xyz>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] rust: file: add `DeferredFdCloser`
Message-ID: <Za6s_dzKKJBwP2mc@boqun-archlinux>
References: <20240118-alice-file-v3-0-9694b6f9580c@google.com>
 <20240118-alice-file-v3-8-9694b6f9580c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-alice-file-v3-8-9694b6f9580c@google.com>

On Thu, Jan 18, 2024 at 02:36:49PM +0000, Alice Ryhl wrote:
[...]
> +        // SAFETY: This is safe no matter what `fd` is. If the `fd` is valid (that is, if the
> +        // pointer is non-null), then we call `filp_close` on the returned pointer as required by
> +        // `close_fd_get_file`.
> +        let file = unsafe { bindings::close_fd_get_file(fd) };

FYI, this function was renamed at:

	a88c955fcfb4 ("file: s/close_fd_get_file()/file_close_fd()/g")

Regards,
Boqun

