Return-Path: <linux-fsdevel+bounces-4689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68160801F04
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 23:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22686280FC8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8C921100
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kHs9wlop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4050102
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 13:22:19 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2866e4ac34bso769584a91.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 13:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552139; x=1702156939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6q9rxKV/doUXKLjycqqgPKowk2OvJvKvEALIpKz5kcY=;
        b=kHs9wlopJ9gWPHAgN+0LZcpZoEF1b2s6VHwOD8or5m8w60stKKdekaLU279U/0tvvl
         nlzDo714yQgH9eYTWO3gtSRt6/mi3Q8iEcMBOTrXt/7FuZ/ToLytKnm9IEqd7K3MppnR
         aXc30wKNGyUaygFgAbyeUi0IiN5ms8GbnaMUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552139; x=1702156939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q9rxKV/doUXKLjycqqgPKowk2OvJvKvEALIpKz5kcY=;
        b=IA9j71bkeRM8dw4BIy4vL9vGJP/z1UeyOGUPPLwiE/ylaMkNQxc66TtQwEIcGmAgQv
         3ZSNa7ApR9I1xI0se1uz82nP0rW8yYrnAsTLahVT5DNAq5EKNX328axOoCAxMXJkw7SA
         Y49Zd7qCD1oxVzNnpeQxonf/ItyaNU15c/l3bwLSHidakiDBZOqGx5EdIsVHQwgoeGPa
         yS6uFRNs4iQICjSERQXdYKt0/U/QzgDD658AwYZfFkwjwa1EtfV4UWoUzStFVcB4q+wv
         NKOnHRZhbPAv08b3/FO21uUMvIAGXoFp/CgrW1maSXF+4Hd/QxaSe/7/L0/u7+/Q9+Zj
         Fd4Q==
X-Gm-Message-State: AOJu0Ywki1q81puaFv/F4I/KQ1HBhsECpiRp0z37rjEqD5nvPMCjuCCv
	0iVzsjVrJlNDl+6yrUgPKZBhrg==
X-Google-Smtp-Source: AGHT+IGwdZyNrYkF0JkXUehoyBhB49FcgaPQH5ljbn8bJURYFny7K2GwkFNcA9nQkamR1wf/yUNoHQ==
X-Received: by 2002:a17:90a:4dc7:b0:286:6cc0:cae8 with SMTP id r7-20020a17090a4dc700b002866cc0cae8mr1174330pjl.95.1701552139339;
        Sat, 02 Dec 2023 13:22:19 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902748800b001c9d6923e7dsm1825013pll.222.2023.12.02.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	Christian Brauner <brauner@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] pstore: Initial use of cleanup.h
Date: Sat,  2 Dec 2023 13:22:10 -0800
Message-Id: <20231202211535.work.571-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=764; i=keescook@chromium.org;
 h=from:subject:message-id; bh=OkDdOwhG1YDg/PhDeGCQ9MLDBDYk/GZl+EOkqpfwlJY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGcFq7mh0j/SHF6DRy6dTOljcIUt/3e8KiD
 O4m31aHYA6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A
 JrS0EACDNa5cDFv8v98syV/CLw45XT9+6rkHlsnLPV6CO+qqH3XWas/PukrFwEtySggzDLfJSVO
 KMG1z1EhLkxTZ0yEZSb8MPm/gPAVBgorAHz+XxvwVvnd7AK93xAywzkoJJdKlVhw9dwTwnC68wg
 ocH77HFxf0URgyLGb1o83VKRWc0C7lwcHAjYCFfdj7IhVzAyWTIAclxdIj9A6B0MkMPZH68hKcA
 HJoMt1GUIvh1/JZvMXedDEC50I/yvOxfvaQQSV1xAIJGbxIsFYCRftyx2RAEn9exGmlOAOKIKOx
 NGTJTJZokqBFTZUvnv9v3scP9NtfpC2H3xvH0cGgHtC3UszM8Z0X+HIZW2AL8AlI9uz1WcXh69w
 RjiAzLTbByaoAroGs4Al0Imk2lPjgQ8wEEzsWRpRl+Uff4hKOeEK0F5qex9i245ZUvZg/65ugNK
 X1rZArEyldUwLgtO58KLapZ9WYAMzCkxOwLq2GjMqT4wazJ1vNCvP72m5odQyMEm3UGN45Qbkot
 oooPjw0Jpctobyq9xCglh/gJEAu0AJX/artOjUYjLAgXpQ/71dj9QQfn7GD2sLMSFHyk8uy0fWJ
 ydg392bMXkgv6tAbniE6m6aMoiGi0+Y1kzj0J05WDQsZvnfYj7jJM3rbZszjLwkOJ+aKdo9sw0G
 l3EdSM5K iUdlLSA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Mostly as practice for myself, I rewrote a bunch of the error handling
paths in pstore to use the new cleanup.h routines. Notably, this meant
adding a DEFINE_FREE() for struct inode. Notably, I'm enjoying this
part: "44 insertions(+), 65 deletions(-)"

It also passes basic testing. :)

-Kees

Kees Cook (5):
  pstore: inode: Convert kfree() usage to __free(kfree)
  pstore: inode: Convert mutex usage to guard(mutex)
  fs: Add DEFINE_FREE for struct inode
  pstore: inode: Use __free(iput) for inode allocations
  pstore: inode: Use cleanup.h for struct pstore_private

 fs/pstore/inode.c  | 107 ++++++++++++++++++---------------------------
 include/linux/fs.h |   2 +
 2 files changed, 44 insertions(+), 65 deletions(-)

-- 
2.34.1


