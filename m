Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF56194BCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 23:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgCZWyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Mar 2020 18:54:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46143 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgCZWy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:54:29 -0400
Received: by mail-lj1-f193.google.com with SMTP id r7so605575ljg.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dketg2xmeCHjMWwyChFsYCLkTQHS2H7rmpcy40U5XQk=;
        b=Mz5JJuHy+EHtTW2ruQf6KS8rf1FyuAKeuMpuRqgexQnmQQXt6lXbg+bouBcIe/NI2b
         R1cEuYVS8YOPkYGJL/h8vPIKKTpgjeVLMEQKoTdrlx6KjEjvXsSQtn4JutgSGcLNu7FE
         HzaHp6I8DeDQygWQA5Xz+Ha5vDztHbTw+RVIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dketg2xmeCHjMWwyChFsYCLkTQHS2H7rmpcy40U5XQk=;
        b=riS13ZuAmNsNsvyHPWjUmHGIxEnhUL6PcTTOaUas+tqXiI7OVr9sdYcYK6uvTD34+x
         zWnIOejkQ9u2f9hdLQ4U2ivg/wB96fYAs0iHUSO7aqC8JpaZMs3uU4GH2A4ENHx0LMml
         bfLXDpk0dG/2Vn9DDGFIBFSv9of9D132oYoSjc6U7hYjg4hBPuKWBkb99YWuXMEP3nhy
         PCxgJ3H4gnCsOLqyQFzx/DPK+z0ejIkaxLrHRNn+2OClb9wYB7NgSVtLdO5KLpZg0rUj
         v1BlWs/9C/7SZz3ArzGea9ymN2kRIx8EbOUhOTpbGEbfv3Rz9SquS48bBnOEaAvkNcr7
         bSNw==
X-Gm-Message-State: AGi0Pubxvqr2Pl6RoDPxW5p+HUpWWG5Im98wGJPrI69Ik9+FHHSzJKYv
        ACdQAh7HoWEOBu8cTClhs8lD8zXmhvk=
X-Google-Smtp-Source: APiQypLN0DbHjGl3NDem7ej+WFCOt+EC9lmewUQ3Pdxq0JiD8EbU44ANTb1gTmuZOj1a5qDOcGBwBA==
X-Received: by 2002:a2e:9053:: with SMTP id n19mr6741655ljg.68.1585263265531;
        Thu, 26 Mar 2020 15:54:25 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id e1sm2080967ljo.16.2020.03.26.15.54.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 15:54:24 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id c20so6341069lfb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2020 15:54:23 -0700 (PDT)
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr3366363lfr.152.1585263263622;
 Thu, 26 Mar 2020 15:54:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
 <20200304131035.731a3947@lwn.net> <alpine.DEB.2.21.2003042145340.2698@felia>
 <e43f0cf0117fbfa8fe8c7e62538fd47a24b4657a.camel@perches.com>
 <alpine.DEB.2.21.2003062214500.5521@felia> <20200307110154.719572e4@onda.lan>
 <0d5503e1d864f2588e756ae590ff8935e11bf9d6.camel@perches.com>
 <4d5291fa3fb4962b1fa55e8fd9ef421ef0c1b1e5.camel@perches.com> <00d11cf766237d9c12c2a06458962c4bae84fa78.camel@perches.com>
In-Reply-To: <00d11cf766237d9c12c2a06458962c4bae84fa78.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Mar 2020 15:54:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg3=D0uFHXFsEz2CAvFGTb8RV1KJH-eOCqR5JUQGvOqeA@mail.gmail.com>
Message-ID: <CAHk-=wg3=D0uFHXFsEz2CAvFGTb8RV1KJH-eOCqR5JUQGvOqeA@mail.gmail.com>
Subject: Re: [PATCH] parse-maintainers: Do not sort section content by default
To:     Joe Perches <joe@perches.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 26, 2020 at 9:47 AM Joe Perches <joe@perches.com> wrote:
>
> Linus? ping?

Applied and pushed out.

            Linus
