Return-Path: <linux-fsdevel+bounces-78214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BMJKvABnWnhMQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 02:42:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 165F31809D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 02:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE6F4305FFD5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 01:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302D199FD3;
	Tue, 24 Feb 2026 01:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBArf8qJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BD1C5D59
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771897236; cv=none; b=YR2RjyqEXca6RQTQCQyAiVd+6MlOMh3t8PoYwvswWv6lHFF5lKqjvpRmVFufSKzBzPtSMPQLiJvpcmY6sLnRHRUYIYTe7gQg+vMyfOO/AW37w59Udjiebu0+mPTYkbdBDfJZR4yOTIlfn7CIeYtC2SxPL5Z2EjaZtJZIEFFI+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771897236; c=relaxed/simple;
	bh=rKdN0A571JW+Ad4nDg9yCsmFu36+cQeMc4MGRsqmMV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEOCgrdinHkur14zFgdKfazy+ovVLBNrnCNnoUxd/q6LCm0g9QfFtSBFevieArGF4I5FMvp7+Nsjo3K3epEL3qJo91yd9ZhzI8m8jGF4Tb4uXnd1lgPg7a979Zwf9kbaqipG9U3yfe0bNpESHuh7M1XZMD7xqyH+CbOfxUHECpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBArf8qJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-480706554beso59609875e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 17:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771897234; x=1772502034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJNHrg5cXVEq6Dijrfrxg73DYHRJSqEt3Qor23SHT0o=;
        b=SBArf8qJPteDw7/WMJeP5FWJ2TaPBqoAcQNbljJcp5LgWnCFZc1vahqyuaXo26Jkn0
         iZWDGrmnfqdosgbP9toy9XW+2KJYy4mHXKMiri7IBOAdBYSdL6NvyunO0p/P4T18YJYt
         0qeyD2RU6UBnWxsYmlKYVYFxD+MxdRMfXR65LtoZdHOzwfnq8p9h+5fQWlFZF8j5uJJT
         t62fI7+/JvYP62YvpKJuKvXS+N2Go11im2Pn3XA5P5hMIwPE8efy7OBHQ7XjtzWDo37B
         zHUN3TUUvfEMyxDvLLuVGLs5iMx7UU+sbh9mO7cCnBzIpPs7m3P6R9BCaxVSqfVgtM0A
         U+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771897234; x=1772502034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GJNHrg5cXVEq6Dijrfrxg73DYHRJSqEt3Qor23SHT0o=;
        b=ef/ht2enWOloo3rMA8B3KY9lkYdYMK7fBaG7uUxuK6k7RpXCKXb91DJnG5wHzoEon+
         SBpMentVUVYh06YzdTrzMeZNd0W6H7jvcGJaDtXn3HKypIPd2K6X3qaKiFKnTY9c6CWG
         rfIW6Wb1scrNQNUve9XlPtWViMfN3ccQ1sGW7vsRj9oqqRAzEGgIRxinh1Jno/7Ow+o3
         vCh9UXTVsm5Zv2BNgEIcYEb9HAiSnF0MGII/hr+ryScQV590y8ygVoksDbTXMjL0BRYf
         1rIBR8Ac5w2xd1Epg7HFS1UCLdRv7bqyiKUXLbTq7sSAmF00ohTgJG6F3LuBc2joOg8G
         WmYA==
X-Forwarded-Encrypted: i=1; AJvYcCXA+x058ublmujhF2HoV/yz9dBTP+HfdFfiVG5kh04lQTsb2XNPW+MmLfQl4JXw3zVOA1LcpHZRIpQu338m@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKB7okku8+vBoUCsTMlSDGdRjdxiv5GgBsjK/H2fadIKlxljg
	8z6y4/yKTdftoWmBaoGRMdHELl/SbrS43egVtPLXqNPvqIEAch5I9ipY
X-Gm-Gg: AZuq6aK6afqIEm0Ov5yzTLbcT4ID3H0tR0gJMetKoHJSun4YLocb65+69DZ8n1Zp+0F
	PGTVeU2sKggLlet1R3NIMs38OkhHoyVhn7K93GxxvxCfxE5pduTC/06pkAd3NiRaDR0U2+qMp86
	tsSJ9jZfRsTo30LYSRVeBKMr8986KcLkTiJDLcjAfCnN8Ukd58DHeqX8jIQ+wFgMNaHNd/J1d+G
	NZWldcbf77h4oPIxUf/K5T7emhyqstDUTFmelPeegjDM+MGARvWzGYsLOXWcuUZe00lij0C/pyC
	Z/4e2fa1YIbddaRaLcNJNssQNMrdc3oNscPHb9X7idiIRen9SFKjujfPrK+Vsa+QSJBYUa1JdUU
	UBZEeiUQoucS/fZ8ikFgibV/OmvFxFJ91+kuB8DPtE7cGzjFNgzPoA/4f7Xy1KvT8RTUmiHwFs0
	Nl1wfgSwdxVxmO64rs6Cs=
X-Received: by 2002:a05:600c:1f93:b0:475:dde5:d91b with SMTP id 5b1f17b1804b1-483a962dff6mr166656605e9.17.1771897233704;
        Mon, 23 Feb 2026 17:40:33 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a31bc0e3sm276169155e9.5.2026.02.23.17.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 17:40:33 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC 0/3] move_mount: expand MOVE_MOUNT_BENEATH
Date: Tue, 24 Feb 2026 04:40:21 +0300
Message-ID: <20260224014021.1231200-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224-work-mount-beneath-rootfs-v1-0-8c58bf08488f@kernel.org>
References: <20260224-work-mount-beneath-rootfs-v1-0-8c58bf08488f@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78214-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 165F31809D9
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org>:
> The traditional approach to switching the rootfs involves pivot_root(2)
> or a chroot_fs_refs()-based mechanism that atomically updates fs->root
> for all tasks sharing the same fs_struct.

I think you meant here "sharing same cwd and root". The problem
with pivot_root is that it changes refs not only for tasks sharing
same fs_struct (i. e. cloned with CLONE_FS), but also for all tasks
sharing same cwd and root.


(I just do some proofreading. I'm trying to help. I hope you are not
offended.)

-- 
Askar Safin

