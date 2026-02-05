Return-Path: <linux-fsdevel+bounces-76392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDojIkF3hGkX3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:56:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E42C2F1846
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B6B1307121D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02B83ACA7A;
	Thu,  5 Feb 2026 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqpZJP7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7213AA1BD
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 10:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288711; cv=none; b=I5WL3T18E/EHKXl1fdEorfrpNfDI6Rk4EuAqLXIgxgCNupyoqHk6hnaBBC50kgDzpDrVk0XE/UKCEz0EZKeV/OXA2LoDr5DETm9CkopItDqhIWod1zQcrVigTvDz4b84nxEY1DUrHwH8Zsk2sLtrztIleCXdOuMDxHCuOaXQ2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288711; c=relaxed/simple;
	bh=ZUybTZ8FVCkafIsHSFbfu9SLz5ANj6JGje2uaPHESaU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D0UP447rLWS2RmjqOgVitM8iiXoSD5IQNowb8AMzf0ta0P0ismz2/8dczsEsdj1xMGQcpATxuQgkZrkwfEQ4ZeGDvAwwcyuJEDlA+nFvy/LdG2MS3ORvloGXdCMukGoqjjfqqjEcBdMtoQ0LBQTB7pfwUHwqRqK9JQJksvvf0xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kqpZJP7U; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4803e8b6007so6486435e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 02:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770288707; x=1770893507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wazCAdh5UgcB5estAlNP9lpZPIwk5UhZor5+EOBIZsE=;
        b=kqpZJP7U2TlmC/6cR1KI3Tdlkl51g004POIaw2ohBfOEHUaVFi8HpiGEuwXo4i/uNs
         pdCgnwkeeEAQrYT2ABWdoEXaDvvudHlh2l1zu1MKHWViZFSx07TZOYBg6inOZnvWd/4m
         Lb/O1RQ7am4I9KuctNKaBMk+Pk/saZlXOWr2BrcNW70Lwo/YyVjt/1GSLmCvltAga/Pi
         ghAaNtEvj8YkUjIvZjd+6OiSdOpFakoyiq3pD+Qnu8YA+P9XFv2+RXBSHaIEP0MYFa6X
         WAhD7YkqOVzqNHMb8N+47n/0l8PtI1T9sbJvgBBPjCBeAuDI9fYkkG81TKduTtGMhdBy
         7zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770288707; x=1770893507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wazCAdh5UgcB5estAlNP9lpZPIwk5UhZor5+EOBIZsE=;
        b=pEWTI84EQMZ2chqfp8/N8hX07Y6g5H017186rs+kgeHU0Dn5FBvnG6n1yLM4M5O8yV
         +NofWSS+2M798bu7jDqCVNjeuIt7w1kiffQkaLt18xAudYPeCnNi56uLyPL7HAyK95c7
         /uz28iRRWVyrvn7yUYoWeJJSQ3hP7FmaBVR/ROh/fUQsPUBMCmgStAMdBwS50ZB4+e5L
         n0guMya1HEvp2cLaEhrKhDnzx+vcn6T6jaIePLJe29AZDWAr/MyZdYQKZttYN2RLC6mw
         75LmdbfrGbYYjaYlwrYS4hXFpoJbmHF7Rd0hylVGP2W+EWtrARcv83cNlPOyhZfK9CRc
         NgUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQYgR/5L+Ut90QeKwYOTvNCQt9W//PRC4V4ujNeVippYQYqAVsoIKSn0vfcVm1uyCMGvar/JA+iE6Bupxe@vger.kernel.org
X-Gm-Message-State: AOJu0YwxoHIX983pfh8CtPStwval57/NxNxwteZVxvSIpVvkeKBBmN7W
	K9bvLZa4+epjxDOkH5zbqdGJtCklNLToAn5GxR7VNjcsjn05JfJEM8ZvZ8nqPXcoR6WzLbBDsKl
	m7++4UE9CK/6/jK2QNQ==
X-Received: from wmmr8.prod.google.com ([2002:a05:600c:4248:b0:480:1b84:b6e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3514:b0:477:b734:8c22 with SMTP id 5b1f17b1804b1-4830e92a7a9mr89953605e9.8.1770288707220;
 Thu, 05 Feb 2026 02:51:47 -0800 (PST)
Date: Thu, 05 Feb 2026 10:51:29 +0000
In-Reply-To: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ZUybTZ8FVCkafIsHSFbfu9SLz5ANj6JGje2uaPHESaU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBphHY5UiLUswz39KqBhHpeX2xIwcn8Oq7WgVuCN
 6qlYNhg4peJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaYR2OQAKCRAEWL7uWMY5
 RrC/EACaH/NwT7xKuwuN3MecASBmi9sF5WLKGr/aOsN9x+VVGOQWNcCz930/ZijztwT5T197Til
 wSVJS5LzKRV6rWMo0D7Vo6S6samyRUH1a3ZiDMa/giFTTrQs44r/Ph41BzSfPa0wWLOzBSaYWuU
 AmgMBo0+NGS9nqEOgTIGNAbxzSuMMVXvT6c5TtGeckYWfZ6vFjt+yI/jgsUhxFZ/jSCbUV3f7ZS
 kwbX3KgW3p6gbT+VnRci3kOwssFbZ7sNLTr78qtwmbNvI30b4v4jEUuU/C7parTf7LMIVzCqqDv
 nBta4IqMi8wqL8Dzsef7IpowXzq/mmV9brjxqUfgo3owxWj9fOUDVlw3fo3QrqrGPir/x03hNcd
 DlD07GP+M15auwzqri/MVlh0HcR/w1aNAqTSjZEM8+owD61r175YHqmlv2FtTCrnPE50VP8ddMN
 FN4H/uPH+K4lEjTHUIs51s8h1NlbGxFti65qOi4xKsTxYyEUI8VF8ceegUm9m8PNI/mBwryG8wd
 LFX/cBaXNkOe4dpuMfYhQqDd1jTzxwSbevCNqa275wy6QuQCzbCF2s9pKe3G8zDJfDws5QKM5bL
 y5oeKQkmFafvjThVLyen/QCXN5pIFkiSVDUETMSZE6cp/hmCaPgrf85ZSqIxz//JGZRhBCtPERL HEaoFDqsHlGyvQw==
X-Mailer: b4 0.14.2
Message-ID: <20260205-binder-tristate-v1-4-dfc947c35d35@google.com>
Subject: [PATCH 4/5] ipc: export init_ipc_ns and put_ipc_ns
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76392-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,google.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E42C2F1846
X-Rspamd-Action: no action

These symbols are used by binderfs as part of the info stored with the
file system.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 ipc/msgutil.c   | 1 +
 ipc/namespace.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index e28f0cecb2ec942a4f6ee93df8384716bd026011..024faedd07c333b23f1e8733833b84ecf5aed9a7 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -30,6 +30,7 @@ struct ipc_namespace init_ipc_ns = {
 	.ns = NS_COMMON_INIT(init_ipc_ns),
 	.user_ns = &init_user_ns,
 };
+EXPORT_SYMBOL(init_ipc_ns);
 
 struct msg_msgseg {
 	struct msg_msgseg *next;
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 535f16ea40e187a9152a03a7345e00b6c5611dbe..c6355020641a74c3be7737b9da15022b961d8f2a 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -210,6 +210,7 @@ void put_ipc_ns(struct ipc_namespace *ns)
 			schedule_work(&free_ipc_work);
 	}
 }
+EXPORT_SYMBOL(put_ipc_ns);
 
 static struct ns_common *ipcns_get(struct task_struct *task)
 {

-- 
2.53.0.rc2.204.g2597b5adb4-goog


