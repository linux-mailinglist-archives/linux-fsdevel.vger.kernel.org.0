Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AA2741978
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 22:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjF1Uej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 16:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjF1Uei (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:34:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C13519B6;
        Wed, 28 Jun 2023 13:34:37 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso142892b3a.2;
        Wed, 28 Jun 2023 13:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687984477; x=1690576477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipbLnYvlGYQvDEihyiPuXfdid6qmlxbdUrEvPFMafw4=;
        b=opSL76LDc984zvWM3786OidbBT25+1HD1mQMziNNFfP4Zsljw5U+R1LwpfgRjqakdu
         lyO3voeeVszuMA+bdl57FtM0OiOwdjEhMGusRh8PrEwfT+W94UMOraQg8L2LqPIZzDp5
         nLnAxenahvm+RDN1eQWrhVw+chYXpSUC5++RVkiMEDXV2tKxMQkMlIdbYtS882Wp3wAq
         3UqdPomtMd0EEcrYiQQZw8VYnUHvixfbxCSUKSZgILtO98HCfujdnQMHBg2enLrGn11M
         FqODDg+KVXkLLJxNQLt1RyfgE/1C3D9Kg+00mZoAc9V4Y02ZyUFj27JJsXB3fDudmRsQ
         vwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984477; x=1690576477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipbLnYvlGYQvDEihyiPuXfdid6qmlxbdUrEvPFMafw4=;
        b=FxxGFXPvgGmDUhbtw7YmCewW8BkpLPeHUirq+tNPTz4vbzWI03GA98ty/XHBmPzDFx
         GhnY6miNONDh9qP3jLX/gbAbnDoZc2Ks1Vwp9+YHjy47VGmV+fVrthDHceTKTswKFqva
         VWWYy9FCpeovd9ZOSsRH9WhA/Sv5bkM99bsApv4s1YgdI0QTcmCrTx479Wu8AvcK5Ga4
         5bX3W/G3Id1qiGaOePDpXcV34h+En4Z1+pLAzh6pk4kVVZiF+EmAaAcVncqdIdvrjjYy
         aDmQUMO/Vwws/M0xA2vUrL3tiXMG2cgdxCkXV8Wuu6cBHduu1UOGpdZgUWk/tBXA+gjL
         tBSg==
X-Gm-Message-State: AC+VfDwh3jLk2vYtK6LDK83INmfEdTOrw0DZkzJm5Xm/n0HqsJAR2MzD
        yX44mA7w2R2dY8yCuZtrPpY=
X-Google-Smtp-Source: ACHHUZ6XkIRJQTHMzWEX1lQu8qkb9AYZLxxYyonQGrQyP+vNh08KhF9U2TY5f8OQbw13ohu8/8LZ8Q==
X-Received: by 2002:a05:6a20:3249:b0:12c:30b0:6225 with SMTP id hm9-20020a056a20324900b0012c30b06225mr2243475pzc.36.1687984476662;
        Wed, 28 Jun 2023 13:34:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:7961])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78281000000b0065a1b05193asm7367724pfm.185.2023.06.28.13.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:34:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 28 Jun 2023 10:34:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>, peterz@infradead.org,
        lujialin4@huawei.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, ebiggers@kernel.org, oleg@redhat.com,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <ZJyZWtK4nihRkTME@slm.duckdns.org>
References: <CAJuCfpGoNbLOLm08LWKPOgn05+FB1GEqeMTUSJUZpRmDYQSjpA@mail.gmail.com>
 <20230628-meisennest-redlich-c09e79fde7f7@brauner>
 <CAJuCfpHqZ=5a_2k==FsdBbwDCF7+s7Ji3aZ37LBqUgyXLMz7gA@mail.gmail.com>
 <20230628-faden-qualvoll-6c33b570f54c@brauner>
 <CAJuCfpF=DjwpWuhugJkVzet2diLkf8eagqxjR8iad39odKdeYQ@mail.gmail.com>
 <20230628-spotten-anzweifeln-e494d16de48a@brauner>
 <ZJx1nkqbQRVCaKgF@slm.duckdns.org>
 <CAJuCfpEFo6WowJ_4XPXH+=D4acFvFqEa4Fuc=+qF8=Jkhn=3pA@mail.gmail.com>
 <2023062845-stabilize-boogieman-1925@gregkh>
 <CAJuCfpFqYytC+5GY9X+jhxiRvhAyyNd27o0=Nbmt_Wc5LFL1Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFqYytC+5GY9X+jhxiRvhAyyNd27o0=Nbmt_Wc5LFL1Sw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Suren.

On Wed, Jun 28, 2023 at 01:12:23PM -0700, Suren Baghdasaryan wrote:
> AFAIU all other files that handle polling rely on f_op->release()
> being called after all the users are gone, therefore they can safely
> free their resources. However kernfs can call ->release() while there
> are still active users of the file. I can't use that operation for
> resource cleanup therefore I was suggesting to add a new operation
> which would be called only after the last fput() and would guarantee
> no users. Again, I'm not an expert in this, so there might be a better
> way to handle it. Please advise.

So, w/ kernfs, the right thing to do is making sure that whatever is exposed
to the kernfs user is terminated on removal - ie. after kernfs_ops->release
is called, the ops table should be considered dead and there shouldn't be
anything left to clean up from the kernfs user side. You can add abstraction
kernfs so that kernfs can terminate the calls coming down from the higher
layers on its own. That's how every other operation is handled and what
should happen with the psi polling too.

Thanks.

-- 
tejun
