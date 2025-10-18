Return-Path: <linux-fsdevel+bounces-64581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185F6BED6FD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 19:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0AD8422D7B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Oct 2025 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71630260590;
	Sat, 18 Oct 2025 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dykkDPOs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181F3009E2
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760809576; cv=none; b=N3QjBUCj5iIWPq5FqdvMKwqcMx+ysh+bLmk61GnW1Q1/9vjf4HxQPQ+EHgtb60q/A9WJuz8fpXrR92iKQGRlPb9Ds2FsazNzNSZcgEGfpuvTDmiwLxh/YVQluIUVzVhP1Uaqlp+UMXUOe8s9N3YLK4aVGnslHvbB3i49dQqH0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760809576; c=relaxed/simple;
	bh=tThvb3NWkM3msr/ABoCM1JnbhTAqdV/nFrTXflsMRkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bNfBKZ1ZtfoEfY33XzQ9tpy3GX/dTAerUBydINYCpGSQV3UwXxzjVf4NjEGm3PvdWUfMT51YFMjJe88YYQvGYhnQshfHm8o9yAGIfmUfeTgN2R34Am0fo4x9/iOihlW69rGStlDvdak8t4UqO7VAcBFiqKXWbVpwVbbgiMRe0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dykkDPOs; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-87dcb1dd50cso14757586d6.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Oct 2025 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760809571; x=1761414371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9GrnMpI60PzKwG6+cJ/Jxamo/bOJKX+J9SwLV1KKddM=;
        b=dykkDPOsKqZYhPS9KYiY6lWr3Z0ZhMJn/5+4vp0BTSy949tm1GzCG4Gs4d8CbqDTmw
         Zx9kfdyOJd66v2uOCSmdehWOBQ4WSMbd5WIFO8M1O479tSt1QJUZY1qw/fF0UKUhRAS3
         zj3b3my1775SIQRRNobdfv1RmuM/sAX2cO47BYAxiHgZqMgkR1Yl0Tf8O1tPo/iEzk/D
         Y3mEEmCKxS1m1nhBp0Ld9zE9iAUPtUj5NeyNtdM1ZEykp8SvaEWaT2lbMZwn5gW69N6D
         JZg/xKyDKNhr/pqwSsuSke8N9Seabin4wwyC1SInZRrYneH8EaOdqkLCPvySu+hPhhXz
         mYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760809571; x=1761414371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GrnMpI60PzKwG6+cJ/Jxamo/bOJKX+J9SwLV1KKddM=;
        b=MnapL7+UoNEnlm+o9Pd1qyvt6i5HzXzZoil7FKf/anRvKLgibi7ih9qy+t5rjrQ1aY
         CnE2ba1BtQGaZYtSzuWmWR/HirKCgkNaSyovF0uzb+cnFxzDEP+afQFoM3bbOZ4Gql+O
         uMLezOOGeYm1kHf/zgir39GlSQjSlMzirHDBJ7wazbvL1AsrnP1XNQGEeYtXtVuY4na5
         oeF56fQQvTuOjcXDZj5RPgmovr3ImxXLVzksI7xXrFXTudQcUetIwrsFICr3tCH3+9ge
         mJUZzRuSuHK0GA6dpvzJxakwXwrIohl+/5vHRX8Gj7RLEvoVCpZjYi7gDv4A9e9GAPUi
         DOLA==
X-Forwarded-Encrypted: i=1; AJvYcCVfBjzCK1YvjUm/dolSQ8t/aybGA55ZEvFYEqkj5SA6ivMuKi0cVArqMI9SJS/X2xa1yUeI6nrboX6K/Top@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3P0NxX8VkvJA2sDyte1/6slVvGElA82U7Y86JlTMx/XVj9hDZ
	kyticlsj4miprhdA8G5yoYiAeV4hw0BUKcYqdVQifCMTQpqpwlOOHtis
X-Gm-Gg: ASbGnctyQPNVXnFxxdeWU99NKcPuKuaDBDDicN/4IfzrjOkjKGouMt8wXBCGDAGZfOq
	Gjx5VuPMjRunkuLxFr9H5GipWznYufqgD3BjJ6yFpMczcIGnO/yX4M2mWspxpJuloLPgSBhZDr+
	iiZNbuxOxsnHCDswvxngUOOYsO/H1YxuEx2LJVe1X5+PqZOeec6fXj9uRuQi98Jw7qfY1TQX4z4
	bGuafCo4oU1LRuJ21FY5CfNuDTa3d7QMyK0h0cHJsBKr3XSHG40Jmb9pFQ7r/7vPatcPogHLPw3
	cHkl7P5a6gj77J6QN4GGR453srsaCyeTwJi6ZykLaEUiI+4Ze+nfqfHUG5/WbzKzcX9uFGSNiq5
	fGERNRkCfGd1KhUOQGK1KOgi6CN5VGS0ntbfY7wdV6ZH7qDw7ekOtI/9V4j8UkYgYw1srLSW3FD
	b8oNL+JcFpIznLD6JEADhWj+XF5GZ9FPYt+7uudLUayur6x/lik0MOwfPsdas9il4N44vKFjXSB
	zmoOyeitqsUSAcbc5ERhiFJO6kr1yXpBfSzYUqsSqzqwd8RW2+xFX2r+yxQygc=
X-Google-Smtp-Source: AGHT+IGZpCN4j9tmhaYbhdNdOMD/u+TXfP+iW99iy32Lbo2Vps7+kQzJb2YNFmaLWQVUUZPeDTJH+g==
X-Received: by 2002:ac8:7f0b:0:b0:4d4:4a2e:531a with SMTP id d75a77b69052e-4e89d29ad47mr112932081cf.30.1760809571213;
        Sat, 18 Oct 2025 10:46:11 -0700 (PDT)
Received: from 117.1.168.192.in-addr.arpa ([2600:4808:6353:5c00:1948:1052:f1e9:e23a])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab114132sm20445161cf.40.2025.10.18.10.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 10:46:09 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 18 Oct 2025 13:45:22 -0400
Subject: [PATCH v18 11/16] rust: opp: fix broken rustdoc link
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251018-cstr-core-v18-11-ef3d02760804@gmail.com>
References: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
In-Reply-To: <20251018-cstr-core-v18-0-ef3d02760804@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Carlos Llamas <cmllamas@google.com>, 
 Suren Baghdasaryan <surenb@google.com>, Jens Axboe <axboe@kernel.dk>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Uladzislau Rezki <urezki@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1760809527; l=760;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=tThvb3NWkM3msr/ABoCM1JnbhTAqdV/nFrTXflsMRkU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBU9F3MfxxHsWXZNGSoYZmn2+0JKsH4AOCWoX3y57VzrfMaGPAHTAxZv38DFnb0J2kyhK3EDxZd
 2sBHoMwBFnAM=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

Correct the spelling of "CString" to make the link work.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/opp.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/opp.rs b/rust/kernel/opp.rs
index 9d6c58178a6f..523a333553bd 100644
--- a/rust/kernel/opp.rs
+++ b/rust/kernel/opp.rs
@@ -87,7 +87,7 @@ fn drop(&mut self) {
 
 use macros::vtable;
 
-/// Creates a null-terminated slice of pointers to [`Cstring`]s.
+/// Creates a null-terminated slice of pointers to [`CString`]s.
 fn to_c_str_array(names: &[CString]) -> Result<KVec<*const c_char>> {
     // Allocated a null-terminated vector of pointers.
     let mut list = KVec::with_capacity(names.len() + 1, GFP_KERNEL)?;

-- 
2.51.1


