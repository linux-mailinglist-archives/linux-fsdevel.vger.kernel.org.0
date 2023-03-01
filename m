Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7895A6A71F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjCARU1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 12:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCARU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:20:26 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1612F78A;
        Wed,  1 Mar 2023 09:20:25 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id o12so56766362edb.9;
        Wed, 01 Mar 2023 09:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PlUwDtADYHSrJPyoxSgDxKr9/apm1LHvBX2UdWMjnq8=;
        b=kmY8+0jd0UO04TZ9LYpBCyQY03De4TqTrGm8NPfSf0vaW64b45be7w3o4md6WrYQzD
         Nk6yyZvFj30UxurRBN3V+nafrvvrx3pvJOA6uGD4dKM4/Gosc9LXPYIpxLk+e8oI172a
         epfY8bLQElCLQBG/G/D3aNXPmrvDqlpag/b383C6TarUk/MiYMkzu79s8/llnCqhyT5O
         D0DyTUGP2J+daMOT78INprXwotujvJQOezk6R/D/0mdukTm1U+kZJaccajHohx1R8aHN
         VoTMHHUgoDJ4yGdV/Y8WXYHEXZdPj2ytqmVAF6EIkcKvd8pySzX9ILVOqDzYmD/P2JvV
         G4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PlUwDtADYHSrJPyoxSgDxKr9/apm1LHvBX2UdWMjnq8=;
        b=YisyumKbbQ2QZXLGgjVKmcIonM5PvCm59ht8aeiw3qhiGvEM2Zb9FbWAzGIGA83eNK
         81pn7xCLe+lEpQGppYmwf8Qh47UUiUOY+9TXk5pLf7vCiSr3lOG7cMZn+Attp0ktRIJp
         TCrJYViUXdgNXnFKPsOicdgyrc0QSD/qvkei0MaObAqi+pp0oQnMEDls0dieaYouYEfQ
         oSZPv5dNjN1ophFV5PzRhJVwEC58C/9VND0BtVYatJ6tcnmiZavJ6g/87BrgUW/3OaE/
         /XUhWG9oHW4NuJOb2jv1+4gN+IgqPbDnDEZOOpqr7u0aQAcgNaTRPYvVxG1i6f3rxzpC
         LMOw==
X-Gm-Message-State: AO0yUKV4qbdGCq9lZPAcYZrISPxuE0joQKyTo6iECaq2wzRC1JJO9g/6
        +H0F0HDiF4dSdI2ttMfvVD8=
X-Google-Smtp-Source: AK7set9ce/Lg09giRLFyJlygFLDRlK0AJJHwRCRI7xF7/8PjhdMqFjMHxUup6B/jZkvyjMraBN7X5w==
X-Received: by 2002:a17:907:2ce6:b0:8ec:439f:18fb with SMTP id hz6-20020a1709072ce600b008ec439f18fbmr7719468ejc.29.1677691223898;
        Wed, 01 Mar 2023 09:20:23 -0800 (PST)
Received: from [127.0.1.1] (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id oy26-20020a170907105a00b008b133f9b33dsm5894826ejb.169.2023.03.01.09.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 09:20:23 -0800 (PST)
From:   Jakob Koschel <jkl820.git@gmail.com>
Date:   Wed, 01 Mar 2023 18:20:18 +0100
Subject: [PATCH] locks: avoid usage of list iterator after loop in
 generic_delete_lease()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230301-locks-avoid-iter-after-loop-v1-1-4d0529b03dc7@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFGJ/2MC/x2NwQrCMBBEf6Xs2YU0RUF/RTxsNhu7WJOSlSKU/
 ruJl4HHDG92MKkqBrdhhyqbmpbcYDwNwDPlp6DGxuCdn9zkRlwKvwxpKxpRP1KRUs+llBUdX5h
 dCtFfz9AMgUwwVMo8d8ebrE17sVZJ+v3f3h/H8QOj02jQhgAAAA==
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677691223; l=1254;
 i=jkl820.git@gmail.com; s=20230112; h=from:subject:message-id;
 bh=s8p60stXlwjtVT6XiuBNRX2nbAh1LO4y0YMOQFFePMk=;
 b=fYRttOSj5AURDfVgB1PTV4Wf4V5JihCeOaPgiew3txrpcAzyUBZeXITuLbn0t9YBgzoJbXSeCnL5
 wI62wyprA6nL2zskNxukFdOcdqBo22Kl68xaAvBOAGr2rP+bYAbA
X-Developer-Key: i=jkl820.git@gmail.com; a=ed25519;
 pk=rcRpP90oZXet9udPj+2yOibfz31aYv8tpf0+ZYOQhyA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

'victim' and 'fl' are ensured to be equal at this point. For consistency
both should use the same variable.

Additionally, Linus proposed to avoid any use of the list iterator
variable after the loop, in the attempt to move the list iterator
variable declaration into the marcro to avoid any potential misuse after
the loop [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jkl820.git@gmail.com>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 66b4eef09db5..3f46d21a95f4 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1841,7 +1841,7 @@ static int generic_delete_lease(struct file *filp, void *owner)
 	}
 	trace_generic_delete_lease(inode, victim);
 	if (victim)
-		error = fl->fl_lmops->lm_change(victim, F_UNLCK, &dispose);
+		error = victim->fl_lmops->lm_change(victim, F_UNLCK, &dispose);
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 	locks_dispose_list(&dispose);

---
base-commit: c0927a7a5391f7d8e593e5e50ead7505a23cadf9
change-id: 20230301-locks-avoid-iter-after-loop-0c6cc0fbd295

Best regards,
-- 
Jakob Koschel <jkl820.git@gmail.com>

