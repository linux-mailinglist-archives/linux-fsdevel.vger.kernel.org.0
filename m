Return-Path: <linux-fsdevel+bounces-77751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OG8J3ugl2nc3AIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:44:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E25C163A3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 00:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90ECA306EE15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Feb 2026 23:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8A32ABCA;
	Thu, 19 Feb 2026 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfQcgfQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E97327213
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 23:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544580; cv=none; b=dRMJmVQAwpre/Cidq/AI85BL0wHs+J0WTgLOaENFNCFpZk0snpjohinCvm3Jk0N30b7+E+m0lQ0GXNXzs3xqvAH1SE0h6YNqLltYwzIRljOPmJErEOYG4nfmFhbn9UtUNDZuRxU/XdM+AoPojwIPyo55rSp5Bhr90R0mzm+9x5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544580; c=relaxed/simple;
	bh=quE5sGl3Uk/gMNmwDYmHMacZa/Zg+chR5zy0mjgEh1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgkkghBPAqc8GJ6Ug4kvpHIBW+7DH7IyWnJSbeWoOysD9eCk2EvOKXsoG8iuLhBUb+CQHXd2xKMtelA9Rd5CLa/h8Wo4AiYwdRFXHVexKUttvZ65i01EBVAxIfFtKF7IVmPm/neM2ihPqSRqm81y9El9H2+O1LGdpGVNGw66CYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfQcgfQX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48371bb515eso19252825e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 15:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771544577; x=1772149377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTF1k698GVo28+ckOqecetXyS8IP9ymt5tN+tdpIOiA=;
        b=UfQcgfQXQy+pYZ6LXrr9RBMeLnuzdqzm13XEFaa5QkNWUZcmJ241fUUe8Cqas9iInE
         Rx/OLeqATRTaT9UFghx2R2YUrh60VeM9q1gBCqVQKa9U+Jxprjj4tj6sov/A/DnjhP2J
         zOS1DfxoNfNg3j2OOVvKMCb/Xzyz+LhmQsyNb0TNhUEkus4xluqIIQIX6Eua36gAiYmd
         LLD6KyKE/dY94xjs0z4jy+o9yXlTGvuVI1SBZGDoisBPmF04N9gUlhqeHisj33IaXNIi
         gLSVGbUIGlvaAYq3drOD5i99jhPZhetE15bWfy/5E5cl730+9fQFX2m5YUnv8bs5qdcm
         rA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771544577; x=1772149377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTF1k698GVo28+ckOqecetXyS8IP9ymt5tN+tdpIOiA=;
        b=GB4ZZ6AHjs8Hkar8zluGORHcqXYP//09SEI5/wAiXPLVpM/GrsQS4hVqrBVFQ2GglS
         BSoNGsRcSZyDxgr9vze4xHvuCNwb0btIZyn6SfXE7ULl04zS0l6neE1LpEV0dQbh2yrB
         iihkEQ+bqzWc6DrPqNapQm5UmPmpvjlOFOHxnbS7DotLSPrcJp0x/vD7pjCOya0y7q4Q
         y2hKYNNqt6fZ4eQZrJMSF+0BuxQNgsCqmOeqRWXLeGPceGkKYJWqSbkQeM2LSPLBnFZm
         3iSfWsVn21AmWNQMdYAaYkYllgAXDsjHigZjiAbMykvtN5EdKPuVYm5Qm/dgxmlSt7C0
         /DDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPLR1q6X8wKGPInYODPRWlIR/BqpNl53/rVV5/exYgn1XH9DvcXCMkcR7qv622w5LAB8dHkFORhkobBqBG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jgFqRAvPkdyIEZjjz+eWcoko+hdCPBGXKDzcc7mg8UB1UAjN
	wABjdm04ZZgiNYMb4ODlg/t3Z2FV+LI7I44OHeGcz9uVdRxkBbg/kOGf
X-Gm-Gg: AZuq6aLMM1eMzPYRS8rwBhrjT4Mr3/AEK1fxyfrqNBb/M0gb1cKp8MUABdkDbJjduJo
	ltvHoh/oajRevlW+AMh1u8paFdd6+oRs9p/8IilPK8PRNbnCHOhfypFwliQaCfztus2o3vZuzhq
	eI0IOglpDcVgONvlDaL6k67EEtRbOBTGrzcjPCVauN2LdJedlODCf2tauCZErbyUAWGWVEmo6Jt
	XYo7lpJnNSA1fdpJpnpZQj++6dU3iNnGghcExbPR7DeALTNf8PxGMkDdNK87maKmG+CWqNrfZMp
	npcBNgxYr8i48Xm2lU9YpHSUgKcE6z7PFibQz3Zmv4iwvqG5jwZH5w2I0b+QRCmPs0Kkti0DgnJ
	HAUM+PlE+CtmF1DrcFVVsYEXMcAweGGXtDUiATKmpz2i5fIB9pxZ8x2BgdkhpmBJMqe6jq+FqOE
	RgwBBhsDy0emp3MiPWbC8=
X-Received: by 2002:a05:600c:4e54:b0:480:4a90:1af2 with SMTP id 5b1f17b1804b1-4839c002d65mr111614985e9.35.1771544577127;
        Thu, 19 Feb 2026 15:42:57 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-483a31c048bsm35793735e9.7.2026.02.19.15.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 15:42:56 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: rob@landley.net
Cc: containers@lists.linux.dev,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] mount: add OPEN_TREE_NAMESPACE
Date: Fri, 20 Feb 2026 02:42:49 +0300
Message-ID: <20260219234249.3757808-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6375f293-709c-41b8-a23d-12010baa3cae@landley.net>
References: <6375f293-709c-41b8-a23d-12010baa3cae@landley.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-77751-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1E25C163A3E
X-Rspamd-Action: no action

Rob Landley <rob@landley.net>:
> Also, could you guys make CONFIG_DEVTMPFS_MOUNT work with initramfs?

I did something similar:
https://lore.kernel.org/initramfs/20260219210312.3468980-1-safinaskar@gmail.com/T/#u

Does this solve your problem?

-- 
Askar Safin

