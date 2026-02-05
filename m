Return-Path: <linux-fsdevel+bounces-76385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAjZKFVrhGl82wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:05:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC5BF12AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 11:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 458203002919
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F22A3A4F46;
	Thu,  5 Feb 2026 10:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlylkwtZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8611B3A4F2F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285903; cv=none; b=Zd7lEUZzzbj2WrVZC0NgHMznGQJ5QnMs7KZRKpSAWDrOOElWsPzGL+tgAHlIrPPqv1VqvvG0nl7m6kWLG+/5Xiu4HFLY5R0UVB15BDp8ryVLVz5nDshwlUOFJ/ohDoYMwzH/VlIUbm6fbt+2N6qzwWdKXT+b5XjuHWo0880ZxtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285903; c=relaxed/simple;
	bh=cUCjXOzyNXfUHrVbFUTqxxw85y4D9L+9PaTcZvGpLiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdlxkbdTWCSZ69zL9wsMQ3VhKxerkdcQEpp0HcIyAOyS8JPyMXSnM3PPO5ZgCNZ7m0emo61+huCWWNwgB/tC5Y4YaU/BrmmUSv4Q2Giar7XkVoJMafoTYyQpU9/sIJH63ghy2PsRQrrODde9MGV0sTA2HIKE8qJkU61dFDTBezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlylkwtZ; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a9042df9a2so4256125ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 02:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770285903; x=1770890703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dsv48T5s7siDt+dbP9XLn3MeHYejAgqP+nja3QugRLg=;
        b=FlylkwtZCJEhtsohuFXzHFpNibTN9in+ujtxaS4qFtOx/7om108lV8AK4iyKt7xh00
         EyCRgR2kW5qKOLExINP0NqAZ2T1OcpJVJ7VAl48+tuaiE5oYxHjUEt4D5vy6hopAWBnz
         mlRj7UQh6k4ynn+drSUvtHl+Wf3f6QwXz7lMirch0JayzGYdg8kMIGMaZo4qHSRPtrt4
         /8+AlTf88IgdFwlDmoZWdGUntbQZ8JhJur2O1YS2K3UXbtw01avkt5E2iKFxmht5wuxR
         rbK9pcolUHrBPwNCOab1pxQi7MIO99CccYJ/Sg+4MXnLfNNIxwT9egCZJhI2khmVE+vZ
         UYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770285903; x=1770890703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dsv48T5s7siDt+dbP9XLn3MeHYejAgqP+nja3QugRLg=;
        b=RBT7gDP6iZaR47+i/k4FZbrm8tyGGfiCcTjB1bvRrIAc5GyJ0xz6nR/OmMwiGyLB2I
         qlezMoEwJq0Dzc3HM/I68IvTmKgycHzJJDGFFiVQx2r2C6xywkCcuhOoC9IVTpO+BCiS
         dxvZksFOSrJqcHLGKIa/i0Od02OzQzK8idBXV3jt36jB9XtI8TLiZLmiOWTq8Ejmk9dc
         LGv3L7PRlP3IbNOMAnuoMj5BHK6RQrGlE3LGQmo63uxi4XTlWKyYOfp8AR6d+sBNztmg
         8Qo9S2/+DEbJu36g9FX7jFGeEpXYtqBOLbSce02yahiNM1yFkXx1aWoM1/lofPyz0Dgn
         liSA==
X-Forwarded-Encrypted: i=1; AJvYcCX3ID0YjjvJ4VRb+xvwygFEwS1Kewjy8p86//kq3iIB2NCyAfNWT/oN0pKo9iVs49k3V7vXHvkaIGuKIggx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8tZIADh0naRpz+9KQwhvVGgUKoau7EgkNzf0MDJ3en7g7tqe
	OX47KICJVxa0viPbUkHgiwOLc9Zh3j8EYsiB4c2lRnd8I4sxGwv/GAI=
X-Gm-Gg: AZuq6aL/MsNr7KGXtPWDdoNtUXx19Z6inOecWcnQFmVD8Cy0UEk/7AUYhe9y0PC7phy
	PEYiMQM+jB3qFVNuxm9FpNyCmmj48jOUTz3iDRDeH2i93kO3KraGkYrvkGLkKfzLLRxFfq7SHMt
	F9dwmOVZ+qU1LW/+SRkWYwyn2RzZ4SKxlM0hhf7hHAr2xLfUAbd8vhPjIq13oZf4clSbeZ6T4nn
	mAfgB70UtJRW1aJdl1fju0jD9Ao8MrHBghpLUMX6BMq4+jPmf+qu5SVMsa3yxeR+/7zsWDcstxr
	TT2g87NgP4I5zEQj31Flfr5UqvI73T4GmZVUHydvufV9u5vapZ/bbfvwh0aSSbyK0vSVSwQ7INe
	/cp8gUVd2xOQU9pEgnH9uMTx6/j3i4gfzp36LceRNRVftoazy1MD9eO3GEu5l+P49sMG4scqz3Z
	0fvcfYqS/NGEc069rmUrOIfd+3OJoenw==
X-Received: by 2002:a17:902:e884:b0:29f:3042:407f with SMTP id d9443c01a7336-2a933e4082amr70434625ad.21.1770285902784;
        Thu, 05 Feb 2026 02:05:02 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a93396b2eesm49360365ad.78.2026.02.05.02.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 02:05:02 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	repnop@google.com,
	shuah@kernel.org
Subject: [RFC PATCH] selftests: fanotify: Add basic create/modify/delete event
Date: Thu,  5 Feb 2026 19:04:34 +0900
Message-ID: <20260205100437.1834-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <dnncglg3x26gdsshcniw5yb4l2zlxz6qcwjqyekkpngb6v26q4@ftqnoe5eeapy>
References: <dnncglg3x26gdsshcniw5yb4l2zlxz6qcwjqyekkpngb6v26q4@ftqnoe5eeapy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,kernel.org];
	FROM_NEQ_ENVFROM(0.00)[alwaysstarving0@gmail.com,linux-fsdevel@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-76385-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBC5BF12AE
X-Rspamd-Action: no action

Thanks for the feedback!

I agree LTP has very comprehensive fanotify/inotify tests.

However, the motivation for adding basic tests to kernel selftests is:
    - Quick and lightweight regression checking during kernel
    development/boot (no external LTP install needed)
    - Non-root basic cases (many LTP tests require root or complex setup)

Similar to how selftests/mm or selftests/net have basic syscall wrappers
even though LTP covers them deeply.

Do you think a different approach (LTP improvement instead)
would be better?

Thanks,
Jinseok

