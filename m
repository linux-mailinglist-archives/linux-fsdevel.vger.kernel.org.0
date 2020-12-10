Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E4C2D4FA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 01:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgLJAmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 19:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgLJAmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:42:06 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76597C0613D6
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Dec 2020 16:41:26 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y22so4674840ljn.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 16:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yrFHmG50c/nNql7cN9PvwrwjyMGC5Bwc4vaN3xil6d8=;
        b=B1O7JYmsBuTSQSY2dW1rHauJ0h7aheOWuUIpdRFOdc/VF7y94d9X0/Rzh6p0VoW9pH
         UxXWjLXwEHSHMpFeAe+P0rZpkVXZXearYow4CnNblmwWpTnvSs3AKX957YfWvXxNFqAj
         1DP20i8Z4w2vPawIGvRPq/yy0Jhvkb3T7RVKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yrFHmG50c/nNql7cN9PvwrwjyMGC5Bwc4vaN3xil6d8=;
        b=fuXiXfyJTBMATIYriS48YA7TPNYkWMCbepQdcDS+KwVONywbWqos1lcyUplYlxzoP/
         GtgEVQMStvumma+dWvUIjIOkBhQuLoHOYOFztb2+qmsq+L4NlGMDvf5nmftILR/zXjWb
         4CZ+2ilTm+4gPiZgTu4kMeQqLPOBMCGTD13qOq3slxTyb92xwy9bTZfALkJ8vb9l02Qi
         CJNyFS10GAJyfcaB3yvRnUFVRrSG4jyN5fzjEo9c+O75HrODz0F8IuuRUPMjb7dCCAjs
         Ayla443hThWYingIpnD6VfBmkIrlm9WN6BElhIZ5V0Vay/se3eZTANlahOo3UQ/cItDN
         +mtA==
X-Gm-Message-State: AOAM533FNtu5eR4K/MNGQRI16qDMvBay71oZjtSd/Qr5R0dAr1QPLvhD
        Pj4BDLTFS9JQ4KsB5TQ63osaVyAT3XIUtA==
X-Google-Smtp-Source: ABdhPJyHEafh0TH7BPWwG192guTHEhgoFaRJaGzl7cJ5x1T5Kt6VOAYlY7iPY4/pe1yR+vAbxrsPIg==
X-Received: by 2002:a2e:9b4d:: with SMTP id o13mr1949710ljj.163.1607560884670;
        Wed, 09 Dec 2020 16:41:24 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l18sm412059ljj.60.2020.12.09.16.41.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 16:41:23 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id a12so5732492lfl.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Dec 2020 16:41:23 -0800 (PST)
X-Received: by 2002:a19:8557:: with SMTP id h84mr1659716lfd.201.1607560883025;
 Wed, 09 Dec 2020 16:41:23 -0800 (PST)
MIME-Version: 1.0
References: <877dprvs8e.fsf@x220.int.ebiederm.org> <20201209040731.GK3579531@ZenIV.linux.org.uk>
 <877dprtxly.fsf@x220.int.ebiederm.org> <20201209142359.GN3579531@ZenIV.linux.org.uk>
 <87o8j2svnt.fsf_-_@x220.int.ebiederm.org> <20201209194938.GS7338@casper.infradead.org>
 <20201209225828.GR3579531@ZenIV.linux.org.uk> <CAHk-=wi7MDO7hSK9-7pbfuwb0HOkMQF1fXyidxR=sqrFG-ZQJg@mail.gmail.com>
 <20201209230755.GV7338@casper.infradead.org> <CAHk-=wg3FFGZO6hgo-L0gSA4Vjv=B8uwa5N8P6SeJR5KbU5qBA@mail.gmail.com>
 <20201210003922.GL2657@paulmck-ThinkPad-P72>
In-Reply-To: <20201210003922.GL2657@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 9 Dec 2020 16:41:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiE_z0FfWHT7at8si0cZgspt+M5rb1i1s79wRmzBOLqwA@mail.gmail.com>
Message-ID: <CAHk-=wiE_z0FfWHT7at8si0cZgspt+M5rb1i1s79wRmzBOLqwA@mail.gmail.com>
Subject: Re: [PATCH] files: rcu free files_struct
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jann@thejh.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 4:39 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Like this, then?

Ack.

           Linus
