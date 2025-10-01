Return-Path: <linux-fsdevel+bounces-63134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C472BAEE5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 02:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6551921CB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 00:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3141DF97C;
	Wed,  1 Oct 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTT9/K0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994811DBB3A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 00:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759279133; cv=none; b=TOSBFP7R4B76fPNhJBgz/flnng8E1VsqHJDYhwZtqz4LI/VQYGIfnmiV1J5YJeZ07mUP7tBMk/bX1rw5UO71rKIP+jqka0131885kFFsqHDFZD4XOXIgfJ/BI0GVEq+wtdS0gPIbTlog5txry3hDtMpbfugg9fjDamDoCjbBWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759279133; c=relaxed/simple;
	bh=pTt+ujkaZVjzP+3E74ZC6wkNRrnymwupPOqQi4vVrqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWAVP+dI5dfon8KVo3Q0i4rPRZYN0sMNqP244ocu0p+aQHTZZmvZI2yeklC0e4b9VOlylBBS6BYv+gIdv20k310t13G92kaxJ5o4JFzd8P1ob6nZFQA0T3lieVclmaziJeGSqFnbSkIOSo8YKWLUG7jPdAE4a7bgnER+txWt81w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTT9/K0O; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b3ee18913c0so501844466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 17:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759279130; x=1759883930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80RkSLcN1Mqe0fHp8+5X2rCf+ePo64S5nx0U5sFjDh4=;
        b=VTT9/K0O0oDwmgwwY5vi6S7WOAik3VQgHyiT/6SxbK9ZUHaQ5GSAQI1JI/zqRxoJvk
         Kpyry0MQK1AOkFagG9dCMZLm5/jCxooEDL98twvPRdWhfuU/aXm2Dj5YTX13PN+Z2K7R
         aMEaLi83fby6RYzPt6HA05Qd+CVGNAXXrj8OB1VvkUd4JfcbQRPyeycTWQgHJYt2AX9g
         1hedhTKYBu/9+doVgrWQbvqIgaBTGRyq7ZU6gc2/Wd+6XoaTvp2WOVs6uG+vGNewgpuf
         HDNYBAkj4AJIOLVZax9WwsowRmQn4BcoADFixmMr327lncWOMgkKMxI/yJgbqz3pIWMI
         MC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759279130; x=1759883930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=80RkSLcN1Mqe0fHp8+5X2rCf+ePo64S5nx0U5sFjDh4=;
        b=fp2+tidsxxqcs3RsAQKEltJkKpFPgk69YoUkzCDQuKK7GoM8mdzFJ25KTpwst5+087
         H24ouLdmpgeDb53sk3eOCOFBKaOpHM6MsDlq7v9PLw6yhI03heHDhFkGeU06wX+SmlDg
         Iq4Aux5yFaqksxqm65UO/aUWH8kDKjG2udbNS3csHpVVApLGKiCCB7Q+CoTOhza1eRFz
         3yGmMkEHMBeezxjg1cgmMih4oJ72DOaMYN3FEgipdxHb3kohC3O6pCT6PfxOk6ZABvOB
         CG8ERYKbcgQeHfGnyeUZOowbVE6cfhRU9mMaakqAC3EusHAtbKPPe8K+yW6nlJNksmI6
         f6Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUEFhdsxRpbMnQoSdY9MIvaTtuW5yy61SzFg6N6W7qWln1MkFngoxIixv5a/5tOnrr5yKre6EE9wykYUDG2@vger.kernel.org
X-Gm-Message-State: AOJu0YxkmQuZcCCFK7sh2znj+r62q587LbXIAac0CTgd7ApKJohySEP1
	m4PqopxAV4pnsKF/Lc9ugaa06jwqqRLvb6rfOIq1kyCz3YF3EFG9MN5U
X-Gm-Gg: ASbGncvzwXKjbwX8ZF1KH15a0tIxlDH3tm8TxoNplsXawV8CBP0bnOQkkQ7rkY3633M
	jFQJUjSXEr2AJ1XmMrUVIy4aisaqz5V1apfV1G2aMQUtA2S0ntRNnhM7JYUxz8RSKZ/YRncLQN/
	/C2yKPzW1MwK2gpJ02mSET6z2CWiqPG0Tp/uEMgldeah/aH9Fdzw4GWK+iTQWg140GVe1BvUHcg
	GymbtXCfZWCfLQSQUjxQIZQWkINPD67dG1qyoclpb9VCmbzSEk8oasKUa+KMlFmx+g9Xyvysgvk
	2jVQaW277a5Q7lCxlAChihRjzp9WjuMm9+FjrcPH5fpBnSMscXC1zsDuwu5ta/LQB+oStx8FXqR
	eFy/Qb9PyQcqk/lJLzU5FYpEyUcNpvVopeAMj80eDAvU=
X-Google-Smtp-Source: AGHT+IHK0/LlHSuoPWFmCm2v5eRSFa2VBRwHPtGKfZiRLiGohR1gYvmPq6f/J2GBYW0sSTfFl1HKAw==
X-Received: by 2002:a17:906:c156:b0:b28:f64f:2fdb with SMTP id a640c23a62f3a-b46e2626cccmr167161366b.4.1759279129687;
        Tue, 30 Sep 2025 17:38:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b35446f79besm1255821866b.69.2025.09.30.17.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 17:38:49 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: cyphar@cyphar.com
Cc: alx@kernel.org,
	brauner@kernel.org,
	dhowells@redhat.com,
	g.branden.robinson@gmail.com,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-man@vger.kernel.org,
	mtk.manpages@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v5 7/8] man/man2/open_tree{,_attr}.2: document new open_tree_attr() API
Date: Wed,  1 Oct 2025 03:38:41 +0300
Message-ID: <20251001003841.510494-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
References: <20250925-new-mount-api-v5-7-028fb88023f2@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aleksa Sarai <cyphar@cyphar.com>:
> +mntfd2 = open_tree(mntfd1, "", OPEN_TREE_CLONE,
> +                   &attr, sizeof(attr));

Your whole so-called "open_tree_attr example" doesn't contain any open_tree_attr
calls. :)

I think you meant open_tree_attr here.

> +\&
> +/* Create a new copy with the id-mapping cleared */
> +memset(&attr, 0, sizeof(attr));
> +attr.attr_clr = MOUNT_ATTR_IDMAP;
> +mntfd3 = open_tree(mntfd1, "", OPEN_TREE_CLONE,
> +                   &attr, sizeof(attr));

And here.

Otherwise your whole patchset looks good. Add to whole patchset:
Reviewed-by: Askar Safin <safinaskar@gmail.com>

-- 
Askar Safin

