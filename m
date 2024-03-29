Return-Path: <linux-fsdevel+bounces-15654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA889112A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A82128CBCD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BED513B7A4;
	Fri, 29 Mar 2024 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9s4HHGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247013AD3C
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677314; cv=none; b=tz+UX5oRSpaUmWyCH/iIy+BCaI+yvsmEoSWCyEb9TfFXocxGNuQcaAIi1tP68YZa/iCuGTc3zmkzJhsDIDeqYu41tFoAE4BA2LckCyGkHNOrddHe1lslnGdifLq7m33zcrHSDVsMgS/YOho3ALuoTFM5GUaLjYGgv8oxT0Yo9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677314; c=relaxed/simple;
	bh=G/uTaIAkskzGcC6fM2pfc7BhIzgm1a5+YIJNknGkYno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhz3czNf/MD39hNCb+bTpJPhjmbUpdAfIGQN6YKtBtYN5D/ykvJoEkwg6oeOoPaI7oX13k+FA0C0Re/taMJ7Bxy6IgAWeOUNAUMzOO1LD5qN5m+KjuG3GN3KoggqDxCAO+82gVEZNJGCrrFTdeldVVF9OkCbnzp2X18Pz6GFWtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9s4HHGP; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1959799276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677311; x=1712282111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qesMvHPna2VGRQ3U+YOYTfZovmbGlRRDeWOIBEA3hQ=;
        b=q9s4HHGP1Y4POoajIPrDkRFEPdCRvS2tvrX+6OGtYUOgo4NIqyDXnOGi/KdTybGEet
         PQuVzJx312TkRUDLhPHbLLp2eesNLcj5SibFtAQpaPyFOMxS6FJa2ls9VhhB3WKCKdeE
         Wl2nvCV2mum0lFcjNmQ0oZ6ghC6BWszbC6BJCug9HPk62J7fLYPrd01vRMG9JuK1/Eyi
         eVt9xgde4BAUtQthbHOAF3WOTHlnmG2IbmAQJU8ev3xpRtu7S4IfkK6nDehk8TWKlbsc
         QPdg8fyRXRqCvJRUnrgNpMFM+q5eD5CCHdrP/nwMAOL+fdIgGKqYxkOFdrWs7B8j5QHK
         crRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677311; x=1712282111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7qesMvHPna2VGRQ3U+YOYTfZovmbGlRRDeWOIBEA3hQ=;
        b=cVPi5Y4krErVOgKmnpiWtOB4T5KFJRLa9InBkKjlU0FfhHlDuobLIiT42WZ4+SjbXq
         t3SvE0AO2g/cm1RXN7odHk6CkxAQsuBp/OncNd3/ataNzb8kAjE8n0o/oH5ZQY3QST2+
         J1TVB5lCxLwFCI/QmQC8fVsonQjctUSYuibI8UqZXezP+agdo30v/8tHYlSm7JjLkiCf
         8MPplPB8fRDossC3bYUwU5kH6M7fupY35hrUAttQ4c7sVYLjfnTGsAQbZGcX/rwGQVZ9
         g99n+8d5vhilf+vV2IUOI2hTu5Zo4v7x6nu3qQtZF2YP85HiEN56VEuLjpRxKrGfVs0S
         XcHg==
X-Forwarded-Encrypted: i=1; AJvYcCXM9URcEttQxhKrOcS5N6a4Uhs6CAMmbF9QSzlNws5f8fpSNM7/m0Gg/AVtIxRGFq/I3qAuqE4bxj8VDjwOz573CorwLKlfvHvBh0mFxg==
X-Gm-Message-State: AOJu0Yw9k6yMAgDk/Y5Q0tnSVwqkqg8c+kizESsFXDMEGmr2veAJ5iTM
	+UqDVEgCL7Kc18GL3YsVeP7JtV3SXh4OXzWV2uOx4qIauJWz/tZUQb5DHuBWv8dgjMbMKJglf2v
	0zg==
X-Google-Smtp-Source: AGHT+IGF9nW/lcLEYaeyMEZVwCHFKdI51EuE9NyugoSApHlrjqOTG5u7cGkQtddkr8oJLGW/eZgzFmc/WjM=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:2701:b0:dc2:5273:53f9 with SMTP id
 dz1-20020a056902270100b00dc2527353f9mr86822ybb.1.1711677311477; Thu, 28 Mar
 2024 18:55:11 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:47 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-33-drosen@google.com>
Subject: [RFC PATCH v4 32/36] WIP: fuse-bpf: add error_out
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

error_out field will allow differentiating between altering error code
from bpf programs, and the bpf program returning an error. TODO

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/linux/bpf_fuse.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index 159b850e1b46..15646ba59c41 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -57,6 +57,7 @@ struct bpf_fuse_meta_info {
 	uint64_t nodeid;
 	uint32_t opcode;
 	uint32_t error_in;
+	uint32_t error_out; // TODO: struct_op programs may set this to alter reported error code
 };
 
 struct bpf_fuse_args {
-- 
2.44.0.478.gd926399ef9-goog


