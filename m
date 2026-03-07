Return-Path: <linux-fsdevel+bounces-79676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id jW4CLVSLq2lUeAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 03:20:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C32299AA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 03:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80C1030333E2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 02:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D0721D3D6;
	Sat,  7 Mar 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJvMhUA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C10145B27
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772850000; cv=none; b=CWkMbiFnZjbm+BQpXEzLPGHW7lBGuhUojpIMwWA4j1pGeateDXyDAovHLMmAPSLB/e2zHUsHHPpMptPVQjlyMHn/vHhXNhCQOe+zRZ70v+/8+xiUmWG/QQL/H8mzELKrmPNm5i+b8i4qZ2HdAkY1EeFHYSTl45a/KZXFEMtitBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772850000; c=relaxed/simple;
	bh=+WzykKKk6O8IJo4p+GDa+iRmQNg1L0DUENzh5zdtLmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNnCOk8OscZra0T5AmtNsm1CPf4pmve6Y5sCYVE1dVkYuvRMOZM1NwVTEFENVnGdAoMsur9+z+PeFvNxhNT22isagUxLQiShfN0rhdmgbOylcOvYOO5OAOO+GpMBLY7mdOr+RtrQQyTx/+doiTjbAdlrPOQxctMxviXGaAiJRxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJvMhUA/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439b2965d4bso5461512f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 18:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772849997; x=1773454797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D8fxGvdWrgZKh3/Av3KufoOxo/gaFMXeddQa/i0sjg=;
        b=jJvMhUA/Djwgi9ecSP1GMwdryKwX8XR3U8dFJeAEuod/aJ7gEWYrW4Ym77AqH5B/25
         /vVK6iKfE23a+fnW77GZxMDxO3Ibl6THMLXFODuki6xNdk80O9daEfP8T6ED7IBNpBPY
         6EUvZ8d6f142tW2B83ihEb++ONyVTafVNiOsdy0spxBMC8pPAO4B+h57EtExCl7QKnJh
         /WiCdve+StrQI5KFuGkDbudg8P2cMn1vGXGss58Nyo6cuvQA0IC68almQW7TxEoDwS2n
         ecDmxAA0GGRZVDif8oQQqEyW9SkAfSAysEO+KItAaFEaybAbO9YENKzpniCtl4Dtihlm
         E5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772849997; x=1773454797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3D8fxGvdWrgZKh3/Av3KufoOxo/gaFMXeddQa/i0sjg=;
        b=hS0T1HkESm2bj75B/WB1dY2XLYXII8e0Yg9sNdBREF3rkODKFJLVEG4yFTpVuNCAvA
         /GLMQbAdb9bKAu1zO77UkhHkFejO7JF2/ELToxMbQjoJj7TGj6btEccZTTEzXmrA9tPs
         PfOSFvm0f7b159OYMc0PRKJIpE61FkHS1SHG5Gso3PnaEa9oM8jKMT99lBsPL3XoPQ8g
         yLQL3k8FN3BuuVG4Gi6EtyEq3cWBfZZlyuiaWNXAgmu2DyXT++0e42HMTn3aJq5msFHM
         rbwj20a5GhAu6EG/atuXQhFM/PdBeAVHNbZ2ZvoJ2MM0BpQBdlyQWtARZr6PKbcYqbjZ
         eEDw==
X-Forwarded-Encrypted: i=1; AJvYcCVo280tFix3ycLNL/pc+g4pB1fGzqKKPoPchdHnJ99h60SaFlFAWsahvQdtIeRmagKr+Rz1ZnOMyzTbAxHO@vger.kernel.org
X-Gm-Message-State: AOJu0YwfIzRihW8eqTa27E8gUuIAF7T1f/8UPhdjgecyezTUbg716JAD
	iNWQcl3JlqrpVex1rJfwS5KCtXWWn/kXlzGpOlneOghgv/SnTuZcZkXB
X-Gm-Gg: ATEYQzz/RKMByNQ/6OmZf84q8YqrFKqW1hdYHR7ghBMmDuw/DMnbyI5wU3AoVKTE1Yc
	IUt3P9dBB7Jbnn3dpI5jgOI9FSFmnyAR46ulZyyPiF88r0yfITQLwquEV9r6m8ETVtHRrQvL2FD
	OnhrkNXDyEUQ2MAFlajvm/Fhq77gbTJOLZ70B0rgKq+wAqiSFPaUuTrBBo6nt/cq4a6Y6ppg+0p
	8d0xf4H1Crxd1mdpVeK3apzzBvjG4HvEMkkmTyE/nMbyHmLdrxDizR9D7+Jq44MQqvTUILKE1aE
	Tr7OwBP8JuF2OKmya21e111/0jWRYco1W+jqy7NMnjrFGchKvwodbRNhu+mF3+xQCFTc0XXydJ8
	P/gVAZabDNtoe+nVCaXSvYsmL3mwuX9Xz703gidxCm7YRDQdI0BBi6YkYtNPuqXMpw9rrABrr4c
	+Lzi8YRppNv7+AXRchhas=
X-Received: by 2002:a05:6000:2482:b0:439:bae9:6151 with SMTP id ffacd0b85a97d-439da67bff5mr7517026f8f.48.1772849997344;
        Fri, 06 Mar 2026 18:19:57 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-439dae3d98asm8855149f8f.30.2026.03.06.18.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 18:19:56 -0800 (PST)
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
Subject: Re: [PATCH RFC v2 00/23] fs,kthread: start all kthreads in nullfs
Date: Sat,  7 Mar 2026 05:19:41 +0300
Message-ID: <20260307021941.2742956-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 293C32299AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79676-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
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
> Summary:

Comment in "call_usermodehelper_exec_async" contains this:

> Initial kernel threads share ther FS with init

This is now wrong and should be changed.

-- 
Askar Safin

