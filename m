Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E642B4D83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 18:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbgKPRh4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387492AbgKPRhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:54 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01112C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:53 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id y16so21101494ljh.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0hFcYQjYTxN6TPp3Kdg1NeqlnTpUC7G+cLOAuMz+zHE=;
        b=HKbDpA8RbHc7R9WeYnYhMYC3gxw9weFs3lMu3SDaX0XkAID5B1sf9E42rWBynbT+Sx
         yT3uEIqvHZJzSY1G2ko5rQ9hLa877Siaz6/opPHEMxfi0DtcEJEuWQQNCPcD356BV5kx
         d7ODwPPcAS09cbveKqn/VdCocdxDt/vjlquyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0hFcYQjYTxN6TPp3Kdg1NeqlnTpUC7G+cLOAuMz+zHE=;
        b=HY0AiLhz1AIk1DqN1V0J2INOU2I2VOJfrrB8AObZRIU7MTmutBWTDAqB8Ko3Zmk9M7
         4XR3xZvd5amgM/wlYOkdWVUgJiwi/RBvz2aBofsNFsDASS5xdUM3EVqiAPx2Czb+84zE
         3r2kurYuKn2toUBTFzPLt5z80Tyef/fBDv8wNt10gcq/cQAvv5avdb84Rqe6fYbYbZpc
         bJwYRYTn7Ewza3wX9c+YMqr9iTGzmTwuh9oe6ivV5ke3qc7MHnbJIjpOKlIngiXimo/F
         DuVzfsCg5BrcBIm1e4AJBF+wRVphig88a82rI2uxn6RfZwvAbx7sbBcXU91Z5v9w2RV9
         rY2g==
X-Gm-Message-State: AOAM531BpNNoSlro4+4nxDUDqJMVoiFR3GTEnxZ1UwNZ7Nj448JVxYGu
        Wu7JFYkNvzhpNMpaSHsySrTStiN7wJLGJg==
X-Google-Smtp-Source: ABdhPJx2/49HbM+o9ayPP+oWQKfVESVhvYNKOJBBrdRe4WsxjyA6K79o+HtiEvjlypsW/ljeMx0j/Q==
X-Received: by 2002:a05:651c:1214:: with SMTP id i20mr210984lja.324.1605548271742;
        Mon, 16 Nov 2020 09:37:51 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id n5sm2822691lfl.175.2020.11.16.09.37.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 09:37:49 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id y16so21101289ljh.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:48 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr153620ljo.371.1605548268341;
 Mon, 16 Nov 2020 09:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20201113080132.16591-1-roberto.sassu@huawei.com>
 <20201114111057.GA16415@infradead.org> <0fd0fb3360194d909ba48f13220f9302@huawei.com>
 <20201116162202.GA15010@infradead.org> <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
In-Reply-To: <c556508437ffc10d3873fe25cbbba3484ca574df.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Nov 2020 09:37:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
Message-ID: <CAHk-=wiso=-Fhe2m042CfBNUGhoVB1Pry14DF64uUgztHVOW0g@mail.gmail.com>
Subject: Re: [RESEND][PATCH] ima: Set and clear FMODE_CAN_READ in ima_calc_file_hash()
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Silviu Vlasceanu <Silviu.Vlasceanu@huawei.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 8:47 AM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> This discussion seems to be going down the path of requiring an IMA
> filesystem hook for reading the file, again.  That solution was
> rejected, not by me.  What is new this time?

You can't read a non-read-opened file. Not even IMA can.

So don't do that then.

IMA is doing something wrong. Why would you ever read a file that can't be read?

Fix whatever "open" function instead of trying to work around the fact
that you opened it wrong.

             Linus
