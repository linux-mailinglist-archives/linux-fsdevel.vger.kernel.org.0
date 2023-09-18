Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55DB7A4C63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 17:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjIRPcj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 11:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjIRPcH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:32:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8395186;
        Mon, 18 Sep 2023 08:30:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE1A7C3278B;
        Mon, 18 Sep 2023 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695048054;
        bh=ZeWZ+8dS+EZG0y8HJDVlPWd6URqnrUZDMlX7eqHI0iU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nzz584ohm3yWGjyuwth376D1n4jxucAvA/eqA5OK9R5JJse0f+NCeZ2dQ4xzk0kby
         kdIZ2soMrCjPX7QY5qTSkTctD5TxyyviKL6rNCbKutMSTBFpxCoMRGfTdVs7P0ooiL
         OPmrB7xdrhLvnKSWKAwAs8+CxFoL/DmMlXTUcfgonosXJ+unXYImxcXUkNAf9WEltm
         OzhBf2AfUdIfWp4jdd1ppn+vGSegsWSD+Pq8FoU82zMwqU84ggXTn1ipXAaN34gDkp
         PVPVHS/mqCQR9CDl8c+v2yexwYlxg71zG2aSibegy+EovI0IL+VLDl0mskBOYMGykg
         dJjK1fr7tcCxg==
Date:   Mon, 18 Sep 2023 16:40:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230918-stuhl-spannend-9904d4addc93@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner>
 <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
 <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:32:30PM +0200, Miklos Szeredi wrote:
> On Mon, 18 Sept 2023 at 16:25, Christian Brauner <brauner@kernel.org> wrote:
> 
> > The system call should please have a proper struct like you had in your
> > first proposal. This is what I'm concerned about:
> >
> > int statmount(u64 mnt_id,
> >               struct statmnt __user *st,
> >               size_t size,
> >               unsigned int flags)
> >
> > instead of taking an void pointer.
> 
> So you are not concerned about having ascii strings returned by the
> syscall?   I thought that was the main complaint.

I'm not following. The original proposals were only returning strings
even for basic binary data such as mount flags, propagation options, and
so on and we're using the xattr interface for any type of information.

What we're talking about here is a nicely typed struct which returns two
paths @mnt_root and @mnt_point which can both be represented as u64
pointers with length parameters like we do in other binary structs such
as bpf and clone3 and a few others. That is a compromise I can live
with. I'm really trying to find as much common ground here as we can.
