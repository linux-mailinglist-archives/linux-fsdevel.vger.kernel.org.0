Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2CB6B1052
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 18:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCHRl2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 12:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCHRlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:41:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F82CE945;
        Wed,  8 Mar 2023 09:40:50 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so1647575wmq.1;
        Wed, 08 Mar 2023 09:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678297247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kR3HSJnXJlKBMH2twJ0meIAq1tnGzT/pRVEELqnSXdE=;
        b=j1+QfU1sf7ZdgQn5B8Z9fjU2E0gQyebw7tWPsuT05QIxGJuEoVzoemUXTDQR8EUEdV
         8QQ4gK0sYB2gP9pI9lvm/GhrRK/DZn0VbmlMOxq+uapwUfEUGCSINB+426HdSjZUjBo5
         DEdAJ8iyd+E+YKjzmYLvdtTvWj7RzOrI29uKeSOkGWv45wU0HrH9xxJRpbrBZP+EgrVu
         Q7bPFHRouq2daFW/EyuSzYMYcDNG0K+vF1UVlU8V2EznBNI3QIWk2gBInS10ZG7WZNds
         ke/NFxPcaEw99HYPThkwZ56pip+9sZhUi8ICby0StkIzVGVyy917x9K6ex4dTqDHU9Ze
         JJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678297247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kR3HSJnXJlKBMH2twJ0meIAq1tnGzT/pRVEELqnSXdE=;
        b=4cRVi6lPZmsaGi9OjdoLgN5DyNuT6x0nVJB96o8Mj78aF3juOZJKapbKcCpEnqmK3k
         N9OQH8nQIPbtSJwRcyBVJ4vVBHUfyq8j/1ytptQJ6hWnXsHYxVpl65Vx3yGR5p+N1320
         Y30CPKxMitm+0E/Pjfkzb9RR/eKbeNKuKvbjRpcpZGC6ZZmCU14UdSLTOXXiyXP5uYc8
         UeGAiSGNuGuAEB3O2EUZo0AtMVN+g7y1TdwFwq6UYonvRMRqLr6Px5rBU9jYNvH9o3aH
         dTOiY5xLcrBdR8N+wqg1xxUZ6onq9do7WTm+GFgcRI3lnt65mq3L2JQGdHNA2HTtqLsn
         WU0w==
X-Gm-Message-State: AO0yUKV7STvTAzTgp2xcgoYfKPEvC0hbU8SzlT+TQZdmyMmGdGDbMfOB
        eDQGQr7vE7szpvv1c5g7peAj0WmvgGGrOg==
X-Google-Smtp-Source: AK7set+yyzh9SmAOmND6n6Cal1TF/6QsgwxSsi+MC9WxoGVpY8HnuQ67N3pejnM/KFc5KIVwAMuSoA==
X-Received: by 2002:a05:600c:1c96:b0:3ea:f6c4:5f3d with SMTP id k22-20020a05600c1c9600b003eaf6c45f3dmr16603330wms.2.1678297246781;
        Wed, 08 Mar 2023 09:40:46 -0800 (PST)
Received: from suse.localnet (host-95-252-162-80.retail.telecomitalia.it. [95.252.162.80])
        by smtp.gmail.com with ESMTPSA id s18-20020a05600c45d200b003e8dcc67bdesm86901wmo.30.2023.03.08.09.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:40:46 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Wed, 08 Mar 2023 18:40:44 +0100
Message-ID: <2907412.VdNmn5OnKV@suse>
In-Reply-To: <ZAD6n+mH/P8LDcOw@ZenIV>
References: <Y/gugbqq858QXJBY@ZenIV> <9074146.CDJkKcVGEf@suse> <ZAD6n+mH/P8LDcOw@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On gioved=EC 2 marzo 2023 20:35:59 CET Al Viro wrote:

[...]

> Frankly, ext2 patchset had been more along the lines of "here's what
> untangling the calling conventions in ext2 would probably look like" than
> anything else. If you are willing to test (and review) that sucker and it
> turns out to be OK, I'll be happy to slap your tested-by on those during
> rebase and feed them to Jan...

I git-clone(d) and built your "vfs" tree, branch #work.ext2, without and wi=
th=20
the following commits:

f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as=20
subtraction")

c7248e221fb5 ("ext2_get_page(): saner type")

470e54a09898 ("ext2_put_page(): accept any pointer within the page")

15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with page_addr")

16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need page_add=
r=20
anymore")

Then I read the code and FWIW the five patches look good to me. I think the=
y=20
can work properly.=20

Therefore, if you want to, please feel free to add my "Reviewed-by" tag (OK=
, I=20
know that you don't need my reviews, since you are the one who taught me ho=
w=20
to write patches like yours for sysv and ufs :-)).

As a personal preference, in ext2_get_page() I'd move the two lines of code=
=20
from the "fail" label to the same 'if' block where you have the "goto fail;=
",=20
mainly because that label is only reachable from there. However, it does no=
t=20
matter at all because I'm only expressing my personal preference.

I ran `./check -g quick` without your patches in a QEMU/KVM x86_32 VM, 6GB=
=20
RAM, running a Kernel with HIGHMEM64GB enabled. I ran it three or four time=
s=20
because it kept on hanging at random tests' numbers.

I'm noticing the same pattern due to the oom killer kicking in several time=
s=20
to kill processes until xfstests its is dead.

[ 1171.795551] Out of memory: Killed process 1669 (xdg-desktop-por) total-v=
m:
105068kB, anon-rss:9792kB, file-rss:10972kB, shmem-rss:0kB, UID:1000 pgtabl=
es:
136kB oom_score_adj:200
[ 1172.339920] systemd invoked oom-killer: gfp_mask=3D0xcc0(GFP_KERNEL),=20
order=3D0, oom_score_adj=3D100
[ 1172.339927] CPU: 3 PID: 1413 Comm: systemd Tainted: G S      W   E     =
=20
6.3.0-rc1-x86-32-debug+ #1
[ 1172.339929] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=20
rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[ 1172.339931] Call Trace:
[ 1172.339934]  dump_stack_lvl+0x92/0xd4
[ 1172.339939]  dump_stack+0xd/0x10
[ 1172.339941]  dump_header+0x42/0x454
[ 1172.339945]  ? ___ratelimit+0x6f/0x140
[ 1172.339948]  oom_kill_process+0xe9/0x244
[ 1172.339950]  out_of_memory+0xf6/0x424=20

I have not enough experience to understand why we get to that out-of-memory=
=20
condition, so that several processes get killed. I can send the whole decod=
ed=20
stack trace and other information to whoever can look at this issue to figu=
re=20
out how to fix this big issue. I can try to bisect this issue too, but I ne=
ed=20
time because of other commitments and a slow system for building the necess=
ary=20
kernels.

I want to stress that it does not depend on the above-mentioned patches. Ye=
s,=20
I'm running Al's "vfs" tree, #work.ext2 branch, but with one only patch bey=
ond=20
the merge with Linus' tree:

522dad1 ext2_rename(): set_link and delete_entry may fail=20

I have no means to test this tree. However, I think that I'd have the same=
=20
issue with Linus' tree too, unless this issue is due to the only commit not=
=20
yet there (I strongly doubt about this possibility).

Thanks,

=46abio





