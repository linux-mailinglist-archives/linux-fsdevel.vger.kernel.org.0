Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80370161B28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 20:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgBQTCU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 14:02:20 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43516 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgBQTCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 14:02:19 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id A833F292457
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v7 1/8] unicode: Add utf8_casefold_iter
Organization: Collabora
References: <20200208013552.241832-1-drosen@google.com>
        <20200208013552.241832-2-drosen@google.com>
        <20200212033800.GC870@sol.localdomain>
        <CA+PiJmT_8EzyFO283_E62+UC6vtCGOJXKHAFqnH3QM9LA+PHAw@mail.gmail.com>
Date:   Mon, 17 Feb 2020 14:02:10 -0500
In-Reply-To: <CA+PiJmT_8EzyFO283_E62+UC6vtCGOJXKHAFqnH3QM9LA+PHAw@mail.gmail.com>
        (Daniel Rosenberg's message of "Fri, 14 Feb 2020 13:47:37 -0800")
Message-ID: <8536b95971.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Rosenberg <drosen@google.com> writes:

> On Tue, Feb 11, 2020 at 7:38 PM Eric Biggers <ebiggers@kernel.org> wrote:
>>
>> Indirect function calls are expensive these days for various reasons, including
>> Spectre mitigations and CFI.  Are you sure it's okay from a performance
>> perspective to make an indirect call for every byte of the pathname?
>>
>> > +typedef int (*utf8_itr_actor_t)(struct utf8_itr_context *, int byte, int pos);
>>
>> The byte argument probably should be 'u8', to avoid confusion about whether it's
>> a byte or a Unicode codepoint.
>>

just for the record, we use int utf8byte because it can fail
error codes, but that is not the case here.  It should be u8.

>
> Gabriel, what do you think here? I could change it to either exposing
> the things necessary to do the hashing in libfs, or instead of the
> general purpose iterator, just have a hash function inside of unicode
> that will compute the hash given a seed value.

Sorry for the delay, I'm away on a long vacation and intentionally
staying away from my laptop :)

Eric has a very good point, if not prohibitively, it is unnecessarily
expensive for a hot path.  Why not expose utf8ncursor and utf8byte to
libfs and implement the hash in libfs?

-- 
Gabriel Krisman Bertazi
