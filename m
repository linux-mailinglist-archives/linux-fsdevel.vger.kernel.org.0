Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586CC185357
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 01:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgCNAcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 20:32:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43963 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgCNAcw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:32:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id r7so12502705ljp.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMErMaHHZEfJVKdh/LzqKM9AZGPTHK1128Br06lV9rE=;
        b=JmPs2t4VMNb7SjMik/nBvMjmm/0Ai21M6NG4Z1pEN2TGml1icBZolBKPU+MTFR3qov
         C1LT6aoBLNUDsT3oWiCnD8Vef9FBCVjYIeLZIDa7ayvP1kbcvKufavDoziWrLSjL1wbZ
         XsQq4CJwAGFvry6iJ4FZN1XfsilMkYlq1eU+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMErMaHHZEfJVKdh/LzqKM9AZGPTHK1128Br06lV9rE=;
        b=j/b0+m56vT2uuVgib7McOOnE8G7DqlIfAm0IiJwVyboEsyvLD5jrdbcfHGnU0UxEN0
         p2p7feZSbubQr+yB5xHXfc3Yz4eoeDm6H2LMFo7Ca9XEwZrjXUYvDvASiJazjRVrZVyp
         BlIaabOCS/e8l+xhR+GZqUdjJ3MVIZso28sc6S2PEGvuN07FipoYXN5XEIgk+7AMGnrw
         EEBRUoN2obAsqQl+TbEljhcplUr0Ay2nAEb02RzI0FXmS/AI0zyi+FKoWUGdE+zK3u53
         cFbrGhWFyLqRF3Ud+pPYTQ/OQeObB2ee6/Xv6iEpaA/0czm2w39RVoj527WQ4ywi3P6A
         WNWA==
X-Gm-Message-State: ANhLgQ1p/IBdwfudFqfct1ATrNY0e+pii4YOW0ZKXICBm5B6Oh3qxcdB
        5xV37unfeTNHMGlQedNxmO7R6o+Ilkg=
X-Google-Smtp-Source: ADFU+vsT8Ntg+278ctwhCDm055S0vmS8JJmLy05eMZ0qzJPMETtc8KYnG76EX2wIrtxYOBHQPHk1pw==
X-Received: by 2002:a05:651c:1058:: with SMTP id x24mr5896263ljm.248.1584145969622;
        Fri, 13 Mar 2020 17:32:49 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id c7sm1476315lfh.74.2020.03.13.17.32.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:32:48 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id s1so9332318lfd.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2020 17:32:48 -0700 (PDT)
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr10337015lfg.142.1584145968339;
 Fri, 13 Mar 2020 17:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-15-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-15-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:32:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=widhgJ=hB=dOcQMJzPL9mX+8TdbcAspBXs4FSdiLk2jMw@mail.gmail.com>
Message-ID: <CAHk-=widhgJ=hB=dOcQMJzPL9mX+8TdbcAspBXs4FSdiLk2jMw@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 15/69] new step_into() flag: WALK_NOFOLLOW
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I mentioned this last time (perhaps for a different sequence):

On Fri, Mar 13, 2020 at 4:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         if (likely(!d_is_symlink(path->dentry)) ||
> -          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
> +          !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW) ||
> +          flags & WALK_NOFOLLOW) {

Yes, I know that bitwise operations have higher precedence than the
logical ones. And I know & (and &&) have higher precedence than | (and
||).

But I have to _think_ about it every time I see code like this.

I'd really prefer to see

   if ((a & BIT) || (b & ANOTHER_BIT))

over the "equivalent" and shorter

   if (a & BIT || b & ANOTHER_BIT)

Please make it explicit. It wasn't before either, but it _could_ be.

              Linus
