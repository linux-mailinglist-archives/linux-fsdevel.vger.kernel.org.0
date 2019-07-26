Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7642F76154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 10:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfGZIwn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 04:52:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34196 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfGZIwn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:52:43 -0400
Received: by mail-io1-f68.google.com with SMTP id k8so103300230iot.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2019 01:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ivu7mmuUCBtRCJ9+296IctrbfYNXAVCIQ5a8QkkFxDo=;
        b=BcbB9dYEb6fL2ssaGCJwDjSepgxhHuOJBsItX3hrLsfKUFk5WZgW0heTRA+zC+/9ki
         epLl9ANmgYHGtkc3Uqix9qGThZR50Myd2iSEOnydNe8nrEbh5evDIlUXXLW6hWf+6EwY
         X0n577EY+VzxpMbP8Wy6TqPvogcrYcyOEn6Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ivu7mmuUCBtRCJ9+296IctrbfYNXAVCIQ5a8QkkFxDo=;
        b=e11NWnmwienffHyxAAo72u06IPE5uzGZW1oD+C+cg8iADTutFwxcM6NSQyBLG6HfIg
         7r8DeBxIRqRnknHSyd3Ut46U//X4LBlETi+bYsmiBjXBxXIwijMmDHQfC1ZJdKkkVYhG
         lqbOiatYfiwa+aPfH+Rf+cEbITJBSI9LA05+wJ4z1WzY5v+WlSIu6fFF31/D3l5d6o0d
         6U0lelA/tTDh8y7JLujaycPOOK3IlqnwlwFANTkhU/WiUgJQYopDPk0pU2ICDyTZch0B
         bIerfoURjic21w9NnnlmL75Mm6PuW9JGkbno8eU9dctZfVQYid+TJQnKXLGGOFBtQuhq
         HCig==
X-Gm-Message-State: APjAAAWYJSih8NVVPTG4zkr3paDagRu2wrmfVgMO0OHTkNFumRB2/WXQ
        NNGZgRlZyaLJJ7NTBcLe8ISxWKu0bVX9JGmgbaq/GA==
X-Google-Smtp-Source: APXvYqwi441df8XodqoYa2JUoE1MGP2LwR3hrCQfE9nZyRGKSRipZoxCCSSAFMCVBaT7g2c2hNnccWtVKrkKS61oXVQ=
X-Received: by 2002:a02:ce52:: with SMTP id y18mr92451652jar.78.1564131162681;
 Fri, 26 Jul 2019 01:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <ae19f8ddc770135572323dd431d0efbe3e419582.camel@linux.ibm.com>
In-Reply-To: <ae19f8ddc770135572323dd431d0efbe3e419582.camel@linux.ibm.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 26 Jul 2019 10:52:31 +0200
Message-ID: <CAJfpegsLKY=M6PSBZjgpKkZTxUYBn+H44BxG2HVLsAVzTzyy_Q@mail.gmail.com>
Subject: Re: Question about vmsplice + SPLICE_F_GIFT
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 23, 2019 at 10:33 PM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> Hello everybody,
>
> I am not sure if this is the right place to be asking this. If is not,
> I apologize for the inconvenience. Also, please tell me where is a
> better way to as these questions.
>
> I am trying to create a basic C code to test vmsplice + SPLICE_F_GIFT
> for moving memory pages between two processes without copying.
>
> I have followed the man pages and several recipes across the web, but I
> could not reproduce it yet.
>
> Basically, I am doing:
> Sending process:
> - malloc + memcpy for generating pages to transfer
> - vmsplice with SPLICE_F_GIFT sending over named pipe (in a loop)
> Receiving process:
> - Create mmaped file to receive the pages
> - splice with SPLICE_F_MOVE receiving from named pipe (in a loop)

As the splice(2) man page says SPLICE_F_MOVE is currently a no-op.

> I have seen the SPLICE_F_MOVE being used on steal ops from the
> 'pipebuffer', but I couldn't find a way to call it from splice.
>
> Questions:
> It does what I think it does? (reassign memory pages from a process to
> another)

> If so, does page gifting still works?
> If so, is there a basic recipe to test it's workings?

What is the end goal?

It is easy to transfer pages using shared memory (see shm_open(3) and
related API), so why mess with splice?

Thanks,
Miklos
