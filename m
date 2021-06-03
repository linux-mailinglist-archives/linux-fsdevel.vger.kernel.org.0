Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9713996BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhFCAI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 20:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhFCAI4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 20:08:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CFCC061760;
        Wed,  2 Jun 2021 17:07:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B6E1F1F42D72
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, chao@kernel.org, ebiggers@google.com,
        drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v8 4/4] fs: unicode: Add utf8 module and a unicode layer
Organization: Collabora
References: <20210423205136.1015456-1-shreeya.patel@collabora.com>
        <20210423205136.1015456-5-shreeya.patel@collabora.com>
        <20210427062907.GA1564326@infradead.org>
        <61d85255-d23e-7016-7fb5-7ab0a6b4b39f@collabora.com>
        <YIgkvjdrJPjeoJH7@mit.edu> <87bl9z937q.fsf@collabora.com>
        <YIlta1Saw7dEBpfs@mit.edu> <87mtti6xtf.fsf@collabora.com>
        <7caab939-2800-0cc2-7b65-345af3fce73d@collabora.com>
        <YJoJp1FnHxyQc9/2@infradead.org>
        <687283ac-77b9-9e9e-dac2-faaf928eb383@collabora.com>
Date:   Wed, 02 Jun 2021 20:07:07 -0400
In-Reply-To: <687283ac-77b9-9e9e-dac2-faaf928eb383@collabora.com> (Shreeya
        Patel's message of "Fri, 21 May 2021 01:49:53 +0530")
Message-ID: <87zgw7izf8.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

> On 11/05/21 10:05 am, Christoph Hellwig wrote:
>> On Tue, May 11, 2021 at 02:17:00AM +0530, Shreeya Patel wrote:
>>> Theodore / Christoph, since we haven't come up with any final decision with
>>> this discussion, how do you think we should proceed on this?
>> I think loading it as a firmware-like table is much preferable to
>> a module with all the static call magic papering over that it really is
>> just one specific table.
>
>
> Christoph, I get you point here but request_firmware API requires a
> device pointer and I don't
> see anywhere it being NULL so I am not sure if we are going in the right
> way by loading the data as firmware like table.

I wasn't going to really oppose it from being a firmware but this
detail, if required, makes the whole firmware idea more awkward.  If the
whole reason to make it a firmware is to avoid the module boilerplate,
this is just different boilerplate.  Once again, I don't know about
precedent of kernel data as a module, and there is the problem with
Makefile rules to install this stuff, that I mentioned.

We know we can get rid of the static call stuff already, since we likely
won't support more encodings anyway, so that would simplify a lot the
module specific code.

-- 
Gabriel Krisman Bertazi
