Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD6327012
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 03:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhB1C1F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 21:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhB1C1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 21:27:04 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB28C06174A;
        Sat, 27 Feb 2021 18:26:24 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1614479182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kN0A0m7HWporrbfhmZZ84V29Hb4Vl0xV+WQAKdrYVUo=;
        b=QZ4nfe4iK5cMNQGg+SjA0nXZpjuNYlQ99tGMoYNJc4m9krkkKt4GnHKv3GEp37WYY9h19t
        imGNEAwTUlUZNv2vnnBNu/bpTfv61pO/3RVhMlqTjtv+HOBUFKoSWlk+fKIHy8CwE39KQs
        x7QCH2JyFnlZxry+xTWFpEsHqo+QAayQcDbyvgyprfZxWRCH/Kv1c1IPuN1Qse6yDwbD7D
        rEgYhHP7JB12XOdiXV3R3gLox8ArIs/rxStuXpryOZGQMn/jqoagDEXMD53IPOUDvlb/ap
        lxFU2vLfUw/BDoKlRif8gk3LEkkYCo74EQEdIdYYALhiDPttNRPygrlJYgyWKQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Feb 2021 21:26:21 -0500
Message-Id: <C9KT3SWXRPPA.257SY2N4MVBZD@taiga>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        "Aleksa Sarai" <cyphar@cyphar.com>
Subject: Re: [RFC PATCH] fs: introduce mkdirat2 syscall for atomic mkdir
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Matthew Wilcox" <willy@infradead.org>
References: <20210228002500.11483-1-sir@cmpwn.com>
 <20210228022440.GN2723601@casper.infradead.org>
In-Reply-To: <20210228022440.GN2723601@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat Feb 27, 2021 at 9:24 PM EST, Matthew Wilcox wrote:
> Where's the problem? If mkdir succeeds in a sticky directory, others
> can't remove or rename it. So how can an app be tricked into doing
> something wrong?

It's not a security concern, it's just about about making the software
more robust.

1. Program A creates a directory
2. Program A is pre-empted
3. Program B deletes the directory
4. Program A creates a file in that directory
5. RIP
