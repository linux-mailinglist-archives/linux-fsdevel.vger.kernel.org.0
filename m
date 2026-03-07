Return-Path: <linux-fsdevel+bounces-79675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LCZH8eHq2mFdwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 03:04:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 238E922992B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 03:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAF0130579DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 02:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2AC2ED872;
	Sat,  7 Mar 2026 02:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHqZwFKx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C081B4257
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 02:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772849078; cv=none; b=VouSpKxsyA70doOLKlVjKWkF/HX4Uiht6zIqBaIlub2/gAtNPDQP8tkXpIliqyYF1u3sEArY1HW2IggkaftQO869erHI57j1RcumS/+lYXOyTYb8fJK8MU0Ayk4AvJ3K3rpJwhXgtnHrjZhzs4+TtZyWSDgdFQCKyGFt8MMVJ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772849078; c=relaxed/simple;
	bh=6Nh7E6RVWFetSmIWmq3xO9GS2JHrjAWwbZKHyTBALbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVlM9LTsBUVyXyfqNBh/7PID2u9xYFr+hZHGKW4mspsErkqdvke5F9+tGZaI3TSzOK7HFk7CLtMvwG9U5IAXXZBO+tOCaGfV58GRgml8WPVpS1anVOTUeD7D/4FZ+hUrBPnkWnu8tbIAx7r/Mah4gCDMkcW+FwTH+GyCiXCIAew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHqZwFKx; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483a233819aso96954685e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 18:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772849075; x=1773453875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7ZCOxoAPjffbKnnZZtgFR4Zve6E5Jt5QxPP+T58sTA=;
        b=MHqZwFKxXVgbGMjASh74r4w8kMib/I6pG9270YdV+Tv/THWxKhLzuTKcRIX563W8h0
         wyZJp3y6u2WtHyooO4xknfAeGcy9PftMYj+xCyGqO8yiYJn5/3te9W+FTlfKsgUP8cbW
         TqwXUIXs09yxVn0PiaFmVweDYj0VR8d7YF53+eRWrKkOaWvKj8dc9S/l+HPTdIzrCow0
         rQt/W7q8MNpFaxXbA6nXsInJhXWKIq3A5nnE5qT5k9CGV/dFaepJ7gqWCpwToSwyxrME
         5H8VLcdfg1/TZnZBm9ps21qCGhhmboNFq6TCJMYqi8vtDnr0U4b1fSGmFuQKltNp+eWS
         T8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772849075; x=1773453875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a7ZCOxoAPjffbKnnZZtgFR4Zve6E5Jt5QxPP+T58sTA=;
        b=Kq6KkADXT7Xtw7UKabS5h1E0YodUcEUcpXAHu2djWJslGOwiaA2RIcSswfv7hDQ0kP
         Jbk/vIiTuE9Y/wL40pO9vGvh/FcVWtnmYNZ4Ks0RuposyPwWXRX50rB0SjwNL78uYjzG
         LdIsHJB5zU/Jtc9iVZgmaUrjLr59GZrERAo10Xe+UbyFm/xikEobm+o5p7tCcDnVDo3C
         1i87iDDymOajwu01ZlIJBVaDo1OHf93tgjHk/MmMyF1oYJq3N7qkKu3LLICpC/GrEJXb
         64iSUqIxorKIhHuNGsrVvcG7rp8OE2ga26QvEw4XPOi7FTv5gwDvx30QZGICCxUKsPkd
         G1Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWL+d+uE/g/9W5L5k00BLK4dsdNp+3Nyu3XFvPGK6Dtn9SgIZzKV3VHTbIw58Xhrt+DvhojFGc5zAmdkCgx@vger.kernel.org
X-Gm-Message-State: AOJu0YxvMWg9npe8JQ6L0lh7Bt9RhL5C3oELiBNqJSQ18O7pWBVJwZkg
	5+vRY2+u1Dcxo1IvsIfnjUnLX7G4Xa+X5lwONhfbYbo1KYmuU7cU+/Gp
X-Gm-Gg: ATEYQzzZJ3dOXm+YHX1wEJQLdGI6jpZVwn3jYiogNHuBXOlB8upY36FPknK0ekYS2cM
	xd2ABNCMjIKtEJFQJG62J/NHrnU9eBRzHRYcxWM4FNl3cmLx2i633C5heG4YP8kvEp5YYV4HNRl
	I0dmPe+m0ON0RoLoLZGg2xwjbuSYHMjALhlqrurtPVtb7qvrJqgSXYOEwPypp48RoNCub3TG0TI
	wV4ZNVTGNHgyk1sZJdY9Lhsfanq9DSBkgbJ09P+3SWAhLz0mGTqQgY6l0CBa/7LWnF8gMobkh3p
	Gzz/hbiktunJDBGPY2Bahwix4/Da6u217HUBTQVwxZpf6hILgJw1+y8AF7Ax8yCVUm6uA5Ha6g/
	rNDHkbnP4BkA6vYbGTri0mV+DuU5infSbIAWmDcX5/f557oJv5qKYVI/qIlSTq3m+DKgyJ/Mywy
	HEF/bVXmyDwUyR3yJEWD0=
X-Received: by 2002:a05:600c:1e88:b0:477:6d96:b3e5 with SMTP id 5b1f17b1804b1-48526916beamr80653685e9.7.1772849075139;
        Fri, 06 Mar 2026 18:04:35 -0800 (PST)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4851fae0202sm214777205e9.6.2026.03.06.18.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 18:04:34 -0800 (PST)
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
Subject: Re: [PATCH RFC v2 19/23] fs: add kthread_mntns()
Date: Sat,  7 Mar 2026 05:04:28 +0300
Message-ID: <20260307020428.2715041-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306-work-kthread-nullfs-v2-19-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-19-ad1b4bed7d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 238E922992B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79675-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Christian Brauner <brauner@kernel.org>:
> + * Allow to give a specific kthread a private mount namespace that is
> + * anchored in nullfs so it can mount.

Which nullfs? By the end of this patchset we have two ones: the one in the root
of namespace of every userspace task, and the one used by kernel threads.

You meant userspace one here. (Similar problem may apply to other patches
in this patchset.)

-- 
Askar Safin

