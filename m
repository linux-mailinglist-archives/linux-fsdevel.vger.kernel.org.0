Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579617AF733
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 02:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjI0AQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 20:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjI0AOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 20:14:05 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E833158AC
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 14:32:20 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d81dd7d76e0so11308007276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Sep 2023 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1695763939; x=1696368739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NY9jveINp5V5rlaBbscxlXmPxYesM9ges3+QHzPHTww=;
        b=JevHIhiYqEti5uTChAjUeDs+BEKCL2g/TRyKpHJ/sKw/h9kJ+4HCHHueL9YgowiXeH
         y+mmV6LB+UES6nnIE0g9mcDow3/ZHPCPRA5pmeJtKaqszxJpl0NT7ay2th4isuwERWRd
         6ifB8qXrbjG6XHh86W6nYjbJ42MprekK2a0jDJyRYz6wdUkKZDcVRoJbS8W75zZJ/ol/
         wjRxHQwuiELIsm0pgootgzP3h4C5nRtHxDOpGShBY4KEdcX1nWkWGPR50zOC0aZH70pv
         bM2ZAeX1I+fDiPw6Kc3dDttcv550is1BDPyTfxuXeB+7xXzhCZYRvFSfU+WatkBxmaVl
         Tq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695763939; x=1696368739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NY9jveINp5V5rlaBbscxlXmPxYesM9ges3+QHzPHTww=;
        b=AIQF+QyTUh3CeQhtW958cDOiGoGZstd8fIOdIGwmhXmAu4dikIb4himhHpnKi7O0JD
         gUaFZR1ED71SPs2shFjGT4ENz38irCPxmmwYtjePjtJ37YzTnK6x2QOG/M812bevIJ5h
         DviPlUtKon6jPI1rGg4/qvd1jJhjyebckI7pVynPlcHUv5JTVsZUxy3o/Wvg0bO9u/9K
         39cd/rQKixs3FXHPdv9qI579gaTe9a5efRM6o7xmVUWCBjeE7n7ber2xom7+3GMwzXD5
         pdGvcTsoHl9321wm4Gje0S224W67gsgGzdGH4wwe2gaypJTb+80BNeZbtRKBsFopnmPX
         s5eQ==
X-Gm-Message-State: AOJu0YwxiJCdLYYa4afDEUovjY7A89huFK8SYboUxWZC1LkS7T4wqMtM
        b5GwAeVRawLRifvJBx8FAIhheIWfDaPnUQGrdNN2
X-Google-Smtp-Source: AGHT+IFCtQ0lRQAQtAczfLsb2sztHe5JKNKH8brd6I1PKgoiFWprOSxrLQWdFdj8Jz71vraPlw9N0n534XJeETDCyZI=
X-Received: by 2002:a25:d308:0:b0:d85:e4c4:4778 with SMTP id
 e8-20020a25d308000000b00d85e4c44778mr183132ybf.0.1695763939574; Tue, 26 Sep
 2023 14:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
 <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
 <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com>
 <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com> <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com>
In-Reply-To: <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 26 Sep 2023 17:32:08 -0400
Message-ID: <CAHC9VhTLnT6HmkvJBXVCApHG4sCFdgXxJykPQ8oYLaVa8vXWkQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, keescook@chromium.org,
        brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com,
        sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 22, 2023 at 6:35=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> No worries, lots of conferences are happening right now, so I expected
> people to be unavailable.

Just a quick note to let you know that my network access is still
limited, but I appreciate the understanding and the detail in your
reply; I'll get you a proper response next week.

--=20
paul-moore.com
