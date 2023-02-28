Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D895F6A613C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 22:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjB1V36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 16:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB1V35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:29:57 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF632CFF3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 13:29:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id da10so45909439edb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677619792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8cphB32FCA+JDrayMTXIg9hnTVIdgiqn6d+31xf70g=;
        b=RnvoGAxGwdikhKT4SupAxcADFamYOt+/v6RSL1oTb/zDbv1TM2he0JfutFX0uxibsD
         aXfgAAPUlUpjgysAiDQd4529DHvHf+CRHuCzA3rdEZt3Lo9uF070u8Vc6hdwtGGCfB+P
         QOl8M4FHCDbGl0EnClfCc8ZznvdwK40yN+tsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677619792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8cphB32FCA+JDrayMTXIg9hnTVIdgiqn6d+31xf70g=;
        b=Ipa0LfWB3oGyO3H8UmfMRvU1AnTpWktASOGjrIieVEItqHK5yOgj31qQHxRuGnlNw/
         unWh6ZQ8dHN1NhcaqyAZXAwTVP2sSskBGSndxF5d4hvVzYcv+cupaCmxCGGSBUrp4VxV
         MpmA8lqk0xOR0t15Jo1HxNeClWLFPjaNbU7sgRQU/7qhmodFXOem4RRTAuJhmXUDFBbu
         TiZvWFc0L9I60Xk34EdNScvXJJ+b+8WBryGBFbyBfdE0KHpUydzbcL7yCxYHCN4sEcgx
         Rg+TLdoHPFGPF/wKP3Ajte2heE3G+TVBCTAK771HcmDspc0fUvOcISEDTOrRlTYlyaDt
         m74g==
X-Gm-Message-State: AO0yUKUN47cBTKIGtx2LrgHk3ArcoHTFLMIythNiDaVr9pVO5hTbfL2o
        oOk6pAlG8Gz7cIHj6IKtLTJ0bpeUgivK28BvehQ=
X-Google-Smtp-Source: AK7set9H64BnoLQghzqmXe4Vl83sUXeaNIjkHK5nUKNU/ZiLdq/Q6p51fxx1axx6OaVqDS1a/JXqrA==
X-Received: by 2002:a17:907:76c6:b0:862:11f6:a082 with SMTP id kf6-20020a17090776c600b0086211f6a082mr4015121ejc.17.1677619792268;
        Tue, 28 Feb 2023 13:29:52 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id us8-20020a170906bfc800b008cafeec917dsm4969732ejb.101.2023.02.28.13.29.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 13:29:51 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id h16so45793364edz.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Feb 2023 13:29:51 -0800 (PST)
X-Received: by 2002:a50:c34a:0:b0:4ae:f144:2c8e with SMTP id
 q10-20020a50c34a000000b004aef1442c8emr2699107edb.5.1677619791223; Tue, 28 Feb
 2023 13:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com>
 <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com> <CAGudoHH-u3KkwSsrSQPGKmhL9uke4HEL8U1Z+aU9etk9-PmdQQ@mail.gmail.com>
In-Reply-To: <CAGudoHH-u3KkwSsrSQPGKmhL9uke4HEL8U1Z+aU9etk9-PmdQQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2023 13:29:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
Message-ID: <CAHk-=wgsVFvGrmbedVgpUjUJaRTMVxvGkr-dcR7s30S_MyDZfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 28, 2023 at 1:21=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> This is part of the crap which made me unwilling to do the clean up.

Yeah, it's not pretty.

That said, the old code was worse. The only redeeming feature of the
old code was that "nobody has touched it in ages", so it was at least
stable.

              Linus
