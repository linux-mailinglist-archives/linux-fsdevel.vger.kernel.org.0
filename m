Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F909711777
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 21:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbjEYTfA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 15:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbjEYTe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 15:34:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41DED8;
        Thu, 25 May 2023 12:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BFA16492C;
        Thu, 25 May 2023 19:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33F6C433D2;
        Thu, 25 May 2023 19:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685043179;
        bh=6UobrKBXIGhe2eUQTgBJPED9+bJgDbD/miYgiY64fQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PcQK9c9EREG4YKZhM4pdUTAf6OggbyNsdHXCf/2K1OpwOUwcqpW4ZVTBOLYcHbTQF
         NX6SWvPe5znnFXJBbQAQ811rD8ETp8tL8p3UPTQXp2hxmwTpMqYOLY+clwKia6xleX
         VFQsrL5Dvb7eAh9GUNw649P/3o/rI+p4wNPR0PnxXai3GSiwtVEarne4mXgNBdFEYl
         TfJSClRSYf1VeXjdHiB5chZvYyCh2wjqRHRcSGJIM+SWjTgsAMgiepbc0VtWkbT1mv
         DKxdeTKbzaIl5lpU+fSC7qeRVHwLAbdKMQhXH/YLXO/qVYnv9PJoAgVK9BEPkDOLZ0
         4lJKDAJjaiXHg==
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f623adec61so43355e9.0;
        Thu, 25 May 2023 12:32:59 -0700 (PDT)
X-Gm-Message-State: AC+VfDyc6SJaJakUHRg7Gc0IuNj3G6RVfBVjkLPNcqmYyKajL/ttV0yV
        dd1+SIgoTCZzIEC55Ta5X464CPO2/SRgVsTTBfI=
X-Google-Smtp-Source: ACHHUZ4aeMTw09mMjfqXPUFnCiuZAbomSUSRRfwvCVtW6z9ZsKNKLNK2xI+Aluo+xANppdWVouLl7+1DSFFxC7prqxM=
X-Received: by 2002:a05:600c:21cf:b0:3f6:3bd:77dc with SMTP id
 x15-20020a05600c21cf00b003f603bd77dcmr3032498wmj.23.1685043178000; Thu, 25
 May 2023 12:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230524213620.3509138-1-mcgrof@kernel.org> <20230524213620.3509138-2-mcgrof@kernel.org>
 <CAHk-=wjahcAqLYm0ijcAVcPcQAz-UUuJ3Ubx4GzP_SJAupf=qQ@mail.gmail.com>
 <CAHk-=wgKu=tJf1bm_dtme4Hde4zTB=_7EdgR8avsDRK4_jD+uA@mail.gmail.com>
 <ZG+kDevFH6uE1I/j@bombadil.infradead.org> <CAHk-=wgWCDw58fZDLGYVqVC2ee-Zec25unewdHFp8syCZFumvg@mail.gmail.com>
In-Reply-To: <CAHk-=wgWCDw58fZDLGYVqVC2ee-Zec25unewdHFp8syCZFumvg@mail.gmail.com>
From:   Luis Chamberlain <mcgrof@kernel.org>
Date:   Thu, 25 May 2023 12:32:45 -0700
X-Gmail-Original-Message-ID: <CAB=NE6XjXtGmXH-wt_38rKpPPxNoBDOgdNVTsrkD7cOecNG4dg@mail.gmail.com>
Message-ID: <CAB=NE6XjXtGmXH-wt_38rKpPPxNoBDOgdNVTsrkD7cOecNG4dg@mail.gmail.com>
Subject: Re: [PATCH 1/2] fs/kernel_read_file: add support for duplicate detection
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>, hch@lst.de,
        brauner@kernel.org, david@redhat.com, tglx@linutronix.de,
        patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com, lennart@poettering.net,
        gregkh@linuxfoundation.org, rafael@kernel.org, song@kernel.org,
        lucas.de.marchi@gmail.com, lucas.demarchi@intel.com,
        christophe.leroy@csgroup.eu, peterz@infradead.org, rppt@kernel.org,
        dave@stgolabs.net, willy@infradead.org, vbabka@suse.cz,
        mhocko@suse.com, dave.hansen@linux.intel.com,
        colin.i.king@gmail.com, jim.cromie@gmail.com,
        catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 25, 2023 at 11:50=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So it would probably improve on those numbers a bit more, but you'd
> still have the fundamental race where *serial* duplicates end up
> always wasting CPU effort and temporary vmalloc space.

The known failed boots are with KASAN with a large number of CPUs, so
the value in
the mitigation would be to help those boot until userspace fixes it
and we have enough
time for propagation. But since it is not a full proof solution, it
may seem like an odd thing
to have in place later and this being lost as odd tribal knowledge.
I'd be in favor of only
applying the mitigation if we really are chasing userspace to fix
this, and we'd be OK
in later removing it after userspace gets this fixed / propagated.

If we're going to have userspace fix this, who is volunteering?

  Luis
