Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96D0410AF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Sep 2021 11:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbhISJrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Sep 2021 05:47:35 -0400
Received: from mout.gmx.net ([212.227.15.18]:39345 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237283AbhISJrc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Sep 2021 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632044759;
        bh=r4hGg2nzjgYQkWh5/4rIRlGxwf45LrpPE3sv0kvrGH0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=DNBUaATxGVDT3RN/xQy49Z8j5hWU9GGroDRPooyy7s0QvKq2mWo8iplnDy/t4/JD8
         6PzmeYWVDNo4qMUKeRabBrdT6fElJCrDnIFTdHYX15fF4ds/+QqfGlCczlkB4Reskl
         1icmntt8tYR50PWX/Qn7swaE7lJaobmTNLNalCrs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MryXH-1nD6FW0OQ9-00nwsx; Sun, 19 Sep 2021 11:45:59 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] aio: Prefer struct_size over open coded arithmetic
Date:   Sun, 19 Sep 2021 11:45:39 +0200
Message-Id: <20210919094539.30589-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3zE+IGnU+JvHXyrQW0fh9978yUWELRjQP+9rWdcNIUMYedoyJPg
 XiqRKExu9060t+6asJ6MhHzi9KAWk/A6lvhbmvK0I3nO8PXqUTnLNsEdM5iTHG2WbvDSBb3
 8kMLcSW9lxCW/CBd/QzFQeP38Bzhk+YY9HqWklfJw+S0bzWpzPuLGiVb15VJVbL4IyWErd6
 RDca97UF1IzBi9Eqd+I9g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4b5Gkt+eIJQ=:rBfGcLTfCy5v/ujrq0DLaV
 rDVXHA/uA32v0LeD+Njjl24b0iXKDbXAU3a97didj6+Uw+cekmQLkYLBFTqSuTQYwyiSfV6pO
 G0xE8iKDbKqLRN3HmEWGRdWe5TKvO6oS9QEte4FrnGtuUdUrA9oCuSMBZ9QWePN+M5b7rTtD4
 UTquhoni45d2g9ZKgSya8R9B0zLjaRq4P3BDDcAn4UkmjBVSMiSjf0Ah5RKrW7ZwUzHHB8QxI
 /fvfUReic6jGu99pyb6Tp1E86eJYm62EyUk5tKmUJUKASRPJGJetIqh0ItgMGSg/z+ddSHxNu
 DQJeiF61k4iBRH6uwAJHXjaMnFNGYoY9dVvFpgqH8/4pEBFZ03TsScPBGI5ESaM/gOT86zT1P
 8MNBKSEmuyAyNfctO1Jq3WEm/Jl9gIOyVrrt8yml8rmrfviwOZ/LbvkpZ1pgyvjDzKflUA7NS
 sEc+v6lUFVNrNORlgmahsAZGmtVC6umGxxkn3d/4d5Ey7cZuai/cVsrX1+AhEFgiTauULxHwE
 kJicOcuAmE/jxyGDYOKBZW+sZf8RPGDwmLgY/N5UPbJzcETn1IuZ25UvmvDP6wuwKLc6JocSf
 kpID8sbf11Wcox0K+nynY3Yd6pspnbDeQ+9xEOWIze/+uYQlfG2s+QXcmv+BBSXQNGwF+8jNF
 bHnjhgpLv+EKq7Ng/VVdIH71hZDctoxBcNC9t/GuT4hJgDoPUz57bSWDBZTHmqF5+U51T1Fad
 wjuoZi6C/TfzAP6fw9FEjJP447CgmBZzJCDgVLBjFeGkbr/LNIHVUp8anvsiNTHLhtaydy8FD
 loccu0LPtIIRkgkTGHwQbE+rG/ggb9zuKLR6oPhsjSh0YwYEJdx+KR6/sCrNybma2ZQHg2wgK
 zOTYgx5rzHjQuTaBejqvIV98mj/MaitBaxTr2nauFMcNMogArzy+2lFGw0Sw4EUIiZfxUDJbJ
 o0mn37+G0RU0ECs9x2tO9IWUud7qQf+eT1oej9RikjSWWHry0XISIB5wbH2Bm0HrLIhBRPsnZ
 nfN3fkQrm25slcIuL2r+YBgdelfxFat3xcgZEOs8P436U/wfyKgGYwkZ1Uyoi0LO5JNa27QTT
 ygJWo4DG3upBX0=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the struct_size() helper to do the arithmetic instead of the
argument "size + size * count" in the kzalloc() function.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
 fs/aio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 51b08ab01dff..c2978c0b872c 100644
=2D-- a/fs/aio.c
+++ b/fs/aio.c
@@ -659,8 +659,7 @@ static int ioctx_add_table(struct kioctx *ctx, struct =
mm_struct *mm)
 		new_nr =3D (table ? table->nr : 1) * 4;
 		spin_unlock(&mm->ioctx_lock);

-		table =3D kzalloc(sizeof(*table) + sizeof(struct kioctx *) *
-				new_nr, GFP_KERNEL);
+		table =3D kzalloc(struct_size(table, table, new_nr), GFP_KERNEL);
 		if (!table)
 			return -ENOMEM;

=2D-
2.25.1

