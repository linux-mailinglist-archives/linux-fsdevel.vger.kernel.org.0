Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84275327289
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 14:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhB1N6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 08:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhB1N6O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 08:58:14 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D99C061756;
        Sun, 28 Feb 2021 05:57:23 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1614520642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yXyAG8cREtN/DVvSryK4/3FwgiB74zHsdpXKDbhSfSM=;
        b=tWpRm/lfotg0xU7Fo6pAkA55cSbrBui+UsgbGWPhY31kGrhUt92NVLSjXm/ThyHTpcKOTR
        pIfELA+x+s33cNIBJs6CoF6PaHUuL8wlpxkQHDlmx3OSbcHWawiMid+XnSZABzJq4e+/Et
        gjC0T3qjCQOxp70QOLCJTghe06cAn1j37UL1B8nSJ5+AlOJwQskKyRcYOKeNWguK5jtpEw
        LwMLA4+qR7qWQ7oX1OhQiD/QLJFINzPAzwkXgTrsWtfOmDSvYhcwUlUZ7zZK+hlldC0T7Z
        wWTBAGPwwWzLTkND8Q6O/cN5/YJPKACtsUCiCkY0ZaqHT8HSWZnQmDMU3TYpKg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 28 Feb 2021 08:57:20 -0500
Message-Id: <C9L7SV0Z2GZR.K2C3O186WDJ7@taiga>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        "Aleksa Sarai" <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Matthew Wilcox" <willy@infradead.org>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <20210228022440.GN2723601@casper.infradead.org>
 <C9KT3SWXRPPA.257SY2N4MVBZD@taiga>
 <20210228040345.GO2723601@casper.infradead.org>
In-Reply-To: <20210228040345.GO2723601@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat Feb 27, 2021 at 11:03 PM EST, Matthew Wilcox wrote:
> > 1. Program A creates a directory
> > 2. Program A is pre-empted
> > 3. Program B deletes the directory
> > 4. Program A creates a file in that directory
> > 5. RIP
>
> umm ... program B deletes the directory. program A opens it in order to
> use openat(). program A gets ENOENT and exits, confused. that's the
> race you're removing here -- and it seems fairly insignificant to me.

Yes, that is the race being eliminated here. Instead of this, program A
has an fd which holds a reference to the directory, so it just works. A
race is a race. It's an oversight in the API.
