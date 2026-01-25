Return-Path: <linux-fsdevel+bounces-75393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fpBiM3mBdmmuRQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 21:47:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1344C826AF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 21:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519073004F75
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jan 2026 20:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485DE30C373;
	Sun, 25 Jan 2026 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2u4XCCN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FB5482EB
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769374066; cv=none; b=to3UwZUJhXpoIcuj3Vh/fPCxokSoG75SH/tsIRp+iG06K0i3BjhKAljmnrmWIKRsFOf0I+OhSczzJsBjrh80X2nIrQGh8QS1+JBGl6M1tsFhF895wPZSu0e6QY/kUFXKSJ8+a38GwaFfACrQHXhX6nNxSJ7FEzYZlACssYskCE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769374066; c=relaxed/simple;
	bh=LH1jC5c1kGjeM88R84d2F32DvAZKT1npv2iWUscmNzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fC7hMoSyBoUG0kcurhaU8Q11EM/MXnD9KkEdVpiMKSi8B9Q1i7nQH2ud3b6Hi/7ZHDWHBV4qGtHyWpDB4C85O2UddiSyM6RBkifGMzVZ/XqlTwGU3h9oqBg5nCQGuPAUgJVO7nxQigyqIuItFjk30yoCbFkFzhgOTKIUQ1QrDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2u4XCCN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359a16a400so3587088f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 25 Jan 2026 12:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769374064; x=1769978864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrOnLwvRLG3JEc1/1HSkUCyAsStaYOH2lsmBWKKbgf0=;
        b=U2u4XCCNrzoG9WEehpV9RG9iWcDF+/RLgra8O3lqj27HzSZbaUBVmlvQUa7mArBpg3
         492zzkn5MDjkwc0cqaLzYg8N7QXO6pXLgOEr2s0q5MNMXLl5mtHsjPZjOOe7agu3EEGx
         aP0Ee9r/pbubhNniUeNXgtm1Km/Zjt+xLtRWPFgGpISarxQUf+JHIBDwR1kuOii555GI
         fqT/VTOW2q64/yR0tr14fuWh6hTRH+/HhEozgba9eVJKfn/Rcg6qMYrwveMWoshnbENR
         SeZ1JN+dA6WEkCNeI2NM7wVnCaIS7/L0wewlziXm2P5s6m4fT+HYcTPqkTl1koTd7ivT
         4Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769374064; x=1769978864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TrOnLwvRLG3JEc1/1HSkUCyAsStaYOH2lsmBWKKbgf0=;
        b=HYgLXBBdh1kGl4T5qpobI7F/pX6dlm1QlarHJC783WqFr/jPeBC177c3toim28Y3T/
         9wMwuMfdo55SuUJQteD2ceU3VHQUn5AO+s5QtHWrVLxMeAN1PbTFB4Xe87p+7PF+Z2r8
         s5jcHpofcfojvAqKxAAB3wncGx5TYWVhpS4b9eogQvJ1U/zVjVCw6H3P8vTxwsbfP1ff
         vh9YfEg7fyzibdrvS6CYyOtehx9AT6CvcENy+bXSk4P0kiRXIibloeiE3MmPEmtfvKx3
         aX8n6ZeI8IEQ3eroaMuw/TAlYxbUcxIIhRLlqo3QrNtTaCKdQE8agtZep9S+FHD1IeRw
         gFTA==
X-Forwarded-Encrypted: i=1; AJvYcCX96NgWoHz6bOhXsYMZPSSFwDuBGJbeUgS/oOHNmumsPnRI/C2QUby88rwFwO5MrL/pZ2FqIiueSXIp7AS/@vger.kernel.org
X-Gm-Message-State: AOJu0YxbxZqB5y2UmkjNHU1EbIQzjwopLHWy57p3mxjsVuG2MYG6NW4/
	sG5m+EPOazFof2OLpYHa5C9FXwPjWoikAjmd1FmzVo2we3d2zaPIATi+
X-Gm-Gg: AZuq6aLVWIiunBXx0MDmRjK0Ecuei3tzKNVR5HCmHjHHVZk6yU+tFteL7r1Q3jHxftd
	1/wHAexeJc8t5zd43w85dUFV0PxoMb7ezvhUNOgSE+3eGi/3BEwe14iId0LbZ8+tRwGnrDQA49l
	FHOnS54dpec139UC+itC245TZd7mDGpVAlBfA8BK8bx/Gaw+wFlNdQmzDbyKvAdnrHcJB7aFs4N
	NOY3+O0n8Sljk8Wzt1EZnQxHqesVLViRRJbkxC2vPDdrntdqZV6yUhyURfmwjx5UFwyDwg5lp31
	drPAEYb1IbV/4ye259TEVCXxr7ql+0dnlxSIe1mOnejlQIwOXkBR/xy/JxwRgmBOhDMAkuKr1hZ
	WjqrfbigGq0V62ndSAkc05rtA4fvUE+hk0y3cUrqB3Q2fqJm0KsCIZqVDOzV0X0Ojv/cmz5htFG
	gMrSZSWH4=
X-Received: by 2002:a05:6000:420e:b0:435:9ee1:f91a with SMTP id ffacd0b85a97d-435ca3a43c4mr4888315f8f.53.1769374063579;
        Sun, 25 Jan 2026 12:47:43 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-435b1c24a8asm24444674f8f.12.2026.01.25.12.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 12:47:43 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	hsiangkao@linux.alibaba.com,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	lennart@poettering.net,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	walters@verbum.org,
	zbyszek@in.waw.pl
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
Date: Sun, 25 Jan 2026 23:47:38 +0300
Message-ID: <20260125204738.2080749-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108-protokollieren-melone-de2f17539209@brauner>
References: <20260108-protokollieren-melone-de2f17539209@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75393-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.alibaba.com,suse.cz,kernel.org,toxicpanda.com,poettering.net,vger.kernel.org,zeniv.linux.org.uk,verbum.org,in.waw.pl];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1344C826AF
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org>:
> We can start with the basic right now where it's not mountable from
> userspace and then make it mountable from userspace later.

For your information: if we make it mountable by userspace, then
magic number will not be reliable indicator of whether this is actual
root of hierarchy.

But this is okay, because we can do listmount/statmount and check
whether mount id is equal to parent mount id.

-- 
Askar Safin

