Return-Path: <linux-fsdevel+bounces-4262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04A7FE369
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 23:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5131C208F8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32247A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNpv4DHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466861686;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3A36C433CB;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701294657;
	bh=kBYMx/ct1DJWmWZZrfAgu5rv/aqJOd49LOYKeJgW/mY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CNpv4DHstKF3PxggnUX4FHrJcqYePxrMZsptqwwZiD3jYC0EtBc4FKCErOk8x0Nma
	 089hRb3I+KOjo+2Ret3FHt772sG1ChgiBtUkr3F3Mcc2Tapxt74XpXPuFtOyO8/yW8
	 R17MS2K9P9TBhLZ7qiibZ+mz/kv1bGxkQ0A1jzi/RtvdD2B2XiJQpZZe2dsddNCvNK
	 wBRPLgYsbplXea35qt4vXD0S68urjWegwAAhc6hOal/Db6K7w24LqcqV5mMkacjiyK
	 aWv26FyeF+jG0yhW/SOYwhrqwOXgNDtRQHS52vYv7X9f1D+EvVrgy1TsrnnWtKYRrd
	 5MBC0PQ5/ypSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DAC46CA0;
	Wed, 29 Nov 2023 21:50:57 +0000 (UTC)
From: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date: Wed, 29 Nov 2023 15:50:20 -0600
Subject: [PATCH 02/16] mnt_idmapping: include cred.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231129-idmap-fscap-refactor-v1-2-da5a26058a5b@kernel.org>
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
 James Morris <jmorris@namei.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=615; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=kBYMx/ct1DJWmWZZrfAgu5rv/aqJOd49LOYKeJgW/mY=; 
 =?utf-8?q?b=3DowEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBlZ7IzazfoDYxcriweVPsbLfsCP?=
 =?utf-8?q?Xs/YDZSjasrRYGN_eexJIWaJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxy?=
 =?utf-8?q?QUCZWeyMwAKCRBTA5mu5fQxySJiB/_9HkMVbp8BLl9a8xkc+YIMjsDXeUD/DHctJI?=
 =?utf-8?q?ej9o90WQvjfYFOqnp97oRSL05awrVwXaUy4ay7+yCJS_h+TxM3omvveG14tjLJ3wC?=
 =?utf-8?q?yk3SZ5mQum5AyAut1Dx7GvAH+aKzPhZyyQZtT0nPq9vJ494NfMFXjQ5yJ_3S4b0Kc?=
 =?utf-8?q?fPnTHEeSpenRnG/gVjMR15wLsSE07DAnXfndDrwZ25uR9RNVxxoQ2/oIyPGlW9O4K?=
 =?utf-8?q?Zj8s0y_ApyXfbn7vle/qhUTdd10Mt0GITrja5wk0lSvSicVeS2eB1a7VlOSSCIz6P?=
 =?utf-8?q?Qhg2BEDCONPD+NTd0khr?= zlm1ANoVLdZpKoEkqw0ZUzJrM5jm8Z
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Endpoint-Received:
 by B4 Relay for sforshee@kernel.org/default with auth_id=103

mnt_idmapping.h uses declarations from cred.h, so it should include that
file directly.

Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 include/linux/mnt_idmapping.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mnt_idmapping.h b/include/linux/mnt_idmapping.h
index 8b5e00ee6472..65e5d0c32fde 100644
--- a/include/linux/mnt_idmapping.h
+++ b/include/linux/mnt_idmapping.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/uidgid.h>
 #include <linux/vfsid.h>
+#include <linux/cred.h>
 
 struct mnt_idmap;
 struct user_namespace;

-- 
2.43.0


