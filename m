Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D543B03E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhFVMOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 08:14:01 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34437 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhFVMOB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:14:01 -0400
Received: from orion.localdomain ([95.117.21.172]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mn1iT-1lWXV33A6Z-00kBxJ; Tue, 22 Jun 2021 14:11:42 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: RFC: generic file operation for fstrim ioctl()
Date:   Tue, 22 Jun 2021 14:11:30 +0200
Message-Id: <20210622121136.4394-1-info@metux.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:W2BeeFr7U+wjER9qNqOeODEQlcctBdEdMmZlsDZ4KHdnHjwBMCv
 ZOTZYZbE3r9/l/PhVbAKwTSRPQNLdLiE3sOk7/yk7zNLUgK+t48gKNFnxIyErDqMWaXVzta
 DjnGi8eUFoQiy21OMx1Ady5sV6lv1kWrWOtQTfxoBaIPomv8mmfNjNp22/IQT2Q+uxAbC5O
 UP6lVCcHNAxEUMRbXzBcw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ukJISyO1zCM=:T2VKI7c5AKGGuoRFQyH0R5
 xLBlJBRn4SE+RcmVpNmVr8XBkFwk2xvl4iFOc2cS83dJz18+rutnacCflJEV7OkzE7ymCr3HQ
 UZNDLwtVNxE/+u4t5LTeI0pt/JuucZ+mDVmCLd7MTteM8oxPnY5HHHsxlxVUWY2aSNLOIr0Ak
 puwJq2Va+Imke3Q0iHg4Gnb5qJfWuUFmSf70r71ZHqyz4bp39R43GkvFqWbTAI2jDaA2vKTDK
 07Q5l0jQ2hv2AmXvWCsTlUbycKxmEAR+P3daEIrAP4VZx3jBRMsfbvJvXufXJUuuDAvMpgMrw
 4Kn5kxqzuqDwj0hBjrbcUzYb4Ib9hrTjMC/SahrmI6eOt9Ylr3WVK8NepZlCrVKiM1abzMelU
 eKr1DUJTnHAkVRfdt/Qtf+Ax+xKXilA4L6+BfOMm35j/Ce0lSa/dFi1VkNIDQFxbiwCtcSdiE
 H6y8MInYN9pFzJVDE059j8qp81fR+r2I2XlPHxujytQ4ddaYnA9tT2jYvFdeOlLPmpfBpkQzo
 sfGXg/qkvjXMN4oUHUb8Qw=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello friends,


here's an RFC for a generic implementation of the FITRIM ioctl:

* introduce a new file_operation call vector for fstrim
* move the generic pieces (eg. cap check, copy from/to userland, etc)
  into a generic implementation that then calls into the fileop
* passing to the old ioctl fileop when fstrim op is NULL
* convert a few fs'es to the new schema

Rationale: it seems that all file systems implement generic stuff like
permission checks and buffer copy from/to userspace, all on their own.
We already have a common place for generic ioctl() handling (do_vfs_ioctl).
I feel its time for factoring this out the common fstrim pieces, too.

The first patch of this series introduces a new file_operation and calls
it on FITRIM (from do_vfs_ioctl) if it's set - otherwise just passes
the ioctl to file_ioctl(), as it had been before. So, this only becomes
active on a fs thats converted to the new file_operation. Subsequent patches
do the conversion for a few file systems.

Note this is just an RFC, don't apply it - there might still be bugs in there.


have fun,

--mtx





