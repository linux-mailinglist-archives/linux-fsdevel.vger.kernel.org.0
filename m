Return-Path: <linux-fsdevel+bounces-79707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +W1OCfyjrGk1sAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 23:17:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FAA22DD0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 23:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9017830164A6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 22:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEF5345CAF;
	Sat,  7 Mar 2026 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9yYzxtw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93E0299922
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772921847; cv=none; b=SjuJ4W4uVbiBUKHevIUc6qPD2FPf/MTOzJ6+Wl7KWXFkPuJijTPvCHbLXFz8EMYAwZCSPt6MZzwzvaLxmW4X/qzrA/zdq3Az6Y6tFc/mDua3Bl4pDtSlU5j3s29Vzc6agwPsKaBerS3wiYiR5if0ZDQQh2Lu6EJid45goB520y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772921847; c=relaxed/simple;
	bh=TZ4sb2xiYLj90R/5Q6kuGQ+m0BxCAF5tYBR6lMurcSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3jBz5Co/UDUMj6eqT/EfpFk9JfhsTOUUtNN5scMKjAl9qqyyQoAZeCMyUPuBczYa17AHKrjbHkFUYHoKpvfHRiQZnQ2S+xWpbNfpjGX3DRhgnHWEZcxDsqzmwVSvqdAaZ7td1UmDDC5RaEkOpmcYId5bRjRCJyJn+KJkFhqdck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9yYzxtw; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439ac15f35fso6960567f8f.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 14:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772921844; x=1773526644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTUk0h9qQdRGSflJ7tX8S/6Du/snKGGKQNL7BQV76XU=;
        b=X9yYzxtwOfhyJSoaKjgDvtqeKzl++rE4s6lfddcLFlbmTA9MZgbVll0C88657urT40
         QzIvptedHqIyklOVkVBBIel7DOUp93UzKCpY5RjwSvLowKEKmnnUkppn8hjgOVMlStfS
         Rd5PXErlet6Faj8Ax3w4iT/LT1KoIzQWPfQS+S1VdPX8+x3bxgTwnHpj/uNgnfyPDNDg
         QB04mnfSXnedzrlogoSuAW7AxdwNM3qJRX37RJI8acutphfQ9KElU+QVYpC5Ir0IggN6
         bKJXEG+UPdDZLNpQ/oluS8CSozC3lUyESDJG4Vs4KwTpshiqX0iCbL+kWoleUbb2O8um
         Pbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772921844; x=1773526644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTUk0h9qQdRGSflJ7tX8S/6Du/snKGGKQNL7BQV76XU=;
        b=cbsH8bZvV+h3eVI5lI9Td37mp//QEZ2YfFJUWX0/II/gCTQUIpaEEmvuylM16o+l3S
         RIKZrSiMjLeHMwXsiLSKGdh5lFwhAjAX8WOu9PcLSReV9wCc1D01cC6Gnp6sMWFgqovH
         DeNbLDnSaAj9aHNI99xBRGbBMr19IabcDxegFv1xR4HTGVeix6WvSPF4rABdga00LHDp
         3D5ZW3FrzXZurqk02FAsqH9RdS5ygye6umprlWxWpvNwnZBLxXp5OBhpXwDYJ63rw2AQ
         k2TUMyMgHUOs2sTYRt1mwK0HAL1SWxsxAtks1PODi3kAGQ5cCQ99+hmNbiWHEwnJserZ
         PW3w==
X-Forwarded-Encrypted: i=1; AJvYcCUMEyXjWv8/glozbyCIyEFIB47o4x5BA9ImGKUNvjGd7ncytN9UEHkPTaEyUwHsA4csQuFBXBPsA3PxlCfD@vger.kernel.org
X-Gm-Message-State: AOJu0YzfeVqWz38iRVXEVOJ/f//hCR2d8z3iJJk1gxFfpTuGdoKiTzRB
	UrZf96Z9pnWYg2V6xDpSD7Uq+oa6K5WyXRRMiqrCVBvDhLrCebvn34cf
X-Gm-Gg: ATEYQzzYdFA98oRAiCWxoyyxR9xOH8VpPcRVVxvq3osQO6UPH574KZUfE9GJpdztIB0
	9B27qDPsBr452OlszH8ZjpMDwHmkiL+p901G0m7RfZtksfhcB1XjQJMTSGmJ8Ou9qUK6EIT/dZ5
	6Yr8N6/WB+ZJV3HF+y9l9bCKMzO8Xomc036yUd0QDQQplkLxuUQUuhSZm0iP8W0K+WvDVQpwASo
	AahVmyEHoE6lOk1R/uVaOm0VC8kPmBA+6XDQQcUTPv2GhE8yXapMeiRj3CYFDRttKQCB2aYJkpI
	GGsEHrTIes+chthi4K/DFTlYqXLoTAzlFyA8+AoKl5qhCAoUY9JNzTjkzlGOwdtAYEPn4zw13Lg
	XI5HJvmNBNhHqjw2cXEbUNoEvBfAkHhgTaT90KftIHHWMjwxiTvfWqcmT2VasvaTUF9Sk0uFWHj
	n2Nuoxz3YeOVmhgDuEEtA=
X-Received: by 2002:a05:600c:1f0f:b0:483:703e:4ad5 with SMTP id 5b1f17b1804b1-48526967cd9mr110619165e9.22.1772921844022;
        Sat, 07 Mar 2026 14:17:24 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4852aac79b3sm46229495e9.19.2026.03.07.14.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 14:17:23 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: axboe@kernel.dk,
	jack@suse.cz,
	jannh@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tj@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH RFC v2 22/23] fs: start all kthreads in nullfs
Date: Sun,  8 Mar 2026 01:17:18 +0300
Message-ID: <20260307221718.3652877-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306-work-kthread-nullfs-v2-22-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-22-ad1b4bed7d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60FAA22DD0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79707-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org>:
> +	nullfs_mnt = kern_mount(&nullfs_fs_type);

There is a comment "We create two mounts" above. But now it is wrong,
because now this function creates 3 mounts: 2 nullfses and 1 tmpfs/ramfs.

-- 
Askar Safin

