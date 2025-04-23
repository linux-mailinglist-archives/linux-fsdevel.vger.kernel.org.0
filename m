Return-Path: <linux-fsdevel+bounces-47095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DADFA98C03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 15:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D12E5A2299
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 13:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17FF1E1E06;
	Wed, 23 Apr 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsj9dmlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C31AF0B5;
	Wed, 23 Apr 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416489; cv=none; b=fHKA60g0ae7evhRatWgg3pCXYqm2PUJkn5GFw1urT2TrrmRSWUKMvQYRgY3qgQWHGsy0dHbSnW2qgb2ChAoD/Ii1ahE/ge8BlpcDU4tcBfl+BdOAb8fPLAK8YUtd4lE1ZzjAaeajQPp39do4r+2T0Tj8Rjs1jRdL4Kyx0xszLrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416489; c=relaxed/simple;
	bh=OTgMdZaw+c5NGr/9Til4thtTT36TGX8yCwq4TYTPiks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xx67uYPsVtoFsqfbEpb+jml3yik7IRaowWDycgXr5ltAeqryMhIEYypr0O3Y7CotgSZGJuyfPiXlwhXLw2FqFhxaH/b5ZCo/wDrl1Dg54avPiid6gNeEafT52qji86IHUux2ecWW8XeyrgmzZ58wBtOgrLSqy0wdAk+JGqfQYkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsj9dmlI; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476977848c4so72577681cf.1;
        Wed, 23 Apr 2025 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745416486; x=1746021286; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CuqgNpQtYEXMZS1DrSHgUIFvXUKBF5Ic3ONpr4JBBA0=;
        b=bsj9dmlI/y+qVwuPI8z5UWasVIqaUpV5q2DST2q7hyvF4+w8TRgf1FlNq6YddEkW3N
         5/LrQdeCNE0p3ElzNCBf3HzI9ixCZW29Nj05MT7KhBeAcAgMr1YHivhaFwwf3h81vfIx
         bYS+kMIGxrxrqxs4xlT2AS5HLoI/F6B7g/VJ6C/CShJ5Aazf2jMyF0POrxDF3htPWawu
         zoA40ZWInPIfe7Hg3N64Lo19P1pNC/ZqyFDGtkbrgek6d7Nbmx2o1OAx/QATc2Fgiaaf
         d2zjw5o45RgHe/W66l5QbO82HG8QMuwUv/NrBjkzDkEtlbD+yuyYcuAEivOohJnL7rib
         5LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745416486; x=1746021286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CuqgNpQtYEXMZS1DrSHgUIFvXUKBF5Ic3ONpr4JBBA0=;
        b=WkeF8EmP46PtUhHi+0nykwtH7B1oP18MKy1dEYaCynXW8bjQxxx+BbSm5eoPxFpQJ6
         ToFm/yE1pPHd8rC91eZDjoWebqo9mTJWr2S/dt3f2ZQ3w/3Aj8Uc20fCoaFmBrANkNtF
         lxXLhhElzjg71GyxCQpVBlRGwm55OT6a+2puJkivKps8x2NNdmCwxvb4Ry4YnKBsKs32
         LXYKAiOwwHIyVyANVMA8rZX452ia/LYxKxDeRRbQeY1N1bj+Fh332PKYKAZmpOHQZDbQ
         MBk8K3KFyM6d4/nv2lUPWdlJPSTE7LBSu5WC45a5nOrySmfpxw5C1ve34MaluHLckLbC
         LS0w==
X-Forwarded-Encrypted: i=1; AJvYcCUFdOSgHAjBXjjbyy/0EqFJ09XHGC244viMaaOg+5p6XgnuhsW1pLawnKu4eUDLNJHtyYLrZN/guIbs28CU@vger.kernel.org, AJvYcCUZYderfpL79wXZeaQqfhd7ZOJ4X2n1gantCzRQJ8tcb0+GNSaJeSyDrSUZzHLeWrWe6d7/i1d35OdJAnyr@vger.kernel.org, AJvYcCWO1L9JPp75OVmy/Ljm5qJLLdE7uvVlydwPVtHBkTl8idQbtLSChi7oGMxJXjptdcN3KVB1Al4k3d1O@vger.kernel.org, AJvYcCWXwhC/d5VFvQeCc7q0Qx3+KXaxxHbAu2VMZlBivfSUT1VNCF1wvo7uXuDibrpQDJVqWZtCHjaBzZlfthObzwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgW1uuisN84477ie/eBYrm3URdIcAtm/6lNOOd0evyMTVzZkw1
	bzOAFitybbCbkRFbiSfYOoMtB+2mClsya1HoyPAGlJ6ZJHOJ4nSw
X-Gm-Gg: ASbGncuFp4O1qhuaWyX2oTgFFA907CBHvGycdecpfF1eAzVwy+xR2RCj6Im8lrWjoxQ
	6t1J7tfp4G/VLSbc6RFOc6EJx3jiXmAEe0mfjjL0E8pcmCN9zg1hHbBE05bLjZZIsTXG/EEcUOx
	ddKdG3bJwCb2rYnusd7eWP9sNjLvLP8hLC5OB5LYyDwReiJ2QWFLNxrf+RhHVKqAY7FC2JXACFc
	ri35CwisfJz/bLhiRWqAK93SP09uz2iP+bljIAWXRrFCkdmt/ELNFc4LGVfCdJBGNEVoQNep78h
	sdOu5SislPEf0dSi+g6M8jKwp5LB4ySE2RkE648D/1uXv731ILOoSjC/aFfds+q/2xc0ykzEicZ
	1ioFYJ39PtCAWhvtY7Vr4/ydZaMUiWsmqPiH6INRe6sm+x5MrAvjEghr8UUnn
X-Google-Smtp-Source: AGHT+IGeEjYsFDhltXcZCq9irwEbKANOyTBHg4Za/JkGXn9YfvMrHB2vnBRdejBXniq5yhRW3lC/Ww==
X-Received: by 2002:a05:622a:28d:b0:478:f03c:b3dc with SMTP id d75a77b69052e-47aec491329mr332173931cf.41.1745416486510;
        Wed, 23 Apr 2025 06:54:46 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:e2b6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47ae9cf9f7dsm68135461cf.74.2025.04.23.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 06:54:46 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 23 Apr 2025 09:54:39 -0400
Subject: [PATCH v19 3/3] MAINTAINERS: add entry for Rust XArray API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-rust-xarray-bindings-v19-3-83cdcf11c114@gmail.com>
References: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
In-Reply-To: <20250423-rust-xarray-bindings-v19-0-83cdcf11c114@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Matthew Wilcox <willy@infradead.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
X-Mailer: b4 0.15-dev

Add an entry for the Rust xarray abstractions.

Acked-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa1e04e87d1d..925d64be9dd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26310,6 +26310,17 @@ F:	lib/test_xarray.c
 F:	lib/xarray.c
 F:	tools/testing/radix-tree
 
+XARRAY API [RUST]
+M:	Tamir Duberstein <tamird@gmail.com>
+M:	Andreas Hindborg <a.hindborg@kernel.org>
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+C:	https://rust-for-linux.zulipchat.com
+T:	git https://github.com/Rust-for-Linux/linux.git rust-next
+F:	rust/kernel/xarray.rs
+
 XBOX DVD IR REMOTE
 M:	Benjamin Valentin <benpicco@googlemail.com>
 S:	Maintained

-- 
2.49.0


