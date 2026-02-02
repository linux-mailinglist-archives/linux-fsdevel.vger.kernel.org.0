Return-Path: <linux-fsdevel+bounces-76063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JYIOPXUgGmFBwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:46:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCB5CF1ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 17:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED8E4304A225
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 16:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B393137E31F;
	Mon,  2 Feb 2026 16:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NP0im2dG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F2236C580
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050619; cv=none; b=CMMVbthAQZp4q44iPDeTchwK+Wf9e0mNjTk0Ezs2LSWWpM4TawkzqBRTYfqO3LMuavG0o57CLqB/simP7WgLlUvPMx6Tp2M7T7fKLzKHRA41nkQPCpjQqxmi/BhAMmIRcS66kTpNWHI1V+zXFCv9HcOiBcp9A0YPj+GMFccBHpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050619; c=relaxed/simple;
	bh=yBbDPMru9yrkingHqkpvh34bh8UEAnM8VfjBQvumfWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSDC+vTmnahIFl5Jxn8EdcrKkwzHt1sh+pLh0kn7mSkaP+oIlUCPS0ZTLcKPqNHvai+CZ2wDtJ0U5RMyTpbsvslJZ+wODj/YMrFT14TjJ/iiD1/zwd+BGvJZbx9n5AOKGHyawDWGBalPZ1n5EytO8OV9sap8vcB29Abb/LdkAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NP0im2dG; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso7014817a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Feb 2026 08:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770050616; x=1770655416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXf4liyLpjRZmiG7TLAwLn9ewsusZDTnCb6Vo/PS4aE=;
        b=NP0im2dGVwaFTeXdWHsAQsT76wI4PgyFOV67p2aa6GK2K8+EujUe00z8Z2ObiCu3dM
         ur9wpi4xcMQ1IOihA+BktljSNukkOyou3tk488r96LTno1liCQZeKDOgmdOteGOR9UEj
         TiaRYh+fipc0GbYF3WxFrl2S2nWBPAfAZ/GyZbIhFrMaJPIPMRC9saLsXp077ROlzkG3
         Yx5nZngz39I53Xx9AVhdHBVdJeiOqypzEi3x0/nJa1o1H6hLcbFtJ+lSCHUNDDb+YBRd
         KZiaOPANUKnIz3WafAA4XcAgmXnugNNpIISVOzo6SIxYVG2VD3oJtSuYEr5eB0qLtV/K
         Lk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770050616; x=1770655416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zXf4liyLpjRZmiG7TLAwLn9ewsusZDTnCb6Vo/PS4aE=;
        b=MZFQ6q18N/UP46CT/L7C3aIyFYscyaBfM/prX5Ic9VhhLgBOks+nDp9MOIdmnwJl7e
         B+FeVDw2zhanvAak6PZ/8T5ZcAlRD22Q8jGibohgFLSaKf44uj2FXg//zknHVArLO2j3
         ztmFZpVpIoEo1qEmaIwOuXJRuRMxQCG/GbNyWPVHKXclXSdFwXmLB9kep3kb+kCnIK4Z
         FvQt2/yGAGhI9wzD83BnvGmTCpAR3RkfmDTPf+7A+JLkx5Kos1LhXuYF1khjXQp80WdL
         +HiMZBYOuX80mEt4pzG0xNxbfeWwhHUse8ggtKyF6hjtftiigBrbWY2SbAsG/Fbf4WnW
         eCtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1j9IMYbs9rbFC2ZhRoFNA7m3PihLeQOGIQgPFw/p02+FLcQ/nbacVMl9YV5owVmSEXPlpIQM+yCST2PlI@vger.kernel.org
X-Gm-Message-State: AOJu0YyfHVODGHu9OlQaP2nff6s8rZ3BQ6+2YR0u51fAMTMYfJKLFv+t
	0pcFRUt7hlil8FDEPUJQj4+ZWoc4jc+khFhsZeDVtbeiwg199JabXAu4
X-Gm-Gg: AZuq6aIZ1dO5N1vQlCSzrzt9emokTzXjDM0GwrQN5Xle9P5AOEwCueec2mIfJR0yJkq
	EnQ5m+xn2xrAy8/h2WoTKgwN2VITPg3z15bUBpUlYyhz41D+jIc/qLu2epmJF8/WbsVYGHQnvP7
	s9dCY0sl+FfI+af30v55FGSaLbn4HqSwFmOYzBJ2+NEJE+J+f/yKxsK/P8dmfMPqcCSs69wmMbT
	T4BjIibLzENwlEVD5l9j4dbKHVeubaMS5wwfaCq0zsXObYtrpioCuEVsXWE+JUFXz3wiX9BxnNi
	GDMDGrORS91pDRFmlKQWrMFqT6ntq701nCXAuVEdA7p6syG4SqeRMRKkhe8ffskdgZ2VFT8MxT/
	uNWfTXiRBDPZI1qZ/S8qezKxHbB+0QrW3Hog+tg9MDPpzwK7ePe4Ay6uKqoO9LlOReUjVYhcdHd
	qrXGQiDL0=
X-Received: by 2002:a05:600c:a00a:b0:471:1717:411 with SMTP id 5b1f17b1804b1-482db481be4mr148672335e9.24.1770043963770;
        Mon, 02 Feb 2026 06:52:43 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48066be77b5sm442477305e9.2.2026.02.02.06.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:52:43 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: cgel.zte@gmail.com
Cc: ahalaney@redhat.com,
	akpm@linux-foundation.org,
	axboe@kernel.dk,
	bhelgaas@google.com,
	elver@google.com,
	f.fainelli@gmail.com,
	geert@linux-m68k.org,
	jack@suse.cz,
	johan@kernel.org,
	keescook@chromium.org,
	leon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@rasmusvillemoes.dk,
	masahiroy@kernel.org,
	mhiramat@kernel.org,
	ojeda@kernel.org,
	palmerdabbelt@google.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	rppt@kernel.org,
	samitolvanen@google.com,
	valentin.schneider@arm.com,
	vgoyal@redhat.com,
	viro@zeniv.linux.org.uk,
	wangkefeng.wang@huawei.com,
	zhang.yunkai@zte.com.cn,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH v7 0/2] init/initramfs.c: make initramfs support pivot_root
Date: Mon,  2 Feb 2026 17:52:33 +0300
Message-ID: <20260202145234.2245271-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20220117134352.866706-1-zhang.yunkai@zte.com.cn>
References: <20220117134352.866706-1-zhang.yunkai@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76063-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,linux-foundation.org,kernel.dk,google.com,gmail.com,linux-m68k.org,suse.cz,kernel.org,chromium.org,vger.kernel.org,rasmusvillemoes.dk,infradead.org,goodmis.org,arm.com,zeniv.linux.org.uk,huawei.com,zte.com.cn];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CCB5CF1ED
X-Rspamd-Action: no action

cgel.zte@gmail.com:
> The goal of the series patches is to make pivot_root() support initramfs.

Exactly this problem solved by these two patchsets:
https://lore.kernel.org/all/20251229-work-empty-namespace-v1-0-bfb24c7b061f@kernel.org/
https://lore.kernel.org/all/20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org/

-- 
Askar Safin

