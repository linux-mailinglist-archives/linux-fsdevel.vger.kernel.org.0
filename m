Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0897643BA93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 21:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbhJZTVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbhJZTU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:20:58 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9173C061570
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 12:18:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id l2so590307lji.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 12:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZmINpwcYY7kcvI7sKLaSgNG7WCxmd5BZ4iNpf7lS1s=;
        b=OsqaCKMuKFeRuWXmhZzecH1PFurN3y1S2AB1+cEKAaxcheLMIwVa1+mU9xaI+48tSD
         hDW/GsZ40FpWHVKK/6DfQVSTBtioB3fbYc70ILsRQJsX9ufj7I2BdNObVy9O6WfiMW1v
         DiUsn9LYY/9cPMqSPRQHNfkJU6lnB2qdNQ6Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZmINpwcYY7kcvI7sKLaSgNG7WCxmd5BZ4iNpf7lS1s=;
        b=VaJxvHZrCj9CCvW9dqUKqYqWZ6vawG8ZyBHHvW5gUXzUTgN1se7D6J7F0woXYKdDZp
         lOFaZiTk+IrYqwgaPOt3SWB98wKDQZ2bDPauPJiTKu+/OCt2G2eVb6OZBhbHYFK5Kq3S
         iZQw1czdjWPIiwn5LMRz6uDk1+/GxeRkCKGaAYx6rIMdKIJGDerph2KBHQgcvNQf68J4
         9Zfu73pZYZnJm4rwTH9Mu1B4Vyof7hEdOYHqr2iPEnrH9bAoSMeGlMmo6H+H8tt1AwGx
         Hk2BCzgyFGIgm9eDPM142FIu5VTrScwuJ6NesGAQizzSoH7yCthfPGMe1R5EvwoHDq8s
         SNfA==
X-Gm-Message-State: AOAM532ca23/x/h18zEPEcwfEsorg3I2l9kE5bosv6qgighzYy8slwyi
        w3Sq7fekQalsgEvJDkIjYAZFF/QPMyWK5nhi
X-Google-Smtp-Source: ABdhPJzDY//4YIrVU7Mh9FVgaccP1yjMBD/qh32dcCBvmb765qjRL7ksnzwfnkBs0F9OYNttvOydNg==
X-Received: by 2002:a05:651c:1541:: with SMTP id y1mr28248123ljp.392.1635275911553;
        Tue, 26 Oct 2021 12:18:31 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id t18sm2010433lfl.289.2021.10.26.12.18.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Oct 2021 12:18:30 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id d13so697627ljg.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Oct 2021 12:18:30 -0700 (PDT)
X-Received: by 2002:a2e:bc24:: with SMTP id b36mr28005819ljf.95.1635275910507;
 Tue, 26 Oct 2021 12:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211019134204.3382645-1-agruenba@redhat.com> <CAHk-=wh0_3y5s7-G74U0Pcjm7Y_yHB608NYrQSvgogVNBxsWSQ@mail.gmail.com>
 <YXBFqD9WVuU8awIv@arm.com> <CAHk-=wgv=KPZBJGnx_O5-7hhST8CL9BN4wJwtVuycjhv_1MmvQ@mail.gmail.com>
 <YXCbv5gdfEEtAYo8@arm.com> <CAHk-=wgP058PNY8eoWW=5uRMox-PuesDMrLsrCWPS+xXhzbQxQ@mail.gmail.com>
 <YXL9tRher7QVmq6N@arm.com> <CAHk-=wg4t2t1AaBDyMfOVhCCOiLLjCB5TFVgZcV4Pr8X2qptJw@mail.gmail.com>
 <CAHc6FU7BEfBJCpm8wC3P+8GTBcXxzDWcp6wAcgzQtuaJLHrqZA@mail.gmail.com>
 <YXhH0sBSyTyz5Eh2@arm.com> <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
In-Reply-To: <CAHk-=wjWDsB-dDj+x4yr8h8f_VSkyB7MbgGqBzDRMNz125sZxw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 26 Oct 2021 12:18:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm9XwkeqWRy4+OvmdmDojghNSYbu81PxYMoPDJKS_j3A@mail.gmail.com>
Message-ID: <CAHk-=wjm9XwkeqWRy4+OvmdmDojghNSYbu81PxYMoPDJKS_j3A@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] gfs2: Fix mmap + page fault deadlocks
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 26, 2021 at 11:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Because for _most_ cases of "copy_to/from_user()" and friends by far,
> the only thing we look for is "zero for success".

Gaah. Looking around, I almost immediately found some really odd
exceptions to this.

Like parse_write_buffer_into_params() in amdgpu_dm_debugfs.c, which does

        r = copy_from_user(wr_buf_ptr, buf, wr_buf_size);

                /* r is bytes not be copied */
        if (r >= wr_buf_size) {
                DRM_DEBUG_DRIVER("user data not be read\n");
                return -EINVAL;
        }

and allows a partial copy to justy silently succeed, because all the
callers have pre-cleared the wr_buf_ptr buffer.

I have no idea why the code does that - it seems to imply that user
space could give an invalid 'size' parameter and mean to write only
the part that didn't succeed.

Adding AMD GPU driver people just to point out that this code not only
has odd whitespace, but that the pattern for "couldn't copy from user
space" should basically always be

        if (copy_from_user(wr_buf_ptr, buf, wr_buf_size))
                return -EFAULT;

because if user-space passes in a partially invalid buffer, you
generally really shouldn't say "ok, I got part of it and will use that
part"

There _are_ exceptions. We've had situations where user-space only
passes in the pointer to the buffer, but not the size. Bad interface,
but it historically happens for the 'mount()' system call 'data'
pointer. So then we'll copy "up to a page size".

Anyway, there are clearly some crazy users, and converting them all to
also check for negative error returns might be more painful than I
thought it would be.

                 Linus
