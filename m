Return-Path: <linux-fsdevel+bounces-70477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1A7C9CCFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 20:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5AAD24E0657
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6B02FBE05;
	Tue,  2 Dec 2025 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YRySokJL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA242FABFE
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 19:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704308; cv=none; b=Y+sswpgC/U/7rsGi6vtED54G2H8QmzAv2LfYq3MRN5L3tx+2U7X2NOBEGYzhZGQl3WRG7a/uYZT6IgaUtL6YZyr6q470EHXyWhejDY+TcxwIk5UMulCvhy1wuI5QIuiYkG+eNiS/NS60wlJboB3Tj8utawR+EwQunYvE+w1ZtaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704308; c=relaxed/simple;
	bh=ZfkP33VcqvWUNnVMxmueuVO7iCL5H6N3VM5f/NFItZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MguMYQhUj5gAoTQMDcz8b6a80hXZLoT3Ij6EyYfzYFxCLvsczHGla86eCkFZQfpq6G5cbVGjEyWBmZcgnLe8LbBw4HW7OQYFbh9XzuG5SoszSzOqs26R4Pt14w0bIa0NJ8HJ/wjQOZPHNNpNHfnq/1v46cR4433YhxgB6t5QDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YRySokJL; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso3561794f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 11:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704305; x=1765309105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HH0tVHLG3ca9kBOTOLq8pgJbAOcVBVaThO/dyel0SIk=;
        b=YRySokJLUThIPVm+gTfU9T8NE4n3c+XnKmUBCVj1A3HgLPFqRn1YK2GnYOqcBw2MfM
         /+EaxZQgZs4q9k7DRt78Y2ioCiRbbOWYVrI1iTJp2wT6rpQAGNvcwdXtY19sqeAM+zcf
         crODL9Brb3nNyqQTL7QtU7N6Nsw8Hbvt07RFpThR8mSpbEY9ulpfUH8vQGg5XG7bglFa
         H2mrSsM1SYIBoHUUDtqDL88CCPjP0+kNt3KNZyc2sU5JPX8pEg7bBocLztrQ39RJI6Fx
         itHLFzKXpnADEVCVPjnPt64Ncv+oKJ/IMx8JoHHh5cycIV4Y9RSOCo1HSt/YlVClxymc
         dGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704305; x=1765309105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HH0tVHLG3ca9kBOTOLq8pgJbAOcVBVaThO/dyel0SIk=;
        b=h9xlIPTJLYTPkivT2EMw+sxlu/a4K2wK5Nc5P2JAz2XAwbOV074KTLB4uISMgP4tWV
         UkJxBQkaeio7I1bL41CGBYb1+iSNWoTKE6Dm1PHDxYi91ZqvxhN5UxbdtxoG66D+UwY8
         su4R4dTABuekZZG3u5fs8rUvZzyc393AqUs1EAf3LUuyW9hz4Al8arkRYtY8DedOzaAy
         HbyHCi+Pl+Rr6JecVKk0+xu0+WfG6lY+Cq76yAgU3LjBLS+XqNFXVElNcBNZqde2K5SF
         lLXeNOdTQLW1fcPW2twxJzTsREtxcehHRQSnbjL/Ln0mgxXjkkYQSGf97crXtAJ1rWKn
         ZYSw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ1e0IBphQxlnuM5CI+0aMp4vGFrNlxNfOJ4mSdG4fafVHWBE24Mootny6hfuNAOLGXvNNVPQs+gXnw13u@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSy3dw60IXb5BU2JZYVLQq6Q5Q+paNfFRlEHvwUKG/SPjWiHy
	/HW365ZiytS3acE9zXCKGJAwyiCTBMLI9QOxVFmaeFT0rhvdn6RwPShqa3IHeCPsUOiT99hy8Tk
	AyQ7ZyhV2prdZJOCfKQ==
X-Google-Smtp-Source: AGHT+IGf/V7uMCrPGDznI1ahB6Qjky/a/3TGW12QgcKWncVdeiPUB9bmFpIWoqj96g3SR7EqCpOa/x+z2oqUhrE=
X-Received: from wrbdn6.prod.google.com ([2002:a05:6000:c06:b0:42b:2ced:aa88])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2f85:b0:42b:4247:b077 with SMTP id ffacd0b85a97d-42e0f34fa15mr34531491f8f.41.1764704305201;
 Tue, 02 Dec 2025 11:38:25 -0800 (PST)
Date: Tue, 02 Dec 2025 19:37:53 +0000
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ZfkP33VcqvWUNnVMxmueuVO7iCL5H6N3VM5f/NFItZo=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AJwLCgR7mi0GsjPC1OLCINkJCKuI0xJ/WMJ
 wKkUshrxeqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9ACQAKCRAEWL7uWMY5
 RkQIEACx0wChzM7/WLtBFZYMdf+NlCmVZYNJtDxNf6q/dKCjt4O3ZcntsoScZYgpn6VCBrxe3Vd
 Gha703JoobNb4pQymxebJXzQnruwYEvAYYf7eoFVWkA0+2FD0EjcDL7lfjEv1XcXjGRM8CTxS+0
 2apvW0AmezBe3ecv3BTuLA1LrvdDiLVRlmehFar0twMSIaR8fkGorsuZhzbg2FFKFiImVs2OR49
 ln4zIHyj3E7NbEUvkMdgyE23heKlfE36mtoGWbaPoNmlaqP7fPQFUXB8AhxWWQCycvXlqJTJoCy
 8w6CuL1T0A6eqc8nttjZQvizHPIWD4Pyo0Gl6itMxHhPycw1y1afYEUp59h6+K44k1J71djL6z6
 quehTuVL8skx1J2X5zec6fFbyMCiBBOHv3h0I11IgSm5zCs9AerzHaa74UmFWa0N2QWdqjGb393
 VQUKmH1AqdnfUGOXqZGqnO3xiOlm+N+skoGyIIgrN3e1gLrM3a+q11QZquMwXZCVqvQiVwbsEps
 hazA/NAsJrfOfTJE29TFqXntaOTPsSp0Pg2EHpVB0H/NWd9WlXodLf0kiCcIdn24oy4qPjtcx8Q
 RACdWdkVJSPysrZ6tWlONK6KtUNj9/huNAHGgBOtmqjkum7CzwlezILWCprgV4nVqfKKwvH7mwu 6tGg1kGezOvl9AA==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-29-a2e13cbc17a6@google.com>
Subject: [PATCH 29/46] rust: poll: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
 rust/helpers/poll.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/helpers/poll.c b/rust/helpers/poll.c
index 7e5b1751c2d526f2dd467fcd61dcf49294d3c20d..78b3839b50f065a7604dd80bc0fdbb5d8c50b430 100644
--- a/rust/helpers/poll.c
+++ b/rust/helpers/poll.c
@@ -3,8 +3,9 @@
 #include <linux/export.h>
 #include <linux/poll.h>
 
-void rust_helper_poll_wait(struct file *filp, wait_queue_head_t *wait_address,
-			   poll_table *p)
+__rust_helper void rust_helper_poll_wait(struct file *filp,
+					 wait_queue_head_t *wait_address,
+					 poll_table *p)
 {
 	poll_wait(filp, wait_address, p);
 }

-- 
2.52.0.158.g65b55ccf14-goog


