Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B27B33E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfG3T0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:26:52 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59565 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfG3T0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:26:52 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHGPA-1i5lAg3ZiK-00DIZr; Tue, 30 Jul 2019 21:26:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 02/29] FIGETBSZ: fix compat
Date:   Tue, 30 Jul 2019 21:25:13 +0200
Message-Id: <20190730192552.4014288-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VxTk9t+4Eekl9sCPB+GuZDa2xg1XBRfZQglgCfBj49V8HwSmbKd
 Sw7uRVqvGYKhkeLbQqxl8zdTMC4RfJTS1MLu1l6zvTVCdozLb1nU5LO2C4FwCrVqmUwAY9/
 2crBk3tFpmHkyXL+bmRrp0XMia+YHHHGue9lCZaxxA32R6FWCvfrFcEVEJmOkH1wlSjqQl9
 ONVXjZR43c/BwjmHj5cwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ow8KP7vl+/8=:n/Ux7h/tmfUb5shzgf+p5Q
 pPUfmEM/h2X2PHpWp0SMRuE9h9EuDgYH8EIHesF/7vQi+qnron5p12uAgMcIpD+GGLVdh/3Hj
 9vxHv6tM9/DJWP/vrlWUuvf8SYQE4kmF3gTfrIqPw/TPpDFX+xxQMmRKU918R/gEqQzdF+b+S
 oJV1Baa1PoKtHM/uw28YGttwVGuJsXw921fmhqrwxAVcT4N/cUS21orvEvbPApvj2YAOXDtC2
 77a2RGWNyxbMDRVVtgMnwEGEKwCKh0keLQH0rLvUyoVoPghghJlfxGv3YH/xpuWVGOyvg2SsQ
 RXO6sD49HUAJ+dC1CvVyoFkVktMA2LXimKhSwRFWVvmqajGgpaFgFiqosFOTWL7mTMu8cKIPx
 +gEsA6UvhdK1gW0IllbilCWowWIW2PByyXmaJdFEB0eR93WvhKKA6a3Ps95MBxLGb8aB89hN9
 Ad5ojH/vyw+eDmh1E83V39mDjzPgFc6UEtrGTxU2aSPwJ5hyKzMOEkcf8E3FBs2kCwYSluqXT
 PjuZ1hFMCSucerZ2alDT9Lq1Cwhv5ozwJ1mnorN77Z0KcNCNkYdV5fxSpph+Jh42zwtrqTVKZ
 movYVnycq6YIuYS7cSwb+krgAy5b42qE+eHpKSqM8d81k/zvJ+7Ggs6leXwBJURvChdQGgPIG
 XaAzB5BzN9h/rakR6aF1W+6czyIb3qO6CHLbKO5j/95yFsUGQvNCr9myzVtCC0qch8NKqhhb4
 k6xeofYmahv7IMIcGurE7p5H2R3/FGmphcDIqA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

it takes a pointer argument, regular file or no regular file

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 31104486fc8b..b19edbc57146 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -1039,10 +1039,10 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	case FICLONERANGE:
 	case FIDEDUPERANGE:
 	case FS_IOC_FIEMAP:
+	case FIGETBSZ:
 		goto found_handler;
 
 	case FIBMAP:
-	case FIGETBSZ:
 	case FIONREAD:
 		if (S_ISREG(file_inode(f.file)->i_mode))
 			break;
-- 
2.20.0

