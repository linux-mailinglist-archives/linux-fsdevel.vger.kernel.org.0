Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADAD49D487
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 22:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiAZVaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 16:30:22 -0500
Received: from mx1.mailbun.net ([170.39.20.100]:42886 "EHLO mx1.mailbun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbiAZVaV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:30:21 -0500
Received: from [2607:fb90:d98b:8818:5079:94eb:24d5:e5c3] (unknown [172.58.109.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id 18CD311A3AC;
        Wed, 26 Jan 2022 21:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643232621;
        bh=cEHBNSv/MipZhCDFhhwu1YqdHHuZS1W4Vo1WymB6Av8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=KtAoMBrKa5duZbZSiJE4d/Wk79MrJ7rb+wsR7yuJEDt3Q2haZcY9ObdQeWp6Y3EOv
         7FtheXJOKmX/CgGlNC2zu0ZZyqX4yxBgi+JoOlg1VbHICjwo/pqPXsVa5mH/o+FNV4
         2H4JNhoJqqQZSrqZK+X9QkYmB1JeGY6lAoSzXvTN8KbWcVjI8IFKefhNJTHP7xnH35
         p//53uAKaDyLIxzoZkvSicMqjnnYfZbZ0rIf9RwOpp7J+ugMzr14uCjAcCmliYMH20
         eF1To6FeGTFgoW92SfAX20aaUVbDcK+IGsw+6FDyWjSXbFzaBY4f+dih1pECbgwJto
         sd/mLBtzQo99A==
Date:   Wed, 26 Jan 2022 15:30:13 -0600 (CST)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
In-Reply-To: <202201261323.9499FA51@keescook>
Message-ID: <64e91dc2-7f5c-6e8-308e-414c82a8ae6b@dereferenced.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org> <202201261202.EC027EB@keescook> <a8fef39-27bf-b25f-7cfe-21782a8d3132@dereferenced.org> <202201261239.CB5D7C991A@keescook> <5e963fab-88d4-2039-1cf4-6661e9bd16b@dereferenced.org>
 <202201261323.9499FA51@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, 26 Jan 2022, Kees Cook wrote:

> On Wed, Jan 26, 2022 at 03:13:10PM -0600, Ariadne Conill wrote:
>> Looks good to me, but I wonder if we shouldn't set an argv of
>> {bprm->filename, NULL} instead of {"", NULL}.  Discussion in IRC led to the
>> realization that multicall programs will try to use argv[0] and might crash
>> in this scenario.  If we're going to fake an argv, I guess we should try to
>> do it right.
>
> They're crashing currently, though, yes? I think the goal is to move
> toward making execve(..., NULL, NULL) just not work at all. Using the
> {"", NULL} injection just gets us closer to protecting a bad userspace
> program. I think things _should_ crash if they try to start depending
> on this work-around.

Is there a reason to spawn a program, just to have it crash, rather than 
just denying it to begin with, though?

I mean, it all seems fine enough, and perhaps I'm just a bit picky on the 
colors and flavors of my bikesheds, so if you want to go with this patch, 
I'll be glad to carry it in the Alpine security update I am doing to make 
sure the *other* GLib-using SUID programs people find don't get exploited 
in the same way.

Ariadne
