Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A6D66A251
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 19:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjAMSpF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 13:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjAMSpE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:45:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B7D209;
        Fri, 13 Jan 2023 10:45:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 18so32335227edw.7;
        Fri, 13 Jan 2023 10:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fVyfE7TORjs2ncDiYR6RHn/voCN67+L9RGjNyyFWon4=;
        b=gub/9QAk7eF+UCFfx0DndHNotZYTPE//gNHNzxMJu9KVlzlge37X8QnM4vz9XgVoGW
         NTkTX0Jrvy0X1iLCKx3dtMJEfx1P9RPnrqj7SnNoT3zAc9U0LsO7GYYH1r76YnEOuuVV
         S0Dmt6PeQLQxQlI3Km6j9RPdxR3Fde4aD7mC5AA83q3moLDMKWIU4il2nMi73hJVfLuw
         N6PrrdTTg6pe6P62Hz/uBnY9fNKwaBHvRi2vPXov2BNekdhY5fwYHwVsLVFpdrYgkM0N
         uTHOmA+zJH5s9vTAh+oiVpU46/5NyuCKWF5Rvim+ioS1Vw+147q2Xkc11aL/mVGJa9uV
         h0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fVyfE7TORjs2ncDiYR6RHn/voCN67+L9RGjNyyFWon4=;
        b=fkFFOCcTuSNwzhI1a6ZPLRvUWLhG7jWFlkBfc4s9SS28qWY9q8+f/+9Y2GVy9eu++p
         Jb879K0dSnBj8XRszoNGuemZx9/TEwCungnFRo9YYMC45nJehlmljowZ3tasC5fPDtna
         jeZRtJxsKjA3FedScVEni/ZlqTJWj4wvgXm/EMuqbtwUviUVYDu6VQV7HAIyB4NM9c02
         WT8GpdTmztdYmp9A/x4XI7t4rk85NgZeK+ylery6EAsbKx5traJRxlkDvDSw04LziVMc
         0GlndzD/b6vM7mPKCrGjpe2pVEMpxiWNhmTPmOX6Sz0PIxIsRfxi7jeJy+4tCFmsghYp
         OgUg==
X-Gm-Message-State: AFqh2koCAE1biMUQ0Yq2EH2qGJD7ceEbZO3EmXDtpSfgcpGcTTeVo/LX
        D/3Wju6g0nawWp/se9GYQ6A=
X-Google-Smtp-Source: AMrXdXs9Nq/D7npk4F9SpsYBT4FccC0XrYrklNLShn5a9UNkqQ5v0jyGHNqsroeXFPFHmdioCAUrzg==
X-Received: by 2002:a05:6402:3227:b0:48e:ac4e:7bfa with SMTP id g39-20020a056402322700b0048eac4e7bfamr847292eda.2.1673635501957;
        Fri, 13 Jan 2023 10:45:01 -0800 (PST)
Received: from f.. (cst-prg-72-175.cust.vodafone.cz. [46.135.72.175])
        by smtp.gmail.com with ESMTPSA id m17-20020a50ef11000000b0049c4e3d4139sm889873eds.89.2023.01.13.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 10:45:01 -0800 (PST)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, jan.glauber@gmail.com,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mjguzik@gmail.com, mpe@ellerman.id.au, tony.luck@intel.com,
        viro@zeniv.linux.org.uk, will@kernel.org
Subject: [PATCH] lockref: stop doing cpu_relax in the cmpxchg loop
Date:   Fri, 13 Jan 2023 19:44:47 +0100
Message-Id: <20230113184447.1707316-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
References: <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On the x86-64 architecture even a failing cmpxchg grants exclusive
access to the cacheline, making it preferable to retry the failed op
immediately instead of stalling with the pause instruction.

To illustrate the impact, below are benchmark results obtained by
running various will-it-scale tests on top of the 6.2-rc3 kernel
and Cascade Lake (2 sockets * 24 cores * 2 threads) CPU.

All results in ops/s. Note there is some variance in re-runs, but
the code is consistently faster when contention is present.

open3 ("Same file open/close"):
proc	stock	no-pause
1	805603	814942	(+%1)
2	1054980	1054781	(-0%)
8	1544802	1822858	(+18%)
24	1191064	2199665	(+84%)
48	851582	1469860	(+72%)
96	609481	1427170	(+134%)

fstat2 ("Same file fstat"):
proc	stock	no-pause
1	3013872	3047636	(+1%)
2	4284687	4400421	(+2%)
8	3257721	5530156	(+69%)
24	2239819	5466127	(+144%)
48	1701072	5256609	(+209%)
96	1269157	6649326	(+423%)

Additionally, a kernel with a private patch to help access() scalability:
access2 ("Same file access"):
proc	stock	patched	patched+nopause
24	2378041	2005501	5370335	(-15% / +125%)

That is, fixing the problems in access itself *reduces* scalability
after the cacheline ping-pong only happens in lockref with the pause
instruction.

Note that fstat and access benchmarks are not currently integrated into
will-it-scale, but interested parties can find them in pull requests to
said project.

Code at hand has a rather tortured history. First modification showed up
in d472d9d98b463dd7 ("lockref: Relax in cmpxchg loop"), written with
Itanium in mind. Later it got patched up to use an arch-dependent macro
to stop doing it on s390 where it caused a significant regression. Said
macro had undergone revisions and was ultimately eliminated later, going
back to cpu_relax.

While I intended to only remove cpu_relax for x86-64, I got the
following comment from Linus:
> I would actually prefer just removing it entirely and see if somebody
> else hollers. You have the numbers to prove it hurts on real hardware,
> and I don't think we have any numbers to the contrary.

> So I think it's better to trust the numbers and remove it as a
> failure, than say "let's just remove it on x86-64 and leave everybody
>else with the potentially broken code"

Additionally, Will Deacon (maintainer of the arm64 port, one of the
architectures previously benchmarked):
> So, from the arm64 side of the fence, I'm perfectly happy just removing
> the cpu_relax() calls from lockref.

As such, come back full circle in history and whack it altogether.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 lib/lockref.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/lockref.c b/lib/lockref.c
index 45e93ece8ba0..2afe4c5d8919 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -23,7 +23,6 @@
 		}								\
 		if (!--retry)							\
 			break;							\
-		cpu_relax();							\
 	}									\
 } while (0)
 
-- 
2.39.0

