Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4DA613D19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 19:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJaSIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 14:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJaSIP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:08:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F093411833;
        Mon, 31 Oct 2022 11:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XHJb5hgteMMf8oWdHH3UbrzQUbWcwhng1DESNpIa9ME=; b=sCHkX071CI2vNwJvjvz/IoWkcN
        ADZhjlKi3s+qAi+OeDPueaYMKvPl9xxiKGHvwhehsVrvIiopIbVvImNKmnQzelxKhVbzUUAS4WF4s
        0ZNdABnkGR9TSZAu+OY+XBG+5mVEjOHZhJbUSEtlRPmgGNBRcWBxKVEaGEBICVc9wy5ih557UbOia
        /2kr63WLCzZWhoWohGxigHkxpFMNV46/HvYkp9L/6A0oK+n5feu9dqWmKrJ2q2jqujOzOB7vSFpaC
        XYa5o/pkPFoCEWl9Vli0mAqemnP9ZpzmFHQw47lSfx9qBo3cAf8vkdWWE0aMzOoG+hScqiDlbLOil
        RByfCFwA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1opZCk-00GlEc-2D;
        Mon, 31 Oct 2022 18:08:10 +0000
Date:   Mon, 31 Oct 2022 18:08:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2] fs: use acquire ordering in __fget_light()
Message-ID: <Y2APCmYNjYOYLf8G@ZenIV>
References: <20221031175256.2813280-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031175256.2813280-1-jannh@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 31, 2022 at 06:52:56PM +0100, Jann Horn wrote:
> We must prevent the CPU from reordering the files->count read with the
> FD table access like this, on architectures where read-read reordering is
> possible:
> 
>     files_lookup_fd_raw()
>                                   close_fd()
>                                   put_files_struct()
>     atomic_read(&files->count)
> 
> I would like to mark this for stable, but the stable rules explicitly say
> "no theoretical races", and given that the FD table pointer and
> files->count are explicitly stored in the same cacheline, this sort of
> reordering seems quite unlikely in practice...

Looks sane, but looking at the definition of atomic_read_acquire...  ouch.

static __always_inline int
atomic_read_acquire(const atomic_t *v)
{
        instrument_atomic_read(v, sizeof(*v));
	return arch_atomic_read_acquire(v);
}

OK...

; git grep -n -w arch_atomic_read_acquire
include/linux/atomic/atomic-arch-fallback.h:220:#ifndef arch_atomic_read_acquire
include/linux/atomic/atomic-arch-fallback.h:222:arch_atomic_read_acquire(const atomic_t *v)
include/linux/atomic/atomic-arch-fallback.h:235:#define arch_atomic_read_acquire arch_atomic_read_acquire
include/linux/atomic/atomic-instrumented.h:35:  return arch_atomic_read_acquire(v);
include/linux/atomic/atomic-long.h:529: return arch_atomic_read_acquire(v);

No arch-specific instances, so...
static __always_inline int
arch_atomic_read_acquire(const atomic_t *v)
{
	int ret;

	if (__native_word(atomic_t)) {
		ret = smp_load_acquire(&(v)->counter);
	} else {
		ret = arch_atomic_read(v);
		__atomic_acquire_fence();
	}

	return ret;
}

OK, but when would that test not be true?  We have unconditional
typedef struct {
        int counter;
} atomic_t;
and
#define __native_word(t) \
        (sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
         sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))

Do we really have any architectures where a structure with one
int field does *not* have a size that would satisfy that check?

Is it future-proofing for masturbation sake, or am I missing something
real here?
