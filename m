Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3AC5D465
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 18:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGBQii (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 12:38:38 -0400
Received: from mout.web.de ([212.227.17.12]:48861 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbfGBQih (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:38:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562085515;
        bh=kMEm5ieX8htfr+OImIiGhIeC1vPtqJlqrNBvgOU7pcM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=mxlaVHmy4XfFPz5w5L/9OcsfQYun8ahJ4bxROzFPOe65wONG9gYxJ/3QKyF1hceUE
         wq80HeWmATjqSgHpvHqhBZ3dQmpZYGKkqHQL4f3p1Q+hm96Wids1/CLPDZa+dhXBsw
         O0oC/ypO36Ol6MRxyjKlxFUsv0jR+rK+XIJzIAOg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.11.114]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lm4hJ-1iH8WJ3R8z-00ZiK8; Tue, 02
 Jul 2019 18:38:34 +0200
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fs/seq_file: Replace a seq_printf() call by seq_puts() in
 seq_hex_dump()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8c295901-cdbd-a4a2-f23f-f63a58330f20@web.de>
Date:   Tue, 2 Jul 2019 18:38:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:59LErC1OHXzOK+/huKorSLnMlbLrM5Gyy9vRGlDuNxjtqkkVdIG
 fpHAw7upKHcuHTIZeH6zbX2NnvbEks6YUbKARkSZAG7SA8NbhV3KZEXbmHG2gdvZZyoz78I
 5+2/9Z70xzbHURjl9/E32ltyGoHljxJaR526PdsTInsbvqbSLwrjZnvD/+/fC0+pFwgPIuU
 aeweUQoUG0Ayty8xLP+0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AsXEBfPaCBM=:bKYT5Zn+01VunanI8BHwE5
 k+qcdbtkna+LAmXGsicOrYuwI9WRtB75QA3OSBRkIVFSAgLAwS4XZGJPpsfXp3vnqPNACyHab
 dlqnNTl3bLu9sxgikHZL7k0SG26HNo2C3zQ0ctQ0SLoDL4zQXdZvvcWg9PSAazNyznJpvCS/1
 tzEXyc9pJgjZWA7cuOLel8Ab6+rAy7ZpkhNzfgW/e0pQEMcefyydZiOhHm6vD48GhVw6TR6Sf
 jSCTxSq+KD6Gjt039ojMEWMnAkjkycseMwsr6OBseF/4VpFZhnB0va2e+qzkgKnSD1+pJN9Vm
 asoh28srM0n4FiJd/WcLdDcTBGWXMWhn+N+guK66mHxvrWqV5dGIBsv94PT5el/A1YK5jFa2e
 VpVkxQoYX9RgPafLDhhGaBOlG09VKmBxGGZgHsxRHkhDIAHi0N9aNQH/adrLigdYMTWJYcvy+
 oBTwwwoH92B4v0GHrlmvWQWnYpNjguJygeL06NdpbIHvuDQ57eUKt0NZLUwjEKTGCld3eaYMs
 CK8lIEC75bbbYtbNasq+W02/hy8ho2GE0GOJ+EWn7UZ8f1ImhstftWfoX8bLjEU6FAiJyWpjc
 pHbpq33aifCRecngH0vDlS2vvsvEiqY5qBSSHg5G/xlKIhEKnKNUyX0WN6qV0kOY+eWJiUNYx
 tzhIgBwsQQx1VBCaiOZMOvC7o1LWGx6ZscLS9YOVr4NsD0kfxaDqhz3SH0rcWTe3bVx0aZbiS
 TlB3EnuRuhDtUVRdoNlramvkKpUHenRbqLw3PqNm6OqX7FRiuPRw6VF1R5VvTuJxUzLxQNhRE
 ss2eUgdhOLRTlsn/O75TEh5V+B18lItu5uQcC45tX73EYEZC/Ko2xa7ZURZJjFeaRab0GA//o
 eb3LsnuRjgvjBclpw5JkT2kmsmnTyLHkF/aZ2SwXy+66q7qCi828CAa5MpS8HLo1ewHOIZ9m3
 yVlQNV2K/tGiPPEPzEZiaG7HBE/+o0Pa2+3ARq34gOlbJl2I2v1IQGo5c1orVpx1dKMagsq39
 s/9FR2FEL4eTL14iaDEl/nAnVG3ozThRQqpdMrvs8XEytskI498lG5becOJ18qZuzJq+TBfEe
 RAXtJJtS8ABnpKE/5l3XsuxGDS3viqaGkKm
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jul 2019 18:28:10 +0200

A string which did not contain a data format specification should be put
into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/seq_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index abe27ec43176..ecc68e9dd31f 100644
=2D-- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -868,7 +868,7 @@ void seq_hex_dump(struct seq_file *m, const char *pref=
ix_str, int prefix_type,
 			seq_printf(m, "%s%.8x: ", prefix_str, i);
 			break;
 		default:
-			seq_printf(m, "%s", prefix_str);
+			seq_puts(m, prefix_str);
 			break;
 		}

=2D-
2.22.0

