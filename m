Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57EB7AD9D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjIYOOW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 10:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjIYOOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:14:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5BF121
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 07:14:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3231df054c4so2709318f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 07:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695651252; x=1696256052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iQq/BqSoldA8+HkQXbEK/xXi8jrjFiaKILJ9T9QlK0o=;
        b=GyhC5rKOM3wVwZRkIFTRY38lMRHZmGQtrtQ9F6rVYmiZLcekuyhziVIZm4bU1xx8pA
         ezbBXNOyC5glz9bmjfYlNDeA+JLdane/7f1cq6sPFpVbaqjPme2WJUq3MWrqu4qdY+/R
         9AViyhrUP1eMCzajtO0HVEG+dGA2BcW3P84cSfwEVCMLilDyo3vSSfovGVDP1uNpXvch
         hJSMa7Vd63M7XJELmvZdRKkYAzkqO9Najm5HtLFPHcay/zO9DnegYxoSqEiGyoyRrql0
         MzCdomWslqawLxwm7S49qhhL4ZEwpZsVQuroxOyA0yjAJyNu/njILTQ3pqkOBFGmjggu
         vGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695651252; x=1696256052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQq/BqSoldA8+HkQXbEK/xXi8jrjFiaKILJ9T9QlK0o=;
        b=I1itdFuKq1BoUagF0Rh/xqztorgo0yb4q49nkdMaAB+WUM03xqQB6Rit9JHNXRR0KL
         Un52lX2AIdT7T56TNN7N3TNGTc0XldC12sRD+CWXv0RLNZezauZbfJ7Yo2nvgNiPZe1n
         vpmgyBjMsYi/0GEtKKuw47RLHdtLuAHdnF1NU2QxtotSmgRvpMRR6CS+Aus6K7wBZt3e
         gnzMe+4kBL/x49NIhgkAdmfev8iB5sf4E9vTXe+ZrvmcHZqAZd5335pG6FmkJUcYEldF
         JHU01VFjAQ5X9g9YywrNJcaBNt4KPrl1q8mzdrMRrcQyvjW1zFhbURvu5nStZU51hsDl
         yMXQ==
X-Gm-Message-State: AOJu0YycO98KnkUSgenP4F1rK/BYaa4yDmpAqAeGpKM3sJF4HcaOCgYU
        y9WmjJ9v/kja7BHAKy+cyWz/X0f7qI0aKPkujS9x8g==
X-Google-Smtp-Source: AGHT+IHUVb+vo/W+27VYRqqrkX6MmlMh6Bm5zqYmDI9ffn0TT8EMbIgHkXOfOzbwguwBLO3KCIaZHA==
X-Received: by 2002:adf:f48a:0:b0:31f:f1f4:ca85 with SMTP id l10-20020adff48a000000b0031ff1f4ca85mr6035329wro.37.1695651252387;
        Mon, 25 Sep 2023 07:14:12 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id j13-20020adfd20d000000b003232c2109cbsm2074379wrh.7.2023.09.25.07.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:14:11 -0700 (PDT)
Date:   Mon, 25 Sep 2023 17:14:09 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Chinner <david@fromorbit.com>,
        Guenter Roeck <linux@roeck-us.net>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <f02917bb-db26-46b8-899d-9a3571682583@kadam.mountain>
References: <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
 <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
 <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
 <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZRFVH3iJX8scrFvn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRFVH3iJX8scrFvn@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 02:38:39AM -0700, Christoph Hellwig wrote:
> On Wed, Sep 13, 2023 at 10:03:55AM -0700, Linus Torvalds wrote:
> >  - syzbot issues.
> > 
> > Ignore them for affs & co.
> 
> And still get spammed?  Again, we need some good common way to stop
> them even bothering instead of wasting their and our resources.

A couple people have suggested adding a pr_warn() in mount.  But another
idea is we could add a taint flag.  That's how we used to ignore bugs in
binary out of tree drivers.

regards,
dan carpenter

