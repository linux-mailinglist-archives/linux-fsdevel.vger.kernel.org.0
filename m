Return-Path: <linux-fsdevel+bounces-19732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EF98C97C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 04:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933891C2146A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 02:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BDFCA4E;
	Mon, 20 May 2024 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oQ0s/cO+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995D847A
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 02:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171379; cv=none; b=B/ElUNuJaKEXPloOmdWq4EctQ3sUBuL60aVij5kOOzSSWZGj3yB4kCLPOKH00nTynwi/q2Z9hUVES8EYh5ADbhp1vwl9M1asUR7e0WcDnrsPgtf0kKuygq52Nuo/RHVBcZ0B98hAh9UW6NWBqms+KWNmMm2NSqUizbfO5L+GnBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171379; c=relaxed/simple;
	bh=k5lb3KexDXe66sBBkZldL+OZ64rstu4w/axQqkMX4Js=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OGfOQcy8yJIlxEMJ3Hjm0cDSbvZ4zNo9DAy0RSbkIaqs+g73gUcaHhlB8g2Nblh1i41+JObKK2kARf6I5tQnv6MT15Lz8Hde5ikGsf2ve32EY8OsRHoiNnhT9XUxYWXCJeq5SwXhid+Ug6EXgnEU5nki3k1IHX2pI3wQaz2DhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oQ0s/cO+; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-663d2e6a3d7so943907a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2024 19:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716171377; x=1716776177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YE4ucDs9bqpCnHq3oUgTivRFQ/nTE3BF0FzqbWtaKfY=;
        b=oQ0s/cO+9DKklSRPhLMVg6Oofm9b83/Lbgx3SGavcwW9ePYRaZm/sbPmVy+gm7Gw/O
         Ie2AT4aTBHtpRNWhhDo8un6H/1ZbOiX6k9dgrdhkOPmQ1fTyb5AWeTR3yXnPo7EgEsJ0
         jVzvIhlde5zcn/2aZ07BfL4mPLC2rT86M4PMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716171377; x=1716776177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YE4ucDs9bqpCnHq3oUgTivRFQ/nTE3BF0FzqbWtaKfY=;
        b=qyAdHOYlXJ1Gj3917anYzmMRuWQTLR7ex/jNI/173WoncPiVZc4hFnabqK7JDfaLpz
         trhF086rMH4hQKWwnrQZnZPX8iLkK6l7K3gF9wR+3b+4v0xb6LnZ9UvjK8x1bvQJfqyU
         vXdbg6uogEzUZAhYETA4BMvsqIXhpneMLU/7YHlZNPYASLZYpiqt4wXYn0n193PRqm0X
         Fpd5c6DkObyb3sU8mIFR8+nWVJu0wvWL9M3TpUnraCo33IfiYoXK4ARzjSkY/pTSf+9w
         xmpCbhNqHr6AmToceFp0Vd2qG4xI+nI6kc7uLCwxCsXi+R8Cqnf75hhZjemD2cq4CVZ9
         /tpg==
X-Forwarded-Encrypted: i=1; AJvYcCXCGeOfQdn6GkivLiVTGcSmD56+Ubw9IqKKWmLClLHdWueknmoJ/WUnuU4EA1PKb/ZB6qum5O2jNX9vVUl3361a/+9an5SO88HLFrUz+A==
X-Gm-Message-State: AOJu0YwmlfKOPWcZB1XiRNOjDUJy6VFtEiRvrk/CckPYcOjpGA+ZkDsz
	m5czNiPwSualRetOGp+TgH9oM+ds65Uq1XcvRRPVklmOc1xcgsrHyqr1MAxr5g==
X-Google-Smtp-Source: AGHT+IGlmg2Db2n2jC83SuJ/euH+lWUD88AE94T/zbSsqm5Y0IM2QGpn7oCJ4Kl9duCwOUaZbJJobQ==
X-Received: by 2002:a05:6a20:9696:b0:1af:4fa3:30c2 with SMTP id adf61e73a8af0-1b1ca45c914mr5637698637.20.1716171377141;
        Sun, 19 May 2024 19:16:17 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a9107f3sm18518349a12.9.2024.05.19.19.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 19:16:16 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/2] exec: Add KUnit test for bprm_stack_limits()
Date: Sun, 19 May 2024 19:16:10 -0700
Message-Id: <20240520021337.work.198-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=800; i=keescook@chromium.org;
 h=from:subject:message-id; bh=k5lb3KexDXe66sBBkZldL+OZ64rstu4w/axQqkMX4Js=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmSrJrWE8uIm/m6QvBW42tgwzmZT5aSDXKKKp9q
 ZrpvWpZHWqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkqyawAKCRCJcvTf3G3A
 Jm2PEACicbwCbc6OZnHBIcUUFcyBjlf/4v+fHpVGZ9x6gjGoLiaNNzSux1Yt5JsshKg1JSrKaUk
 kuwBy5cP7Wd1dPijGg1mmRphZ+4IlFvzRrJdV7kssCixOfU6FtSV3Z57lrbjvvyP8HHzedtpUEK
 1yWzY2CSboSPLgs+vdL24sCO6N5A0fM4nPaXhMJVpZbmiiaU2w+t4R+CbiMTLUfvxHhh70wgbcb
 31ctRRBnXXJiv0X6Noy+6hyd11W3mG18VH6cMEhncRxY8+O5gvEkhS7e9LUnAtB7+VACvUknFrj
 lD9AsbARrigjh9odISpN5HjThC567f+OvosQSoO3K/la5Yrw3INvPzoS2Y1/xslqszpZr3xlxPT
 foiHcGM05pEJ3c/fzvDF+Eqe80hxDr9m9vt3MLb742NAq51+rJUuBQ/WQJSCMuI4XpjnKGR6t3g
 dlq/1cdQVlvi5myH8cCuE58CIMYkiCNwVw241Xz3XRRKcmqKdyK0+fNLvD8Y73jUM9QOLixb5Qv
 yV70c8ZgrF46lDeClXpyRchoMZzfQrie5TK1WjbGBI2N6AT77vLlSVhoYrCPJJX98yNuXY3Fp2w
 eIANrxNFwd5Yi30KSmuHd3ssO10sVZK125bhTFDM+1hkoWH11nyVYsBqHfVIVXU/SkgIT6dvlc/
 kHPdLM3h 3fmwu7w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

This adds a first KUnit test to the core exec code. With the ability to
manipulate userspace memory from KUnit coming[1], I wanted to at least
get the KUnit framework in place in exec.c. Most of the coming tests
will likely be to binfmt_elf.c, but still, this serves as a reasonable
first step.

-Kees

[1] https://lore.kernel.org/linux-hardening/20240519190422.work.715-kees@kernel.org/

Kees Cook (2):
  exec: Add KUnit test for bprm_stack_limits()
  exec: Avoid pathological argc, envc, and bprm->p values

 MAINTAINERS       |   2 +
 fs/Kconfig.binfmt |   8 +++
 fs/exec.c         |  24 +++++++-
 fs/exec_test.c    | 137 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 170 insertions(+), 1 deletion(-)
 create mode 100644 fs/exec_test.c

-- 
2.34.1


